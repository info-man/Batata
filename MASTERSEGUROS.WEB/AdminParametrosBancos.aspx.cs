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
    public partial class AdminParametrosBancos : System.Web.UI.Page
    {

        SqlConnection cnn = new SqlConnection(Comum.General.getConnection());
        SqlDataAdapter sqlDataAdapter = new SqlDataAdapter();
        DataTable datatable;

        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void ButtonDelete_Click(object sender, EventArgs e)
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

                        SqlCommand sqlCommand = new SqlCommand("delete from master_banco where bancoID=@bancoID", cnn);
                        sqlCommand.Transaction = transaction;
                        sqlCommand.CommandType = System.Data.CommandType.Text;
                        SqlParameter paramReclamacao = sqlCommand.Parameters.Add("@bancoID", System.Data.SqlDbType.Int);

                        paramReclamacao.Value = (ch).Attributes["BC_ID"];
                        sqlCommand.ExecuteNonQuery();
                        transaction.Commit();
                    }
                }
            }

            Response.Redirect("Admin_Bancos.aspx");
            ((GridView)FormView1.FindControl("GridView1")).DataBind();
        }

        protected void btnInsertButton_Click(object sender, EventArgs e)
        {
            //Response.Redirect("Admin_Bancos.aspx");
            //GridView1.DataBind();

        }
    }
}