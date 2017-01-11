using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

namespace MASTERSEGUROS.WEB
{
    public partial class AdminCliente : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!User.Identity.IsAuthenticated)
                Response.Redirect("~/Account/Login.aspx");
                InitializeFormView();
        }

        protected void Page_LoadComplete(object sender, EventArgs e)
        {
            

            if (((TextBox)FormView1.FindControl("DataNascimentoTextBox")) != null)
                if (((TextBox)FormView1.FindControl("DataNascimentoTextBox")).Text.Length == 10)
                {
                    ((TextBox)FormView1.FindControl("DataNascimentoTextBox")).Text = ((TextBox)FormView1.FindControl("DataNascimentoTextBox")).Text.Substring(0, 2) + "/" + ((TextBox)FormView1.FindControl("DataNascimentoTextBox")).Text.Substring(3, 2) + "/" + ((TextBox)FormView1.FindControl("DataNascimentoTextBox")).Text.Substring(6, 4);
                }

           
        }

        protected void On_Updated(Object sender, SqlDataSourceStatusEventArgs e)
        {

            if (e.Exception == null)
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(),
               "ShowMessageUpdate", string.Format("<script type='text/javascript'>MessageBoxSucessoGravar('');</script>", ""));
            }
            else
            {

                Page.ClientScript.RegisterStartupScript(this.GetType(),
               "ShowMessageErro", string.Format("<script type='text/javascript'>MessageBoxErroGravar('');</script>", ""));
            }
        }

        void InitializeFormView()
        {
            string Cl = string.Empty;
            Cl = Request.QueryString["Cl"];
            if (Cl != null)
            {
                FormView1.ChangeMode(FormViewMode.Edit);

                if (!IsPostBack)
                {
                    SqlDataSourceCliente.SelectParameters["ClienteID"].DefaultValue = Cl;
                    FormView1.DataBind();

                    ((DropDownList)FormView1.FindControl("ProvinciaIDComboBox")).SelectedValue = ((System.Data.DataRowView)(FormView1.DataItem)).Row["ProvinciaId"].ToString();
                    ((DropDownList)FormView1.FindControl("MunicipioIDComboBox")).SelectedValue = ((System.Data.DataRowView)(FormView1.DataItem)).Row["MunicipioId"].ToString();
                    ((DropDownList)FormView1.FindControl("ComunaIDComboBox")).SelectedValue = ((System.Data.DataRowView)(FormView1.DataItem)).Row["ComunaId"].ToString();
                    ((DropDownList)FormView1.FindControl("ProfissaoComboBox")).SelectedValue = ((System.Data.DataRowView)(FormView1.DataItem)).Row["ProfissaoID"].ToString();
                    ((DropDownList)FormView1.FindControl("TomadorDropDownList")).SelectedValue = ((System.Data.DataRowView)(FormView1.DataItem)).Row["Tomador"].ToString();
                    if (((TextBox)FormView1.FindControl("DataNascimentoTextBox")).Text.Length == 10)
                    {
                        //((TextBox)FormView1.FindControl("h_DataInicioTextBox")).Text = ((TextBox)FormView1.FindControl("DataInicioTextBox")).Text;
                        ((TextBox)FormView1.FindControl("DataNascimentoTextBox")).Text = ((System.Data.DataRowView)(FormView1.DataItem)).Row["DataNascimento"].ToString().Substring(3, 2) + "/" + ((System.Data.DataRowView)(FormView1.DataItem)).Row["DataNascimento"].ToString().Substring(0, 2) + "/" + ((System.Data.DataRowView)(FormView1.DataItem)).Row["DataNascimento"].ToString().Substring(6, 4);
                    }
                    
                }
            }

            else
            {
                
                FormView1.ChangeMode(FormViewMode.Insert);
            }
        }

        protected void On_Inserted(object sender, SqlDataSourceStatusEventArgs e)
        {
            if (e.Exception == null)
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(),
               "ShowMessageUpdate", string.Format("<script type='text/javascript'>MessageBoxSucessoGravar('');</script>", ""));
            }
            else
            {

                Page.ClientScript.RegisterStartupScript(this.GetType(),
               "ShowMessageErro", string.Format("<script type='text/javascript'>MessageBoxErroGravar('');</script>", ""));
            }
        }
    }
}