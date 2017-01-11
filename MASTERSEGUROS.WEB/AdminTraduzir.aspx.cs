using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Winthusiasm.HtmlEditor;


namespace MASTERSEGUROS.WEB
{
    public partial class AdminTraduzir : System.Web.UI.Page
    {
      
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!User.Identity.IsAuthenticated)
                Response.Redirect("~/Account/Login.aspx");

           
            InitializeFormView();

            Session["tab"] = "RibbonClassificador";

        }

        protected void gvEmployee_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            //if (e.Row.RowType == DataControlRowType.DataRow)
            //{
            //   if (e.Row.RowState == DataControlRowState.Edit || e.Row.RowState == (System.Web.UI.WebControls.DataControlRowState.Alternate | System.Web.UI.WebControls.DataControlRowState.Edit))
            //    {
            //        LinkButton lb = (LinkButton)e.Row.Cells[4].Controls[0];
            //        if (lb != null)
            //        {
            //            lb.Attributes.Add("onclick", "javascript:return " + "ConfirmActualizarDiasExtra('" + this.Page.ClientScript.GetPostBackEventReference(new PostBackOptions(lb)).Replace("'", "|") + "')");
            //        }
            //    }
            //}
        }

        //protected string BuildNomeAuditor(object AuditorId)
        //{
        //    //return dictAuditor[int.Parse(AuditorId.ToString())].ToString();
        //}

        //protected string BuildNomeProjecto(object ProjectoId)
        //{
        //    return dictProjecto[int.Parse(ProjectoId.ToString())].ToString();
        //}

        protected Boolean BuildBoolean(object bVal)
        {
            if(bVal==null) 
                return false;

            if (bVal.Equals(System.Boolean.Parse("true")))
                return true;
            else
                return false;
        }
        
        protected void On_Inserted(Object sender, SqlDataSourceStatusEventArgs e)
        {

            if (e.Exception == null)
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(),
               "ShowMessageCreate", string.Format("<script type='text/javascript'>MessageBoxClassificadorCriado('');</script>", ""));
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
               "ShowMessageUpdate", string.Format("<script type='text/javascript'>MessageBoxClassificadorActualizado('');</script>", ""));
            }
            else
            {
                
                Page.ClientScript.RegisterStartupScript(this.GetType(),
               "ShowMessageErro", string.Format("<script type='text/javascript'>MessageBoxErroGravar('');</script>", ""));
             }
        }

        void InitializeFormView()
        {
            string cid = string.Empty;
            string idl = string.Empty;

            cid = Request.QueryString["cid"];
            idl = Request.QueryString["idl"];
            

            lblBread.Text = " Traduzir ";
            FormView1.ChangeMode(FormViewMode.Insert);
            
            //Set values from database
            FillControlsClassifierByIDLingua(int.Parse(cid), int.Parse(idl));
           
            foreach (var oItem in ((DropDownList)FormView1.FindControl("LinguaComboBox")).Items)
            {
                if (((System.Web.UI.WebControls.ListItem)(oItem)).Value != idl)
                {
                    ((DropDownList)FormView1.FindControl("LinguaComboBox")).SelectedValue = ((System.Web.UI.WebControls.ListItem)(oItem)).Value;
                    break;
                }
            }

        }

        private void FillControlsClassifierByIDLingua(int classificadorID, int Lingua)
        {
            SqlDataReader rdr = null;

            using (SqlConnection con = new SqlConnection(MASTERSEGUROS.WEB.Comum.General.getConnection()))
            {
                con.Open();
                 //Actualizar o estado da marcação
                SqlCommand sqlCommand = new SqlCommand("spGetClassificador", con);
             
                sqlCommand.CommandType = System.Data.CommandType.StoredProcedure;

                SqlParameter paramClassificadorID = sqlCommand.Parameters.Add("@ClassificadorID", SqlDbType.Int);
                SqlParameter paramLingua = sqlCommand.Parameters.Add("@Lingua", SqlDbType.Int);

                paramClassificadorID.Value = classificadorID;
                paramLingua.Value = Lingua;
                
                rdr = sqlCommand.ExecuteReader();
                while (rdr.Read())
                {
                    ((TextBox)FormView1.FindControl("ClassificadorPaiIDTextBox")).Text = (String)rdr["ClassificadorPaiID"].ToString();
                    ((Label)FormView1.FindControl("NomeLabel")).Text = (String)rdr["Nome"].ToString();
                    ((DropDownList)FormView1.FindControl("TipoComboBox")).SelectedValue = (String)rdr["Tipo"].ToString();
                    ((DropDownList)FormView1.FindControl("NivelInteresseIDComboBox")).SelectedValue = (String)rdr["NivelInteresseID"].ToString();
                    ((DropDownList)FormView1.FindControl("EstadoCombobox")).SelectedValue = (String)(String)rdr["Estado"].ToString();
                }


                con.Close();
            }
            
        }
       
        protected void On_Updating(object sender, SqlDataSourceCommandEventArgs e)
        {
            string sExtension = string.Empty;
            string sFileName = string.Empty;

            if (((System.Web.UI.WebControls.FileUpload)FormView1.FindControl("MediaUpload")).HasFile)
            {
                sExtension = ((System.Web.UI.WebControls.FileUpload)FormView1.FindControl("MediaUpload")).FileName.Substring(((System.Web.UI.WebControls.FileUpload)FormView1.FindControl("MediaUpload")).FileName.Length - 4);
                sFileName = System.Guid.NewGuid().ToString() + sExtension;
                SaveFile(sFileName);
                e.Command.Parameters["@Media"].Value = sFileName;
            }
            else
                e.Command.Parameters["@Media"].Value = string.Empty;

            
        }

        protected void SqlDataSourceClassificador_Inserting(object sender, SqlDataSourceCommandEventArgs e)
        {
            string sExtension = string.Empty;
            string sFileName = string.Empty;

            if (((System.Web.UI.WebControls.FileUpload)FormView1.FindControl("MediaUpload")).HasFile)
            {
                sExtension = ((System.Web.UI.WebControls.FileUpload)FormView1.FindControl("MediaUpload")).FileName.Substring(((System.Web.UI.WebControls.FileUpload)FormView1.FindControl("MediaUpload")).FileName.Length - 4);
                sFileName = System.Guid.NewGuid().ToString() + sExtension;
                SaveFile(sFileName);
                e.Command.Parameters["@Media"].Value = sFileName;
            }
            else
            {
                e.Command.Parameters["@Media"].Value = string.Empty;
            }

            //ClassificadorID (Max(classificadorID) +1 
            e.Command.Parameters["@ClassificadorID"].Value = int.Parse(Request.QueryString["cid"]);
            e.Command.Parameters["@Nome"].Value = ((TextBox)FormView1.FindControl("NomeTextBox")).Text;

   
        }

        public bool SaveFile(string filename)
        {
            try
            {
                string savePath = Server.MapPath("\\uploads\\");
                ((System.Web.UI.WebControls.FileUpload)FormView1.FindControl("MediaUpload")).SaveAs(savePath + filename);
            }
            catch
            {
                return false;
            }

            return true;
        }

        protected void btnApagarMedia_Click(object sender, EventArgs e)
        {
            ((Button)FormView1.FindControl("btnApagarMedia")).Visible = false;
            ((Button)FormView1.FindControl("btnVerMedia")).Visible = false;
            ((FileUpload)FormView1.FindControl("MediaUpload")).Visible = true;
            

            
        }


        private int getNextClassificadorID()
        {
            int cid = 0;           

             using (SqlConnection con = new SqlConnection(MASTERSEGUROS.WEB.Comum.General.getConnection()))
             {
                 //Fill all Periods/Years
                 using (SqlCommand cmd = new SqlCommand("SELECT Max(ClassificadorID) + 1 FROM cmsck_classificador", con))
                 {
                     cmd.CommandType = CommandType.Text;

                     con.Open();
                     cid= (int)cmd.ExecuteScalar();
                     con.Close();
                 }
             }
             return cid;
        }
        
    }
}