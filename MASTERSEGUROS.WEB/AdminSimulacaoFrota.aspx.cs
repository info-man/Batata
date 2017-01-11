using MASTERSEGUROS.WEB.Comum;
using SelectPdf;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.OleDb;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Security;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Winthusiasm.HtmlEditor;
using NPOI.SS.UserModel;

namespace MASTERSEGUROS.WEB
{
    public partial class AdminSimulacaoFrota : System.Web.UI.Page
    {
        public Dictionary<System.String, System.Decimal> dictDetalheOpcao = new Dictionary<System.String, System.Decimal>();
        public Dictionary<System.Int32, System.String> dictProvincia = new Dictionary<System.Int32, System.String>();
        public Dictionary<System.Int32, System.String> dictMarca = new Dictionary<System.Int32, System.String>();
        public Dictionary<System.Int32, System.String> dictModelo = new Dictionary<System.Int32, System.String>();
        public Dictionary<System.String, System.String> dictTipoCategoria = new Dictionary<System.String, System.String>();

        public string sMessage = string.Empty;
        public string sProposta = string.Empty;
        public bool FlagControl = false;
        public string UrlDocument = string.Empty;
       
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!User.Identity.IsAuthenticated)
               Response.Redirect("~/Account/Login.aspx");

            initialize();
            InitializeFormView();

