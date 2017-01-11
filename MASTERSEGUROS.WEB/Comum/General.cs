using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Configuration;
using System.Net.Mail;
using System.Web.Security;
using System.Data.SqlClient;
using System.Data;
using SelectPdf;
using System.Text;
using System.Web.UI.WebControls;
using QRCoder;
using System.Drawing;
using System.IO;
using iTextSharp.text.pdf;
using iTextSharp.text;

namespace MASTERSEGUROS.WEB.Comum
{
    public static class General
    {
        //TIPOS DE SEGURO
        public const string TIPO_SEGURO_AUTO = "1";
        public const string TIPO_SEGURO_AUTO_FROTA = "2";
        public const string TIPO_SEGURO_ACIDENTES_PESSOAIS = "3";

        //ID DOS DOCUMENTOS AUTO E XXXX ??????????
        public const string RECIBO_COBRANCA = "1";
        public const string RECIBO_PREMIO = "2";
        public const string APOLICE = "3";
        public const string CERTIFICADO = "4";
        public const string LISTA_ANEXA = "5";

        public const string HEADER_URL_PDF = "~/files/header.html";
        public const string FOOTER_URL_PDF = "~/files/footer.html";
        public const string VALOR_NULO = "--------------";

        //CONSTANTES IDADE
        public const string IDADE_MENOS_25 = "IDADE_MENOS_25";
        public const string IDADE_MAIS_25_MENOS_60 = "IDADE_MAIS_25_MENOS_60";
        public const string IDADE_MAIS_60 = "IDADE_MAIS_60";

        //CONSTANTES EXPERIENCIA
        public const string ANOS_EXPERIENCIA_MENOS_2 = "ANOS_EXPERIENCIA_MENOS_2";
        public const string ANOS_EXPERIENCIA_MAIS_2 = "ANOS_EXPERIENCIA_MAIS_2";
                   
        public static string getConnection()
        {
            return ConfigurationManager.ConnectionStrings["DBConnectionString"].ConnectionString;
        }

        public static string getBASE_URL()
        {
            return ConfigurationManager.AppSettings["BASE_URL"].ToString();
        }

        public static Boolean sendNotification(string sTo, string sSubject, string sBody)
        {
            try
                {
                    //Ler a configuração do servidor SMTP
                    string smtpServer = ConfigurationManager.AppSettings["SMTP"].ToString();
                    int smtpServerPort = 25;
                    
                    //Ler a configuração das credenciais
                    string smtpUser = ConfigurationManager.AppSettings["EMAIL_FROM_CONTACTO"].ToString();
                    string smtpPwd = ConfigurationManager.AppSettings["PWD_FROM_CONTACTO"].ToString();
                    
                    //Criar a mensagem
                    MailAddress add = new MailAddress(sTo);
                    System.Net.Mail.MailMessage msg = new System.Net.Mail.MailMessage(smtpUser, sTo, sSubject, sBody);
                    SmtpClient oSmtpClient = new SmtpClient();

                    msg.IsBodyHtml = true;

                    //Enviar a mensagem
                    oSmtpClient.Host = smtpServer;
                    oSmtpClient.Port = smtpServerPort;
                    oSmtpClient.Credentials = new System.Net.NetworkCredential(smtpUser, smtpPwd);
                    oSmtpClient.Send(msg);
            }
            catch
            {
                return false;
            }

            return true;
        }

        public static System.Web.UI.WebControls.Image getQRCodeApolice(string sApolice)
        {
            string code = sApolice;
            QRCodeGenerator qrGenerator = new QRCodeGenerator();
            QRCodeGenerator.QRCode qrCode = qrGenerator.CreateQrCode(code, QRCodeGenerator.ECCLevel.Q);
            System.Web.UI.WebControls.Image imgBarCode = new System.Web.UI.WebControls.Image();
            imgBarCode.Height = 150;
            imgBarCode.Width = 150;
            using (Bitmap bitMap = qrCode.GetGraphic(20))
            {
                using (MemoryStream ms = new MemoryStream())
                {
                    bitMap.Save(ms, System.Drawing.Imaging.ImageFormat.Png);
                    byte[] byteImage = ms.ToArray();
                    imgBarCode.ImageUrl = "data:image/png;base64," + Convert.ToBase64String(byteImage);
                }
                //plBarCode.Controls.Add(imgBarCode);
               // Panel pnl = new Panel();
                //pnl.Controls.Add(imgBarCode);
            }
            return imgBarCode;
        }

        public static string getBodyNotificationApprovedVacation()
        {
            return ConfigurationManager.ConnectionStrings["DBConnectionString"].ConnectionString;
        }
        
        public static string getRoleAdminName()
        {
            return ConfigurationManager.AppSettings["RoleAdminName"].ToString();
        }

        public static string FormatUsernameToName(string username)
        {
            string sRetValue = string.Empty;
            string sFirstChar = string.Empty;

            sRetValue = username.Replace(".", " ");

            sRetValue = System.Threading.Thread.CurrentThread.CurrentCulture.TextInfo.ToTitleCase(sRetValue.ToLower());

            return sRetValue;
        }

        public static string FormataProposta(string sNumero, string sTipoProposta)
        {
            if (sTipoProposta == "AUTO")
            {
                string sTempName = "MS.AU.PRP." + DateTime.Now.Year + ".";
                return sTempName += sNumero.ToString().PadLeft(5, '0');
            }
            else
                return "";
        }

        public static string FormataNumeroCliente(string sNumero)
        {
                return sNumero.ToString().PadLeft(8, '0');
        }

        public static string ConverteValorNuloToEmpty(string sValue)
        {
            if (sValue == Comum.General.VALOR_NULO || sValue == "Sem Franquia" || sValue == "Capital Seguro" || sValue == string.Empty || sValue == "")
                return "0";
            else
                return sValue;

        }

        public static string ConverteEmptyToZero(string sValue)
        {
            if (sValue == "" || sValue == string.Empty)
                return "0";
            else
                return sValue;

        }

        public static Object ConverteEmptyToNull__(string sValue)
        {
            if (sValue == "" || sValue == string.Empty)
                return DBNull.Value;
            else
                return sValue;

        }

        public static string getLoggedUser()
        {
            return General.FormatUsernameToName(Membership.GetUser().UserName);
        }

        public static string GetConfig(string sConfigKey)
        {
            SqlDataReader rdr = null;
          
            //Obter Ano e Periodos
            using (SqlConnection con = new SqlConnection(General.getConnection()))
            {
                

                using (SqlCommand cmd = new SqlCommand("SELECT Valor FROM [VACATION].[dbo].[Configuracao] WHERE [ConfigKey] ='" + sConfigKey + "'", con))
                {
                    var lst = new List<String>();
                    cmd.CommandType = CommandType.Text;


                    con.Open();
                    rdr = cmd.ExecuteReader();

                    while (rdr.Read())
                    {
                        return rdr["Valor"].ToString() ;
                    }
                    rdr.Close();
                    con.Close();
                }
            }
            return string.Empty;
        }
 
        public static string getKeyFromConfigFile(string sKey)
        {
            return ConfigurationManager.AppSettings[sKey].ToString();
        }

        public static string getContentType(string iContent)
        {
            switch (iContent)
            {
                case "1":
                    return "FAQ";
                case "2":
                    return "Link";
                case "4":
                    return "Artigo";
                case "8":
                    return "Media";
                case "9":
                    return "Contacto";
                case "25":
                    return "Banner";
                default:
                    return "";
            }
        }

         public static string getRibbon(string iContent)
        {
            switch (iContent)
            {
                case "2":
                    return "RibbonLink";
                case "4":
                    return "RibbonArtigo";
                case "8":
                    return "RibbonMedia";
                case "9":
                    return "RibbonContacto";
                case "25":
                    return "RibbonBanner";
                default:
                    return "";
            }
        }

        public static string getContent(string iContentType, string IDContent, string LinguaContent)
        {
            switch (iContentType)
            {
                case "1":
                    return GetFAQByIDLingua(int.Parse(IDContent), int.Parse(LinguaContent));
                case "2":
                    return GetLinkByIDLingua(int.Parse(IDContent), int.Parse(LinguaContent));
                case "4":
                    return GetArticleByIDLingua(int.Parse(IDContent), int.Parse(LinguaContent));
                case "8":
                    return GetMediaByIDLingua(int.Parse(IDContent), int.Parse(LinguaContent));
                case "9":
                    return GetContactoByIDLingua(int.Parse(IDContent), int.Parse(LinguaContent));
                case "25":
                    return GetBannerByIDLingua(int.Parse(IDContent), int.Parse(LinguaContent));
                default:
                    return "";
            }
        }

        public static string GetFAQByIDLingua(int FAQID, int Lingua)
        {
            SqlDataReader rdr = null;
            String sRetValue = string.Empty;

            using (SqlConnection con = new SqlConnection(MASTERSEGUROS.WEB.Comum.General.getConnection()))
            {
                con.Open();
                //Actualizar o estado da marcação
                SqlCommand sqlCommand = new SqlCommand("spGetFAQ", con);


                sqlCommand.CommandType = System.Data.CommandType.StoredProcedure;

                SqlParameter paramFAQID = sqlCommand.Parameters.Add("@FAQID", SqlDbType.Int);
                SqlParameter paramLingua = sqlCommand.Parameters.Add("@Lingua", SqlDbType.Int);

                paramFAQID.Value = FAQID;
                paramLingua.Value = Lingua;

                rdr = sqlCommand.ExecuteReader();
                while (rdr.Read())
                {
                    sRetValue = (String)rdr["Titulo"].ToString();
                }


                con.Close();
            }

            return sRetValue;

        }

        public static string GetArticleByIDLingua(int ArtigoID, int Lingua)
        {
            SqlDataReader rdr = null;
            String sRetValue = string.Empty;

            using (SqlConnection con = new SqlConnection(MASTERSEGUROS.WEB.Comum.General.getConnection()))
            {
                con.Open();
                //Actualizar o estado da marcação
                SqlCommand sqlCommand = new SqlCommand("spGetArtigo", con);
                

                sqlCommand.CommandType = System.Data.CommandType.StoredProcedure;

                SqlParameter paramArtigoID = sqlCommand.Parameters.Add("@ArtigoID", SqlDbType.Int);
                SqlParameter paramLingua = sqlCommand.Parameters.Add("@Lingua", SqlDbType.Int);

                paramArtigoID.Value = ArtigoID;
                paramLingua.Value = Lingua;

                rdr = sqlCommand.ExecuteReader();
                while (rdr.Read())
                {
                    sRetValue= (String)rdr["Titulo"].ToString();
                }


                con.Close();
            }

            return sRetValue;

        }

        public static string GetMediaByIDLingua(int MediaID, int Lingua)
        {
            SqlDataReader rdr = null;
            String sRetValue = string.Empty;

            using (SqlConnection con = new SqlConnection(MASTERSEGUROS.WEB.Comum.General.getConnection()))
            {
                con.Open();
                //Actualizar o estado da marcação
                SqlCommand sqlCommand = new SqlCommand("spGetMedia", con);


                sqlCommand.CommandType = System.Data.CommandType.StoredProcedure;

                SqlParameter paramMediaID = sqlCommand.Parameters.Add("@MediaID", SqlDbType.Int);
                SqlParameter paramLingua = sqlCommand.Parameters.Add("@Lingua", SqlDbType.Int);

                paramMediaID.Value = MediaID;
                paramLingua.Value = Lingua;

                rdr = sqlCommand.ExecuteReader();
                while (rdr.Read())
                {
                    sRetValue = (String)rdr["Titulo"].ToString();
                }


                con.Close();
            }

            return sRetValue;

        }

        public static string GetLinkByIDLingua(int LinkID, int Lingua)
        {
            SqlDataReader rdr = null;
            String sRetValue = string.Empty;

            using (SqlConnection con = new SqlConnection(MASTERSEGUROS.WEB.Comum.General.getConnection()))
            {
                con.Open();
                //Actualizar o estado da marcação
                SqlCommand sqlCommand = new SqlCommand("spGetLink", con);


                sqlCommand.CommandType = System.Data.CommandType.StoredProcedure;

                SqlParameter paramLinkID = sqlCommand.Parameters.Add("@LinkID", SqlDbType.Int);
                SqlParameter paramLingua = sqlCommand.Parameters.Add("@Lingua", SqlDbType.Int);

                paramLinkID.Value = LinkID;
                paramLingua.Value = Lingua;

                rdr = sqlCommand.ExecuteReader();
                while (rdr.Read())
                {
                    sRetValue = (String)rdr["Titulo"].ToString();
                }


                con.Close();
            }

            return sRetValue;

        }

        public static string GetContactoByIDLingua(int ContactoID, int Lingua)
        {
            SqlDataReader rdr = null;
            String sRetValue = string.Empty;

            using (SqlConnection con = new SqlConnection(MASTERSEGUROS.WEB.Comum.General.getConnection()))
            {
                con.Open();
                //Actualizar o estado da marcação
                SqlCommand sqlCommand = new SqlCommand("spGetContacto", con);


                sqlCommand.CommandType = System.Data.CommandType.StoredProcedure;

                SqlParameter paramContactoID = sqlCommand.Parameters.Add("@ContactoID", SqlDbType.Int);
                SqlParameter paramLingua = sqlCommand.Parameters.Add("@Lingua", SqlDbType.Int);

                paramContactoID.Value = ContactoID;
                paramLingua.Value = Lingua;

                rdr = sqlCommand.ExecuteReader();
                while (rdr.Read())
                {
                    sRetValue = (String)rdr["Nome"].ToString();
                }


                con.Close();
            }

            return sRetValue;

        }

