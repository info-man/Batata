using SelectPdf;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using Winthusiasm.HtmlEditor;


namespace MASTERSEGUROS.WEB
{
    public partial class AdminSimulacaoAT : System.Web.UI.Page
    {
        public Dictionary<System.Int32, System.String> dictProvincia = new Dictionary<System.Int32, System.String>();

        public string sMessage = string.Empty;
        public string sProposta = string.Empty;
        public bool FlagControl = false;
        public string UrlDocument = string.Empty;
      
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!User.Identity.IsAuthenticated)
               Response.Redirect("~/Account/Login.aspx");

             initialize();
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
            if (bVal == null)
                return false;

            if (bVal.Equals(System.Boolean.Parse("true")))
                return true;
            else
                return false;
        }

        protected void On_Inserted(Object sender, SqlDataSourceStatusEventArgs e)
        {

            //if (e.Exception == null)
            //{
            //    string sProposta =  Comum.General.FormataProposta(e.Command.Parameters["@PropostaID"].Value.ToString(), "AUTO");
            //    SimularAuto(sProposta) ;
            //}
            //else
            //{
            //    Page.ClientScript.RegisterStartupScript(this.GetType(),
            //    "ShowMessageErro", string.Format("<script type='text/javascript'>MessageBoxErroGravar('');</script>", ""));

            //}
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

        protected void ClienteComboBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (((DropDownList)sender).SelectedValue == "2")
            {
                ScriptManager.RegisterClientScriptBlock(this, GetType(), "showCliente", "showCliente();", true);
                ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "InitializeAcordion_1", "SetInitializeAcordion_1();", true);
            }

        }

        private void initialize()
        {
            //SqlDataReader rdr = null;

            //using (SqlConnection con = new SqlConnection(MASTERSEGUROS.WEB.Comum.General.getConnection()))
            //{
            //    //Fill all Periods/Years
            //    using (SqlCommand cmd = new SqlCommand("SELECT * FROM [master_opcao_ocupante_detalhe]", con))
            //    {
            //        cmd.CommandType = CommandType.Text;

            //        con.Open();
            //        rdr = cmd.ExecuteReader();

            //        while (rdr.Read())
            //        {
            //            dictDetalheOpcao.Add(rdr["OpcaoOcupantesID"].ToString() + (string)rdr["DescricaoCurta"], (decimal)rdr["Valor"]);
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
                    SqlDataSourcePropostaAuto.SelectParameters["MilitanteID"].DefaultValue = cpaid;

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
       
        protected void On_Updating(object sender, SqlDataSourceCommandEventArgs e)
        {
            //e.Command.Parameters["@UserIDCriacao"].Value = Membership.GetUser().ProviderUserKey.ToString();
            //e.Command.Parameters["@DataCriacao"].Value = DateTime.Now;
        }

        protected void On__Inserting(object sender, SqlDataSourceCommandEventArgs e)
        {
            //string sExtension = string.Empty;
            //string sFileName = string.Empty;

            //if (((System.Web.UI.WebControls.FileUpload)FormView1.FindControl("MediaUpload")).HasFile)
            //{
            //    sExtension = ((System.Web.UI.WebControls.FileUpload)FormView1.FindControl("MediaUpload")).FileName.Substring(((System.Web.UI.WebControls.FileUpload)FormView1.FindControl("MediaUpload")).FileName.Length - 4);
            //    sFileName = System.Guid.NewGuid().ToString() + sExtension;
            //    SaveFile(sFileName);
            //    e.Command.Parameters["@Foto"].Value = sFileName;
            //}
            //else
            //{
            //    e.Command.Parameters["@Foto"].Value = string.Empty;
            //}

            //ClassificadorID (Max(classificadorID) +1 
            //e.Command.Parameters["@CAPID"].Value = getNextCAPID();
            e.Command.Parameters["@UserIDCriacao"].Value = Membership.GetUser().ProviderUserKey.ToString();
            e.Command.Parameters["@DataCriacao"].Value = DateTime.Now;

        }

        protected void SqlDataSourcePropostaAuto_Inserting(object sender, SqlDataSourceCommandEventArgs e)
        {
            e.Command.Parameters["@UserIDCriacao"].Value = Membership.GetUser().ProviderUserKey.ToString();
            e.Command.Parameters["@DataCriacao"].Value = DateTime.Now;
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

        protected void Proposta_Click(object sender, EventArgs e)
        {

        }

        protected void cstConverterApolice_ServerValidate(object source, ServerValidateEventArgs args)
        {

            if (FlagControl)
                return;

            FlagControl = true;


            if (Session["Proposta"] != null)
                args.IsValid = (Session["Proposta"].ToString() != String.Empty);
            else
                args.IsValid = false;



            if (!args.IsValid)
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "ShowMessageBoxEmptyConverterApolice", string.Format("<script type='text/javascript'>MessageBoxEmptyConverterApolice('');</script>", ""));
            }
            else
            {
                Dictionary<string, string> dicDadosApolice = new Dictionary<string, string>();
                Dictionary<string, string> dicDadosCobranca = new Dictionary<string, string>();

                //dicDadosApolice = ConvertePropostaToApolice(Session["Proposta"].ToString());

                //Se não existir um aviso de cobrança, este é criado
                //dicDadosCobranca = CreateAvisoCobranca(dicDadosApolice["ApoliceID"]);

                Page.ClientScript.RegisterStartupScript(this.GetType(), "ShowMessageBoxResultado", string.Format("<script type='text/javascript'>MessageBoxResultado('" + dicDadosApolice["ApoliceID"] + "','" + dicDadosApolice["NumeroApolice"] + "','" + dicDadosApolice["ClienteID"] + "','" + dicDadosCobranca["NumeroAvisoCobranca"] + "');</script>", ""));
            }



        }

        protected void MarcaComboBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            ((DropDownList)FormView1.FindControl("ModeloComboBox")).Items.Clear();
            ((DropDownList)FormView1.FindControl("ModeloComboBox")).DataBind();
            //ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "IniatializeSetAcordion", "SetAcordion(2);", true);
            ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "InitializeAcordion_3", "SetInitializeAcordion_3();", true);
        }

        public static Dictionary<string, string> GetSimulacao(int TipoSeguro, int Opcao, int Lugares, string CodigoTipoVeiculo, int CodigoCategoria, string ConfigKeyParcelamento,  string ConfigKeyIdadeCondutor, string ConfigKeyExperienciaCondutor, string ConfigKeyAnosVeiculo, decimal Malus, decimal Bonus, decimal Descontos, decimal ValorSegurar)
        {
            SqlDataReader rdr = null;
            String sRetValue = string.Empty;
            Dictionary<string, string> dicSimulacao = new Dictionary<string, string>();

            using (SqlConnection con = new SqlConnection(Comum.General.getConnection()))
            {
                con.Open();
                
                SqlCommand sqlCommand = new SqlCommand("spCalculaPremio", con);

                sqlCommand.CommandType = CommandType.StoredProcedure;

                SqlParameter paramTipoSeguroID = sqlCommand.Parameters.Add("@TipoSeguroID", SqlDbType.Int);
                SqlParameter paramOpcaoID = sqlCommand.Parameters.Add("@OpcaoID", SqlDbType.Int);
                SqlParameter paramNrLugares = sqlCommand.Parameters.Add("@NrLugares", SqlDbType.Int);
                SqlParameter paramCodigoTipoVeiculo = sqlCommand.Parameters.Add("@CodigoTipoVeiculo", SqlDbType.VarChar);
                SqlParameter paramCodigoCategoria = sqlCommand.Parameters.Add("@CodigoCategoria", SqlDbType.Int);
                SqlParameter paramConfigKeyConfigKeyParcelaPagamento = sqlCommand.Parameters.Add("@ConfigKeyParcelaPagamento", SqlDbType.VarChar);
                SqlParameter paramConfigKeyIdadeCondutor = sqlCommand.Parameters.Add("@ConfigKeyIdadeCondutor", SqlDbType.VarChar);
                SqlParameter paramConfigKeyExperienciaCondutor = sqlCommand.Parameters.Add("@ConfigKeyExperienciaCondutor", SqlDbType.VarChar);
                SqlParameter paramConfigKeyAnosVeiculo = sqlCommand.Parameters.Add("@ConfigKeyAnosVeiculo", SqlDbType.VarChar);
                SqlParameter paramMalus = sqlCommand.Parameters.Add("@Malus", SqlDbType.Decimal);
                SqlParameter paramBonus = sqlCommand.Parameters.Add("@Bonus", SqlDbType.Decimal);
                SqlParameter paramDescontos = sqlCommand.Parameters.Add("@Descontos", SqlDbType.Decimal);
                SqlParameter paramValorSegurar = sqlCommand.Parameters.Add("@ValorSegurar", SqlDbType.Decimal);

                paramTipoSeguroID.Value = TipoSeguro;
                paramOpcaoID .Value= Opcao;
                paramNrLugares.Value = Lugares;
                paramCodigoTipoVeiculo.Value = CodigoTipoVeiculo;
                paramCodigoCategoria.Value = CodigoCategoria;
                paramConfigKeyConfigKeyParcelaPagamento.Value = ConfigKeyParcelamento;
                paramConfigKeyIdadeCondutor.Value = ConfigKeyIdadeCondutor;
                paramConfigKeyExperienciaCondutor.Value = ConfigKeyExperienciaCondutor;
                paramConfigKeyAnosVeiculo.Value = ConfigKeyAnosVeiculo;
                paramMalus.Value = Malus;
                paramBonus.Value = Bonus;
                paramDescontos.Value = Descontos;
                paramValorSegurar.Value = ValorSegurar;

                rdr = sqlCommand.ExecuteReader();

                while (rdr.Read())
                {
                    dicSimulacao.Add("TipoSeguro", rdr["TipoSeguro"].ToString());
                    dicSimulacao.Add("Fraccionamento", rdr["Fraccionamento"].ToString());
                    dicSimulacao.Add("PremioSimples", rdr["PremioSimples"].ToString());
                    dicSimulacao.Add("Encargos", rdr["Encargos"].ToString());
                    dicSimulacao.Add("Arseg", rdr["Arseg"].ToString());
                    dicSimulacao.Add("Funga", rdr["Funga"].ToString());
                    dicSimulacao.Add("IncrementoApolice", rdr["IncrementoApolice"].ToString());
                    dicSimulacao.Add("ValorOpcaoExtra", rdr["ValorOpcaoExtra"].ToString());
                    dicSimulacao.Add("PremioTotal", rdr["PremioTotal"].ToString());
                }

                con.Close();
            }

            return dicSimulacao;

        }

        public  Dictionary<string, string> GetSimulacao()
        {
            Dictionary<string, string> dicSimulacao = new Dictionary<string, string>();

            string CodigoTipoVeiculo = ((DropDownList)FormView1.FindControl("TipoCategoriaComboBox")).SelectedValue.ToString();
            int iCodigoCategoria = int.Parse(((DropDownList)FormView1.FindControl("CategoriaComboBox")).SelectedValue.ToString());
            string ConfigKeyParcelamento = ((DropDownList)FormView1.FindControl("CobrancaFraccionamentoComboBox")).SelectedValue.ToString();
            string ConfigKeyIdadeCondutor = Comum.General.getKeyIdadeCondutor(Comum.General.getAge(DateTime.Parse(((TextBox)FormView1.FindControl("DataNascimentoTextBox")).Text)).ToString()); //IDADE_MENOS_25 | IDADE_MAIS_60 | IDADE_MAIS_25_MENOS_60
            string ConfigKeyExperienciaCondutor = Comum.General.getKeyExperienciaCondutor(Comum.General.getAge(DateTime.Parse(((TextBox)FormView1.FindControl("DataCartaTextBox")).Text)).ToString());
            string ConfigKeyAnosVeiculo = Comum.General.getKeyAnosVeiculo(Comum.General.getAge(DateTime.Parse(((TextBox)FormView1.FindControl("DataFabricoTextBox")).Text)).ToString());
            int iTipoSeguro = int.Parse(((DropDownList)FormView1.FindControl("TipoSeguroComboBox")).SelectedValue.ToString());
            int iOpcao = (((DropDownList)FormView1.FindControl("OpcaoOcupantesComboBox")).SelectedValue.ToString() == string.Empty?0:int.Parse(((DropDownList)FormView1.FindControl("OpcaoOcupantesComboBox")).SelectedValue.ToString()));
            int iLugares = int.Parse(((TextBox)FormView1.FindControl("LugaresTextBox")).Text);
            //decimal Malus = decimal.Parse(((TextBox)FormView1.FindControl("MalusTextBox")).Text);
            decimal Bonus = 0;
            decimal Descontos = 0;
            decimal dValorSegurar = decimal.Parse(((TextBox)FormView1.FindControl("ValorSegurarTextBox")).Text);
            

            if (((TextBox)FormView1.FindControl("ClienteRCTextBox")).Text == string.Empty)
                Descontos = 0;
            else
                Descontos = decimal.Parse(((TextBox)FormView1.FindControl("ClienteRCTextBox")).Text);
            
               
            return GetSimulacao(iTipoSeguro, iOpcao, iLugares, CodigoTipoVeiculo, iCodigoCategoria, ConfigKeyParcelamento, ConfigKeyIdadeCondutor, ConfigKeyExperienciaCondutor, ConfigKeyAnosVeiculo, 0, 0, Descontos, dValorSegurar);
        }

        //protected void OpcaoOcupantesComboBox_SelectedIndexChanged(object sender, EventArgs e)
        //{
        //    if (((DropDownList)FormView1.FindControl("OpcaoOcupantesComboBox")).SelectedValue == "")
        //    {
        //        ((TextBox)FormView1.FindControl("MIPDescTextBox")).Text = "";
        //        ((TextBox)FormView1.FindControl("DTDescTextBox")).Text = "";
        //        ((TextBox)FormView1.FindControl("DFDescTextBox")).Text = "";

        //        ((TextBox)FormView1.FindControl("MIPValorTextBox")).Text = "";
        //        ((TextBox)FormView1.FindControl("DTValorTextBox")).Text = "";
        //        ((TextBox)FormView1.FindControl("DFValorTextBox")).Text = "";
        //    }
        //    else
        //    {
        //        ((TextBox)FormView1.FindControl("MIPDescTextBox")).Text = "MIP";
        //        ((TextBox)FormView1.FindControl("DTDescTextBox")).Text = "DT";
        //        ((TextBox)FormView1.FindControl("DFDescTextBox")).Text = "DF";

        //        ((TextBox)FormView1.FindControl("MIPValorTextBox")).Text = dictDetalheOpcao [((DropDownList)FormView1.FindControl("OpcaoOcupantesComboBox")).SelectedValue + "MIP"].ToString() ;

        //        ((TextBox)FormView1.FindControl("DTValorTextBox")).Text = dictDetalheOpcao[((DropDownList)FormView1.FindControl("OpcaoOcupantesComboBox")).SelectedValue + "DT"].ToString();
        //        ((TextBox)FormView1.FindControl("DFValorTextBox")).Text = dictDetalheOpcao[((DropDownList)FormView1.FindControl("OpcaoOcupantesComboBox")).SelectedValue + "DF"].ToString();
        //    }

        //}

        public void  SimularAT(string sNumeroProposta)
        {
            //Colocar os valores de Premios Fixos na ComboBox
            //CategoriaComboBox_DataBound(null, null);


            string htmlString = string.Empty;
            string headerUrl = Server.MapPath("~/files/header.html");
            string footerUrl = Server.MapPath("~/files/footer.html");

            string sRespCivil = "";
            string sOcupantes = "";
            string sMorteInvalidez = "";
            string sDespesasTratamento = "";
            string sDespesasFuneral = "";
            string sChoqueColisao = "";
            string sFurtoRoubo = "";
            string sIncendioRaio = "";
            //Franquia
            string sRespCivilFranquia = "";
            string sOcupantesFranquia = "";
            string sMorteInvalidezFRanquia = "";
            string sDespesasTratamentoFranquia = "";
            string sDespesasFuneralFranquia = "";
            string sChoqueColisaoFranquia = "";
            string sFurtoRouboFranquia = "";
            string sIncendioRaioFranquia = "";
            string sDataFim = Comum.General.GetAddTime(((DropDownList)FormView1.FindControl("CobrancaFraccionamentoComboBox")).SelectedValue, ((TextBox)FormView1.FindControl("DataInicioTextBox")).Text);
            string pdf_page_size = "A4";
            Dictionary<string, string> dicSimulacao = new Dictionary<string, string>();

            dicSimulacao = GetSimulacao();

            PdfPageSize pageSize = (PdfPageSize)Enum.Parse(typeof(PdfPageSize),
                pdf_page_size, true);

            string pdf_orientation = "Portrait";
            PdfPageOrientation pdfOrientation =
                (PdfPageOrientation)Enum.Parse(typeof(PdfPageOrientation),
                pdf_orientation, true);


            // instantiate a html to pdf converter object
            HtmlToPdf converter = new HtmlToPdf();

            // set converter options
            converter.Options.PdfPageSize = pageSize;
            converter.Options.PdfPageOrientation = pdfOrientation;

            converter.Options.DisplayHeader = true;
            converter.Options.DisplayFooter = true;

            converter.Options.MarginLeft = 0;

            converter.Header.Height = 60;
            converter.Footer.Height = 50;

            PdfHtmlSection headerHtml = new PdfHtmlSection(headerUrl);

            converter.Header.Add(headerHtml);

            PdfHtmlSection footerHtml = new PdfHtmlSection(footerUrl);
            footerHtml.AutoFitHeight = HtmlToPdfPageFitMode.AutoFit;
            converter.Footer.Add(footerHtml);

            //htmlString = Comum.General.getHTMLTabelaSimulacao(((TextBox)FormView1.FindControl("NomeTextBox")).Text, ((DropDownList)FormView1.FindControl("TipoSeguroComboBox")).SelectedItem.Text, ((TextBox)FormView1.FindControl("MoradaTextBox")).Text, Comum.General.VALOR_NULO, ((DropDownList)FormView1.FindControl("ProvinciaIDComboBox")).SelectedItem.Text, sNumeroProposta, ((DropDownList)FormView1.FindControl("BrokerComboBox")).SelectedItem.Text, ((DropDownList)FormView1.FindControl("QualidadeComboBox")).SelectedItem.Text, ((DropDownList)FormView1.FindControl("CobrancaFraccionamentoComboBox")).SelectedItem.Text, ((DropDownList)FormView1.FindControl("MarcaComboBox")).SelectedItem.Text, ((DropDownList)FormView1.FindControl("ModeloComboBox")).SelectedItem.Text, ((TextBox)FormView1.FindControl("DataInicioTextBox")).Text, sDataFim, ((TextBox)FormView1.FindControl("MatriculaTextBox")).Text, ((TextBox)FormView1.FindControl("CilindradaTextBox")).Text, ((TextBox)FormView1.FindControl("LugaresTextBox")).Text, ((DropDownList)FormView1.FindControl("UsoComboBox")).SelectedItem.Text, ((TextBox)FormView1.FindControl("ChassiTextBox")).Text);

            PdfDocument doc = converter.ConvertHtmlString(htmlString);

            // save pdf document
            doc.Save(Response, false, string.Format(@"{0}.pdf", DateTime.Now.Ticks));

            // close pdf document
            doc.Close();
        }

        protected void SimularButton_Click(object sender, EventArgs e)
        {
            SimularAT(Comum.General.VALOR_NULO);
            string script = "window.open(" + "'Uploads/" + UrlDocument + "','Simulação')";
            ClientScript.RegisterClientScriptBlock(this.GetType(), "NewWindowSimulacao", script, true);
        }

        protected void ConverterButton_Click(object sender, EventArgs e)
        {
        }
       
        //protected void CategoriaComboBox_DataBound(object sender, EventArgs e)
        //{
        //    System.Data.DataTable dt = new System.Data.DataTable();
        //    System.Data.DataView dv = (System.Data.DataView)SqlDataSourceCategoria.Select(DataSourceSelectArguments.Empty);

        //    dt = dv.ToTable();

        //    foreach (System.Data.DataRow row in dt.Rows)
        //    {
        //        ((DropDownList)FormView1.FindControl("CategoriaComboBox")).Items.FindByValue(row[0].ToString()).Attributes.Add("valor", row[2].ToString());
        //        ((DropDownList)FormView1.FindControl("CategoriaComboBox")).Items.FindByValue(row[0].ToString()).Attributes.Add("ocupantes", row[3].ToString());
        //        ((DropDownList)FormView1.FindControl("CategoriaComboBox")).Items.FindByValue(row[0].ToString()).Attributes.Add("danosproprios", row[4].ToString());
        //    }
        //}

        protected void CategoriaComboBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            //CategoriaComboBox_DataBound(null, null);
            string Ocupantes = string.Empty;
            string DanosProprios = string.Empty;

            ((DropDownList)FormView1.FindControl("TipoCategoriaComboBox")).Items.Clear();
            ((DropDownList)FormView1.FindControl("TipoCategoriaComboBox")).DataBind();

            // --- OCUPANTES ---
            Ocupantes = ((DropDownList)FormView1.FindControl("CategoriaComboBox")).SelectedItem.Attributes["ocupantes"].ToString();
          
            if (Ocupantes=="0")
            {
                ((DropDownList)FormView1.FindControl("OpcaoOcupantesComboBox")).SelectedIndex = -1;
                ((DropDownList)FormView1.FindControl("OpcaoOcupantesComboBox")).Enabled = false;
                ((DropDownList)FormView1.FindControl("OpcaoOcupantesComboBox")).BackColor = System.Drawing.Color.FromArgb(235,235,228);

                ((TextBox)FormView1.FindControl("MIPDescTextBox")).Text = "";
                ((TextBox)FormView1.FindControl("DTDescTextBox")).Text = "";
                ((TextBox)FormView1.FindControl("DFDescTextBox")).Text = "";

                ((TextBox)FormView1.FindControl("MIPValorTextBox")).Text = "";
                ((TextBox)FormView1.FindControl("DTValorTextBox")).Text = "";
                ((TextBox)FormView1.FindControl("DFValorTextBox")).Text = "";

                ((TextBox)FormView1.FindControl("MIPDescTextBox")).Enabled = false;
                ((TextBox)FormView1.FindControl("DTDescTextBox")).Enabled = false;
                ((TextBox)FormView1.FindControl("DFDescTextBox")).Enabled = false;

                ((TextBox)FormView1.FindControl("MIPValorTextBox")).Enabled = false;
                ((TextBox)FormView1.FindControl("DTValorTextBox")).Enabled = false;
                ((TextBox)FormView1.FindControl("DFValorTextBox")).Enabled = false;

             
            }
            else
            {
                ((DropDownList)FormView1.FindControl("OpcaoOcupantesComboBox")).Enabled = true;
                ((DropDownList)FormView1.FindControl("OpcaoOcupantesComboBox")).BackColor = System.Drawing.Color.White;

                ((TextBox)FormView1.FindControl("MIPDescTextBox")).Enabled = true;
                ((TextBox)FormView1.FindControl("DTDescTextBox")).Enabled = true;
                ((TextBox)FormView1.FindControl("DFDescTextBox")).Enabled = true;

                ((TextBox)FormView1.FindControl("MIPValorTextBox")).Enabled = true;
                ((TextBox)FormView1.FindControl("DTValorTextBox")).Enabled = true;
                ((TextBox)FormView1.FindControl("DFValorTextBox")).Enabled = true;
            }

            // --- DANOS PRÓRPIOS ---
            bool bDataFabricoEmpty = false;
            double dDifDataFabrico = 0;

            
            bDataFabricoEmpty = (((TextBox)FormView1.FindControl("DataFabricoTextBox")).Text == string.Empty);

            if (!bDataFabricoEmpty)
            {
                dDifDataFabrico = Comum.General.DifferenceTotalYears(DateTime.Parse(((TextBox)FormView1.FindControl("DataFabricoTextBox")).Text), DateTime.Now);
            }

            DanosProprios = ((DropDownList)FormView1.FindControl("CategoriaComboBox")).SelectedItem.Attributes["danosproprios"].ToString();

            //Se a diferença entre anos for superior a 5 anos ou na tabela master_categoria estiver DanosProprios=0 então "DANOS PROPRIOS NAO DISPONIVEL"
           
            if ((bDataFabricoEmpty = true && DanosProprios == "0") || (dDifDataFabrico > 5 || DanosProprios == "0"))
            {
                    ((TextBox)FormView1.FindControl("ValorNovoTextBox")).Enabled = false;
                    ((TextBox)FormView1.FindControl("ValorSegurarTextBox")).Enabled = false;
                    ((TextBox)FormView1.FindControl("FranquiaTextBox")).Enabled = false;
                }
            else
            {
                    ((TextBox)FormView1.FindControl("ValorNovoTextBox")).Enabled = true;
                    ((TextBox)FormView1.FindControl("ValorSegurarTextBox")).Enabled = true;
                    ((TextBox)FormView1.FindControl("FranquiaTextBox")).Enabled = true;
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

        protected void GridViewCliente_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            if (e.NewPageIndex == -1)
            {
                btnPesquisar_Click(null, null);

            }
            else
                GridViewCliente.PageIndex = e.NewPageIndex;


            ClientScript.RegisterStartupScript(GetType(), "showCliente", "showCliente();", true);

            //lientScript.RegisterStartupScript(GetType(), "SetAfterValues", "SetAfterValues();", true);

        }

        protected void btnPesquisar_Click(object sender, EventArgs e)
        {
            try
            {
                GridViewCliente.DataBind();
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message, ex);
            }
        }

        protected void ActividadePredominanteComboBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            ActividadePredominanteComboBox_DataBound(null, null);
            string TaxaSimples = string.Empty;
            TaxaSimples = ((DropDownList)FormView1.FindControl("ActividadePredominanteComboBox")).SelectedItem.Attributes["taxa"].ToString();
            ((TextBox)FormView1.FindControl("TaxaSimplesTextBox")).Text = TaxaSimples;
        }

        protected void ActividadePredominanteComboBox_DataBound(object sender, EventArgs e)
        {
            System.Data.DataTable dt = new System.Data.DataTable();
            System.Data.DataView dv = (System.Data.DataView)SqlDataSourceCAE.Select(DataSourceSelectArguments.Empty);

            dt = dv.ToTable();

            foreach (System.Data.DataRow row in dt.Rows)
            {
                ((DropDownList)FormView1.FindControl("ActividadePredominanteComboBox")).Items.FindByValue(row[0].ToString()).Attributes.Add("taxa", row[3].ToString());
                ((DropDownList)FormView1.FindControl("ActividadePredominanteComboBox")).Items.FindByValue(row[0].ToString()).Attributes.Add("tipotaxa", row[4].ToString());
                ((DropDownList)FormView1.FindControl("ActividadePredominanteComboBox")).Items.FindByValue(row[0].ToString()).Attributes.Add("valor", row[5].ToString());
            }
        }

        private string CalculaTaxaFinal()
        {

            return "";
        }
    }

}