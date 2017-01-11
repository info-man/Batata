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
    public partial class Utilizadores : System.Web.UI.Page
    {
        public Dictionary<System.Int32, System.String> dictAuditor = new Dictionary<System.Int32, System.String>();
       

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!User.Identity.IsAuthenticated)
                Response.Redirect("~/Account/Login.aspx");


            

            Session["tab"] = "RibbonAdministracao";

        }

        protected string BuildEstado(object Estado)
        {
            //Este estado está ao contrário dos restantes conteúdos
            if (Estado.ToString() == "False")
                return "~/images/certo.gif";
            else
                return "~/images/xis.gif";
        }

        protected string BuildToolTipEstado(object Estado, object nome)
        {
            if (Estado.ToString() == "1")
                return "O utilizador '" + nome + "' está válido.\nClique para colocar no estado inválido";
            else
                return "O utilizador '" + nome + "' está inválido.\nClique para colocar no estado válido";
        }

        protected void imgEstado_Click(object sender, ImageClickEventArgs e)
        {
            string estado;
            estado = (((System.Web.UI.WebControls.ImageButton)(sender))).Attributes["Estado"];
            if (estado == Boolean.FalseString)
                estado = Boolean.TrueString;
            else
                estado = Boolean.FalseString;
            //UpdateEstado((((System.Web.UI.WebControls.ImageButton)(sender))).Attributes["userID"], (((System.Web.UI.WebControls.ImageButton)(sender))).Attributes["IDLingua"], estado);

            SqlDataSourceUtilizadores.UpdateParameters["UserId"].DefaultValue = (((System.Web.UI.WebControls.ImageButton)(sender))).Attributes["userID"].ToString();
            SqlDataSourceUtilizadores.UpdateParameters["IsLockedOut"].DefaultValue = estado;
            SqlDataSourceUtilizadores.Update();

            GridViewUtilizadores.DataBind();
        }

        protected void GridViewUtilizadores_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            //Apenas os administradores vêm
            //if (User.IsInRole("Administrador"))
            //e.Row.Cells[3].Enabled = false;
            //GridViewUtilizadores.Columns[GridViewUtilizadores.Columns.Count - 2].Visible = false;
            if (!User.IsInRole("Administrador"))
            {
                if (e.Row.RowState == DataControlRowState.Alternate || e.Row.RowState == System.Web.UI.WebControls.DataControlRowState.Normal)
                {
                    if (e.Row.RowType == DataControlRowType.DataRow)
                    {
                        ImageButton ib = (ImageButton)e.Row.Cells[4].Controls[1];
                        if (ib != null)
                        {
                            ib.Enabled = false;
                        }
                    }
                }
            }
        }
    }
}