        public static string GetBannerByIDLingua(int BannerID, int Lingua)
        {
            SqlDataReader rdr = null;
            String sRetValue = string.Empty;

            using (SqlConnection con = new SqlConnection(MASTERSEGUROS.WEB.Comum.General.getConnection()))
            {
                con.Open();
                //Actualizar o estado da marcação
                SqlCommand sqlCommand = new SqlCommand("spGetBanner", con);


                sqlCommand.CommandType = System.Data.CommandType.StoredProcedure;

                SqlParameter paramBannerID = sqlCommand.Parameters.Add("@BannerID", SqlDbType.Int);
                SqlParameter paramLingua = sqlCommand.Parameters.Add("@Lingua", SqlDbType.Int);

                paramBannerID.Value = BannerID;
                paramLingua.Value = Lingua;

                rdr = sqlCommand.ExecuteReader();
                while (rdr.Read())
                {
                    sRetValue = (String)rdr["Titulo"].ToString();
                }


                con.Close();
            }

            return sRetValue;

        }

        public static string GetClassifierByIDLingua(int ClassificadorID, int Lingua)
        {
            SqlDataReader rdr = null;
            String sRetValue = string.Empty;

            using (SqlConnection con = new SqlConnection(getConnection()))
            {
                con.Open();
                //Actualizar o estado da marcação
                SqlCommand sqlCommand = new SqlCommand("spGetClassificador", con);


                sqlCommand.CommandType = System.Data.CommandType.StoredProcedure;

                SqlParameter paramClassificadorID = sqlCommand.Parameters.Add("@ClassificadorID", SqlDbType.Int);
                SqlParameter paramLingua = sqlCommand.Parameters.Add("@Lingua", SqlDbType.Int);

                paramClassificadorID.Value = ClassificadorID;
                paramLingua.Value = Lingua;

                rdr = sqlCommand.ExecuteReader();
                while (rdr.Read())
                {
                    sRetValue = (String)rdr["Nome"].ToString();
                }


                con.Close();
            }

            return sRetValue;

        }
        
        public static string ClientEncode(string html)
        {
            html = html.Replace("&quot;", "&quotx;");
            html = html.Replace("\"", "&quot;");
            html = html.Replace("&amp;", "&ampx;");
            html = html.Replace("&", "&amp;");
            html = html.Replace("&lt;", "&ltx;");
            html = html.Replace("<", "&lt;");
            html = html.Replace("&gt;", "&gtx;");
            html = html.Replace(">", "&gt;");

            return html;
        }

        public static int getAge(DateTime birthdate)
        {
            var today = DateTime.Today;
            var age = today.Year - birthdate.Year;
            if (birthdate > today.AddYears(-age)) age--;
            return age;
        }

        public static double DifferenceTotalYears(this DateTime start, DateTime end)
        {
            // Get difference in total months.
            int months = ((end.Year - start.Year) * 12) + (end.Month - start.Month);

            // substract 1 month if end month is not completed
            if (end.Day < start.Day)
            {
                months--;
            }

            double totalyears = months / 12d;
            return totalyears;
        }

        public static string getKeyIdadeCondutor(string sIdade)
        {
            //IDADE_MENOS_25 | IDADE_MAIS_60 | IDADE_MAIS_25_MENOS_60
            if (int.Parse(sIdade) < 25)
                return IDADE_MENOS_25;
            else if (int.Parse(sIdade) >= 25 && int.Parse(sIdade) < 60)
                return IDADE_MAIS_25_MENOS_60;
            else
                return IDADE_MAIS_60;
        }

        public static string getKeyExperienciaCondutor(string sAnosExperiencia)
        {
            //ANOS_EXPERIENCIA_MENOS_2 || ANOS_EXPERIENCIA_MAIS_2
            if (int.Parse(sAnosExperiencia) < 2)
                return ANOS_EXPERIENCIA_MENOS_2;
            else
                return ANOS_EXPERIENCIA_MAIS_2;
        }

        public static string getKeyAnosVeiculo(string sIdade)
        {
            if (int.Parse(sIdade) < 5)
                return "VEICULO_MENOS_5_ANOS";
            else if (int.Parse(sIdade) >= 5 && int.Parse(sIdade) < 7)
                return "VEICULO_MAIS_5_MENOS_7_ANOS";
            else
                return "VEICULO_MAIS_7_ANOS";
        }

        public static string getHTMLTabelaSimulacao(string sNome, string sProduto, string sMorada, string sNumeroCliente, string sProvincia, string sAdesao, string sUnidadeNegocio, string sQualidadeTomador, string sFraccionamento, string sMarca, string sModelo, string sDataInicio, string sDataFim, string sMatricula, string sCilindrada, string sNumeroLugares, string sUso, string sChassi, string sRespCivilBase, string sRespCivilResponsavel, string sRespCivilTranquilo, string sRespCivilInteligente, string sRespCivilFranquia, string sOcupantesBase, string sOcupantesResponsavel, string sOcupantesTranquilo, string sOcupantesInteligente, string sOcupantesFranquia, string sMorteInvalidezBase, string sMorteInvalidezResponsavel, string sMorteInvalidezTranquilo, string sMorteInvalidezInteligente, string sMorteInvalidezFranquia, string sDespesasTratamentoBase, string sDespesasTratamentoResponsavel, string sDespesasTratamentoTranquilo, string sDespesasTratamentoInteligente, string sDespesasTratamentoFranquia, string sDespesasFuneralBase, string sDespesasFuneralResponsavel, string sDespesasFuneralTranquilo, string sDespesasFuneralInteligente, string sDespesasFuneralFranquia, string sChoqueColisaoBase, string sChoqueColisaoResponsavel, string sChoqueColisaoTranquilo, string sChoqueColisaoInteligente, string sChoqueColisaoFranquia, string sFurtoRouboBase, string sFurtoRouboResponsavel, string sFurtoRouboTranquilo, string sFurtoRouboInteligente, string sFurtoRouboFranquia, string sIncendioRaioBase, string sIncendioRaioResponsavel, string sIncendioRaioTranquilo, string sIncendioRaioInteligente, string sIncendioRaioFranquia, Dictionary<string, string> dicSimulacao)
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

            sValue.Append("<tr style=\"color:red;height:18px;\">");
                sValue.Append("<td width=\"150px\">&nbsp;</td>");
                sValue.Append("<td width=\"130px\">&nbsp;</td>");
                sValue.Append("<td width=\"120px\">&nbsp;</td>");
                sValue.Append("<td width=\"200px\"><strong>SIMULAÇÃO</strong></td>");
            sValue.Append("</tr>");
            sValue.Append("<tr style=\"font-size:14px\">");
                sValue.Append("<td width=\"150px\">&nbsp;</td>");
                sValue.Append("<td width=\"130px\">&nbsp;</td>");
                sValue.Append("<td width=\"120px\">&nbsp;</td>");
                sValue.Append("<td width=\"200px\"><strong>AUTOMÓVEL</strong></td>");
            sValue.Append("</tr>");
            sValue.Append("</table>");


            sValue.Append("<table width=\"600\" cellpadding=\"1\" cellspacing=\"1\" style=\"font-family: 'Arial Narrow'; font-size: 12px;padding-top:25px;text-align:left\" align=\"center\">");
            sValue.Append("<tr>");
            sValue.Append("<td colspan=\"4\" style=\"text-align:left\"><strong>&nbsp;</strong></td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\"><strong>APÓLICE</strong></td>");
            sValue.Append("<td width=\"130px\">&nbsp;</td>");
            sValue.Append("<td width=\"120px\">&nbsp;</td>");
            sValue.Append("<td width=\"200px\"><strong>TOMADOR DO SEGURO</strong></td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\"><strong>Ramo:</strong></td>");
            sValue.Append("<td width=\"130px\">Não Vida</td>");
            sValue.Append("<td width=\"120px\"></td>");
            sValue.Append("<td width=\"200px\">" + sNome + "</td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\"><strong>Produto:</strong></td>");
            sValue.Append("<td width=\"130px\">Automóvel</td>");
            sValue.Append("<td width=\"120px\"></td>");
            sValue.Append("<td width=\"200px\">" + sMorada + "</td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\"><strong>Cliente nº:</strong></td>");
            sValue.Append("<td width=\"130px\">" + sNumeroCliente + " </td>");
            sValue.Append("<td width=\"120px\"></td>");
            sValue.Append("<td width=\"200px\">" + sProvincia + " </td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\"><strong>Adesão nº:</strong></td>");
            sValue.Append("<td width=\"130px\">" + sAdesao + " </td>");
            sValue.Append("<td width=\"120px\"></td>");
            sValue.Append("<td width=\"200px\"></td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\"><strong>Agente/Mediador:</strong></td>");
            sValue.Append("<td width=\"130px\">" + getLoggedUser() + " </td>");
            sValue.Append("<td width=\"120px\"></td>");
            sValue.Append("<td width=\"200px\"><strong>QUALIDADE DO TOMADOR</strong></td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\"><strong>Unidade de Negócio:</strong></td>");
            sValue.Append("<td width=\"130px\">" + sUnidadeNegocio + " </td>");
            sValue.Append("<td width=\"120px\"></td>");
            sValue.Append("<td width=\"200px\">" + sQualidadeTomador + " </td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\"><strong>Fraccionamento:</strong></td>");
            sValue.Append("<td width=\"130px\">" + General.VALOR_NULO + "</td>");
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
            sValue.Append("<td width=\"200px\"><strong>Marca/Modelo: </strong>" + sMarca + " " + sModelo + "</td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\">Início: ás 0 horas de:</td>");
            sValue.Append("<td width=\"130px\">" + sDataInicio + " </td>");
            sValue.Append("<td width=\"120px\">Cobrança Directa</td>");
            sValue.Append("<td width=\"200px\"><strong>Dt. 1ª Matrícula/Construção: </strong> 01/02/2013</td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\">Renovação/Termo:ás 24 horas de:</td>");
            sValue.Append("<td width=\"130px\">" + sDataFim + " </td>");
            sValue.Append("<td width=\"120px\"></td>");
            sValue.Append("<td width=\"200px\"><strong>Matrícula: </strong>" + sMatricula + "</td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\"></td>");
            sValue.Append("<td width=\"130px\"></td>");
            sValue.Append("<td width=\"120px\"></td>");
            sValue.Append("<td width=\"200px\"><strong>Cilindrada: </strong>" + sCilindrada + " c.c </td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\"><strong></strong></td>");
            sValue.Append("<td width=\"130px\"></td>");
            sValue.Append("<td width=\"120px\"></td>");
            sValue.Append("<td width=\"200px\"><strong>Nº Lugares: </strong>" + sNumeroLugares + "</td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\"></td>");
            sValue.Append("<td width=\"130px\"></td>");
            sValue.Append("<td width=\"120px\"></td>");
            sValue.Append("<td width=\"200px\"><strong>Uso: </strong>" + sUso + "</td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\"></td>");
            sValue.Append("<td width=\"130px\"></td>");
            sValue.Append("<td width=\"120px\"></td>");
            sValue.Append("<td width=\"200px\"><strong>Nº Chassis: </strong>" + sChassi + "</td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td colspan=\"4\">&nbsp;</td>");
            sValue.Append("</tr>");
            sValue.Append("</table>");
            //COBERTURAS
            sValue.Append("<table width=\"600\" cellpadding=\"1\" cellspacing=\"1\" style=\"font-family: 'Arial Narrow'; font-size: 12px;padding-top:25px;text-align:center\" align=\"center\">");
                sValue.Append("<tr>");
                    sValue.Append("<td colspan=\"6\" style=\"text-align:left\"><strong>COBERTURAS</strong></td>");
                sValue.Append("</tr>");

                sValue.Append("<tr>");
                    sValue.Append("<td width=\"250px\"></td>");
                    sValue.Append("<td style=\"background-color:#BF9000;color:white;height:18px;border-width:thin;border-color:darkgrey\" width=\"120px\">BASE</td>");
                    sValue.Append("<td style=\"background-color:#BF9000;color:white;height:18px;border-width:thin;border-color:darkgrey\" width=\"120px\">RESPONSÁVEL</td>");
                    sValue.Append("<td style=\"background-color:#BF9000;color:white;height:18px;border-width:thin;border-color:darkgrey\" width=\"120px\">TRANQUILO</td>");
                    sValue.Append("<td style=\"background-color:#BF9000;color:white;height:18px;border-width:thin;border-color:darkgrey\" width=\"120px\">INTELIGENTE</td>");
                    sValue.Append("<td style=\"background-color:#BF9000;color:white;height:18px;border-width:thin;border-color:darkgrey\" width=\"120px\">FRANQUIA</td>");
                sValue.Append("</tr>");

