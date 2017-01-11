using SelectPdf;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.SqlServer.Server;

namespace MASTERSEGUROS.WEB
{
    public partial class AutoDocument : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            string docID = Request.QueryString["docID"];
            string aplID = Request.QueryString["aplID"];
            string type = Request.QueryString["type"];
            string avcID = string.Empty;


            Dictionary<string, string> dicApolice = new Dictionary<string, string>();
            DataTable dtApoliceFrota = new DataTable();

            //if (type==Comum.General.TIPO_SEGURO_AUTO) //Caso seja seguro individual
                dicApolice = GetListOneApolice(int.Parse(aplID));
            if (type == Comum.General.TIPO_SEGURO_AUTO_FROTA) //Caso seja seguro Frota (Várias viaturas na impressao do distico e certificado)
                dtApoliceFrota = GetListApoliceFrota(int.Parse(aplID));


            if (docID == Comum.General.RECIBO_COBRANCA)
            {
                Dictionary<string, string> dicDadosCobranca = new Dictionary<string, string>();
                //Se não existir um aviso de cobrança, este é criado
                dicDadosCobranca = CreateAvisoCobranca(aplID);

                if (!dicApolice.Keys.Contains("NumeroAvisoCobranca"))
                    dicApolice.Add("NumeroAvisoCobranca", dicDadosCobranca["NumeroAvisoCobranca"]);

                if (!dicApolice.Keys.Contains("DataEmissao"))
                    dicApolice.Add("DataEmissao", dicDadosCobranca["DataEmissao"]);

                ReciboCobranca(dicApolice);
                Response.Redirect(Comum.General.getBASE_URL() + "Uploads/" + dicApolice["NumeroAvisoCobranca"] + ".pdf");
            }
            else if (docID == Comum.General.RECIBO_PREMIO)
            {
                avcID = Request.QueryString["avcID"];

                Dictionary<string, string> dicAvisoCobranca = new Dictionary<string, string>();

                dicAvisoCobranca = GetReciboCobrancaActualizaImpressoes(avcID);

                dicApolice.Add("DataEmissao", dicAvisoCobranca["DataEmissao"]);
                dicApolice.Add("TotalImpressoes", dicAvisoCobranca["TotalImpressoes"]);
                dicApolice.Add("NumeroAvisoCobranca", dicAvisoCobranca["NumeroAvisoCobranca"]);

                ReciboPremio(dicApolice);
                Response.Redirect(Comum.General.getBASE_URL() + "Uploads/" + dicApolice["NumeroAvisoCobranca"].Replace("AVC", "RCB") + ".pdf");
            }
            else if (docID == Comum.General.APOLICE)
            {
                Apolice(dicApolice);
                Response.Redirect(Comum.General.getBASE_URL() + "Uploads/" + dicApolice["NumeroApolice"] + ".pdf");
            }
            else if (docID == Comum.General.CERTIFICADO)
            {
                  if (type == Comum.General.TIPO_SEGURO_AUTO_FROTA)
                    CertificadoFrota(dicApolice, dtApoliceFrota);
                  else
                    Certificado(dicApolice);

                Response.Redirect(Comum.General.getBASE_URL() + "Uploads/" + dicApolice["NumeroApolice"] + "_CERTIFICADO.pdf");
            }
            else if (docID== Comum.General.LISTA_ANEXA)
            {
                DataTable dt = new DataTable();
                dt = getViaturasFrota(aplID);

                ListaAnexa(dicApolice, dt);
                Response.Redirect(Comum.General.getBASE_URL() + "Uploads/" + dicApolice["NumeroApolice"] + "_LISTA_ANEXA.pdf");
            }

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

                    if (!dicApolice.Keys.Contains("NumeroAvisoCobranca"))
                        dicApolice.Add("NumeroAvisoCobranca", rdrAux["NumeroAvisoCobranca"].ToString());