            if (IsPostBack && ((FileUpload)FormView1.FindControl("FileUpload1")).HasFile)
            {
                foreach (BaseValidator val in Page.Validators)
                {
                    
                        val.Enabled = false;
                    
                }


                string FileName = Path.GetFileName(((FileUpload)FormView1.FindControl("FileUpload1")).PostedFile.FileName);
                string Extension = Path.GetExtension(((FileUpload)FormView1.FindControl("FileUpload1")).PostedFile.FileName);
                string FolderPath = ConfigurationManager.AppSettings["FolderPath"];

                string FilePath = Server.MapPath(FolderPath + FileName);
                ((FileUpload)FormView1.FindControl("FileUpload1")).SaveAs(FilePath);

                Import_To_GridV2(FilePath, Extension, "True");

                FlagControl = true;

                ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "InitializeAcordion_3", "SetInitializeAcordion_3();", true);

            }


            if (!IsPostBack)
                Session["Proposta"] = string.Empty;

           

        }

        protected void Page_LoadComplete(object sender, EventArgs e)
        {
            foreach (BaseValidator val in Page.Validators)
            {
                val.Enabled = true;
            }

            if (((TextBox)FormView1.FindControl("DataInicioTextBox")).Text.Length == 10)
            {
                ((TextBox)FormView1.FindControl("DataInicioTextBox")).Text = ((TextBox)FormView1.FindControl("DataInicioTextBox")).Text.Substring(3, 2) + "/" + ((TextBox)FormView1.FindControl("DataInicioTextBox")).Text.Substring(0, 2) + "/" + ((TextBox)FormView1.FindControl("DataInicioTextBox")).Text.Substring(6, 4);
            }



            if (((TextBox)FormView1.FindControl("DataFabricoTextBox")).Text.Length == 10)
            {
                ((TextBox)FormView1.FindControl("DataFabricoTextBox")).Text = ((TextBox)FormView1.FindControl("DataFabricoTextBox")).Text.Substring(3, 2) + "/" + ((TextBox)FormView1.FindControl("DataFabricoTextBox")).Text.Substring(0, 2) + "/" + ((TextBox)FormView1.FindControl("DataFabricoTextBox")).Text.Substring(6, 4);
            }
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
            string script = string.Empty;
            string script2 = string.Empty;

            if (e.Exception == null)
            {
                sProposta =  Comum.General.FormataProposta(e.Command.Parameters["@PropostaID"].Value.ToString(), "AUTO");

                General.UpdateNumeroProposta(e.Command.Parameters["@PropostaID"].Value.ToString(), sProposta, "AUTO");

                Session["Proposta"] = e.Command.Parameters["@PropostaID"].Value.ToString();

                //CriaPropostaAutoFrota(e.Command.Parameters["@PropostaID"].Value.ToString());

                PropostaAutoFrota(sProposta);
                
                script = "window.open(" + "'Uploads/" + string.Format(@"{0}.pdf", sProposta) + "','Proposta');";
                script2 = "location.href = 'AdminSimulacaoFrotaUpdate.aspx?prpID=" + e.Command.Parameters["@PropostaID"].Value.ToString() + "';";

                ClientScript.RegisterClientScriptBlock(this.GetType(), "NewWindowSimulacaoFrota", script, true);
                ClientScript.RegisterClientScriptBlock(this.GetType(), "RedirectSameWindow", script2, true);
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
            //PROVINCIA
            DataView dviewProvincia = (DataView)SqlDataSourceProvincia.Select(DataSourceSelectArguments.Empty);

            foreach (DataRow row in dviewProvincia.Table.Rows)
            {
                dictProvincia.Add((Int32)row[0], (String)row[1]);
            }

            //MARCA
            DataView dviewMarca = (DataView)MarcaDatasource.Select(DataSourceSelectArguments.Empty);

            foreach (DataRow row in dviewMarca.Table.Rows)
            {
                dictMarca.Add((Int32)row[0], (String)row[1]);
            }

            //MODELO
            DataView dviewModelo = (DataView)ModeloAllDatasource.Select(DataSourceSelectArguments.Empty);

            foreach (DataRow row in dviewModelo.Table.Rows)
            {
                dictModelo.Add((Int32)row[0], (String)row[2]);
            }

            //TipoCategoria
            DataView dviewTipoCategoria = (DataView)SqlDataSourceAllTipoCategoria.Select(DataSourceSelectArguments.Empty);

            foreach (DataRow row in dviewTipoCategoria.Table.Rows)
            {
                dictTipoCategoria.Add((String)row[0], (String)row[2]);
            }




            //SqlDataSourceAllTipoCategoria
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
            string prpID = string.Empty;
            prpID = Request.QueryString["prpID"];

            if (prpID != null)
            {
                FormView1.ChangeMode(FormViewMode.Edit);

                //Seleccionar o registo correcto
                if (!IsPostBack)
                {
                    SqlDataSourcePropostaAutoFrota.SelectParameters["PropostaID"].DefaultValue = prpID;

                    FormView1.DataBind();
                    ((DropDownList)FormView1.FindControl("ProvinciaIDComboBox")).SelectedValue = ((System.Data.DataRowView)(FormView1.DataItem)).Row["ProvinciaID"].ToString();
                    //((DropDownList)FormView1.FindControl("MunicipioIDComboBox")).SelectedValue = ((System.Data.DataRowView)(FormView1.DataItem)).Row["MunicipioID"].ToString();
                    //((DropDownList)FormView1.FindControl("ComunaIDComboBox")).SelectedValue = ((System.Data.DataRowView)(FormView1.DataItem)).Row["ComunaID"].ToString();

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

        }

        protected void On_Inserting(object sender, SqlDataSourceCommandEventArgs e)
        {
            e.Command.Parameters["@UserIDCriacao"].Value = Membership.GetUser().ProviderUserKey.ToString();
            e.Command.Parameters["@DataCriacao"].Value = DateTime.Now;
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
        
        protected void ClienteComboBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (((DropDownList)sender).SelectedValue=="2")
            {
                ScriptManager.RegisterClientScriptBlock(this, GetType(), "showCliente", "showCliente();", true);
                ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "InitializeAcordion_1", "SetInitializeAcordion_1();", true);
            }

        }

        protected void MarcaComboBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            ((DropDownList)FormView1.FindControl("ModeloComboBox")).Items.Clear();
            ((DropDownList)FormView1.FindControl("ModeloComboBox")).DataBind();
            //ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "IniatializeSetAcordion", "SetAcordion(2);", true);
            ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "InitializeAcordion_3", "SetInitializeAcordion_3();", true);
        }
  
        public static Dictionary<string, string> GetSimulacao(int Opcao, int Lugares, string CodigoTipoVeiculo, int CodigoCategoria, string ConfigKeyIdadeCondutor, string ConfigKeyExperienciaCondutor, string ConfigKeyAnosVeiculo, decimal Malus, decimal Bonus, decimal Descontos, decimal ValorSegurar)
        {
            SqlDataReader rdr = null;
            String sRetValue = string.Empty;
            Dictionary<string, string> dicSimulacao = new Dictionary<string, string>();

            using (SqlConnection con = new SqlConnection(Comum.General.getConnection()))
            {
                con.Open();

                SqlCommand sqlCommand = new SqlCommand("spCalculaPremioSimulacao", con);

                sqlCommand.CommandType = CommandType.StoredProcedure;

              
                SqlParameter paramOpcaoID = sqlCommand.Parameters.Add("@OpcaoID", SqlDbType.Int);
                SqlParameter paramNrLugares = sqlCommand.Parameters.Add("@NrLugares", SqlDbType.Int);
                SqlParameter paramCodigoTipoVeiculo = sqlCommand.Parameters.Add("@CodigoTipoVeiculo", SqlDbType.VarChar);
                SqlParameter paramCodigoCategoria = sqlCommand.Parameters.Add("@CodigoCategoria", SqlDbType.Int);
                SqlParameter paramConfigKeyIdadeCondutor = sqlCommand.Parameters.Add("@ConfigKeyIdadeCondutor", SqlDbType.VarChar);
                SqlParameter paramConfigKeyExperienciaCondutor = sqlCommand.Parameters.Add("@ConfigKeyExperienciaCondutor", SqlDbType.VarChar);
                SqlParameter paramConfigKeyAnosVeiculo = sqlCommand.Parameters.Add("@ConfigKeyAnosVeiculo", SqlDbType.VarChar);
                SqlParameter paramMalus = sqlCommand.Parameters.Add("@Malus", SqlDbType.Decimal);
                SqlParameter paramBonus = sqlCommand.Parameters.Add("@Bonus", SqlDbType.Decimal);
                SqlParameter paramDescontos = sqlCommand.Parameters.Add("@Descontos", SqlDbType.Decimal);
                SqlParameter paramValorSegurar = sqlCommand.Parameters.Add("@ValorSegurar", SqlDbType.Decimal);

              
                paramOpcaoID.Value = Opcao;
                paramNrLugares.Value = Lugares;
                paramCodigoTipoVeiculo.Value = CodigoTipoVeiculo;
                paramCodigoCategoria.Value = CodigoCategoria;
               
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
                    dicSimulacao.Add("BASE_ANUAL", rdr["BASE_ANUAL"].ToString());
                    dicSimulacao.Add("BASE_SEMESTRAL", rdr["BASE_SEMESTRAL"].ToString());
                    dicSimulacao.Add("BASE_TRIMESTRAL", rdr["BASE_TRIMESTRAL"].ToString());
                    dicSimulacao.Add("RESPONSAVEL_ANUAL", rdr["RESPONSAVEL_ANUAL"].ToString());
                    dicSimulacao.Add("RESPONSAVEL_SEMESTRAL", rdr["RESPONSAVEL_SEMESTRAL"].ToString());
                    dicSimulacao.Add("RESPONSAVEL_TRIMESTRAL", rdr["RESPONSAVEL_TRIMESTRAL"].ToString());
                    dicSimulacao.Add("TRANQUILO_ANUAL", rdr["TRANQUILO_ANUAL"].ToString());
                    dicSimulacao.Add("TRANQUILO_SEMESTRAL", rdr["TRANQUILO_SEMESTRAL"].ToString());
                    dicSimulacao.Add("TRANQUILO_TRIMESTRAL", rdr["TRANQUILO_TRIMESTRAL"].ToString());
                    dicSimulacao.Add("INTELIGENTE_ANUAL", rdr["INTELIGENTE_ANUAL"].ToString());
                    dicSimulacao.Add("INTELIGENTE_SEMESTRAL", rdr["INTELIGENTE_SEMESTRAL"].ToString());
                    dicSimulacao.Add("INTELIGENTE_TRIMESTRAL", rdr["INTELIGENTE_TRIMESTRAL"].ToString());
                }

                con.Close();
            }

            return dicSimulacao;

        }

        public Dictionary<string, string> GetSimulacao()
        {
            Dictionary<string, string> dicSimulacao = new Dictionary<string, string>();
            Dictionary<string, string> dicSimulacaoTemp = new Dictionary<string, string>();



            if (ViewState["dt"] != null)
            {
                foreach (DataRow row in ((DataTable)ViewState["dt"]).Rows)
                {
                    //new DataColumn("DataFabrico"), new DataColumn("Cilindrada"), new DataColumn("Chassi"), new DataColumn("Lugares"), new DataColumn("UsoID"), new DataColumn("RCCliente"), new DataColumn("DPCliente"), new DataColumn("CategoriaID"), new DataColumn("TipoCategoriaID"), new DataColumn("OpcaoOcupantesID"), new DataColumn("ValorNovo"), new DataColumn("ValorSegurar"), new DataColumn("Franquia") });

                    int iOpcao = (row["OpcaoOcupantesID"].ToString() == string.Empty ? 0 : int.Parse(row["OpcaoOcupantesID"].ToString()));
                    int iLugares = int.Parse(row["Lugares"].ToString());
                    string CodigoTipoVeiculo = row["TipoCategoriaID"].ToString();
                    int iCodigoCategoria = int.Parse(row["CategoriaID"].ToString());
                    string ConfigKeyIdadeCondutor = General.IDADE_MAIS_25_MENOS_60; //IDADE_MENOS_25 | IDADE_MAIS_60 | IDADE_MAIS_25_MENOS_60
                    string ConfigKeyExperienciaCondutor = Comum.General.ANOS_EXPERIENCIA_MAIS_2;
                    string ConfigKeyAnosVeiculo = Comum.General.getKeyAnosVeiculo(Comum.General.getAge(DateTime.Parse(row["DataFabrico"].ToString())).ToString());

                    //decimal Malus = decimal.Parse(((TextBox)FormView1.FindControl("MalusTextBox")).Text);
                    decimal Bonus = 0;
                    decimal Descontos = 0;
                    decimal dValorSegurar = (row["ValorSegurar"].ToString() == string.Empty ? 0 : decimal.Parse(row["ValorSegurar"].ToString()));

                    if (row["RCCliente"].ToString() == string.Empty)
                    { Descontos = 0; }
                    else
                    { Descontos = decimal.Parse(row["RCCliente"].ToString()); }

                    dicSimulacaoTemp = GetSimulacao(iOpcao, iLugares, CodigoTipoVeiculo, iCodigoCategoria, ConfigKeyIdadeCondutor, ConfigKeyExperienciaCondutor, ConfigKeyAnosVeiculo, 0, 0, Descontos, dValorSegurar);

                    if (dicSimulacao.Count == 0)
                    {
                        dicSimulacao = dicSimulacaoTemp;
                    }
                    else
                    {
                        dicSimulacao["BASE_ANUAL"] = (decimal.Parse(dicSimulacao["BASE_ANUAL"]) + decimal.Parse(dicSimulacaoTemp["BASE_ANUAL"])).ToString();
                        dicSimulacao["BASE_SEMESTRAL"] = (decimal.Parse(dicSimulacao["BASE_SEMESTRAL"]) + decimal.Parse(dicSimulacaoTemp["BASE_SEMESTRAL"])).ToString();
                        dicSimulacao["BASE_TRIMESTRAL"] = (decimal.Parse(dicSimulacao["BASE_TRIMESTRAL"]) + decimal.Parse(dicSimulacaoTemp["BASE_TRIMESTRAL"])).ToString();
                        dicSimulacao["RESPONSAVEL_ANUAL"] = (decimal.Parse(dicSimulacao["RESPONSAVEL_ANUAL"]) + decimal.Parse(dicSimulacaoTemp["RESPONSAVEL_ANUAL"])).ToString();
                        dicSimulacao["RESPONSAVEL_SEMESTRAL"] = (decimal.Parse(dicSimulacao["RESPONSAVEL_SEMESTRAL"]) + decimal.Parse(dicSimulacaoTemp["RESPONSAVEL_SEMESTRAL"])).ToString();
                        dicSimulacao["RESPONSAVEL_TRIMESTRAL"] = (decimal.Parse(dicSimulacao["RESPONSAVEL_TRIMESTRAL"]) + decimal.Parse(dicSimulacaoTemp["RESPONSAVEL_TRIMESTRAL"])).ToString();
                        dicSimulacao["TRANQUILO_ANUAL"] = (decimal.Parse(dicSimulacao["TRANQUILO_ANUAL"]) + decimal.Parse(dicSimulacaoTemp["TRANQUILO_ANUAL"])).ToString();
                        dicSimulacao["TRANQUILO_SEMESTRAL"] = (decimal.Parse(dicSimulacao["TRANQUILO_SEMESTRAL"]) + decimal.Parse(dicSimulacaoTemp["TRANQUILO_SEMESTRAL"])).ToString();
                        dicSimulacao["TRANQUILO_TRIMESTRAL"] = (decimal.Parse(dicSimulacao["TRANQUILO_TRIMESTRAL"]) + decimal.Parse(dicSimulacaoTemp["TRANQUILO_TRIMESTRAL"])).ToString();
                        dicSimulacao["INTELIGENTE_ANUAL"] = (decimal.Parse(dicSimulacao["INTELIGENTE_ANUAL"]) + decimal.Parse(dicSimulacaoTemp["INTELIGENTE_ANUAL"])).ToString();
                        dicSimulacao["INTELIGENTE_SEMESTRAL"] = (decimal.Parse(dicSimulacao["INTELIGENTE_SEMESTRAL"]) + decimal.Parse(dicSimulacaoTemp["INTELIGENTE_SEMESTRAL"])).ToString();
                        dicSimulacao["INTELIGENTE_TRIMESTRAL"] = (decimal.Parse(dicSimulacao["INTELIGENTE_TRIMESTRAL"]) + decimal.Parse(dicSimulacaoTemp["INTELIGENTE_TRIMESTRAL"])).ToString();
                    }

                }
            }
            return dicSimulacao;
        
            //return GetSimulacao(iOpcao, iLugares, CodigoTipoVeiculo, iCodigoCategoria, ConfigKeyIdadeCondutor, ConfigKeyExperienciaCondutor, ConfigKeyAnosVeiculo, 0, 0, Descontos, dValorSegurar);
        }

        public static Dictionary<string, string> GetProposta(int TipoSeguro, int Opcao, int Lugares, string CodigoTipoVeiculo, int CodigoCategoria, string ConfigKeyParcelamento, string ConfigKeyIdadeCondutor, string ConfigKeyExperienciaCondutor, string ConfigKeyAnosVeiculo, decimal Malus, decimal Bonus, decimal Descontos, decimal ValorSegurar)
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
                paramOpcaoID.Value = Opcao;
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

                    dicSimulacao.Add("PremioSimplesAnual", rdr["PremioSimplesAnual"].ToString());
                    dicSimulacao.Add("EncargosAnual", rdr["EncargosAnual"].ToString());
                    dicSimulacao.Add("ArsegAnual", rdr["ArsegAnual"].ToString());
                    dicSimulacao.Add("FungaAnual", rdr["FungaAnual"].ToString());
                    dicSimulacao.Add("ValorOpcaoExtraAnual", rdr["ValorOpcaoExtraAnual"].ToString());
                    dicSimulacao.Add("PremioTotalAnual", rdr["PremioTotalAnual"].ToString());
                }

                con.Close();
            }

            return dicSimulacao;

        }

        public Dictionary<string, string> GetProposta()
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
            decimal dValorSegurar = (((TextBox)FormView1.FindControl("ValorSegurarTextBox")).Text == string.Empty?0: decimal.Parse(((TextBox)FormView1.FindControl("ValorSegurarTextBox")).Text));
                        
            if (((TextBox)FormView1.FindControl("ClienteRCTextBox")).Text == string.Empty)
                Descontos = 0;
            else
                Descontos = decimal.Parse(((TextBox)FormView1.FindControl("ClienteRCTextBox")).Text);
            
               
            return GetProposta(iTipoSeguro, iOpcao, iLugares, CodigoTipoVeiculo, iCodigoCategoria, ConfigKeyParcelamento, ConfigKeyIdadeCondutor, ConfigKeyExperienciaCondutor, ConfigKeyAnosVeiculo, 0, 0, Descontos, dValorSegurar);
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

        public void PropostaAutoFrota(string sNumeroProposta)
        {
            //Colocar os valores de Premios Fixos na ComboBox
            CategoriaComboBox_DataBound(null, null);


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
            string sMorteInvalidezFranquia = "";
            string sDespesasTratamentoFranquia = "";
            string sDespesasFuneralFranquia = "";
            string sChoqueColisaoFranquia = "";
            string sFurtoRouboFranquia = "";
            string sIncendioRaioFranquia = "";
            string sDataFim = Comum.General.GetAddTime(((DropDownList)FormView1.FindControl("CobrancaFraccionamentoComboBox")).SelectedValue, ((TextBox)FormView1.FindControl("DataInicioTextBox")).Text);
            string pdf_page_size = "A4";

            Dictionary<string, string> dicProposta = new Dictionary<string, string>();
            Dictionary<string, string> dicPropostaTemp = new Dictionary<string, string>();

            for (int i = ((DataTable)ViewState["dt"]).Rows.Count - 1; i >= 0; i--)
            {
                DataRow dr = ((DataTable)ViewState["dt"]).Rows[i];

                sRespCivil = Comum.General.FormataNumero(GetRespCivil(dr));
                sOcupantes = Comum.General.FormataNumero(GetOcupantes(dr));
                sMorteInvalidez = Comum.General.FormataNumero(GetMorteInvalidez(dr));
                sDespesasTratamento = Comum.General.FormataNumero(GetDespesasTratamento(dr));
                sDespesasFuneral = Comum.General.FormataNumero(GetDespesasFuneral(dr));
                sChoqueColisao =Comum.General.FormataNumero(GetChoqueColisao(dr));
                sFurtoRoubo = Comum.General.FormataNumero(GetFurtoRoubo(dr));
                sIncendioRaio = Comum.General.FormataNumero(GetIncendioRaio(dr));
                //Franquia
                sRespCivilFranquia = Comum.General.FormataNumero(GetRespCivilFranquia(dr));
                sOcupantesFranquia = Comum.General.FormataNumero(GetOcupantesFranquia(dr));
                sMorteInvalidezFranquia = Comum.General.VALOR_NULO;
                sDespesasTratamentoFranquia = Comum.General.VALOR_NULO;
                sDespesasFuneralFranquia = Comum.General.VALOR_NULO;
                sChoqueColisaoFranquia = Comum.General.FormataNumero(GetChoqueColisaoFranquia(dr));
                sFurtoRouboFranquia = Comum.General.FormataNumero(GetFurtoRouboFranquia(dr));
                sIncendioRaioFranquia = Comum.General.FormataNumero(GetIncendioRaioFranquia(dr));

                string CodigoTipoVeiculo = dr["TipoCategoriaID"].ToString();
                int iCodigoCategoria = int.Parse(dr["CategoriaID"].ToString());
                string ConfigKeyParcelamento = ((DropDownList)FormView1.FindControl("CobrancaFraccionamentoComboBox")).SelectedValue.ToString();
                string ConfigKeyIdadeCondutor = General.IDADE_MAIS_25_MENOS_60;
                string ConfigKeyExperienciaCondutor = General.ANOS_EXPERIENCIA_MAIS_2;
                string ConfigKeyAnosVeiculo = General.getKeyAnosVeiculo("1");
                int iTipoSeguro = int.Parse(dr["TipoSeguroID"].ToString());
                int iOpcao = (dr["OpcaoOcupantesID"].ToString() == string.Empty ? 0 : int.Parse(dr["OpcaoOcupantesID"].ToString()));
                int iLugares = int.Parse(dr["Lugares"].ToString());
                //decimal Malus = decimal.Parse(((TextBox)FormView1.FindControl("MalusTextBox")).Text);
                decimal Bonus = 0;
                decimal Descontos = 0;
                decimal dValorSegurar = (dr["ValorSegurar"].ToString() == string.Empty ? 0 : decimal.Parse(dr["ValorSegurar"].ToString()));

                if (dr["RCCliente"].ToString() == string.Empty)
                    Descontos = 0;
                else
                    Descontos = decimal.Parse(dr["RCCliente"].ToString());


                dicProposta = GetProposta(iTipoSeguro, iOpcao, iLugares, CodigoTipoVeiculo, iCodigoCategoria, ConfigKeyParcelamento, ConfigKeyIdadeCondutor, ConfigKeyExperienciaCondutor, ConfigKeyAnosVeiculo, 0, 0, Descontos, dValorSegurar);

                General.CreatePropostaFrota(Session["Proposta"].ToString(), dr["Matricula"].ToString(), dr["MarcaID"].ToString(), dr["ModeloID"].ToString(), DateTime.Parse(dr["DataFabrico"].ToString()), dr["Cilindrada"].ToString(), dr["Chassi"].ToString(), dr["Lugares"].ToString(), dr["UsoID"].ToString(), dr["RCCliente"].ToString(), dr["DPCliente"].ToString(), dr["CategoriaID"].ToString(), dr["TipoCategoriaID"].ToString(), dr["TipoSeguroID"].ToString(), dr["OpcaoOcupantesID"].ToString(), dr["ValorNovo"].ToString(), dr["ValorSegurar"].ToString(), dr["Franquia"].ToString(), Membership.GetUser().ProviderUserKey.ToString(), DateTime.Now, sRespCivil, sOcupantes, sMorteInvalidez, sDespesasTratamento, sDespesasFuneral, sChoqueColisao, sFurtoRoubo, sIncendioRaio, sRespCivilFranquia, sOcupantesFranquia, sMorteInvalidezFranquia, sDespesasTratamentoFranquia, sDespesasFuneralFranquia, sChoqueColisaoFranquia, sFurtoRouboFranquia, sIncendioRaioFranquia,  dicProposta["PremioSimples"], dicProposta["Encargos"], dicProposta["Arseg"], dicProposta["Funga"], dicProposta["IncrementoApolice"], dicProposta["ValorOpcaoExtra"], dicProposta["PremioTotal"]);

                //Cálculo dos totais do Prémio
                if (dicPropostaTemp.Count == 0)
                {
                    dicPropostaTemp = dicProposta;
                }
                else
                {
                    //dicProposta["ValorOpcaoExtra"], dicProposta["PremioSimples"], dicProposta["Encargos"], dicProposta["Arseg"], dicProposta["Funga"], dicProposta["IncrementoApolice"], dicProposta["PremioTotal"]);
                    dicPropostaTemp["ValorOpcaoExtra"] = (decimal.Parse(dicPropostaTemp["ValorOpcaoExtra"]) + decimal.Parse(dicProposta["ValorOpcaoExtra"])).ToString();
                    dicPropostaTemp["PremioSimples"] = (decimal.Parse(dicPropostaTemp["PremioSimples"]) + decimal.Parse(dicProposta["PremioSimples"])).ToString();
                    dicPropostaTemp["Encargos"] = (decimal.Parse(dicPropostaTemp["Encargos"]) + decimal.Parse(dicProposta["Encargos"])).ToString();
                    dicPropostaTemp["Arseg"] = (decimal.Parse(dicPropostaTemp["Arseg"]) + decimal.Parse(dicProposta["Arseg"])).ToString();
                    dicPropostaTemp["Funga"] = (decimal.Parse(dicPropostaTemp["Funga"]) + decimal.Parse(dicProposta["Funga"])).ToString();
                    dicPropostaTemp["IncrementoApolice"] = (decimal.Parse(dicPropostaTemp["IncrementoApolice"]) + decimal.Parse(dicProposta["IncrementoApolice"])).ToString();
                    dicPropostaTemp["PremioTotal"] = (decimal.Parse(dicPropostaTemp["PremioTotal"]) + decimal.Parse(dicProposta["PremioTotal"])).ToString();
                }

            }

            General.UpdatePremioProposta(Session["Proposta"].ToString(), "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", dicPropostaTemp["ValorOpcaoExtra"], dicPropostaTemp["PremioSimples"], dicPropostaTemp["Encargos"], dicPropostaTemp["Arseg"], dicPropostaTemp["Funga"], dicPropostaTemp["IncrementoApolice"], dicPropostaTemp["PremioTotal"]);

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

            htmlString = Comum.General.getHTMLTabelaPropostaFrota(((TextBox)FormView1.FindControl("NomeTextBox")).Text, ((DropDownList)FormView1.FindControl("TipoSeguroComboBox")).SelectedItem.Text, ((TextBox)FormView1.FindControl("MoradaTextBox")).Text, Comum.General.VALOR_NULO, ((DropDownList)FormView1.FindControl("ProvinciaIDComboBox")).SelectedItem.Text, sNumeroProposta, ((DropDownList)FormView1.FindControl("BrokerComboBox")).SelectedItem.Text, ((DropDownList)FormView1.FindControl("QualidadeComboBox")).SelectedItem.Text, ((DropDownList)FormView1.FindControl("CobrancaFraccionamentoComboBox")).SelectedItem.Text, "Lista", "Anexa", ((TextBox)FormView1.FindControl("DataInicioTextBox")).Text, sDataFim, General.VALOR_NULO, General.VALOR_NULO, General.VALOR_NULO, General.VALOR_NULO, General.VALOR_NULO, sRespCivil, sOcupantes, sMorteInvalidez, sDespesasTratamento, sDespesasFuneral, sChoqueColisao, sFurtoRoubo, sIncendioRaio, sRespCivilFranquia, sOcupantesFranquia, sMorteInvalidezFranquia, sDespesasTratamentoFranquia, sDespesasFuneralFranquia, sChoqueColisaoFranquia, sFurtoRouboFranquia, sIncendioRaioFranquia, dicPropostaTemp);

            PdfDocument doc = converter.ConvertHtmlString(htmlString);

            doc.Save(Server.MapPath("Uploads") + "\\" + string.Format(@"{0}.pdf", sNumeroProposta));

            doc.Close();
        }

        public void SimulacaoAuto(string sNumeroProposta)
        {
            //Colocar os valores de Premios Fixos na ComboBox
            CategoriaComboBox_DataBound(null, null);

            string htmlString = string.Empty;
            string headerUrl = Server.MapPath("~/files/header.html");
            string footerUrl = Server.MapPath("~/files/footer.html");

            string sDataFim = string.Empty;
            string pdf_page_size = "A4";
            Dictionary<string, string> dicSimulacao = new Dictionary<string, string>();


            if (((DropDownList)FormView1.FindControl("CobrancaFraccionamentoComboBox")).SelectedValue !=string.Empty && ((TextBox)FormView1.FindControl("DataInicioTextBox")).Text != string.Empty)
            {
                sDataFim = General.GetAddTime(((DropDownList)FormView1.FindControl("CobrancaFraccionamentoComboBox")).SelectedValue, ((TextBox)FormView1.FindControl("DataInicioTextBox")).Text);
            }

            
            dicSimulacao = GetSimulacao();

            //General.UpdatePremioProposta(Session["Proposta"].ToString(), sRespCivil, sOcupantes, sMorteInvalidez, sDespesasTratamento, sDespesasFuneral, sChoqueColisao, sFurtoRoubo, sIncendioRaio, sRespCivilFranquia, sOcupantesFranquia, sMorteInvalidezFranquia, sDespesasTratamentoFranquia, sDespesasFuneralFranquia, sChoqueColisaoFranquia, sFurtoRouboFranquia, sIncendioRaioFranquia, dicSimulacao["ValorOpcaoExtra"], dicSimulacao["PremioSimples"], dicSimulacao["Encargos"], dicSimulacao["Arseg"], dicSimulacao["Funga"], dicSimulacao["IncrementoApolice"], dicSimulacao["PremioTotal"]);

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

            htmlString = Comum.General.getHTMLTabelaSimulacaoFrota(((TextBox)FormView1.FindControl("NomeTextBox")).Text, ((DropDownList)FormView1.FindControl("TipoSeguroComboBox")).SelectedItem.Text, ((TextBox)FormView1.FindControl("MoradaTextBox")).Text, Comum.General.VALOR_NULO, ((DropDownList)FormView1.FindControl("ProvinciaIDComboBox")).SelectedItem.Text, sNumeroProposta, ((DropDownList)FormView1.FindControl("BrokerComboBox")).SelectedItem.Text, ((DropDownList)FormView1.FindControl("QualidadeComboBox")).SelectedItem.Text, ((DropDownList)FormView1.FindControl("CobrancaFraccionamentoComboBox")).SelectedItem.Text, "Lista anexa", "", General.VALOR_NULO, sDataFim, General.VALOR_NULO, General.VALOR_NULO, General.VALOR_NULO, General.VALOR_NULO, General.VALOR_NULO, dicSimulacao);

            PdfDocument doc = converter.ConvertHtmlString(htmlString);
            UrlDocument = General.getLoggedUser() + "_" + DateTime.Now.Ticks + ".pdf";
            doc.Save(Server.MapPath("Uploads") + "\\" + UrlDocument);

            //doc.Save(Response, false, string.Format(@"{0}.pdf", DateTime.Now.Ticks));
            
            doc.Close();
        }

        protected void SimularButton_Click(object sender, EventArgs e)
        {
           SimulacaoAuto(Comum.General.VALOR_NULO);
           string script = "window.open(" + "'Uploads/"  + UrlDocument + "','Simulação')";
           ClientScript.RegisterClientScriptBlock(this.GetType(), "NewWindowSimulacao", script, true);
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
       
        private string GetRespCivil(DataRow dr)
        {
            //dr["TipoSeguroID"] = ((DropDownList)FormView1.FindControl("TipoSeguroComboBox")).SelectedValue;
            if (dr["TipoSeguroID"].ToString() == "1")
                return GetRespCivilBase(dr);
            else if (dr["TipoSeguroID"].ToString() == "2")
                return GetRespCivilResponsavel(dr);
            else if (dr["TipoSeguroID"].ToString() == "3")
                return GetRespCivilTranquilo(dr);
            else if (dr["TipoSeguroID"].ToString() == "4")
                return GetRespCivilInteligente(dr);
            else
                return Comum.General.VALOR_NULO;
        }

        private string GetRespCivilBase(DataRow dr)
        {
            return (dr["CategoriaValor"].ToString());
        }

        private string GetRespCivilResponsavel(DataRow dr)
        {
            
            if (dr["OpcaoOcupantesID"].ToString() == "")
                return Comum.General.VALOR_NULO;
            else
                return dr["CategoriaValor"].ToString();
            
        }

        private string GetRespCivilTranquilo(DataRow dr)
        {
           
            if (dr["ValorNovo"].ToString() =="")
                return dr["CategoriaValor"].ToString();
            else
                return General.VALOR_NULO;
        }

        private string GetRespCivilInteligente(DataRow dr)
        {
            string Ocupantes = dr["CategoriaOcupantes"].ToString();
            if ((Ocupantes == "1") && (dr["ValorNovo"].ToString()==""))
                return dr["CategoriaValor"].ToString();
            else
                return Comum.General.VALOR_NULO;

        }

        private string GetRespCivilFranquia(DataRow dr)
        {
            return "Sem Franquia";
        }
        
        private string GetOcupantes(DataRow dr)
        {
            if (dr["TipoSeguroID"].ToString() == "1")
                return GetOcupantesBase(dr); 
            else if (dr["TipoSeguroID"].ToString() == "2")
                return GetOcupantesResponsavel(dr);
            else if (dr["TipoSeguroID"].ToString() == "3")
                return GetOcupantesTranquilo(dr);
            else if (dr["TipoSeguroID"].ToString() == "4")
                return GetOcupantesInteligente(dr);
            else
                return Comum.General.VALOR_NULO;
        }

        private string GetOcupantesBase(DataRow dr)
        {
            return Comum.General.VALOR_NULO;
        }

        private string GetOcupantesResponsavel(DataRow dr)
        {
            if (dr["OpcaoOcupantesID"].ToString() == "")
                return  Comum.General.VALOR_NULO;
            else
                return dr["OpcaoOcupantes"].ToString();
        }
       
        private string GetOcupantesTranquilo(DataRow dr)
        {
            if (GetRespCivilTranquilo(dr) == Comum.General.VALOR_NULO)
                return Comum.General.VALOR_NULO;
            else if (dr["OpcaoOcupantesID"].ToString() == "")
                return Comum.General.VALOR_NULO;
            else
            return dr["OpcaoOcupantes"].ToString();
        }

        private string GetOcupantesInteligente(DataRow dr)
        {
            if (GetRespCivilInteligente(dr)== Comum.General.VALOR_NULO)
                return Comum.General.VALOR_NULO;
            else
                return GetOcupantesResponsavel(dr);
        }

        private string GetOcupantesFranquia(DataRow dr)
        {
            if (GetOcupantesInteligente(dr) == "Sem Franquia")
                return "Capital Seguro";
            else
                return Comum.General.VALOR_NULO;
        }

        private string GetMorteInvalidez(DataRow dr)
        {
            if (dr["TipoSeguroID"].ToString() == "1")
                return Comum.General.VALOR_NULO;
            else if (dr["TipoSeguroID"].ToString() == "2")
                return (dr["MIPValor"].ToString() == string.Empty ? Comum.General.VALOR_NULO :dr["MIPValor"].ToString());
            else if (dr["TipoSeguroID"].ToString() == "3")
                return (dr["MIPValor"].ToString() == string.Empty ? Comum.General.VALOR_NULO : dr["MIPValor"].ToString());
            else if (dr["TipoSeguroID"].ToString() == "4")
                return (dr["MIPValor"].ToString() == string.Empty ? Comum.General.VALOR_NULO : dr["MIPValor"].ToString());
            else
                return Comum.General.VALOR_NULO;
        }

        private string GetDespesasTratamento(DataRow dr)
        {
            if (dr["TipoSeguroID"].ToString() == "1")
                return Comum.General.VALOR_NULO;
            else if (dr["TipoSeguroID"].ToString() == "2")
                return (dr["DTValor"].ToString() == string.Empty ? Comum.General.VALOR_NULO : dr["DTValor"].ToString());
            else if (dr["TipoSeguroID"].ToString() == "3")
                return (dr["DTValor"].ToString() == string.Empty ? Comum.General.VALOR_NULO : dr["DTValor"].ToString());
            else if (dr["TipoSeguroID"].ToString() == "4")
                return (dr["DTValor"].ToString() == string.Empty ? Comum.General.VALOR_NULO : dr["DTValor"].ToString());
            else
                return Comum.General.VALOR_NULO;
        }

        private string GetDespesasFuneral(DataRow dr)
        {
            if (dr["TipoSeguroID"].ToString() == "1")
                return Comum.General.VALOR_NULO;
            else if (dr["TipoSeguroID"].ToString() == "2")
                return (dr["DFValor"].ToString() == string.Empty ? Comum.General.VALOR_NULO : dr["DFValor"].ToString());
            else if (dr["TipoSeguroID"].ToString() == "3")
                return (dr["DFValor"].ToString() == string.Empty ? Comum.General.VALOR_NULO : dr["DFValor"].ToString());
            else if (dr["TipoSeguroID"].ToString() == "4")
                return (dr["DFValor"].ToString() == string.Empty ? Comum.General.VALOR_NULO : dr["DFValor"].ToString());
            else
                return Comum.General.VALOR_NULO;
        }
        
        private string GetChoqueColisao(DataRow dr)
        {
            if (dr["TipoSeguroID"].ToString() == "1")
                return Comum.General.VALOR_NULO;
            else if (dr["TipoSeguroID"].ToString() == "2")
                return Comum.General.VALOR_NULO;
            else if (dr["TipoSeguroID"].ToString() == "3")
                return GetChoqueColisaoTranquilo(dr);
            else if (dr["TipoSeguroID"].ToString() == "4")
                return GetChoqueColisaoInteligente(dr);
            else
                return Comum.General.VALOR_NULO;
        }

        private string GetChoqueColisaoTranquilo(DataRow dr)
        {
            //(((TextBox)FormView1.FindControl("ValorNovoTextBox")).Enabled=false? Comum.General.VALOR_NULO: ((TextBox)FormView1.FindControl("ValorNovoTextBox")).Text
            //if (!((TextBox)FormView1.FindControl("ValorNovoTextBox")).Enabled || !((TextBox)FormView1.FindControl("ValorSegurarTextBox")).Enabled)
            //{
            //    return Comum.General.VALOR_NULO;
            //}
            //else
            //{
                if (dr["ValorNovo"].ToString() == "0" ||dr["ValorNovo"].ToString() == string.Empty)
                    return Comum.General.VALOR_NULO;
                else
                    return dr["ValorSegurar"].ToString(); 
            //}
        }

        private string GetChoqueColisaoInteligente(DataRow dr)
        {
            string TempRespCivilInteligente = GetRespCivilInteligente(dr);
            if (TempRespCivilInteligente == Comum.General.VALOR_NULO)
            {
                return Comum.General.VALOR_NULO;
            }
            else
                return GetChoqueColisaoTranquilo(dr);
        }

        private string GetChoqueColisaoFranquia(DataRow dr)
        {

            if (GetChoqueColisaoTranquilo(dr) == Comum.General.VALOR_NULO)
            {
                return Comum.General.VALOR_NULO;
            }
            else
            {
                if (dr["ValorSegurar"].ToString() != string.Empty && dr["Franquia"].ToString() != string.Empty)
                    return (Double.Parse(dr["ValorSegurar"].ToString()) * Double.Parse(dr["Franquia"].ToString())).ToString();
                else
                    return Comum.General.VALOR_NULO;
            }
        }

        private string GetFurtoRoubo(DataRow dr)
        {
            if (dr["TipoSeguroID"].ToString() == "1")
                return Comum.General.VALOR_NULO;
            else if (dr["TipoSeguroID"].ToString() == "2")
                return Comum.General.VALOR_NULO;
            else if (dr["TipoSeguroID"].ToString() == "3")
                return GetFurtoRouboTranquilo(dr);
            else if (dr["TipoSeguroID"].ToString() == "4")
                return GetFurtoRouboInteligente(dr);
            else
                return Comum.General.VALOR_NULO;
        }

        private string GetFurtoRouboTranquilo(DataRow dr)
        {
            //(((TextBox)FormView1.FindControl("ValorNovoTextBox")).Enabled=false? Comum.General.VALOR_NULO: ((TextBox)FormView1.FindControl("ValorNovoTextBox")).Text
            //if (!((TextBox)FormView1.FindControl("ValorNovoTextBox")).Enabled || !((TextBox)FormView1.FindControl("ValorSegurarTextBox")).Enabled)
            //{
            //    return Comum.General.VALOR_NULO;
            //}
            //else
            //{
                if (dr["ValorNovo"].ToString() == "0" || dr["ValorNovo"].ToString() == string.Empty)
                    return Comum.General.VALOR_NULO;
                else
                    return dr["ValorSegurar"].ToString();
            //}
        }

        private string GetFurtoRouboInteligente(DataRow dr)
        {
            string TempRespCivilInteligente = GetRespCivilInteligente(dr);
            if (TempRespCivilInteligente == Comum.General.VALOR_NULO)
            {
                return Comum.General.VALOR_NULO;
            }
            else
                return GetFurtoRouboTranquilo(dr);
        }

        private string GetFurtoRouboFranquia(DataRow dr)
        {

            if (GetFurtoRouboTranquilo(dr) == Comum.General.VALOR_NULO)
            {
                return Comum.General.VALOR_NULO;
            }
            else
            {
                if (dr["ValorSegurar"].ToString() != string.Empty && dr["Franquia"].ToString() != string.Empty)
                    return (Double.Parse(dr["ValorSegurar"].ToString()) * Double.Parse(dr["Franquia"].ToString())).ToString();
                else
                    return Comum.General.VALOR_NULO;
            }
        }

        private string GetIncendioRaio(DataRow dr)
        {
            if (dr["TipoSeguroID"].ToString() == "1")
                return Comum.General.VALOR_NULO;
            else if (dr["TipoSeguroID"].ToString() == "2")
                return Comum.General.VALOR_NULO;
            else if (dr["TipoSeguroID"].ToString() == "3")
                return GetIncendioRaioTranquilo(dr);
            else if (dr["TipoSeguroID"].ToString() == "4")
                return GetIncendioRaioInteligente(dr);
            else
                return Comum.General.VALOR_NULO;
        }

        private string GetIncendioRaioTranquilo(DataRow dr)
        {
            //(((TextBox)FormView1.FindControl("ValorNovoTextBox")).Enabled=false? Comum.General.VALOR_NULO: ((TextBox)FormView1.FindControl("ValorNovoTextBox")).Text
            //if (!((TextBox)FormView1.FindControl("ValorNovoTextBox")).Enabled || !((TextBox)FormView1.FindControl("ValorSegurarTextBox")).Enabled)
            //{
            //    return Comum.General.VALOR_NULO;
            //}
            //else
            //{
            if (dr["ValorNovo"].ToString() == "0" || dr["ValorNovo"].ToString() == string.Empty)
                return Comum.General.VALOR_NULO;
            else
                return dr["ValorSegurar"].ToString();
            //}
        }

        private string GetIncendioRaioInteligente(DataRow dr)
        {
            string TempRespCivilInteligente = GetRespCivilInteligente(dr);
            if (TempRespCivilInteligente == Comum.General.VALOR_NULO)
            {
                return Comum.General.VALOR_NULO;
            }
            else
                return GetIncendioRaioTranquilo(dr);
        }

        private string GetIncendioRaioFranquia(DataRow dr)
        {

            if (GetIncendioRaioTranquilo(dr) == Comum.General.VALOR_NULO)
            {
                return Comum.General.VALOR_NULO;
            }
            else
            {
                if (dr["ValorSegurar"].ToString() != string.Empty && dr["Franquia"].ToString() != string.Empty)
                    return (Double.Parse(dr["ValorSegurar"].ToString()) * Double.Parse(dr["Franquia"].ToString())).ToString();
                else
                    return Comum.General.VALOR_NULO;
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

                dicDadosApolice = ConvertePropostaToApolice(Session["Proposta"].ToString());

                //Se não existir um aviso de cobrança, este é criado
                dicDadosCobranca = CreateAvisoCobranca(dicDadosApolice["ApoliceID"]);

                Page.ClientScript.RegisterStartupScript(this.GetType(), "ShowMessageBoxResultado", string.Format("<script type='text/javascript'>MessageBoxResultado('" + dicDadosApolice["ApoliceID"] + "','" + dicDadosApolice["NumeroApolice"] + "','" + dicDadosApolice["ClienteID"]  + "','" + dicDadosCobranca["NumeroAvisoCobranca"] + "');</script>", ""));
            }
           


        }

        public static Dictionary<string, string> ConvertePropostaToApolice(string sProposta)
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
                    dicDadosApolice.Add("ApoliceID", rdr["ApoliceID"].ToString());
                    dicDadosApolice.Add("NumeroApolice", rdr["NumeroApolice"].ToString());
                    dicDadosApolice.Add("ClienteID", rdr["ClienteID"].ToString());
                }

                con.Close();
            }

            return dicDadosApolice;

        }

        public static Dictionary<string, string> CreateAvisoCobranca(string sApoliceID)
        {
            SqlDataReader rdrAux = null;
            Dictionary<string, string> dicApolice = new Dictionary<string, string>();
            //sApoliceID = sApoliceID.Substring(15);

            using (SqlConnection con = new SqlConnection(Comum.General.getConnection()))
            {
                
                con.Open();
                SqlCommand sqlCommandAux = new SqlCommand("CriaAvisoCobrancaAuto", con);

                sqlCommandAux.CommandType = CommandType.StoredProcedure;

                SqlParameter paramApoliceID = sqlCommandAux.Parameters.Add("@ApoliceID", SqlDbType.Int);

                paramApoliceID.Value = sApoliceID;

                rdrAux = sqlCommandAux.ExecuteReader();

                while (rdrAux.Read())
                {
                    dicApolice.Add("NumeroAvisoCobranca", rdrAux["NumeroAvisoCobranca"].ToString());
                    dicApolice.Add("DataEmissao", rdrAux["DataEmissao"].ToString());
                }

                con.Close();

            }

            return dicApolice;
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
            if (e.NewPageIndex==-1)
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

        protected void btnAdicionarAutomovelFrota_Click(object sender, EventArgs e)
        {
            
                //Colocar os valores de Premios Fixos na ComboBox
                CategoriaComboBox_DataBound(null, null);

                DataTable dt = new DataTable();
                if (ViewState["dt"] != null)
                    dt = (DataTable)ViewState["dt"];
                else
                    dt.Columns.AddRange(new DataColumn[24] { new DataColumn("ViaturaId"), new DataColumn("Matricula"), new DataColumn("MarcaID"), new DataColumn("ModeloID"), new DataColumn("DataFabrico"), new DataColumn("Cilindrada"), new DataColumn("Chassi"), new DataColumn("Lugares"), new DataColumn("UsoID"), new DataColumn("RCCliente"), new DataColumn("DPCliente"), new DataColumn("CategoriaID"), new DataColumn("TipoCategoriaID"), new DataColumn("OpcaoOcupantesID"), new DataColumn("ValorNovo"), new DataColumn("ValorSegurar"), new DataColumn("Franquia"), new DataColumn("TipoSeguroID"), new DataColumn("CategoriaValor"), new DataColumn("CategoriaOcupantes"), new DataColumn("OpcaoOcupantes"), new DataColumn("MIPValor"), new DataColumn("DTValor"), new DataColumn("DFValor") });

                //dt.Rows.Add(((GridView)FormView1.FindControl("GridViewViaturas")).Rows.Count + 1, "LD-94-73");
                dt.Rows.Add(((GridView)FormView1.FindControl("GridViewViaturas")).Rows.Count + 1, ((TextBox)FormView1.FindControl("MatriculaTextBox")).Text, ((DropDownList)FormView1.FindControl("MarcaComboBox")).SelectedValue, ((DropDownList)FormView1.FindControl("ModeloComboBox")).SelectedValue, ((TextBox)FormView1.FindControl("DataFabricoTextBox")).Text, ((TextBox)FormView1.FindControl("CilindradaTextBox")).Text, ((TextBox)FormView1.FindControl("ChassiTextBox")).Text, ((TextBox)FormView1.FindControl("LugaresTextBox")).Text, ((DropDownList)FormView1.FindControl("UsoComboBox")).SelectedValue, ((TextBox)FormView1.FindControl("ClienteRCTextBox")).Text, ((TextBox)FormView1.FindControl("ClienteDPTextBox")).Text, ((DropDownList)FormView1.FindControl("CategoriaComboBox")).SelectedValue, ((DropDownList)FormView1.FindControl("TipoCategoriaComboBox")).SelectedValue, ((DropDownList)FormView1.FindControl("OpcaoOcupantesComboBox")).SelectedValue, ((TextBox)FormView1.FindControl("ValorNovoTextBox")).Text, ((TextBox)FormView1.FindControl("ValorSegurarTextBox")).Text, ((TextBox)FormView1.FindControl("FranquiaTextBox")).Text, ((DropDownList)FormView1.FindControl("TipoSeguroComboBox")).SelectedValue, ((DropDownList)FormView1.FindControl("CategoriaComboBox")).SelectedItem.Attributes["Valor"].ToString(), ((DropDownList)FormView1.FindControl("CategoriaComboBox")).SelectedItem.Attributes["ocupantes"].ToString(), ((DropDownList)FormView1.FindControl("OpcaoOcupantesComboBox")).SelectedItem.Text, ((TextBox)FormView1.FindControl("MIPValorTextBox")).Text, ((TextBox)FormView1.FindControl("DTValorTextBox")).Text, ((TextBox)FormView1.FindControl("DFValorTextBox")).Text);

                ViewState["dt"] = dt;
                BindGridViaturas();
            
            ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "InitializeAcordion_3", "SetInitializeAcordion_3();", true);

        }

        protected void btnActualizarAutomovelFrota_Click(object sender, EventArgs e)
        {
            

            for (int i = ((DataTable)ViewState["dt"]).Rows.Count - 1; i >= 0; i--)
            {
                DataRow dr = ((DataTable)ViewState["dt"]).Rows[i];
                if (dr["ViaturaID"].ToString() == ((TextBox)FormView1.FindControl("MatriculaTextBox")).Attributes["ViaturaID"].ToString())
                {
                    CategoriaComboBox_DataBound(null, null);
                    dr["Matricula"] = ((TextBox)FormView1.FindControl("MatriculaTextBox")).Text;
                    dr["MarcaID"] = ((DropDownList)FormView1.FindControl("MarcaComboBox")).SelectedValue;
                    dr["ModeloID"] = ((DropDownList)FormView1.FindControl("ModeloComboBox")).SelectedValue;
                    dr["DataFabrico"] = ((TextBox)FormView1.FindControl("DataFabricoTextBox")).Text;
                    dr["Cilindrada"] = ((TextBox)FormView1.FindControl("CilindradaTextBox")).Text;
                    dr["Chassi"] = ((TextBox)FormView1.FindControl("ChassiTextBox")).Text;
                    dr["Lugares"] = ((TextBox)FormView1.FindControl("LugaresTextBox")).Text;
                    dr["UsoID"] = ((DropDownList)FormView1.FindControl("UsoComboBox")).SelectedValue;
                    dr["RCCliente"] = ((TextBox)FormView1.FindControl("ClienteRCTextBox")).Text;
                    dr["DPCliente"] = ((TextBox)FormView1.FindControl("ClienteDPTextBox")).Text;
                    dr["CategoriaID"] = ((DropDownList)FormView1.FindControl("CategoriaComboBox")).SelectedValue;
                    dr["TipoCategoriaID"] = ((DropDownList)FormView1.FindControl("TipoCategoriaComboBox")).SelectedValue;
                    dr["OpcaoOcupantesID"] = ((DropDownList)FormView1.FindControl("OpcaoOcupantesComboBox")).SelectedValue;
                    dr["ValorNovo"] = ((TextBox)FormView1.FindControl("ValorNovoTextBox")).Text;
                    dr["ValorSegurar"] = ((TextBox)FormView1.FindControl("ValorSegurarTextBox")).Text;
                    dr["Franquia"] = ((TextBox)FormView1.FindControl("FranquiaTextBox")).Text;
                    dr["TipoSeguroID"] = ((DropDownList)FormView1.FindControl("TipoSeguroComboBox")).SelectedValue;
                    dr["CategoriaValor"] = ((DropDownList)FormView1.FindControl("CategoriaComboBox")).SelectedItem.Attributes["Valor"].ToString();
                    dr["CategoriaOcupantes"] = ((DropDownList)FormView1.FindControl("CategoriaComboBox")).SelectedItem.Attributes["ocupantes"].ToString();
                    dr["OpcaoOcupantes"] = ((DropDownList)FormView1.FindControl("OpcaoOcupantesComboBox")).SelectedItem.Text;
                    

                    BindGridViaturas();
                    btnCancelarAutomovelFrota_Click(null, null);
                }
            }

            //DataTable dt = new DataTable();
            //if (ViewState["dt"] != null)
            //    dt = (DataTable)ViewState["dt"];
            //else
            //    dt.Columns.AddRange(new DataColumn[17] { new DataColumn("ViaturaId"), new DataColumn("Matricula"), new DataColumn("MarcaID"), new DataColumn("ModeloID"), new DataColumn("DataFabrico"), new DataColumn("Cilindrada"), new DataColumn("Chassi"), new DataColumn("Lugares"), new DataColumn("UsoID"), new DataColumn("RCCliente"), new DataColumn("DPCliente"), new DataColumn("CategoriaID"), new DataColumn("TipoCategoriaID"), new DataColumn("OpcaoOcupantesID"), new DataColumn("ValorNovo"), new DataColumn("ValorSegurar"), new DataColumn("Franquia") });

            ////dt.Rows.Add(((GridView)FormView1.FindControl("GridViewViaturas")).Rows.Count + 1, "LD-94-73");
            //dt.Rows.Add(((GridView)FormView1.FindControl("GridViewViaturas")).Rows.Count + 1, ((TextBox)FormView1.FindControl("MatriculaTextBox")).Text, ((DropDownList)FormView1.FindControl("MarcaComboBox")).SelectedValue, ((DropDownList)FormView1.FindControl("ModeloComboBox")).SelectedValue, ((TextBox)FormView1.FindControl("DataFabricoTextBox")).Text, ((TextBox)FormView1.FindControl("CilindradaTextBox")).Text, ((TextBox)FormView1.FindControl("ChassiTextBox")).Text, ((TextBox)FormView1.FindControl("LugaresTextBox")).Text, ((DropDownList)FormView1.FindControl("UsoComboBox")).SelectedValue, ((TextBox)FormView1.FindControl("ClienteRCTextBox")).Text, ((TextBox)FormView1.FindControl("ClienteDPTextBox")).Text, ((DropDownList)FormView1.FindControl("CategoriaComboBox")).SelectedValue, ((DropDownList)FormView1.FindControl("TipoCategoriaComboBox")).SelectedValue, ((DropDownList)FormView1.FindControl("OpcaoOcupantesComboBox")).SelectedValue, ((TextBox)FormView1.FindControl("ValorNovoTextBox")).Text, ((TextBox)FormView1.FindControl("ValorSegurarTextBox")).Text, ((TextBox)FormView1.FindControl("FranquiaTextBox")).Text);

            //ViewState["dt"] = dt;
            //BindGridViaturas();
            //ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "InitializeAcordion_3", "SetInitializeAcordion_3();", true);
        }

        protected void Operation_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (((System.Web.UI.WebControls.ListControl)(sender)).SelectedValue == "1")
            {
                //Response.Redirect("AdminArtigo.aspx?aid=" + (((System.Web.UI.WebControls.ListControl)(sender))).Attributes["IDArtigo"] + "&idl=" + (((System.Web.UI.WebControls.ListControl)(sender))).Attributes["IDLingua"]);
                EditViatura((((System.Web.UI.WebControls.ListControl)(sender))).Attributes["IDViatura"]);
            }

            if (((System.Web.UI.WebControls.ListControl)(sender)).SelectedValue == "2")
            {
                DeleteViatura((((System.Web.UI.WebControls.ListControl)(sender))).Attributes["IDViatura"]);

            }
           
            ((GridView)FormView1.FindControl("GridViewViaturas")).DataBind();
        }

        protected void btnCancelarAutomovelFrota_Click(object sender, EventArgs e)
        {
            //CAMPOS
            ((TextBox)FormView1.FindControl("MatriculaTextBox")).Text = "";
            ((DropDownList)FormView1.FindControl("MarcaComboBox")).SelectedIndex = -1;
            ((DropDownList)FormView1.FindControl("ModeloComboBox")).SelectedIndex = -1;
            ((TextBox)FormView1.FindControl("DataFabricoTextBox")).Text = "";
            ((TextBox)FormView1.FindControl("CilindradaTextBox")).Text = "";
            ((TextBox)FormView1.FindControl("ChassiTextBox")).Text = "";
            ((TextBox)FormView1.FindControl("LugaresTextBox")).Text = "";
            ((DropDownList)FormView1.FindControl("UsoComboBox")).SelectedIndex = -1;
            ((TextBox)FormView1.FindControl("ClienteRCTextBox")).Text = "";
            ((TextBox)FormView1.FindControl("ClienteDPTextBox")).Text = "";
            ((DropDownList)FormView1.FindControl("CategoriaComboBox")).SelectedIndex = -1;
            ((DropDownList)FormView1.FindControl("TipoCategoriaComboBox")).SelectedIndex = -1;
            ((DropDownList)FormView1.FindControl("OpcaoOcupantesComboBox")).SelectedIndex = -1;
            ((TextBox)FormView1.FindControl("ValorNovoTextBox")).Text = "";
            ((TextBox)FormView1.FindControl("ValorSegurarTextBox")).Text = "";
            ((TextBox)FormView1.FindControl("FranquiaTextBox")).Text = "";

            ((TextBox)FormView1.FindControl("MIPDescTextBox")).Text = "";
            ((TextBox)FormView1.FindControl("MIPValorTextBox")).Text = "";

            ((TextBox)FormView1.FindControl("DTDescTextBox")).Text = "";
            ((TextBox)FormView1.FindControl("DTValorTextBox")).Text = "";

            ((TextBox)FormView1.FindControl("DFDescTextBox")).Text = "";
            ((TextBox)FormView1.FindControl("DFValorTextBox")).Text = "";


            //BOTOES
            ((Button)FormView1.FindControl("btnActualizarAutomovelFrota")).Visible = false;
            ((Button)FormView1.FindControl("btnCancelarAutomovelFrota")).Visible = false;
            ((Button)FormView1.FindControl("btnAdicionarAutomovelFrota")).Visible = true;

            foreach (BaseValidator val in Page.Validators)
            {

                val.Enabled = false;

            }
            //BindGridViaturas();
            //ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "InitializeAcordion_3", "SetInitializeAcordion_3();", true);
        }

        public void DeleteViatura(string ViaturaID)
        {
            for (int i = ((DataTable)ViewState["dt"]).Rows.Count - 1; i >= 0; i--)
            {
                DataRow dr = ((DataTable)ViewState["dt"]).Rows[i];
                if (dr["ViaturaID"].ToString() == ViaturaID)
                {
                    dr.Delete();
                    BindGridViaturas();
                }
            }
    }

        public void EditViatura(string ViaturaID)
        {

            for (int i = ((DataTable)ViewState["dt"]).Rows.Count - 1; i >= 0; i--)
            {
                DataRow dr = ((DataTable)ViewState["dt"]).Rows[i];
                if (dr["ViaturaID"].ToString() == ViaturaID)
                {
                    ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "InitializeAcordion_3", "SetInitializeAcordion_3();", true);
                    try {
                        ((TextBox)FormView1.FindControl("MatriculaTextBox")).Text = dr["Matricula"].ToString();
                        ((TextBox)FormView1.FindControl("MatriculaTextBox")).Attributes.Add("ViaturaID", ViaturaID);
                        ((DropDownList)FormView1.FindControl("MarcaComboBox")).SelectedValue = dr["MarcaID"].ToString();
                        MarcaComboBox_SelectedIndexChanged(null, null);
                        ((DropDownList)FormView1.FindControl("ModeloComboBox")).SelectedValue = dr["ModeloID"].ToString();
                        ((TextBox)FormView1.FindControl("DataFabricoTextBox")).Text = DateTime.Parse(dr["DataFabrico"].ToString()).Day.ToString("00") + "/" + DateTime.Parse(dr["DataFabrico"].ToString()).Month.ToString("00") + "/" + DateTime.Parse(dr["DataFabrico"].ToString()).Year.ToString();
                        ((TextBox)FormView1.FindControl("CilindradaTextBox")).Text = dr["Cilindrada"].ToString();
                        ((TextBox)FormView1.FindControl("ChassiTextBox")).Text = dr["Chassi"].ToString();
                        ((TextBox)FormView1.FindControl("LugaresTextBox")).Text = dr["Lugares"].ToString();
                        ((DropDownList)FormView1.FindControl("UsoComboBox")).SelectedValue = dr["UsoID"].ToString();
                        ((TextBox)FormView1.FindControl("ClienteRCTextBox")).Text = dr["RCCliente"].ToString();
                        ((TextBox)FormView1.FindControl("ClienteDPTextBox")).Text = dr["DPCliente"].ToString();
                        ((DropDownList)FormView1.FindControl("CategoriaComboBox")).SelectedValue = dr["CategoriaID"].ToString();
                        CategoriaComboBox_SelectedIndexChanged(null, null);
                        ((DropDownList)FormView1.FindControl("TipoCategoriaComboBox")).SelectedValue = dr["TipoCategoriaID"].ToString();
                        ((DropDownList)FormView1.FindControl("TipoSeguroComboBox")).SelectedValue = dr["TipoSeguroID"].ToString();
                        ((DropDownList)FormView1.FindControl("OpcaoOcupantesComboBox")).SelectedValue = dr["OpcaoOcupantesID"].ToString();
                        OpcaoOcupantesComboBox_SelectedIndexChanged(null, null);
                        ((TextBox)FormView1.FindControl("ValorNovoTextBox")).Text = dr["ValorNovo"].ToString();
                        ((TextBox)FormView1.FindControl("ValorSegurarTextBox")).Text = dr["ValorSegurar"].ToString();
                        ((TextBox)FormView1.FindControl("FranquiaTextBox")).Text = dr["Franquia"].ToString();
                        ((DropDownList)FormView1.FindControl("TipoSeguroComboBox")).Text = dr["TipoSeguroID"].ToString();


                        //BOTOES
                        ((Button)FormView1.FindControl("btnActualizarAutomovelFrota")).Visible = true;
                        ((Button)FormView1.FindControl("btnCancelarAutomovelFrota")).Visible = true;
                        ((Button)FormView1.FindControl("btnAdicionarAutomovelFrota")).Visible = false;
                    }
                    catch (Exception ex)
                    {
                        string message = ex.Message.Replace("'", string.Empty);
                        ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "SetMessageBoxErroEditar", "MessageBoxErroEditar('" + message.Replace(Environment.NewLine, string.Empty) + "');", true);


                    }


                }
            }

            BindGridViaturas();
        }

        protected void BindGridViaturas()
        {
            for (int i = ((DataTable)ViewState["dt"]).Rows.Count - 1; i >= 0; i--)
            {
                DataRow dr = ((DataTable)ViewState["dt"]).Rows[i];
                dr["ViaturaID"] = i + 1;
            }

            ((GridView)FormView1.FindControl("GridViewViaturas")).DataSource = ViewState["dt"] as DataTable;
            ((GridView)FormView1.FindControl("GridViewViaturas")).DataBind();

            
        }

        protected string BuildMarca(object MarcaId)
        {
            try
            {
                return dictMarca[int.Parse(MarcaId.ToString())].ToString();
            }
            catch
            {
                return "";

            }
        }

        protected string BuildModelo(object ModeloId)
        {
            try
            {
                return dictModelo[int.Parse(ModeloId.ToString())].ToString();
            }
            catch
            {
                return "";

            }
        }

        protected string BuildTipoCategoriaID(object TipoCategoriaID)
        {
            try
            {
                return dictTipoCategoria[TipoCategoriaID.ToString()].ToString();
            }
            catch
            {
                return "";

            }
        }

        protected void btnLimpar_Click(object sender, EventArgs e)
        {
            BindGridViaturas();
        }

        protected void ListaAnexa_Click(object sender, EventArgs e)
        {

        }

        protected void FileUpload1_DataBinding(object sender, EventArgs e)
        {
        }

       
        private void Import_To_GridV2(string FilePath, string Extension, string isHDR)
        {
            string fname = FilePath;
            //Console.WriteLine("Reading file " + fname + ".");

            // Read excel file.
            IWorkbook wb = WorkbookFactory.Create(new FileStream(
                           Path.GetFullPath(fname),
                           FileMode.Open, FileAccess.Read,
                           FileShare.ReadWrite));

            ISheet ws = wb.GetSheetAt(0);

            ViewState["dt"] = null;
            DataTable dt = new DataTable();
            dt.Columns.AddRange(new DataColumn[24] { new DataColumn("ViaturaId"), new DataColumn("Matricula"), new DataColumn("MarcaID"), new DataColumn("ModeloID"), new DataColumn("DataFabrico"), new DataColumn("Cilindrada"), new DataColumn("Chassi"), new DataColumn("Lugares"), new DataColumn("UsoID"), new DataColumn("RCCliente"), new DataColumn("DPCliente"), new DataColumn("CategoriaID"), new DataColumn("TipoCategoriaID"), new DataColumn("OpcaoOcupantesID"), new DataColumn("ValorNovo"), new DataColumn("ValorSegurar"), new DataColumn("Franquia"), new DataColumn("TipoSeguroID"), new DataColumn("CategoriaValor"), new DataColumn("CategoriaOcupantes"), new DataColumn("OpcaoOcupantes"), new DataColumn("MIPValor"), new DataColumn("DTValor"), new DataColumn("DFValor") });

            for (int row = 1; row <= ws.LastRowNum; row++)
            { 
                // Ignoring first row as headers.
                //Console.WriteLine(ws.GetRow(row).GetCell(0).NumericCellValue);
                if (ws.GetRow(row).GetCell(0) != null)// && ws.GetRow(row).GetCell(1).NumericCellValue > 0 && ws.GetRow(row).GetCell(3) != null) //Tem de ter Matricula, Marca e Modelo
                    if (ws.GetRow(row).GetCell(0).StringCellValue != "")
                        dt.Rows.Add(((GridView)FormView1.FindControl("GridViewViaturas")).Rows.Count + 1, ws.GetRow(row).GetCell(0).StringCellValue , ws.GetRow(row).GetCell(1).NumericCellValue, ws.GetRow(row).GetCell(3).NumericCellValue, ws.GetRow(row).GetCell(5).DateCellValue.ToString().Substring(0,10), ws.GetRow(row).GetCell(6).NumericCellValue, ws.GetRow(row).GetCell(7).StringCellValue, ws.GetRow(row).GetCell(8).NumericCellValue, ws.GetRow(row).GetCell(9).NumericCellValue, "","", ws.GetRow(row).GetCell(11).NumericCellValue, ws.GetRow(row).GetCell(13).StringCellValue, ws.GetRow(row).GetCell(17).NumericCellValue, ws.GetRow(row).GetCell(19).NumericCellValue, ws.GetRow(row).GetCell(20).NumericCellValue, ws.GetRow(row).GetCell(21).NumericCellValue, ws.GetRow(row).GetCell(15).NumericCellValue, ws.GetRow(row).GetCell(22).NumericCellValue, ws.GetRow(row).GetCell(23).NumericCellValue, ws.GetRow(row).GetCell(24).StringCellValue, ws.GetRow(row).GetCell(25).NumericCellValue, ws.GetRow(row).GetCell(26).NumericCellValue, ws.GetRow(row).GetCell(27).NumericCellValue);
                        //dt.Rows.Add(((GridView)FormView1.FindControl("GridViewViaturas")).Rows.Count + 1, ws.GetRow(row).GetCell(0).StringCellValue, ws.GetRow(row).GetCell(1).NumericCellValue.ToString(), ws.GetRow(row).GetCell(3).NumericCellValue.ToString(), ws.GetRow(row).GetCell(4).StringCellValue, ws.GetRow(row).GetCell(5).StringCellValue, ws.GetRow(row).GetCell(6).StringCellValue, ws.GetRow(row).GetCell(7).NumericCellValue.ToString(), ws.GetRow(row).GetCell(8).NumericCellValue.ToString(), "", "", ws.GetRow(row).GetCell(10).NumericCellValue.ToString(), ws.GetRow(row).GetCell(12).NumericCellValue.ToString(), ws.GetRow(row).GetCell(16).NumericCellValue.ToString(), ws.GetRow(row).GetCell(18).StringCellValue, ws.GetRow(row).GetCell(19).StringCellValue, ws.GetRow(row).GetCell(20).StringCellValue, ws.GetRow(row).GetCell(14).NumericCellValue.ToString(), ((DropDownList)FormView1.FindControl("CategoriaComboBox")).SelectedItem.Attributes["Valor"].ToString(), ((DropDownList)FormView1.FindControl("CategoriaComboBox")).SelectedItem.Attributes["ocupantes"].ToString(), ((DropDownList)FormView1.FindControl("OpcaoOcupantesComboBox")).SelectedItem.Text, ((TextBox)FormView1.FindControl("MIPValorTextBox")).Text, ((TextBox)FormView1.FindControl("DTValorTextBox")).Text, ((TextBox)FormView1.FindControl("DFValorTextBox")).Text);
            }

            ViewState["dt"] = dt;
            BindGridViaturas();

        }

       
    }
}