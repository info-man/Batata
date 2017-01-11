using MASTERSEGUROS.WEB.Comum;
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
    public partial class ConsultarApolice : System.Web.UI.Page
    {
        public Dictionary<System.String, System.Decimal> dictDetalheOpcao = new Dictionary<System.String, System.Decimal>();
        public string sMessage = string.Empty;
        public string sProposta = string.Empty;
        public bool FlagControl = false;


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!User.Identity.IsAuthenticated)
               Response.Redirect("~/Account/Login.aspx");

             initialize();

            if (!IsPostBack)
                Session["Proposta"] = string.Empty;

            //if (sProposta != string.Empty && sProposta != General.VALOR_NULO)
            //{
            //    ((Button)FormView1.FindControl("ConverterButton")).Text = "OK OK";
            //    SimularAuto(sProposta);
            //}
            // InitializeFormView();

                // Session["tab"] = "RibbonTabMilitantes";
                //if (((TextBox)FormView1.FindControl("PropostaID")).Text != "")
                //{
                //    ((Button)FormView1.FindControl("ConverterButton")).Visible = true;
                //}

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

            if (e.Exception == null)
            {
                // Page.ClientScript.RegisterStartupScript(this.GetType(),
                //"ShowMessageCreate", string.Format("<script type='text/javascript'>MessageBoxCAPCriado('');</script>", ""));
                //((TextBox)FormView1.FindControl("PropostaID")).Text = e.Command.Parameters["@PropostaID"].Value.ToString(); 
                sProposta =  Comum.General.FormataProposta(e.Command.Parameters["@PropostaID"].Value.ToString(), "AUTO");
                General.UpdateNumeroProposta(e.Command.Parameters["@PropostaID"].Value.ToString(), sProposta, "AUTO");
                Session["Proposta"] = e.Command.Parameters["@PropostaID"].Value.ToString();
                SimularAuto(sProposta);
            }
            else
            {
                //ClientMessageBox.Show("ATENÇÃOB: Ocorreu a gravar os dados.\nContacte o administrador de sistemas.\n" + e.Exception.ToString(), this);
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
            SqlDataReader rdr = null;

            using (SqlConnection con = new SqlConnection(MASTERSEGUROS.WEB.Comum.General.getConnection()))
            {
                //Fill all Periods/Years
                using (SqlCommand cmd = new SqlCommand("SELECT * FROM [master_opcao_ocupante_detalhe]", con))
                {
                    cmd.CommandType = CommandType.Text;

                    con.Open();
                    rdr = cmd.ExecuteReader();

                    while (rdr.Read())
                    {
                        dictDetalheOpcao.Add(rdr["OpcaoOcupantesID"].ToString() + (string)rdr["DescricaoCurta"], (decimal)rdr["Valor"]);
                    }

                    rdr.Close();
                    con.Close();
                }
            }

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

        protected void SqlDataSourcePropostaAuto_Inserting(object sender, SqlDataSourceCommandEventArgs e)
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
                    cid = (int)cmd.ExecuteScalar();
                    con.Close();
                }
            }
            return cid;
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
            decimal Bonus;
            decimal Descontos = 0;
            decimal dValorSegurar = decimal.Parse(((TextBox)FormView1.FindControl("ValorSegurarTextBox")).Text);

            Bonus = 0;

            if (((TextBox)FormView1.FindControl("ClienteRCTextBox")).Text == string.Empty)
                Descontos = 0;
            else
                Descontos = decimal.Parse(((TextBox)FormView1.FindControl("ClienteRCTextBox")).Text);
            
               
            return GetSimulacao(iTipoSeguro, iOpcao, iLugares, CodigoTipoVeiculo, iCodigoCategoria, ConfigKeyParcelamento, ConfigKeyIdadeCondutor, ConfigKeyExperienciaCondutor, ConfigKeyAnosVeiculo, 0, 0, Descontos, dValorSegurar);
        }

        protected void OpcaoOcupantesComboBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (((DropDownList)FormView1.FindControl("OpcaoOcupantesComboBox")).SelectedValue == "")
            {
                ((TextBox)FormView1.FindControl("MIPDescTextBox")).Text = "";
                ((TextBox)FormView1.FindControl("DTDescTextBox")).Text = "";
                ((TextBox)FormView1.FindControl("DFDescTextBox")).Text = "";

                ((TextBox)FormView1.FindControl("MIPValorTextBox")).Text = "";
                ((TextBox)FormView1.FindControl("DTValorTextBox")).Text = "";
                ((TextBox)FormView1.FindControl("DFValorTextBox")).Text = "";
            }
            else
            {
                ((TextBox)FormView1.FindControl("MIPDescTextBox")).Text = "MIP";
                ((TextBox)FormView1.FindControl("DTDescTextBox")).Text = "DT";
                ((TextBox)FormView1.FindControl("DFDescTextBox")).Text = "DF";

                ((TextBox)FormView1.FindControl("MIPValorTextBox")).Text = dictDetalheOpcao [((DropDownList)FormView1.FindControl("OpcaoOcupantesComboBox")).SelectedValue + "MIP"].ToString() ;

                ((TextBox)FormView1.FindControl("DTValorTextBox")).Text = dictDetalheOpcao[((DropDownList)FormView1.FindControl("OpcaoOcupantesComboBox")).SelectedValue + "DT"].ToString();
                ((TextBox)FormView1.FindControl("DFValorTextBox")).Text = dictDetalheOpcao[((DropDownList)FormView1.FindControl("OpcaoOcupantesComboBox")).SelectedValue + "DF"].ToString();
            }

        }

        public void  SimularAuto(string sNumeroProposta)
        {
            //Colocar os valores de Premios Fixos na ComboBox
            CategoriaComboBox_DataBound(null, null);


            string htmlString = string.Empty;
            string headerUrl = Server.MapPath("~/files/header.html");
            string footerUrl = Server.MapPath("~/files/footer.html");

            string sRespCivil = Comum.General.FormataNumero(GetRespCivil());
            string sOcupantes = Comum.General.FormataNumero(GetOcupantes());
            string sMorteInvalidez = Comum.General.FormataNumero(GetMorteInvalidez());
            string sDespesasTratamento = Comum.General.FormataNumero(GetDespesasTratamento());
            string sDespesasFuneral = Comum.General.FormataNumero(GetDespesasFuneral());
            string sChoqueColisao = Comum.General.FormataNumero(GetChoqueColisao());
            string sFurtoRoubo = Comum.General.FormataNumero(GetFurtoRoubo());
            string sIncendioRaio = Comum.General.FormataNumero(GetIncendioRaio());
            //Franquia
            string sRespCivilFranquia = Comum.General.FormataNumero(GetRespCivilFranquia());
            string sOcupantesFranquia = Comum.General.FormataNumero(GetOcupantesFranquia());
            string sMorteInvalidezFRanquia = Comum.General.VALOR_NULO;
            string sDespesasTratamentoFranquia = Comum.General.VALOR_NULO;
            string sDespesasFuneralFranquia = Comum.General.VALOR_NULO;
            string sChoqueColisaoFranquia = Comum.General.FormataNumero(GetChoqueColisaoFranquia());
            string sFurtoRouboFranquia = Comum.General.FormataNumero(GetFurtoRouboFranquia());
            string sIncendioRaioFranquia = Comum.General.FormataNumero(GetIncendioRaioFranquia());
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

            htmlString = Comum.General.getHTMLTabelaProposta(((TextBox)FormView1.FindControl("NomeTextBox")).Text, ((DropDownList)FormView1.FindControl("TipoSeguroComboBox")).SelectedItem.Text, ((TextBox)FormView1.FindControl("MoradaTextBox")).Text, Comum.General.VALOR_NULO, ((DropDownList)FormView1.FindControl("ProvinciaIDComboBox")).SelectedItem.Text, sNumeroProposta, ((DropDownList)FormView1.FindControl("BrokerComboBox")).SelectedItem.Text, ((DropDownList)FormView1.FindControl("QualidadeComboBox")).SelectedItem.Text, ((DropDownList)FormView1.FindControl("CobrancaFraccionamentoComboBox")).SelectedItem.Text, ((DropDownList)FormView1.FindControl("MarcaComboBox")).SelectedItem.Text, ((DropDownList)FormView1.FindControl("ModeloComboBox")).SelectedItem.Text, ((TextBox)FormView1.FindControl("DataInicioTextBox")).Text, sDataFim, ((TextBox)FormView1.FindControl("MatriculaTextBox")).Text, ((TextBox)FormView1.FindControl("CilindradaTextBox")).Text, ((TextBox)FormView1.FindControl("LugaresTextBox")).Text, ((DropDownList)FormView1.FindControl("UsoComboBox")).SelectedItem.Text, ((TextBox)FormView1.FindControl("ChassiTextBox")).Text, sRespCivil, sOcupantes, sMorteInvalidez, sDespesasTratamento, sDespesasFuneral, sChoqueColisao, sFurtoRoubo, sIncendioRaio, sRespCivilFranquia, sOcupantesFranquia, sMorteInvalidezFRanquia, sDespesasTratamentoFranquia, sDespesasFuneralFranquia, sChoqueColisaoFranquia, sFurtoRouboFranquia, sIncendioRaioFranquia, dicSimulacao);

            PdfDocument doc = converter.ConvertHtmlString(htmlString);

            

            // save pdf document
            if (sNumeroProposta== Comum.General.VALOR_NULO)
                doc.Save(Response, false, string.Format(@"{0}.pdf", DateTime.Now.Ticks));
            else
                doc.Save(Response, false, string.Format(@"{0}.pdf", sNumeroProposta));
            //doc.Save(Response, false, string.Format(@"{0}.pdf", sNumeroProposta));
            // close pdf document
            doc.Close();
        }
            
        protected void SimularButton_Click(object sender, EventArgs e)
        {
            SimularAuto(Comum.General.VALOR_NULO);

            ((Button)FormView1.FindControl("ConverterButton")).Visible = true;
        }

        protected void ConverterButton_Click(object sender, EventArgs e)
        {
           
        }
       
        protected void CategoriaComboBox_DataBound(object sender, EventArgs e)
        {
            System.Data.DataTable dt = new System.Data.DataTable();
            System.Data.DataView dv = (System.Data.DataView)SqlDataSourceCategoria.Select(DataSourceSelectArguments.Empty);

            dt = dv.ToTable();

            foreach (System.Data.DataRow row in dt.Rows)
            {
                ((DropDownList)FormView1.FindControl("CategoriaComboBox")).Items.FindByValue(row[0].ToString()).Attributes.Add("valor", row[2].ToString());
                ((DropDownList)FormView1.FindControl("CategoriaComboBox")).Items.FindByValue(row[0].ToString()).Attributes.Add("ocupantes", row[3].ToString());
                ((DropDownList)FormView1.FindControl("CategoriaComboBox")).Items.FindByValue(row[0].ToString()).Attributes.Add("danosproprios", row[4].ToString());
            }
        }

        protected void CategoriaComboBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            CategoriaComboBox_DataBound(null, null);
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
       
        private string GetRespCivil()
        {
            if (((DropDownList)FormView1.FindControl("TipoSeguroComboBox")).SelectedValue == "1")
                return GetRespCivilBase();
            else if (((DropDownList)FormView1.FindControl("TipoSeguroComboBox")).SelectedValue == "2")
                return GetRespCivilResponsavel();
            else if (((DropDownList)FormView1.FindControl("TipoSeguroComboBox")).SelectedValue == "3")
                return GetRespCivilTranquilo();
            else if (((DropDownList)FormView1.FindControl("TipoSeguroComboBox")).SelectedValue == "4")
                return GetRespCivilInteligente();
            else
                return Comum.General.VALOR_NULO;
        }

        private string GetRespCivilBase()
        {
            return ((DropDownList)FormView1.FindControl("CategoriaComboBox")).SelectedItem.Attributes["Valor"].ToString();
        }

        private string GetRespCivilResponsavel()
        {
            if (((DropDownList)FormView1.FindControl("OpcaoOcupantesComboBox")).SelectedValue == "")
                return Comum.General.VALOR_NULO;
            else
                return ((DropDownList)FormView1.FindControl("CategoriaComboBox")).SelectedItem.Attributes["Valor"].ToString();
            
        }

        private string GetRespCivilTranquilo()
        {
           
            if (((TextBox)FormView1.FindControl("ValorNovoTextBox")).Enabled)
                return ((DropDownList)FormView1.FindControl("CategoriaComboBox")).SelectedItem.Attributes["Valor"].ToString();
            else
                return "----------";
        }

        private string GetRespCivilInteligente()
        {
            string Ocupantes = ((DropDownList)FormView1.FindControl("CategoriaComboBox")).SelectedItem.Attributes["ocupantes"].ToString();
            if ((Ocupantes == "1") && (((TextBox)FormView1.FindControl("ValorNovoTextBox")).Enabled))
                return ((DropDownList)FormView1.FindControl("CategoriaComboBox")).SelectedItem.Attributes["Valor"].ToString();
            else
                return Comum.General.VALOR_NULO;

        }

        private string GetRespCivilFranquia()
        {
            return "Sem Franquia";
        }
        
        private string GetOcupantes()
        {
            if (((DropDownList)FormView1.FindControl("TipoSeguroComboBox")).SelectedValue == "1")
                return Comum.General.VALOR_NULO; 
            else if (((DropDownList)FormView1.FindControl("TipoSeguroComboBox")).SelectedValue == "2")
                return GetOcupantesResponsavel();
            else if (((DropDownList)FormView1.FindControl("TipoSeguroComboBox")).SelectedValue == "3")
                return GetOcupantesTranquilo();
            else if (((DropDownList)FormView1.FindControl("TipoSeguroComboBox")).SelectedValue == "4")
                return GetOcupantesInteligente();
            else
                return Comum.General.VALOR_NULO;
        }

        private string GetOcupantesResponsavel()
        {
            if (((DropDownList)FormView1.FindControl("OpcaoOcupantesComboBox")).SelectedValue == "")
                return  Comum.General.VALOR_NULO;
            else
                return ((DropDownList)FormView1.FindControl("OpcaoOcupantesComboBox")).SelectedItem.Text;
        }
       
        private string GetOcupantesTranquilo()
        {
            if (GetRespCivilTranquilo() == Comum.General.VALOR_NULO)
                return Comum.General.VALOR_NULO;
            else
                return ((DropDownList)FormView1.FindControl("OpcaoOcupantesComboBox")).SelectedItem.Text;
        }

        private string GetOcupantesInteligente()
        {
            if (GetRespCivilInteligente()== Comum.General.VALOR_NULO)
                return Comum.General.VALOR_NULO;
            else
                return GetOcupantesResponsavel();
        }

        private string GetOcupantesFranquia()
        {
            if (GetOcupantesInteligente() == "Sem Franquia")
                return "Capital Seguro";
            else
                return Comum.General.VALOR_NULO;
        }

        private string GetMorteInvalidez()
        {
            if (((DropDownList)FormView1.FindControl("TipoSeguroComboBox")).SelectedValue == "1")
                return Comum.General.VALOR_NULO;
            else if (((DropDownList)FormView1.FindControl("TipoSeguroComboBox")).SelectedValue == "2")
                return (((TextBox)FormView1.FindControl("MIPValorTextBox")).Text == string.Empty ? Comum.General.VALOR_NULO : ((TextBox)FormView1.FindControl("MIPValorTextBox")).Text);
            else if (((DropDownList)FormView1.FindControl("TipoSeguroComboBox")).SelectedValue == "3")
                return (((TextBox)FormView1.FindControl("MIPValorTextBox")).Text == string.Empty ? Comum.General.VALOR_NULO : ((TextBox)FormView1.FindControl("MIPValorTextBox")).Text);
            else if (((DropDownList)FormView1.FindControl("TipoSeguroComboBox")).SelectedValue == "4")
                return (((TextBox)FormView1.FindControl("MIPValorTextBox")).Text == string.Empty ? Comum.General.VALOR_NULO : ((TextBox)FormView1.FindControl("MIPValorTextBox")).Text);
            else
                return Comum.General.VALOR_NULO;
        }

        private string GetDespesasTratamento()
        {
            if (((DropDownList)FormView1.FindControl("TipoSeguroComboBox")).SelectedValue == "1")
                return Comum.General.VALOR_NULO;
            else if (((DropDownList)FormView1.FindControl("TipoSeguroComboBox")).SelectedValue == "2")
                return (((TextBox)FormView1.FindControl("DTValorTextBox")).Text == string.Empty ? Comum.General.VALOR_NULO : ((TextBox)FormView1.FindControl("DTValorTextBox")).Text);
            else if (((DropDownList)FormView1.FindControl("TipoSeguroComboBox")).SelectedValue == "3")
                return (((TextBox)FormView1.FindControl("DTValorTextBox")).Text == string.Empty ? Comum.General.VALOR_NULO : ((TextBox)FormView1.FindControl("DTValorTextBox")).Text);
            else if (((DropDownList)FormView1.FindControl("TipoSeguroComboBox")).SelectedValue == "4")
                return (((TextBox)FormView1.FindControl("DTValorTextBox")).Text == string.Empty ? Comum.General.VALOR_NULO : ((TextBox)FormView1.FindControl("DTValorTextBox")).Text);
            else
                return Comum.General.VALOR_NULO;
        }

        private string GetDespesasFuneral()
        {
            if (((DropDownList)FormView1.FindControl("TipoSeguroComboBox")).SelectedValue == "1")
                return Comum.General.VALOR_NULO;
            else if (((DropDownList)FormView1.FindControl("TipoSeguroComboBox")).SelectedValue == "2")
                return (((TextBox)FormView1.FindControl("DFValorTextBox")).Text == string.Empty ? Comum.General.VALOR_NULO : ((TextBox)FormView1.FindControl("DFValorTextBox")).Text);
            else if (((DropDownList)FormView1.FindControl("TipoSeguroComboBox")).SelectedValue == "3")
                return (((TextBox)FormView1.FindControl("DFValorTextBox")).Text == string.Empty ? Comum.General.VALOR_NULO : ((TextBox)FormView1.FindControl("DFValorTextBox")).Text);
            else if (((DropDownList)FormView1.FindControl("TipoSeguroComboBox")).SelectedValue == "4")
                return (((TextBox)FormView1.FindControl("DFValorTextBox")).Text == string.Empty ? Comum.General.VALOR_NULO : ((TextBox)FormView1.FindControl("DFValorTextBox")).Text);
            else
                return Comum.General.VALOR_NULO;
        }
        
        private string GetChoqueColisao()
        {
            if (((DropDownList)FormView1.FindControl("TipoSeguroComboBox")).SelectedValue == "1")
                return Comum.General.VALOR_NULO;
            else if (((DropDownList)FormView1.FindControl("TipoSeguroComboBox")).SelectedValue == "2")
                return Comum.General.VALOR_NULO;
            else if (((DropDownList)FormView1.FindControl("TipoSeguroComboBox")).SelectedValue == "3")
                return GetChoqueColisaoTranquilo();
            else if (((DropDownList)FormView1.FindControl("TipoSeguroComboBox")).SelectedValue == "4")
                return GetChoqueColisaoInteligente();
            else
                return Comum.General.VALOR_NULO;
        }

        private string GetChoqueColisaoTranquilo()
        {
            //(((TextBox)FormView1.FindControl("ValorNovoTextBox")).Enabled=false? Comum.General.VALOR_NULO: ((TextBox)FormView1.FindControl("ValorNovoTextBox")).Text
            if (!((TextBox)FormView1.FindControl("ValorNovoTextBox")).Enabled || !((TextBox)FormView1.FindControl("ValorSegurarTextBox")).Enabled)
            {
                return Comum.General.VALOR_NULO;
            }
            else
            {
                if (((TextBox)FormView1.FindControl("ValorNovoTextBox")).Text == "0" || ((TextBox)FormView1.FindControl("ValorNovoTextBox")).Text == string.Empty)
                    return Comum.General.VALOR_NULO;
                else
                    return ((TextBox)FormView1.FindControl("ValorSegurarTextBox")).Text; 
            }
        }

        private string GetChoqueColisaoInteligente()
        {
            string TempRespCivilInteligente = GetRespCivilInteligente();
            if (TempRespCivilInteligente == Comum.General.VALOR_NULO)
            {
                return Comum.General.VALOR_NULO;
            }
            else
                return GetChoqueColisaoTranquilo();
        }

        private string GetChoqueColisaoFranquia()
        {

            if (GetChoqueColisaoTranquilo() == Comum.General.VALOR_NULO)
            {
                return Comum.General.VALOR_NULO;
            }
            else
            {
                if (((TextBox)FormView1.FindControl("ValorSegurarTextBox")).Text != string.Empty && ((TextBox)FormView1.FindControl("FranquiaTextBox")).Text != string.Empty)
                    return (Double.Parse(((TextBox)FormView1.FindControl("ValorSegurarTextBox")).Text) * Double.Parse(((TextBox)FormView1.FindControl("FranquiaTextBox")).Text)).ToString();
                else
                    return Comum.General.VALOR_NULO;
            }
        }

        private string GetFurtoRoubo()
        {
            if (((DropDownList)FormView1.FindControl("TipoSeguroComboBox")).SelectedValue == "1")
                return Comum.General.VALOR_NULO;
            else if (((DropDownList)FormView1.FindControl("TipoSeguroComboBox")).SelectedValue == "2")
                return Comum.General.VALOR_NULO;
            else if (((DropDownList)FormView1.FindControl("TipoSeguroComboBox")).SelectedValue == "3")
                return GetFurtoRouboTranquilo();
            else if (((DropDownList)FormView1.FindControl("TipoSeguroComboBox")).SelectedValue == "4")
                return GetFurtoRouboInteligente();
            else
                return Comum.General.VALOR_NULO;
        }

        private string GetFurtoRouboTranquilo()
        {
            //(((TextBox)FormView1.FindControl("ValorNovoTextBox")).Enabled=false? Comum.General.VALOR_NULO: ((TextBox)FormView1.FindControl("ValorNovoTextBox")).Text
            if (!((TextBox)FormView1.FindControl("ValorNovoTextBox")).Enabled || !((TextBox)FormView1.FindControl("ValorSegurarTextBox")).Enabled)
            {
                return Comum.General.VALOR_NULO;
            }
            else
            {
                if (((TextBox)FormView1.FindControl("ValorNovoTextBox")).Text == "0" || ((TextBox)FormView1.FindControl("ValorNovoTextBox")).Text == string.Empty)
                    return Comum.General.VALOR_NULO;
                else
                    return ((TextBox)FormView1.FindControl("ValorSegurarTextBox")).Text;
            }
        }

        private string GetFurtoRouboInteligente()
        {
            string TempRespCivilInteligente = GetRespCivilInteligente();
            if (TempRespCivilInteligente == Comum.General.VALOR_NULO)
            {
                return Comum.General.VALOR_NULO;
            }
            else
                return GetFurtoRouboTranquilo();
        }

        private string GetFurtoRouboFranquia()
        {

            if (GetFurtoRouboTranquilo() == Comum.General.VALOR_NULO)
            {
                return Comum.General.VALOR_NULO;
            }
            else
            {
                if (((TextBox)FormView1.FindControl("ValorSegurarTextBox")).Text != string.Empty && ((TextBox)FormView1.FindControl("FranquiaTextBox")).Text != string.Empty)
                    return (Double.Parse(((TextBox)FormView1.FindControl("ValorSegurarTextBox")).Text) * Double.Parse(((TextBox)FormView1.FindControl("FranquiaTextBox")).Text)).ToString();
                else
                    return Comum.General.VALOR_NULO;
            }
        }

        private string GetIncendioRaio()
        {
            if (((DropDownList)FormView1.FindControl("TipoSeguroComboBox")).SelectedValue == "1")
                return Comum.General.VALOR_NULO;
            else if (((DropDownList)FormView1.FindControl("TipoSeguroComboBox")).SelectedValue == "2")
                return Comum.General.VALOR_NULO;
            else if (((DropDownList)FormView1.FindControl("TipoSeguroComboBox")).SelectedValue == "3")
                return GetIncendioRaioTranquilo();
            else if (((DropDownList)FormView1.FindControl("TipoSeguroComboBox")).SelectedValue == "4")
                return GetIncendioRaioInteligente();
            else
                return Comum.General.VALOR_NULO;
        }

        private string GetIncendioRaioTranquilo()
        {
            //(((TextBox)FormView1.FindControl("ValorNovoTextBox")).Enabled=false? Comum.General.VALOR_NULO: ((TextBox)FormView1.FindControl("ValorNovoTextBox")).Text
            if (!((TextBox)FormView1.FindControl("ValorNovoTextBox")).Enabled || !((TextBox)FormView1.FindControl("ValorSegurarTextBox")).Enabled)
            {
                return Comum.General.VALOR_NULO;
            }
            else
            {
                if (((TextBox)FormView1.FindControl("ValorNovoTextBox")).Text == "0" || ((TextBox)FormView1.FindControl("ValorNovoTextBox")).Text == string.Empty)
                    return Comum.General.VALOR_NULO;
                else
                    return ((TextBox)FormView1.FindControl("ValorSegurarTextBox")).Text;
            }
        }

        private string GetIncendioRaioInteligente()
        {
            string TempRespCivilInteligente = GetRespCivilInteligente();
            if (TempRespCivilInteligente == Comum.General.VALOR_NULO)
            {
                return Comum.General.VALOR_NULO;
            }
            else
                return GetIncendioRaioTranquilo();
        }

        private string GetIncendioRaioFranquia()
        {

            if (GetIncendioRaioTranquilo() == Comum.General.VALOR_NULO)
            {
                return Comum.General.VALOR_NULO;
            }
            else
            {
                if (((TextBox)FormView1.FindControl("ValorSegurarTextBox")).Text != string.Empty && ((TextBox)FormView1.FindControl("FranquiaTextBox")).Text != string.Empty)
                    return (Double.Parse(((TextBox)FormView1.FindControl("ValorSegurarTextBox")).Text) * Double.Parse(((TextBox)FormView1.FindControl("FranquiaTextBox")).Text)).ToString();
                else
                    return Comum.General.VALOR_NULO;
            }
        }

        protected void SimularButtonGravar_Click(object sender, EventArgs e)
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
                //ScriptManager.RegisterStartupScript(((UpdatePanel)FormView1.FindControl("UpdatePanel4")), ((UpdatePanel)FormView1.FindControl("UpdatePanel4")).GetType(), "ShowMessageConverterApolice", "MessageBoxEmptyConverterApolice('')", true);
            }
            else
            {
                Dictionary<string, string> dicDadosApolice = new Dictionary<string, string>();
                dicDadosApolice = GetDadosApolice("21"); //HARD CODED
                Page.ClientScript.RegisterStartupScript(this.GetType(), "ShowMessageBoxResultado", string.Format("<script type='text/javascript'>MessageBoxResultado('" + dicDadosApolice["NumeroApolice"] + "','" + dicDadosApolice["ClienteID"]  +  "');</script>", ""));
                //ScriptManager.RegisterStartupScript(((UpdatePanel)FormView1.FindControl("UpdatePanel4")), ((UpdatePanel)FormView1.FindControl("UpdatePanel4")).GetType(), "ShowMessageBoxResultado", "MessageBoxResultado('" + "A Proposta <strong>" + Session["Proposta"].ToString() + "</strong> foi convertida na apólice <strong>" + dicDadosApolice["NumeroApolice"] + "</strong> associado ao cliente <strong>" + dicDadosApolice["NumeroApolice"] + "</strong>.')", true);
            }
           


        }

        public static Dictionary<string, string> GetDadosApolice(string sProposta)
        {
            SqlDataReader rdr = null;
            String sRetValue = string.Empty;
            Dictionary<string, string> dicDadosApolice = new Dictionary<string, string>();

            using (SqlConnection con = new SqlConnection(Comum.General.getConnection()))
            {
                con.Open();

                SqlCommand sqlCommand = new SqlCommand("spConvertePropostaApoliceAuto", con);

                sqlCommand.CommandType = CommandType.StoredProcedure;

                SqlParameter paramPropostaID = sqlCommand.Parameters.Add("@PropostaID", SqlDbType.Int);

                paramPropostaID.Value = sProposta;

                rdr = sqlCommand.ExecuteReader();

                while (rdr.Read())
                {
                    dicDadosApolice.Add("NumeroApolice", rdr["NumeroApolice"].ToString());
                    dicDadosApolice.Add("ClienteID", rdr["ClienteID"].ToString());
                }

                con.Close();
            }

            return dicDadosApolice;

        }

    }



}