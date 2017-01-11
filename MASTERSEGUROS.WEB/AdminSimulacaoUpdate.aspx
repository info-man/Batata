<%@ Page Title="Simulação de Seguro"  Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdminSimulacaoUpdate.aspx.cs" Inherits="MASTERSEGUROS.WEB.AdminSimulacaoUpdate"  %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
  
<asp:ScriptManager ID="ScriptManager1" runat="server" EnablePartialRendering="true" EnableCdn="true"/>
  
    <asp:FormView ID="FormView1" runat="server"   Width="100%" DataKeyNames="PropostaID" DataSourceID="SqlDataSourcePropostaAuto" DefaultMode="Edit" >

        <EditItemTemplate>
            
             <table border="0" cellpadding="0" cellspacing="0" width="100%">
                 <tr>
                     <td colspan="2">
                          <div id="accordion">
                              <h3>Tomador do Seguro</h3>
                              <div>
                             <table border="0" cellpadding="0" cellspacing="0"   style="width:100%;border-collapse:collapse;font-size: 13px;">
                                
                                <tr>
                                    <td style="width:50px">Broker: <img alt="" style="vertical-align:middle" src="img/yes.png" /></td>
                                    <td>
                                        <asp:DropDownList runat="server" ID="BrokerComboBox"  Width="115px">
                                            <asp:ListItem Text="Seguradora" Value="1"></asp:ListItem>
                                            <asp:ListItem Text="Mediador" Value="2"></asp:ListItem>
                                            <asp:ListItem Text="Agente" Value="3"></asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                 <tr>
                                    <td style="width:50px">Tomador: <img alt="" style="vertical-align:middle" src="img/yes.png" /></td>
                                    <td>
                                        <asp:DropDownList runat="server" ID="ClienteComboBox"  Width="115px">
                                            <asp:ListItem Text="Novo" Value="1"></asp:ListItem>
                                            <asp:ListItem Text="Existente" Value="2"></asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                 <tr>
                                    <td style="width:90px">Nome: <img alt="" style="vertical-align:middle" src="img/yes2.png" /></td>
                                    <td>
                                        <asp:TextBox ID="NomeTextBox" Text='<%#Bind("Nome") %>'  runat="server" Width="350" MaxLength="350" />
                                        &nbsp;<asp:RequiredFieldValidator ID="ReqValNomeTextBox" ValidationGroup="Form" Display="Dynamic" runat="server" Text="*" ControlToValidate="NomeTextBox"  ToolTip="" SetFocusOnError="true">&otimes;</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Morada: <img alt="" style="vertical-align:middle" src="img/yes.png" /></td>
                                    <td>
                                        <asp:TextBox ID="MoradaTextBox" Text='<%#Bind("Morada") %>'  runat="server"  Width="350" MaxLength="350" />
                                        &nbsp;<asp:RequiredFieldValidator ID="ReqValMoradaTextbox" ValidationGroup="Form" Display="Dynamic" runat="server" Text="*" ControlToValidate="MoradaTextBox"  ToolTip="" SetFocusOnError="true">&otimes;</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Província:</td>
                                    <td>
                                        <asp:DropDownList runat="server"  ID="ProvinciaIDComboBox" AutoPostBack ="false"  Width="200px"    AppendDataBoundItems="true"  DataSourceID="SqlDataSourceProvincia"   DataValueField="ProvinciaId"  DataTextField="Nome" >
                                        
                                        </asp:DropDownList>
                                    </td>
                                </tr>

                                 <tr>
                                    <td>Telemóvel: <img alt="" style="vertical-align:middle" src="img/yes2.png" /></td>
                                    <td>
                                        <asp:TextBox ID="TelemovelTextBox"  Text='<%#Bind("Telemovel") %>'  runat="server"  Width="200" MaxLength="400" />
                                         &nbsp;<asp:RequiredFieldValidator ID="ReqValTelemovelTextbox" ValidationGroup="Form" Display="Dynamic" runat="server" Text="*" ControlToValidate="TelemovelTextBox"  ToolTip="" SetFocusOnError="true">&otimes;</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td>E-mail:</td>
                                    <td>
                                        <asp:TextBox ID="EmailTextBox" Text='<%#Bind("Email") %>'  runat="server"  Width="300" MaxLength="400" />
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width:120px">Data de Início: <img alt="" style="vertical-align:middle" src="img/yes.png" /></td>
                                    <td>
                                        <asp:TextBox ID="DataInicioTextBox" Text='<%#Bind("DataInicio") %>'  runat="server"  Width="75" MaxLength="10"  /><img alt="Data de Início" src="images/31.png" style="vertical-align:text-bottom" />
                                        &nbsp;<asp:RequiredFieldValidator ID="ReqValDataInicioTextBox" ValidationGroup="Form" Display="Dynamic" runat="server" Text="*" ControlToValidate="DataInicioTextBox"  ToolTip="" SetFocusOnError="true">&otimes;</asp:RequiredFieldValidator>
                                              <asp:RangeValidator ID="RngValDataInicioTextBox"   ValidationGroup="Form" Display="Dynamic" runat="server" Type="Date" ControlToValidate="DataInicioTextBox" MaximumValue="01-01-2100"  MinimumValue="01-01-1900"  ToolTip="" SetFocusOnError="true">&otimes;</asp:RangeValidator>
                                    </td>
                                </tr>
                             </table>
                                  </div>

                               <h3>Proponente / Condutor Habitual</h3>
                              <div>
                            <table border="0" cellpadding="0" cellspacing="0"   style="width:100%;border-collapse:collapse;font-size: 13px;">
                                 <tr>
                                    <td style="width:120px">Data de Nascimento: <img alt="" style="vertical-align:middle" src="img/yes.png" /></td>
                                    <td>
                                        <asp:TextBox ID="DataNascimentoTextBox" Text='<%#Bind("DataNascimento") %>'  runat="server"  Width="75" MaxLength="10"  /><img alt="Data de Nascimento" src="images/31.png" style="vertical-align:text-bottom" />
                                        &nbsp;<asp:RequiredFieldValidator ID="ReqValDataNascimentoTextBox" ValidationGroup="Form" Display="Dynamic" runat="server" Text="*" ControlToValidate="DataNascimentoTextBox"  ToolTip="" SetFocusOnError="true">&otimes;</asp:RequiredFieldValidator>
                   
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width:150px" >Qualidade do Tomador:</td>
                                    <td>
                                            <asp:DropDownList Width="200" runat="server" ID="QualidadeComboBox" >
                                                <asp:ListItem Value="1" Text="Proprietário"></asp:ListItem>
                                                <asp:ListItem Value="2" Text="Credor hipotecário / Locatário"></asp:ListItem>
                                                <asp:ListItem Value="3" Text="Outra"></asp:ListItem>
                                                <asp:ListItem Value="4" Text="Usufrutuário"></asp:ListItem>
                                            </asp:DropDownList>
                                    </td>
                                </tr>
                                 <tr>
                                    <td style="width:120px">Data da Carta Cond.: <img alt="" style="vertical-align:middle" src="img/yes.png" /></td>
                                    <td>
                                        <asp:TextBox ID="DataCartaTextBox" Text='<%#Bind("CartaConducaoData") %>'  runat="server"  Width="75" MaxLength="10"  /><img alt="Data da Carta Conduçaõ" src="images/31.png" style="vertical-align:text-bottom" />
                                        &nbsp;<asp:RequiredFieldValidator ID="ReqValDataCartaTextBox" ValidationGroup="Form" Display="Dynamic" runat="server" Text="*" ControlToValidate="DataCartaTextBox"  ToolTip="" SetFocusOnError="true">&otimes;</asp:RequiredFieldValidator>



                                    </td>
                                </tr>
                            </table>
                            </div>
                               
                              <h3>Dados do Veículo</h3>
                              
                              <div>
                                  <asp:UpdatePanel ID="UpdatePanel1" runat="server"  updatemode="Conditional" > 
                              <ContentTemplate>
                                <table border="0" cellpadding="0" cellspacing="0"   style="width:100%;border-collapse:collapse;font-size: 13px;">
                                    <tr>
                                        <td style="width:120px">Matrícula:  <img alt="" style="vertical-align:middle" src="img/yes.png" /></td>
                                        <td>
                                             <asp:TextBox ID="MatriculaTextBox" Text='<%#Bind("Matricula") %>'  runat="server"  Width="95" MaxLength="12"  />
                                            &nbsp;<asp:RequiredFieldValidator ID="ReqValMatriculaTextBox" ValidationGroup="Form" Display="Dynamic" runat="server"  ControlToValidate="MatriculaTextBox" ToolTip="" SetFocusOnError="true">&otimes;</asp:RequiredFieldValidator><asp:RegularExpressionValidator runat="server" EnableClientScript="true" ControlToValidate="MatriculaTextBox"  ValidationGroup="Form" Display="Dynamic" ValidationExpression="([A-Z]{2}-[0-9]{2}-[0-9]{2}-[A-Z]{2})|([A-Z]{3}-[0-9]{2}-[0-9]{2}-[A-Z]{2})">&otimes;</asp:RegularExpressionValidator>  &nbsp;(Ex:LD-00-00-AA ou LBB-00-00-XX)

                                        </td>
                                    </tr>
                                   
                                    <tr>
                                        <td style="width:120px" >Marca:  <img alt="" style="vertical-align:middle" src="img/yes.png" /></td>
                                        <td>
                                                <asp:DropDownList Width="200" runat="server" ID="MarcaComboBox" AppendDataBoundItems="true" DataSourceID="MarcaDatasource" DataTextField="Descricao" DataValueField="MarcaID" OnSelectedIndexChanged="MarcaComboBox_SelectedIndexChanged" AutoPostBack="true"  >
                                                    <asp:ListItem Value="" Text="Seleccione um opção"></asp:ListItem>
                                                </asp:DropDownList>
                                            &nbsp;<asp:RequiredFieldValidator ID="ReqValMarcaComboBox" ValidationGroup="Form" Display="Dynamic" runat="server" ControlToValidate="MarcaComboBox"  ToolTip="" SetFocusOnError="true">&otimes;</asp:RequiredFieldValidator>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width:120px" >Modelo: <img alt="" style="vertical-align:middle" src="img/yes.png" /></td>
                                        <td>
                                                <asp:DropDownList Width="200" runat="server" ID="ModeloComboBox" AppendDataBoundItems="true" DataSourceID="ModeloDatasource" DataTextField="Descricao" DataValueField="ModeloID" >
                                                   <asp:ListItem Value="" Text="Seleccione um opção"></asp:ListItem>
                                                </asp:DropDownList>
                                                &nbsp;<asp:RequiredFieldValidator ID="ReqValModeloComboBox" ValidationGroup="Form" Display="Dynamic" runat="server" ControlToValidate="ModeloComboBox" ToolTip="" SetFocusOnError="true">&otimes;</asp:RequiredFieldValidator>

                                        </td>
                                    </tr> 
                                   
                                     <tr>
                                        <td style="width:120px" >Data de Fabrico: <img alt="" style="vertical-align:middle" src="img/yes.png" /></td>
                                        <td>
                                             <asp:TextBox ID="DataFabricoTextBox" runat="server"  Text='<%#Bind("DataFabrico") %>' Width="75" MaxLength="10" /><img alt="Data de Fabrico" src="images/31.png" style="vertical-align:text-bottom" />&nbsp;
                                            &nbsp;<asp:RequiredFieldValidator ID="ReqValDataFabricoTextBox" ValidationGroup="Form" Display="Dynamic" runat="server" Text="*" ControlToValidate="DataFabricoTextBox" ToolTip="" SetFocusOnError="true">&otimes;</asp:RequiredFieldValidator>
                                        </td>
                                    </tr>
                                     <tr>
                                        <td>Cilindrada: <img alt="" style="vertical-align:middle" src="img/yes.png" /></td>
                                        <td>
                                            <asp:TextBox ID="CilindradaTextBox" Text='<%#Bind("Cilindrada") %>'  runat="server"  Width="50" MaxLength="4" />
                                            &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator2" ValidationGroup="Form" Display="Dynamic" runat="server" Text="*" ControlToValidate="CilindradaTextBox"  ToolTip="" SetFocusOnError="true">&otimes;</asp:RequiredFieldValidator>
                                            <asp:RangeValidator MaximumValue="10000" MinimumValue="0" ControlToValidate="CilindradaTextBox" ID="RangeValCilindradaTextBox" runat="server" Type="Integer">&otimes;</asp:RangeValidator>
                
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width:120px">Nº Chassi:</td>
                                        <td>
                                             <asp:TextBox ID="ChassiTextBox" Text='<%#Bind("Chassi") %>'  runat="server"  Width="195" MaxLength="30" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Nº de Lugares: <img alt="" style="vertical-align:middle" src="img/yes.png" /></td>
                                        <td>
                                            <asp:TextBox ID="LugaresTextBox" Text='<%#Bind("Lugares") %>'  runat="server"  Width="30" MaxLength="2" />
                                            &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator3" ValidationGroup="Form" Display="Dynamic" runat="server" Text="*" ControlToValidate="LugaresTextBox"  ToolTip="" SetFocusOnError="true">&otimes;</asp:RequiredFieldValidator>
                                            <asp:RangeValidator MaximumValue="60" MinimumValue="0" ControlToValidate="LugaresTextBox" ID="RageValLugaresTextBox" runat="server" Type="Integer">&otimes;</asp:RangeValidator>
                
                                        </td>
                                    </tr>

                                    <tr>
                                    <td style="width:150px">Uso:</td>
                                    <td>
                                            <asp:DropDownList Width="200" runat="server" ID="UsoComboBox" >
                                                <asp:ListItem Value="1" Text="Particular"></asp:ListItem>
                                                <asp:ListItem Value="2" Text="Aluguer"></asp:ListItem>
                                                <asp:ListItem Value="3" Text="Serviço Táxi"></asp:ListItem>
                                            </asp:DropDownList>
                                    </td>
                                </tr>
                                    <tr>
                                        <td>"Q" Cliente RC:</td>
                                        <td>
                                            <asp:TextBox ID="ClienteRCTextBox" Text='<%#Bind("RCCliente") %>'  runat="server"  Width="30" MaxLength="4" Style="text-align:center" />
                                           
                                            <asp:RangeValidator MaximumValue="100" MinimumValue="0" ControlToValidate="ClienteDPTextBox" ID="RngValClienteRCTextBox" runat="server" Type="Double">&otimes;</asp:RangeValidator>
                
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>"Q" Cliente DP:</td>
                                        <td>
                                            <asp:TextBox ID="ClienteDPTextBox" Text='<%#Bind("DPCliente") %>'  runat="server"  Width="30" MaxLength="4"  Style="text-align:center" />
                                           
                                            <asp:RangeValidator MaximumValue="100" MinimumValue="0" ControlToValidate="ClienteDPTextBox" ID="RngValClienteDPTextBox" runat="server" Type="Double">&otimes;</asp:RangeValidator>
                
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width:120px;">Categoria:</td>
                                        <td>
                                            <asp:DropDownList runat="server" ID="CategoriaComboBox" DataSourceID="SqlDataSourceCategoria"   OnDataBound="CategoriaComboBox_DataBound" DataTextField="Descricao" DataValueField="CategoriaID" OnSelectedIndexChanged="CategoriaComboBox_SelectedIndexChanged" AutoPostBack="true" >
                                            <asp:ListItem Value="" Text="Seleccione um opção"></asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width:120px;">Tipo:</td>
                                        <td>
                                            <asp:DropDownList runat="server" ID="TipoCategoriaComboBox" DataSourceID="SqlDataSourceTipoCategoria"  DataTextField="Descricao" DataValueField="Codigo">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                </table>
                                </ContentTemplate>
                              </asp:UpdatePanel>
                              </div>
                             
                             
                              <h3>Ocupantes</h3>
                              <div>
                                 <asp:UpdatePanel ID="UpdatePanel2" runat="server"  updatemode="Conditional" > 
                                 <ContentTemplate>
                                 <table border="0" cellpadding="0" cellspacing="0"   style="width:100%;border-collapse:collapse;font-size: 13px;">
                                <tr>
                                    <td style="width:25%;vertical-align: top;">
                                        <table border="0" cellpadding="0" cellspacing="0"   style="width:100%;border-collapse:collapse;font-size: 13px;">
                                            <tr>
                                                <td style="width:120px" >Opção:</td>
                                                <td>
                                                    <asp:DropDownList Width="200" runat="server" ID="OpcaoOcupantesComboBox" AppendDataBoundItems="true" DataSourceID="SqlDataSourceOpcaoOcupantes" DataTextField="Descricao" DataValueField="OpcaoOcupantesID" AutoPostBack="true" OnSelectedIndexChanged="OpcaoOcupantesComboBox_SelectedIndexChanged" >
                                                       <asp:ListItem Value="" Text="Seleccione um opção"></asp:ListItem>
                                                    </asp:DropDownList>
                                                    

                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td style="width:50%">
                                        <table border="0" cellpadding="0" cellspacing="0"   style="width:100%;border-collapse:collapse;font-size: 13px;">
                                            <tr>
                                                <td style="width:50px" ><asp:TextBox ID="MIPDescTextBox" runat="server"  ReadOnly="true" Width="40" MaxLength="10" /></td>
                                                <td>
                                                        <asp:TextBox ID="MIPValorTextBox" runat="server"  ReadOnly="true" Width="95" MaxLength="10" />
                                                </td>
                                            </tr>
                                             <tr>
                                                <td style="width:50px"><asp:TextBox ID="DTDescTextBox" runat="server"  ReadOnly="true" Width="40" MaxLength="10" /></td>
                                                <td>
                                                        <asp:TextBox ID="DTValorTextBox" runat="server" ReadOnly="true" Width="95" MaxLength="10"  />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width:50px"><asp:TextBox ID="DFDescTextBox" runat="server"  ReadOnly="true" Width="40" MaxLength="10" /></td>
                                                <td>
                                                        <asp:TextBox ID="DFValorTextBox" runat="server"  ReadOnly="true" Width="95" MaxLength="10"  />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                                 </ContentTemplate>
                                 <Triggers>
                                 <asp:AsyncPostBackTrigger ControlID="CategoriaComboBox" EventName="SelectedIndexChanged" />
                                 </Triggers>
                              </asp:UpdatePanel>
                              </div>

                               <h3>Danos Próprios</h3>
                              <div>
                                   <asp:UpdatePanel ID="UpdatePanel3" runat="server"  updatemode="Conditional" > 
                                 <ContentTemplate>
                                  <table border="0" cellpadding="0" cellspacing="0"   style="width:100%;border-collapse:collapse;font-size: 13px;">
                                    <tr>
                                        <td style="width:120px">Valor em Novo: </td>
                                        <td>
                                             <asp:TextBox ID="ValorNovoTextBox" Text='<%#Bind("ValorNovo") %>'  runat="server"  Width="95" MaxLength="10"  />&nbsp;<asp:RangeValidator ID="rngValValorNovoTextBox" ValidationGroup="Form" Display="Dynamic" runat="server" ControlToValidate="ValorNovoTextBox" ToolTip="" SetFocusOnError="true" Type="Double" MinimumValue="0" MaximumValue="50000000">&otimes;</asp:RangeValidator>

                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width:120px" >Valor a Segurar: </td>
                                        <td>
                                                <asp:TextBox ID="ValorSegurarTextBox" Text='<%#Bind("ValorSegurar") %>'  runat="server"  Width="95" MaxLength="10"  />&nbsp;<asp:RangeValidator ID="rngValValorSegurarTextBox" ValidationGroup="Form" Display="Dynamic" runat="server" ControlToValidate="ValorSegurarTextBox" ToolTip="" SetFocusOnError="true" Type="Double" MinimumValue="0" MaximumValue="50000000">&otimes;</asp:RangeValidator>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width:120px" >Franquia:</td>
                                        <td>

                                      <asp:TextBox ID="FranquiaTextBox" Text='<%#Bind("Franquia") %>'  runat="server"  Width="35" MaxLength="5"  />%
                                            <asp:RangeValidator ID="rngValFranquiaTextBox" ValidationGroup="Form" Display="Dynamic" runat="server"  ControlToValidate="FranquiaTextBox" ToolTip="" SetFocusOnError="true" Type="Double" MinimumValue="0" MaximumValue="100">&otimes;</asp:RangeValidator>

                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <br />
                                            <i>Esclareça o cliente sobre a diferença entre o valor em novo e valor a segurar.</i>
                                        </td>

                                    </tr>


                                    </table>
                                  </ContentTemplate>
                                 <Triggers>
                                 <asp:AsyncPostBackTrigger ControlID="CategoriaComboBox" EventName="SelectedIndexChanged" />
                                 </Triggers>
                              </asp:UpdatePanel>
                              </div>

                              <h3>Duração / Cobrança / Tipo de Seguro</h3>
                              <div>
                                <table border="0" cellpadding="0" cellspacing="0"   style="width:100%;border-collapse:collapse;font-size: 13px;">
                                    <tr>
                                        <td style="width:120px">Tipo de Seguro:</td>
                                        <td>
                                            <asp:DropDownList runat="server" ID="TipoSeguroComboBox" >
                                                <asp:ListItem Text="Base" Value="1"></asp:ListItem>
                                                <asp:ListItem Text="Responsável" Value="2"></asp:ListItem>
                                                <asp:ListItem Text="Tranquilo" Value="3"></asp:ListItem>
                                                <asp:ListItem Text="Inteligente" Value="4"></asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width:120px">Fraccionamento:</td>
                                        <td>
                                            <asp:DropDownList Width="104px"  runat="server" ID="CobrancaFraccionamentoComboBox"  DataSourceID="ParcelamentoDatasource" DataTextField="Descricao" DataValueField="ConfigKey" >
                                            
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                </table>
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
           
            <asp:Button ID="SimularSemGravar" ValidationGroup="Form" CssClass="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" runat="server" Text="1.Simular" OnClientClick="SetValidatorsSimulacao(false);" OnClick="SimularButton_Click" CausesValidation ="True"  />
            <asp:Button ID="PropostaButton" ValidationGroup="Form" CssClass="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" runat="server" Text="2.Proposta" CommandName="Update" CausesValidation ="True" OnClientClick="SetValidatorsSimulacao(true);" OnClick="Proposta_Click"  />
            <asp:Button ID="ConverterButton" CssClass="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" runat="server" ValidationGroup="Apolice" Text="3.Aviso de Cobrança"  Visible="true" OnClick="ConverterButton_Click" /><br />
            
            <asp:ValidationSummary ValidationGroup="Form" runat="server" ShowSummary="true" ID="ValSummary" DisplayMode="List" />
            <asp:CustomValidator ID="cstConverterApolice" Text="" Display="Dynamic"   ValidationGroup="Apolice" runat="server" OnServerValidate="cstConverterApolice_ServerValidate" ></asp:CustomValidator> 
        </EditItemTemplate>

       
    </asp:FormView>

    
            
    <div id="dialog-ArtigoErroGravar" title="Master Seguros" style="display: none">
        <br />
        <b>Ocorreu um erro a gravar os dados.<br />Comunique ao administrador de sistemas.</b>
    </div>      
     <div id="dialog-EmptyQueryString" title="Master Seguros" style="display: none">
        <br />
        <b>Não é possível visualisar a página solicitada.<br />Comunique ao administrador de sistemas.</b>
    </div> 

    
    <div id="dialog-EmptyConverterApolice" title="Master Seguros" style="display: none">
        <br />Para gerar o aviso de cobrança deve primeiro seleccionar a opção 'Proposta'.
    </div>
    <div id="dialog-ResultadoConverterApolice" title="Master Seguros" style="display: none">
        <br />O aviso de cobrança foi criado com sucesso.<br />Para visualizar o documento clique em "OK".<br />
        Número de Apólice:&nbsp;<input type="text" style="border-color:white;width:150px;text-align: right;" id="Apolice" readonly="readonly" /><br />
        Número de Cliente:&nbsp;<input type="text" style="border-color:white;width:150px;text-align: right;" id="Cliente" readonly="readonly" /><br />
        Aviso de Cobrança:&nbsp;<input type="text" style="border-color:white;width:150px;text-align: right;" id="AvisoCobranca" readonly="readonly" /><br />
    </div>
    
    <div id="dialog-SimulacaoSucesso" title="Master Seguros" style="display: none">
        <br />
        <b>Detalhe da simulação.</b>
        <p id="hidden-input"></p>
        <table border="0" cellpadding="0" cellspacing="10"   style="width:100%;border-collapse:collapse;font-size: 13px;" >
            <tr>
                <td style="width:170px">PRÉMIO PURO:</td>
                <td>
                    <input type="text" style="border-color:white;width:80px;text-align: right;" id="PremioPuro" readonly="readonly" />
                </td>
            </tr>
            <tr>
                <td style="width:120px">PRÉMIO COMERCIAL:</td>
                <td>
                    <input type="text" style="border-color:white;width:80px;text-align: right;" id="PremioComercial" readonly="readonly" />

                </td>
            </tr>
            <tr>
                    <td style="width:120px">ENCARGOS:</td>
                    <td>
                            <input type="text" style="border-color:white;width:80px;text-align: right;"  id="Encargos" readonly="readonly" />
                    </td>
            </tr>
            <tr>
                    <td style="width:120px">ENCARGOS PARCEL.:</td>
                    <td>
                            <input type="text" style="border-color:white;width:80px;text-align: right;"  id="EncargosParcelamento" readonly="readonly" />
                    </td>
                </tr>
            <tr>
                    <td style="width:120px">IMPOSTO SELO:</td>
                    <td>
                        <input type="text" style="border-color:white;width:80px;text-align: right;"  id="ImpostoSelo" readonly="readonly" />
                    </td>
                </tr>
            <tr>
                    <td style="width:120px"><b>TOTAL:</b></td>
                    <td>
                            <input type="text" style="border-color:white;width:80px;text-align: right;" id="PremioTotal" readonly="readonly" />
                    </td>
                </tr>
        </table>
    </div>

   <asp:SqlDataSource ID="SqlDataSourceClassificador"   OnInserted="On_Inserted" OnUpdated="On_Updated" OnUpdating="On_Updating" runat="server"
        ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"
        DeleteCommand="DELETE FROM [CTT_classificador] WHERE [ClassificadorID] = @ClassificadorID AND [Lingua]=@Lingua"
        InsertCommand="INSERT INTO [CTT_classificador] ([ClassificadorID], [ClassificadorPaiID], [Nome], [Descricao], [Ordem], [Estado], [Lingua], [Media], [UrlTemplate], [Tipo], [NivelInteresseID]) VALUES (@ClassificadorID,@ClassificadorPaiID, @Nome, @Descricao, @Ordem, @Estado, @Lingua, @Media, @UrlTemplate, @Tipo, @NivelInteresseID)"
        SelectCommand="SELECT * FROM [CTT_classificador] WHERE [ClassificadorID]=@ClassificadorID AND [Lingua]=@Lingua"
        UpdateCommand="UPDATE [CTT_classificador] SET [ClassificadorPaiID]=@ClassificadorPaiID, [Nome]=@Nome, [Descricao]=@Descricao, [Ordem]=@Ordem, [Estado]=@Estado, [Lingua]=@Lingua, [Media]=@Media, [UrlTemplate]=@UrlTemplate, [Tipo]=@Tipo, [NivelInteresseID]=@NivelInteresseID WHERE [ClassificadorId] = @ClassificadorId AND [Lingua]=@Lingua">
        <DeleteParameters>
            <asp:Parameter Name="ClassificadorID" Type="Int32" />
            <asp:Parameter Name="Lingua" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="ClassificadorID" Type="Int32" />
            <asp:Parameter Name="ClassificadorPai" Type="Int32" ConvertEmptyStringToNull="false" />
            <asp:Parameter Name="Nome" Type="String" />
            <asp:Parameter Name="Descricao" Type="String" />
            <asp:Parameter Name="Media" Type="String" />
            <asp:Parameter Name="UrlTemplate" Type="String" ConvertEmptyStringToNull="true" />
            <asp:ControlParameter ControlID="ctl00$MainContent$FormView1$TipoComboBox" PropertyName="SelectedValue" Name="Tipo"  Type="Int32" DefaultValue="0" />
            <asp:ControlParameter ControlID="ctl00$MainContent$FormView1$LinguaComboBox" PropertyName="SelectedValue" Name="Lingua"  Type="Int32" DefaultValue="0" />
            <asp:ControlParameter ControlID="ctl00$MainContent$FormView1$NivelInteresseIDComboBox" PropertyName="SelectedValue" Name="NivelInteresseID"  Type="Int32" DefaultValue="0" />
            <asp:ControlParameter ControlID="ctl00$MainContent$FormView1$EstadoComboBox" PropertyName="SelectedValue" Name="Estado"  Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="Ordem" Type="Int32" DefaultValue="0" />    
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="ClassificadorPai" Type="Int32" ConvertEmptyStringToNull="false" />
            <asp:Parameter Name="Nome" Type="String" />
            <asp:Parameter Name="Descricao" Type="String" />
            <asp:Parameter Name="Media" Type="String" />
            <asp:Parameter Name="UrlTemplate" Type="String" ConvertEmptyStringToNull="true" />
            <asp:ControlParameter ControlID="ctl00$MainContent$FormView1$TipoComboBox" PropertyName="SelectedValue" Name="Tipo"  Type="Int32" DefaultValue="0" />
            <asp:ControlParameter ControlID="ctl00$MainContent$FormView1$LinguaComboBox" PropertyName="SelectedValue" Name="Lingua"  Type="Int32" DefaultValue="0" />
            <asp:ControlParameter ControlID="ctl00$MainContent$FormView1$NivelInteresseIDComboBox" PropertyName="SelectedValue" Name="NivelInteresseID"  Type="Int32" DefaultValue="0" />
            <asp:ControlParameter ControlID="ctl00$MainContent$FormView1$EstadoComboBox" PropertyName="SelectedValue" Name="Estado"  Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="Ordem" Type="Int32" DefaultValue="0" />    
        </UpdateParameters>
       <SelectParameters>
           <asp:Parameter Name="ClassificadorID" Type="Int32" />
           <asp:Parameter Name="Lingua" Type="Int32" />
       </SelectParameters>
        

    </asp:SqlDataSource>

   <asp:SqlDataSource ID="SqlDataSourcePropostaAuto"   OnInserted="On_Inserted" OnUpdated="On_Updated"  OnInserting ="SqlDataSourcePropostaAuto_Inserting" OnUpdating="On_Updating" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" 
        DeleteCommand="DELETE FROM [master_proposta_auto] WHERE [PropostaID] = @PropostaID" 
        InsertCommand="INSERT INTO [master_proposta_auto] ([NumeroProposta], [BrokerID], [QualidadeTomadorID], [DataInicio], [Matricula], [MarcaID], [ModeloID], [DataFabrico], [Cilindrada], [Chassi], [Lugares], [UsoID], [RCCliente], [DPCliente], [CategoriaID], [TipoCategoriaID], [OcupantesOpcaoID], [ValorNovo], [ValorSegurar], [Franquia], [TipoSeguroID], [Fraccionamento], [Nome], [Morada], [ProvinciaID], [Telemovel], [Email], [BI], [Passaporte], [DataNascimento], [CartaConducaoNumero], [CartaConducaoData], [UserIDCriacao], [DataCriacao]) VALUES (@NumeroProposta, @BrokerID,@QualidadeTomadorID, @DataInicio , @Matricula ,@MarcaID,@ModeloID,@DataFabrico,@Cilindrada, @Chassi, @Lugares, @UsoID,@RCCliente,@DPCliente,@CategoriaID,@TipoCategoriaID,@OcupantesOpcaoID,@ValorNovo,@ValorSegurar,@Franquia,@TipoSeguroID,@Fraccionamento,@Nome,@Morada,@ProvinciaID,@Telemovel,@Email,@BI,@Passaporte,@DataNascimento,@CartaConducaoNumero,@CartaConducaoData,  @UserIDCriacao, @DataCriacao); SELECT @PropostaID = SCOPE_IDENTITY()" 
        SelectCommand="SELECT * FROM [master_proposta_auto] WHERE [PropostaID] = @PropostaID"  
        UpdateCommand="UPDATE [master_proposta_auto] SET [BrokerID] = @BrokerID ,[QualidadeTomadorID] = @QualidadeTomadorID ,  [DataInicio] = @DataInicio, [Matricula] = @Matricula, [MarcaID] = @MarcaID ,[ModeloID] = @ModeloID ,[DataFabrico] = @DataFabrico ,[Cilindrada] = @Cilindrada ,[Chassi] = @Chassi, [Lugares]=@Lugares, [UsoID] = @UsoID, [RCCliente] = @RCCliente,[DPCliente] = @DPCliente, [CategoriaID] = @CategoriaID, [TipoCategoriaID] = @TipoCategoriaID, [OcupantesOpcaoID] = @OcupantesOpcaoID, [ValorNovo] = @ValorNovo, [ValorSegurar] = @ValorSegurar,[Franquia] = @Franquia, [TipoSeguroID] = @TipoSeguroID, [Fraccionamento] = @Fraccionamento, [Nome] = @Nome,[Morada] = @Morada, [ProvinciaID] = @ProvinciaID, [Telemovel] = @Telemovel, [Email] = @Email, [BI] = @BI, [Passaporte] = @Passaporte, [DataNascimento] = @DataNascimento, [CartaConducaoNumero] = @CartaConducaoNumero,[CartaConducaoData] = @CartaConducaoData, [UserIDActualizacao] = @UserIDActualizacao, [DataActualizacao] = @DataActualizacao WHERE PropostaID = @PropostaID">
        <InsertParameters>
            <asp:Parameter Name="PropostaID" Direction="Output" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="NumeroProposta" Type="String" DefaultValue="0" />
            <asp:ControlParameter ControlID="ctl00$MainContent$FormView1$BrokerComboBox" PropertyName="SelectedValue" Name="BrokerID"  Type="Int32" />
            <asp:ControlParameter ControlID="ctl00$MainContent$FormView1$QualidadeComboBox" PropertyName="SelectedValue" Name="QualidadeTomadorID"  Type="Int32" />
             <asp:Parameter Name="DataInicio" Type="DateTime" />
            <asp:Parameter Name="Matricula" Type="String" />
            <asp:ControlParameter ControlID="ctl00$MainContent$FormView1$MarcaComboBox" PropertyName="SelectedValue" Name="MarcaID"  Type="Int32" />
            <asp:ControlParameter ControlID="ctl00$MainContent$FormView1$ModeloComboBox" PropertyName="SelectedValue" Name="ModeloID"  Type="Int32" />
            <asp:Parameter Name="DataFabrico" Type="DateTime" />
            <asp:Parameter Name="Cilindrada" Type="Int32" />
            <asp:Parameter Name="Chassi" Type="String" />
            <asp:Parameter Name="Lugares" Type="String" />
            <asp:ControlParameter ControlID="ctl00$MainContent$FormView1$UsoComboBox" PropertyName="SelectedValue" Name="UsoID"  Type="Int32" />
            <asp:Parameter Name="RCCliente" Type="Int32"  DefaultValue="0"/>
            <asp:Parameter Name="DPCliente" Type="Int32" DefaultValue="0"/>
            <asp:ControlParameter ControlID="ctl00$MainContent$FormView1$CategoriaComboBox" PropertyName="SelectedValue" Name="CategoriaID"  Type="Int32" />
            <asp:ControlParameter ControlID="ctl00$MainContent$FormView1$TipoCategoriaComboBox" PropertyName="SelectedValue" Name="TipoCategoriaID"  Type="String" />
            <asp:ControlParameter ControlID="ctl00$MainContent$FormView1$OpcaoOcupantesComboBox" PropertyName="SelectedValue" Name="OcupantesOpcaoID"  Type="Int32" />
            <asp:Parameter Name="ValorNovo" Type="Int32" />
            <asp:Parameter Name="ValorSegurar" Type="Int32" />
            <asp:Parameter Name="Franquia" Type="Decimal" />
            <asp:ControlParameter ControlID="ctl00$MainContent$FormView1$TipoSeguroComboBox" PropertyName="SelectedValue" Name="TipoSeguroID"  Type="Int32" />
            <asp:ControlParameter ControlID="ctl00$MainContent$FormView1$CobrancaFraccionamentoComboBox" PropertyName="SelectedValue" Name="Fraccionamento"  Type="String" />

            <asp:Parameter Name="Nome" Type="String" />
            <asp:Parameter Name="Morada" Type="String" />
            <asp:ControlParameter ControlID="ctl00$MainContent$FormView1$ProvinciaIDComboBox" PropertyName="SelectedValue" Name="ProvinciaID"  Type="Int32" />
            <asp:Parameter Name="Telemovel" Type="String" />
            <asp:Parameter Name="Email" Type="String" />
            <asp:Parameter Name="BI" Type="String" />
            <asp:Parameter Name="Passaporte" Type="String" />
            <asp:Parameter Name="DataNascimento" Type="DateTime" />
            <asp:Parameter Name="CartaConducaoNumero" Type="String" />
            <asp:Parameter Name="CartaConducaoData" Type="DateTime" />
            <asp:Parameter Name="UserIDCriacao" Type="String" />
            <asp:Parameter Name="DataCriacao" Type="DateTime" />
        </InsertParameters>
        <UpdateParameters>
            <asp:ControlParameter ControlID="ctl00$MainContent$FormView1$BrokerComboBox" PropertyName="SelectedValue" Name="BrokerID"  Type="Int32" />
            <asp:ControlParameter ControlID="ctl00$MainContent$FormView1$QualidadeComboBox" PropertyName="SelectedValue" Name="QualidadeTomadorID"  Type="Int32" />
            <asp:Parameter Name="DataInicio" Type="DateTime" />
            <asp:Parameter Name="Matricula" Type="String" />
            <asp:ControlParameter ControlID="ctl00$MainContent$FormView1$MarcaComboBox" PropertyName="SelectedValue" Name="MarcaID"  Type="Int32" />
            <asp:ControlParameter ControlID="ctl00$MainContent$FormView1$ModeloComboBox" PropertyName="SelectedValue" Name="ModeloID"  Type="Int32" />
            <asp:Parameter Name="DataFabrico" Type="DateTime" />
            <asp:Parameter Name="Cilindrada" Type="Int32" />
            <asp:Parameter Name="Chassi" Type="String" />
            <asp:ControlParameter ControlID="ctl00$MainContent$FormView1$UsoComboBox" PropertyName="SelectedValue" Name="UsoID"  Type="Int32" />
            <asp:Parameter Name="RCCliente" Type="Int32"  DefaultValue="0"/>
            <asp:Parameter Name="DPCliente" Type="Int32" DefaultValue="0"/>
            <asp:ControlParameter ControlID="ctl00$MainContent$FormView1$CategoriaComboBox" PropertyName="SelectedValue" Name="CategoriaID"  Type="Int32" />
            <asp:ControlParameter ControlID="ctl00$MainContent$FormView1$TipoCategoriaComboBox" PropertyName="SelectedValue" Name="TipoCategoriaID"  Type="String" />
            <asp:ControlParameter ControlID="ctl00$MainContent$FormView1$OpcaoOcupantesComboBox" PropertyName="SelectedValue" Name="OcupantesOpcaoID"  Type="Int32" />
            <asp:Parameter Name="ValorNovo" Type="Int32" />
            <asp:Parameter Name="ValorSegurar" Type="Int32" />
            <asp:Parameter Name="Franquia" Type="Decimal" />
            <asp:ControlParameter ControlID="ctl00$MainContent$FormView1$TipoSeguroComboBox" PropertyName="SelectedValue" Name="TipoSeguroID"  Type="Int32" />
            <asp:ControlParameter ControlID="ctl00$MainContent$FormView1$CobrancaFraccionamentoComboBox" PropertyName="SelectedValue" Name="Fraccionamento"  Type="String" />

            <asp:Parameter Name="Nome" Type="String" />
            <asp:Parameter Name="Morada" Type="String" />
            <asp:ControlParameter ControlID="ctl00$MainContent$FormView1$ProvinciaIDComboBox" PropertyName="SelectedValue" Name="ProvinciaID"  Type="Int32" />
            <asp:Parameter Name="Telemovel" Type="String" />
            <asp:Parameter Name="Email" Type="String" />
            <asp:Parameter Name="BI" Type="String" />
            <asp:Parameter Name="Passaporte" Type="String" />
            <asp:Parameter Name="DataNascimento" Type="DateTime" />
            <asp:Parameter Name="CartaConducaoNumero" Type="String" />
            <asp:Parameter Name="CartaConducaoData" Type="DateTime" />
            <asp:Parameter Name="UserIDActualizacao" Type="String" />
            <asp:Parameter Name="DataActualizacao" Type="DateTime" />
        </UpdateParameters>
        <SelectParameters>
           <asp:Parameter Name="PropostaID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

   <asp:SqlDataSource ID="SqlDataSourceCategoria" runat="server"
        ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"
        SelectCommand="SELECT [CategoriaID], [Descricao], [Valor], [Ocupantes], [DanosProprios] FROM [master_categoria]"></asp:SqlDataSource>

   <asp:SqlDataSource ID="SqlDataSourceTipoCategoria" runat="server"
        ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"
        SelectCommand="SELECT * FROM [master_tipo_categoria] WHERE CategoriaID=@CategoriaID">
         <SelectParameters>
            <asp:ControlParameter ControlID="ctl00$MainContent$FormView1$CategoriaComboBox" PropertyName="SelectedValue"
                                  Name="CategoriaID" Type="Int32" DefaultValue="0" />
          </SelectParameters>

    </asp:SqlDataSource>

     <asp:SqlDataSource ID="SqlDataSource1" runat="server"
        ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"
        SelectCommand="SELECT  ConfigKey, Descricao FROM master_configuracao WHERE ConfigType= 'PARCELA_PAGAMENTO'">
    </asp:SqlDataSource>

   
      <asp:SqlDataSource ID="SqlDataSourceOpcaoOcupantes" runat="server"
        ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"
        SelectCommand="SELECT * FROM [master_opcao_ocupantes]"></asp:SqlDataSource>

   <asp:SqlDataSource ID="SqlDataSourceTipoVeiculo" runat="server"
        ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"
        SelectCommand="SELECT * FROM [master_tipo_veiculo] WHERE Estado=1"></asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceProvincia" runat="server"
        ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"
        SelectCommand="SELECT * FROM [master_provincia] ORDER BY NOME "></asp:SqlDataSource>

   <asp:SqlDataSource ID="MarcaDatasource" runat="server"
        ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"
        SelectCommand="SELECT * FROM [master_marca_veiculo] WHERE Estado=1"></asp:SqlDataSource>

   <asp:SqlDataSource ID="ModeloDatasource" runat="server"
        ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"
        SelectCommand="SELECT * FROM [master_modelo_veiculo] WHERE  MarcaID=@MarcaID AND Estado=1">
        <SelectParameters>
            <asp:ControlParameter ControlID="ctl00$MainContent$FormView1$MarcaComboBox" PropertyName="SelectedValue"
                                  Name="MarcaID" Type="Int32" DefaultValue="0" />
          </SelectParameters>
    </asp:SqlDataSource>
   

    
   <asp:SqlDataSource ID="ParcelamentoDatasource" runat="server"
        ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"
        SelectCommand="SELECT  ConfigKey, Descricao FROM master_configuracao WHERE ConfigType= 'PARCELA_PAGAMENTO'">
    </asp:SqlDataSource>

   <asp:SqlDataSource ID="CorDatasource" runat="server"
        ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"
        SelectCommand="SELECT * FROM [master_cor]"></asp:SqlDataSource>

   <asp:SqlDataSource ID="BancoDatasource" runat="server"
        ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"
        SelectCommand="SELECT * FROM [master_banco]"></asp:SqlDataSource>

   <script type="text/javascript">

       $(function () {
           $("input").checkboxradio({
               icon: false
           });
       });

       SetInitialize();

   
       function SetValidatorsSimulacao(bVal)
       {
          //Desabilitar/habilitar validators
           document.getElementById("ctl00_MainContent_FormView1_ReqValMoradaTextbox").enabled = bVal;
           document.getElementById("ctl00_MainContent_FormView1_ReqValDataInicioTextBox").enabled = bVal;
           return true;
       }

      

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

           
      
           $("#ctl00_MainContent_FormView1_DataFabricoTextBox").datepicker();
           $("#ctl00_MainContent_FormView1_DataFabricoTextBox").datepicker("option", "dateFormat", "dd/mm/yy");

           $("#ctl00_MainContent_FormView1_DataInicioTextBox").datepicker();
           $("#ctl00_MainContent_FormView1_DataInicioTextBox").datepicker("option", "dateFormat", "dd/mm/yy");

           $("#ctl00_MainContent_FormView1_DataNascimentoTextBox").datepicker();
           $("#ctl00_MainContent_FormView1_DataNascimentoTextBox").datepicker("option", "dateFormat", "dd/mm/yy");

           $("#ctl00_MainContent_FormView1_DataCartaTextBox").datepicker();
           $("#ctl00_MainContent_FormView1_DataCartaTextBox").datepicker("option", "dateFormat", "dd/mm/yy");

           //$('#ctl00_MainContent_FormView1_MatriculaTextBox').mask("aa-99-99-aa");
           $('#ctl00_MainContent_FormView1_MatriculaTextBox').keyup(function () {
               this.value = this.value.toUpperCase();
           });
           $('#ctl00_MainContent_FormView1_ChassiTextBox').blur(function () {
               this.value = this.value.toUpperCase();
           });
        

       }

       
       
       function SetInitializeAcordion_3() {
           

           $("#ctl00_MainContent_FormView1_DataFabricoTextBox").datepicker();
           $("#ctl00_MainContent_FormView1_DataFabricoTextBox").datepicker("option", "dateFormat", "dd/mm/yy");

           //$('#ctl00_MainContent_FormView1_MatriculaTextBox').mask("aa-99-99-aa");
           $('#ctl00_MainContent_FormView1_MatriculaTextBox').keyup(function () {
               this.value = this.value.toUpperCase();
           });

           $('#ctl00_MainContent_FormView1_ChassiTextBox').blur(function () {
               this.value = this.value.toUpperCase();
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

       function MessageBoxEmptyConverterApolice(refString) {
           $("#dialog-EmptyConverterApolice").dialog({
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
       
       function MessageBoxErro() {
           $("#dialog-EmptyQueryString").dialog({
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
       

       
       function MessageBoxResultado(ApoliceID, Apolice, Cliente, AvisoCobranca) {
          
           $("#Apolice").val(Apolice);
           $("#Cliente").val(Cliente);
           $("#AvisoCobranca").val(AvisoCobranca);
           $("#dialog-ResultadoConverterApolice").dialog({
               title: "MASTER SEGUROS",
               resizable: false,
               width: 430,
               height: 300,
               modal: true,
               buttons: {
                   "OK": function () {
                       window.open('AutoDocument.aspx?docID=1&aplID=' + ApoliceID, 'Aviso');
                       location.href = 'AdminSimulacao.aspx';
                       $(this).dialog("close");
                       return true;
                   }
               }

           });
           return false;
       }

       function MessageBoxSimulacaoSucesso(PremioPuro, PremioComercial, Encargos, EncargosParcelamento, ImpostoSelo, PremioTotal) {
           //var message = refString;
           $("#PremioPuro").val(PremioPuro);
           $("#PremioComercial").val(PremioComercial);
           $("#Encargos").val(Encargos);
           $("#EncargosParcelamento").val(EncargosParcelamento);
           $("#ImpostoSelo").val(ImpostoSelo);
           $("#PremioTotal").val(PremioTotal);
           
           $("#dialog-SimulacaoSucesso").dialog({
               title: "MASTER SEGUROS",
               resizable: false,
               width: 530,
               height: 400,
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
