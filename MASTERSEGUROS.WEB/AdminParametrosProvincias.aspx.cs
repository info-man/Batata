using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MASTERSEGUROS.WEB
{
    public partial class AdminParametrosProvincias : System.Web.UI.Page
    {
        public string ActiveAccordion = "";
        protected void Page_Load(object sender, EventArgs e)
        {
           
            string controlName = "";

            if (Page.Request.Params["__EVENTTARGET"] == null)
            {
                ActiveAccordion = "0";
            }
            else
            {
                if (Page.FindControl(Page.Request.Params["__EVENTTARGET"]) == null)
                {
                    ActiveAccordion = "1";
                    return;
                }

                controlName = Page.FindControl(Page.Request.Params["__EVENTTARGET"]).ID;

                if (controlName== "GridView1" || controlName == "InsertButton" || (Page.FindControl(Page.Request.Params["__EVENTTARGET"])).ClientID.ToString().Contains("GridView1"))
                    ActiveAccordion = "0";
                else
                    ActiveAccordion = "1";
            }
        }
        protected string BuildEstado(object Estado)
        {
            if (Estado != null)
                if (Estado.ToString() == "True")
                    return "Activo";
                else
                    return "Inactivo";
            else
                return "Inactivo";

        }
    }
}