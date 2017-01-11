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
    public partial class AdminAlteraPalavraPasse : System.Web.UI.Page
    {
        public Dictionary<System.Int32, System.Int32> dictPeriodoAno = new Dictionary<System.Int32, System.Int32>();
        public Dictionary<Guid, String> dictUser = new Dictionary<Guid, String>();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!User.Identity.IsAuthenticated)
                Response.Redirect("~/Account/Login.aspx");

            //if (!IsPostBack)
                initialize();

                Session["tab"] = "RibbonAdministracao";
        }

        protected void gvEmployee_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                LinkButton lkIni = (LinkButton)e.Row.FindControl("lnkgettextIni");
                TextBox textBoxIni = (TextBox)e.Row.FindControl("DataTextBoxGridIni");

                LinkButton lkFim = (LinkButton)e.Row.FindControl("lnkgettextFim");
                TextBox textBoxFim = (TextBox)e.Row.FindControl("DataTextBoxGridFim");

                if (lkIni != null)
                    lkIni.Attributes.Add("onclick", "cal.select(" + textBoxIni.ClientID + ",'A_DataTextBoxIni','dd/MM/yyyy'); return false;");
                 
                if (lkFim != null)
                    lkFim.Attributes.Add("onclick", "cal.select(" + textBoxFim.ClientID + ",'A_DataTextBoxFim','dd/MM/yyyy'); return false;");

                if (e.Row.RowState == DataControlRowState.Edit || e.Row.RowState == (System.Web.UI.WebControls.DataControlRowState.Alternate | System.Web.UI.WebControls.DataControlRowState.Edit))
                {
                    LinkButton lb = (LinkButton)e.Row.Cells[4].Controls[0];
                    if (lb != null)
                    {
                        lb.Attributes.Add("onclick", "javascript:return " + "confirm('Tem a certeza que pretende actualizar?')");
                    }
                }

            }
        }

        protected string BuildDescAno(object PeriodoId)
        {
                return dictPeriodoAno[int.Parse(PeriodoId.ToString())].ToString();
        }

        protected string BuildLongUserName(object userId)
        {
            return dictUser[Guid.Parse(userId.ToString())].ToString();
        }
        


        private void initialize()
        {
            SqlDataReader rdr = null;

            using (SqlConnection con = new SqlConnection(MASTERSEGUROS.WEB.Comum.General.getConnection()))
            {
                //Fill all Periods/Years
                using (SqlCommand cmd = new SqlCommand("SELECT PeriodoId, Ano FROM PeriodoFerias", con))
                {
                    cmd.CommandType = CommandType.Text;

                    con.Open();
                    rdr = cmd.ExecuteReader();

                    while (rdr.Read())
                    {
                        dictPeriodoAno.Add((Int32)rdr["PeriodoId"], (Int32)rdr["Ano"]);
                    }

                    rdr.Close();
                    con.Close();
                }

                using (SqlCommand cmd = new SqlCommand("SELECT UserId, dbo.PascalCase(REPLACE(UserName,'.',' ')) as LongName FROM aspnet_Users", con))
                {
                    cmd.CommandType = CommandType.Text;

                    con.Open();
                    rdr = cmd.ExecuteReader();

                    while (rdr.Read())
                    {
                        dictUser.Add((Guid)rdr["UserId"], (String)rdr["LongName"]);
                    }

                    rdr.Close();
                    con.Close();
                }
            }
        }

      
    }
}