                sValue.Append("<tr>");
                    sValue.Append("<td style=\"background-color:#BF9000;color:white;height:18px;border-width:thin;border-color:darkgrey\" width=\"250px\">Responsabilidade Civil</td>");
                    sValue.Append("<td style=\"background-color:lightgray;color:black;height:18px;border-width:thin;border-color:darkgrey\" width=\"120px\">" + sRespCivilBase + "</td>");
                    sValue.Append("<td style=\"background-color:lightgray;color:black;height:18px;border-width:thin;border-color:darkgrey\" width=\"120px\">" + sRespCivilResponsavel + "</td>");
                    sValue.Append("<td style=\"background-color:lightgray;color:black;height:18px;border-width:thin;border-color:darkgrey\" width=\"120px\">" + sRespCivilTranquilo + "</td>");
                    sValue.Append("<td style=\"background-color:lightgray;color:black;height:18px;border-width:thin;border-color:darkgrey\" width=\"120px\">" + sRespCivilInteligente + "</td>");
                    sValue.Append("<td style=\"background-color:lightgray;color:black;height:18px;border-width:thin;border-color:darkgrey\" width=\"120px\">"  + sRespCivilFranquia + "</td>");
                sValue.Append("</tr>");

                sValue.Append("<tr>");
                    sValue.Append("<td style=\"background-color:#BF9000;color:white;height:18px;border-width:thin;border-color:darkgrey\" width=\"250px\">Ocupantes</td>"); //string , string , string , string , string 
                    sValue.Append("<td style=\"background-color:lightgray;color:black;height:18px;border-width:thin;border-color:darkgrey\" width=\"120px\">" + sOcupantesBase + "</td>");
                    sValue.Append("<td style=\"background-color:lightgray;color:black;height:18px;border-width:thin;border-color:darkgrey\" width=\"120px\">" + sOcupantesResponsavel + "</td>");
                    sValue.Append("<td style=\"background-color:lightgray;color:black;height:18px;border-width:thin;border-color:darkgrey\" width=\"120px\">" + sOcupantesTranquilo  + "</td>");
                    sValue.Append("<td style=\"background-color:lightgray;color:black;height:18px;border-width:thin;border-color:darkgrey\" width=\"120px\">" + sOcupantesInteligente + "</td>");
                    sValue.Append("<td style=\"background-color:lightgray;color:black;height:18px;border-width:thin;border-color:darkgrey\" width=\"120px\">" + sOcupantesFranquia + "</td>");
                sValue.Append("</tr>");

                sValue.Append("<tr>");
                    sValue.Append("<td style=\"background-color:#BF9000;color:white;height:18px;border-width:thin;border-color:darkgrey\" width=\"250px\">Morte ou Invalidez Permanente</td>");
                    sValue.Append("<td style=\"background-color:lightgray;color:black;height:18px;border-width:thin;border-color:darkgrey\" width=\"120px\">" + sMorteInvalidezBase + "</td>");
                    sValue.Append("<td style=\"background-color:lightgray;color:black;height:18px;border-width:thin;border-color:darkgrey\" width=\"120px\">" + sMorteInvalidezResponsavel + "</td>");
                    sValue.Append("<td style=\"background-color:lightgray;color:black;height:18px;border-width:thin;border-color:darkgrey\" width=\"120px\">" + sMorteInvalidezTranquilo + "</td>");
                    sValue.Append("<td style=\"background-color:lightgray;color:black;height:18px;border-width:thin;border-color:darkgrey\" width=\"120px\">" + sMorteInvalidezInteligente + "</td>");
                    sValue.Append("<td style=\"background-color:lightgray;color:black;height:18px;border-width:thin;border-color:darkgrey\" width=\"120px\">" + sMorteInvalidezFranquia + "</td>");
                sValue.Append("</tr>");

                sValue.Append("<tr>");
                    sValue.Append("<td style=\"background-color:#BF9000;color:white;height:18px;border-width:thin;border-color:darkgrey\" width=\"250px\">Despesas de Tratamento</td>");
                    sValue.Append("<td style=\"background-color:lightgray;color:black;height:18px;border-width:thin;border-color:darkgrey\" width=\"120px\">" + sDespesasTratamentoBase + "</td>"); 
                    sValue.Append("<td style=\"background-color:lightgray;color:black;height:18px;border-width:thin;border-color:darkgrey\" width=\"120px\">" + sDespesasTratamentoResponsavel + "</td>");
                    sValue.Append("<td style=\"background-color:lightgray;color:black;height:18px;border-width:thin;border-color:darkgrey\" width=\"120px\">" + sDespesasTratamentoTranquilo + "</td>");
                    sValue.Append("<td style=\"background-color:lightgray;color:black;height:18px;border-width:thin;border-color:darkgrey\" width=\"120px\">" + sDespesasTratamentoInteligente + "</td>");
                    sValue.Append("<td style=\"background-color:lightgray;color:black;height:18px;border-width:thin;border-color:darkgrey\" width=\"120px\">" + sDespesasTratamentoFranquia + "</td>");
                sValue.Append("</tr>");

                sValue.Append("<tr>");
                    sValue.Append("<td style=\"background-color:#BF9000;color:white;height:18px;border-width:thin;border-color:darkgrey\" width=\"250px\">Despesas de Funeral</td>");
            sValue.Append("<td style=\"background-color:lightgray;color:black;height:18px;border-width:thin;border-color:darkgrey\" width=\"120px\">" + sDespesasFuneralBase + "</td>");
                    sValue.Append("<td style=\"background-color:lightgray;color:black;height:18px;border-width:thin;border-color:darkgrey\" width=\"120px\">" + sDespesasFuneralResponsavel + "</td>");
                    sValue.Append("<td style=\"background-color:lightgray;color:black;height:18px;border-width:thin;border-color:darkgrey\" width=\"120px\">" + sDespesasFuneralTranquilo + "</td>");
                    sValue.Append("<td style=\"background-color:lightgray;color:black;height:18px;border-width:thin;border-color:darkgrey\" width=\"120px\">" + sDespesasFuneralInteligente + "</td>");
                    sValue.Append("<td style=\"background-color:lightgray;color:black;height:18px;border-width:thin;border-color:darkgrey\" width=\"120px\">" + sDespesasFuneralFranquia + "</td>");
                sValue.Append("</tr>");

                sValue.Append("<tr>");
                    sValue.Append("<td style=\"background-color:#BF9000;color:white;height:18px;border-width:thin;border-color:darkgrey\" width=\"250px\">Choque, Colisão ou Capotamento</td>"); 
                    sValue.Append("<td style=\"background-color:lightgray;color:black;height:18px;border-width:thin;border-color:darkgrey\" width=\"120px\">" + sChoqueColisaoBase + "</td>");
                    sValue.Append("<td style=\"background-color:lightgray;color:black;height:18px;border-width:thin;border-color:darkgrey\" width=\"120px\">" + sChoqueColisaoResponsavel + "</td>");
                    sValue.Append("<td style=\"background-color:lightgray;color:black;height:18px;border-width:thin;border-color:darkgrey\" width=\"120px\">" + sChoqueColisaoTranquilo + "</td>");
                    sValue.Append("<td style=\"background-color:lightgray;color:black;height:18px;border-width:thin;border-color:darkgrey\" width=\"120px\">" + sChoqueColisaoInteligente + "</td>");
                    sValue.Append("<td style=\"background-color:lightgray;color:black;height:18px;border-width:thin;border-color:darkgrey\" width=\"120px\">" + sChoqueColisaoFranquia + "</td>");
                sValue.Append("</tr>");

                sValue.Append("<tr>");
                    sValue.Append("<td style=\"background-color:#BF9000;color:white;height:18px;border-width:thin;border-color:darkgrey\" width=\"250px\">Furto ou Roubo</td>");  
            sValue.Append("<td style=\"background-color:lightgray;color:black;height:18px;border-width:thin;border-color:darkgrey\" width=\"120px\">" + sFurtoRouboBase + "</td>");
            sValue.Append("<td style=\"background-color:lightgray;color:black;height:18px;border-width:thin;border-color:darkgrey\" width=\"120px\">" + sFurtoRouboResponsavel + "</td>");
            sValue.Append("<td style=\"background-color:lightgray;color:black;height:18px;border-width:thin;border-color:darkgrey\" width=\"110px\">" + sFurtoRouboTranquilo + "</td>");
            sValue.Append("<td style=\"background-color:lightgray;color:black;height:18px;border-width:thin;border-color:darkgrey\" width=\"110px\">" + sFurtoRouboInteligente + "</td>");
            sValue.Append("<td style=\"background-color:lightgray;color:black;height:18px;border-width:thin;border-color:darkgrey\" width=\"120px\">" + sFurtoRouboFranquia + "</td>");
            sValue.Append("</tr>");

                sValue.Append("<tr>");
                    sValue.Append("<td style=\"background-color:#BF9000;color:white;height:18px;border-width:thin;border-color:darkgrey\" width=\"250px\">Incêndio, Raio ou Explosão</td>");
                    sValue.Append("<td style=\"background-color:lightgray;color:black;height:18px;border-width:thin;border-color:darkgrey\" width=\"120px\">" + sIncendioRaioBase + "</td>");
                    sValue.Append("<td style=\"background-color:lightgray;color:black;height:18px;border-width:thin;border-color:darkgrey\" width=\"120px\">" + sIncendioRaioResponsavel + "</td>");
                    sValue.Append("<td style=\"background-color:lightgray;color:black;height:18px;border-width:thin;border-color:darkgrey\" width=\"120px\">" + sIncendioRaioTranquilo + "</td>");
                    sValue.Append("<td style=\"background-color:lightgray;color:black;height:18px;border-width:thin;border-color:darkgrey\" width=\"120px\">" + sIncendioRaioInteligente + "</td>");
                    sValue.Append("<td style=\"background-color:lightgray;color:black;height:18px;border-width:thin;border-color:darkgrey\" width=\"120px\">" + sIncendioRaioFranquia + "</td>");
                sValue.Append("</tr>");
            sValue.Append("</table>");

            //PREMIO - ANUAL/SEMESTRAL/TRIMESTRAL
            sValue.Append("<table width=\"600\" cellpadding=\"1\" cellspacing=\"1\" style=\"font-family: 'Arial Narrow'; font-size: 12px;padding-top:25px;text-align:center\" align=\"center\">");

            sValue.Append("<tr>");
                sValue.Append("<td colspan=\"6\" style=\"text-align:left\"><strong>PRÉMIO TOTAL</strong></td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
                sValue.Append("<td width=\"155px\"></td>");
                sValue.Append("<td style=\"background-color:#BF9000;color:white;height:18px;border-width:thin;border-color:darkgrey\" width=\"72px\">BASE</td>");
                sValue.Append("<td style=\"background-color:#BF9000;color:white;height:18px;border-width:thin;border-color:darkgrey\" width=\"98px\">RESPONSÁVEL</td>");
                sValue.Append("<td style=\"background-color:#BF9000;color:white;height:18px;border-width:thin;border-color:darkgrey\" width=\"89px\">TRANQUILO</td>");
                sValue.Append("<td style=\"background-color:#BF9000;color:white;height:18px;border-width:thin;border-color:darkgrey\" width=\"93px\">INTELIGENTE</td>");
                sValue.Append("<td width=\"86px\"></td>");
            sValue.Append("</tr>");
            sValue.Append("<tr>");
                sValue.Append("<td style=\"background-color:#BF9000;color:white;height:18px;border-width:thin;border-color:darkgrey\" width=\"155px\">ANUAL</td>");
                sValue.Append("<td style=\"background-color:lightgray;color:black;height:18px;border-width:thin;border-color:darkgrey\" width=\"72px\">" + General.FormataNumero(dicSimulacao["BASE_ANUAL"]) + "</td>");
                sValue.Append("<td style=\"background-color:lightgray;color:black;height:18px;border-width:thin;border-color:darkgrey\" width=\"98px\">" + General.FormataNumero(dicSimulacao["RESPONSAVEL_ANUAL"]) + "</td>");
                sValue.Append("<td style=\"background-color:lightgray;color:black;height:18px;border-width:thin;border-color:darkgrey\" width=\"89px\">" + General.FormataNumero(dicSimulacao["TRANQUILO_ANUAL"]) + "</td>");
                sValue.Append("<td style=\"background-color:lightgray;color:black;height:18px;border-width:thin;border-color:darkgrey\" width=\"93px\">" + General.FormataNumero(dicSimulacao["INTELIGENTE_ANUAL"]) + "</td>");
            sValue.Append("</tr>");
            sValue.Append("<tr>");
                sValue.Append("<td style=\"background-color:#BF9000;color:white;height:18px;border-width:thin;border-color:darkgrey\" width=\"155px\">SEMESTRAL</td>");
                sValue.Append("<td style=\"background-color:lightgray;color:black;height:18px;border-width:thin;border-color:darkgrey\" width=\"72px\">" + General.FormataNumero(dicSimulacao["BASE_SEMESTRAL"]) + "</td>");
                sValue.Append("<td style=\"background-color:lightgray;color:black;height:18px;border-width:thin;border-color:darkgrey\" width=\"98px\">" + General.FormataNumero(dicSimulacao["RESPONSAVEL_SEMESTRAL"]) + "</td>");
                sValue.Append("<td style=\"background-color:lightgray;color:black;height:18px;border-width:thin;border-color:darkgrey\" width=\"89px\">" + General.FormataNumero(dicSimulacao["TRANQUILO_SEMESTRAL"]) + "</td>");
                sValue.Append("<td style=\"background-color:lightgray;color:black;height:18px;border-width:thin;border-color:darkgrey\" width=\"93px\">" + General.FormataNumero(dicSimulacao["INTELIGENTE_SEMESTRAL"]) + "</td>");
            sValue.Append("</tr>");
            sValue.Append("<tr>");
                sValue.Append("<td style=\"background-color:#BF9000;color:white;height:18px;border-width:thin;border-color:darkgrey\" width=\"155px\">TRIMESTRAL</td>");
                sValue.Append("<td style=\"background-color:lightgray;color:black;height:18px;border-width:thin;border-color:darkgrey\" width=\"72px\">" + General.FormataNumero(dicSimulacao["BASE_TRIMESTRAL"]) + "</td>");
                sValue.Append("<td style=\"background-color:lightgray;color:black;height:18px;border-width:thin;border-color:darkgrey\" width=\"98px\">" + General.FormataNumero(dicSimulacao["RESPONSAVEL_TRIMESTRAL"]) + "</td>");
                sValue.Append("<td style=\"background-color:lightgray;color:black;height:18px;border-width:thin;border-color:darkgrey\" width=\"89px\">" + General.FormataNumero(dicSimulacao["TRANQUILO_TRIMESTRAL"]) + "</td>");
                sValue.Append("<td style=\"background-color:lightgray;color:black;height:18px;border-width:thin;border-color:darkgrey\" width=\"93px\">" + General.FormataNumero(dicSimulacao["INTELIGENTE_TRIMESTRAL"]) + "</td>");
            sValue.Append("</tr>");
            sValue.Append("</table>");

            sValue.Append("<table width=\"600\" cellpadding=\"1\" cellspacing=\"1\" style=\"font-family: 'Arial Narrow'; font-size: 12px;padding-top:25px;text-align:left\" align=\"center\">");
            sValue.Append("<tr style=\"font-size: 11px;\">");
            sValue.Append("<td colspan=\"4\">A presente simulação tem carácter meramente informativo, não vinculando a Master Seguros, estando sujeita à sua aceitação. Esta simulação tem como pressupostos os dados inseridos e a não existência de factores de agravamento de risco, nomeadamente a não circulação do veículo em áreas de acesso restrito e a não efectivação de transporte de matérias perigosas.</ td > ");
            sValue.Append("</tr>");
            sValue.Append("</table>");

            return sValue.ToString();

        }