                    if (!dicApolice.Keys.Contains("DataEmissao"))
                        dicApolice.Add("DataEmissao", rdrAux["DataEmissao"].ToString());
                }

                con.Close();

            }

            return dicApolice;
        }

        public static Dictionary<string, string> GetListOneApolice(int ApoliceID)
        {
            SqlDataReader rdr = null;
            SqlDataReader rdrAux = null;
            String sRetValue = string.Empty;
            Dictionary<string, string> dicApolice = new Dictionary<string, string>();

            using (SqlConnection con = new SqlConnection(Comum.General.getConnection()))
            {
                con.Open();

                SqlCommand sqlCommand = new SqlCommand("spGetListOneApolice", con);

                sqlCommand.CommandType = CommandType.StoredProcedure;

                SqlParameter paramApoliceID = sqlCommand.Parameters.Add("@ApoliceID", SqlDbType.Int);

                paramApoliceID.Value = ApoliceID;

                rdr = sqlCommand.ExecuteReader();

                while (rdr.Read())
                {
                    //APOLICE
                    dicApolice.Add("EstadoApoliceID", rdr["EstadoApoliceID"].ToString());
                    dicApolice.Add("ApoliceID", rdr["ApoliceID"].ToString());
                    dicApolice.Add("PropostaID", rdr["PropostaID"].ToString());
                    dicApolice.Add("NumeroApolice", rdr["NumeroApolice"].ToString());
                    dicApolice.Add("DataInicio", rdr["DataInicio"].ToString());
                    dicApolice.Add("BrokerID", rdr["BrokerID"].ToString());
                    dicApolice.Add("BrokerName", rdr["BrokerName"].ToString());
                    dicApolice.Add("QualidadeTomadorID", rdr["QualidadeTomadorID"].ToString());
                    dicApolice.Add("Matricula", rdr["Matricula"].ToString());
                    dicApolice.Add("MarcaID", rdr["MarcaID"].ToString());
                    dicApolice.Add("ModeloID", rdr["ModeloID"].ToString());
                    dicApolice.Add("DataFabrico", rdr["DataFabrico"].ToString());
                    dicApolice.Add("Cilindrada", rdr["Cilindrada"].ToString());
                    dicApolice.Add("Chassi", rdr["Chassi"].ToString());
                    dicApolice.Add("Lugares", rdr["Lugares"].ToString());
                    dicApolice.Add("UsoID", rdr["UsoID"].ToString());
                    dicApolice.Add("RCCliente", rdr["RCCliente"].ToString());
                    dicApolice.Add("DPCliente", rdr["DPCliente"].ToString());
                    dicApolice.Add("CategoriaID", rdr["CategoriaID"].ToString());
                    dicApolice.Add("TipoCategoriaID", rdr["TipoCategoriaID"].ToString());
                    dicApolice.Add("OcupantesOpcaoID", rdr["OcupantesOpcaoID"].ToString());
                    dicApolice.Add("ValorNovo", rdr["ValorNovo"].ToString());
                    dicApolice.Add("ValorSegurar", rdr["ValorSegurar"].ToString());
                    dicApolice.Add("Franquia", rdr["Franquia"].ToString());
                    dicApolice.Add("TipoSeguroID", rdr["TipoSeguroID"].ToString());
                    dicApolice.Add("Fraccionamento", rdr["Fraccionamento"].ToString());
                    dicApolice.Add("UserIDCriacao", rdr["DataCriacao"].ToString());
                    dicApolice.Add("UserIDActualizacao", rdr["UserIDActualizacao"].ToString());
                    dicApolice.Add("DataActualizacao", rdr["DataActualizacao"].ToString());
                    dicApolice.Add("Estado", rdr["Estado"].ToString());
                    dicApolice.Add("ClienteID", rdr["ClienteID"].ToString());
                    //CLIENTE
                    dicApolice.Add("Nome", rdr["Nome"].ToString());
                    dicApolice.Add("Morada", rdr["Morada"].ToString());
                    dicApolice.Add("Provincia", rdr["Provincia"].ToString());
                    dicApolice.Add("Telefone", rdr["Telefone"].ToString());
                    dicApolice.Add("Telemovel", rdr["Telemovel"].ToString());
                    dicApolice.Add("Email", rdr["Email"].ToString());
                    //CALCULO PREMIO
                    dicApolice.Add("RespCivilFranquia", rdr["RespCivilFranquia"].ToString());
                    dicApolice.Add("RespCivilValor", rdr["RespCivilValor"].ToString());
                    dicApolice.Add("OcupantesFranquia", rdr["OcupantesFranquia"].ToString());
                    dicApolice.Add("OcupantesValor", rdr["OcupantesValor"].ToString());
                    dicApolice.Add("MorteInvalidezFranquia", rdr["MorteInvalidezFranquia"].ToString());
                    dicApolice.Add("MorteInvalidezValor", rdr["MorteInvalidezValor"].ToString());
                    dicApolice.Add("DespesasFuneralFranquia", rdr["DespesasFuneralFranquia"].ToString());
                    dicApolice.Add("DespesasFuneralValor", rdr["DespesasFuneralValor"].ToString());
                    dicApolice.Add("DespesasTratamentoFranquia", rdr["DespesasTratamentoFranquia"].ToString());
                    dicApolice.Add("DespesasTratamentoValor", rdr["DespesasTratamentoValor"].ToString());
                    dicApolice.Add("ChoqueColisaoFranquia", rdr["ChoqueColisaoFranquia"].ToString());
                    dicApolice.Add("ChoqueColisaoValor", rdr["ChoqueColisaoValor"].ToString());
                    dicApolice.Add("FurtoRouboFranquia", rdr["FurtoRouboFranquia"].ToString());
                    dicApolice.Add("FurtoRouboValor", rdr["FurtoRouboValor"].ToString());
                    dicApolice.Add("IncendioRaioFranquia", rdr["IncendioRaioFranquia"].ToString());
                    dicApolice.Add("IncendioRaioValor", rdr["IncendioRaioValor"].ToString());
                    dicApolice.Add("PremioSimples", rdr["PremioSimples"].ToString());
                    dicApolice.Add("Encargos", rdr["Encargos"].ToString());
                    dicApolice.Add("Arseg", rdr["Arseg"].ToString());
                    dicApolice.Add("FGA", rdr["FGA"].ToString());
                    dicApolice.Add("CustoApolice", rdr["CustoApolice"].ToString());
                    dicApolice.Add("ValorOpcaoExtra", rdr["ValorOpcaoExtra"].ToString());
                    dicApolice.Add("PremioTotal", rdr["PremioTotal"].ToString());
                }

                con.Close();

            }

            return dicApolice;
        }

        public DataTable GetListApoliceFrota(int ApoliceID)
        {
            String sRetValue = string.Empty;
            DataTable dtApolice = new DataTable();
            SqlDataAdapter daApolice ;

            using (SqlConnection con = new SqlConnection(Comum.General.getConnection()))
            {
                con.Open();

                SqlCommand sqlCommand = new SqlCommand("spGetListOneApoliceFrota", con);

                sqlCommand.CommandType = CommandType.StoredProcedure;

                SqlParameter paramApoliceID = sqlCommand.Parameters.Add("@ApoliceID", SqlDbType.Int);

                paramApoliceID.Value = ApoliceID;

                daApolice = new SqlDataAdapter(sqlCommand);

                daApolice.Fill(dtApolice);

                con.Close();

            }

            return dtApolice;
        }
        

        public static Dictionary<string, string> GetReciboCobrancaActualizaImpressoes(string avcID)
        {

            SqlDataReader rdr = null;

            String sRetValue = string.Empty;
            Dictionary<string, string> dicApolice = new Dictionary<string, string>();

            using (SqlConnection con = new SqlConnection(Comum.General.getConnection()))
            {
                con.Open();

                SqlCommand sqlCommand = new SqlCommand("spActualizaImpressoesAvisoCobrancaAuto", con);

                sqlCommand.CommandType = CommandType.StoredProcedure;

                SqlParameter paramApoliceAvisoCobrancaID = sqlCommand.Parameters.Add("@ApoliceAvisoCobrancaID", SqlDbType.Int);

                paramApoliceAvisoCobrancaID.Value = avcID;

                rdr = sqlCommand.ExecuteReader();

                while (rdr.Read())
                {
                    dicApolice.Add("DataEmissao", rdr["DataEmissao"].ToString());
                    dicApolice.Add("TotalImpressoes", rdr["TotalImpressoes"].ToString());
                    dicApolice.Add("NumeroAvisoCobranca", rdr["NumeroAvisoCobranca"].ToString());


                }
                con.Close();
            }

            return dicApolice;

        }

        private void ReciboCobranca(Dictionary<string, string> dicApolice)
        {
            string pdf_page_size = "A4";
            string headerUrl = Server.MapPath("~/files/header.html");
            string footerUrl = Server.MapPath("~/files/footer.html");

            PdfPageSize pageSize = (PdfPageSize)Enum.Parse(typeof(PdfPageSize),
                pdf_page_size, true);

            string pdf_orientation = "Portrait";
            PdfPageOrientation pdfOrientation =
                (PdfPageOrientation)Enum.Parse(typeof(PdfPageOrientation),
                pdf_orientation, true);

            HtmlToPdf converter = new HtmlToPdf();

            // set converter options
            converter.Options.PdfPageSize = pageSize;
            converter.Options.PdfPageOrientation = pdfOrientation;

            converter.Options.DisplayHeader = true;
            converter.Options.DisplayFooter = true;
            converter.Options.MarginLeft = 10;
            converter.Options.MarginRight = 10;

            converter.Header.Height = 60;
            converter.Footer.Height = 50;

            PdfHtmlSection headerHtml = new PdfHtmlSection(headerUrl);

            converter.Header.Add(headerHtml);

            PdfHtmlSection footerHtml = new PdfHtmlSection(footerUrl);
            footerHtml.AutoFitHeight = HtmlToPdfPageFitMode.AutoFit;
            converter.Footer.Add(footerHtml);

            string sHTMLApolice = getHTMLReciboCobranca(dicApolice);

            converter.Options.MinPageLoadTime = 2;

            PdfDocument doc = converter.ConvertHtmlString(sHTMLApolice);

            doc.Save(Server.MapPath("Uploads") + "\\" + dicApolice["NumeroAvisoCobranca"] + ".pdf");

            doc.Close();
        }

        private string getHTMLReciboCobranca(Dictionary<string, string> dicApolice)
        {

            StringBuilder sValue = new StringBuilder();

            sValue.Append("<table width=\"600\" cellpadding=\"1\" cellspacing=\"1\" style=\"font-family: Arial; font-size: 18px;padding-top:25px;text-align:left\" align=\"center\">");
            sValue.Append("<tr>");
            sValue.Append("<td colspan=\"4\" style=\"text-align:left\">&nbsp;</td>");
            sValue.Append("</tr> ");

            sValue.Append("<tr>");
            sValue.Append("<td colspan=\"4\" style=\"text-align:left\">&nbsp;</td>");
            sValue.Append("</tr> ");

            sValue.Append("<tr style=\"height:18px;\">");
            sValue.Append("<td width=\"150px\">&nbsp;</td>");
            sValue.Append("<td width=\"130px\">&nbsp;</td>");
            sValue.Append("<td width=\"120px\">&nbsp;</td>");
            sValue.Append("<td width=\"200px\"><strong>AVISO DE COBRANÇA</strong></td>");
            sValue.Append("</tr>");


            sValue.Append("<tr style=\"font-family: 'Arial Narrow'; font-size: 12px\">");
            sValue.Append("<td width=\"150px\">&nbsp;</td>");
            sValue.Append("<td width=\"130px\">&nbsp;</td>");
            sValue.Append("<td width=\"120px\">&nbsp;</td>");
            sValue.Append("<td width=\"200px\"><strong>" + dicApolice["NumeroAvisoCobranca"] + "</strong></td>");
            sValue.Append("</tr>");
            sValue.Append("<tr style=\"font-family: 'Arial Narrow'; font-size: 12px\">");
            sValue.Append("<td width=\"150px\">&nbsp;</td>");
            sValue.Append("<td width=\"130px\">&nbsp;</td>");
            sValue.Append("<td width=\"120px\">&nbsp;</td>");
            sValue.Append("<td width=\"200px\">" + dicApolice["Nome"] + "</td>");
            sValue.Append("</tr>");
            sValue.Append("<tr style=\"font-family: 'Arial Narrow'; font-size: 12px\">");

            sValue.Append("<td width=\"150px\">&nbsp;</td>");
            sValue.Append("<td width=\"130px\">&nbsp;</td>");
            sValue.Append("<td width=\"120px\">&nbsp;</td>");
            sValue.Append("<td width=\"200px\">" + dicApolice["Morada"] + "</td>");
            sValue.Append("</tr>");
            sValue.Append("<tr style=\"font-family: 'Arial Narrow'; font-size: 12px\">");

            sValue.Append("<td width=\"150px\">&nbsp;</td>");
            sValue.Append("<td width=\"130px\">&nbsp;</td>");
            sValue.Append("<td width=\"120px\">&nbsp;</td>");
            sValue.Append("<td width=\"200px\">" + dicApolice["Provincia"] + "</td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td colspan=\"4\" style=\"text-align:left\">&nbsp;</td>");
            sValue.Append("</tr> ");

            sValue.Append("</table>");


            sValue.Append("<table width=\"600\" cellpadding=\"0\" cellspacing=\"0\" style=\"font-family: 'Arial Narrow';font-size: 12px;text-align:left;vertical-align: middle;\" align=\"center\">");
            sValue.Append("<tbody>");
            sValue.Append("<tr>");
            sValue.Append("<td style=\"border-bottom:solid;border-color:gold\" width=\"40px\"><strong>APÓLICE</strong></td>");
            sValue.Append("<td colspan=\"3\" style=\"color:gold;border-bottom:solid\">&nbsp;</td>");
            sValue.Append("</tr>");
            sValue.Append("</tbody>");
            sValue.Append("</table>");


            sValue.Append("<table width=\"600\" cellpadding=\"1\" cellspacing=\"1\" style=\"font-family: 'Arial Narrow'; font-size: 12px;padding-top:5px;text-align:left\" align=\"center\">");
            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\"><strong>Ramo:</strong></td>");
            sValue.Append("<td width=\"130px\">Não Vida</td>");
            sValue.Append("<td width=\"100px\"><strong>Contacto Tel.:</strong></td>");
            sValue.Append("<td width=\"220px\">" + dicApolice["Telemovel"] + "</td>");
            sValue.Append("</tr>");
            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\"><strong>Produto:</strong></td>");
            sValue.Append("<td width=\"130px\">" + "Automóvel-" + Comum.General.getDescricaoProduto(dicApolice["TipoSeguroID"]) + "</td>");
            sValue.Append("<td width=\"100px\"><strong>Contacto e-mail.:</strong></td>");
            sValue.Append("<td width=\"220px\">" + dicApolice["Email"] + "</td>");
            sValue.Append("</tr>");
            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\"><strong>Apólice nº:</strong></td>");
            sValue.Append("<td width=\"130px\">" + dicApolice["NumeroApolice"] + "</td>");
            sValue.Append("<td width=\"100px\"></td>");
            sValue.Append("<td width=\"220px\"></td>");
            sValue.Append("</tr>");
            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\"><strong>Modalidade Pagamento:</strong></td>");
            sValue.Append("<td width=\"130px\">" + dicApolice["Fraccionamento"] + "</td>");
            sValue.Append("<td width=\"100px\"><strong>Data de Emissão:</strong></td>");
            sValue.Append("<td width=\"220px\">" + dicApolice["DataEmissao"] + "</td>");
            sValue.Append("</tr>");
            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\"><strong>Recibo nº:</strong></td>");
            sValue.Append("<td width=\"130px\">" + dicApolice["NumeroAvisoCobranca"] + "</td>");
            sValue.Append("<td width=\"100px\"></td>");
            sValue.Append("<td width=\"220px\"><strong>&nbsp;</strong></td>");
            sValue.Append("</tr>");
            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\"><strong>Agente/Mediador:</strong></td>");
            sValue.Append("<td width=\"130px\">" + dicApolice["BrokerName"] + "</td>");
            sValue.Append("<td width=\"100px\"><strong>Periodo do Recibo:</strong></td>");
            sValue.Append("<td width=\"220px\">" + dicApolice["DataInicio"].Substring(0, 10) + " A " + Comum.General.GetAddTime(dicApolice["Fraccionamento"], dicApolice["DataInicio"]) + "</td>");
            sValue.Append("</tr>");
            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\"><strong>Gestor:</strong></td>");
            sValue.Append("<td width=\"130px\">" + Comum.General.getLoggedUser() + "</td>");
            sValue.Append("<td width=\"100px\"></td>");
            sValue.Append("<td width=\"220px\"></td>");
            sValue.Append("</tr>");
            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\"><strong>Matrícula:</strong></td>");
            sValue.Append("<td width=\"130px\">" + dicApolice["Matricula"] + "</td>");
            sValue.Append("<td width=\"100px\"><strong>Limite Pagamento:</strong></td>");
            sValue.Append("<td width=\"220px\">" + dicApolice["DataInicio"] + "</td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td colspan=\"4\">&nbsp;</td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td colspan=\"4\">Estimado(a) Cliente,<br />Vimos por este meio informar que o valor abaixo indicado,</br>relativo ao prémio do seguro da apólice em referência,</br>deverá ser pago até 24 horas após o seu vencimento.</td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td colspan=\"4\">&nbsp;</td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td style=\"border-bottom:solid;border-color:gold\" width=\"150px\"><strong>PRÉMIO</strong></td>");
            sValue.Append("<td colspan=\"3\" style=\"border-bottom:solid;border-color:gold\" width=\"450px\"><strong>VALOR</strong></td>");
            //sValue.Append("<td width=\"100px\"></td>");
            //sValue.Append("<td width=\"220px\"><strong></strong></td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\">Prémio Simples</td>");
            sValue.Append("<td width=\"130px\">" + Comum.General.FormataNumero(dicApolice["PremioSimples"]) + "</td>");
            sValue.Append("<td width=\"100px\"></td>");
            sValue.Append("<td width=\"220px\"></td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\">Encargos</td>");
            sValue.Append("<td width=\"130px\">" + Comum.General.FormataNumero(dicApolice["Encargos"]) + "</td>");
            sValue.Append("<td width=\"100px\"></td>");
            sValue.Append("<td width=\"220px\"></td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\">Arseg</td>");
            sValue.Append("<td width=\"130px\">" + Comum.General.FormataNumero(dicApolice["Arseg"]) + "</td>");
            sValue.Append("<td width=\"100px\"></td>");
            sValue.Append("<td width=\"220px\"></td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\">FGA</td>");
            sValue.Append("<td width=\"130px\">" + Comum.General.FormataNumero(dicApolice["FGA"]) + "</td>");
            sValue.Append("<td width=\"100px\"></td>");
            sValue.Append("<td width=\"220px\"></td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\">Custo Apólice</td>");
            sValue.Append("<td width=\"130px\">" + Comum.General.FormataNumero(dicApolice["CustoApolice"]) + "</td>");
            sValue.Append("<td width=\"100px\"></td>");
            sValue.Append("<td width=\"220px\"></td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\"><strong>Total a Pagar</strong></td>");
            sValue.Append("<td width=\"130px\">" + Comum.General.FormataNumero(dicApolice["PremioTotal"]) + "</td>");
            sValue.Append("<td width=\"100px\"></td>");
            sValue.Append("<td width=\"220px\"></td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td colspan=\"4\">&nbsp;</td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td colspan=\"4\">Nos termos do Art.º 25º do Decreto Executivo n.º5/03, de 24 de Janeiro, o Segurado que não liquidar o prémio ou fracção do prémio devido está sujeito: <br/>  *A uma taxa de juros de mora equivalente á taxa de juro bancário a data de pagamento, com efeitos a partir do vencimento; <br/> *A suspensão das garantias a partir do 16º dia a contar do vencimento;<br/> *Se no decurso do prazo de suspensão se verificar o pagamento do prémio em dívida e dos respectivos juros, os efeitos do seguro reiniciam-se a partir das 12 horas do dia seguinte aquele em que o pagamento teve lugar; <br/> Durante o período de suspensão, a seguradora não responde por qualquer sinistro que ocorra após o 16º dia acima referido. <br/> Nos termos do Art.º 26 do mesmo Diploma legal, a resolução do contrato de seguro pela seguradora não exonera o Segurado ou <br/> Tomador de Seguro de liquidar os prémios em dívida relativos ao período em que o contrato produziu os seus efeitos, podendo a seguradora recorrer à cobrança coerciva.</td> ");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td colspan=\"4\">&nbsp;</td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td colspan=\"4\" style=\"font-weight:bold\">Sempre que o pagamento de prémio for efectuado por transferência bancária, cheque ou vale postal, agradecemos indicação do número da apólice e recibo. </td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td colspan=\"4\">&nbsp;</td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td style=\"border-bottom:solid;border-color:gold\" colspan=\"4\"><strong>COORDENADAS BANCÁRIAS</strong></td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\">BANCO BAI</td>");
            sValue.Append("<td width=\"130px\">Conta: 2143554.10.001</td>");
            sValue.Append("<td colspan=\"2\">IBAN: AO06 21435 5423 3232 4544 6</td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\">BANCO BIC</td>");
            sValue.Append("<td width=\"130px\">Conta: 2143554.10.001</td>");
            sValue.Append("<td colspan=\"2\">IBAN: AO06 21435 5423 3232 4544 6</td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\">BANCO BFA</td>");
            sValue.Append("<td width=\"130px\">Conta: 2143554.10.001</td>");
            sValue.Append("<td colspan=\"2\">IBAN: AO06 21435 5423 3232 4544 6</td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\">BANCO BESA</td>");
            sValue.Append("<td width=\"130px\">Conta: 2143554.10.001</td>");
            sValue.Append("<td colspan=\"2\">IBAN: AO06 21435 5423 3232 4544 6</td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\">BANCO BPC</td>");
            sValue.Append("<td width=\"130px\">Conta: 2143554.10.001</td>");
            sValue.Append("<td colspan=\"2\">IBAN: AO06 21435 5423 3232 4544 6</td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\">BANCO SOL</td>");
            sValue.Append("<td width=\"130px\">Conta: 2143554.10.001</td>");
            sValue.Append("<td colspan=\"2\">IBAN: AO06 21435 5423 3232 4544 6</td>");
            sValue.Append("</tr>");
            sValue.Append("</table>");


            return sValue.ToString();
        }

        private void ReciboPremio(Dictionary<string, string> dicApolice)
        {
            string pdf_page_size = "A4";
            string headerUrl = Server.MapPath("~/files/header.html");
            string footerUrl = Server.MapPath("~/files/footer.html");

            PdfPageSize pageSize = (PdfPageSize)Enum.Parse(typeof(PdfPageSize), pdf_page_size, true);

            string pdf_orientation = "Portrait";
            PdfPageOrientation pdfOrientation = (PdfPageOrientation)Enum.Parse(typeof(PdfPageOrientation), pdf_orientation, true);

            HtmlToPdf converter = new HtmlToPdf();

            // set converter options
            converter.Options.PdfPageSize = pageSize;
            converter.Options.PdfPageOrientation = pdfOrientation;

            converter.Options.DisplayHeader = true;
            converter.Options.DisplayFooter = true;
            converter.Options.MarginLeft = 10;
            converter.Options.MarginRight = 10;
            converter.Options.MarginTop = 10;
          
            converter.Header.Height = 60;
            converter.Footer.Height = 50;

            PdfHtmlSection headerHtml = new PdfHtmlSection(headerUrl);

            converter.Header.Add(headerHtml);

            PdfHtmlSection footerHtml = new PdfHtmlSection(footerUrl);
            footerHtml.AutoFitHeight = HtmlToPdfPageFitMode.AutoFit;
            converter.Footer.Add(footerHtml);

            string sHTMLApolice = getHTMLReciboPremio(dicApolice);

            PdfDocument doc = converter.ConvertHtmlString(sHTMLApolice, Comum.General.getBASE_URL());

            doc.Save(Server.MapPath("Uploads") + "\\" + dicApolice["NumeroAvisoCobranca"].Replace("AVC", "RCB") + ".pdf");
            //doc.Save(Response, false, dicApolice["NumeroApolice"] + ".pdf");
            doc.Close();
        }

        private string getHTMLReciboPremio(Dictionary<string, string> dicApolice)
        {

            StringBuilder sValue = new StringBuilder();

            sValue.Append("<table width=\"600\" cellpadding=\"1\" cellspacing=\"1\" style=\"font-family: Arial; font-size: 18px;padding-top:25px;text-align:left\" align=\"center\">");//;color:#7A5A00
            sValue.Append("<tr>");
            sValue.Append("<td colspan=\"4\" style=\"text-align:left\">&nbsp;</td>");
            sValue.Append("</tr> ");
            sValue.Append("<tr>");
            sValue.Append("<td colspan=\"4\" style=\"text-align:left\">&nbsp;</td>");
            sValue.Append("</tr> ");


            sValue.Append("<tr style=\"height:18px; \">");
            sValue.Append("<td width=\"150px\">&nbsp;</td>");
            sValue.Append("<td width=\"130px\">&nbsp;</td>");
            sValue.Append("<td width=\"120px\">&nbsp;</td>");
            sValue.Append("<td width=\"200px\"><strong>RECIBO DE PRÉMIO</strong></td>");
            sValue.Append("</tr>");

            sValue.Append("<tr style=\"height:18px;\">");
            sValue.Append("<td width=\"150px\">&nbsp;</td>");
            sValue.Append("<td width=\"130px\">&nbsp;</td>");
            sValue.Append("<td width=\"120px\">&nbsp;</td>");
            sValue.Append("<td width=\"200px\"><strong>ORIGINAL</strong></td>");
            //sValue.Append("<td width=\"200px\"><strong>" + (dicApolice["TotalImpressoes"]=="1"?"ORIGINAL":"2ª VIA") + "</strong></td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td colspan=\"4\" style=\"text-align:left\">&nbsp;</td>");
            sValue.Append("</tr> ");
            sValue.Append("</table>");

            sValue.Append("<table width=\"600\" cellpadding=\"1\" cellspacing=\"1\" style=\"font-family: 'Arial Narrow'; font-size: 12px;padding-top:5px;text-align:left\" align=\"center\">");
            sValue.Append("<tr>");
            sValue.Append("<td colspan=\"4\">Exmo(s). Sr(s)</td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td colspan=\"4\" style=\"text-align:left\">&nbsp;</td>");
            sValue.Append("</tr> ");

            sValue.Append("<tr>");
            sValue.Append("<td colspan=\"4\">Recebemos em " + DateTime.Now.Day.ToString("00") + " / " + DateTime.Now.Month.ToString("00") + " / " + DateTime.Now.Year.ToString("00") + " o pagamento do seguinte prémio de seguro: </td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td colspan=\"4\" style=\"text-align:left\">&nbsp;</td>");
            sValue.Append("</tr> ");

            sValue.Append("</table>");


            //TOMADOR SEGURO
            sValue.Append("<table width=\"600\" cellpadding=\"0\" cellspacing=\"0\" style=\"font-family: 'Arial Narrow';font-size: 12px;text-align:left;vertical-align: middle;\" align=\"center\">");
            sValue.Append("<tbody>");
            sValue.Append("<tr>");
            sValue.Append("<td colspan=\"2\" style=\"border-bottom:solid;border-color:gold\" width=\"40px\"><strong>TOMADOR DO SEGURO</strong></td>");
            sValue.Append("<td colspan=\"2\" style=\"color:gold;border-bottom:solid\">&nbsp;</td>");
            sValue.Append("</tr>");
            sValue.Append("</tbody>");
            sValue.Append("</table>");
            //DADOS TOMADOR SEGURO
            sValue.Append("<table width=\"600\" cellpadding=\"1\" cellspacing=\"1\" style=\"font-family: 'Arial Narrow'; font-size: 12px;padding-top:5px;text-align:left\" align=\"center\">");
            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\"><strong>Nº Cliente:</strong></td>");
            sValue.Append("<td colspan=\"3\">" + Comum.General.FormataNumeroCliente(dicApolice["ClienteID"]) + "</td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\"><strong>Nome:</strong></td>");
            sValue.Append("<td colspan=\"3\">" + dicApolice["Nome"] + "</td>");
            sValue.Append("</tr>");
            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\"><strong>Morada:</strong></td>");
            sValue.Append("<td colspan=\"3\">" + dicApolice["Morada"] + "</td>");
            sValue.Append("</tr>");
            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\"><strong>Província:</strong></td>");
            sValue.Append("<td colspan=\"3\">" + dicApolice["Provincia"] + "</td>");
            sValue.Append("</tr>");
            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\"><strong>Telemóvel:</strong></td>");
            sValue.Append("<td colspan=\"3\">" + dicApolice["Telemovel"] + "</td>");
            sValue.Append("</tr>");
            sValue.Append("<tr>");
            sValue.Append("<td colspan=\"4\">&nbsp;</td>");
            sValue.Append("</tr>");
            sValue.Append("</table>");

            //APÓLICE
            sValue.Append("<table width=\"600\" cellpadding=\"0\" cellspacing=\"0\" style=\"font-family: 'Arial Narrow';font-size: 12px;text-align:left;vertical-align: middle;\" align=\"center\">");
            sValue.Append("<tbody>");
            sValue.Append("<tr>");
            sValue.Append("<td style=\"border-bottom:solid;border-color:gold\" width=\"40px\"><strong>APÓLICE</strong></td>");
            sValue.Append("<td colspan=\"3\" style=\"color:gold;border-bottom:solid\">&nbsp;</td>");
            sValue.Append("</tr>");
            sValue.Append("</tbody>");
            sValue.Append("</table>");
            //DADOS APÓLICE
            sValue.Append("<table width=\"600\" cellpadding=\"1\" cellspacing=\"1\" style=\"font-family: 'Arial Narrow'; font-size: 12px;padding-top:5px;text-align:left\" align=\"center\">");
            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\"><strong>Agente/Mediador:</strong></td>");
            sValue.Append("<td width=\"130px\">" + dicApolice["BrokerName"] + "</td>");
            sValue.Append("<td width=\"100px\"></td>");
            sValue.Append("<td width=\"220px\"></td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\"><strong>Gestor:</strong></td>");
            sValue.Append("<td width=\"130px\">" + Comum.General.getLoggedUser() + "</td>");
            sValue.Append("<td width=\"100px\"></td>");
            sValue.Append("<td width=\"220px\"></td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\"><strong>Ramo:</strong></td>");
            sValue.Append("<td width=\"130px\">Não Vida</td>");
            sValue.Append("<td width=\"100px\"></td>");
            sValue.Append("<td width=\"220px\"></td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\"><strong>Produto:</strong></td>");
            sValue.Append("<td width=\"130px\">Automóvel" + (Comum.General.getDescricaoProduto(dicApolice["TipoSeguroID"])==string.Empty?"":"-" + Comum.General.getDescricaoProduto(dicApolice["TipoSeguroID"])) + "</td>");
            sValue.Append("<td width=\"100px\"><strong>Matrícula:</strong></td>");
            sValue.Append("<td width=\"220px\">" + dicApolice["Matricula"] + "</td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\"><strong>Apólice nº:</strong></td>");
            sValue.Append("<td width=\"130px\">" + dicApolice["NumeroApolice"] + "</td>");
            sValue.Append("<td width=\"100px\"><strong>Data de Emissão:</strong></td>");
            sValue.Append("<td width=\"220px\">" + dicApolice["DataEmissao"] + "</td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\"><strong>Recibo nº:</strong></td>");
            sValue.Append("<td width=\"130px\">" + dicApolice["NumeroAvisoCobranca"] + "</td>");
            sValue.Append("<td width=\"100px\"><strong>Periodo do Recibo:</strong></td>");
            sValue.Append("<td width=\"220px\">" + dicApolice["DataInicio"].Substring(0, 10) + " A " + Comum.General.GetAddTime(dicApolice["Fraccionamento"], dicApolice["DataInicio"]) + "</td>");

            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\"><strong>Modalidade Pagamento:</strong></td>");
            sValue.Append("<td width=\"130px\">" + dicApolice["Fraccionamento"] + "</td>");
            sValue.Append("<td width=\"100px\"><strong>Limite Pagamento:</strong></td>");
            sValue.Append("<td width=\"220px\">" + dicApolice["DataInicio"] + "</td>");
            sValue.Append("</tr>");
            sValue.Append("<tr>");
            sValue.Append("<td colspan=\"4\">&nbsp;</td>");
            sValue.Append("</tr>");
            sValue.Append("</table>");

            //PRÉMIO
            sValue.Append("<table width=\"600\" cellpadding=\"0\" cellspacing=\"0\" style=\"font-family: 'Arial Narrow';font-size: 12px;text-align:left;vertical-align: middle;\" align=\"center\">");
            sValue.Append("<tbody>");
            sValue.Append("<tr>");
            sValue.Append("<td style=\"border-bottom:solid;border-color:gold\" width=\"40px\"><strong>PRÉMIO</strong></td>");
            sValue.Append("<td colspan=\"3\" style=\"color:gold;border-bottom:solid\">&nbsp;</td>");
            sValue.Append("</tr>");
            sValue.Append("</tbody>");
            sValue.Append("</table>");

            //DADOS PRÉMIO
            sValue.Append("<table width=\"600\" cellpadding=\"1\" cellspacing=\"1\" style=\"font-family: 'Arial Narrow'; font-size: 12px;padding-top:5px;text-align:left\" align=\"center\">");
            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\">Prémio Simples</td>");
            sValue.Append("<td width=\"130px\">" + Comum.General.FormataNumero(dicApolice["PremioSimples"]) + "</td>");
            sValue.Append("<td width=\"100px\"></td>");
            sValue.Append("<td width=\"220px\"></td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\">Encargos</td>");
            sValue.Append("<td width=\"130px\">" + Comum.General.FormataNumero(dicApolice["Encargos"]) + "</td>");
            sValue.Append("<td width=\"100px\"></td>");
            sValue.Append("<td width=\"220px\"></td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\">Arseg</td>");
            sValue.Append("<td width=\"130px\">" + Comum.General.FormataNumero(dicApolice["Arseg"]) + "</td>");
            sValue.Append("<td width=\"100px\"></td>");
            sValue.Append("<td width=\"220px\"></td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\">FGA</td>");
            sValue.Append("<td width=\"130px\">" + Comum.General.FormataNumero(dicApolice["FGA"]) + "</td>");
            sValue.Append("<td width=\"100px\"></td>");
            sValue.Append("<td width=\"220px\"></td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\">Custo Apólice</td>");
            sValue.Append("<td width=\"130px\">" + Comum.General.FormataNumero(dicApolice["CustoApolice"]) + "</td>");
            sValue.Append("<td width=\"100px\"></td>");
            sValue.Append("<td width=\"220px\"></td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\"><strong>Total a Pagar</strong></td>");
            sValue.Append("<td width=\"130px\">" + Comum.General.FormataNumero(dicApolice["PremioTotal"]) + "</td>");
            sValue.Append("<td width=\"100px\"></td>");
            sValue.Append("<td width=\"220px\"></td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td colspan=\"4\" align=\"right\" style=\"padding-bottom:15px;padding-right:250px\">&nbsp;</td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td colspan=\"4\" align=\"right\" style=\"padding-bottom:15px;padding-right:250px\">&nbsp;</td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td colspan=\"4\" align=\"right\" style=\"padding-bottom:15px;padding-right:250px\">&nbsp;</td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td colspan=\"4\" align=\"right\" style=\"padding-bottom:15px;padding-right:250px\"><img width=\"239\" height=\"100\" src=\"" + Comum.General.getBASE_URL() + "images/stamp.jpg" + "\" /></td>");
            sValue.Append("</tr>");



            sValue.Append("</table>");

            return sValue.ToString();
        }

        private void Apolice(Dictionary<string, string> dicApolice)
        {
            string pdf_page_size = "A4";
            string headerUrl = Server.MapPath("~/files/header.html");
            string footerUrl = Server.MapPath("~/files/footer.html");

            PdfPageSize pageSize = (PdfPageSize)Enum.Parse(typeof(PdfPageSize), pdf_page_size, true);

            string pdf_orientation = "Portrait";
            PdfPageOrientation pdfOrientation = (PdfPageOrientation)Enum.Parse(typeof(PdfPageOrientation), pdf_orientation, true);

            HtmlToPdf converter = new HtmlToPdf();

            // set converter options
            converter.Options.PdfPageSize = pageSize;
            converter.Options.PdfPageOrientation = pdfOrientation;

            converter.Options.DisplayHeader = true;
            converter.Options.DisplayFooter = true;
            converter.Options.MarginLeft = 10;
            converter.Options.MarginRight = 10;

            converter.Header.Height = 60;
            converter.Footer.Height = 50;

            PdfHtmlSection headerHtml = new PdfHtmlSection(headerUrl);

            converter.Header.Add(headerHtml);

            PdfHtmlSection footerHtml = new PdfHtmlSection(footerUrl);
            footerHtml.AutoFitHeight = HtmlToPdfPageFitMode.AutoFit;
            converter.Footer.Add(footerHtml);

            string sHTMLApolice = getHTMLApolice(dicApolice);

            //PdfDocument doc1 = new PdfDocument();
            //doc1 = converter.ConvertHtmlString(sHTMLApolice, Comum.General.getBASE_URL());

            //PdfDocument doc2 = new PdfDocument();
            //doc2 = converter.ConvertHtmlString(sHTMLApolice, Comum.General.getBASE_URL());


            PdfDocument doc = new PdfDocument();
            doc = converter.ConvertHtmlString(sHTMLApolice, Comum.General.getBASE_URL());
            //doc.Append(doc1);
            //doc.Append(doc2);



            doc.Save(Server.MapPath("Uploads") + "\\" + dicApolice["NumeroApolice"] + ".pdf");

            doc.Close();
        }

        public static string getHTMLApolice(Dictionary<string, string> dicApolice)
        {
            StringBuilder sValue = new StringBuilder();

            sValue.Append("<table width=\"600\" cellpadding=\"1\" cellspacing=\"1\" style=\"font-family: Arial; font-size: 18px;padding-top:25px;text-align:left\" align=\"center\">");
            sValue.Append("<tr>");
            sValue.Append("<td colspan=\"4\" style=\"text-align:left\">&nbsp;</td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td colspan=\"4\" style=\"text-align:left\">&nbsp;</td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td colspan=\"4\" style=\"text-align:left\">&nbsp;</td>");
            sValue.Append("</tr>");

            sValue.Append("<tr style=\"color:black;height:18px;\">");
            sValue.Append("<td width=\"150px\">&nbsp;</td>");
            sValue.Append("<td width=\"130px\">&nbsp;</td>");
            sValue.Append("<td width=\"120px\">&nbsp;</td>");
            sValue.Append("<td width=\"200px\"><strong>APÓLICE</strong></td>");
            sValue.Append("</tr>");
            sValue.Append("</tr>");
            sValue.Append("<tr style=\"font-size:14px\">");
            sValue.Append("<td width=\"150px\">&nbsp;</td>");
            sValue.Append("<td width=\"130px\">&nbsp;</td>");
            sValue.Append("<td width=\"120px\">&nbsp;</td>");
            sValue.Append("<td width=\"200px\"><strong>CONDIÇÕES PARTICULARES</strong></td>");
            sValue.Append("</tr>");
            sValue.Append("<tr style=\"font-size:14px\">");
            sValue.Append("<td width=\"150px\">&nbsp;</td>");
            sValue.Append("<td width=\"130px\">&nbsp;</td>");
            sValue.Append("<td width=\"120px\">&nbsp;</td>");
            sValue.Append("<td width=\"200px\"><strong>AUTOMÓVEL</strong></td>");
            sValue.Append("</tr>");
            sValue.Append("</table>");

            sValue.Append("<table width=\"600\" cellpadding=\"0\" cellspacing=\"0\" style=\"font-family: 'Arial Narrow'; font-size: 12px;padding-top:25px;text-align:left\" align=\"center\">");
            sValue.Append("<tr>");
            sValue.Append("<td colspan=\"4\" style=\"text-align:left\"><strong>&nbsp;</strong></td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td style=\"border-bottom:solid;border-color:gold\" width=\"40px\"><strong>APÓLICE</strong></td>");
            sValue.Append("<td colspan=\"2\" style=\"color:gold;border-bottom:solid\"  width=\"250px\">&nbsp;</td>");
            sValue.Append("<td style=\"border-bottom:solid;border-color:gold\" width=\"200px\"><strong>TOMADOR DO SEGURO</strong></td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\"><strong>Ramo:</strong></td>");
            sValue.Append("<td width=\"130px\">Não Vida</td>");
            sValue.Append("<td width=\"120px\"></td>");
            sValue.Append("<td width=\"200px\">" + dicApolice["Nome"] + "</td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\"><strong>Produto:</strong></td>");
            sValue.Append("<td width=\"130px\">Automóvel-" + (dicApolice["TipoSeguroID"]== string.Empty? "Lista Anexa": Comum.General.GetListProdutoAuto()[dicApolice["TipoSeguroID"]]) + " </td>");
            sValue.Append("<td width=\"120px\"></td>");
            sValue.Append("<td width=\"200px\">" + dicApolice["Morada"] + "</td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\"><strong>Cliente nº:</strong></td>");
            sValue.Append("<td width=\"130px\">" + Comum.General.FormataNumeroCliente(dicApolice["ClienteID"]) + " </td>");
            sValue.Append("<td width=\"120px\"></td>");
            sValue.Append("<td width=\"200px\">" + dicApolice["Provincia"] + " </td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\"><strong>Proposta nº:</strong></td>");
            sValue.Append("<td width=\"130px\">" + Comum.General.FormataProposta(dicApolice["PropostaID"], "AUTO") + " </td>");
            sValue.Append("<td width=\"120px\"></td>");
            sValue.Append("<td width=\"200px\"></td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\"><strong>Agente/Mediador:</strong></td>");
            sValue.Append("<td width=\"130px\">" + Comum.General.getLoggedUser() + " </td>");
            sValue.Append("<td width=\"120px\"></td>");
            sValue.Append("<td width=\"200px\"><strong>QUALIDADE DO TOMADOR</strong></td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\"><strong>Unidade de Negócio:</strong></td>");
            sValue.Append("<td width=\"130px\">" + dicApolice["BrokerName"] + " </td>");
            sValue.Append("<td width=\"120px\"></td>");
            sValue.Append("<td width=\"200px\">" + Comum.General.GetListQualidadeTomador()[dicApolice["QualidadeTomadorID"]] + " </td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\"><strong>Fraccionamento:</strong></td>");
            sValue.Append("<td width=\"130px\">" + dicApolice["Fraccionamento"] + " </td>");
            sValue.Append("<td width=\"120px\"></td>");
            sValue.Append("<td width=\"200px\"></td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\"></td>");
            sValue.Append("<td width=\"130px\"></td>");
            sValue.Append("<td width=\"120px\"></td>");
            sValue.Append("<td width=\"200px\"><strong>VEÍCULO SEGURO</strong></td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\"><strong>Prazos de Validade:</strong></td>");
            sValue.Append("<td width=\"130px\"></td>");
            sValue.Append("<td width=\"120px\"><strong>Pagamento</strong></td>");
            sValue.Append("<td width=\"200px\"><strong>Marca/Modelo: </strong>" + (dicApolice["MarcaID"]==string.Empty? "Lista Anexa ": Comum.General.GetListMarca()[dicApolice["MarcaID"]] + " " + Comum.General.GetListModelo(dicApolice["MarcaID"])[dicApolice["ModeloID"]]) + "</td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\">Início: ás 0 horas de:</td>");
            sValue.Append("<td width=\"130px\">" + dicApolice["DataInicio"].Substring(0, 10) + " </td>");
            sValue.Append("<td width=\"120px\">Cobrança Directa</td>");
            sValue.Append("<td width=\"200px\"><strong>Dt. 1ª Matrícula/Construção: </strong>" + dicApolice["DataFabrico"] + "</td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\">Renovação/Termo:ás 24 horas de:</td>");
            sValue.Append("<td width=\"130px\">" + Comum.General.GetAddTime(dicApolice["Fraccionamento"], dicApolice["DataInicio"]) + " </td>");
            sValue.Append("<td width=\"120px\"></td>");
            sValue.Append("<td width=\"200px\"><strong>Matrícula: </strong>" + dicApolice["Matricula"] + "</td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\"></td>");
            sValue.Append("<td width=\"130px\"></td>");
            sValue.Append("<td width=\"120px\"></td>");
            sValue.Append("<td width=\"200px\"><strong>Cilindrada: </strong>" + dicApolice["Cilindrada"] + " c.c </td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\"><strong></strong></td>");
            sValue.Append("<td width=\"130px\"></td>");
            sValue.Append("<td width=\"120px\"></td>");
            sValue.Append("<td width=\"200px\"><strong>Nº Lugares: </strong>" + dicApolice["Lugares"] + "</td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\"></td>");
            sValue.Append("<td width=\"130px\"></td>");
            sValue.Append("<td width=\"120px\"></td>");
            sValue.Append("<td width=\"200px\"><strong>Uso: </strong>" + (dicApolice["UsoID"]==string.Empty? "" : Comum.General.GetListUso()[dicApolice["UsoID"]]) + "</td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td colspan=\"3\"><!--<strong>Moeda de contratação: </strong> AOA	 <strong>Tx. Câmbio USD/AOA:</strong> 99,50	<strong>Dt. Câmbio: </strong>" + DateTime.Now.ToString().Substring(0, 10) + "--></td>");
            sValue.Append("<td width=\"200px\"><strong>Nº Chassis: </strong>" + dicApolice["Chassi"] + "</td>");
            sValue.Append("</tr>");

           

            //Se Não existir Veiculo com Marca entao estamos perante uma apólice Frota
            if (dicApolice["MarcaID"] != string.Empty && dicApolice["ModeloID"]!= string.Empty)
            {
                sValue.Append("<tr>");
                sValue.Append("<td colspan=\"4\">&nbsp;</td>");
                sValue.Append("</tr>");

                sValue.Append("<tr>");
                sValue.Append("<td style=\"border-bottom:solid;border-color:gold\" width=\"150px\"><strong>COBERTURAS</strong></td>");
                sValue.Append("<td style=\"border-bottom:solid;border-color:gold\" width=\"130px\"></td>");
                sValue.Append("<td style=\"border-bottom:solid;border-color:gold\" width=\"120px\"><strong>VALORES LIMITE</strong></td>");
                sValue.Append("<td style=\"border-bottom:solid;border-color:gold\" width=\"200px\"><strong>FRANQUIA</strong></td>");
                sValue.Append("</tr>");

                sValue.Append("<tr>");
                sValue.Append("<td width=\"150px\">Responsabilidade Civil Obrigatória</td>");
                sValue.Append("<td width=\"130px\"></td>");
                sValue.Append("<td width=\"120px\">" + Comum.General.FormataNumeroValorNulo(dicApolice["RespCivilValor"]) + " </td>");
                sValue.Append("<td width=\"200px\" style=\"text-align:left\">" + "Sem Franquia" + "</td>");
                sValue.Append("</tr>");

                sValue.Append("<tr>");
                sValue.Append("<td width=\"150px\">Ocupantes</td>");
                sValue.Append("<td width=\"130px\"></td>");
                sValue.Append("<td width=\"120px\">" + Comum.General.FormataNumeroValorNulo(dicApolice["RespCivilValor"]) + "</td>");
                sValue.Append("<td width=\"200px\">" + Comum.General.FormataNumeroValorNulo(dicApolice["OcupantesFranquia"]) + "</td>");
                sValue.Append("</tr>");

                sValue.Append("<tr>");
                sValue.Append("<td width=\"150px\">Morte ou Invalidez Permanente</td>");
                sValue.Append("<td width=\"130px\"></td>");
                sValue.Append("<td width=\"120px\">" + Comum.General.FormataNumeroValorNulo(dicApolice["MorteInvalidezValor"]) + "</td>");
                sValue.Append("<td width=\"200px\">" + Comum.General.FormataNumeroValorNulo(dicApolice["MorteInvalidezFranquia"]) + "</td>");
                sValue.Append("</tr>");

                sValue.Append("<tr>");
                sValue.Append("<td width=\"150px\">Despesas de Tratamento</td>");
                sValue.Append("<td width=\"130px\"></td>");
                sValue.Append("<td width=\"120px\">" + Comum.General.FormataNumeroValorNulo(dicApolice["DespesasTratamentoValor"]) + "</td>");
                sValue.Append("<td width=\"200px\">" + Comum.General.FormataNumeroValorNulo(dicApolice["DespesasTratamentoFranquia"]) + "</td>");
                sValue.Append("</tr>");

                sValue.Append("<tr>");
                sValue.Append("<td width=\"150px\">Despesas de Funeral</td>");
                sValue.Append("<td width=\"130px\"></td>");
                sValue.Append("<td width=\"120px\">" + Comum.General.FormataNumeroValorNulo(dicApolice["DespesasFuneralValor"]) + "</td>");
                sValue.Append("<td width=\"200px\">" + Comum.General.FormataNumeroValorNulo(dicApolice["DespesasFuneralFranquia"]) + "</td>");
                sValue.Append("</tr>");

                sValue.Append("<tr>");
                sValue.Append("<td width=\"150px\">Choque Colisão ou Capotamento</td>");
                sValue.Append("<td width=\"130px\"></td>");
                sValue.Append("<td width=\"120px\">" + Comum.General.FormataNumeroValorNulo(dicApolice["ChoqueColisaoValor"]) + "</td>");
                sValue.Append("<td width=\"200px\">" + Comum.General.FormataNumeroValorNulo(dicApolice["ChoqueColisaoFranquia"]) + "</td>");
                sValue.Append("</tr>");

                sValue.Append("<tr>");
                sValue.Append("<td width=\"150px\">Furto ou Roubo</td>");
                sValue.Append("<td width=\"130px\"></td>");
                sValue.Append("<td width=\"120px\">" + Comum.General.FormataNumeroValorNulo(dicApolice["FurtoRouboValor"]) + "</td>");
                sValue.Append("<td width=\"200px\">" + Comum.General.FormataNumeroValorNulo(dicApolice["FurtoRouboFranquia"]) + "</td>");
                sValue.Append("</tr>");

                sValue.Append("<tr>");
                sValue.Append("<td width=\"150px\">Incêndio, Raio ou Explosão</td>");
                sValue.Append("<td width=\"130px\"></td>");
                sValue.Append("<td width=\"120px\">" + Comum.General.FormataNumeroValorNulo(dicApolice["IncendioRaioValor"]) + "</td>");
                sValue.Append("<td width=\"200px\">" + Comum.General.FormataNumeroValorNulo(dicApolice["IncendioRaioFranquia"]) + "</td>");
                sValue.Append("</tr>");

                //A OPÇÂO EXTRA só aparece se existir, ou seja, se for diferente de "0"
                if (dicApolice["ValorOpcaoExtra"] != string.Empty)
                    if (double.Parse(dicApolice["ValorOpcaoExtra"].ToString()) != 0)
                    {
                        sValue.Append("<tr>");
                        sValue.Append("<td width=\"150px\">Extra</td>");
                        sValue.Append("<td width=\"130px\"></td>");
                        sValue.Append("<td width=\"120px\"></td>");
                        sValue.Append("<td width=\"200px\">" + Comum.General.FormataNumero(dicApolice["ValorOpcaoExtra"]) + "</td>");
                        sValue.Append("</tr>");
                    }
            }
            //PREMIO TOTAL E PARCELAS
            sValue.Append("<tr>");
            sValue.Append("<td colspan=\"4\">&nbsp;</td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td style=\"border-bottom:solid;border-color:gold\" width=\"150px\"><strong>PRÉMIO</strong></td>");
            sValue.Append("<td style=\"border-bottom:solid;border-color:gold\" width=\"130px\"></td>");
            sValue.Append("<td style=\"border-bottom:solid;border-color:gold\" width=\"120px\"><strong></strong></td>");
            sValue.Append("<td style=\"border-bottom:solid;border-color:gold\" width=\"200px\"><strong>VALOR</strong></td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\">Prémio Simples</td>");
            sValue.Append("<td width=\"130px\"></td>");
            sValue.Append("<td width=\"120px\"></td>");
            sValue.Append("<td width=\"200px\">" + Comum.General.FormataNumero(dicApolice["PremioSimples"]) + "</td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\">Encargos</td>");
            sValue.Append("<td width=\"130px\"></td>");
            sValue.Append("<td width=\"120px\"></td>");
            sValue.Append("<td width=\"200px\">" + Comum.General.FormataNumero(dicApolice["Encargos"]) + "</td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\">Arseg</td>");
            sValue.Append("<td width=\"130px\"></td>");
            sValue.Append("<td width=\"120px\"></td>");
            sValue.Append("<td width=\"200px\">" + Comum.General.FormataNumero(dicApolice["Arseg"]) + "</td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\">FGA</td>");
            sValue.Append("<td width=\"130px\"></td>");
            sValue.Append("<td width=\"120px\"></td>");
            sValue.Append("<td width=\"200px\">" + Comum.General.FormataNumero(dicApolice["FGA"]) + "</td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\">Custo Apólice</td>");
            sValue.Append("<td width=\"130px\"></td>");
            sValue.Append("<td width=\"120px\"></td>");
            sValue.Append("<td width=\"200px\">" + Comum.General.FormataNumero(dicApolice["CustoApolice"]) + "</td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\"><strong>Prémio Total</strong></td>");
            sValue.Append("<td width=\"130px\"></td>");
            sValue.Append("<td width=\"120px\"></td>");
            sValue.Append("<td width=\"200px\"><strong>" + Comum.General.FormataNumero(dicApolice["PremioTotal"]) + "</strong></td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td colspan=\"4\">&nbsp;</td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td colspan=\"4\">&nbsp;</td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td colspan=\"4\">&nbsp;</td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\"></td>");
            sValue.Append("<td width=\"130px\"></td>");
            sValue.Append("<td width=\"120px\"></td>");
            sValue.Append("<td width=\"200px\"><strong></strong></td>");
            sValue.Append("</tr>");

            sValue.Append("<tr style=\"font-size: 11px;\">");
            sValue.Append("<td colspan=\"4\">Este Contrato de seguro é constituído pelas Condições Gerais, Especiais e Particulares anexas e ainda pela Proposta que lhe serviu de base.Deverá ser conferido e assinado pelo Tomador de Seguro, após o que deverá ser devolvido um exemplar á Seguradora.Todavia, não havendo manifestação em contrário, será tido como inteiramente conforme, mesmo que não se tenha verificado a devolução do exemplar assinado á Seguradora </ td > ");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td colspan=\"4\" align=\"right\" style=\"padding-bottom:15px;padding-right:250px\">&nbsp;</td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td colspan=\"4\" align=\"right\" style=\"padding-bottom:15px;padding-right:250px\">&nbsp;</td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td colspan=\"4\" align=\"right\" style=\"padding-bottom:15px;padding-right:250px\">&nbsp;</td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td colspan=\"4\" align=\"right\" style=\"padding-bottom:15px;padding-right:250px\"><img width=\"239\" height=\"100\" src=\"" + Comum.General.getBASE_URL() + "images/stamp.jpg" + "\" /></td>");
            sValue.Append("</tr>");
            sValue.Append("</table>");

            return sValue.ToString();

        }

        private void Certificado(Dictionary<string, string> dicApolice)
        {
            string pdf_page_size = "A4";
            string headerUrl = Server.MapPath("~/files/header.html");
            string footerUrl = Server.MapPath("~/files/footer.html");

            PdfPageSize pageSize = (PdfPageSize)Enum.Parse(typeof(PdfPageSize), pdf_page_size, true);

            string pdf_orientation = "Portrait";
            PdfPageOrientation pdfOrientation = (PdfPageOrientation)Enum.Parse(typeof(PdfPageOrientation), pdf_orientation, true);

            HtmlToPdf converter = new HtmlToPdf();

            // set converter options
            converter.Options.PdfPageSize = pageSize;
            converter.Options.PdfPageOrientation = pdfOrientation;

            converter.Options.DisplayHeader = true;
            converter.Options.DisplayFooter = true;
            converter.Options.MarginLeft = 10;
            converter.Options.MarginRight = 10;

            converter.Header.Height = 60;
            converter.Footer.Height = 50;

            PdfHtmlSection headerHtml = new PdfHtmlSection(headerUrl);

            converter.Header.Add(headerHtml);

            PdfHtmlSection footerHtml = new PdfHtmlSection(footerUrl);
            footerHtml.AutoFitHeight = HtmlToPdfPageFitMode.AutoFit;
            converter.Footer.Add(footerHtml);

            string sHTMLApolice = getHTMLCertificado(dicApolice);

            PdfDocument doc = converter.ConvertHtmlString(sHTMLApolice, Comum.General.getBASE_URL());

            doc.Save(Server.MapPath("Uploads") + "\\" + dicApolice["NumeroApolice"] + "_CERTIFICADO.pdf");

            doc.Close();
        }

        public static string getHTMLCertificado(Dictionary<string, string> dicApolice)
        {
            StringBuilder sValue = new StringBuilder();



            sValue.Append("<table width=\"100%\">");
            sValue.Append("<tr>");
            sValue.Append("<td align=\"center\">");

            sValue.Append("<table width=\"800\" cellpadding=\"1\" cellspacing=\"1\" style=\"font-family: 'Times New Roman'; font-size: 17px;padding-top:25px;text-align:center\">");
            sValue.Append("<tr>");
            sValue.Append("<td colspan=\"4\" style=\"text-align:center\"><img width=\"60\" height=\"74\" src=\"" + Comum.General.getBASE_URL() + "images/angola_logo-republica.png" + "\" /></td>");
            sValue.Append("</tr>");
            sValue.Append("<tr>");
            sValue.Append("<td colspan=\"4\" style=\"text-align:center;color:black;border-bottom:solid; border-bottom-width:1px\"><strong>REPÚBLICA DE ANGOLA</strong></td>");
            sValue.Append("</tr>");
            sValue.Append("</table>");

            sValue.Append("<table width=\"800\" cellpadding=\"1\" cellspacing=\"1\" style=\"font-family: 'Arial Narrow'; font-style ;padding-top:5px;text-align:center\">");
            sValue.Append("<tr>");
            sValue.Append("<td colspan=\"4\" style=\"text-align:center\"><strong>CERTIFICADO DE RESPONSABILIDADE CIVIL AUTOMÓVEL Nº</strong>&nbsp;&nbsp;<span style=\"font-family: 'Arial Narrow'; font-size: 14px;\">00211249</span></td>");
            sValue.Append("</tr>");
            sValue.Append("</table>");

            sValue.Append("<table width=\"800\" cellpadding=\"1\" cellspacing=\"1\" style=\"font-family: 'Arial Narrow'; font-size: 14px;padding-top:5px;padding-left:20px;text-align:left\">");
            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\" style=\"padding-bottom:5px\"><strong>Nome do Tomador:</strong></td>");
            sValue.Append("<td width=\"200px\">" + dicApolice["Nome"] + "</td>");
            sValue.Append("<td width=\"200px\"></td>");
            sValue.Append("<td width=\"250px\"></td>");
            sValue.Append("</tr>");
            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\" style=\"padding-bottom:5px\"><strong>Morada do Tomador:</strong></td>");
            sValue.Append("<td colspan=\"2\" width=\"400px\">" + dicApolice["Morada"] + " </td>");
            sValue.Append("<td width=\"250px\"></td>");
            sValue.Append("</tr>");
            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\" style=\"padding-bottom:5px\"><strong>Povíncia:</strong></td>");
            sValue.Append("<td width=\"200px\">" + dicApolice["Provincia"] + "</td>");
            sValue.Append("<td width=\"200px\"></td>");
            sValue.Append("<td width=\"250px\"></td>");
            sValue.Append("</tr>");
            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\" style=\"padding-bottom:5px\"><strong>Nº Apólice:</strong></td>");
            sValue.Append("<td width=\"200px\">" + dicApolice["NumeroApolice"] + " </td>");
            sValue.Append("<td width=\"200px\"></td>");
            sValue.Append("<td width=\"250px\"></td>");
            sValue.Append("</tr>");
            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\" style=\"padding-bottom:5px\"><strong>Categoria Veículo:</strong></td>");
            sValue.Append("<td width=\"200px\">" + Comum.General.GetListTipoCategoria()[dicApolice["TipoCategoriaID"]] + "</td>");
            sValue.Append("<td width=\"200px\"><strong>Marca:</strong>&nbsp;&nbsp;" + Comum.General.GetListMarca()[dicApolice["MarcaID"]] + " " + Comum.General.GetListModelo(dicApolice["MarcaID"])[dicApolice["ModeloID"]] + "</td>");
            sValue.Append("<td width=\"250px\"></td>");
            sValue.Append("</tr>");
            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\" style=\"padding-bottom:5px\"><strong>MATRÍCULA:</strong></td>");
            sValue.Append("<td width=\"200px\">" + dicApolice["Matricula"] + "</td>");
            sValue.Append("<td width=\"200px\"><strong>CHASSI/QUADRO:</strong>&nbsp;&nbsp;" + dicApolice["Chassi"] + "</td>");
            sValue.Append("<td width=\"250px\"></td>");
            sValue.Append("</tr>");
            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\"><strong>Validade do Certificado</strong></td>");
            sValue.Append("<td width=\"200px\"><strong>Data de Início:</strong>&nbsp;&nbsp;" + dicApolice["DataInicio"].Substring(0, 10) + "</td>");
            sValue.Append("<td width=\"200px\"><strong>Data de Termo:</strong>&nbsp;&nbsp;" + Comum.General.GetAddTime(dicApolice["Fraccionamento"], dicApolice["DataInicio"]) + "</td>");
            sValue.Append("<td width=\"250px\"></td>");
            sValue.Append("</tr>");
            sValue.Append("<tr>");
            sValue.Append("<td colspan=\"4\">&nbsp;</td>");
            sValue.Append("</tr>");
            sValue.Append("<tr>");
            sValue.Append("<td colspan=\"4\" align=\"right\" style=\"padding-bottom:15px;padding-right:250px\"><img width=\"239\" height=\"100\" src=\"" + Comum.General.getBASE_URL() + "images/stamp.jpg" + "\" /></td>");
            sValue.Append("</tr>");
            sValue.Append("</table>");
            //SEPARADOR

            sValue.Append("<table width=\"800\" cellpadding=\"1\" cellspacing=\"1\" style=\"font-family: 'Times New Roman'; font-size: 17px;padding-top:50px;text-align:center\">");
            sValue.Append("<tr>");
            sValue.Append("<td colspan=\"4\" style=\"text-align:center;color:gray;border-bottom:dashed; border-bottom-width:5px\"></td>");
            sValue.Append("</tr>");
            sValue.Append("</table>");


            sValue.Append("</td>");
            sValue.Append("</tr>");
            sValue.Append("</table>");

            //DÍSTICO
            sValue.Append("<table width=\"100%\">");
            sValue.Append("<tr>");
            sValue.Append("<td align=\"center\">");

            sValue.Append("<table width=\"100%\"  align=\"left\" cellpadding=\"1\" cellspacing=\"1\" style=\"font-family: 'Times New Roman'; font-size: 13px;padding-top:85px;text-align:center\">");
            sValue.Append("<tr>");
            sValue.Append("<td>");
            sValue.Append("<table width=\"425\" align=\"center\"  cellpadding=\"3\" cellspacing=\"1\" style=\"font-family: Arial Narrow; font-size: 13px;padding-top:7px;text-align:center;border-top:1px solid;border-bottom:1px solid;border-left:1px solid;border-right:1px solid;padding: 7px 25px 3px 25px\">");
            sValue.Append("<tr>");
            sValue.Append("<td colspan=\"4\" style=\"text-align:center\"><img width=\"45\" height=\"55\" src=\"" + Comum.General.getBASE_URL() + "images/angola_logo-republica.png" + "\" /></td>");
            sValue.Append("</tr>");
            sValue.Append("<tr>");
            sValue.Append("<td colspan=\"4\" style=\"text-align:center;color:black;border-bottom:1px solid;font-family: 'Times New Roman'; font-size: 13px;\"><strong>REPÚBLICA DE ANGOLA</strong></td>");
            sValue.Append("</tr>");
            sValue.Append("<tr style=\"text-align:left;padding-bottom:20px\">");
            sValue.Append("<td><strong>Dístico nº:</strong></td>");
            sValue.Append("<td>00211249</td>");
            sValue.Append("<td colspan=\"2\" style=\"font-family: Arial; font-size: 9px;text-align:center\">(Comprovativo de Seguro Efectuado)</td>");
            sValue.Append("</tr>");

            sValue.Append("<tr style=\"text-align:left\">");
            sValue.Append("<td><strong>Seguradora:</strong></td>");
            sValue.Append("<td colspan=\"3\">Master Seguros, SA</td>");
            sValue.Append("</tr>");
            sValue.Append("<tr style=\"text-align:left\">");
            sValue.Append("<td><strong>Nº Apólice:</strong></td>");
            sValue.Append("<td colspan=\"3\">" + dicApolice["NumeroApolice"] + "</td>");
            sValue.Append("</tr>");
            sValue.Append("<tr style=\"text-align:left\">");
            sValue.Append("<td><strong>Matrícula:</strong></td>");
            sValue.Append("<td>" + dicApolice["Matricula"] + "</td>");
            sValue.Append("<td><strong>Marca:</strong></td>");
            sValue.Append("<td>" + Comum.General.GetListMarca()[dicApolice["MarcaID"]] + " " + Comum.General.GetListModelo(dicApolice["MarcaID"])[dicApolice["ModeloID"]] + "</td>");

            sValue.Append("</tr>");

            sValue.Append("<tr style=\"text-align:left\">");
            sValue.Append("<td colspan=\"4\"><strong>Dístico emitido ao abrigo do certificado de <br />seguro de Responsabilidade Civil e Automóvel nº:</strong>&nbsp;&nbsp;00211249</td>");
            sValue.Append("</tr>");
            sValue.Append("<tr style=\"text-align:left\">");
            sValue.Append("<td><strong>Validade:</strong></td>");
            sValue.Append("<td><strong>Início:</strong>&nbsp;&nbsp;&nbsp;" + dicApolice["DataInicio"].Substring(0, 10) + "</td>");
            sValue.Append("<td></td>");
            sValue.Append("<td><strong>Termo:</strong>&nbsp;&nbsp;&nbsp;" + Comum.General.GetAddTime(dicApolice["Fraccionamento"], dicApolice["DataInicio"]) + "</td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td colspan=\"2\" align=\"left\" style=\"padding-bottom:10px;padding-right:50px\"><img width=\"60\" height=\"60\" src=\"" + Comum.General.getQRCodeApolice(dicApolice["NumeroApolice"]).ImageUrl + "\" /></td>");
            sValue.Append("<td colspan=\"2\" align=\"right\" style=\"padding-bottom:10px;padding-right:50px\"><img width=\"191\" height=\"80\"src=\"" + Comum.General.getBASE_URL() + "images/stamp.jpg" + "\" /></td>");
            sValue.Append("</tr>");
            sValue.Append("</table>");

            sValue.Append("</td>");
            sValue.Append("</tr>");
            sValue.Append("<tr>");
            sValue.Append("<td height=\"40px\">&nbsp;</td>");
            sValue.Append("</tr>");
            sValue.Append("<tr>");
            sValue.Append("<td style=\"font-family: Arial Narrow; font-size: 9px;\" align=\"left\">");
            sValue.Append("" + DateTime.Now.Year.ToString() + DateTime.Now.Month.ToString("00") + DateTime.Now.Day.ToString("00") + "<br />");
            sValue.Append("" + Membership.GetUser().UserName + "");
            sValue.Append("</td>");
            sValue.Append("</tr>");
            sValue.Append("</table>");

            sValue.Append("</td>");
            sValue.Append("</tr>");
            sValue.Append("</table>");

            return sValue.ToString();
        }

        private void CertificadoFrota(Dictionary<string, string> dicApolice, DataTable dtApolice)
        {
            string pdf_page_size = "A4";
            string headerUrl = Server.MapPath("~/files/header.html");
            string footerUrl = Server.MapPath("~/files/footer.html");

            PdfPageSize pageSize = (PdfPageSize)Enum.Parse(typeof(PdfPageSize), pdf_page_size, true);

            string pdf_orientation = "Portrait";
            PdfPageOrientation pdfOrientation = (PdfPageOrientation)Enum.Parse(typeof(PdfPageOrientation), pdf_orientation, true);

            HtmlToPdf converter = new HtmlToPdf();

            // set converter options
            converter.Options.PdfPageSize = pageSize;
            converter.Options.PdfPageOrientation = pdfOrientation;

            converter.Options.DisplayHeader = true;
            converter.Options.DisplayFooter = true;
            converter.Options.MarginLeft = 10;
            converter.Options.MarginRight = 10;

            converter.Header.Height = 60;
            converter.Footer.Height = 50;

            PdfHtmlSection headerHtml = new PdfHtmlSection(headerUrl);

            converter.Header.Add(headerHtml);

            PdfHtmlSection footerHtml = new PdfHtmlSection(footerUrl);
            footerHtml.AutoFitHeight = HtmlToPdfPageFitMode.AutoFit;
            converter.Footer.Add(footerHtml);

            string sHTMLApolice = string.Empty;
            List<String> InFiles = new List<string>();

            int i = 1;
            foreach (DataRow row in dtApolice.Rows)
            {
                sHTMLApolice = getHTMLCertificadoFrota(dicApolice, row);

                PdfDocument doc = converter.ConvertHtmlString(sHTMLApolice, Comum.General.getBASE_URL());

                doc.Save(Server.MapPath("Uploads") + "\\" + dicApolice["NumeroApolice"] + "_CERTIFICADO_" + i.ToString() + ".pdf");

                InFiles.Add(Server.MapPath("Uploads") + "\\" + dicApolice["NumeroApolice"] + "_CERTIFICADO_" + i.ToString() + ".pdf");

                doc.Close();
                i++;
            }

            if (Comum.General.MergePDFs(InFiles, Server.MapPath("Uploads") + "\\" + dicApolice["NumeroApolice"] + "_CERTIFICADO.pdf"))
                return;
        }

        public static string getHTMLCertificadoFrota(Dictionary<string, string> dicApolice, DataRow drApolice)
        {
            StringBuilder sValue = new StringBuilder();



            sValue.Append("<table width=\"100%\">");
            sValue.Append("<tr>");
            sValue.Append("<td align=\"center\">");

            sValue.Append("<table width=\"800\" cellpadding=\"1\" cellspacing=\"1\" style=\"font-family: 'Times New Roman'; font-size: 17px;padding-top:25px;text-align:center\">");
            sValue.Append("<tr>");
            sValue.Append("<td colspan=\"4\" style=\"text-align:center\"><img width=\"60\" height=\"74\" src=\"" + Comum.General.getBASE_URL() + "images/angola_logo-republica.png" + "\" /></td>");
            sValue.Append("</tr>");
            sValue.Append("<tr>");
            sValue.Append("<td colspan=\"4\" style=\"text-align:center;color:black;border-bottom:solid; border-bottom-width:1px\"><strong>REPÚBLICA DE ANGOLA</strong></td>");
            sValue.Append("</tr>");
            sValue.Append("</table>");

            sValue.Append("<table width=\"800\" cellpadding=\"1\" cellspacing=\"1\" style=\"font-family: 'Arial Narrow'; font-style ;padding-top:5px;text-align:center\">");
            sValue.Append("<tr>");
            sValue.Append("<td colspan=\"4\" style=\"text-align:center\"><strong>CERTIFICADO DE RESPONSABILIDADE CIVIL AUTOMÓVEL Nº</strong>&nbsp;&nbsp;<span style=\"font-family: 'Arial Narrow'; font-size: 14px;\">00211249</span></td>");
            sValue.Append("</tr>");
            sValue.Append("</table>");

            sValue.Append("<table width=\"800\" cellpadding=\"1\" cellspacing=\"1\" style=\"font-family: 'Arial Narrow'; font-size: 14px;padding-top:5px;padding-left:20px;text-align:left\">");
            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\" style=\"padding-bottom:5px\"><strong>Nome do Tomador:</strong></td>");
            sValue.Append("<td width=\"200px\">" + dicApolice["Nome"] + "</td>");
            sValue.Append("<td width=\"200px\"></td>");
            sValue.Append("<td width=\"250px\"></td>");
            sValue.Append("</tr>");
            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\" style=\"padding-bottom:5px\"><strong>Morada do Tomador:</strong></td>");
            sValue.Append("<td colspan=\"2\" width=\"400px\">" + dicApolice["Morada"] + " </td>");
            sValue.Append("<td width=\"250px\"></td>");
            sValue.Append("</tr>");
            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\" style=\"padding-bottom:5px\"><strong>Povíncia:</strong></td>");
            sValue.Append("<td width=\"200px\">" + dicApolice["Provincia"] + "</td>");
            sValue.Append("<td width=\"200px\"></td>");
            sValue.Append("<td width=\"250px\"></td>");
            sValue.Append("</tr>");
            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\" style=\"padding-bottom:5px\"><strong>Nº Apólice:</strong></td>");
            sValue.Append("<td width=\"200px\">" + dicApolice["NumeroApolice"] + " </td>");
            sValue.Append("<td width=\"200px\"></td>");
            sValue.Append("<td width=\"250px\"></td>");
            sValue.Append("</tr>");
            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\" style=\"padding-bottom:5px\"><strong>Categoria Veículo:</strong></td>");
            sValue.Append("<td width=\"200px\">" + Comum.General.GetListTipoCategoria()[drApolice["TipoCategoriaID"].ToString()] + "</td>");
            sValue.Append("<td width=\"200px\"><strong>Marca:</strong>&nbsp;&nbsp;" + Comum.General.GetListMarca()[drApolice["MarcaID"].ToString()] + " " + Comum.General.GetListModelo(drApolice["MarcaID"].ToString())[drApolice["ModeloID"].ToString()] + "</td>");
            sValue.Append("<td width=\"250px\"></td>");
            sValue.Append("</tr>");
            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\" style=\"padding-bottom:5px\"><strong>MATRÍCULA:</strong></td>");
            sValue.Append("<td width=\"200px\">" + drApolice["Matricula"].ToString() + "</td>");
            sValue.Append("<td width=\"200px\"><strong>CHASSI/QUADRO:</strong>&nbsp;&nbsp;" + drApolice["Chassi"].ToString() + "</td>");
            sValue.Append("<td width=\"250px\"></td>");
            sValue.Append("</tr>");
            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\"><strong>Validade do Certificado</strong></td>");
            sValue.Append("<td width=\"200px\"><strong>Data de Início:</strong>&nbsp;&nbsp;" + dicApolice["DataInicio"].Substring(0, 10) + "</td>");
            sValue.Append("<td width=\"200px\"><strong>Data de Termo:</strong>&nbsp;&nbsp;" + Comum.General.GetAddTime(dicApolice["Fraccionamento"], dicApolice["DataInicio"]) + "</td>");
            sValue.Append("<td width=\"250px\"></td>");
            sValue.Append("</tr>");
            sValue.Append("<tr>");
            sValue.Append("<td colspan=\"4\">&nbsp;</td>");
            sValue.Append("</tr>");
            sValue.Append("<tr>");
            sValue.Append("<td colspan=\"4\" align=\"right\" style=\"padding-bottom:15px;padding-right:250px\"><img width=\"239\" height=\"100\" src=\"" + Comum.General.getBASE_URL() + "images/stamp.jpg" + "\" /></td>");
            sValue.Append("</tr>");
            sValue.Append("</table>");
            //SEPARADOR

            sValue.Append("<table width=\"800\" cellpadding=\"1\" cellspacing=\"1\" style=\"font-family: 'Times New Roman'; font-size: 17px;padding-top:50px;text-align:center\">");
            sValue.Append("<tr>");
            sValue.Append("<td colspan=\"4\" style=\"text-align:center;color:gray;border-bottom:dashed; border-bottom-width:5px\"></td>");
            sValue.Append("</tr>");
            sValue.Append("</table>");


            sValue.Append("</td>");
            sValue.Append("</tr>");
            sValue.Append("</table>");

            //DÍSTICO
            sValue.Append("<table width=\"100%\">");
            sValue.Append("<tr>");
            sValue.Append("<td align=\"center\">");

            sValue.Append("<table width=\"100%\"  align=\"left\" cellpadding=\"1\" cellspacing=\"1\" style=\"font-family: 'Times New Roman'; font-size: 13px;padding-top:85px;text-align:center\">");
            sValue.Append("<tr>");
            sValue.Append("<td>");
            sValue.Append("<table width=\"425\" align=\"center\"  cellpadding=\"3\" cellspacing=\"1\" style=\"font-family: Arial Narrow; font-size: 13px;padding-top:7px;text-align:center;border-top:1px solid;border-bottom:1px solid;border-left:1px solid;border-right:1px solid;padding: 7px 25px 3px 25px\">");
            sValue.Append("<tr>");
            sValue.Append("<td colspan=\"4\" style=\"text-align:center\"><img width=\"45\" height=\"55\" src=\"" + Comum.General.getBASE_URL() + "images/angola_logo-republica.png" + "\" /></td>");
            sValue.Append("</tr>");
            sValue.Append("<tr>");
            sValue.Append("<td colspan=\"4\" style=\"text-align:center;color:black;border-bottom:1px solid;font-family: 'Times New Roman'; font-size: 13px;\"><strong>REPÚBLICA DE ANGOLA</strong></td>");
            sValue.Append("</tr>");
            sValue.Append("<tr style=\"text-align:left;padding-bottom:20px\">");
            sValue.Append("<td><strong>Dístico nº:</strong></td>");
            sValue.Append("<td>00211249</td>");
            sValue.Append("<td colspan=\"2\" style=\"font-family: Arial; font-size: 9px;text-align:center\">(Comprovativo de Seguro Efectuado)</td>");
            sValue.Append("</tr>");

            sValue.Append("<tr style=\"text-align:left\">");
            sValue.Append("<td><strong>Seguradora:</strong></td>");
            sValue.Append("<td colspan=\"3\">Master Seguros, SA</td>");
            sValue.Append("</tr>");
            sValue.Append("<tr style=\"text-align:left\">");
            sValue.Append("<td><strong>Nº Apólice:</strong></td>");
            sValue.Append("<td colspan=\"3\">" + dicApolice["NumeroApolice"] + "</td>");
            sValue.Append("</tr>");
            sValue.Append("<tr style=\"text-align:left\">");
            sValue.Append("<td><strong>Matrícula:</strong></td>");
            sValue.Append("<td>" + drApolice["Matricula"].ToString() + "</td>");
            sValue.Append("<td><strong>Marca:</strong></td>");
            sValue.Append("<td>" + Comum.General.GetListMarca()[drApolice["MarcaID"].ToString()] + " " + Comum.General.GetListModelo(drApolice["MarcaID"].ToString())[drApolice["ModeloID"].ToString()] + "</td>");

            sValue.Append("</tr>");

            sValue.Append("<tr style=\"text-align:left\">");
            sValue.Append("<td colspan=\"4\"><strong>Dístico emitido ao abrigo do certificado de <br />seguro de Responsabilidade Civil e Automóvel nº:</strong>&nbsp;&nbsp;00211249</td>");
            sValue.Append("</tr>");
            sValue.Append("<tr style=\"text-align:left\">");
            sValue.Append("<td><strong>Validade:</strong></td>");
            sValue.Append("<td><strong>Início:</strong>&nbsp;&nbsp;&nbsp;" + dicApolice["DataInicio"].Substring(0, 10) + "</td>");
            sValue.Append("<td></td>");
            sValue.Append("<td><strong>Termo:</strong>&nbsp;&nbsp;&nbsp;" + Comum.General.GetAddTime(dicApolice["Fraccionamento"], dicApolice["DataInicio"]) + "</td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td colspan=\"2\" align=\"left\" style=\"padding-bottom:10px;padding-right:50px\"><img width=\"60\" height=\"60\" src=\"" + Comum.General.getQRCodeApolice(dicApolice["NumeroApolice"]).ImageUrl + "\" /></td>");
            sValue.Append("<td colspan=\"2\" align=\"right\" style=\"padding-bottom:10px;padding-right:50px\"><img width=\"191\" height=\"80\"src=\"" + Comum.General.getBASE_URL() + "images/stamp.jpg" + "\" /></td>");
            sValue.Append("</tr>");
            sValue.Append("</table>");

            sValue.Append("</td>");
            sValue.Append("</tr>");
            sValue.Append("<tr>");
            sValue.Append("<td height=\"40px\">&nbsp;</td>");
            sValue.Append("</tr>");
            sValue.Append("<tr>");
            sValue.Append("<td style=\"font-family: Arial Narrow; font-size: 9px;\" align=\"left\">");
            sValue.Append("" + DateTime.Now.Year.ToString() + DateTime.Now.Month.ToString("00") + DateTime.Now.Day.ToString("00") + "<br />");
            sValue.Append("" + Membership.GetUser().UserName + "");
            sValue.Append("</td>");
            sValue.Append("</tr>");
            sValue.Append("</table>");

            sValue.Append("</td>");
            sValue.Append("</tr>");
            sValue.Append("</table>");

            return sValue.ToString();
        }



        private void ListaAnexa(Dictionary<string, string> dicApolice, DataTable dt)
        {
            string pdf_page_size = "A4";
            string headerUrl = Server.MapPath("~/files/header.html");
            string footerUrl = Server.MapPath("~/files/footer.html");

            PdfPageSize pageSize = (PdfPageSize)Enum.Parse(typeof(PdfPageSize), pdf_page_size, true);

            string pdf_orientation = "Portrait";
            PdfPageOrientation pdfOrientation = (PdfPageOrientation)Enum.Parse(typeof(PdfPageOrientation), pdf_orientation, true);

            HtmlToPdf converter = new HtmlToPdf();

            // set converter options
            converter.Options.PdfPageSize = pageSize;
            converter.Options.PdfPageOrientation = pdfOrientation;

            converter.Options.DisplayHeader = true;
            converter.Options.DisplayFooter = true;
            converter.Options.MarginLeft = 10;
            converter.Options.MarginRight = 10;

            converter.Header.Height = 60;
            converter.Footer.Height = 50;

            PdfHtmlSection headerHtml = new PdfHtmlSection(headerUrl);

            converter.Header.Add(headerHtml);

            PdfHtmlSection footerHtml = new PdfHtmlSection(footerUrl);
            footerHtml.AutoFitHeight = HtmlToPdfPageFitMode.AutoFit;
            converter.Footer.Add(footerHtml);

            string sHTMLApolice = getHTMListaAnexa(dicApolice, dt);

            PdfDocument doc = converter.ConvertHtmlString(sHTMLApolice, Comum.General.getBASE_URL());

            doc.Save(Server.MapPath("Uploads") + "\\" + dicApolice["NumeroApolice"] + "_LISTA_ANEXA.pdf");

            doc.Close();
        }

        public static string getHTMListaAnexa(Dictionary<string, string> dicApolice, DataTable dt)
        {
            StringBuilder sValue = new StringBuilder();

            sValue.Append("<table width=\"800\" cellpadding=\"1\" cellspacing=\"1\" style=\"font-family: Arial; font-size: 18px;padding-top:25px;text-align:left\" align=\"left\">");
                    sValue.Append("<tr>");
                        sValue.Append("<td colspan=\"2\" style=\"text-align:left\"></td>");
                    sValue.Append("</tr>");

                sValue.Append("<tr style =\"height:18px;\">");
                    sValue.Append("<td width=\"600px\">&nbsp;</td>");
                    sValue.Append("<td width=\"200px\"><strong>LISTA ANEXA</strong></td>");
                sValue.Append("</tr>");

                sValue.Append("<tr style =\"font-family: 'Arial Narrow'; font-size: 12px\">");
                    sValue.Append("<td width=\"600px\">&nbsp;</td>");
                    sValue.Append("<td width=\"200px\"><strong>" + dicApolice["NumeroApolice"] + "</strong></td>");
                sValue.Append("</tr>");

                sValue.Append("<tr style =\"font-family: 'Arial Narrow'; font-size: 12px\">");
                    sValue.Append("<td width=\"600px\">&nbsp;</td>");
                    sValue.Append("<td width=\"200px\">" + dicApolice["Nome"] + "</td>");
                sValue.Append("</tr>");

                sValue.Append("<tr style =\"font-family: 'Arial Narrow'; font-size: 12px\">");
                    sValue.Append("<td width=\"600px\">&nbsp;</td>");
                    sValue.Append("<td width=\"200px\">" + dicApolice["Morada"] + "</td>");
                sValue.Append("</tr>");

                sValue.Append("<tr style =\"font-family: 'Arial Narrow'; font-size: 12px\">");
                    sValue.Append("<td width=\"600px\">&nbsp;</td>");
                    sValue.Append("<td width=\"200px\">" + dicApolice["Provincia"] + "</td>");
                sValue.Append("</tr>");

            sValue.Append("</table>");

            sValue.Append("<table width=\"800\" cellpadding=\"1\" cellspacing=\"1\" style=\"font-family: 'Arial Narrow'; font-size: 12px;padding-top:0px;text-align:left\" align=\"left\">");
                sValue.Append("<tr>");
                    sValue.Append("<td colspan=\"8\" style=\"color:gold;border-bottom:solid\">&nbsp;</td>");
                sValue.Append("</tr>");
                sValue.Append("<tr>");
                    sValue.Append("<td width=\"15px\"><strong>Nº</strong></td>");
                    sValue.Append("<td width=\"100px\"><strong>Matrícula</strong></td>");
                    sValue.Append("<td width=\"150px\"><strong>Marca</strong></td>");
                    sValue.Append("<td width=\"150px\"><strong>Modelo</strong></td>");
                    sValue.Append("<td width=\"50px\"><strong>Cilindrada</strong></td>");
                    sValue.Append("<td width=\"100px\" style=\"text-align:center\"><strong>Lugares</strong></td>");
                    sValue.Append("<td width=\"100px\"><strong>Tipo Seguro</strong></td>");
                    sValue.Append("<td width=\"50px\"><strong>Prémio</strong></td>");
                sValue.Append("</tr>");
                sValue.Append("<tr>");
                    sValue.Append("<td colspan=\"8\" style=\"color:gold;border-top:solid\">&nbsp;</td>");
                sValue.Append("</tr>");

            int i = 0;
            foreach (DataRow row in dt.Rows)
                {
                sValue.Append("<tr>");
                sValue.Append("<td width=\"15px\">" + (i + 1).ToString() + "</td>");
                sValue.Append("<td width=\"100px\">" + row["Matricula"].ToString()  + "</td>");
                sValue.Append("<td width=\"150px\">" + row["Marca"].ToString() + "</td>");
                sValue.Append("<td width=\"150px\">" + row["Modelo"].ToString() + "</td>");
                sValue.Append("<td width=\"50px\">" + row["Cilindrada"].ToString() + " c.c</td>");
                sValue.Append("<td width=\"100px\" style=\"text-align:center\">" + row["Lugares"].ToString() + "</td>");
                sValue.Append("<td width=\"100p.x\">" + Comum.General.getDescricaoProduto(row["TipoSeguroID"].ToString()).ToString() + "</td>");
                sValue.Append("<td width=\"50px\">" + Comum.General.FormataNumero(row["PremioTotal"].ToString()) + "</td>");
                sValue.Append("</tr>");

                i++;
            }
           
            sValue.Append("</table>");

            return sValue.ToString();
        }

        public DataTable getViaturasFrota(string PropostaID)
        {
            //PropostaAutoFrotaViatura
            DataTable dt = new DataTable();

            if (PropostaID!=string.Empty)
            {
                DataView dviewApoliceAutoFrotaViatura = (DataView)SqlDataSourceApoliceAutoFrotaViatura.Select(DataSourceSelectArguments.Empty);
                return dviewApoliceAutoFrotaViatura.Table;
            }

            return dt;


        }
    }
}