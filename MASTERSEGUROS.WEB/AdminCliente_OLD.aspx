<%@ Page Title="Clientes" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdminCliente_OLD.aspx.cs" Inherits="MASTERSEGUROS.WEB.AdminCliente_OLD"  %>
<%@ Register TagPrefix="cc" Namespace="Winthusiasm.HtmlEditor" Assembly="Winthusiasm.HtmlEditor" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
   
        <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePartialRendering="true" />
    <asp:UpdatePanel ID="UpdatePanel2" runat="server"> 
            <ContentTemplate>
    
    <asp:FormView ID="FormView1" runat="server"   Width="100%" DataKeyNames="CAPID" DataSourceID="SqlDataSourceCTT" DefaultMode="Insert" >

        <InsertItemTemplate>
            
                <div id="accordion">
  <h3>Tomador do Seguro</h3>
  <div>
     <table border="0" cellpadding="0" cellspacing="0"   style="width:100%;border-collapse:collapse;font-size: 13px;">
        <tr>
            <td style="width:90px">Nome:</td>
            <td>
                <asp:TextBox ID="NomeTextBox" runat="server" Text='<%# Bind("Nome") %>' Width="350" MaxLength="350" />
                &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator5" ValidationGroup="Form" Display="Dynamic" runat="server" Text="*" ControlToValidate="NomeTextBox" class="erro" ToolTip="" SetFocusOnError="true">&otimes;</asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>Morada:</td>
            <td>
                <asp:TextBox ID="PseudonimoTextBox" runat="server" Text='<%# Bind("Pseudonimo") %>' Width="350" MaxLength="350" />
                &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator1" ValidationGroup="Form" Display="Dynamic" runat="server" Text="*" ControlToValidate="PseudonimoTextBox" class="erro" ToolTip="" SetFocusOnError="true">&otimes;</asp:RequiredFieldValidator>
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
            <td>Município:</td>
            <td>
                <asp:DropDownList runat="server"  ID="MunicipioIDComboBox" AutoPostBack ="false"   Width="200px"   AppendDataBoundItems="true"   DataSourceID="SqlDataSourceMunicipio"   DataValueField="MunicipioId"  DataTextField="Nome" >
                                        
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td>Comuna:</td>
            <td>
                <asp:DropDownList runat="server"  ID="ComunaIDComboBox" AutoPostBack ="false"   Width="200px"   AppendDataBoundItems="true"   DataSourceID="SqlDataSourceComuna"   DataValueField="ComunaId"  DataTextField="Nome" >
                                       
                </asp:DropDownList>
            </td>
        </tr>
            <tr>
            <td>Telefone:</td>
            <td>
                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Telemovel") %>' Width="200" MaxLength="400" />
            </td>
        </tr>
        <tr>
            <td>Telemóvel:</td>
            <td>
                <asp:TextBox ID="TelemovelTextBox" runat="server" Text='<%# Bind("Telemovel") %>' Width="200" MaxLength="400" />
            </td>
        </tr>
        <tr>
            <td>E-mail:</td>
            <td>
                <asp:TextBox ID="EmailTextBox" runat="server" Text='<%# Bind("Email") %>' Width="300" MaxLength="400" />
            </td>
        </tr>
            <tr>
            <td>BI:</td>
            <td>
                <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("BI") %>' Width="200" MaxLength="400" /> 
            </td>
        </tr>
        <tr>
            <td>NIF:</td>
            <td>
                <asp:TextBox ID="NIFTextBox" runat="server" Text='<%# Bind("NIF") %>' Width="200" MaxLength="400" /> 
            </td>
        </tr>
            <tr>
            <td>Profissão:</td>
            <td>
                <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("NIF") %>' Width="200" MaxLength="400" /> 
            </td>
        </tr>
            <tr>
            <td>Cª Condução:</td>
            <td>
                <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("NIF") %>' Width="200" MaxLength="400" /> 
            </td>
        </tr>
                    </table>
  </div>
    
            <h3>Segurado</h3>
            <div> 
            O tomador do seguro é o mesmo que o segurado? <asp:CheckBox   runat="server"  ID="chkTomador"   AutoPostBack="true"  OnCheckedChanged="chkTomador_CheckedChanged" /><br /><br />
       

            <asp:Panel ID="pnlTomadorSeguro" runat="server" visible="true"> 
     <table border="0" cellpadding="0" cellspacing="0"   style="width:100%;border-collapse:collapse;font-size: 13px;">
        <tr>
            <td style="width:90px">Nome:</td>
            <td>
                <asp:TextBox ID="TextBox6" runat="server" Text='<%# Bind("Nome") %>' Width="350" MaxLength="350" />
                &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator2" ValidationGroup="Form" Display="Dynamic" runat="server" Text="*" ControlToValidate="NomeTextBox" class="erro" ToolTip="" SetFocusOnError="true">&otimes;</asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>Morada:</td>
            <td>
                <asp:TextBox ID="TextBox11" runat="server" Text='<%# Bind("Pseudonimo") %>' Width="350" MaxLength="350" />
                &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator3" ValidationGroup="Form" Display="Dynamic" runat="server" Text="*" ControlToValidate="PseudonimoTextBox" class="erro" ToolTip="" SetFocusOnError="true">&otimes;</asp:RequiredFieldValidator>
            </td>
        </tr>
            <tr>
            <td>Província:</td>
            <td>
                <asp:DropDownList runat="server"  ID="DropDownList1" AutoPostBack ="false"  Width="200px"    AppendDataBoundItems="true"  DataSourceID="SqlDataSourceProvincia"   DataValueField="ProvinciaId"  DataTextField="Nome" >
                                        
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td>Município:</td>
            <td>
                <asp:DropDownList runat="server"  ID="DropDownList2" AutoPostBack ="false"   Width="200px"   AppendDataBoundItems="true"   DataSourceID="SqlDataSourceMunicipio"   DataValueField="MunicipioId"  DataTextField="Nome" >
                                        
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td>Comuna:</td>
            <td>
                <asp:DropDownList runat="server"  ID="DropDownList3" AutoPostBack ="false"   Width="200px"   AppendDataBoundItems="true"   DataSourceID="SqlDataSourceComuna"   DataValueField="ComunaId"  DataTextField="Nome" >
                                       
                </asp:DropDownList>
            </td>
        </tr>
            <tr>
            <td>Telefone:</td>
            <td>
                <asp:TextBox ID="TextBox12" runat="server" Text='<%# Bind("Telemovel") %>' Width="200" MaxLength="400" />
            </td>
        </tr>
        <tr>
            <td>Telemóvel:</td>
            <td>
                <asp:TextBox ID="TextBox13" runat="server" Text='<%# Bind("Telemovel") %>' Width="200" MaxLength="400" />
            </td>
        </tr>
        <tr>
            <td>E-mail:</td>
            <td>
                <asp:TextBox ID="TextBox14" runat="server" Text='<%# Bind("Email") %>' Width="300" MaxLength="400" />
            </td>
        </tr>
            <tr>
            <td>BI:</td>
            <td>
                <asp:TextBox ID="TextBox15" runat="server" Text='<%# Bind("BI") %>' Width="200" MaxLength="400" /> 
            </td>
        </tr>
        <tr>
            <td>NIF:</td>
            <td>
                <asp:TextBox ID="TextBox16" runat="server" Text='<%# Bind("NIF") %>' Width="200" MaxLength="400" /> 
            </td>
        </tr>
            <tr>
            <td>Profissão:</td>
            <td>
                <asp:TextBox ID="TextBox17" runat="server" Text='<%# Bind("NIF") %>' Width="200" MaxLength="400" /> 
            </td>
        </tr>
            <tr>
            <td>Cª Condução:</td>
            <td>
                <asp:TextBox ID="TextBox18" runat="server" Text='<%# Bind("NIF") %>' Width="200" MaxLength="400" /> 
            </td>
        </tr>
                    </table>
           </asp:Panel>
  </div>
                          