        public static string getHTMLTabelaSimulacaoFrota(string sNome, string sProduto, string sMorada, string sNumeroCliente, string sProvincia, string sAdesao, string sUnidadeNegocio, string sQualidadeTomador, string sFraccionamento, string sMarca, string sModelo, string sDataInicio, string sDataFim, string sMatricula, string sCilindrada, string sNumeroLugares, string sUso, string sChassi, Dictionary<string, string> dicSimulacao)
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

            sValue.Append("<tr style=\"color:red;height:18px;\">");
            sValue.Append("<td width=\"150px\">&nbsp;</td>");
            sValue.Append("<td width=\"130px\">&nbsp;</td>");
            sValue.Append("<td width=\"120px\">&nbsp;</td>");
            sValue.Append("<td width=\"200px\"><strong>SIMULAÇÃO</strong></td>");
            sValue.Append("</tr>");
            sValue.Append("<tr style=\"font-size:14px\">");
            sValue.Append("<td width=\"150px\">&nbsp;</td>");
            sValue.Append("<td width=\"130px\">&nbsp;</td>");
            sValue.Append("<td width=\"120px\">&nbsp;</td>");
            sValue.Append("<td width=\"200px\"><strong>AUTOMÓVEL</strong></td>");
            sValue.Append("</tr>");
            sValue.Append("</table>");


            sValue.Append("<table width=\"600\" cellpadding=\"1\" cellspacing=\"1\" style=\"font-family: 'Arial Narrow'; font-size: 12px;padding-top:25px;text-align:left\" align=\"center\">");
            sValue.Append("<tr>");
            sValue.Append("<td colspan=\"4\" style=\"text-align:left\"><strong>&nbsp;</strong></td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\"><strong>APÓLICE</strong></td>");
            sValue.Append("<td width=\"130px\">&nbsp;</td>");
            sValue.Append("<td width=\"120px\">&nbsp;</td>");
            sValue.Append("<td width=\"200px\"><strong>TOMADOR DO SEGURO</strong></td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\"><strong>Ramo:</strong></td>");
            sValue.Append("<td width=\"130px\">Não Vida</td>");
            sValue.Append("<td width=\"120px\"></td>");
            sValue.Append("<td width=\"200px\">" + sNome + "</td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\"><strong>Produto:</strong></td>");
            sValue.Append("<td width=\"130px\">" + "Automóvel" + "</td>");
            sValue.Append("<td width=\"120px\"></td>");
            sValue.Append("<td width=\"200px\">" + sMorada + "</td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\"><strong>Cliente nº:</strong></td>");
            sValue.Append("<td width=\"130px\">" + sNumeroCliente + " </td>");
            sValue.Append("<td width=\"120px\"></td>");
            sValue.Append("<td width=\"200px\">" + sProvincia + " </td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\"><strong>Adesão nº:</strong></td>");
            sValue.Append("<td width=\"130px\">" + sAdesao + " </td>");
            sValue.Append("<td width=\"120px\"></td>");
            sValue.Append("<td width=\"200px\"></td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\"><strong>Agente/Mediador:</strong></td>");
            sValue.Append("<td width=\"130px\">" + getLoggedUser() + " </td>");
            sValue.Append("<td width=\"120px\"></td>");
            sValue.Append("<td width=\"200px\"><strong>QUALIDADE DO TOMADOR</strong></td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\"><strong>Unidade de Negócio:</strong></td>");
            sValue.Append("<td width=\"130px\">" + sUnidadeNegocio + " </td>");
            sValue.Append("<td width=\"120px\"></td>");
            sValue.Append("<td width=\"200px\">" + sQualidadeTomador + " </td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\"><strong>Fraccionamento:</strong></td>");
            sValue.Append("<td width=\"130px\">" + General.VALOR_NULO + "</td>");
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
            sValue.Append("<td width=\"200px\"><strong>Marca/Modelo: </strong>" + sMarca + " " + sModelo + "</td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\">Início: ás 0 horas de:</td>");
            sValue.Append("<td width=\"130px\">" + sDataInicio + " </td>");
            sValue.Append("<td width=\"120px\">Cobrança Directa</td>");
            sValue.Append("<td width=\"200px\"><strong>Dt. 1ª Matrícula/Construção: </strong>" + General.VALOR_NULO + "</td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\">Renovação/Termo:ás 24 horas de:</td>");
            sValue.Append("<td width=\"130px\">" + sDataFim + " </td>");
            sValue.Append("<td width=\"120px\"></td>");
            sValue.Append("<td width=\"200px\"><strong>Matrícula: </strong>" + sMatricula + "</td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\"></td>");
            sValue.Append("<td width=\"130px\"></td>");
            sValue.Append("<td width=\"120px\"></td>");
            sValue.Append("<td width=\"200px\"><strong>Cilindrada: </strong>" + sCilindrada + "</td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\"><strong></strong></td>");
            sValue.Append("<td width=\"130px\"></td>");
            sValue.Append("<td width=\"120px\"></td>");
            sValue.Append("<td width=\"200px\"><strong>Nº Lugares: </strong>" + sNumeroLugares + "</td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\"></td>");
            sValue.Append("<td width=\"130px\"></td>");
            sValue.Append("<td width=\"120px\"></td>");
            sValue.Append("<td width=\"200px\"><strong>Uso: </strong>" + sUso + "</td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\"></td>");
            sValue.Append("<td width=\"130px\"></td>");
            sValue.Append("<td width=\"120px\"></td>");
            sValue.Append("<td width=\"200px\"><strong>Nº Chassis: </strong>" + sChassi + "</td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td colspan=\"4\">&nbsp;</td>");
            sValue.Append("</tr>");
            sValue.Append("</table>");
            
            //PREMIO - ANUAL/SEMESTRAL/TRIMESTRAL
            sValue.Append("<table width=\"600\" cellpadding=\"1\" cellspacing=\"1\" style=\"font-family: 'Arial Narrow'; font-size: 12px;padding-top:25px;text-align:center\" align=\"center\">");

            sValue.Append("<tr>");
            sValue.Append("<td colspan=\"6\" style=\"text-align:left\"><strong>PRÉMIO TOTAL</strong></td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"155px\"></td>");
            sValue.Append("<td style=\"background-color:#BF9000;color:white;height:18px;border-width:thin;border-color:darkgrey\" width=\"72px\">BASE</td>");
            sValue.Append("<td style=\"background-color:#BF9000;color:white;height:18px;border-width:thin;border-color:darkgrey\" width=\"98px\">RESPONSÁVEL</td>");
            sValue.Append("<td style=\"background-color:#BF9000;color:white;height:18px;border-width:thin;border-color:darkgrey\" width=\"89px\">TRANQUILO</td>");
            sValue.Append("<td style=\"background-color:#BF9000;color:white;height:18px;border-width:thin;border-color:darkgrey\" width=\"93px\">INTELIGENTE</td>");
            sValue.Append("<td width=\"86px\"></td>");
            sValue.Append("</tr>");
            sValue.Append("<tr>");
            sValue.Append("<td style=\"background-color:#BF9000;color:white;height:18px;border-width:thin;border-color:darkgrey\" width=\"155px\">ANUAL</td>");
            sValue.Append("<td style=\"background-color:lightgray;color:black;height:18px;border-width:thin;border-color:darkgrey\" width=\"72px\">" + General.FormataNumero(dicSimulacao["BASE_ANUAL"]) + "</td>");
            sValue.Append("<td style=\"background-color:lightgray;color:black;height:18px;border-width:thin;border-color:darkgrey\" width=\"98px\">" + General.FormataNumero(dicSimulacao["RESPONSAVEL_ANUAL"]) + "</td>");
            sValue.Append("<td style=\"background-color:lightgray;color:black;height:18px;border-width:thin;border-color:darkgrey\" width=\"89px\">" + General.FormataNumero(dicSimulacao["TRANQUILO_ANUAL"]) + "</td>");
            sValue.Append("<td style=\"background-color:lightgray;color:black;height:18px;border-width:thin;border-color:darkgrey\" width=\"93px\">" + General.FormataNumero(dicSimulacao["INTELIGENTE_ANUAL"]) + "</td>");
            sValue.Append("</tr>");
            sValue.Append("<tr>");
            sValue.Append("<td style=\"background-color:#BF9000;color:white;height:18px;border-width:thin;border-color:darkgrey\" width=\"155px\">SEMESTRAL</td>");
            sValue.Append("<td style=\"background-color:lightgray;color:black;height:18px;border-width:thin;border-color:darkgrey\" width=\"72px\">" + General.FormataNumero(dicSimulacao["BASE_SEMESTRAL"]) + "</td>");
            sValue.Append("<td style=\"background-color:lightgray;color:black;height:18px;border-width:thin;border-color:darkgrey\" width=\"98px\">" + General.FormataNumero(dicSimulacao["RESPONSAVEL_SEMESTRAL"]) + "</td>");
            sValue.Append("<td style=\"background-color:lightgray;color:black;height:18px;border-width:thin;border-color:darkgrey\" width=\"89px\">" + General.FormataNumero(dicSimulacao["TRANQUILO_SEMESTRAL"]) + "</td>");
            sValue.Append("<td style=\"background-color:lightgray;color:black;height:18px;border-width:thin;border-color:darkgrey\" width=\"93px\">" + General.FormataNumero(dicSimulacao["INTELIGENTE_SEMESTRAL"]) + "</td>");
            sValue.Append("</tr>");
            sValue.Append("<tr>");
            sValue.Append("<td style=\"background-color:#BF9000;color:white;height:18px;border-width:thin;border-color:darkgrey\" width=\"155px\">TRIMESTRAL</td>");
            sValue.Append("<td style=\"background-color:lightgray;color:black;height:18px;border-width:thin;border-color:darkgrey\" width=\"72px\">" + General.FormataNumero(dicSimulacao["BASE_TRIMESTRAL"]) + "</td>");
            sValue.Append("<td style=\"background-color:lightgray;color:black;height:18px;border-width:thin;border-color:darkgrey\" width=\"98px\">" + General.FormataNumero(dicSimulacao["RESPONSAVEL_TRIMESTRAL"]) + "</td>");
            sValue.Append("<td style=\"background-color:lightgray;color:black;height:18px;border-width:thin;border-color:darkgrey\" width=\"89px\">" + General.FormataNumero(dicSimulacao["TRANQUILO_TRIMESTRAL"]) + "</td>");
            sValue.Append("<td style=\"background-color:lightgray;color:black;height:18px;border-width:thin;border-color:darkgrey\" width=\"93px\">" + General.FormataNumero(dicSimulacao["INTELIGENTE_TRIMESTRAL"]) + "</td>");
            sValue.Append("</tr>");
            sValue.Append("</table>");

