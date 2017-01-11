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
    public partial class PesquisaSimulacao : System.Web.UI.Page
    {
        public Dictionary<System.Int32, System.String> dictRamo = new Dictionary<System.Int32, System.String>();

        public Dictionary<System.Int32, System.String> dictProvincia = new Dictionary<System.Int32, System.String>();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!User.Identity.IsAuthenticated)
                Response.Redirect("~/Account/Login.aspx");

                initialize();
           
        }

        protected void Page_LoadComplete(object sender, EventArgs e)
        {

           
            if (DataInicioTextBox.Text.Length == 10)
            {
                DataInicioTextBox.Text = DataInicioTextBox.Text.Substring(3, 2) + "/" + DataInicioTextBox.Text.Substring(0, 2) + "/" + DataInicioTextBox.Text.Substring(6, 4);
            }


            if (DataFimTextBox.Text.Length == 10)
            {
                DataFimTextBox.Text = DataFimTextBox.Text.Substring(3, 2) + "/" + DataFimTextBox.Text.Substring(0, 2) + "/" + DataFimTextBox.Text.Substring(6, 4);
            }


        }
        protected string BuildRamo(object RamoId)
        {
            try {
                return dictRamo[int.Parse(RamoId.ToString())].ToString();
            }
            catch
            {
                return "";

            }
        }

        protected string BuildProvincia(object ProvinciaId)
        {
            try
            {
                return dictProvincia[int.Parse(ProvinciaId.ToString())].ToString();
            }
            catch
            {
                return "";

            }
        }

        public string BuildTipo(object Tipo)
        {
            try
            {
                return Comum.General.BuildTipo(Tipo);
            }
            catch
            {
                return "";

            }
        }

        private void initialize()
        {
            //ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "SetAcordion", "SetAcordion(1);", true);

            DataView dviewRamo = (DataView)SqlDataSourceRamo.Select(DataSourceSelectArguments.Empty);
            DataView dviewProvincia = (DataView)SqlDataSourceProvincia.Select(DataSourceSelectArguments.Empty);
          

            foreach (DataRow row in dviewRamo.Table.Rows)
            {
                dictRamo.Add((Int32)row[0], (String)row[1]);
            }

            foreach (DataRow row in dviewProvincia.Table.Rows)
            {
                dictProvincia.Add((Int32)row[0], (String)row[1]);
            }
        }

        protected void btnPesquisar_Click(object sender, EventArgs e)
        {
            try
            {

                GridViewProposta.DataBind();
                //ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "SetAcordionPosition", "SetAcordion(1);", true);


            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message, ex);
            }

        }
    
        protected string BuildEstado(object Estado)
        {
            if (Estado.ToString()=="1")
                return "Em Cobrança";
            else if (Estado.ToString() == "2")
                return "Pago";
            else if (Estado.ToString() == "3")
                return "Emitida";
            else if (Estado.ToString() == "4")
                return "Anulada";
            return "NA";
        }

        protected void Operation_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (((System.Web.UI.WebControls.ListControl)(sender)).SelectedValue == "1")
            {
                Response.Redirect("AutoDoc.aspx?docid=" + (((System.Web.UI.WebControls.ListControl)(sender))).Attributes["IDClass"]);
            }
            
            if (((System.Web.UI.WebControls.ListControl)(sender)).SelectedValue == "3")
            {
                Response.Redirect("AdminTraduzir.aspx?cid=" + (((System.Web.UI.WebControls.ListControl)(sender))).Attributes["IDClass"] + "&idl=" + (((System.Web.UI.WebControls.ListControl)(sender))).Attributes["IDLingua"]);
            }

            if (((System.Web.UI.WebControls.ListControl)(sender)).SelectedValue == "4")
            {
                Response.Redirect("AdminConteudosClassificados.aspx?cid=" + (((System.Web.UI.WebControls.ListControl)(sender))).Attributes["IDClass"] + "&idl=" + (((System.Web.UI.WebControls.ListControl)(sender))).Attributes["IDLingua"]);
            }

            if (((System.Web.UI.WebControls.ListControl)(sender)).SelectedValue == "5")
            {
                Response.Redirect("AdminAssociar.aspx?cid=" + (((System.Web.UI.WebControls.ListControl)(sender))).Attributes["IDClass"] + "&idl=" + (((System.Web.UI.WebControls.ListControl)(sender))).Attributes["IDLingua"]);
            }
        }
    }
}