</div> 
             
                     <br />
            
            
            <asp:Button ID="InsertButton" ValidationGroup="Form" CssClass="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" runat="server" Text="Guardar" CommandName="Insert" CausesValidation="True"  />
        </InsertItemTemplate>

        <EditItemTemplate>
            <table border="0" cellpadding="0" cellspacing="0" >
                 <tr>
                    <td> 
                          <table border="0" cellpadding="1" cellspacing="0"   style="width:100%;border-collapse:collapse;font-size: 13px;">
                            <tr><td><h3>Dados Biográficos</h3></td></tr>
                            
                            
                            <tr>
                                <td>Nome da Empresa:</td>
                                <td>
                                    <asp:TextBox ID="NomeTextBox" runat="server" Text='<%# Bind("Nome") %>' Width="398" MaxLength="400" />
                                    &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator5" ValidationGroup="Form" Display="Dynamic" runat="server" Text="*" ControlToValidate="NomeTextBox" class="erro" ToolTip="" SetFocusOnError="true">&otimes;</asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td>Morada:</td>
                                <td>
                                    <asp:TextBox ID="PseudonimoTextBox" runat="server" Text='' Width="398" MaxLength="400" />
                                    &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator1" ValidationGroup="Form" Display="Dynamic" runat="server" Text="*" ControlToValidate="PseudonimoTextBox" class="erro" ToolTip="" SetFocusOnError="true">&otimes;</asp:RequiredFieldValidator>
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
                                <td>Município:</td>
                                <td>
                                    <asp:DropDownList runat="server"  ID="MunicipioIDComboBox" AutoPostBack ="false"   Width="200px"   AppendDataBoundItems="true"   DataSourceID="SqlDataSourceMunicipio"   DataValueField="MunicipioId"  DataTextField="Nome" >
                                        
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td>Comuna:</td>
                                <td>
                                    <asp:DropDownList runat="server"  ID="ComunaIDComboBox" AutoPostBack ="false"   Width="200px"   AppendDataBoundItems="true"   DataSourceID="SqlDataSourceComuna"   DataValueField="ComunaId"  DataTextField="Nome" >
                                       
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td>Código 3 Palavras:</td>
                                <td>
                                    <asp:TextBox ID="Palavra1TextBox" runat="server" Text='<%# Bind("Palavra1") %>' Width="80" MaxLength="20" /><strong>.</strong><asp:TextBox ID="Palavra2TextBox" runat="server" Text='<%# Bind("Palavra2") %>' Width="80" MaxLength="20" /><strong>.</strong><asp:TextBox ID="Palavra3TextBox" runat="server" Text='<%# Bind("Palavra3") %>' Width="80" MaxLength="20" />&nbsp;<button id="btnLocalizacao" onclick="getLocalizacao()" type="button" value="Localização Actual" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" style="padding: 2px 4px;font-size: 11px; margin-bottom: 1px;">Localização Actual</button>
                                   
                                </td>
                            </tr>
                             
                            <tr>
                                <td>Nome Sócio:</td>
                                <td>
                                    <asp:TextBox ID="BITextBox" runat="server" Text='<%# Bind("BI") %>' Width="398" MaxLength="400" />
                                </td>
                            </tr>
                            <tr>
                                <td>Data de Criação:</td>
                                <td><asp:TextBox ID="DataEmissaoTextBox"  ValidationGroup="Form" runat="server" Text='<%# Bind("DataEmissao", "{0:dd/MM/yyyy}")%>'  Width ="80" MaxLength="10" />&nbsp;<a class="linkData" name="A_DataEmissaoTextBox" id="ADataEmissaoTextBox" href="#" onclick="cal.select(document.forms[0].ctl00$MainContent$FormView1$DataEmissaoTextBox,'ADataEmissaoTextBox','dd/MM/yyyy'); return false;"><img style="vertical-align:middle;border:0 "  alt="" onclick=""  src ="images/31.png"/></a><asp:RequiredFieldValidator ValidationGroup="Form" ID="RequiredFieldValidator12" Display="Dynamic" runat="server" Text="*"  ControlToValidate="DataEmissaoTextBox"  class="erro"  ToolTip="">&nbsp;&otimes;</asp:RequiredFieldValidator><asp:CompareValidator ID="CompareValidator1"  Operator="DataTypeCheck"  ControlToValidate="DataEmissaoTextBox" runat="server"  Type="Date"  Display="Dynamic" class="erro">&nbsp;Formato incorrecto</asp:CompareValidator>
                                </td>
                            </tr>

                             <tr>
                                <td>Telefone Fixo:</td>
                                <td>
                                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Telemovel") %>' Width="200" MaxLength="400" />
                                </td>
                            </tr>
                            
                            <tr>
                                <td>Telemóvel:</td>
                                <td>
                                    <asp:TextBox ID="TelemovelTextBox" runat="server" Text='<%# Bind("Telemovel") %>' Width="200" MaxLength="400" />
                                </td>
                            </tr>
                            <tr>
                                <td>E-mail:</td>
                                <td>
                                    <asp:TextBox ID="EmailTextBox" runat="server" Text='<%# Bind("Email") %>' Width="200" MaxLength="400" />
                                </td>
                            </tr>
                          
                            <tr>
                                <td>NIF:</td>
                                <td>
                                    <asp:TextBox ID="NIFTextBox" runat="server" Text='<%# Bind("NIF") %>' Width="200" MaxLength="400" /> 
                                </td>
                            </tr>
                            <tr><td><br /><h3>Documentos</h3></td></tr>
                             <tr>
                                <td>NIF:</td>
                                <td>
                                    <asp:FileUpload ID="MediaUpload" Visible="false" runat="server" Width="200" CssClass="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" style="width: 400px;padding:0px 0px;border:0px"/><button id="VerDoc1" onclick="getLocalizacao()" type="button" value="Localização Actual" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" style="padding: 2px 4px;font-size: 11px; margin-bottom: 1px;">Ver Documento</button>&nbsp;<button id="btnLocalizacaoa" onclick="getLocalizacao()" type="button" value="Localização Actual" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" style="padding: 2px 4px;font-size: 11px; margin-bottom: 1px;">Remover Documento</button>
                                </td>
                            </tr>
                            <tr>
                                <td>Estatutos:</td>
                                <td>
                                    <asp:FileUpload ID="EstatutoUpload" Visible="false" runat="server" Width="200" CssClass="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" style="width: 400px;padding:0px 0px;border:0px"/><button id="VerDoc1" onclick="getLocalizacao()" type="button" value="Localização Actual" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" style="padding: 2px 4px;font-size: 11px; margin-bottom: 1px;">Ver Documento</button>&nbsp;<button id="btnLocalizacaoa" onclick="getLocalizacao()" type="button" value="Localização Actual" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" style="padding: 2px 4px;font-size: 11px; margin-bottom: 1px;">Remover Documento</button>
                                </td>
                            </tr>
                             <tr>
                                <td>Certidão Comercial:</td>
                                <td>
                                    <asp:FileUpload ID="FileUpload1" Visible="false" runat="server" Width="200" CssClass="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" style="width: 400px;padding:0px 0px;border:0px"/><button id="VerDoc1" onclick="getLocalizacao()" type="button" value="Localização Actual" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" style="padding: 2px 4px;font-size: 11px; margin-bottom: 1px;">Ver Documento</button>&nbsp;<button id="btnLocalizacaoa" onclick="getLocalizacao()" type="button" value="Localização Actual" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" style="padding: 2px 4px;font-size: 11px; margin-bottom: 1px;">Remover Documento</button>
                                </td>
                            </tr>
                            <tr>
                                <td>Diário República:</td>
                                <td>
                                    <asp:FileUpload ID="FileUpload2" Visible="false" runat="server" Width="200" CssClass="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" style="width: 400px;padding:0px 0px;border:0px"/><button id="VerDoc1" onclick="getLocalizacao()" type="button" value="Localização Actual" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" style="padding: 2px 4px;font-size: 11px; margin-bottom: 1px;">Ver Documento</button>&nbsp;<button id="btnLocalizacaoa" onclick="getLocalizacao()" type="button" value="Localização Actual" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" style="padding: 2px 4px;font-size: 11px; margin-bottom: 1px;">Remover Documento</button>
                                </td>
                            </tr>
                               <tr>
                                <td>Observações:</td>
                                <td>
                                    <asp:TextBox ID="txtObs" TextMode="MultiLine" Visible="false" runat="server" Rows="3" Columns="80"></asp:TextBox>
                                </td>
                            </tr>
                           
                            
            </table>
                     </td>
                
                    <td style="vertical-align:top">
                         
                         <table border="0" cellpadding="2" cellspacing="0"  style="width:100%;border-collapse:collapse;font-size: 13px;">
                            <tr><td><h3>Pontos de Correspondência</h3></td></tr>
                             <tr>
                                <td>Nome:</td>
                                <td>
                                    <asp:TextBox ID="NomeConjugeTextBox" runat="server" Text='<%# Bind("NomeConjuge") %>' Width="398" MaxLength="400" />
                                    &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator14" ValidationGroup="Form" Display="Dynamic" runat="server" Text="*" ControlToValidate="NomeConjugeTextBox" class="erro" ToolTip="" SetFocusOnError="true">&otimes;</asp:RequiredFieldValidator>
                                </td>
                            </tr>
                             <tr>
                                <td>Morada:</td>
                                <td>
                                    <asp:TextBox ID="TextBox10" runat="server" Text='<%# Bind("NomeConjuge") %>' Width="398" MaxLength="400" />
                                </td>
                            </tr>
                            <tr>
                                <td>Província:</td>
                                <td>
                                    <asp:DropDownList runat="server"  ID="ProvinciaMoradaIDComboBox" AutoPostBack ="false"  Width="200px"  DataSourceID="SqlDataSourceProvincia"   DataValueField="ProvinciaId"  DataTextField="Nome" AppendDataBoundItems="true"  onchange="javascript:SetURL(this)" >
                                        
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td>Município:</td>
                                <td>
                                    <asp:DropDownList runat="server"  ID="MunicipioMoradaIDComboBox" AutoPostBack ="false"   Width="200px"   AppendDataBoundItems="true"   DataSourceID="SqlDataSourceMunicipio"   DataValueField="MunicipioId"  DataTextField="Nome"  onchange="javascript:SetURL(this)" >
                                        
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td>Comuna:</td>
                                <td>
                                    <asp:DropDownList runat="server"  ID="ComunaMoradaIDComboBox" AutoPostBack ="false"   Width="200px"   AppendDataBoundItems="true"   DataSourceID="SqlDataSourceComuna"   DataValueField="ComunaId"  DataTextField="Nome"  >
                                       
                                    </asp:DropDownList>
                                </td>
                            </tr>
                             <tr>
                                <td>Código 3 Palavras:</td>
                                <td>
                                    <asp:TextBox ID="TextBox7" runat="server" Text='<%# Bind("Palavra1") %>' Width="80" MaxLength="20" /><strong>.</strong><asp:TextBox ID="TextBox8" runat="server" Text='<%# Bind("Palavra2") %>' Width="80" MaxLength="20" /><strong>.</strong><asp:TextBox ID="TextBox9" runat="server" Text='<%# Bind("Palavra3") %>' Width="80" MaxLength="20" />&nbsp;<button id="btnLocalizacaoa" onclick="getLocalizacao()" type="button" value="Localização Actual" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" style="padding: 2px 4px;font-size: 11px; margin-bottom: 1px;">Localização Actual</button>
                                   
                                </td>
                            </tr>
                             <tr>
                                <td>Telefone Fixo:</td>
                                <td>
                                    <asp:TextBox ID="TextBox2" runat="server" Text='' Width="200" MaxLength="400" />
                                </td>
                            </tr>
                             <tr>
                                <td>Telemóvel:</td>
                                <td>
                                    <asp:TextBox ID="TelemovelConjugeTextBox" runat="server" Text='' Width="200" MaxLength="400" />
                                </td>
                            </tr>
                            <tr>
                                <td>E-mail:</td>
                                <td>
                                    <asp:TextBox ID="EmailConjugeTextBox" runat="server" Text='' Width="200" MaxLength="400" />
                                </td>
                            </tr>
                             <tr>
                                 <td colspan="2"><br /><asp:Button ID="Button1" ValidationGroup="Form" CssClass="ui-button2 ui-widget ui-state-default ui-corner-all ui-button-text-only" runat="server" Text="Adicionar" CommandName="Insert" CausesValidation="True"  /></td>
                             </tr>
                    </table>
                </td>
            </tr>
             <tr>
                <td colspan="2">
                <hr />
                </td>
            </tr>
        </table>

            <asp:Button ID="BackButton" ValidationGroup="Form" CssClass="ui-button2 ui-widget ui-state-default ui-corner-all ui-button-text-only" runat="server" Text="Voltar"  CausesValidation="True" OnClientClick="history.back(-1);" />
            <asp:Button ID="ValidateButton" Visible="false" ValidationGroup="Form" CssClass="ui-button2 ui-widget ui-state-default ui-corner-all ui-button-text-only" runat="server" Text="Aprovar"  CausesValidation="True"  />
            <asp:Button ID="ReproveButton" Visible="false" ValidationGroup="Form" CssClass="ui-button2 ui-widget ui-state-default ui-corner-all ui-button-text-only" runat="server" Text="Reprovar"  CausesValidation="True"  />
            <asp:Button ID="UpdateButton" ValidationGroup="Form" CssClass="ui-button2 ui-widget ui-state-default ui-corner-all ui-button-text-only" runat="server" Text="Guardar" CommandName="Update" CausesValidation ="True"  />

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
        <b>Ocorreu um erro a gravar os dados.<br />Comunique ao administrador de sistemas.</b>
    </div>

    <div id="dialog-form" title="CTT" style="display: none">
       <b>Comités de Acção Política:</b>
 <table id="users" class="ui-widget ui-widget-content">
	
     <asp:GridView ID="gridviewCAP" runat="server"
        AllowPaging="False" AllowSorting="False" AutoGenerateColumns="False"
        CellPadding="4" DataKeyNames="" DataSourceID=""
        PagerSettings-PageButtonCount="15" PageSize="15"
        HeaderStyle-CssClass="SGCRowHeader"
        AlternatingRowStyle-CssClass="SGCdadosBodyAlt"
        RowStyle-CssClass="SGCdadosBodyNorm" >
        <AlternatingRowStyle BackColor="White" />
        <Columns>

             <asp:BoundField DataField="CAPID" HeaderText="ID" 
            SortExpression="CAPID"  ItemStyle-HorizontalAlign="Right"/>

            <asp:BoundField DataField="Numero" HeaderText="Número" 
            SortExpression="Numero"  ItemStyle-HorizontalAlign="Right"/>
            
            <asp:BoundField DataField="Nome" ItemStyle-Width="150px" HeaderText="Nome" 
            SortExpression="Nome"  ItemStyle-HorizontalAlign="Left" />

            <asp:BoundField DataField="NomeProvincia" ItemStyle-Width="75px" HeaderText="Província" 
            SortExpression="NomeProvincia"  ItemStyle-HorizontalAlign="Left" />
      
            <asp:BoundField DataField="NomeMunicipio" ItemStyle-Width="75px" HeaderText="Município" 
            SortExpression="NomeMunicipio"  ItemStyle-HorizontalAlign="Left" />

            <asp:BoundField DataField="NomeComuna" ItemStyle-Width="75px" HeaderText="Comuna" 
            SortExpression="Comuna"  ItemStyle-HorizontalAlign="Left" />


          <asp:TemplateField HeaderText="Operações"  ItemStyle-HorizontalAlign="Left">
                <ItemTemplate>
                    <asp:LinkButton ID="lnkSelClassificador" runat="server" Text='Seleccionar'  OnClientClick='<%# Eval("CAPID", "SelClassificador(\"{0}\");") %>'></asp:LinkButton>
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

    <div id="dialog-Media"  title="CTT" style="display: none">
        <asp:Image runat="server" ID="imgVerMedia" />
    </div>