            sValue.Append("<table width=\"600\" cellpadding=\"1\" cellspacing=\"1\" style=\"font-family: 'Arial Narrow'; font-size: 12px;padding-top:25px;text-align:left\" align=\"center\">");
            sValue.Append("<tr style=\"font-size: 11px;\">");
            sValue.Append("<td colspan=\"4\">A presente simulação tem carácter meramente informativo, não vinculando a Master Seguros, estando sujeita à sua aceitação. Esta simulação tem como pressupostos os dados inseridos e a não existência de factores de agravamento de risco, nomeadamente a não circulação do veículo em áreas de acesso restrito e a não efectivação de transporte de matérias perigosas.</ td > ");
            sValue.Append("</tr>");
            sValue.Append("</table>");

            return sValue.ToString();

        }

        public static string getHTMLTabelaProposta(string sNome, string sProduto, string sMorada, string sNumeroCliente, string sProvincia, string sAdesao, string sUnidadeNegocio, string sQualidadeTomador, string sFraccionamento, string sMarca, string sModelo, string sDataInicio, string sDataFim, string sMatricula, string sCilindrada, string sNumeroLugares, string sUso, string sChassi, string sRespCivil, string sOcupantes, string sMorteInvalidez, string sDespesasTratamento, string sDespesasFuneral, string sChoqueColisao, string sFurtoRoubo, string sIncendioRaio, string sFranquiaCivil, string sFranquiaOcupantes, string sFraquiaMorteInvalidez, string sFranquiaDespesasTratamento, string sFranquiaDespesasFuneral, string sFranquiaChoqueColisao, string sFranquiaFurtoRoubo, string sFraquiaIncendioRaio, Dictionary<string, string> dicProposta)
        {
            StringBuilder sValue = new StringBuilder();

            sValue.Append("<table width=\"600\" cellpadding=\"0\" cellspacing=\"0\" style=\"font-family: Arial; font-size: 18px;padding-top:25px;text-align:left\" align=\"center\">");
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
            sValue.Append("<td width=\"200px\"><strong>PROPOSTA</strong></td>");
            sValue.Append("</tr>");
            sValue.Append("<tr style=\"font-size:14px\">");
            sValue.Append("<td width=\"150px\">&nbsp;</td>");
            sValue.Append("<td width=\"130px\">&nbsp;</td>");
            sValue.Append("<td width=\"120px\">&nbsp;</td>");
            sValue.Append("<td width=\"200px\"><strong>AUTOMÓVEL</strong></td>");
            sValue.Append("</tr>");
            sValue.Append("</table>");


            sValue.Append("<table width=\"600\" cellpadding=\"1\" cellspacing=\"1\" style=\"font-family: 'Arial Narrow'; font-size: 12px;padding-top:25px;text-align:left\" align=\"center\">");
            sValue.Append("<tr>");
            sValue.Append("<td colspan=\"4\" style=\"text-align:left\"><strong>&nbsp;</strong></td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td style=\"border-bottom:solid;border-color:gold\" width=\"150px\"><strong>APÓLICE</strong></td>");
            sValue.Append("<td style=\"border-bottom:solid;border-color:gold\" width=\"130px\">&nbsp;</td>");
            sValue.Append("<td style=\"border-bottom:solid;border-color:gold\" width=\"120px\">&nbsp;</td>");
            sValue.Append("<td style=\"border-bottom:solid;border-color:gold\" width=\"200px\"><strong>TOMADOR DO SEGURO</strong></td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\"><strong>Ramo:</strong></td>");
            sValue.Append("<td width=\"130px\">Não Vida</td>");
            sValue.Append("<td width=\"120px\"></td>");
            sValue.Append("<td width=\"200px\">" + sNome + "</td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\"><strong>Produto:</strong></td>");
            sValue.Append("<td width=\"130px\">Automóvel - " + sProduto + " </td>");
            sValue.Append("<td width=\"120px\"></td>");
            sValue.Append("<td width=\"200px\">" + sMorada + " </td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\"><strong>Cliente nº:</strong></td>");
            sValue.Append("<td width=\"130px\">" + sNumeroCliente + " </td>");
            sValue.Append("<td width=\"120px\"></td>");
            sValue.Append("<td width=\"200px\">" + sProvincia + " </td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\"><strong>Adesão nº:</strong></td>");
            sValue.Append("<td width=\"130px\">" + sAdesao + " </td>");
            sValue.Append("<td width=\"120px\"></td>");
            sValue.Append("<td width=\"200px\"></td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\"><strong>Agente/Mediador:</strong></td>");
            sValue.Append("<td width=\"130px\">" + getLoggedUser() + " </td>");
            sValue.Append("<td width=\"120px\"></td>");
            sValue.Append("<td width=\"200px\"><strong>QUALIDADE DO TOMADOR</strong></td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\"><strong>Unidade de Negócio:</strong></td>");
            sValue.Append("<td width=\"130px\">" + sUnidadeNegocio + " </td>");
            sValue.Append("<td width=\"120px\"></td>");
            sValue.Append("<td width=\"200px\">" + sQualidadeTomador + " </td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\"><strong>Fraccionamento:</strong></td>");
            sValue.Append("<td width=\"130px\">" + sFraccionamento + " </td>");
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
            sValue.Append("<td width=\"200px\"><strong>Marca/Modelo: </strong>" + sMarca + " " + sModelo + "</td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\">Início: ás 0 horas de:</td>");
            sValue.Append("<td width=\"130px\">" + sDataInicio + " </td>");
            sValue.Append("<td width=\"120px\">Cobrança Directa</td>");
            sValue.Append("<td width=\"200px\"><strong>Dt. 1ª Matrícula/Construção: </strong> 01/02/2013</td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\">Renovação/Termo:ás 24 horas de:</td>");
            sValue.Append("<td width=\"130px\">" + sDataFim + " </td>");
            sValue.Append("<td width=\"120px\"></td>");
            sValue.Append("<td width=\"200px\"><strong>Matrícula: </strong>" + sMatricula + "</td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\"></td>");
            sValue.Append("<td width=\"130px\"></td>");
            sValue.Append("<td width=\"120px\"></td>");
            sValue.Append("<td width=\"200px\"><strong>Cilindrada: </strong>" + sCilindrada + " c.c </td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\"><strong></strong></td>");
            sValue.Append("<td width=\"130px\"></td>");
            sValue.Append("<td width=\"120px\"></td>");
            sValue.Append("<td width=\"200px\"><strong>Nº Lugares: </strong>" + sNumeroLugares + "</td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\"></td>");
            sValue.Append("<td width=\"130px\"></td>");
            sValue.Append("<td width=\"120px\"></td>");
            sValue.Append("<td width=\"200px\"><strong>Uso: </strong>" + sUso + "</td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td colspan=\"3\"><strong>Moeda de contratação: </strong> AOA</td>");
            sValue.Append("<td width=\"200px\"><strong>Nº Chassis: </strong>" + sChassi + "</td>");
            sValue.Append("</tr>");

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
            sValue.Append("<td width=\"120px\">" + sRespCivil + "</td>");
            sValue.Append("<td width=\"200px\" style=\"text-align:left\">" + sFranquiaCivil+ "</td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\">Ocupantes</td>");
            sValue.Append("<td width=\"130px\"></td>");
            sValue.Append("<td width=\"120px\">" + sOcupantes + "</td>");
            sValue.Append("<td width=\"200px\">" + sFranquiaOcupantes + "</td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\">Morte ou Invalidez Permanente</td>");
            sValue.Append("<td width=\"130px\"></td>");
            sValue.Append("<td width=\"120px\">" + sMorteInvalidez + "</td>");
            sValue.Append("<td width=\"200px\">" + sFraquiaMorteInvalidez+ "</td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\">Despesas de Tratamento</td>");
            sValue.Append("<td width=\"130px\"></td>");
            sValue.Append("<td width=\"120px\">" + sDespesasTratamento + "</td>");
            sValue.Append("<td width=\"200px\">" + sFranquiaDespesasTratamento+ "</td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\">Despesas de Funeral</td>");
            sValue.Append("<td width=\"130px\"></td>");
            sValue.Append("<td width=\"120px\">" + sDespesasFuneral + "</td>");
            sValue.Append("<td width=\"200px\">" + sFranquiaDespesasFuneral+ "</td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\">Choque Colisão ou Capotamento</td>");
            sValue.Append("<td width=\"130px\"></td>");
            sValue.Append("<td width=\"120px\">" + sChoqueColisao+ "</td>");
            sValue.Append("<td width=\"200px\">" + sFranquiaChoqueColisao + "</td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\">Furto ou Roubo</td>");
            sValue.Append("<td width=\"130px\"></td>");
            sValue.Append("<td width=\"120px\">" + sFurtoRoubo + "</td>");
            sValue.Append("<td width=\"200px\">" + sFranquiaFurtoRoubo+ "</td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\">Incêndio, Raio ou Explosão</td>");
            sValue.Append("<td width=\"130px\"></td>");
            sValue.Append("<td width=\"120px\">" + sIncendioRaio + "</td>");
            sValue.Append("<td width=\"200px\">" + sFraquiaIncendioRaio+ "</td>");
            sValue.Append("</tr>");

            //A OPÇÂO EXTRA só aparece se existir, ou seja, se for diferente de "0"
            if (double.Parse(dicProposta["ValorOpcaoExtraAnual"].ToString()) != 0)
            {
                sValue.Append("<tr>");
                sValue.Append("<td width=\"150px\">Extra</td>");
                sValue.Append("<td width=\"130px\"></td>");
                sValue.Append("<td width=\"120px\">" + FormataNumero(dicProposta["ValorOpcaoExtraAnual"]) + "</td>");
                sValue.Append("<td width=\"200px\"></td>");
                sValue.Append("</tr>");
            }

            //PREMIO TOTAL E PARCELAS
            sValue.Append("<tr>");
            sValue.Append("<td colspan=\"4\">&nbsp;</td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td style=\"border-bottom:solid;border-color:gold\" width=\"150px\"><strong>PRÉMIO ANUAL</strong></td>");
            sValue.Append("<td style=\"border-bottom:solid;border-color:gold\" width=\"130px\"></td>");
            sValue.Append("<td style=\"border-bottom:solid;border-color:gold\" width=\"120px\"><strong>VALOR</strong></td>");
            sValue.Append("<td style=\"border-bottom:solid;border-color:gold\" width=\"200px\"></td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\">Prémio Simples</td>");
            sValue.Append("<td width=\"130px\"></td>");
            sValue.Append("<td width=\"120px\">" + FormataNumero(dicProposta["PremioSimplesAnual"]) + "</td>");
            sValue.Append("<td width=\"200px\"></td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\">Encargos</td>");
            sValue.Append("<td width=\"130px\"></td>");
            sValue.Append("<td width=\"120px\">" + FormataNumero(dicProposta["EncargosAnual"]) + "</td>");
            sValue.Append("<td width=\"200px\"></td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\">Arseg</td>");
            sValue.Append("<td width=\"130px\"></td>");
            sValue.Append("<td width=\"120px\">" + FormataNumero(dicProposta["ArsegAnual"]) + "</td>");
            sValue.Append("<td width=\"200px\"></td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\">FGA</td>");
            sValue.Append("<td width=\"130px\"></td>");
            sValue.Append("<td width=\"120px\">" + FormataNumero(dicProposta["FungaAnual"]) + "</td>");
            sValue.Append("<td width=\"200px\"></td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\">Custo Apólice</td>");
            sValue.Append("<td width=\"130px\"></td>");
            sValue.Append("<td width=\"120px\">" + FormataNumero(dicProposta["IncrementoApolice"]) + "</td>");
            sValue.Append("<td width=\"200px\"></td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\"><strong>Prémio Total</strong></td>");
            sValue.Append("<td width=\"130px\"></td>");
            sValue.Append("<td width=\"120px\">" + FormataNumero(dicProposta["PremioTotalAnual"]) + "</td>");
            sValue.Append("<td width=\"200px\"></td>");
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
            sValue.Append("<td width=\"150px\"><strong>CLÁUSULAS</strong></td>");
            sValue.Append("<td width=\"130px\"></td>");
            sValue.Append("<td width=\"120px\"></td>");
            sValue.Append("<td width=\"200px\"><strong></strong></td>");
            sValue.Append("</tr>");

            sValue.Append("<tr style=\"font-size: 11px;\">");
            sValue.Append("<td colspan=\"4\">Esta Simulação é Valida por trinta dias e os elementos nela constantes não podem em caso algum comprometer a Seguradora, sem dados que sirvam de base ao seu estabelecimento sejam definitivamente confirmados.A aceitação do seguro fica sempre dependente dos serviços da Master Seguros, SA.</ td > ");
            sValue.Append("</tr>");
            sValue.Append("</table>");

            return sValue.ToString();

        }

