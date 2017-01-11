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
    public partial class Rastrear : System.Web.UI.Page
    {
        public Dictionary<System.Int32, System.String> dictLingua = new Dictionary<System.Int32, System.String>();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!User.Identity.IsAuthenticated)
                Response.Redirect("~/Account/Login.aspx");

            initialize();
            InitializeFormView();

            Session["tab"] = "RibbonTabCongresso";

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

        void InitializeFormView()
        {
            string cid = string.Empty;
            string idl = string.Empty;

            cid = Request.QueryString["cid"];
            idl = Request.QueryString["idl"];
            if (cid != null)
            {
                FormView1.ChangeMode(FormViewMode.Edit);

                //Seleccionar o registo correcto
                if (!IsPostBack)
                {
                    SqlDataSourceClassificador.SelectParameters["ClassificadorID"].DefaultValue = cid;
                    SqlDataSourceClassificador.SelectParameters["Lingua"].DefaultValue = idl;
                    
                    FormView1.DataBind();
                    ((DropDownList)FormView1.FindControl("TipoComboBox")).SelectedValue = ((System.Data.DataRowView)(FormView1.DataItem)).Row["Tipo"].ToString();
                    ((DropDownList)FormView1.FindControl("LinguaComboBox")).SelectedValue = ((System.Data.DataRowView)(FormView1.DataItem)).Row["Lingua"].ToString();
                    ((DropDownList)FormView1.FindControl("NivelInteresseIDComboBox")).SelectedValue = ((System.Data.DataRowView)(FormView1.DataItem)).Row["NivelInteresseID"].ToString();
                    ((DropDownList)FormView1.FindControl("EstadoCombobox")).SelectedValue = ((System.Data.DataRowView)(FormView1.DataItem)).Row["Estado"].ToString();

                    //Se Exitir Media, mostro "ver" e "Apagar"
                    if (((System.Data.DataRowView)(FormView1.DataItem)).Row["Media"].ToString() != string.Empty)
                    {

                        ((Button)FormView1.FindControl("btnApagarMedia")).Visible = true;
                        ((Button)FormView1.FindControl("btnVerMedia")).Visible = true;
                        ((FileUpload)FormView1.FindControl("MediaUpload")).Visible = false;
                        imgVerMedia.ImageUrl="~/uploads/" + ((System.Data.DataRowView)(FormView1.DataItem)).Row["Media"].ToString();
                    }
                    else
                    {
                        ((Button)FormView1.FindControl("btnApagarMedia")).Visible = false;
                        ((Button)FormView1.FindControl("btnVerMedia")).Visible = false;
                        ((FileUpload)FormView1.FindControl("MediaUpload")).Visible = true;
                    }

                    
                    
                    
                    //SetDisableFields(Boolean.Parse(((System.Data.DataRowView)(FormView1.DataItem)).Row["Aberto"].ToString()));
                }
                else
                {

                }
                //Mudar a descrição da label
                lblBread.Text = " Editar ";
            }
            else
            {
                //Mudar a descrição da label
                lblBread.Text = " Criar ";
                FormView1.ChangeMode(FormViewMode.Insert);
            }
        }

        protected string BuildLingua(object LinguaId)
        {
            return dictLingua[int.Parse(LinguaId.ToString())].ToString();
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


            //Campo Editor
            e.Command.Parameters["@Descricao"].Value = ((Winthusiasm.HtmlEditor.HtmlEditor)FormView1.FindControl("DescricaoTextBox")).Text;

            
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
            e.Command.Parameters["@ClassificadorID"].Value = getNextClassificadorID();

            //Campo Editor
            e.Command.Parameters["@Descricao"].Value = ((Winthusiasm.HtmlEditor.HtmlEditor)FormView1.FindControl("DescricaoTextBox")).Text;

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
                 using (SqlCommand cmd = new SqlCommand("SELECT coalesce(MAX(ClassificadorID),0,MAX(ClassificadorID)) + 1 FROM cmsck_classificador", con))
                 {
                     cmd.CommandType = CommandType.Text;

                     con.Open();
                     cid= (int)cmd.ExecuteScalar();
                     con.Close();
                 }
             }
             return cid;
        }
        
        protected void btnteste_Click(object sender, EventArgs e)
        {
            string aa = ((Winthusiasm.HtmlEditor.HtmlEditor)FormView1.FindControl("Editor")).Text;
        }

        protected void OBAdicionar_Click(object sender, EventArgs e)
        {
            this.Validate("Form");
        }
    }
}