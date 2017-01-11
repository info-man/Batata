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
    public partial class AdminParametrosTipocategoria : System.Web.UI.Page
    {
        SqlConnection cnn = new SqlConnection(Comum.General.getConnection());
        SqlDataAdapter sqlDataAdapter = new SqlDataAdapter();
    

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btneliminar_Click(object sender, EventArgs e)
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

                        SqlCommand sqlCommand = new SqlCommand("delete from master_tipo_categoria where Codigo=@Codigo", cnn);
                        sqlCommand.Transaction = transaction;
                        sqlCommand.CommandType = System.Data.CommandType.Text;
                        SqlParameter paramReclamacao = sqlCommand.Parameters.Add("@Codigo", System.Data.SqlDbType.VarChar);

                        paramReclamacao.Value = (ch).Attributes["BC_ID"];
                        sqlCommand.ExecuteNonQuery();
                        transaction.Commit();
                    }
                }
            }

            Response.Redirect("AdminTipocategoria.aspx");
            ((GridView)FormView1.FindControl("GridView1")).DataBind();
        }

        protected void FormView1_PageIndexChanging(object sender, FormViewPageEventArgs e)
        {

        }

        protected void btneliminar_Click1(object sender, EventArgs e)
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

                        SqlCommand sqlCommand = new SqlCommand("delete from master_tipo_categoria where Codigo=@Codigo", cnn);
                        sqlCommand.Transaction = transaction;
                        sqlCommand.CommandType = System.Data.CommandType.Text;
                        SqlParameter paramReclamacao = sqlCommand.Parameters.Add("@Codigo", System.Data.SqlDbType.VarChar);

                        paramReclamacao.Value = (ch).Attributes["BC_ID"];
                        sqlCommand.ExecuteNonQuery();
                        transaction.Commit();
                    }
                }
            }

            Response.Redirect("AdminTipocategoria.aspx");
            ((GridView)FormView1.FindControl("GridView1")).DataBind();
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
    }
}