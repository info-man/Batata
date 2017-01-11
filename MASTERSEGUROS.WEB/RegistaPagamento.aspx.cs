using MASTERSEGUROS.WEB.Comum;
using SelectPdf;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using Winthusiasm.HtmlEditor;


namespace MASTERSEGUROS.WEB
{
    public partial class RegistaPagamento : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!User.Identity.IsAuthenticated)
               Response.Redirect("~/Account/Login.aspx");
     
            InitializeFormView();

        }

        protected void SqlDataSourceAvisoCobrancaPagamento_Inserted(Object sender, SqlDataSourceStatusEventArgs e)
        {
            string script = string.Empty;
            string script2 = string.Empty;
            int rowsAffected = 0;

            //Actualizar a Tabela "master_ApoliceAvisoCobranca"
            using (SqlConnection con = new SqlConnection(Comum.General.getConnection()))
            {
                using (SqlCommand cmd = new SqlCommand("spActualizaEstadoAvisoCobrancaAuto", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    con.Open();
                    SqlParameter paramApoliceAvisoCobrancaID = cmd.Parameters.Add("@ApoliceAvisoCobrancaID", SqlDbType.Int);
                    SqlParameter paramEstado = cmd.Parameters.Add("@Estado", SqlDbType.Int);
                    paramApoliceAvisoCobrancaID.Value = Request.QueryString["avcID"];
                    paramEstado.Value = "2";
                    rowsAffected = cmd.ExecuteNonQuery();
                    con.Close();
                }
                //Actualizar a Tabela "master_apolice"
                using (SqlCommand cmd = new SqlCommand("spActualizaEstadoApolice", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    con.Open();
                    SqlParameter paramApoliceID = cmd.Parameters.Add("@ApoliceID", SqlDbType.Int);
                    SqlParameter paramEstadoAPL = cmd.Parameters.Add("@Estado", SqlDbType.Int);
                    paramApoliceID.Value = Request.QueryString["aplid"];
                    paramEstadoAPL.Value = "2";
                    rowsAffected = cmd.ExecuteNonQuery();
                    con.Close();
                }
            }

            if (e.Exception == null && rowsAffected > 0)
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(),
              "ShowMessageErro", string.Format("<script type='text/javascript'>MessageBoxSucessoGravar('" + Request.QueryString["aplid"] + "','" + Request.QueryString["avcID"] +  "');</script>", ""));
            }
            else
            {
                //ClientMessageBox.Show("ATENÇÃOB: Ocorreu a gravar os dados.\nContacte o administrador de sistemas.\n" + e.Exception.ToString(), this);
                Page.ClientScript.RegisterStartupScript(this.GetType(),
                "ShowMessageErro", string.Format("<script type='text/javascript'>MessageBoxErroGravar('');</script>", ""));

            }
        }

        private void InitializeFormView()
        {
            string avcPagID = string.Empty;
            avcPagID = Request.QueryString["avcPagID"];

            if (avcPagID != null)
            {
                FormView1.ChangeMode(FormViewMode.Edit);

                //Seleccionar o registo correcto
                if (!IsPostBack)
                {
                    //SqlDataSourcePropostaAuto.SelectParameters["PropostaID"].DefaultValue = prpID;

                    FormView1.DataBind();
                    //((DropDownList)FormView1.FindControl("ProvinciaIDComboBox")).SelectedValue = ((System.Data.DataRowView)(FormView1.DataItem)).Row["ProvinciaID"].ToString();
                    //((DropDownList)FormView1.FindControl("MunicipioIDComboBox")).SelectedValue = ((System.Data.DataRowView)(FormView1.DataItem)).Row["MunicipioID"].ToString();
                    //((DropDownList)FormView1.FindControl("ComunaIDComboBox")).SelectedValue = ((System.Data.DataRowView)(FormView1.DataItem)).Row["ComunaID"].ToString();

                    //((DropDownList)FormView1.FindControl("ProvinciaNascIDComboBox")).SelectedValue = ((System.Data.DataRowView)(FormView1.DataItem)).Row["ProvinciaNascID"].ToString();
                    //((DropDownList)FormView1.FindControl("MunicipioNascIDComboBox")).SelectedValue = ((System.Data.DataRowView)(FormView1.DataItem)).Row["MunicipioNascID"].ToString();
                    //((DropDownList)FormView1.FindControl("ComunaNascIDComboBox")).SelectedValue = ((System.Data.DataRowView)(FormView1.DataItem)).Row["ComunaNascID"].ToString();


                    //    ((DropDownList)FormView1.FindControl("EstadoCombobox")).SelectedValue = ((System.Data.DataRowView)(FormView1.DataItem)).Row["Estado"].ToString();

                    //    //Se Exitir Media, mostro "ver" e "Apagar"
                    //    if (((System.Data.DataRowView)(FormView1.DataItem)).Row["Foto"].ToString() != string.Empty)
                    //    {

                    //        ((Button)FormView1.FindControl("btnApagarMedia")).Visible = true;
                    //        ((Button)FormView1.FindControl("btnVerMedia")).Visible = true;
                    //        ((FileUpload)FormView1.FindControl("MediaUpload")).Visible = false;
                    //        imgVerMedia.ImageUrl="~/uploads/" + ((System.Data.DataRowView)(FormView1.DataItem)).Row["Media"].ToString();
                    //    }
                    //    else
                    //    {
                    //        ((Button)FormView1.FindControl("btnApagarMedia")).Visible = false;
                    //        ((Button)FormView1.FindControl("btnVerMedia")).Visible = false;
                    //        ((FileUpload)FormView1.FindControl("MediaUpload")).Visible = true;
                    //    }
                    //        //SetDisableFields(Boolean.Parse(((System.Data.DataRowView)(FormView1.DataItem)).Row["Aberto"].ToString()));
                }
                //else
                //{

                //}
                //Mudar a descrição da label
                //lblBread.Text = " Editar ";
            }
            else
            {
                //Mudar a descrição da label
                //lblBread.Text = " Criar ";
                FormView1.ChangeMode(FormViewMode.Insert);
            }
        }
       
        protected void SqlDataSourceAvisoCobrancaPagamento_Updating(object sender, SqlDataSourceCommandEventArgs e)
        {
            //string sExtension = string.Empty;
            //string sFileName = string.Empty;

            //if (((System.Web.UI.WebControls.FileUpload)FormView1.FindControl("MediaUpload")).HasFile)
            //{
            //    sExtension = ((System.Web.UI.WebControls.FileUpload)FormView1.FindControl("MediaUpload")).FileName.Substring(((System.Web.UI.WebControls.FileUpload)FormView1.FindControl("MediaUpload")).FileName.Length - 4);
            //    sFileName = System.Guid.NewGuid().ToString() + sExtension;
            //    SaveFile(sFileName);
            //    e.Command.Parameters["@Media"].Value = sFileName;
            //}
            //else
            //    e.Command.Parameters["@Media"].Value = string.Empty;


            ////Campo Editor
            //e.Command.Parameters["@Descricao"].Value = ((Winthusiasm.HtmlEditor.HtmlEditor)FormView1.FindControl("DescricaoTextBox")).Text;


        }

        protected void SqlDataSourceAvisoCobrancaPagamento_Inserting(object sender, SqlDataSourceCommandEventArgs e)
        {
            e.Command.Parameters["@UserIDCriacao"].Value = Membership.GetUser().ProviderUserKey.ToString();
            e.Command.Parameters["@DataCriacao"].Value = DateTime.Now;

            e.Command.Parameters["@ApoliceID"].Value = Request.QueryString["aplID"];
            e.Command.Parameters["@ApoliceAvisoCobrancaID"].Value = Request.QueryString["avcID"];
        }
    }
}