<asp:SqlDataSource ID="SqlDataSourceCTTPopUp" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" 
        SelectCommand="SELECT cap.CAPID, cap.Numero, cap.Nome, p.ProvinciaId, p.Nome as NomeProvincia, m.MunicipioId,m.Nome as NomeMunicipio, c.ComunaId, c.Nome as NomeComuna FROM [dbo].[mpla_cap] cap 
        INNER JOIN [dbo].[master_provincia] p ON cap.ProvinciaID = p.ProvinciaId
        INNER JOIN [dbo].[master_municipio] m on cap.MunicipioID= m.MunicipioId
        INNER JOIN [dbo].[master_comuna] c ON cap.ComunaId = c.ComunaId">
</asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceCTT"  OnInserted="On_Inserted" OnUpdated="On_Updated"  OnInserting ="SqlDataSourceCTT_Inserting" OnUpdating="On_Updating" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" 
        DeleteCommand="DELETE FROM [sige_cliente] WHERE [MilitanteID] = @MilitanteID" 
        InsertCommand="INSERT INTO [sige_cliente] ([CAPID], [ProvinciaID], [MunicipioID], [ComunaID],[Palavra1],[Palavra2],[Palavra3], [Nome], [Pseudonino], [NomePai], [NomeMae], [DataNascimento], [LocalNascimento], [ProvinciaNascID], [MunicipioNascID], [ComunaNascID], [BI], [DataEmissao], [Arquivo], [NomeEmpresa], [MoradaEmpresa], [TelefoneEmpresa], [Profissao], [Funcao], [HabilitacoesID], [EstadoCivilID], [NomeConjuge], [Morada], [ProvinciaMoradaID], [MunicipioMoradaID], [ComunaMoradaID], [Telemovel], [Email], [NIF], [NumeroEleitor], [GrupoEleitor] , [Foto], [RecomendacaoNomeMilitante1], [RecomendacaoComiteAccao1], [RecomendacaoAnosMilitancia1], [RecomendacaoConheceReq1], [RecomendacaoNomeMilitante2], [RecomendacaoComiteAccao2], [RecomendacaoAnosMilitancia2], [RecomendacaoConheceReq2], [ConfirmacaoNomeMilitante], [ConfirmacaoAtribuicao], [UserIDCriacao], [DataCriacao], [UserIDActualizacao], [DataActualizacao], [Estado]) VALUES (@CAPID,  @ProvinciaID, @MunicipioID, @ComunaID, @Palavra1, @Palavra2, @Palavra3, @Nome, @Pseudonino, @NomePai, @NomeMae, @DataNascimento, @LocalNascimento, @ProvinciaNascID, @MunicipioNascID, @ComunaNascID, @BI, @DataEmissao, @Arquivo, @NomeEmpresa, @MoradaEmpresa, @TelefoneEmpresa, @Profissao, @Funcao, @HabilitacoesID, @EstadoCivilID, @NomeConjuge, @Morada, @ProvinciaMoradaID, @MunicipioMoradaID, @ComunaMoradaID, @Telemovel, @Email, @NIF, @NumeroEleitor, @GrupoEleitor, @Foto, @RecomendacaoNomeMilitante1, @RecomendacaoComiteAccao1, @RecomendacaoAnosMilitancia1, @RecomendacaoConheceReq1, @RecomendacaoNomeMilitante2, @RecomendacaoComiteAccao2, @RecomendacaoAnosMilitancia2, @RecomendacaoConheceReq2, @ConfirmacaoNomeMilitante, @ConfirmacaoAtribuicao, @UserIDCriacao, @DataCriacao, @UserIDActualizacao, @DataActualizacao, @Estado)" 
        SelectCommand="SELECT * FROM [sige_cliente] WHERE [MilitanteID] = @MilitanteID"  
        UpdateCommand="UPDATE [sige_cliente] SET [CAPID] = @CAPID, [Nome] = @Nome, [Pseudonino] = @Pseudonino, [NomePai] = @NomePai, [NomeMae] = @NomeMae, [DataNascimento] = @DataNascimento, [LocalNascimento] = @LocalNascimento, [ProvinciaNascID] = @ProvinciaNascID, [MunicipioNascID] = @MunicipioNascID, [ComunaNascID] = @ComunaNascID, [BI] = @BI, [DataEmissao] = @DataEmissao, [Arquivo] = @Arquivo, [NomeEmpresa] = @NomeEmpresa, [MoradaEmpresa] = @MoradaEmpresa, [TelefoneEmpresa] = @TelefoneEmpresa, [Profissao] = @Profissao, [Funcao] = @Funcao, [HabilitacoesID] = @HabilitacoesID, [EstadoCivilID] = @EstadoCivilID, [NomeConjuge] = @NomeConjuge, [Morada] = @Morada, [ProvinciaMoradaID] = @ProvinciaMoradaID, [MunicipioMoradaID] = @MunicipioMoradaID, [ComunaMoradaID] = @ComunaMoradaID, [Telemovel] = @Telemovel, [Email] = @Email, [NIF] = @NIF, [NumeroEleitor] = @NumeroEleitor, [GrupoEleitor] = @GrupoEleitor, [RecomendacaoNomeMilitante1] = @RecomendacaoNomeMilitante1, [RecomendacaoComiteAccao1] = @RecomendacaoComiteAccao1, [RecomendacaoAnosMilitancia1] = @RecomendacaoAnosMilitancia1, [RecomendacaoConheceReq1] = @RecomendacaoConheceReq1, [RecomendacaoNomeMilitante2] = @RecomendacaoNomeMilitante2, [RecomendacaoComiteAccao2] = @RecomendacaoComiteAccao2, [RecomendacaoAnosMilitancia2] = @RecomendacaoAnosMilitancia2, [RecomendacaoConheceReq2] = @RecomendacaoConheceReq2, [ConfirmacaoNomeMilitante] = @ConfirmacaoNomeMilitante, [ConfirmacaoAtribuicao] = @ConfirmacaoAtribuicao, [UserIDCriacao] = @UserIDCriacao, [DataCriacao] = @DataCriacao, [UserIDActualizacao] = @UserIDActualizacao, [DataActualizacao] = @DataActualizacao, [Estado] = @Estado WHERE [MilitanteID] = @MilitanteID">
        
        <InsertParameters>
            <asp:Parameter Name="CAPID" Type="Int32" />
            <asp:ControlParameter ControlID="ctl00$MainContent$FormView1$ProvinciaIDComboBox" PropertyName="SelectedValue" Name="ProvinciaID"  Type="Int32" DefaultValue="0" />
            <asp:ControlParameter ControlID="ctl00$MainContent$FormView1$MunicipioIDComboBox" PropertyName="SelectedValue" Name="MunicipioID"  Type="Int32" DefaultValue="0" />
            <asp:ControlParameter ControlID="ctl00$MainContent$FormView1$ComunaIDComboBox" PropertyName="SelectedValue" Name="ComunaID"  Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="Nome" Type="String" />
            <asp:Parameter Name="Palavra1" Type="String" />
            <asp:Parameter Name="Palavra2" Type="String" />
            <asp:Parameter Name="Palavra3" Type="String" />
            <asp:Parameter Name="Pseudonino" Type="String" />
            <asp:Parameter Name="NomePai" Type="String" />
            <asp:Parameter Name="NomeMae" Type="String" />
            <asp:Parameter Name="DataNascimento" Type="DateTime" />
            <asp:Parameter Name="LocalNascimento" Type="String" />
            <asp:ControlParameter ControlID="ctl00$MainContent$FormView1$ProvinciaNascIDComboBox" PropertyName="SelectedValue" Name="ProvinciaNascID"  Type="Int32" DefaultValue="0" />
            <asp:ControlParameter ControlID="ctl00$MainContent$FormView1$MunicipioNascIDComboBox" PropertyName="SelectedValue" Name="MunicipioNascID"  Type="Int32" DefaultValue="0" />
            <asp:ControlParameter ControlID="ctl00$MainContent$FormView1$ComunaNascIDComboBox" PropertyName="SelectedValue" Name="ComunaNascID"  Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="BI" Type="String" />
            <asp:Parameter Name="DataEmissao" Type="DateTime" />
            <asp:Parameter Name="Arquivo" Type="String" />
            <asp:Parameter Name="NomeEmpresa" Type="String" />
            <asp:Parameter Name="MoradaEmpresa" Type="String" />
            <asp:Parameter Name="TelefoneEmpresa" Type="String" />
            <asp:Parameter Name="Profissao" Type="String" />
            <asp:Parameter Name="Funcao" Type="String" />
            <asp:ControlParameter ControlID="ctl00$MainContent$FormView1$HabilitacoesIDComboBox" PropertyName="SelectedValue" Name="HabilitacoesID"  Type="Int32" DefaultValue="0" />
            <asp:ControlParameter ControlID="ctl00$MainContent$FormView1$EstadoCivilIDComboBox" PropertyName="SelectedValue" Name="EstadoCivilID"  Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="NomeConjuge" Type="String" />
            <asp:Parameter Name="Morada" Type="String" />
            <asp:ControlParameter ControlID="ctl00$MainContent$FormView1$ProvinciaMoradaIDComboBox" PropertyName="SelectedValue" Name="ProvinciaMoradaID"  Type="Int32" DefaultValue="0" />
            <asp:ControlParameter ControlID="ctl00$MainContent$FormView1$MunicipioMoradaIDComboBox" PropertyName="SelectedValue" Name="MunicipioMoradaID"  Type="Int32" DefaultValue="0" />
            <asp:ControlParameter ControlID="ctl00$MainContent$FormView1$ComunaMoradaIDComboBox" PropertyName="SelectedValue" Name="ComunaMoradaID"  Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="Telemovel" Type="String" />
            <asp:Parameter Name="Email" Type="String" />
            <asp:Parameter Name="NIF" Type="String" />
            <asp:Parameter Name="NumeroEleitor" Type="String" />
            <asp:Parameter Name="GrupoEleitor" Type="String" />
            <asp:Parameter Name="Foto" Type="String" />
            <asp:Parameter Name="RecomendacaoNomeMilitante1" Type="String" />
            <asp:Parameter Name="RecomendacaoComiteAccao1" Type="Int32" />
            <asp:Parameter Name="RecomendacaoAnosMilitancia1" Type="Int32" />
            <asp:Parameter Name="RecomendacaoConheceReq1"  Type="Int32" DefaultValue="" />
            <asp:Parameter Name="RecomendacaoNomeMilitante2" Type="String" />
            <asp:Parameter Name="RecomendacaoComiteAccao2" Type="Int32" />
            <asp:Parameter Name="RecomendacaoAnosMilitancia2" Type="Int32" />
            <asp:Parameter Name="RecomendacaoConheceReq2"  Type="Int32" DefaultValue="" />
            <asp:Parameter Name="ConfirmacaoNomeMilitante" Type="String" />
            <asp:Parameter Name="ConfirmacaoAtribuicao" Type="DateTime" />
            <asp:Parameter Name="UserIDCriacao" Type="String" />
            <asp:Parameter Name="DataCriacao" Type="DateTime" />
            <asp:Parameter Name="UserIDActualizacao" Type="String" />
            <asp:Parameter Name="DataActualizacao" Type="DateTime" />
            <asp:Parameter Name="Estado"  Type="Int32" DefaultValue="1" />
        </InsertParameters>
         <SelectParameters>
           <asp:Parameter Name="MilitanteID" Type="Int32" />
       </SelectParameters>
       
    </asp:SqlDataSource>


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
   
   <asp:SqlDataSource ID="SqlDataSourceProvincia" runat="server"
        ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"
        SelectCommand="SELECT * FROM [master_provincia] ORDER BY NOME "></asp:SqlDataSource>

   <asp:SqlDataSource ID="SqlDataSourceMunicipio" runat="server"
        ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"
        SelectCommand="SELECT * FROM [master_municipio] ORDER BY NOME"></asp:SqlDataSource>

   <asp:SqlDataSource ID="SqlDataSourceComuna" runat="server"
        ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"
        SelectCommand="SELECT * FROM [master_comuna] ORDER BY NOME"></asp:SqlDataSource>

  

   <script type="text/javascript">
       $(function () {
           var icons = {
               header: "ui-icon-circle-arrow-e",
               activeHeader: "ui-icon-circle-arrow-s"
           };
           $("#accordion").accordion({
               icons: icons
           });
           $("#accordion").accordion({
               heightStyle: "content"
           });
       });

       function SetAcordion() {
           var icons = {
               header: "ui-icon-circle-arrow-e",
               activeHeader: "ui-icon-circle-arrow-s"
           };
           $("#accordion").accordion({
               icons: icons
           });
           
           $("#accordion").accordion({
               active: 1
           });
           
       }
      
       function getLocalizacao() {
             navigator.geolocation.getCurrentPosition(function (location) {
               data = {
                   'key': '5GEZ5L3C',
                   'position': location.coords.latitude + ',' + location.coords.longitude,
                   'lang':'PT'
               };
               //alert(location.coords.latitude);
               //alert(location.coords.longitude);
              
                   $.post('http://api.what3words.com/position', data, function (response) {
                   ctl00_MainContent_FormView1_Palavra1TextBox.value = response.words[0];
                   ctl00_MainContent_FormView1_Palavra2TextBox.value = response.words[1];
                   ctl00_MainContent_FormView1_Palavra3TextBox.value = response.words[2];
               });
           });
       };

       function get3Palavras() {
           //var product =
           // JSON.stringify({
           //     key: '5GEZ5L3C',
           //     position: '-8.839987599999999,13.289436799999999'
           // });

           //        $.ajax({
           //            URL: 'https://api.what3words.com/position',
           //            type: 'POST',
           //            contentType: 'application/json',
           //            dataType: 'json',
           //            data: product,
           //            success: function (data, status, xhr) {
           //                alert('Success!');
           //            },
           //            error: function (xhr, status, error) {
           //        alert('Update Error occurred - ' + error);
           //    }
           //});
       }

       function ConfirmVerMedia() {
          $("#dialog-Media").dialog({
               title: "CTT",
               autoOpen: true,
               resizable: true,
               height: 500,
               width: 550,
               modal: true,
               buttons: {
                   "Fechar": function () {
                       $(this).dialog("close");
                       return false;
                   }
               }
           });
           return false;
       }


       function SelClassificador(value) {
         
       }

        function ConfirmInsereClassificador() {
            $("#dialog-confirmInsereClassificador").dialog({
                title: "CTT",
                resizable: false,
                width: 430,
                height: 200,
                modal: true,
                buttons: {
                    "Sim": function () {
                        <%= this.FormView1.CurrentMode == FormViewMode.Insert ? this.Page.ClientScript.GetPostBackEventReference(new PostBackOptions(this.FormView1.FindControl("InsertButton"))): "" %>;
                     },
                     "Não": function () {
                         $(this).dialog("close");
                         return false;
                     }
                 }

             });
             return false;
         }

         function confirmActualizarClassificador(refString) {
             $("#dialog-confirmActualizarClassificador").dialog({
                 title: "CTT",
                 resizable: false,
                 width: 430,
                 height: 200,
                 modal: true,
                 buttons: {
                     "Sim": function () {
                         <%= this.FormView1.CurrentMode == FormViewMode.Edit ? this.Page.ClientScript.GetPostBackEventReference(new PostBackOptions(this.FormView1.FindControl("UpdateButton"),"Update")): "" %>;

                     },
                     "Não": function () {
                         $(this).dialog("close");
                         return false;
                     }
                 }

             });
             return false;
         }

       function MessageBoxCAPActualizado(refString) {
           $("#dialog-ClassificadorActualizado").dialog({
                 title: "CTT",
                 resizable: false,
                 width: 430,
                 height: 200,
                 modal: true,
                 buttons: {
                     "OK": function () {
                         document.location = "PesquisaCAP.aspx?";
                         $(this).dialog("close");
                         return true;
                     }
                 }

             });
             return false;
         }

         function MessageBoxCAPCriado(refString) {
             $("#dialog-MilitanteCriado").dialog({
                 title: "CTT",
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
             $("#dialog-RelatorioErroGravar").dialog({
                 title: "CTT",
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

        function ClearFileUpload() {
            
        }
</script>
           
</asp:Content>
