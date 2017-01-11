using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MASTERSEGUROS.WEB.Account
{
    public partial class LoginExt : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //RegisterHyperLink.NavigateUrl = "Register.aspx?ReturnUrl=" + HttpUtility.UrlEncode(Request.QueryString["ReturnUrl"]);
            string pwd = string.Empty;
            string usr = string.Empty;

            if (IsPostBack)
            {
                usr = Request.Form["url"];
                pwd = Request.Form["pwd"];

                if (Membership.ValidateUser(usr, pwd))
                {
                    Session["tab"] = "RibbonSimbolos";
                    // Log the user into the site
                    FormsAuthentication.RedirectFromLoginPage(usr, true);
                }
                else
                {
                    url_user.Src = "../images/usericon_red.png";
                    url_password.Src = "../images/passicon_red.png";
                }
            }
            
        }

        protected void Entrar_Click(object sender, EventArgs e)
        {
           
            Response.Redirect("Account/Login.aspx");
        }
    }
}
