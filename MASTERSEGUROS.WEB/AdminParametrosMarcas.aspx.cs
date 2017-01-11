using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;


namespace MASTERSEGUROS.WEB
    
{
    public partial class AdminParametrosMarcas : System.Web.UI.Page
    {
        SqlConnection cnn = new SqlConnection(Comum.General.getConnection());
        SqlDataAdapter sqlDataAdapter = new SqlDataAdapter();


        protected void Page_Load(object sender, EventArgs e)
        {
            //if (!User.Identity.IsAuthenticated)
            //    Response.Redirect("~/Account/Login.aspx");

        }

        protected void FormView1_PageIndexChanging(object sender, FormViewPageEventArgs e)
        {

        }
        protected void DeleteButton_Click1(object sender, EventArgs e)
        {
            
        }
        protected void btnInsertButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("AdminMarcas.aspx");
            ((GridView)FormView1.FindControl("GridView1")).DataBind();
        }

        protected void btnapagar_Click(object sender, EventArgs e)
        {
            foreach (GridViewRow row in ((GridView)FormView1.FindControl("GridView1")).Rows)
            {
                CheckBox ch = (CheckBox)row.FindControl("CheckBox1");
                if (ch != null)
                {
                    if (ch.Checked)
                    {
                        cnn.Close();
                        cnn.Open();
                        SqlTransaction transaction = cnn.BeginTransaction();

                        SqlCommand sqlCommand = new SqlCommand("delete from master_marca_veiculo where MarcaID=@MarcaID", cnn);
                        sqlCommand.Transaction = transaction;
                        sqlCommand.CommandType = System.Data.CommandType.Text;
                        SqlParameter paramReclamacao = sqlCommand.Parameters.Add("@MarcaID", System.Data.SqlDbType.Int);

                        paramReclamacao.Value = (ch).Attributes["BC_ID"];
                        sqlCommand.ExecuteNonQuery();
                        transaction.Commit();
                    }
                }
            }

            Response.Redirect("AdminMarcas.aspx");
            ((GridView)FormView1.FindControl("GridView1")).DataBind();
        }

        protected string BuildEstado(object Estado)
        {
            if (Estado != null)
                if (Estado.ToString() == "1")
                    return "Activo";
                else
                    return "Inactivo";
            else
                return "Inactivo";

        }
    }
}