        public static string getHTMLTabelaPropostaFrota(string sNome, string sProduto, string sMorada, string sNumeroCliente, string sProvincia, string sAdesao, string sUnidadeNegocio, string sQualidadeTomador, string sFraccionamento, string sMarca, string sModelo, string sDataInicio, string sDataFim, string sMatricula, string sCilindrada, string sNumeroLugares, string sUso, string sChassi, string sRespCivil, string sOcupantes, string sMorteInvalidez, string sDespesasTratamento, string sDespesasFuneral, string sChoqueColisao, string sFurtoRoubo, string sIncendioRaio, string sFranquiaCivil, string sFranquiaOcupantes, string sFraquiaMorteInvalidez, string sFranquiaDespesasTratamento, string sFranquiaDespesasFuneral, string sFranquiaChoqueColisao, string sFranquiaFurtoRoubo, string sFraquiaIncendioRaio, Dictionary<string, string> dicPropostaFrota)
        {
            StringBuilder sValue = new StringBuilder();

            sValue.Append("<table width=\"600\" cellpadding=\"0\" cellspacing=\"0\" style=\"font-family: Arial; font-size: 18px;padding-top:25px;text-align:left\" align=\"center\">");
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
            sValue.Append("<td width=\"200px\"><strong>PROPOSTA</strong></td>");
            sValue.Append("</tr>");
            sValue.Append("<tr style=\"font-size:14px\">");
            sValue.Append("<td width=\"150px\">&nbsp;</td>");
            sValue.Append("<td width=\"130px\">&nbsp;</td>");
            sValue.Append("<td width=\"120px\">&nbsp;</td>");
            sValue.Append("<td width=\"200px\"><strong>AUTOMÓVEL</strong></td>");
            sValue.Append("</tr>");
            sValue.Append("</table>");


            sValue.Append("<table width=\"600\" cellpadding=\"1\" cellspacing=\"1\" style=\"font-family: 'Arial Narrow'; font-size: 12px;padding-top:25px;text-align:left\" align=\"center\">");
            sValue.Append("<tr>");
            sValue.Append("<td colspan=\"4\" style=\"text-align:left\"><strong>&nbsp;</strong></td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td style=\"border-bottom:solid;border-color:gold\" width=\"150px\"><strong>APÓLICE</strong></td>");
            sValue.Append("<td style=\"border-bottom:solid;border-color:gold\" width=\"130px\">&nbsp;</td>");
            sValue.Append("<td style=\"border-bottom:solid;border-color:gold\" width=\"120px\">&nbsp;</td>");
            sValue.Append("<td style=\"border-bottom:solid;border-color:gold\" width=\"200px\"><strong>TOMADOR DO SEGURO</strong></td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\"><strong>Ramo:</strong></td>");
            sValue.Append("<td width=\"130px\">Não Vida</td>");
            sValue.Append("<td width=\"120px\"></td>");
            sValue.Append("<td width=\"200px\">" + sNome + "</td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\"><strong>Produto:</strong></td>");
            sValue.Append("<td width=\"130px\">Automóvel - " + sProduto + " </td>");
            sValue.Append("<td width=\"120px\"></td>");
            sValue.Append("<td width=\"200px\">" + sMorada + " </td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\"><strong>Cliente nº:</strong></td>");
            sValue.Append("<td width=\"130px\">" + sNumeroCliente + " </td>");
            sValue.Append("<td width=\"120px\"></td>");
            sValue.Append("<td width=\"200px\">" + sProvincia + " </td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\"><strong>Adesão nº:</strong></td>");
            sValue.Append("<td width=\"130px\">" + sAdesao + " </td>");
            sValue.Append("<td width=\"120px\"></td>");
            sValue.Append("<td width=\"200px\"></td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\"><strong>Agente/Mediador:</strong></td>");
            sValue.Append("<td width=\"130px\">" + getLoggedUser() + " </td>");
            sValue.Append("<td width=\"120px\"></td>");
            sValue.Append("<td width=\"200px\"><strong>QUALIDADE DO TOMADOR</strong></td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\"><strong>Unidade de Negócio:</strong></td>");
            sValue.Append("<td width=\"130px\">" + sUnidadeNegocio + " </td>");
            sValue.Append("<td width=\"120px\"></td>");
            sValue.Append("<td width=\"200px\">" + sQualidadeTomador + " </td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\"><strong>Fraccionamento:</strong></td>");
            sValue.Append("<td width=\"130px\">" + sFraccionamento + " </td>");
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
            sValue.Append("<td width=\"200px\"><strong>Marca/Modelo: </strong>" + sMarca + " " + sModelo + "</td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\">Início: ás 0 horas de:</td>");
            sValue.Append("<td width=\"130px\">" + sDataInicio + " </td>");
            sValue.Append("<td width=\"120px\">Cobrança Directa</td>");
            sValue.Append("<td width=\"200px\"><strong>Dt. 1ª Matrícula/Construção: </strong>" + VALOR_NULO + "</td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\">Renovação/Termo:ás 24 horas de:</td>");
            sValue.Append("<td width=\"130px\">" + sDataFim + " </td>");
            sValue.Append("<td width=\"120px\"></td>");
            sValue.Append("<td width=\"200px\"><strong>Matrícula: </strong>" + sMatricula + "</td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\"></td>");
            sValue.Append("<td width=\"130px\"></td>");
            sValue.Append("<td width=\"120px\"></td>");
            sValue.Append("<td width=\"200px\"><strong>Cilindrada: </strong>" + sCilindrada + "</td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\"><strong></strong></td>");
            sValue.Append("<td width=\"130px\"></td>");
            sValue.Append("<td width=\"120px\"></td>");
            sValue.Append("<td width=\"200px\"><strong>Nº Lugares: </strong>" + sNumeroLugares + "</td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\"></td>");
            sValue.Append("<td width=\"130px\"></td>");
            sValue.Append("<td width=\"120px\"></td>");
            sValue.Append("<td width=\"200px\"><strong>Uso: </strong>" + sUso + "</td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td colspan=\"3\"><strong>Moeda de contratação: </strong> AOA</td>");
            sValue.Append("<td width=\"200px\"><strong>Nº Chassis: </strong>" + sChassi + "</td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td colspan=\"4\">&nbsp;</td>");
            sValue.Append("</tr>");
            /*
            sValue.Append("<tr>");
            sValue.Append("<td style=\"border-bottom:solid;border-color:gold\" width=\"150px\"><strong>COBERTURAS</strong></td>");
            sValue.Append("<td style=\"border-bottom:solid;border-color:gold\" width=\"130px\"></td>");
            sValue.Append("<td style=\"border-bottom:solid;border-color:gold\" width=\"120px\"><strong>VALORES LIMITE</strong></td>");
            sValue.Append("<td style=\"border-bottom:solid;border-color:gold\" width=\"200px\"><strong>FRANQUIA</strong></td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\">Responsabilidade Civil Obrigatória</td>");
            sValue.Append("<td width=\"130px\"></td>");
            sValue.Append("<td width=\"120px\">" + sRespCivil + "</td>");
            sValue.Append("<td width=\"200px\" style=\"text-align:left\">" + sFranquiaCivil + "</td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\">Ocupantes</td>");
            sValue.Append("<td width=\"130px\"></td>");
            sValue.Append("<td width=\"120px\">" + sOcupantes + "</td>");
            sValue.Append("<td width=\"200px\">" + sFranquiaOcupantes + "</td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\">Morte ou Invalidez Permanente</td>");
            sValue.Append("<td width=\"130px\"></td>");
            sValue.Append("<td width=\"120px\">" + sMorteInvalidez + "</td>");
            sValue.Append("<td width=\"200px\">" + sFraquiaMorteInvalidez + "</td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\">Despesas de Tratamento</td>");
            sValue.Append("<td width=\"130px\"></td>");
            sValue.Append("<td width=\"120px\">" + sDespesasTratamento + "</td>");
            sValue.Append("<td width=\"200px\">" + sFranquiaDespesasTratamento + "</td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\">Despesas de Funeral</td>");
            sValue.Append("<td width=\"130px\"></td>");
            sValue.Append("<td width=\"120px\">" + sDespesasFuneral + "</td>");
            sValue.Append("<td width=\"200px\">" + sFranquiaDespesasFuneral + "</td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\">Choque Colisão ou Capotamento</td>");
            sValue.Append("<td width=\"130px\"></td>");
            sValue.Append("<td width=\"120px\">" + sChoqueColisao + "</td>");
            sValue.Append("<td width=\"200px\">" + sFranquiaChoqueColisao + "</td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\">Furto ou Roubo</td>");
            sValue.Append("<td width=\"130px\"></td>");
            sValue.Append("<td width=\"120px\">" + sFurtoRoubo + "</td>");
            sValue.Append("<td width=\"200px\">" + sFranquiaFurtoRoubo + "</td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\">Incêndio, Raio ou Explosão</td>");
            sValue.Append("<td width=\"130px\"></td>");
            sValue.Append("<td width=\"120px\">" + sIncendioRaio + "</td>");
            sValue.Append("<td width=\"200px\">" + sFraquiaIncendioRaio + "</td>");
            sValue.Append("</tr>");

            //A OPÇÂO EXTRA só aparece se existir, ou seja, se for diferente de "0"
            if (double.Parse(dicProposta["ValorOpcaoExtraAnual"].ToString()) != 0)
            {
                sValue.Append("<tr>");
                sValue.Append("<td width=\"150px\">Extra</td>");
                sValue.Append("<td width=\"130px\"></td>");
                sValue.Append("<td width=\"120px\">" + FormataNumero(dicProposta["ValorOpcaoExtraAnual"]) + "</td>");
                sValue.Append("<td width=\"200px\"></td>");
                sValue.Append("</tr>");
            }

            //PREMIO TOTAL E PARCELAS
            sValue.Append("<tr>");
            sValue.Append("<td colspan=\"4\">&nbsp;</td>");
            sValue.Append("</tr>");
            */
            sValue.Append("<tr>");
            sValue.Append("<td style=\"border-bottom:solid;border-color:gold\" width=\"150px\"><strong>PRÉMIO ANUAL</strong></td>");
            sValue.Append("<td style=\"border-bottom:solid;border-color:gold\" width=\"130px\"></td>");
            sValue.Append("<td style=\"border-bottom:solid;border-color:gold\" width=\"120px\"><strong>VALOR</strong></td>");
            sValue.Append("<td style=\"border-bottom:solid;border-color:gold\" width=\"200px\"></td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\">Prémio Simples</td>");
            sValue.Append("<td width=\"130px\"></td>");
            sValue.Append("<td width=\"120px\">" + FormataNumero(dicPropostaFrota["PremioSimples"]) + "</td>");
            sValue.Append("<td width=\"200px\"></td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\">Encargos</td>");
            sValue.Append("<td width=\"130px\"></td>");
            sValue.Append("<td width=\"120px\">" + FormataNumero(dicPropostaFrota["Encargos"]) + "</td>");
            sValue.Append("<td width=\"200px\"></td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\">Arseg</td>");
            sValue.Append("<td width=\"130px\"></td>");
            sValue.Append("<td width=\"120px\">" + FormataNumero(dicPropostaFrota["Arseg"]) + "</td>");
            sValue.Append("<td width=\"200px\"></td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\">FGA</td>");
            sValue.Append("<td width=\"130px\"></td>");
            sValue.Append("<td width=\"120px\">" + FormataNumero(dicPropostaFrota["Funga"]) + "</td>");
            sValue.Append("<td width=\"200px\"></td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\">Custo Apólice</td>");
            sValue.Append("<td width=\"130px\"></td>");
            sValue.Append("<td width=\"120px\">" + FormataNumero(dicPropostaFrota["IncrementoApolice"]) + "</td>");
            sValue.Append("<td width=\"200px\"></td>");
            sValue.Append("</tr>");

            sValue.Append("<tr>");
            sValue.Append("<td width=\"150px\"><strong>Prémio Total</strong></td>");
            sValue.Append("<td width=\"130px\"></td>");
            sValue.Append("<td width=\"120px\">" + FormataNumero(dicPropostaFrota["PremioTotal"]) + "</td>");
            sValue.Append("<td width=\"200px\"></td>");
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
            sValue.Append("<td width=\"150px\"><strong>CLÁUSULAS</strong></td>");
            sValue.Append("<td width=\"130px\"></td>");
            sValue.Append("<td width=\"120px\"></td>");
            sValue.Append("<td width=\"200px\"><strong></strong></td>");
            sValue.Append("</tr>");

            sValue.Append("<tr style=\"font-size: 11px;\">");
            sValue.Append("<td colspan=\"4\">Esta Simulação é Valida por trinta dias e os elementos nela constantes não podem em caso algum comprometer a Seguradora, sem dados que sirvam de base ao seu estabelecimento sejam definitivamente confirmados.A aceitação do seguro fica sempre dependente dos serviços da Master Seguros, SA.</ td > ");
            sValue.Append("</tr>");
            sValue.Append("</table>");

            return sValue.ToString();

        }
        
        public static string GetAddTime(string Fraccionamento, string sDataInicio)
        {
            if (Fraccionamento == "ANUAL")
                return DateTime.Parse(sDataInicio).AddYears(1).AddDays(-1).ToString().Substring(0, 10);
            else if (Fraccionamento == "SEMESTRAL")
                return DateTime.Parse(sDataInicio).AddMonths(6).AddDays(-1).ToString().Substring(0, 10);
            else if (Fraccionamento == "TRIMESTRAL")
                return DateTime.Parse(sDataInicio).AddMonths(3).AddDays(-1).ToString().Substring(0, 10);
            else
                return DateTime.Parse(sDataInicio).ToString().Substring(0, 10);
        }

        public static string FormataNumero(string sNumero)
        {
            double dNumero;

            if (double.TryParse(sNumero, out dNumero))
            {
                return string.Format("{0:N}", dNumero);
            }
            else
            {
                return sNumero;
            }
        }
        
