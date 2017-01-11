using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MASTERSEGUROS.WEB
{
    public partial class PesquisaBanner : System.Web.UI.Page
    {
        public Dictionary<System.Int32, System.String> dictLingua = new Dictionary<System.Int32, System.String>();
        public Dictionary<System.Int32, System.String> dictProjecto = new Dictionary<System.Int32, System.String>();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!User.Identity.IsAuthenticated)
                Response.Redirect("~/Account/Login.aspx");

                //if (!IsPostBack)
                initialize();

                //GridViewBanners.DataBind();

                Session["tab"] = "RibbonConteudos";

        }

        protected string BuildLingua(object LinguaId)
        {
            return dictLingua[int.Parse(LinguaId.ToString())].ToString();
        }

        private void initialize()
        {
            SqlDataReader rdr = null;

            using (SqlConnection con = new SqlConnection(MASTERSEGUROS.WEB.Comum.General.getConnection()))
            {
                //Fill all Periods/Years
                using (SqlCommand cmd = new SqlCommand("SELECT * FROM [cmsck_lingua]", con))
                {
                    cmd.CommandType = CommandType.Text;

                    con.Open();
                    rdr = cmd.ExecuteReader();

                    while (rdr.Read())
                    {
                        dictLingua.Add((Int32)rdr["LinguaId"], (String)rdr["Abreviatura"]);
                    }

                    rdr.Close();
                    con.Close();
                }
            }
        }

        protected void On_Inserted(Object sender, SqlDataSourceStatusEventArgs e)
        {

            if (e.Exception == null)
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(),
               "ShowMessageCreate", string.Format("<script type='text/javascript'>MessageBoxEntregavelCriado('');</script>", ""));
            }
            else
            {
                //ClientMessageBox.Show("ATENÇÃO: Ocorreu a gravar os dados.\nContacte o administrador de sistemas.\n" + e.Exception.ToString(), this);
                Page.ClientScript.RegisterStartupScript(this.GetType(),
                "ShowMessageErro", string.Format("<script type='text/javascript'>MessageBoxErroGravar('');</script>", ""));

            }
        }

        protected void On_Updated(Object sender, SqlDataSourceStatusEventArgs e)
        {

            if (e.Exception == null)
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(),
               "ShowMessageUpdate", string.Format("<script type='text/javascript'>MessageBoxEntregavelActualizado('');</script>", ""));
            }
            else
            {
                
                Page.ClientScript.RegisterStartupScript(this.GetType(),
               "ShowMessageErro", string.Format("<script type='text/javascript'>MessageBoxErroGravar('');</script>", ""));
             }
        }

        protected void btnPesquisar_Click(object sender, EventArgs e)
        {
            try
            {
                GridViewBanners.DataBind();
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message, ex);
            }

        }

        protected void btnLimpar_Click(object sender, EventArgs e)
        {
            this.ClassificadorIDTextBox.Text = string.Empty;
            this.BannerIDTextBox.Text = string.Empty;
            this.TituloTextBox.Text = string.Empty;
            this.SubtituloTextBox.Text = string.Empty;
            this.URLTextBox.Text = string.Empty;
            this.DataEntradaTextBox.Text = string.Empty;
            this.DataSaidaTextBox.Text = string.Empty;
            this.LinguaComboBox.SelectedIndex= -1;
            this.EstadoComboBox.SelectedIndex = -1;
        }

        protected string BuildEstado(object Estado)
        {
            if (Estado.ToString()=="1")
                return "~/images/certo.gif";
            else
                return "~/images/xis.gif";
        }

        protected string BuildToolTipEstado(object Estado,object nome)
        {
            if (Estado.ToString()=="1")
                return "O Banner '" + nome + "' está válido e visível no site.\nClique para colocar no estado inválido";
            else
                return "O Banner '" + nome + "' está inválido e invisível no site.\nClique para colocar no estado válido";
        }
        
        protected void Operation_SelectedIndexChanged(object sender, EventArgs e)
        {
           
            if (((System.Web.UI.WebControls.ListControl)(sender)).SelectedValue == "1")
            {
                Response.Redirect("AdminBanner.aspx?bid=" + (((System.Web.UI.WebControls.ListControl)(sender))).Attributes["IDBanner"] + "&idl=" + (((System.Web.UI.WebControls.ListControl)(sender))).Attributes["IDLingua"]);
               
            }
            
            if (((System.Web.UI.WebControls.ListControl)(sender)).SelectedValue == "2")
            {
                DeleteBanner((((System.Web.UI.WebControls.ListControl)(sender))).Attributes["IDBanner"], (((System.Web.UI.WebControls.ListControl)(sender))).Attributes["IDLingua"]);
                
            }

            if (((System.Web.UI.WebControls.ListControl)(sender)).SelectedValue == "3")
            {
                Response.Redirect("AdminBannerTraduzir.aspx?bid=" + (((System.Web.UI.WebControls.ListControl)(sender))).Attributes["IDBanner"] + "&idl=" + (((System.Web.UI.WebControls.ListControl)(sender))).Attributes["IDLingua"]);
            }

            if (((System.Web.UI.WebControls.ListControl)(sender)).SelectedValue == "4")
            {
                Response.Redirect("AdminClassificar.aspx?cid=" + (((System.Web.UI.WebControls.ListControl)(sender))).Attributes["IDBanner"] + "&idl=" + (((System.Web.UI.WebControls.ListControl)(sender))).Attributes["IDLingua"] + "&ctype=" + (int)Comum.ContentType.Banner);
            }

            if (((System.Web.UI.WebControls.ListControl)(sender)).SelectedValue == "5")
            {
                //Response.Redirect("AdminBannerSeccoes.aspx?aid=" + (((System.Web.UI.WebControls.ListControl)(sender))).Attributes["IDBanner"] + "&idl=" + (((System.Web.UI.WebControls.ListControl)(sender))).Attributes["IDLingua"] + "&ctype=4");
            }
            GridViewBanners.DataBind();
        }

        public void DeleteBanner(string BannerID, string Lingua)
        {
            using (SqlConnection con = new SqlConnection(Comum.General.getConnection()))
            {
                con.Open();
                SqlTransaction transaction = con.BeginTransaction();

                //Apagar as férias antes de criar
                SqlCommand sqlCommand = new SqlCommand("spDeleteBanner", con);
                sqlCommand.Transaction = transaction;
                sqlCommand.CommandType = System.Data.CommandType.StoredProcedure;

                SqlParameter paramBannerID = sqlCommand.Parameters.Add("@BannerID", SqlDbType.Int);
                SqlParameter paramLingua = sqlCommand.Parameters.Add("@Lingua", SqlDbType.Int);
                
                paramBannerID.Value = Int32.Parse(BannerID);
                paramLingua.Value = Int32.Parse(Lingua);
                
                sqlCommand.ExecuteNonQuery();
                transaction.Commit();
            }
        }

        public void UpdateEstado(string BannerID, string Lingua, string NewState)
        {
            using (SqlConnection con = new SqlConnection(Comum.General.getConnection()))
            {
                con.Open();
                SqlTransaction transaction = con.BeginTransaction();

                //Apagar as férias antes de criar
                SqlCommand sqlCommand = new SqlCommand("spUpdateEstadoBanner", con);
                sqlCommand.Transaction = transaction;
                sqlCommand.CommandType = System.Data.CommandType.StoredProcedure;

                SqlParameter paramBannerID = sqlCommand.Parameters.Add("@BannerID", SqlDbType.Int);
                SqlParameter paramLingua = sqlCommand.Parameters.Add("@Lingua", SqlDbType.Int);
                SqlParameter paramEstadoID = sqlCommand.Parameters.Add("@Estado", SqlDbType.Int);

                paramBannerID.Value = Int32.Parse(BannerID);
                paramLingua.Value = Int32.Parse(Lingua);
                paramEstadoID.Value = Int32.Parse(NewState);


                sqlCommand.ExecuteNonQuery();
                transaction.Commit();
            }
        }

        protected void imgEstado_Click(object sender, ImageClickEventArgs e)
        {
            string estado;
            estado = (((System.Web.UI.WebControls.ImageButton)(sender))).Attributes["Estado"];
            if (estado == "0")
                estado = "1";
            else
                estado = "0";
            UpdateEstado((((System.Web.UI.WebControls.ImageButton)(sender))).Attributes["IDBanner"], (((System.Web.UI.WebControls.ImageButton)(sender))).Attributes["IDLingua"],estado);

            GridViewBanners.DataBind();
        }

    }
}