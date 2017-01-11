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
    public partial class AdminParametrosCategorias : System.Web.UI.Page
    {

        SqlConnection cnn = new SqlConnection(Comum.General.getConnection());
        SqlDataAdapter sqlDataAdapter = new SqlDataAdapter();
        DataTable datatable;


        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected string Buildocupantes(object Estado)
        {
            if (Estado != null)
                if (Estado.ToString() == "1")
                    return "Sim";
                else
                    return "Não";
            else
                return "Não";

        }

        protected void btnInsertButton_Click(object sender, EventArgs e)
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

                        SqlCommand sqlCommand = new SqlCommand("delete from master_categoria where CategoriaID=@CategoriaID", cnn);
                        sqlCommand.Transaction = transaction;
                        sqlCommand.CommandType = System.Data.CommandType.Text;
                        SqlParameter paramReclamacao = sqlCommand.Parameters.Add("@CategoriaID", System.Data.SqlDbType.Int);

                        paramReclamacao.Value = (ch).Attributes["Ct_ID"];
                        sqlCommand.ExecuteNonQuery();
                        transaction.Commit();
                    }
                }
            }

            Response.Redirect("Admin_Categorias.aspx");
            ((GridView)FormView1.FindControl("GridView1")).DataBind();
        }
    }



}