<%@ Page Title="Registar Documento"  Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="RegistaDocumento.aspx.cs" Inherits="MASTERSEGUROS.WEB.RegistaDocumento"  %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
  
<asp:ScriptManager ID="ScriptManager1" runat="server" EnablePartialRendering="true" EnableCdn="true"/>
  
    <asp:FormView ID="FormView1" runat="server"   Width="100%" DataKeyNames="DocumentoID" DataSourceID="SqlDataSourceDocumento" DefaultMode="Insert" >

        <InsertItemTemplate>
            
             <table border="0" cellpadding="0" cellspacing="0" width="100%">
                 <tr>
                     <td colspan="2">
                          <div id="accordion">
                              <h3>Documentos</h3>
                              <div>
                                  <asp:UpdatePanel ID="UpdatePanel1" runat="server"  updatemode="Conditional" > 
                              <ContentTemplate>
                             <table border="0" cellpadding="0" cellspacing="0"   style="width:100%;border-collapse:collapse;font-size: 13px;">
                                <tr>
                                    <td style="width:160px">Tipo de Processo: </td>
                                    <td>
                                        <asp:DropDownList runat="server" ID="TipoProcessoIDCombobox"  Width="175px" DataSourceID="SqlDataSourceDocumentoProcesso" DataTextField="Descricao" DataValueField="TipoProcessoID">
                                           
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                 <tr>
                                    <td style="width:160px">Tipo de Documento: </td>
                                    <td>
                                        <asp:DropDownList runat="server" ID="TipoDocumentoIDCombobox"  Width="175px" DataSourceID="SqlDataSourceDocumentoTipo" DataTextField="Descricao" DataValueField="TipoDocumentoID" OnSelectedIndexChanged="TipoDocumentoIDCombobox_SelectedIndexChanged" AutoPostBack="true">
                                           
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                               
                                 <asp:Repeater ID="rptCamposDocumento" DataSourceID="SqlDataSourceDocumentoCampo"  runat="server" Visible="true">
                                     <ItemTemplate>
                                        <tr>
                                        <td>
                                            <%# Eval("Descricao") %>:
                                        </td>
                                        <td>
                                            <asp:TextBox  CAMPOID='<%# Eval("alias") %>' runat="server" Width="200" MaxLength="200" />
                                        </td>
                                        </tr>
                                    </ItemTemplate>
                                 </asp:Repeater>
                                 
                                 <tr>
                                    <td style="width:90px">Descrição: </td>
                                    <td>
                                        <asp:TextBox ID="NomeTextBox" Text='<%#Bind("Nome") %>'  runat="server" Width="317" MaxLength="150" />
                                    </td>
                                </tr>
                                 <tr>
                                <td>Documento:</td>
                                <td>
                                    <asp:FileUpload ID="FileUpload1" runat="server"   ClientIDMode="Static" CssClass="ui-button ui-corner-all" />
                                </td>
                            </tr>
                             
                             </table>
                                  </ContentTemplate>
                              </asp:UpdatePanel>
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

     <asp:SqlDataSource ID="SqlDataSourceDocumentoProcesso" runat="server"
        ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"
        SelectCommand="SELECT * FROM [master_documento_processo] WHERE Visible='True'">
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceDocumentoTipo" runat="server"
        ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"
        SelectCommand="SELECT * FROM [master_documento_tipo] WHERE Visible='True'">
    </asp:SqlDataSource>
   
    <asp:SqlDataSource ID="SqlDataSourceDocumentoCampo" runat="server"
        ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"
        SelectCommand="SELECT * FROM [master_documento_campo] WHERE TipoDocumentoID=@TipoDocumentoID AND Visible='True'">
        <SelectParameters>
            <asp:ControlParameter ControlID="ctl00$MainContent$FormView1$TipoDocumentoIDCombobox" PropertyName="SelectedValue"
                                  Name="TipoDocumentoID" Type="Int32" DefaultValue="0" />
          </SelectParameters>
    </asp:SqlDataSource>
   

   <asp:SqlDataSource ID="SqlDataSourceDocumento" OnInserted="SqlDataSourceDocumento_Inserted" OnInserting="SqlDataSourceDocumento_Inserting"  runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" 
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
