using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;




namespace MASTERSEGUROS.WEB
{
    public partial class AdminParametrosUserRoles : System.Web.UI.Page
    {
        private string[] usersInRole;
        private string[] rolesArray;
        private MembershipUserCollection users;

        protected void Page_Load(object sender, EventArgs e)
        {
            Msg.Text = "";

            if (!IsPostBack)
            {
                // trazendo os grupos para a listbox grupo

                rolesArray = Roles.GetAllRoles();
                RolesListBox.DataSource = rolesArray;
                RolesListBox.DataBind();

                // trazendo os usuario para a listbox usuario

                users = Membership.GetAllUsers();
                UsersListBox.DataSource = users;
                UsersListBox.DataBind();
            }

            if (RolesListBox.SelectedItem != null)
            {
                
                // trazendo os usuarios que pertecem a grupos na gridview

                usersInRole = Roles.GetUsersInRole(RolesListBox.SelectedItem.Value);
                UsersInRoleGrid.DataSource = usersInRole;
                UsersInRoleGrid.DataBind();
            }
        }

        protected void AddUsersButton_Click(object sender, EventArgs args)
        {
           
            // verificando se o grupo foi selecionado

            if (RolesListBox.SelectedItem == null)
            {
                Msg.Text = "Selecione um grupo.";
                return;
            }

            // verificando se o usuario foi selecionado

            if (UsersListBox.SelectedItem == null)
            {
                Msg.Text = "Selecione um,ou mais usuário.";
                return;
            }


            // Criando a lista de Usuário para adiciona-los aos Grupos

            string[] newusers = new string[UsersListBox.GetSelectedIndices().Length];

            for (int i = 0; i < newusers.Length; i++)
            {
                newusers[i] = UsersListBox.Items[UsersListBox.GetSelectedIndices()[i]].Value;
            }

            try
            {
                // Adicnando usuários aos grupos selecionados.

                Roles.AddUsersToRole(newusers, RolesListBox.SelectedItem.Value);

               
                // Mostrando de volta os usuários que estão em grupos no GridView.

                usersInRole = Roles.GetUsersInRole(RolesListBox.SelectedItem.Value);
                UsersInRoleGrid.DataSource = usersInRole;
                UsersInRoleGrid.DataBind();
            }
            catch (Exception e)
            {
                Msg.Text = e.Message;
            }
        }

        protected void UsersInRoleGrid_RowCommand(object sender, GridViewCommandEventArgs args)
        {
            int index = Convert.ToInt32(args.CommandArgument);

            string username = ((DataBoundLiteralControl)UsersInRoleGrid.Rows[index].Cells[0].Controls[0]).Text;

            try
            {
                // Remoendo usuários aos grupos selecionados.

                Roles.RemoveUserFromRole(username, RolesListBox.SelectedItem.Value);
            }

            catch (Exception e)
            {
                Msg.Text = "Ocorreu um erro " + e.GetType().ToString() +
                " ao remover...";
            }

           
            // Mostrando de volta os usuários que estão em grupos no GridView.
            usersInRole = Roles.GetUsersInRole(RolesListBox.SelectedItem.Value);
            UsersInRoleGrid.DataSource = usersInRole;
            UsersInRoleGrid.DataBind();
        }

        protected void RegisterUser_CreatedUser(object sender, EventArgs e)
        {
            //FormsAuthentication.SetAuthCookie(RegisterUser.UserName, false /* createPersistentCookie */);

            string continueUrl = RegisterUser.ContinueDestinationPageUrl;
            if (String.IsNullOrEmpty(continueUrl))
            {
                continueUrl = "~/AdminParametrosUserRoles.aspx";
            }
            Response.Redirect(continueUrl);
        }
    }
}



   