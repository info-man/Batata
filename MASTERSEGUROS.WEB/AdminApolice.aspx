<%@ Page Title="Clientes" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdminApolice.aspx.cs" Inherits="MASTERSEGUROS.WEB.AdminApolice" %>

<%@ Register TagPrefix="cc" Namespace="Winthusiasm.HtmlEditor" Assembly="Winthusiasm.HtmlEditor" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePartialRendering="true" />

    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
        <ContentTemplate>
            <asp:FormView ID="FormView1" runat="server" Width="100%" DataKeyNames="CAPID" DataSourceID="SqlDataSourceCTT" DefaultMode="Insert">

                <InsertItemTemplate>

                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td colspan="2">
                                <div id="accordion">
                                    <h3>Dados do Gerais</h3>
                                    <div>
                                        <table border="0" cellpadding="0" cellspacing="0" style="width: 100%; border-collapse: collapse; font-size: 13px;">
                                            <tr>
                                                <td style="width: 90px">Ramo:</td>
                                                <td>
                                                    <asp:DropDownList runat="server" ID="RamoComboBox" Width="115px">
                                                        <asp:ListItem Text="Automóvel" Value="1"></asp:ListItem>
                                                        <asp:ListItem Text="Vida" Value="2"></asp:ListItem>
                                                        <asp:ListItem Text="Saúde" Value="3"></asp:ListItem>
                                                        <asp:ListItem Text="Viagem" Value="4"></asp:ListItem>
                                                        <asp:ListItem Text="Ac. Pessoais" Value="5"></asp:ListItem>
                                                        <asp:ListItem Text="Ac. Trabalho" Value="6"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 90px">Tipo:</td>
                                                <td>
                                                    <asp:DropDownList runat="server" ID="TipoSeguroComboBox" Width="115px">
                                                        <asp:ListItem Text="Novo" Value="1"></asp:ListItem>
                                                        <asp:ListItem Text="Alteração" Value="2"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 50px">Broker:</td>
                                                <td>
                                                    <asp:DropDownList runat="server" ID="BrokerComboBox" Width="115px">
                                                        <asp:ListItem Text="Seguradora" Value="1"></asp:ListItem>
                                                        <asp:ListItem Text="Mediador" Value="2"></asp:ListItem>
                                                        <asp:ListItem Text="Agente" Value="3"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 90px">Número:</td>
                                                <td>
                                                    <asp:TextBox ID="NumeroExecutanteTextBox" runat="server" Width="110px" MaxLength="10" />
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                    <h3>Tomador do Seguro</h3>
                                    <div>
                                        <asp:Panel ID="pnlEscondePesquisa" runat="server" Visible="true">
                                            <table border="0" cellpadding="0" cellspacing="0" style="vertical-align: top">
                                                <tr>
                                                    <td>
                                                        <asp:Button ID="btnMostrarPesquisa" Visible="true" CssClass="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" runat="server" Text="Mostrar Pesquisa" OnClick="btnMostrarPesquisa_Click" />

                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:Panel>

                                        <asp:Panel ID="pnlMostrarPesquisa" runat="server" Visible="false">
                                            <table border="0" cellpadding="0" cellspacing="0" style="vertical-align: top" width="100%">
                                                <tr>
                                                    <td style="width: 80px">Nº Cliente:</td>
                                                    <td>
                                                        <asp:TextBox ID="NumeroClienteTextBox" runat="server" Width="30" MaxLength="10" />

                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>Nº Carta:</td>
                                                    <td>
                                                        <asp:TextBox ID="NumeroCartaTextBox" runat="server" Width="30" />

                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>Nome:</td>
                                                    <td>
                                                        <asp:TextBox ID="NomeClienteTextBox" runat="server" Width="200" MaxLength="100" />
                                                    </td>
                                                </tr>

                                                <tr>
                                                    <td colspan="2">
                                                        <br />
                                                        <asp:Button ID="btnPesquisar" CssClass="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" runat="server" Text="Pesquisar" CommandName="Select" OnClick="btnPesquisar_Click" />&nbsp;
                <asp:Button ID="btnEsconderPesquisa" CssClass="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" runat="server" Text="Esconder Pesquisa" OnClick="btnEsconderPesquisa_Click" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2">
                                                        <hr />
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:Panel>
                                        <table border="0" cellpadding="0" cellspacing="0" style="width: 100%; border-collapse: collapse; font-size: 13px;">
                                            <tr>
                                                <td style="width: 120px">Nome:</td>
                                                <td>
                                                    <asp:TextBox ID="NomeTextBox" Enabled="false" runat="server" Width="350" MaxLength="350" />
                                                    &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator5" ValidationGroup="Form" Display="Dynamic" runat="server" Text="*" ControlToValidate="NomeTextBox" class="erro" ToolTip="" SetFocusOnError="true">&otimes;</asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Morada:</td>
                                                <td>
                                                    <asp:TextBox ID="MoradaTextBox" Enabled="false" runat="server" Width="350" MaxLength="350" />

                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Província:</td>
                                                <td>
                                                    <asp:DropDownList runat="server" Enabled="false" BackColor="#EBEBE4" ID="ProvinciaIDComboBox" AutoPostBack="false" Width="205px" AppendDataBoundItems="true" DataSourceID="SqlDataSourceProvincia" DataValueField="ProvinciaId" DataTextField="Nome">
                                                        <asp:ListItem Value="" Text=""></asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Município:</td>
                                                <td>
                                                    <asp:DropDownList runat="server" Enabled="false" BackColor="#EBEBE4" ID="MunicipioIDComboBox" AutoPostBack="false" Width="205px" AppendDataBoundItems="true" DataSourceID="SqlDataSourceMunicipio" DataValueField="MunicipioId" DataTextField="Nome">
                                                        <asp:ListItem Value="" Text=""></asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Comuna:</td>
                                                <td>
                                                    <asp:DropDownList runat="server" Enabled="false" BackColor="#EBEBE4" ID="ComunaIDComboBox" AutoPostBack="false" Width="205px" AppendDataBoundItems="true" DataSourceID="SqlDataSourceComuna" DataValueField="ComunaId" DataTextField="Nome">
                                                        <asp:ListItem Value="" Text=""></asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Telefone:</td>
                                                <td>
                                                    <asp:TextBox ID="TelefoneTextBox" Enabled="false" runat="server" Width="200" MaxLength="400" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Telemóvel:</td>
                                                <td>
                                                    <asp:TextBox ID="TelemovelTextBox" Enabled="false" runat="server" Width="200" MaxLength="400" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>E-mail:</td>
                                                <td>
                                                    <asp:TextBox ID="EmailTextBox" Enabled="false" runat="server" Width="300" MaxLength="400" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>BI:</td>
                                                <td>
                                                    <asp:TextBox ID="BITextBox" Enabled="false" runat="server" Width="200" MaxLength="400" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>NIF:</td>
                                                <td>
                                                    <asp:TextBox ID="NIFTextBox" Enabled="false" runat="server" Width="200" MaxLength="400" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Profissão:</td>
                                                <td>
                                                    <asp:TextBox ID="ProfissaoTextBox" Enabled="false" runat="server" Width="200" MaxLength="400" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Carta Condução:</td>
                                                <td>
                                                    <asp:TextBox ID="CartaConducaoTextBox" Enabled="false" runat="server" Width="200" MaxLength="400" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Validade:
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="ValidadeTextBox" runat="server" Width="75" MaxLength="10" /><img alt="Data de Validade" src="images/31.png" style="vertical-align: text-bottom" />
                                                </td>
                                            </tr>

                                        </table>
                                    </div>
                                    <h3>Quem Contrata o Seguro</h3>
                                    <div>
                                        <table border="0" cellpadding="0" cellspacing="0" style="width: 100%; border-collapse: collapse; font-size: 13px;">
                                            <tr>
                                                <td style="width: 120px">Proprietário desde:</td>
                                                <td>
                                                    <asp:TextBox ID="ProprietarioDesdeTextBox" runat="server" Width="75" MaxLength="10" /><img alt="Propriétário desde" src="images/31.png" style="vertical-align: text-bottom" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 120px;">Adquirente c/ resp.:</td>
                                                <td>
                                                    <asp:DropDownList runat="server" ID="ResponsabilidadeAdquirente">
                                                        <asp:ListItem Value="1" Text="Própria"></asp:ListItem>
                                                        <asp:ListItem Value="2" Text="Locatário"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 120px">Outra:</td>
                                                <td>
                                                    <asp:TextBox ID="OutraResponsabilidade" runat="server" Width="350" MaxLength="350" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2">
                                                    <br />
                                                    Direitos ressalvados a favor de: Proprietário/Credor Hipotecário:</td>
                                            </tr>
                                            <tr>
                                                <td>Nome:</td>
                                                <td>
                                                    <asp:TextBox ID="DireitosNomeTextBox" runat="server" Width="350" MaxLength="350" />

                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Morada:</td>
                                                <td>
                                                    <asp:TextBox ID="DireitosMoradaTextBox" runat="server" Width="350" MaxLength="350" />

                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Província:</td>
                                                <td>
                                                    <asp:DropDownList runat="server" ID="ProvinciaDireitosComboBox" AutoPostBack="false" Width="205px" AppendDataBoundItems="true" DataSourceID="SqlDataSourceProvincia" DataValueField="ProvinciaId" DataTextField="Nome">
                                                        <asp:ListItem Value="" Text=""></asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Município:</td>
                                                <td>
                                                    <asp:DropDownList runat="server" ID="MunicipioDireitosComboBox" AutoPostBack="false" Width="205px" AppendDataBoundItems="true" DataSourceID="SqlDataSourceMunicipio" DataValueField="MunicipioId" DataTextField="Nome">
                                                        <asp:ListItem Value="" Text=""></asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Comuna:</td>
                                                <td>
                                                    <asp:DropDownList runat="server" ID="ComunaDireitosComboBox" AutoPostBack="false" Width="205px" AppendDataBoundItems="true" DataSourceID="SqlDataSourceComuna" DataValueField="ComunaId" DataTextField="Nome">
                                                        <asp:ListItem Value="" Text=""></asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                        </table>

                                    </div>
                                    <h3>Transferência Seguro</h3>
                                    <div>
                                        <table border="0" cellpadding="0" cellspacing="0" style="width: 100%; border-collapse: collapse; font-size: 13px;">
                                            <tr>
                                                <td style="width: 120px">Seguradora anterior:</td>
                                                <td>
                                                    <asp:DropDownList Width="100" runat="server" ID="TransfSeguradoraAnterior">
                                                        <asp:ListItem Value="1" Text="Ensa"></asp:ListItem>
                                                        <asp:ListItem Value="2" Text="Global"></asp:ListItem>
                                                        <asp:ListItem Value="3" Text="Nossa"></asp:ListItem>
                                                        <asp:ListItem Value="4" Text="Universal"></asp:ListItem>
                                                        <asp:ListItem Value="5" Text="Saham"></asp:ListItem>
                                                        <asp:ListItem Value="6" Text="Mundial "></asp:ListItem>
                                                        <asp:ListItem Value="7" Text="Trevo"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 120px">Nº Apólice:</td>
                                                <td>
                                                    <asp:TextBox ID="TransfNumeoApóliceTextBox" runat="server" Width="95" MaxLength="10" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 120px">Tem Débitos:</td>
                                                <td>
                                                    <asp:CheckBox ID="TransfTemDebitosCheckbox" runat="server" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 120px">Último Sinistro:</td>
                                                <td>
                                                    <asp:TextBox ID="TransfUltimoSinistoTextBox" runat="server" Width="75" MaxLength="10" /><img alt="Data Último Sinistro" src="images/31.png" style="vertical-align: text-bottom" />
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                    <h3>Condutor Habitual</h3>
                                    <div>
                                        O condutor habitual é o mesmo que o tomador?
                                        <asp:CheckBox runat="server" ID="CondHabMesmoTomadorCheckBox" AutoPostBack="true" /><br />
                                        <br />

                                        <table border="0" cellpadding="0" cellspacing="0" style="width: 100%; border-collapse: collapse; font-size: 13px;">
                                            <tr>
                                                <td style="width: 120px">Nome:</td>
                                                <td>
                                                    <asp:TextBox ID="CondHabNomeTextBox" runat="server" Width="350" MaxLength="350" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Morada:</td>
                                                <td>
                                                    <asp:TextBox ID="CondHabMoradaTextBox" runat="server" Width="350" MaxLength="350" />

                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Província:</td>
                                                <td>
                                                    <asp:DropDownList runat="server" ID="CondHabProvinciaComboBox" AutoPostBack="false" Width="205px" AppendDataBoundItems="true" DataSourceID="SqlDataSourceProvincia" DataValueField="ProvinciaId" DataTextField="Nome">
                                                        <asp:ListItem Value="" Text=""></asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Município:</td>
                                                <td>
                                                    <asp:DropDownList runat="server" ID="CondHabMunicipioComboBox" AutoPostBack="false" Width="205px" AppendDataBoundItems="true" DataSourceID="SqlDataSourceMunicipio" DataValueField="MunicipioId" DataTextField="Nome">
                                                        <asp:ListItem Value="" Text=""></asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Comuna:</td>
                                                <td>
                                                    <asp:DropDownList runat="server" ID="CondHabComunaComboBox" AutoPostBack="false" Width="205px" AppendDataBoundItems="true" DataSourceID="SqlDataSourceComuna" DataValueField="ComunaId" DataTextField="Nome">
                                                        <asp:ListItem Value="" Text=""></asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Telefone:</td>
                                                <td>
                                                    <asp:TextBox ID="CondHabTelefoneTextBox" runat="server" Width="200" MaxLength="400" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Telemóvel:</td>
                                                <td>
                                                    <asp:TextBox ID="CondHabTelemovelTextBox" runat="server" Width="200" MaxLength="400" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>E-mail:</td>
                                                <td>
                                                    <asp:TextBox ID="CondHabEmailTextBox" runat="server" Width="300" MaxLength="400" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>BI:</td>
                                                <td>
                                                    <asp:TextBox ID="CondHabBITextBox" runat="server" Width="200" MaxLength="400" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>NIF:</td>
                                                <td>
                                                    <asp:TextBox ID="CondHabNIFTextBox" runat="server" Width="200" MaxLength="400" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Profissão:</td>
                                                <td>
                                                    <asp:TextBox ID="CondHabProfissaoTextBox" runat="server" Width="200" MaxLength="400" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Carta Condução:</td>
                                                <td>
                                                    <asp:TextBox ID="CondHabCartaConducaoTextBox" runat="server" Width="200" MaxLength="400" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Validade:
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="CondHabValidadeTextBox" runat="server" Width="75" MaxLength="10" /><img alt="Data de Validade" src="images/31.png" style="vertical-align: text-bottom" />
                                                </td>
                                            </tr>
                                        </table>

                                    </div>

                                    <h3>Duração / Cobrança</h3>
                                    <div>
                                        <table border="0" cellpadding="0" cellspacing="0" style="width: 100%; border-collapse: collapse; font-size: 13px;">
                                            <tr>
                                                <td style="width: 130px">Ínicio:</td>
                                                <td>
                                                    <asp:TextBox ID="CobrancaInicioTextBox" runat="server" Width="75" MaxLength="10" /><img alt="Data de Ínicio" src="images/31.png" style="vertical-align: text-bottom" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Duração:</td>
                                                <td>
                                                    <asp:DropDownList runat="server" ID="CobrancaAnoSeguintesComboBox">
                                                        <asp:ListItem Value="1" Text="Ano e Seguintes"></asp:ListItem>
                                                        <asp:ListItem Value="2" Text="Temporário"></asp:ListItem>
                                                    </asp:DropDownList>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Com termo em:
                                                    <asp:TextBox ID="CobrancaDataTermoTextBox" runat="server" Width="75" MaxLength="10" /><img alt="Data de Validade" src="images/31.png" style="vertical-align: text-bottom" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Fraccionamento:</td>
                                                <td>
                                                    <asp:DropDownList runat="server" ID="CobrancaFraccionamentoComboBox">
                                                        <asp:ListItem Value="1" Text="Anual"></asp:ListItem>
                                                        <asp:ListItem Value="2" Text="Semestral"></asp:ListItem>
                                                        <asp:ListItem Value="3" Text="Trimestral"></asp:ListItem>
                                                        <asp:ListItem Value="4" Text="Único"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Forma Pagamento:</td>
                                                <td>
                                                    <asp:DropDownList runat="server" ID="CobrancaFormaPagamentoComboBox">
                                                        <asp:ListItem Value="1" Text="Transferência Bancária"></asp:ListItem>
                                                        <asp:ListItem Value="2" Text="Depósito Bancário"></asp:ListItem>
                                                        <asp:ListItem Value="3" Text="Referência Multicaixa"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>

                                    <h3>Veículo a Segurar</h3>
                                    <div>
                                        <table border="0" cellpadding="0" cellspacing="0" style="width: 100%; border-collapse: collapse; font-size: 13px;">
                                            <tr>
                                                <td style="width: 30%">
                                                    <table border="0" cellpadding="0" cellspacing="0" style="width: 100%; border-collapse: collapse; font-size: 13px;">
                                                        <tr>
                                                            <td style="width: 120px">Matrícula:</td>
                                                            <td>
                                                                <asp:TextBox ID="MatriculaTextBox" runat="server" Width="95" MaxLength="10" />
                                                                &nbsp;<asp:RequiredFieldValidator ID="ReqValMatriculaTextBox" ValidationGroup="Form" Display="Dynamic" runat="server" Text="*" ControlToValidate="MatriculaTextBox" ToolTip="" SetFocusOnError="true">&otimes;</asp:RequiredFieldValidator>

                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width: 120px">Marca:</td>
                                                            <td>
                                                                <asp:DropDownList Width="200" runat="server" ID="MarcaComboBox" AppendDataBoundItems="true" DataSourceID="MarcaDatasource" DataTextField="Descricao" DataValueField="MarcaID" OnSelectedIndexChanged="MarcaComboBox_SelectedIndexChanged" AutoPostBack="true">
                                                                    <asp:ListItem Value="" Text="Seleccione um opção"></asp:ListItem>
                                                                </asp:DropDownList>
                                                                &nbsp;<asp:RequiredFieldValidator ID="ReqValMarcaComboBox" ValidationGroup="Form" Display="Dynamic" runat="server" Text="*" ControlToValidate="MarcaComboBox" ToolTip="" SetFocusOnError="true">&otimes;</asp:RequiredFieldValidator>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width: 120px">Modelo:</td>
                                                            <td>
                                                                <asp:DropDownList Width="200" runat="server" ID="ModeloComboBox" AppendDataBoundItems="true" DataSourceID="ModeloDatasource" DataTextField="Descricao" DataValueField="ModeloID">
                                                                    <asp:ListItem Value="" Text="Seleccione um opção"></asp:ListItem>
                                                                </asp:DropDownList>
                                                                &nbsp;<asp:RequiredFieldValidator ID="ReqValModeloComboBox" ValidationGroup="Form" Display="Dynamic" runat="server" Text="*" ControlToValidate="ModeloComboBox" ToolTip="" SetFocusOnError="true">&otimes;</asp:RequiredFieldValidator>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width: 120px">Cor:</td>
                                                            <td>
                                                                <asp:DropDownList Width="200" runat="server" ID="CorComboBox" AppendDataBoundItems="true" DataSourceID="CorDatasource" DataTextField="Descricao" DataValueField="CorID">
                                                                    <asp:ListItem Value="" Text="Seleccione um opção"></asp:ListItem>
                                                                </asp:DropDownList>
                                                                &nbsp;<asp:RequiredFieldValidator ID="ReqValCorComboBox" ValidationGroup="Form" Display="Dynamic" runat="server" Text="*" ControlToValidate="CorComboBox" ToolTip="" SetFocusOnError="true">&otimes;</asp:RequiredFieldValidator>

                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width: 120px">Nº Chassi:</td>
                                                            <td>
                                                                <asp:TextBox ID="ChassiTextBox" runat="server" Width="195" MaxLength="30" />
                                                            </td>
                                                        </tr>




                                                    </table>
                                                </td>
                                                <td style="width: 50%">
                                                    <table border="0" cellpadding="0" cellspacing="0" style="width: 100%; border-collapse: collapse; font-size: 13px;">
                                                        <tr>
                                                            <td style="width: 120px">Data de Fabrico:</td>
                                                            <td>
                                                                <asp:TextBox ID="DataFabricoTextBox" runat="server" Width="75" MaxLength="10" /><img alt="Data de Fabrico" src="images/31.png" style="vertical-align: text-bottom" />&nbsp;
                                &nbsp;<asp:RequiredFieldValidator ID="ReqValDataFabricoTextBox" ValidationGroup="Form" Display="Dynamic" runat="server" Text="*" ControlToValidate="DataFabricoTextBox" ToolTip="" SetFocusOnError="true">&otimes;</asp:RequiredFieldValidator>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width: 120px">Cilindrada:</td>
                                                            <td>
                                                                <asp:TextBox ID="TextBox1" runat="server" Width="95" MaxLength="10" />
                                                                &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator1" ValidationGroup="Form" Display="Dynamic" runat="server" Text="*" ControlToValidate="MatriculaTextBox" ToolTip="" SetFocusOnError="true">&otimes;</asp:RequiredFieldValidator>

                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width: 120px">Peso Bruto:</td>
                                                            <td>
                                                                <asp:TextBox ID="TextBox2" runat="server" Width="95" MaxLength="10" />
                                                                &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator2" ValidationGroup="Form" Display="Dynamic" runat="server" Text="*" ControlToValidate="MatriculaTextBox" ToolTip="" SetFocusOnError="true">&otimes;</asp:RequiredFieldValidator>

                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width: 120px">Lugares:</td>
                                                            <td>
                                                                <asp:TextBox ID="TextBox3" runat="server" Width="95" MaxLength="10" />
                                                                &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator3" ValidationGroup="Form" Display="Dynamic" runat="server" Text="*" ControlToValidate="MatriculaTextBox" ToolTip="" SetFocusOnError="true">&otimes;</asp:RequiredFieldValidator>

                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width: 120px">Combustível:</td>
                                                            <td>
                                                                <asp:DropDownList Width="200" runat="server" ID="CombustivelComboBox" AppendDataBoundItems="true">
                                                                    <asp:ListItem Value="1" Text="Gasolina"></asp:ListItem>
                                                                    <asp:ListItem Value="2" Text="Gasóleo"></asp:ListItem>
                                                                </asp:DropDownList>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>



                                    </div>

                                    <h3>Coberturas e Capitais a Segurar</h3>
                                    <div>
                                        <p>Nam enim risus, molestie et, porta ac, aliquam ac, risus. Quisque lobortis. Phasellus pellentesque purus in massa. Aenean in pede. Phasellus ac libero ac tellus pellentesque semper. Sed ac felis. Sed commodo, magna quis lacinia ornare, quam ante aliquam nisi, eu iaculis leo purus venenatis dui. </p>
                                        <ul>
                                            <li>List item</li>
                                            <li>List item</li>
                                            <li>List item</li>
                                            <li>List item</li>
                                            <li>List item</li>
                                            <li>List item</li>
                                            <li>List item</li>
                                        </ul>
                                    </div>

                                </div>
                            </td>


                        </tr>
                        <tr>
                            <td colspan="2">
                                <hr />
                            </td>
                        </tr>
                    </table>


                    <asp:Button ID="InsertButton" ValidationGroup="Form" CssClass="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" runat="server" Text="Guardar" CommandName="Insert" CausesValidation="True" />
                </InsertItemTemplate>

                <EditItemTemplate>


                    <asp:Button ID="BackButton" ValidationGroup="Form" CssClass="ui-button2 ui-widget ui-state-default ui-corner-all ui-button-text-only" runat="server" Text="Voltar" CausesValidation="True" OnClientClick="history.back(-1);" />
                    <asp:Button ID="ValidateButton" Visible="false" ValidationGroup="Form" CssClass="ui-button2 ui-widget ui-state-default ui-corner-all ui-button-text-only" runat="server" Text="Aprovar" CausesValidation="True" />
                    <asp:Button ID="ReproveButton" Visible="false" ValidationGroup="Form" CssClass="ui-button2 ui-widget ui-state-default ui-corner-all ui-button-text-only" runat="server" Text="Reprovar" CausesValidation="True" />
                    <asp:Button ID="UpdateButton" ValidationGroup="Form" CssClass="ui-button2 ui-widget ui-state-default ui-corner-all ui-button-text-only" runat="server" Text="Guardar" CommandName="Update" CausesValidation="True" />

                </EditItemTemplate>
            </asp:FormView>
        </ContentTemplate>
    </asp:UpdatePanel>
    <div id="dialog-confirmInsereClassificador" title="CTT" style="display: none">
        <br />
        <b>Tem a certeza que pretende adicionar um classificador?</b>
    </div>
    <div id="dialog-confirmActualizarClassificador" title="CTT" style="display: none">
        <br />
        <b>Tem a certeza que pretende actualizar o classificador?</b>
    </div>
    <div id="dialog-ClassificadorActualizado" title="CTT" style="display: none">
        <br />
        <b>O classificador foi actualizado com sucesso.</b>
    </div>
    <div id="dialog-MilitanteCriado" title="CTT" style="display: none">
        <br />
        <b>O Cliente foi criado com sucesso.</b>
    </div>
    <div id="dialog-RelatorioErroGravar" title="CTT" style="display: none">
        <br />
        <b>Ocorreu um erro a gravar os dados.<br />
            Comunique ao administrador de sistemas.</b>
    </div>

    <div id="dialog-form" title="CTT" style="display: none">
        <b>Comités de Acção Política:</b>
        <table id="users" class="ui-widget ui-widget-content">

            <asp:GridView ID="gridviewCAP" runat="server"
                AllowPaging="False" AllowSorting="False" AutoGenerateColumns="False"
                CellPadding="4"
                PagerSettings-PageButtonCount="15" PageSize="15"
                HeaderStyle-CssClass="SGCRowHeader"
                AlternatingRowStyle-CssClass="SGCdadosBodyAlt"
                RowStyle-CssClass="SGCdadosBodyNorm">
                <AlternatingRowStyle BackColor="White" />
                <Columns>

                    <asp:BoundField DataField="CAPID" HeaderText="ID"
                        SortExpression="CAPID" ItemStyle-HorizontalAlign="Right" />

                    <asp:BoundField DataField="Numero" HeaderText="Número"
                        SortExpression="Numero" ItemStyle-HorizontalAlign="Right" />

                    <asp:BoundField DataField="Nome" ItemStyle-Width="150px" HeaderText="Nome"
                        SortExpression="Nome" ItemStyle-HorizontalAlign="Left" />

                    <asp:BoundField DataField="NomeProvincia" ItemStyle-Width="75px" HeaderText="Província"
                        SortExpression="NomeProvincia" ItemStyle-HorizontalAlign="Left" />

                    <asp:BoundField DataField="NomeMunicipio" ItemStyle-Width="75px" HeaderText="Município"
                        SortExpression="NomeMunicipio" ItemStyle-HorizontalAlign="Left" />

                    <asp:BoundField DataField="NomeComuna" ItemStyle-Width="75px" HeaderText="Comuna"
                        SortExpression="Comuna" ItemStyle-HorizontalAlign="Left" />


                    <asp:TemplateField HeaderText="Operações" ItemStyle-HorizontalAlign="Left">
                        <ItemTemplate>
                            <asp:LinkButton ID="lnkSelClassificador" runat="server" Text='Seleccionar' OnClientClick='<%# Eval("CAPID", "SelClassificador(\"{0}\");") %>'></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>

                </Columns>
                <EditRowStyle BackColor="#C2F0C4" />
                <FooterStyle BackColor="#427c97" Font-Bold="False" ForeColor="White" />
                <HeaderStyle Font-Bold="False" ForeColor="White" />
                <PagerSettings PageButtonCount="15"></PagerSettings>
                <PagerStyle BackColor="#427c97" ForeColor="White" HorizontalAlign="Center" Height="10" CssClass="PagerStyle" />
                <RowStyle BackColor="#E3EAEB" />
                <SelectedRowStyle BackColor="#C5BBAF" Font-Bold="False" ForeColor="#333333" />
                <SortedAscendingCellStyle BackColor="#F8FAFA" />
                <SortedAscendingHeaderStyle BackColor="#1F6500" />
                <SortedDescendingCellStyle BackColor="#D4DFE1" />
                <SortedDescendingHeaderStyle BackColor="#1F6500" />
                <EmptyDataRowStyle BorderStyle="None" BorderWidth="0px" />
                <EmptyDataTemplate>Não foram encontrados registos</EmptyDataTemplate>
            </asp:GridView>
        </table>
    </div>

    <div id="dialog-Media" title="CTT" style="display: none">
        <asp:Image runat="server" ID="imgVerMedia" />
    </div>



   

    <asp:SqlDataSource ID="SqlDataSourceProvincia" runat="server"
        ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"
        SelectCommand="SELECT * FROM [master_provincia] ORDER BY NOME "></asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceMunicipio" runat="server"
        ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"
        SelectCommand="SELECT * FROM [master_municipio] ORDER BY NOME"></asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceComuna" runat="server"
        ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"
        SelectCommand="SELECT * FROM [master_comuna] ORDER BY NOME"></asp:SqlDataSource>

    <asp:SqlDataSource ID="MarcaDatasource" runat="server"
        ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"
        SelectCommand="SELECT * FROM [master_marca_veiculo] WHERE Estado=1"></asp:SqlDataSource>

    <asp:SqlDataSource ID="ModeloDatasource" runat="server"
        ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"
        SelectCommand="SELECT * FROM [master_modelo_veiculo] WHERE  MarcaID=@MarcaID AND Estado=1">
        <SelectParameters>
            <asp:ControlParameter ControlID="ctl00$MainContent$FormView1$MarcaComboBox" PropertyName="SelectedValue" Name="MarcaID" Type="Int32" DefaultValue="0" />
        </SelectParameters>
    </asp:SqlDataSource>


    <asp:SqlDataSource ID="ParcelamentoDatasource" runat="server"
        ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"
        SelectCommand="SELECT  ConfigKey, Descricao FROM master_configuracao WHERE ConfigType= 'PARCELA_PAGAMENTO'"></asp:SqlDataSource>


    <asp:SqlDataSource ID="CorDatasource" runat="server"
        ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"
        SelectCommand="SELECT * FROM [master_cor]"></asp:SqlDataSource>

    <asp:SqlDataSource ID="BancoDatasource" runat="server"
        ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"
        SelectCommand="SELECT * FROM [master_banco]"></asp:SqlDataSource>

    <script type="text/javascript">
        SetInitialize();

        function SetInitialize() {
            $("#accordion").accordion({
                heightStyle: "content"
            });
            var icons = {
                header: "ui-icon-circle-arrow-e",
                activeHeader: "ui-icon-circle-arrow-s"
            };
            $("#accordion").accordion({
                icons: icons
            });

            

        }


        function SetAcordion(acordID) {
            $("#accordion").accordion({
                heightStyle: "content"
            });
            var icons = {
                header: "ui-icon-circle-arrow-e",
                activeHeader: "ui-icon-circle-arrow-s"
            };
            $("#accordion").accordion({
                icons: icons
            });

            $("#accordion").accordion({
                active: acordID
            });

        }
        

        function MessageBoxSucessoGravar(refString) {
            $("#dialog-ErroGravar").dialog({
                title: "MASTER SEGUROS",
                resizable: false,
                width: 430,
                height: 200,
                modal: true,
                buttons: {
                    "OK": function () {
                        $(this).dialog("close");
                        return true;
                    }
                }

            });
            return false;
        }

        function MessageBoxErroGravar(refString) {
            $("#dialog-ErroGravar").dialog({
                title: "MASTER SEGUROS",
                resizable: false,
                width: 430,
                height: 200,
                modal: true,
                buttons: {
                    "OK": function () {
                        $(this).dialog("close");
                        return true;
                    }
                }

            });
            return false;
        }

    </script>

</asp:Content>
