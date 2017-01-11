<%@ Page Title="Pagamento de Apólice"  Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="RegistaPagamento.aspx.cs" Inherits="MASTERSEGUROS.WEB.RegistaPagamento"  %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
  
<asp:ScriptManager ID="ScriptManager1" runat="server" EnablePartialRendering="true" EnableCdn="true"/>
  
    <asp:FormView ID="FormView1" runat="server"   Width="100%" DataKeyNames="PropostaID" DataSourceID="SqlDataSourceAvisoCobrancaPagamento" DefaultMode="Insert" >

        <InsertItemTemplate>
            
             <table border="0" cellpadding="0" cellspacing="0" width="100%">
                 <tr>
                     <td colspan="2">
                          <div id="accordion">
                              <h3>Pagamento | Aviso de Cobrança : <%=Request.QueryString["nravc"].ToString() %> | Apólice : <%=Request.QueryString["nrapl"].ToString() %></h3>
                              <div>
                             <table border="0" cellpadding="0" cellspacing="0"   style="width:100%;border-collapse:collapse;font-size: 13px;">
                                <tr>
                                    <td style="width:90px">Nome : </td>
                                    <td>
                                        <asp:TextBox ID="NomeTextBox" Text='<%#Bind("Nome") %>'  runat="server" Width="300" MaxLength="150" />
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width:160px">Doc. Identificação: </td>
                                    <td>
                                        <asp:DropDownList runat="server" ID="DocIdentificacaoIDComboBox"  Width="175px">
                                            <asp:ListItem Text="BI" Value="1"></asp:ListItem>
                                            <asp:ListItem Text="Passaporte" Value="2"></asp:ListItem>
                                            <asp:ListItem Text="Residência" Value="3"></asp:ListItem>
                                            <asp:ListItem Text="Carta de Condução" Value="4"></asp:ListItem>
                                            <asp:ListItem Text="Outro" Value="5"></asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width:90px">Número Doc.: </td>
                                    <td>
                                        <asp:TextBox ID="NumeroDocumentoTextBox" Text='<%#Bind("NumeroDocumento") %>'  runat="server" Width="171" MaxLength="50" />
                                    </td>
                                </tr>
                                 <tr>
                                    <td style="width:120px">Data de Validade: </td>
                                    <td>
                                        <asp:TextBox ID="DataValidadeTextBox" Text='<%#Bind("DataValidade") %>'  runat="server"  Width="75" MaxLength="10"  /><img alt="Data de Início" src="images/31.png" style="vertical-align:text-bottom" />
                                        <asp:RangeValidator ID="RngValDataValidadeTextBox"   ValidationGroup="Form" Display="Dynamic" runat="server" Type="Date" ControlToValidate="DataValidadeTextBox" MaximumValue="01-01-2100"  MinimumValue="01-01-1900"  ToolTip="" SetFocusOnError="true">&otimes;</asp:RangeValidator>
                                    </td>
                                </tr>
                                 <tr>
                                    <td style="width:150px">Forma de Pagamento: <img alt="" style="vertical-align:middle" src="img/yes.png" /></td>
                                    <td>
                                        <asp:DropDownList runat="server" ID="FormaPagamentoIDComboBox"  Width="175px">
                                            <asp:ListItem Text="Seleccione um opção" Value=""></asp:ListItem>
                                            <asp:ListItem Text="Transferência Bancária" Value="1"></asp:ListItem>
                                            <asp:ListItem Text="Multicaixa" Value="2"></asp:ListItem>
                                            <asp:ListItem Text="Depósito Bancário" Value="3"></asp:ListItem>
                                            <asp:ListItem Text="Numerário" Value="4"></asp:ListItem>
                                            <asp:ListItem Text="Outro" Value="5"></asp:ListItem>
                                        </asp:DropDownList>
                                        &nbsp;<asp:RequiredFieldValidator ID="ReqValFormaPagamentoIDComboBox" ValidationGroup="Form" Display="Dynamic" runat="server" Text="*" ControlToValidate="FormaPagamentoIDComboBox"  ToolTip="" SetFocusOnError="true">&otimes;</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Nº Doc. (Primavera): <img alt="" style="vertical-align:middle" src="img/yes.png" /></td>
                                    <td>
                                        <asp:TextBox ID="NumeroDocSistemaTextBox" Text='<%#Bind("NumeroDocSistema") %>'  runat="server"  Width="90" MaxLength="90" />
                                        &nbsp;<asp:RequiredFieldValidator ID="ReqValNumeroDocSistemaTextbox" ValidationGroup="Form" Display="Dynamic" runat="server" Text="*" ControlToValidate="NumeroDocSistemaTextBox"  ToolTip="" SetFocusOnError="true">&otimes;</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                    

                                 <tr>
                                    <td>Observações: </td>
                                    <td>
                                        <asp:TextBox ID="ObservacoesTextBox"  Text='<%#Bind("Observacoes") %>'  TextMode="MultiLine" Rows="3"  Columns="10" runat="server"  Width="400" MaxLength="400" />
                                    </td>
                                </tr>
                                
                             </table>
                                  </div>
                        </div> 
                     </td>
                </tr>
                <tr>
                    <td colspan="2">&nbsp;</td>
                </tr>
        </table>
           
            <asp:Button ID="Validar" ValidationGroup="Form" CssClass="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" runat="server" Text="Gravar" CommandName="Insert" CausesValidation ="True"  />
        </InsertItemTemplate>

       
    </asp:FormView>

    
            
    <div id="dialog-ErroGravar" title="Master Seguros" style="display: none">
        <br />
        Ocorreu um erro a gravar os dados.<br />Comunique ao administrador de sistemas.
    </div> 
    <div id="dialog-SucessoGravar" title="Master Seguros" style="display: none">
        <br />
        O pagamento foi validado com sucesso.<br />
        Clique em "OK" para imprimir o <strong>Recibo</strong>.
    </div>      
   
   <asp:SqlDataSource ID="SqlDataSourceAvisoCobrancaPagamento" OnInserted="SqlDataSourceAvisoCobrancaPagamento_Inserted" OnInserting="SqlDataSourceAvisoCobrancaPagamento_Inserting"  runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" 
        DeleteCommand="DELETE FROM [master_apolice_pagamento] WHERE [PagamentoID] = @PropostaID" 
        InsertCommand="INSERT INTO [master_apolice_pagamento] ([ApoliceID],[ApoliceAvisoCobrancaID], [Nome], [DocIdentificacaoID], [NumeroDocumento], [DataValidade], [FormaPagamentoID], [NumeroDocSistema], [Observacoes], [UserIDCriacao], [DataCriacao], [UserIDActualizacao],[DataActualizacao]) VALUES (@ApoliceID,@ApoliceAvisoCobrancaID, @Nome, @DocIdentificacaoID, @NumeroDocumento, @DataValidade, @FormaPagamentoID, @NumeroDocSistema, @Observacoes, @UserIDCriacao, @DataCriacao, @UserIDActualizacao,@DataActualizacao);" 
        SelectCommand="SELECT * FROM [master_apolice_pagamento] WHERE [PagamentoID] = @PagamentoID" >
        <InsertParameters>
            <asp:Parameter Name="ApoliceID" Type="Int32" />
            <asp:Parameter Name="ApoliceAvisoCobrancaID" Type="Int32" />
            <asp:Parameter Name="Nome" Type="String" />
            <asp:ControlParameter ControlID="ctl00$MainContent$FormView1$DocIdentificacaoIDComboBox" PropertyName="SelectedValue" Name="DocIdentificacaoID"  Type="Int32" />
            <asp:Parameter Name="NumeroDocumento" Type="String" />
            <asp:Parameter Name="DataValidade" Type="DateTime" />
            <asp:ControlParameter ControlID="ctl00$MainContent$FormView1$FormaPagamentoIDComboBox" PropertyName="SelectedValue" Name="FormaPagamentoID"  Type="Int32" />
            <asp:Parameter Name="NumeroDocSistema" Type="String" />
            <asp:Parameter Name="Observacoes" Type="String" />
            <asp:Parameter Name="UserIDCriacao" Type="String" />
            <asp:Parameter Name="DataCriacao" Type="DateTime" />
            <asp:Parameter Name="UserIDActualizacao" Type="String" />
            <asp:Parameter Name="DataActualizacao" Type="DateTime" />
        </InsertParameters>
         <SelectParameters>
           <asp:Parameter Name="PagamentoID" Type="Int32" />
       </SelectParameters>
       
    </asp:SqlDataSource>

   <asp:SqlDataSource ID="SqlDataSourceCategoria" runat="server"
        ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"
        SelectCommand="SELECT [CategoriaID], [Descricao], [Valor], [Ocupantes], [DanosProprios] FROM [master_categoria]">
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

     
           $("#ctl00_MainContent_FormView1_DataValidadeTextBox").datepicker();
           $("#ctl00_MainContent_FormView1_DataValidadeTextBox").datepicker("option", "dateFormat", "dd/mm/yy");
       }

       
      
       function MessageBoxSucessoGravar(ApoliceID, avcID) {
           $("#dialog-SucessoGravar").dialog({
               title: "MASTER SEGUROS",
               resizable: false,
               width: 430,
               height: 200,
               modal: true,
               buttons: {
                   "OK": function () {
                       window.open('AutoDocument.aspx?docID=2&aplID=' + ApoliceID + '&avcID=' + avcID, 'Recibo');
                       document.location = "PesquisaPagamentos.aspx";
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
