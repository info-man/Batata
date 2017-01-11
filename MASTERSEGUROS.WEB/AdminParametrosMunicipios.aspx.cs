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
    public partial class AdminParametrosMunicipios : System.Web.UI.Page
    {
        SqlConnection cnn = new SqlConnection(Comum.General.getConnection());
        SqlDataAdapter sqlDataAdapter = new SqlDataAdapter();
        DataTable dataTable;


        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnInsertButton_Click(object sender, EventArgs e)
        {

        }

        //protected void ButtonDelete_Click(object sender, EventArgs e)
        //{
        //    foreach (GridViewRow row in ((GridView)FormView1.FindControl("GridView1")).Rows)
        //    {
        //        CheckBox ch = (CheckBox)row.FindControl("CheckBox1");
        //        if (ch != null)
        //        {
        //            if (ch.Checked)
        //            {
        //                cnn.Close();
        //                cnn.Open();
        //                SqlTransaction transaction = cnn.BeginTransaction();

        //                SqlCommand sqlCommand = new SqlCommand("delete from master_municipio where MunicipioId=@MunicipioId", cnn);
        //                sqlCommand.Transaction = transaction;
        //                sqlCommand.CommandType = System.Data.CommandType.Text;
        //                SqlParameter paramReclamacao = sqlCommand.Parameters.Add("@MunicipioId", System.Data.SqlDbType.Int);

        //                paramReclamacao.Value = (ch).Attributes["MNCP_ID"];
        //                sqlCommand.ExecuteNonQuery();
        //                transaction.Commit();
        //                Response.Redirect("Admin_municipios.aspx");
        //                //((GridView)FormView1.FindControl("GridView1")).DataBind();
        //            }
        //        }
        //    }
        //}



        protected string BuidDescValor(object Estado)
        {
            if (Estado != null)
                if (Estado.ToString() == "True")
                return "Activo";
            else
                return "Inactivo";
             else
                return "Inactivo";

        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            //DataRowView dRowView = (DataRowView)e.Row.DataItem;
            //if (e.Row.RowType == DataControlRowType.DataRow)
            //{
            //    if ((e.Row.RowState & DataControlRowState.Edit) > 0)
            //    {
            //        DropDownList VisibleDropDownList2 = (DropDownList)e.Row.FindControl("VisibleDropDownList2");
            //        VisibleDropDownList2.SelectedValue = dRowView[2].ToString();
            //    }
            //}
        }

        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {

        }
    }
}