        public static string FormataNumeroValorNulo(string sNumero)
        {
            double dNumero;

            if (double.TryParse(sNumero, out dNumero))
            {
                if (dNumero==0)
                    return VALOR_NULO;
                else
                    return string.Format("{0:N}", dNumero);
            }
            else
            {
                return VALOR_NULO;
            }
        }

        public static string getDescricaoProduto(string iProduto)
        {
            switch (iProduto)
            {
                case "1":
                    return "Base";
                case "2":
                    return "Responsável";
                case "3":
                    return "Tranquilo";
                case "4":
                    return "Inteligente";
                default:
                    return "";
            }
        }
 
        public static void UpdateNumeroProposta(string sPropostaID, string sNumeroProposta, string sRamo)
        {
            using (SqlConnection con = new SqlConnection(General.getConnection()))
            {
                con.Open();

                SqlCommand sqlCommand = new SqlCommand("spActualizaNumeroProposta", con);
            
                sqlCommand.CommandType = System.Data.CommandType.StoredProcedure;

                SqlParameter paramPropostaID = sqlCommand.Parameters.Add("@PropostaID", SqlDbType.VarChar);
                SqlParameter paramNumeroProposta = sqlCommand.Parameters.Add("@NumeroProposta", SqlDbType.VarChar);
                SqlParameter paramRamo = sqlCommand.Parameters.Add("@Ramo", SqlDbType.VarChar);
                //SqlParameter paramEstado = sqlCommand.Parameters.Add("@Estado", SqlDbType.Int);

                paramPropostaID.Value = sPropostaID;
                paramNumeroProposta.Value = sNumeroProposta;
                //paramEstado.Value = 2;

                paramRamo.Value = sRamo;

                sqlCommand.ExecuteNonQuery();
            }
        }

        public static void UpdatePremioProposta(string sPropostaID, string sRespCivil, string sOcupantes, string sMorteInvalidez, string sDespesasTratamento, string sDespesasFuneral, string sChoqueColisao, string sFurtoRoubo, string sIncendioRaio, string sRespCivilFranquia, string sOcupantesFranquia, string sMorteInvalidezFranquia, string sDespesasTratamentoFranquia, string sDespesasFuneralFranquia, string sChoqueColisaoFranquia, string sFurtoRouboFranquia, string sIncendioRaioFranquia, string ValorOpcaoExtra, string PremioSimples, string Encargos, string Arseg, string Funga, string IncrementoApolice, string PremioTotal)
        {
            using (SqlConnection con = new SqlConnection(General.getConnection()))
            {
                con.Open();

                SqlCommand sqlCommand = new SqlCommand("spActualizaPremioPropostaAuto", con);

                sqlCommand.CommandType = System.Data.CommandType.StoredProcedure;

                SqlParameter paramPropostaID = sqlCommand.Parameters.Add("@PropostaID", SqlDbType.VarChar);
                SqlParameter paramRespCivil = sqlCommand.Parameters.Add("@RespCivil", SqlDbType.Decimal);
                SqlParameter paramOcupantes = sqlCommand.Parameters.Add("@Ocupantes", SqlDbType.VarChar);
                SqlParameter paramMorteInvalidez = sqlCommand.Parameters.Add("@MorteInvalidez", SqlDbType.Decimal);
                SqlParameter paramDespesasTratamento = sqlCommand.Parameters.Add("@DespesasTratamento", SqlDbType.Decimal);
                SqlParameter paramDespesasFuneral = sqlCommand.Parameters.Add("@DespesasFuneral", SqlDbType.Decimal);
                SqlParameter paramChoqueColisao = sqlCommand.Parameters.Add("@ChoqueColisao", SqlDbType.Decimal);
                SqlParameter paramFurtoRoubo = sqlCommand.Parameters.Add("@FurtoRoubo", SqlDbType.Decimal);
                SqlParameter paramIncendioRaio = sqlCommand.Parameters.Add("@IncendioRaio", SqlDbType.Decimal);
                SqlParameter paramRespCivilFranquia = sqlCommand.Parameters.Add("@RespCivilFranquia", SqlDbType.Decimal);
                SqlParameter paramOcupantesFranquia = sqlCommand.Parameters.Add("@OcupantesFranquia", SqlDbType.Decimal);
                SqlParameter paramMorteInvalidezFranquia = sqlCommand.Parameters.Add("@MorteInvalidezFranquia", SqlDbType.Decimal);
                SqlParameter paramDespesasTratamentoFranquia = sqlCommand.Parameters.Add("@DespesasTratamentoFranquia", SqlDbType.Decimal);
                SqlParameter paramDespesasFuneralFranquia = sqlCommand.Parameters.Add("@DespesasFuneralFranquia", SqlDbType.Decimal);
                SqlParameter paramChoqueColisaoFranquia = sqlCommand.Parameters.Add("@ChoqueColisaoFranquia", SqlDbType.Decimal);
                SqlParameter paramFurtoRouboFranquia = sqlCommand.Parameters.Add("@FurtoRouboFranquia", SqlDbType.Decimal);
                SqlParameter paramIncendioRaioFranquia = sqlCommand.Parameters.Add("@IncendioRaioFranquia", SqlDbType.Decimal);

                SqlParameter paramValorOpcaoExtra = sqlCommand.Parameters.Add("@ValorOpcaoExtra", SqlDbType.Decimal);
                SqlParameter paramPremioSimples = sqlCommand.Parameters.Add("@PremioSimples", SqlDbType.Decimal);
                SqlParameter paramEncargos = sqlCommand.Parameters.Add("@Encargos", SqlDbType.Decimal);
                SqlParameter paramArseg = sqlCommand.Parameters.Add("@Arseg", SqlDbType.Decimal);
                SqlParameter paramFunga = sqlCommand.Parameters.Add("@Funga", SqlDbType.Decimal);
                SqlParameter paramIncrementoApolice = sqlCommand.Parameters.Add("@IncrementoApolice", SqlDbType.Decimal);
                SqlParameter paramPremioTotal = sqlCommand.Parameters.Add("@PremioTotal", SqlDbType.Decimal);

                paramPropostaID.Value = sPropostaID;
                paramRespCivil.Value = ConverteValorNuloToEmpty(sRespCivil);
                paramOcupantes.Value = ConverteValorNuloToEmpty(sOcupantes);
                paramMorteInvalidez.Value = ConverteValorNuloToEmpty(sMorteInvalidez);
                paramDespesasTratamento.Value = ConverteValorNuloToEmpty(sDespesasTratamento);
                paramDespesasFuneral.Value = ConverteValorNuloToEmpty(sDespesasFuneral);
                paramChoqueColisao.Value = ConverteValorNuloToEmpty(sChoqueColisao);
                paramFurtoRoubo.Value = ConverteValorNuloToEmpty(sFurtoRoubo);
                paramIncendioRaio.Value = ConverteValorNuloToEmpty(sIncendioRaio);
                paramRespCivilFranquia.Value = ConverteValorNuloToEmpty(sRespCivilFranquia);
                paramOcupantesFranquia.Value = ConverteValorNuloToEmpty(sOcupantesFranquia);
                paramMorteInvalidezFranquia.Value = ConverteValorNuloToEmpty(sMorteInvalidezFranquia);
                paramDespesasTratamentoFranquia.Value = ConverteValorNuloToEmpty(sDespesasTratamentoFranquia);
                paramDespesasFuneralFranquia.Value = ConverteValorNuloToEmpty(sDespesasFuneralFranquia);
                paramChoqueColisaoFranquia.Value = ConverteValorNuloToEmpty(sChoqueColisaoFranquia);
                paramFurtoRouboFranquia.Value = ConverteValorNuloToEmpty(sFurtoRouboFranquia);
                paramIncendioRaioFranquia.Value = ConverteValorNuloToEmpty(sIncendioRaioFranquia);

                paramValorOpcaoExtra.Value = ConverteValorNuloToEmpty(ValorOpcaoExtra);
                paramPremioSimples.Value = ConverteValorNuloToEmpty(PremioSimples);
                paramEncargos.Value = ConverteValorNuloToEmpty(Encargos);
                paramArseg.Value = ConverteValorNuloToEmpty(Arseg);
                paramFunga.Value = ConverteValorNuloToEmpty(Funga);
                paramIncrementoApolice.Value = ConverteValorNuloToEmpty(IncrementoApolice);
                paramPremioTotal.Value = ConverteValorNuloToEmpty(PremioTotal);

                sqlCommand.ExecuteNonQuery();
            }
        }

