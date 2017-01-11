using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security; 
using System.Configuration;
using OfficeWebUI;


namespace MASTERSEGUROS.WEB
{
    
    public partial class SiteMaster : System.Web.UI.MasterPage
    {
        string[] rolesArray;
        //public string UserLogged = General.FormatUsernameToName(Membership.GetUser().UserName);

        protected void Page_Load(object sender, EventArgs e)
        {

            setRibbon();
            setLoggedUser();
            setStatusBar();

            //if (!IsPostBack)
            //{
                rolesArray = Roles.GetRolesForUser();
            //}
        }
      
        private void setRibbon()
        {
            //if (Session["tab"]!= null)
                //OfficeRibbon1.SelectTabID = Session["tab"].ToString();
        }

        public void setLoggedUser()
        {

            if (System.Web.HttpContext.Current.User.Identity.IsAuthenticated)
                ((Label)this.FindControl("lblUserText")).Text = "&nbsp;&nbsp;&nbsp;Bem-vindo " + MASTERSEGUROS.WEB.Comum.General.FormatUsernameToName(Membership.GetUser().UserName) + " | Online desde " + Membership.GetUser().LastLoginDate.ToString();
            
        }

        public void setStatusBar()
        {
            //Se não for administrator só pode pesqusiar os as suas férias e dos seu colaboradores
            //if (!Roles.IsUserInRole(MASTERSEGUROS.WEB.Comum.General.getRoleAdminName()))
            //{
                //Administração - Férias
                //ItemNovoUtilizador.Enabled = false;
                //LogEntregaveis.Enabled = false;
                //LargeItemDiasAdicionais.Enabled = false;
                //LargeItemDiasFeiras.Enabled = false;
               
                
                ////Administração
                //LargeItemEntidade.Enabled = false;
                //LargeItemHierarquia.Enabled = false;
                
            //}
        }
        
        protected void Sair_Click(object sender, EventArgs e)
        {
            FormsAuthentication.SignOut();
            Response.Redirect("Account/Login.aspx");
        }

        protected void OfficeRibbon1_Unload(object sender, EventArgs e)
        {
            //setLoggedUser();
        }

        protected void Manager1_Init(object sender, EventArgs e)
        {
            setLoggedUser();
        }

        protected void Ajuda_Click(object sender, EventArgs e)
        {
            Response.Redirect("about.aspx");
        }

        protected void SignOut_ServerClick(object sender, EventArgs e)
        {
            FormsAuthentication.SignOut();
            Response.Redirect(getBaseURL() + "/Account/Login.aspx");
            //Response.Redirect("/plesk-site-preview/masterseguros.co.ao/94.46.176.100/Account/Login.aspx");
        }

        public string getStatusMenu(string sNameMenu)
        {

            foreach (string s in rolesArray)
            {
                if (ConfigurationManager.AppSettings[sNameMenu].ToString().ToLower().IndexOf(s.ToLower()) > -1)
                    return "";
            }
            return "pointer-events:none;opacity:0.6;display:none";
        }

        public string getBaseURL()
        {
            return Comum.General.getBASE_URL();
        }
    }
}
