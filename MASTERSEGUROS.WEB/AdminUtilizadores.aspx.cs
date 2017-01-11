using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MASTERSEGUROS.WEB
{
    public partial class AdminUtilizadores : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!User.Identity.IsAuthenticated)
                Response.Redirect("~/Account/Login.aspx");

            Session["tab"] = "RibbonAdministracao";
        }

        protected void RegisterUser_CreatedUser(object sender, EventArgs e)
        {
            System.Web.UI.WebControls.CheckBox chkAdmin = new CheckBox();

            chkAdmin = ((System.Web.UI.WebControls.CheckBox)RegisterUser.CreateUserStep.Controls[0].FindControl("chkAdmin"));

             if (chkAdmin.Checked)
                Roles.AddUserToRole((sender as CreateUserWizard).UserName, "Administrador");

        }

       
    }
}