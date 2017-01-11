using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using Winthusiasm.HtmlEditor;


namespace MASTERSEGUROS.WEB
{
    public partial class AdminPropostaApolice : System.Web.UI.Page
    {
        public Dictionary<System.Int32, System.String> dictLingua = new Dictionary<System.Int32, System.String>();
        public string sMessage = string.Empty;

        protected void Page_Load(object sender, EventArgs e)
        {
           // if (!User.Identity.IsAuthenticated)
             //   Response.Redirect("~/Account/Login.aspx");

           // initialize();
           // InitializeFormView();

           // Session["tab"] = "RibbonTabMilitantes";

        }

        protected void gvEmployee_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            //if (e.Row.RowType == DataControlRowType.DataRow)
            //{
            //   if (e.Row.RowState == DataControlRowState.Edit || e.Row.RowState == (System.Web.UI.WebControls.DataControlRowState.Alternate | System.Web.UI.WebControls.DataControlRowState.Edit))
            //    {
            //        LinkButton lb = (LinkButton)e.Row.Cells[4].Controls[0];
            //        if (lb != null)
            //        {
            //            lb.Attributes.Add("onclick", "javascript:return " + "ConfirmActualizarDiasExtra('" + this.Page.ClientScript.GetPostBackEventReference(new PostBackOptions(lb)).Replace("'", "|") + "')");
            //        }
            //    }
            //}
        }

        //protected string BuildNomeAuditor(object AuditorId)
        //{
        //    //return dictAuditor[int.Parse(AuditorId.ToString())].ToString();
        //}

        //protected string BuildNomeProjecto(object ProjectoId)
        //{
        //    return dictProjecto[int.Parse(ProjectoId.ToString())].ToString();
        //}

        protected Boolean BuildBoolean(object bVal)
        {
            if(bVal==null) 
                return false;

            if (bVal.Equals(System.Boolean.Parse("true")))
                return true;
            else
                return false;
        }
        