        public static void CreatePropostaFrota(string PropostaID, string Matricula, string MarcaID, string ModeloID, DateTime DataFabrico, string Cilindrada, string Chassi, string Lugares, string UsoID, string RCCliente, string DPCliente, string CategoriaID, string TipoCategoriaID, string TipoSeguroID, string OcupantesOpcaoID, string ValorNovo, string ValorSegurar, string Franquia, string UserIDCriacao, DateTime DataCriacao, string RespCivilFranquia, string RespCivilValor, string OcupantesFranquia, string OcupantesValor, string MorteInvalidezFranquia, string MorteInvalidezValor, string DespesasTratamentoFranquia, string DespesasTratamentoValor, string DespesasFuneralFranquia, string DespesasFuneralValor, string ChoqueColisaoFranquia, string ChoqueColisaoValor, string FurtoRouboFranquia, string FurtoRouboValor, string IncendioRaioFranquia, string IncendioRaioValor, string PremioSimples, string Encargos, string Arseg, string FGA, string CustoApolice, string ValorOpcaoExtra, string PremioTotal)
        {
            using (SqlConnection con = new SqlConnection(General.getConnection()))
            {
                con.Open();

                SqlCommand sqlCommand = new SqlCommand("spCriaPropostaAutoFrota", con);

                sqlCommand.CommandType = CommandType.StoredProcedure;
                
                SqlParameter paramPropostaID = sqlCommand.Parameters.Add("@PropostaID", SqlDbType.Int);
                SqlParameter paramMatricula = sqlCommand.Parameters.Add("@Matricula", SqlDbType.VarChar);
                SqlParameter paramMarcaID = sqlCommand.Parameters.Add("@MarcaID", SqlDbType.Int);
                SqlParameter paramModeloID = sqlCommand.Parameters.Add("@ModeloID", SqlDbType.Int);
                SqlParameter paramDataFabrico = sqlCommand.Parameters.Add("@DataFabrico", SqlDbType.DateTime);
                SqlParameter paramCilindrada = sqlCommand.Parameters.Add("@Cilindrada", SqlDbType.VarChar);
                SqlParameter paramChassi = sqlCommand.Parameters.Add("@Chassi", SqlDbType.VarChar);
                SqlParameter paramLugares = sqlCommand.Parameters.Add("@Lugares", SqlDbType.Int);
                SqlParameter paramUsoID = sqlCommand.Parameters.Add("@UsoID", SqlDbType.Int);
                SqlParameter paramRCCliente = sqlCommand.Parameters.Add("@RCCliente", SqlDbType.Int);
                SqlParameter paramDPCliente = sqlCommand.Parameters.Add("@DPCliente", SqlDbType.Int);

                SqlParameter paramCategoriaID = sqlCommand.Parameters.Add("@CategoriaID", SqlDbType.Int);
                SqlParameter paramTipoCategoriaID = sqlCommand.Parameters.Add("@TipoCategoriaID", SqlDbType.VarChar);
                SqlParameter paramTipoSeguroID = sqlCommand.Parameters.Add("@TipoSeguroID", SqlDbType.Int);

                SqlParameter paramOcupantesOpcaoID = sqlCommand.Parameters.Add("@OcupantesOpcaoID", SqlDbType.Int);
                SqlParameter paramValorNovo = sqlCommand.Parameters.Add("@ValorNovo", SqlDbType.Int);
                SqlParameter paramValorSegurar = sqlCommand.Parameters.Add("@ValorSegurar", SqlDbType.Int);
                SqlParameter paramFranquia = sqlCommand.Parameters.Add("@Franquia", SqlDbType.Decimal);
                SqlParameter paramUserIDCriacao = sqlCommand.Parameters.Add("@UserIDCriacao", SqlDbType.VarChar);

                SqlParameter paramDataCriacao = sqlCommand.Parameters.Add("@DataCriacao", SqlDbType.DateTime);
                SqlParameter paramRespCivilFranquia = sqlCommand.Parameters.Add("@RespCivilFranquia", SqlDbType.Decimal);
                SqlParameter paramRespCivilValor = sqlCommand.Parameters.Add("@RespCivilValor", SqlDbType.VarChar);
                SqlParameter paramOcupantesFranquia = sqlCommand.Parameters.Add("@OcupantesFranquia", SqlDbType.Decimal);
                SqlParameter paramOcupantesValor = sqlCommand.Parameters.Add("@OcupantesValor", SqlDbType.Decimal);

                SqlParameter paramMorteInvalidezFranquia = sqlCommand.Parameters.Add("@MorteInvalidezFranquia", SqlDbType.Decimal);
                SqlParameter paramMorteInvalidezValor = sqlCommand.Parameters.Add("@MorteInvalidezValor", SqlDbType.Decimal);
                SqlParameter paramDespesasTratamentoFranquia = sqlCommand.Parameters.Add("@DespesasTratamentoFranquia", SqlDbType.Decimal);
                SqlParameter paramDespesasTratamentoValor = sqlCommand.Parameters.Add("@DespesasTratamentoValor", SqlDbType.Decimal);
                SqlParameter paramDespesasFuneralFranquia = sqlCommand.Parameters.Add("@DespesasFuneralFranquia", SqlDbType.Decimal);
                SqlParameter paramDespesasFuneralValor = sqlCommand.Parameters.Add("@DespesasFuneralValor", SqlDbType.Decimal);

                SqlParameter paramChoqueColisaoFranquia = sqlCommand.Parameters.Add("@ChoqueColisaoFranquia", SqlDbType.Decimal);
                SqlParameter paramChoqueColisaoValor = sqlCommand.Parameters.Add("@ChoqueColisaoValor", SqlDbType.Decimal);
                SqlParameter paramFurtoRouboFranquia = sqlCommand.Parameters.Add("@FurtoRouboFranquia", SqlDbType.Decimal);
                SqlParameter paramFurtoRouboValor = sqlCommand.Parameters.Add("@FurtoRouboValor", SqlDbType.Decimal);
                SqlParameter paramIncendioRaioFranquia = sqlCommand.Parameters.Add("@IncendioRaioFranquia", SqlDbType.Decimal);
                SqlParameter paramIncendioRaioValor = sqlCommand.Parameters.Add("@IncendioRaioValor", SqlDbType.Decimal);

                SqlParameter paramPremioSimples = sqlCommand.Parameters.Add("@PremioSimples", SqlDbType.Decimal);
                SqlParameter paramEncargos = sqlCommand.Parameters.Add("@Encargos", SqlDbType.Decimal);
                SqlParameter paramArseg = sqlCommand.Parameters.Add("@Arseg", SqlDbType.Decimal);
                SqlParameter paramFGA = sqlCommand.Parameters.Add("@FGA", SqlDbType.Decimal);
                SqlParameter paramCustoApolice = sqlCommand.Parameters.Add("@CustoApolice", SqlDbType.Decimal);
                SqlParameter paramValorOpcaoExtra = sqlCommand.Parameters.Add("@ValorOpcaoExtra", SqlDbType.Decimal);

                SqlParameter paramPremioTotal = sqlCommand.Parameters.Add("@PremioTotal", SqlDbType.Decimal);
                SqlParameter paramUserIDActualizacao = sqlCommand.Parameters.Add("@UserIDActualizacao", SqlDbType.VarChar);
                SqlParameter paramDataActualizacao = sqlCommand.Parameters.Add("@DataActualizacao", SqlDbType.DateTime);

                //Parameter - Values
                paramPropostaID.Value = ConverteValorNuloToEmpty(PropostaID);
                paramMatricula.Value = ConverteValorNuloToEmpty(Matricula);
                paramMarcaID.Value = ConverteValorNuloToEmpty(MarcaID);
                paramModeloID.Value = ConverteValorNuloToEmpty(ModeloID);
                paramDataFabrico.Value = DataFabrico;
                paramCilindrada.Value = ConverteValorNuloToEmpty(Cilindrada);
                paramChassi.Value = ConverteValorNuloToEmpty(Chassi);
                paramLugares.Value = ConverteValorNuloToEmpty(Lugares);
                paramUsoID.Value = ConverteValorNuloToEmpty(UsoID);
                paramRCCliente.Value = ConverteValorNuloToEmpty(RCCliente);
                paramDPCliente.Value = ConverteValorNuloToEmpty(DPCliente);
                paramCategoriaID.Value = ConverteValorNuloToEmpty(CategoriaID);
                paramTipoCategoriaID.Value = ConverteValorNuloToEmpty(TipoCategoriaID);
                paramTipoSeguroID.Value = ConverteValorNuloToEmpty(TipoSeguroID);
                paramOcupantesOpcaoID.Value = ConverteValorNuloToEmpty(OcupantesOpcaoID);
                paramValorNovo.Value = ConverteValorNuloToEmpty(ValorNovo);
                paramValorSegurar.Value = ConverteValorNuloToEmpty(ValorSegurar);
                paramFranquia.Value = ConverteValorNuloToEmpty(Franquia);
                paramUserIDCriacao.Value = ConverteValorNuloToEmpty(UserIDCriacao);

                paramDataCriacao.Value = DataCriacao;
                paramRespCivilFranquia.Value = ConverteValorNuloToEmpty(RespCivilFranquia);
                paramRespCivilValor.Value = ConverteValorNuloToEmpty(RespCivilValor);
                paramOcupantesFranquia.Value = ConverteValorNuloToEmpty(OcupantesFranquia);
                paramOcupantesValor.Value = ConverteValorNuloToEmpty(OcupantesValor);

                paramMorteInvalidezFranquia.Value = ConverteValorNuloToEmpty(MorteInvalidezFranquia);
                paramMorteInvalidezValor.Value = ConverteValorNuloToEmpty(MorteInvalidezValor);
                paramDespesasTratamentoFranquia.Value = ConverteValorNuloToEmpty(DespesasTratamentoFranquia);
                paramDespesasTratamentoValor.Value = ConverteValorNuloToEmpty(DespesasTratamentoValor);
                paramDespesasFuneralFranquia.Value = ConverteValorNuloToEmpty(DespesasFuneralFranquia);
                paramDespesasFuneralValor.Value = ConverteValorNuloToEmpty(DespesasFuneralValor);

                paramChoqueColisaoFranquia.Value = ConverteValorNuloToEmpty(ChoqueColisaoFranquia);
                paramChoqueColisaoValor.Value = ConverteValorNuloToEmpty(ChoqueColisaoValor);
                paramFurtoRouboFranquia.Value = ConverteValorNuloToEmpty(FurtoRouboFranquia);
                paramFurtoRouboValor.Value = ConverteValorNuloToEmpty(FurtoRouboValor);
                paramIncendioRaioFranquia.Value = ConverteValorNuloToEmpty(IncendioRaioFranquia);
                paramIncendioRaioValor.Value = ConverteValorNuloToEmpty(IncendioRaioValor);

                paramPremioSimples.Value = ConverteValorNuloToEmpty(PremioSimples);
                paramEncargos.Value = ConverteValorNuloToEmpty(Encargos);
                paramArseg.Value = ConverteValorNuloToEmpty(Arseg);
                paramFGA.Value = ConverteValorNuloToEmpty(FGA);
                paramCustoApolice.Value = ConverteValorNuloToEmpty(CustoApolice);
                paramValorOpcaoExtra.Value = ConverteValorNuloToEmpty(ValorOpcaoExtra);

                paramPremioTotal.Value = ConverteValorNuloToEmpty(PremioTotal);
                paramUserIDActualizacao.Value = DBNull.Value;
                paramDataActualizacao.Value = DBNull.Value;
               

                sqlCommand.ExecuteNonQuery();
            }
        }

        public static void DeletePropostaFrota(string PropostaID)
        {
            using (SqlConnection con = new SqlConnection(General.getConnection()))
            {
                con.Open();

                SqlCommand sqlCommand = new SqlCommand("spDeletePropostaAutoFrota", con);
                sqlCommand.CommandType = CommandType.StoredProcedure;
                SqlParameter paramPropostaID = sqlCommand.Parameters.Add("@PropostaID", SqlDbType.Int);
                //Parameter - Values
                paramPropostaID.Value = ConverteValorNuloToEmpty(PropostaID);
                sqlCommand.ExecuteNonQuery();
            }
        }

        public static Dictionary<string, string> GetListProdutoAuto()
        {
            Dictionary<string, string> dicProdutoAuto = new Dictionary<string, string>();

            dicProdutoAuto.Add("1", "Base");
            dicProdutoAuto.Add("2", "Responsável");
            dicProdutoAuto.Add("3", "Tranquilo");
            dicProdutoAuto.Add("4", "Inteligente");

            return dicProdutoAuto;
        }

        public static Dictionary<string, string> GetListQualidadeTomador()
        {
            Dictionary<string, string> dicQualidadeTomador = new Dictionary<string, string>();

            dicQualidadeTomador.Add("1", "Proprietário");
            dicQualidadeTomador.Add("2", "Credor hipotecário / Locatário");
            dicQualidadeTomador.Add("3", "Outra");
            dicQualidadeTomador.Add("4", "Usufrutuário");

            return dicQualidadeTomador;
        }

        public static Dictionary<string, string> GetListUso()
        {
            Dictionary<string, string> dicUso = new Dictionary<string, string>();

            dicUso.Add("1", "Particular");
            dicUso.Add("2", "Aluguer");
            dicUso.Add("3", "Serviço Táxi");

            return dicUso;
        }

        public static Dictionary<string, string> GetListMarca()
        {
            SqlDataReader rdrAux = null;
            Dictionary<string, string> dicMarca = new Dictionary<string, string>();
         
            using (SqlConnection con = new SqlConnection(Comum.General.getConnection()))
            {

                con.Open();
                SqlCommand sqlCommandAux = new SqlCommand("SELECT * FROM master_marca_veiculo", con);

                sqlCommandAux.CommandType = CommandType.Text;

                rdrAux = sqlCommandAux.ExecuteReader();

                while (rdrAux.Read())
                {
                    dicMarca.Add(rdrAux["MarcaID"].ToString(), rdrAux["Descricao"].ToString());                 
                }

                con.Close();
            }
            return dicMarca;
        }

        public static Dictionary<string, string> GetListModelo(string marcaID)
        {
            SqlDataReader rdrAux = null;
            Dictionary<string, string> dicModelo = new Dictionary<string, string>();

            using (SqlConnection con = new SqlConnection(Comum.General.getConnection()))
            {
                con.Open();
                SqlCommand sqlCommandAux = new SqlCommand("SELECT * FROM master_modelo_veiculo WHERE MarcaID=" + marcaID, con);

                sqlCommandAux.CommandType = CommandType.Text;

                rdrAux = sqlCommandAux.ExecuteReader();

                while (rdrAux.Read())
                {
                    dicModelo.Add(rdrAux["ModeloID"].ToString(), rdrAux["Descricao"].ToString());                    
                }

                con.Close();
            }
            return dicModelo;
        }

        public static Dictionary<string, string> GetListBanco()
        {
            SqlDataReader rdrAux = null;
            Dictionary<string, string> dicModelo = new Dictionary<string, string>();

            using (SqlConnection con = new SqlConnection(Comum.General.getConnection()))
            {
                con.Open();
                SqlCommand sqlCommandAux = new SqlCommand("SELECT * FROM master_banco", con);

                sqlCommandAux.CommandType = CommandType.Text;

                rdrAux = sqlCommandAux.ExecuteReader();

                while (rdrAux.Read())
                {
                    dicModelo.Add(rdrAux["nome"].ToString(), rdrAux["Descricao"].ToString());
                }

                con.Close();
            }
            return dicModelo;
        }

        public static Dictionary<string, string> GetListTipoCategoria()
        {
            SqlDataReader rdrAux = null;
            Dictionary<string, string> dicTipoCategoria = new Dictionary<string, string>();

            using (SqlConnection con = new SqlConnection(Comum.General.getConnection()))
            {
                con.Open();
                SqlCommand sqlCommandAux = new SqlCommand("SELECT * FROM master_tipo_categoria", con);

                sqlCommandAux.CommandType = CommandType.Text;

                rdrAux = sqlCommandAux.ExecuteReader();

                while (rdrAux.Read())
                {
                    dicTipoCategoria.Add(rdrAux["Codigo"].ToString(), rdrAux["Descricao"].ToString());
                }

                con.Close();
            }
            return dicTipoCategoria;
        }

        public static string BuildTipo(object Tipo)
        {
            try
            {
                if (Tipo.ToString() == "1")
                    return "Auto - Individual";
                else if (Tipo.ToString() == "2")
                    return "Auto - Frota";
                else if (Tipo.ToString() == "3")
                    return "Acidentes Trabalho";
                else if (Tipo.ToString() == "4")
                    return "Viagem";
                return "NA";
            }
            catch
            {
                return "";

            }
        }

        public static bool MergePDFs(List<String> InFiles, String OutFile)
        {
            bool merged = true;
            try
            {
                List<PdfReader> readerList = new List<PdfReader>();
                foreach (string filePath in InFiles)
                {
                    PdfReader pdfReader = new PdfReader(filePath);
                    readerList.Add(pdfReader);
                }

                //Define a new output document and its size, type
                Document document = new Document(PageSize.A4, 0, 0, 0, 0);
                //Create blank output pdf file and get the stream to write on it.
                PdfWriter writer = PdfWriter.GetInstance(document, new FileStream(OutFile, FileMode.Create));
                document.Open();

                foreach (PdfReader reader in readerList)
                {
                    PdfReader.unethicalreading = true;
                    for (int i = 1; i <= reader.NumberOfPages; i++)
                    {
                        PdfImportedPage page = writer.GetImportedPage(reader, i);
                        document.Add(iTextSharp.text.Image.GetInstance(page));
                    }
                }
                document.Close();
                foreach (PdfReader reader in readerList)
                {
                    reader.Close();
                }

            }
            catch (Exception ex)
            {
                merged = false;
            }


            return merged;
        }

    }
}