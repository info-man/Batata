<%@ Page Title="Simulação de Seguro" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdminSimulacaoAT.aspx.cs" Inherits="MASTERSEGUROS.WEB.AdminSimulacaoAT"  %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
  
<asp:ScriptManager ID="ScriptManager1" runat="server" EnablePartialRendering="true" EnablePageMethods="true" EnableCdn="true"/>
  <div id="aa" style="display:none">
     <asp:TextBox ID="h_C_ClienteIDTextBox"  runat="server" Width="0" />
     <asp:TextBox ID="h_C_ProvinciaIDComboBox"  runat="server" Width="0" />
     <asp:TextBox ID="h_C_NomeTextbox"  runat="server" Width="0" />
     <asp:TextBox ID="h_C_TelemovelTextBox"  runat="server" Width="0" />
  </div>
    <asp:FormView ID="FormView1" runat="server"   Width="100%" DataKeyNames="PropostaID" DataSourceID="SqlDataSourcePropostaAuto" DefaultMode="Insert" >

        <InsertItemTemplate>
            
             <table border="0" cellpadding="0" cellspacing="0" width="100%">
                 <tr>
                     <td colspan="2">
                          <div id="accordion">
                              <h3>Tomador / Proponente </h3>
                              <div>
                                   <asp:UpdatePanel ID="UpdatePanel4" runat="server"  updatemode="Conditional" > 
                              <ContentTemplate>
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
                                        <asp:DropDownList runat="server" ID="ClienteComboBox"  Width="115px" OnSelectedIndexChanged="ClienteComboBox_SelectedIndexChanged" AutoPostBack="true"  >
                                            <asp:ListItem Text="Novo" Value="1"></asp:ListItem>
                                            <asp:ListItem Text="Existente" Value="2"></asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                 <tr>
                                    <td style="width:90px">Nome: <img alt="" style="vertical-align:middle" src="img/yes2.png" /></td>
                                    <td>
                                        <asp:TextBox ID="NomeTextBox" Text='<%#Bind("Nome") %>'  runat="server" Width="350" MaxLength="350" />
                                        &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator5" ValidationGroup="Form" Display="Dynamic" runat="server" Text="*" ControlToValidate="NomeTextBox"  ToolTip="" SetFocusOnError="true">&otimes;</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Morada: <img alt="" style="vertical-align:middle" src="img/yes.png" /></td>
                                    <td>
                                        <asp:TextBox ID="MoradaTextBox" Text='<%#Bind("Morada") %>'  runat="server"  Width="350" MaxLength="350" />
                                        &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator1" ValidationGroup="Form" Display="Dynamic" runat="server" Text="*" ControlToValidate="MoradaTextBox"  ToolTip="" SetFocusOnError="true">&otimes;</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Província:</td>
                                    <td>
                                        <asp:DropDownList runat="server"  ID="ProvinciaIDComboBox" AutoPostBack ="false"  Width="205px"    AppendDataBoundItems="true"  DataSourceID="SqlDataSourceProvincia"   DataValueField="ProvinciaId"  DataTextField="Nome" ></asp:DropDownList>
                                    </td>
                                </tr>

                                 <tr>
                                    <td>Telemóvel: <img alt="" style="vertical-align:middle" src="img/yes2.png" /></td>
                                    <td>
                                        <asp:TextBox ID="TelemovelTextBox"  Text='<%#Bind("Telemovel") %>'  runat="server"  Width="200" MaxLength="400" />
                                         &nbsp;<asp:RequiredFieldValidator ID="ReqVal" ValidationGroup="Form" Display="Dynamic" runat="server" Text="*" ControlToValidate="TelemovelTextBox"  ToolTip="" SetFocusOnError="true">&otimes;</asp:RequiredFieldValidator>
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

                                    </td>
                                </tr>
                             </table>
                                   </ContentTemplate>

                                 </asp:UpdatePanel>
                                  </div>

                               <h3>Actividade / Modalidade </h3>
                              <div>
                            <table border="0" cellpadding="0" cellspacing="0"   style="width:100%;border-collapse:collapse;font-size: 13px;">
                                <tr>
                                    <td style="width:135px">Mediador: <img alt="" style="vertical-align:middle" src="img/yes.png" /></td>
                                    <td>
                                        <asp:TextBox ID="MediadorTextBox" ReadOnly="true" BackColor="Window" Text='Obtido automaticamente'  runat="server" Width="350" MaxLength="350" />
                                        &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator7" ValidationGroup="Form" Display="Dynamic" runat="server" Text="*" ControlToValidate="MediadorTextBox"  ToolTip="" SetFocusOnError="true">&otimes;</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width:125px">Modalidade: <img alt="" style="vertical-align:middle" src="img/yes.png" /></td>
                                    <td>
                                        <asp:DropDownList runat="server"  ID="ModalidadeComboBox" AutoPostBack ="false"  Width="205px"    AppendDataBoundItems="true"  DataSourceID="SqlDataSourceModalidade"   DataValueField="ModalidadeID"  DataTextField="Descricao" ></asp:DropDownList>
                                       
                                    </td>
                                </tr>
                                 <tr>
                                    <td style="width:125px">Duração: </td>
                                    <td>
                                        <asp:DropDownList runat="server"  ID="DurcaoComboBox" AutoPostBack ="false"  Width="205px">
                                            <asp:ListItem Value="1" Text="6 Meses"></asp:ListItem>
                                            <asp:ListItem Value="2" Text="1 Ano e seguintes"></asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                
                                <tr>
                                    <td style="width:125px">Fraccionamento:</td>
                                    <td>
                                        <asp:DropDownList Width="205px"  runat="server" ID="FormaDePagamentoComboBox"  DataSourceID="ParcelamentoDatasource" DataTextField="Descricao" DataValueField="ConfigKey" >
                                            
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                
                                 <tr>
                                    <td style="width:125px">  CAE.: <img alt="" style="vertical-align:middle" src="img/yes.png" /></td>
                                      <td>
                                            <asp:DropDownList Width="350px" runat="server" ID="CaeIDComboBox"  DataSourceID="SqlDataSourceCAE" DataValueField="caeID" DataTextField="Descricao" >
                                                <asp:ListItem Value="1" Text=""></asp:ListItem>
                                               
                                            </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width:125px">Act. Predominante:<img alt="" style="vertical-align:middle" src="img/yes.png" /></td>
                                    <td>
                                            <asp:DropDownList Width="350px" runat="server" ID="ActividadePredominanteComboBox" DataSourceID="SqlDataSourceCAE" DataValueField="caeID" DataTextField="Descricao"  OnDataBound="ActividadePredominanteComboBox_DataBound" OnSelectedIndexChanged="ActividadePredominanteComboBox_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>&nbsp; <span style="font-size:10px">(Determina a taxa a aplicar)</span>
                                    </td>
                                </tr>                         
                            </table>
                            </div>
                               
                              <h3>Taxas e Remunerações</h3>
                              
                              <div>
                                  <asp:UpdatePanel ID="UpdatePanel1" runat="server"  updatemode="Conditional" > 
                              <ContentTemplate>
                                <table border="0" cellpadding="0" cellspacing="0"   style="width:100%;border-collapse:collapse;font-size: 13px;">
                          
                                    <tr>
                                        <td style="width:130px">Taxa Simples: </td>
                                        <td>
                                             <asp:TextBox ID="TaxaSimplesTextBox" ReadOnly="true" BackColor="ControlLight" Text='<%#Bind("TaxaSimples") %>'  runat="server"  Width="50" MaxLength="10" Style="text-align:center"  />%</td>
                                    </tr>
                                    <tr>
                                        <td>"Q" Cliente: </td>
                                        <td>
                                            <asp:TextBox ID="ClienteQPTextBox" Text='<%#Bind("ClienteQP") %>'  runat="server"  Width="50" MaxLength="4" Style="text-align:center" />%
                                             &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator9" ValidationGroup="Form" Display="Dynamic" runat="server"  ControlToValidate="ClienteQPTextBox" ToolTip="" SetFocusOnError="true" >&otimes;</asp:RequiredFieldValidator>
                                            <asp:RangeValidator MaximumValue="100" MinimumValue="0" ControlToValidate="ClienteQPTextBox" ID="RngValClienteQPTextBox" runat="server" Type="Double">&otimes;</asp:RangeValidator>
                
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width:130px">Taxa Simples Final: </td>
                                        <td>
                                            <asp:TextBox ID="TaxaSimplesFinalTextBox" ReadOnly="true" BackColor="ControlLight" Text='<%#Bind("TaxaSimplesFinal") %>'  runat="server"  Width="50" MaxLength="4" Style="text-align:center" />%   
                                          &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator11" ValidationGroup="Form" Display="Dynamic" runat="server"  ControlToValidate="TaxaSimplesFinalTextBox" ToolTip="" SetFocusOnError="true" >&otimes;</asp:RequiredFieldValidator>

                                            <asp:RangeValidator MaximumValue="100" MinimumValue="0" ControlToValidate="TaxaSimplesFinalTextBox" ID="RangeValidator1" runat="server" Type="Double">&otimes;</asp:RangeValidator>
                                                             
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" style="height:40px">Remunerações Mensais:</td>

                                    </tr>
                                    <tr>
                                        <td style="width:130px" >Salário:<img alt="" style="vertical-align:middle" src="img/yes.png" /></td>
                                       <td>
                                        <asp:TextBox ID="SalarioTextBox" Text='<%#Bind("Salario") %>'  runat="server" Width="110" MaxLength="9" />&nbsp;<asp:RequiredFieldValidator ID="ReqValSalarioTextBox" ValidationGroup="Form" Display="Dynamic" runat="server" Text="*" ControlToValidate="SalarioTextBox"  ToolTip="" SetFocusOnError="true">&otimes;</asp:RequiredFieldValidator>&nbsp;<asp:RangeValidator MaximumValue="50000000" MinimumValue="0" ControlToValidate="SalarioTextBox" ID="RangeValidator4" runat="server" Type="Double">&otimes;</asp:RangeValidator>Meses Ano: <asp:DropDownList ID="SalarioMesesComboBox" runat="server" Width="100px" >
                                               <asp:ListItem Text="" Value=""></asp:ListItem>
                                               <asp:ListItem Text="14" Value="14"></asp:ListItem>
                                               <asp:ListItem Text="13" Value="13"></asp:ListItem>
                                               <asp:ListItem Text="12" Value="12"></asp:ListItem>
                                               <asp:ListItem Text="11" Value="11"></asp:ListItem>
                                               <asp:ListItem Text="10" Value="10"></asp:ListItem>
                                               <asp:ListItem Text="09" Value="9"></asp:ListItem>
                                               <asp:ListItem Text="08" Value="8"></asp:ListItem>
                                               <asp:ListItem Text="07" Value="7"></asp:ListItem>
                                               <asp:ListItem Text="06" Value="6"></asp:ListItem>
                                               <asp:ListItem Text="05" Value="5"></asp:ListItem>
                                               <asp:ListItem Text="04" Value="4"></asp:ListItem>
                                               <asp:ListItem Text="03" Value="3"></asp:ListItem>
                                               <asp:ListItem Text="02" Value="2"></asp:ListItem>
                                               <asp:ListItem Text="01" Value="1"></asp:ListItem>
                                                 </asp:DropDownList>
                                            &nbsp;<asp:RequiredFieldValidator ID="ReqValSalarioMesesComboBox" ValidationGroup="Form" Display="Dynamic" runat="server"  ControlToValidate="SalarioMesesComboBox" ToolTip="" SetFocusOnError="true" >&otimes;</asp:RequiredFieldValidator>
                                            </td>
                                        
                                    </tr>

                                    <tr>
                                        <td style="width:130px" >Outras: </td>
                                       <td>
                                        <asp:TextBox ID="OutrasTextBox" Text='<%#Bind("Outras") %>'  runat="server" Width="110" MaxLength="350" />&nbsp;<asp:RangeValidator MaximumValue="50000000" MinimumValue="0" ControlToValidate="OutrasTextBox" ID="RangeValidator2" runat="server" Type="Double">&otimes;</asp:RangeValidator>&nbsp;Meses Ano: <asp:DropDownList ID="OutrasMesesComboBox" runat="server" Width="100px" >
                                               <asp:ListItem Text="" Value=""></asp:ListItem>
                                               <asp:ListItem Text="14" Value="14"></asp:ListItem>
                                               <asp:ListItem Text="13" Value="13"></asp:ListItem>
                                               <asp:ListItem Text="12" Value="12"></asp:ListItem>
                                               <asp:ListItem Text="11" Value="11"></asp:ListItem>
                                               <asp:ListItem Text="10" Value="10"></asp:ListItem>
                                               <asp:ListItem Text="09" Value="9"></asp:ListItem>
                                               <asp:ListItem Text="08" Value="8"></asp:ListItem>
                                               <asp:ListItem Text="07" Value="7"></asp:ListItem>
                                               <asp:ListItem Text="06" Value="6"></asp:ListItem>
                                               <asp:ListItem Text="05" Value="5"></asp:ListItem>
                                               <asp:ListItem Text="04" Value="4"></asp:ListItem>
                                               <asp:ListItem Text="03" Value="3"></asp:ListItem>
                                               <asp:ListItem Text="02" Value="2"></asp:ListItem>
                                               <asp:ListItem Text="01" Value="1"></asp:ListItem>
                                                 </asp:DropDownList>
                                    </td>
                                    
                                    

                                    </tr> 

                                </table>
                                </ContentTemplate>
                                       <Triggers>
                                 <asp:AsyncPostBackTrigger ControlID="ActividadePredominanteComboBox" EventName="SelectedIndexChanged" />
                                 </Triggers>
                              </asp:UpdatePanel>
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
            <asp:Button ID="PropostaButton" ValidationGroup="Form" CssClass="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" runat="server" Text="2.Proposta" CommandName="Insert" CausesValidation ="True" OnClientClick="SetValidatorsSimulacao(true);" OnClick="Proposta_Click"  />
            <asp:Button ID="ConverterButton" CssClass="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" runat="server"  ValidationGroup="Apolice" Text="3.Aviso de Cobrança"  Visible="true" OnClick="ConverterButton_Click" />

            <asp:ValidationSummary ValidationGroup="Form" runat="server" ShowSummary="true" ID="ValSummary" DisplayMode="List" />
            <asp:CustomValidator ID="cstConverterApolice" Text="" Display="Dynamic"   ValidationGroup="Apolice" runat="server" OnServerValidate="cstConverterApolice_ServerValidate" ></asp:CustomValidator> 

        </InsertItemTemplate>
    </asp:FormView>
        <div id="modal-Cliente" title="Master Seguros - Pesquisa de Clientes" style="display: none">
         <asp:UpdatePanel ID="UpdatePanel5" runat="server" UpdateMode="Conditional">
           
            <ContentTemplate>
              
                <table border="0" cellpadding="1" cellspacing="0"   style="vertical-align: top;width:100%;border-collapse:collapse;font-size: 12px;">
                <tr>
                    <td style="width:80px" >Nr. Cliente:</td>
                    <td>
                        <asp:TextBox ID="C_ClienteIDTextBox" runat="server" Width="30" MaxLength="4" />
                    </td>
                </tr>
                <tr>
                    <td>Nome:</td>
                    <td>
                        <asp:TextBox ID="C_NomeTextbox" runat="server"  Width="300" MaxLength="300" />

                    </td>
                </tr>
                <tr>
                    <td>Província:</td>
                    <td>
                        <asp:DropDownList runat="server"  ID="C_ProvinciaIDComboBox" AutoPostBack ="false"  Width="160px"    AppendDataBoundItems="true"  DataSourceID="SqlDataSourceProvincia"   DataValueField="ProvinciaId"  DataTextField="Nome" >
                            <asp:ListItem Value="-1" Text="Seleccione um opção"></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td>Telemóvel:</td>
                    <td>
                        <asp:TextBox ID="C_TelemovelTextBox" runat="server"  Width="80" MaxLength="12" />

                    </td>
                </tr>
            
            <tr>
                <td colspan="2">
                    <asp:Button ID="btnPesquisar"  CausesValidation="False" CssClass="ui-button ui-corner-all" runat="server" Text="Pesquisar" OnClientClick="javascript:SelValues();__doPostBack('ctl00$MainContent$GridViewCliente','Page$0');" />
                   <hr />
                </td>
            </tr>
            </table>
        <asp:GridView ID="GridViewCliente" runat="server"
        AllowPaging="True" AutoGenerateColumns="False"
        CellPadding="2" DataKeyNames="ClienteID" DataSourceID="ClienteDatasource"
        PagerSettings-PageButtonCount="15" PageSize="10"
        HeaderStyle-CssClass="SGCRowHeader"
        AlternatingRowStyle-CssClass="SGCdadosBodyAlt"
        RowStyle-CssClass="SGCdadosBodyNorm" OnPageIndexChanging="GridViewCliente_PageIndexChanging">
        <AlternatingRowStyle BackColor="White" />
        <Columns>
            <asp:BoundField DataField="ClienteID" HeaderText="Nr. Cliente" SortExpression="ClienteID" ItemStyle-Width="60px" ItemStyle-HorizontalAlign="Right"  />
            <asp:BoundField DataField="Nome" HeaderText="Nome" SortExpression="Nome" ItemStyle-Width="200px" />
            <asp:BoundField DataField="Morada" HeaderText="Morada" SortExpression="Morada" ItemStyle-Width="200px" />
            <asp:TemplateField HeaderText="Província" SortExpression="ProvinciaID" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="70px">
                <ItemTemplate>
                    <asp:Label ID="lblProvincia" runat="server" Text='<%# BuildProvincia((object)Eval("ProvinciaID"))%>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="Telemovel" HeaderText="Telemovel" SortExpression="Morada" ItemStyle-Width="80px" />
            <asp:TemplateField HeaderText="Operações"  ItemStyle-HorizontalAlign="Left">
                <ItemTemplate>
                    <asp:LinkButton ID="lnkSelCliente" runat="server" Text='Seleccionar'  OnClientClick='<%# Eval("ClienteID", "SelCliente(\"{0}\");") %>'></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        <EditRowStyle />
        <FooterStyle  Font-Bold="False" ForeColor="White" />
        <HeaderStyle  Font-Bold="False" ForeColor="White" />
        <PagerSettings PageButtonCount="15"></PagerSettings>
        <PagerStyle  ForeColor="White" HorizontalAlign="Center" CssClass="PagerStyle" />
        <RowStyle BackColor="#E3EAEB" />
        <SelectedRowStyle BackColor="#C5BBAF" Font-Bold="False" ForeColor="#333333" />
        <SortedAscendingCellStyle BackColor="#F8FAFA" />
        <SortedAscendingHeaderStyle BackColor="#1F6500" />
        <SortedDescendingCellStyle BackColor="#D4DFE1" />
        <SortedDescendingHeaderStyle BackColor="#1F6500" />
        <EmptyDataRowStyle BorderStyle="None"  BorderWidth="0" BorderColor="White" ForeColor="#427c97" />
        <EmptyDataTemplate>Não foram encontrados resultados</EmptyDataTemplate>
    </asp:GridView>
            </ContentTemplate>
             
        </asp:UpdatePanel>
    </div>    
            
        <div id="dialog-ArtigoErroGravar" title="Master Seguros" style="display: none">
        <br />
        <b>Ocorreu um erro a gravar os dados.<br />Comunique ao administrador de sistemas.</b>
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

   <asp:SqlDataSource ID="SqlDataSourcePropostaAuto"  OnInserted="On_Inserted" OnUpdated="On_Updated"  OnInserting ="SqlDataSourcePropostaAuto_Inserting" OnUpdating="On_Updating" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" 
        DeleteCommand="DELETE FROM [master_proposta_auto] WHERE [PropostaID] = @PropostaID" 
        InsertCommand="INSERT INTO [master_proposta_auto] ([NumeroProposta], [BrokerID], [QualidadeTomadorID], [MarcaID], [ModeloID], [DataFabrico], [Cilindrada], [Chassi], [UsoID], [RCCliente], [DPCliente], [CategoriaID], [TipoCategoriaID], [OcupantesOpcaoID], [ValorNovo], [ValorSegurar], [Franquia], [TipoSeguroID], [Fraccionamento], [Nome], [Morada], [ProvinciaID], [Telemovel], [Email], [BI], [Passaporte], [DataNascimento], [CartaConducaoNumero], [CartaConducaoData], [UserIDCriacao], [DataCriacao]) VALUES (@NumeroProposta, @BrokerID,@QualidadeTomadorID,@MarcaID,@ModeloID,@DataFabrico,@Cilindrada,@Chassi,@UsoID,@RCCliente,@DPCliente,@CategoriaID,@TipoCategoriaID,@OcupantesOpcaoID,@ValorNovo,@ValorSegurar,@Franquia,@TipoSeguroID,@Fraccionamento,@Nome,@Morada,@ProvinciaID,@Telemovel,@Email,@BI,@Passaporte,@DataNascimento,@CartaConducaoNumero,@CartaConducaoData,  @UserIDCriacao, @DataCriacao); SELECT @PropostaID = SCOPE_IDENTITY()" 
        SelectCommand="SELECT * FROM [master_proposta_auto] WHERE [PropostaID] = @PropostaID"  
        UpdateCommand="UPDATE [master_proposta_auto] SET [NumeroProposta] = @NumeroProposta, [BrokerID] = @BrokerID ,[QualidadeTomadorID] = @QualidadeTomadorID ,[MarcaID] = @MarcaID ,[ModeloID] = @ModeloID ,[DataFabrico] = @DataFabrico ,[Cilindrada] = @Cilindrada ,[Chassi] = @Chassi, [UsoID] = @UsoID, [RCCliente] = @RCCliente,[DPCliente] = @DPCliente, [CategoriaID] = @CategoriaID, [TipoCategoriaID] = @TipoCategoriaID, [OcupantesOpcaoID] = @OcupantesOpcaoID, [ValorNovo] = @ValorNovo, [ValorSegurar] = @ValorSegurar,[Franquia] = @Franquia, [TipoSeguroID] = @TipoSeguroID, [Fraccionamento] = @Fraccionamento, [Nome] = @Nome,[Morada] = @Morada, [ProvinciaID] = @ProvinciaID, [Telemovel] = @Telemovel, [Email] = @Email, [BI] = @BI, [Passaporte] = @Passaporte, [DataNascimento] = @DataNascimento, [CartaConducaoNumero] = @CartaConducaoNumero,[CartaConducaoData] = @CartaConducaoData, [UserIDCriacao] = @UserIDCriacao,[DataCriacao] = @DataCriacao, [UserIDActualizacao] = @UserIDActualizacao, [DataActualizacao] = @DataActualizacao WHERE PropostaID = @PropostaID">
        <InsertParameters>
            <asp:Parameter Name="PropostaID" Direction="Output" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="NumeroProposta" Type="String" DefaultValue="0" />
            <asp:ControlParameter ControlID="ctl00$MainContent$FormView1$BrokerComboBox" PropertyName="SelectedValue" Name="BrokerID"  Type="Int32" />
            <asp:ControlParameter ControlID="ctl00$MainContent$FormView1$QualidadeComboBox" PropertyName="SelectedValue" Name="QualidadeTomadorID"  Type="Int32" />
        <%--    <asp:ControlParameter ControlID="ctl00$MainContent$FormView1$MarcaComboBox" PropertyName="SelectedValue" Name="MarcaID"  Type="Int32" />--%>
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
            <asp:Parameter Name="UserIDCriacao" Type="String" />
            <asp:Parameter Name="DataCriacao" Type="DateTime" />
        </InsertParameters>
         <SelectParameters>
           <asp:Parameter Name="PropostaID" Type="Int32" />
       </SelectParameters>
       
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceCAE" runat="server"
        ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"
        SelectCommand="SELECT CaeID, Codigo, SUBSTRING(Descricao,0,100) as Descricao, Taxa, TipoTaxa, Valor FROM master_cae">
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceProvincia" runat="server"
        ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"
        SelectCommand="SELECT * FROM [master_provincia] ORDER BY NOME "></asp:SqlDataSource>

     <asp:SqlDataSource ID="SqlDataSourceModalidade" runat="server"
        ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"
        SelectCommand="SELECT * FROM [master_modalidade] ORDER BY ModalidadeID "></asp:SqlDataSource>

   <asp:SqlDataSource ID="ParcelamentoDatasource" runat="server"
        ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"
        SelectCommand="SELECT  ConfigKey, Descricao FROM master_configuracao WHERE ConfigType= 'PARCELA_PAGAMENTO'">
    </asp:SqlDataSource>

  <asp:SqlDataSource ID="ClienteDatasource" runat="server"
        ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"
        SelectCommandType="StoredProcedure" 
        SelectCommand="spGetListCliente">
         <SelectParameters>
           <asp:ControlParameter ControlID="h_C_ClienteIDTextBox" PropertyName="Text" Name="ClienteID" Type="Int32" DefaultValue="-1" />
           <asp:ControlParameter ControlID="h_C_ProvinciaIDComboBox" PropertyName="Text" Name="ProvinciaID" ConvertEmptyStringToNull="False" Type="string" />
           <asp:ControlParameter ControlID="h_C_NomeTextbox" PropertyName="Text" Name="Nome" ConvertEmptyStringToNull="False" Type="string" />
           <asp:ControlParameter ControlID="h_C_TelemovelTextBox" PropertyName="Text" Name="Telemovel" ConvertEmptyStringToNull="False" Type="string" />
       </SelectParameters>
    </asp:SqlDataSource>

   <script type="text/javascript">

       $(function () {
           $("input").checkboxradio({
               icon: false
           });
       });

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

           $("#ctl00_MainContent_FormView1_DataInicioTextBox").datepicker();
           $("#ctl00_MainContent_FormView1_DataInicioTextBox").datepicker("option", "dateFormat", "dd/mm/yy");

           $("#ctl00_MainContent_FormView1_DataNascimentoTextBox").datepicker();
           $("#ctl00_MainContent_FormView1_DataNascimentoTextBox").datepicker("option", "dateFormat", "dd/mm/yy");

       }

       function SetInitializeAcordion_1() {
           $("#ctl00_MainContent_FormView1_DataInicioTextBox").datepicker();
           $("#ctl00_MainContent_FormView1_DataInicioTextBox").datepicker("option", "dateFormat", "dd/mm/yy");
       }
       
       function SetInitializeAcordion_3() {

       }

       function SetValidatorsSimulacao(bVal) {
           //Desabilitar/habilitar validators
           document.getElementById("ctl00_MainContent_FormView1_RequiredFieldValidator1").enabled = bVal;
           document.getElementById("ctl00_MainContent_FormView1_ReqVal").enabled = bVal;
           return true;
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

       function SelCliente(value) {
           document.all['<%=FormView1.FindControl("NomeTextBox").UniqueID%>'].value = value;
            $("#modal-Cliente").dialog("close");
       }

       function showCliente()
       {
           $("#modal-Cliente").dialog({
               title: "MASTER SEGUROS",
               resizable: false,
               width: 800,
               height: 620,
               modal: true              
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