        protected void On_Inserted(Object sender, SqlDataSourceStatusEventArgs e)
        {

            if (e.Exception == null)
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(),
               "ShowMessageCreate", string.Format("<script type='text/javascript'>MessageBoxCAPCriado('');</script>", ""));
            }
            else
            {
                //ClientMessageBox.Show("ATENÇÃO: Ocorreu a gravar os dados.\nContacte o administrador de sistemas.\n" + e.Exception.ToString(), this);
                Page.ClientScript.RegisterStartupScript(this.GetType(),
                "ShowMessageErro", string.Format("<script type='text/javascript'>MessageBoxErroGravar('');</script>", ""));

            }
        }

        protected void On_Updated(Object sender, SqlDataSourceStatusEventArgs e)
        {
            if (e.Exception == null)
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(),
               "ShowMessageUpdate", string.Format("<script type='text/javascript'>MessageBoxClassificadorActualizado('');</script>", ""));
            }
            else
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(),
               "ShowMessageErro", string.Format("<script type='text/javascript'>MessageBoxErroGravar('');</script>", ""));
             }
        }

        private void initialize()
        {
            //SqlDataReader rdr = null;

            //using (SqlConnection con = new SqlConnection(MASTERSEGUROS.WEB.Comum.General.getConnection()))
            //{
            //    //Fill all Periods/Years
            //    using (SqlCommand cmd = new SqlCommand("SELECT * FROM [cmsck_lingua]", con))
            //    {
            //        cmd.CommandType = CommandType.Text;

            //        con.Open();
            //        rdr = cmd.ExecuteReader();

            //        while (rdr.Read())
            //        {
            //            dictLingua.Add((Int32)rdr["LinguaId"], (String)rdr["Abreviatura"]);
            //        }

            //        rdr.Close();
            //        con.Close();
            //    }
            //}
           
        }

        void InitializeFormView()
        {
            string cpaid = string.Empty;
            //           string idl = string.Empty;

            cpaid = Request.QueryString["cpaid"];
 //           idl = Request.QueryString["idl"];
            if (cpaid != null)
            {
                FormView1.ChangeMode(FormViewMode.Edit);

                //Seleccionar o registo correcto
                if (!IsPostBack)
                {
                    SqlDataSourceCTT.SelectParameters["MilitanteID"].DefaultValue = cpaid;
                    
                    FormView1.DataBind();
                    ((DropDownList)FormView1.FindControl("ProvinciaIDComboBox")).SelectedValue = ((System.Data.DataRowView)(FormView1.DataItem)).Row["ProvinciaID"].ToString();
                    ((DropDownList)FormView1.FindControl("MunicipioIDComboBox")).SelectedValue = ((System.Data.DataRowView)(FormView1.DataItem)).Row["MunicipioID"].ToString();
                    ((DropDownList)FormView1.FindControl("ComunaIDComboBox")).SelectedValue = ((System.Data.DataRowView)(FormView1.DataItem)).Row["ComunaID"].ToString();

                    //((DropDownList)FormView1.FindControl("ProvinciaNascIDComboBox")).SelectedValue = ((System.Data.DataRowView)(FormView1.DataItem)).Row["ProvinciaNascID"].ToString();
                    //((DropDownList)FormView1.FindControl("MunicipioNascIDComboBox")).SelectedValue = ((System.Data.DataRowView)(FormView1.DataItem)).Row["MunicipioNascID"].ToString();
                    //((DropDownList)FormView1.FindControl("ComunaNascIDComboBox")).SelectedValue = ((System.Data.DataRowView)(FormView1.DataItem)).Row["ComunaNascID"].ToString();


                    //    ((DropDownList)FormView1.FindControl("EstadoCombobox")).SelectedValue = ((System.Data.DataRowView)(FormView1.DataItem)).Row["Estado"].ToString();

                    //    //Se Exitir Media, mostro "ver" e "Apagar"
                    //    if (((System.Data.DataRowView)(FormView1.DataItem)).Row["Foto"].ToString() != string.Empty)
                    //    {

                    //        ((Button)FormView1.FindControl("btnApagarMedia")).Visible = true;
                    //        ((Button)FormView1.FindControl("btnVerMedia")).Visible = true;
                    //        ((FileUpload)FormView1.FindControl("MediaUpload")).Visible = false;
                    //        imgVerMedia.ImageUrl="~/uploads/" + ((System.Data.DataRowView)(FormView1.DataItem)).Row["Media"].ToString();
                    //    }
                    //    else
                    //    {
                    //        ((Button)FormView1.FindControl("btnApagarMedia")).Visible = false;
                    //        ((Button)FormView1.FindControl("btnVerMedia")).Visible = false;
                    //        ((FileUpload)FormView1.FindControl("MediaUpload")).Visible = true;
                    //    }
                    //        //SetDisableFields(Boolean.Parse(((System.Data.DataRowView)(FormView1.DataItem)).Row["Aberto"].ToString()));
                }
                //else
                //{

                //}
                //Mudar a descrição da label
                //lblBread.Text = " Editar ";


                string op = string.Empty;
                op = Request.QueryString["op"];
                if (op != null)
                {
                    ((Button)FormView1.FindControl("ValidateButton")).Visible = true;
                    ((TextBox)FormView1.FindControl("txtObs")).Visible = true;
                    ((Button)FormView1.FindControl("ReproveButton")).Visible = true;
                }
            }
            else
            {
                //Mudar a descrição da label
                //lblBread.Text = " Criar ";
                FormView1.ChangeMode(FormViewMode.Insert);
            }
        }

        //protected string BuildLingua(object LinguaId)
        //{
        //    return dictLingua[int.Parse(LinguaId.ToString())].ToString();
        //}
        protected void On_Updating(object sender, SqlDataSourceCommandEventArgs e)
        {
            //string sExtension = string.Empty;
            //string sFileName = string.Empty;

            //if (((System.Web.UI.WebControls.FileUpload)FormView1.FindControl("MediaUpload")).HasFile)
            //{
            //    sExtension = ((System.Web.UI.WebControls.FileUpload)FormView1.FindControl("MediaUpload")).FileName.Substring(((System.Web.UI.WebControls.FileUpload)FormView1.FindControl("MediaUpload")).FileName.Length - 4);
            //    sFileName = System.Guid.NewGuid().ToString() + sExtension;
            //    SaveFile(sFileName);
            //    e.Command.Parameters["@Media"].Value = sFileName;
            //}
            //else
            //    e.Command.Parameters["@Media"].Value = string.Empty;


            ////Campo Editor
            //e.Command.Parameters["@Descricao"].Value = ((Winthusiasm.HtmlEditor.HtmlEditor)FormView1.FindControl("DescricaoTextBox")).Text;

            
        }

        protected void SqlDataSourceCTT_Inserting(object sender, SqlDataSourceCommandEventArgs e)
        {
            string sExtension = string.Empty;
            string sFileName = string.Empty;

            if (((System.Web.UI.WebControls.FileUpload)FormView1.FindControl("MediaUpload")).HasFile)
            {
                sExtension = ((System.Web.UI.WebControls.FileUpload)FormView1.FindControl("MediaUpload")).FileName.Substring(((System.Web.UI.WebControls.FileUpload)FormView1.FindControl("MediaUpload")).FileName.Length - 4);
                sFileName = System.Guid.NewGuid().ToString() + sExtension;
                SaveFile(sFileName);
                e.Command.Parameters["@Foto"].Value = sFileName;
            }
            else
            {
                e.Command.Parameters["@Foto"].Value = string.Empty;
            }

            //ClassificadorID (Max(classificadorID) +1 
            e.Command.Parameters["@CAPID"].Value = getNextCAPID();
            e.Command.Parameters["@UserIDCriacao"].Value = Membership.GetUser().ProviderUserKey.ToString();
            






        }

        public bool SaveFile(string filename)
        {
            try
            {
                string savePath = Server.MapPath("\\uploads\\");
                ((System.Web.UI.WebControls.FileUpload)FormView1.FindControl("MediaUpload")).SaveAs(savePath + filename);
            }
            catch
            {
                return false;
            }

            return true;
        }

        protected void btnApagarMedia_Click(object sender, EventArgs e)
        {
            ((Button)FormView1.FindControl("btnApagarMedia")).Visible = false;
            ((Button)FormView1.FindControl("btnVerMedia")).Visible = false;
            ((FileUpload)FormView1.FindControl("MediaUpload")).Visible = true;
            

            
        }

        private int getNextCAPID()
        {
            int cid = 0;           

             using (SqlConnection con = new SqlConnection(MASTERSEGUROS.WEB.Comum.General.getConnection()))
             {
                 //Fill all Periods/Years
                 using (SqlCommand cmd = new SqlCommand("SELECT coalesce(MAX(MilitanteID),0,MAX(MilitanteID)) + 1 FROM sige_cliente", con))
                 {
                     cmd.CommandType = CommandType.Text;

                     con.Open();
                     cid= (int)cmd.ExecuteScalar();
                     con.Close();
                 }
             }
             return cid;
        }

        //protected void btnteste_Click(object sender, EventArgs e)
        //{
        //    string aa = ((Winthusiasm.HtmlEditor.HtmlEditor)FormView1.FindControl("Editor")).Text;
        //}

        //protected void OBAdicionar_Click(object sender, EventArgs e)
        //{
        //    this.Validate("Form");
        //}

        protected void btnEsconderPesquisa_Click(object sender, EventArgs e)
        {
            try
            {
                ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "myAlertScript", "SetAcordion(1);", true);
                ((Panel)FormView1.FindControl("pnlMostrarPesquisa")).Visible = false;
                ((Button)FormView1.FindControl("btnMostrarPesquisa")).Visible = true;
               

            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message, ex);
            }

        }

        protected void btnMostrarPesquisa_Click(object sender, EventArgs e)
        {
            try
            {
              
                ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "myAlertScript", "SetAcordion(1);", true);
                ((Panel)FormView1.FindControl("pnlMostrarPesquisa")).Visible = true;
                ((Button)FormView1.FindControl("btnMostrarPesquisa")).Visible = false;

                ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "ScriptDataPicker", "SetDatapicker();", true);
                
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message, ex);
            }

        }

        protected void btnPesquisar_Click(object sender, EventArgs e)
        {
            try
            {
                ((GridView)FormView1.FindControl("GridViewClassificador")).DataBind();

            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message, ex);
            }

        }

        protected void MarcaComboBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            ((DropDownList)FormView1.FindControl("ModeloComboBox")).Items.Clear();
            ((DropDownList)FormView1.FindControl("ModeloComboBox")).DataBind();
            ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "IniatializeSetAcordion", "SetAcordion(2);", true);
            ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "IniatializeSetDatapicker", "SetDatapicker();", true);
        }

        public static Dictionary<string,string> GetSimulacao(string CodigoTipoVeiculo, string ConfigKeyIdadeCondutor, string ConfigKeyExperienciaCondutor, string ConfigKeyAnosVeiculo, decimal Malus, decimal Bonus, decimal Descontos)
        {
            SqlDataReader rdr = null;
            String sRetValue = string.Empty;
            Dictionary<string, string> dicSimulacao = new Dictionary<string, string>();

            using (SqlConnection con = new SqlConnection(Comum.General.getConnection()))
            {
                con.Open();
                //Actualizar o estado da marcação
                SqlCommand sqlCommand = new SqlCommand("spCalculaPremio", con);

                sqlCommand.CommandType = System.Data.CommandType.StoredProcedure;

                SqlParameter paramCodigoTipoVeiculo = sqlCommand.Parameters.Add("@CodigoTipoVeiculo", SqlDbType.VarChar);
                SqlParameter paramConfigKeyIdadeCondutor = sqlCommand.Parameters.Add("@ConfigKeyIdadeCondutor", SqlDbType.VarChar);
                SqlParameter paramConfigKeyExperienciaCondutor = sqlCommand.Parameters.Add("@ConfigKeyExperienciaCondutor", SqlDbType.VarChar);
                SqlParameter paramConfigKeyAnosVeiculo = sqlCommand.Parameters.Add("@ConfigKeyAnosVeiculo", SqlDbType.VarChar);
                //SqlParameter paramConfigKeyParcelaPagamento = sqlCommand.Parameters.Add("@ConfigKeyParcelaPagamento", SqlDbType.VarChar);
                SqlParameter paramMalus = sqlCommand.Parameters.Add("@Malus", SqlDbType.Decimal);
                SqlParameter paramBonus = sqlCommand.Parameters.Add("@Bonus", SqlDbType.Decimal);
                SqlParameter paramDescontos = sqlCommand.Parameters.Add("@Descontos", SqlDbType.Decimal);

                paramCodigoTipoVeiculo.Value = CodigoTipoVeiculo;
                paramConfigKeyIdadeCondutor.Value = ConfigKeyIdadeCondutor;
                paramConfigKeyExperienciaCondutor.Value = ConfigKeyExperienciaCondutor;
                paramConfigKeyAnosVeiculo.Value = ConfigKeyAnosVeiculo;
                //paramConfigKeyParcelaPagamento.Value = ConfigKeyParcelaPagamento;
                paramMalus.Value = Malus;
                paramBonus.Value = Bonus;
                paramDescontos.Value = Descontos;

                rdr = sqlCommand.ExecuteReader();

                while (rdr.Read())
                {
                    //dicSimulacao.Add("PremioPuro", rdr["PremioPuro"].ToString());
                    //dicSimulacao.Add("PremioComercial", rdr["PremioComercial"].ToString());
                    //dicSimulacao.Add("Encargos", rdr["Encargos"].ToString());
                    //dicSimulacao.Add("EncargosParcelamento", rdr["EncargosParcelamento"].ToString());
                    //dicSimulacao.Add("ImpostoSelo", rdr["ImpostoSelo"].ToString());
                    //dicSimulacao.Add("PremioTotal", rdr["PremioTotal"].ToString());
                }

                con.Close();
            }

            return dicSimulacao;

        }

        protected void SimularButton_Click(object sender, EventArgs e)
        {
            
            ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "Iniatialize", "SetInitialize();", true);
            ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "IniatializeSetAcordion", "SetAcordion(2);", true);
            ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "IniatializeSetDatapicker", "SetDatapicker();", true);

            Dictionary<string, string> dicSimulacao = new Dictionary<string, string>();

            string CodigoTipoVeiculo = ((DropDownList)FormView1.FindControl("TipoVeiculoComboBox")).SelectedValue.ToString();
            string ConfigKeyIdadeCondutor = Comum.General.getKeyIdadeCondutor(((TextBox)FormView1.FindControl("IdadeCondutorTextBox")).Text); //IDADE_MENOS_25 | IDADE_MAIS_60 | IDADE_MAIS_25_MENOS_60
            string ConfigKeyExperienciaCondutor = Comum.General.getKeyExperienciaCondutor(((TextBox)FormView1.FindControl("AnosCartaTextBox")).Text);
            string ConfigKeyAnosVeiculo = Comum.General.getKeyAnosVeiculo(Comum.General.getAge( DateTime.Parse(((TextBox)FormView1.FindControl("DataFabricoTextBox")).Text)).ToString());
            //string ConfigKeyParcelaPagamento = ((DropDownList)FormView1.FindControl("ParcelamentoComboBox")).SelectedValue.ToString(); 
            decimal Malus = decimal.Parse(((TextBox)FormView1.FindControl("MalusTextBox")).Text);
            decimal Bonus = decimal.Parse(((TextBox)FormView1.FindControl("BonusTextBox")).Text);
            decimal Descontos = 0;

            dicSimulacao = GetSimulacao(CodigoTipoVeiculo, ConfigKeyIdadeCondutor, ConfigKeyExperienciaCondutor, ConfigKeyAnosVeiculo, Malus, Bonus, Descontos);


            //ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "ShowMessageSucess", "MessageBoxSimulacaoSucesso('" + dicSimulacao["PremioPuro"] + "','" + dicSimulacao["PremioComercial"] + "','" + dicSimulacao["Encargos"] + "','" + dicSimulacao["EncargosParcelamento"] + "','" + dicSimulacao["ImpostoSelo"] +  "','" + dicSimulacao["PremioTotal"] + "');", true);
        }
    }
}