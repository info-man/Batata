<%@ Page Title="Rastrear" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Rastrear.aspx.cs" Inherits="MASTERSEGUROS.WEB.Rastrear"  %>
<%@ Register TagPrefix="cc" Namespace="Winthusiasm.HtmlEditor" Assembly="Winthusiasm.HtmlEditor" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
   
        <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePartialRendering="true" />
    <h3>Estafetas ><asp:Label ID="lblBread"   runat="server"></asp:Label>Rastrear</h3>
    <br />
    <asp:FormView ID="FormView1" runat="server" DataKeyNames="ClassificadorID" DataSourceID="SqlDataSourceClassificador" DefaultMode="Insert" >
        <InsertItemTemplate>
            
                <table border="0" cellpadding="2" cellspacing="0" style="vertical-align: top;font-size:14px">
                 <tr>
                    <td>Identificador:</td>
                    <td>
                        <asp:TextBox ID="NomeTextBox" runat="server" Text='<%# Bind("Nome") %>' Width="200" MaxLength="100" />
                        &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator5" ValidationGroup="Form" Display="Dynamic" runat="server" Text="*" ControlToValidate="NomeTextBox" class="erro" ToolTip="" SetFocusOnError="true">Preenchimento Obrigatório</asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                     <td colspan="2">
                         <asp:Button ID="InsertButton" ValidationGroup="Form" CssClass="ui-button2 ui-widget ui-state-default ui-corner-all ui-button-text-only" runat="server" Text="Pesquisar" CommandName="Insert" CausesValidation="True"  />
                    </td>
                </tr>
              </table>     
           
        </InsertItemTemplate>

      
    </asp:FormView>
        
    <div id="dialog-confirmInsereClassificador" title="CMSCK" style="display: none">
        <br />
        <b>Tem a certeza que pretende adicionar um classificador?</b>
    </div>
    <div id="dialog-confirmActualizarClassificador" title="CMSCK" style="display: none">
        <br />
        <b>Tem a certeza que pretende actualizar o classificador?</b>
    </div>
     <div id="dialog-ClassificadorActualizado" title="CMSCK" style="display: none">
        <br />
        <b>O classificador foi actualizado com sucesso.</b>
    </div>
     <div id="dialog-ClassificadorCriado" title="CMSCK" style="display: none">
        <br />
        <b>O classificador foi criado com sucesso.</b>
    </div>
    <div id="dialog-RelatorioErroGravar" title="CMSCK" style="display: none">
        <br />
        <b>Ocorreu um erro a gravar os dados.<br />Comunique ao administrador de sistemas.</b>
    </div>

    <div id="dialog-form" title="Create new user" title="CMSCK" style="display: none">
       <b>Classificadores:</b>
 <table id="users" class="ui-widget ui-widget-content">
	
 </table>
</div>

    <div id="dialog-Media" title="Media" title="CMSCK" style="display: none">
        <asp:Image runat="server" ID="imgVerMedia" />
    </div>

<asp:SqlDataSource ID="SqlDataSourceClassificadorPopUp" runat="server" 
    ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" 
 SelectCommand="SELECT * FROM [cmsck_classificador]">
   

</asp:SqlDataSource>

   <asp:SqlDataSource ID="SqlDataSourceClassificador"   OnInserted="On_Inserted" OnUpdated="On_Updated"  OnInserting ="SqlDataSourceClassificador_Inserting"  OnUpdating="On_Updating" runat="server"
        ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"
        DeleteCommand="DELETE FROM [cmsck_classificador] WHERE [ClassificadorID] = @ClassificadorID AND [Lingua]=@Lingua"
        InsertCommand="INSERT INTO [cmsck_classificador] ([ClassificadorID], [ClassificadorPaiID], [Nome], [Descricao], [Ordem], [Estado], [Lingua], [Media], [UrlTemplate], [Tipo], [NivelInteresseID]) VALUES (@ClassificadorID,@ClassificadorPaiID, @Nome, @Descricao, @Ordem, @Estado, @Lingua, @Media, @UrlTemplate, @Tipo, @NivelInteresseID)"
        SelectCommand="SELECT * FROM [cmsck_classificador] WHERE [ClassificadorID]=@ClassificadorID AND [Lingua]=@Lingua"
        UpdateCommand="UPDATE [cmsck_classificador] SET [ClassificadorPaiID]=@ClassificadorPaiID, [Nome]=@Nome, [Descricao]=@Descricao, [Ordem]=@Ordem, [Estado]=@Estado, [Lingua]=@Lingua, [Media]=@Media, [UrlTemplate]=@UrlTemplate, [Tipo]=@Tipo, [NivelInteresseID]=@NivelInteresseID WHERE [ClassificadorId] = @ClassificadorId AND [Lingua]=@Lingua">
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

   <script type="text/javascript">


       function SetURL(selectObject) {
           
       }
      

       function ConfirmEscolheClassificadorPai() {
           $("#dialog-form").dialog({
               title: "CMSCK - Gestor de Conteúdos",
               autoOpen: true,
               resizable: false,
               height: 500,
               width: 550,
               modal: true,
               buttons: {
                   
                   "Cancelar": function () {
                       $(this).dialog("close");
                       return false;
                   }
               }
           });
           return false;
       }

       function ConfirmVerMedia() {
          $("#dialog-Media").dialog({
               title: "CMSCK - Gestor de Conteúdos",
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
                title: "CMSCK - Gestor de Conteúdos",
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
                 title: "CMSCK - Gestor de Conteúdos",
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

       function MessageBoxClassificadorActualizado(refString) {
           $("#dialog-ClassificadorActualizado").dialog({
                 title: "CMSCK - Gestor de Conteúdos",
                 resizable: false,
                 width: 430,
                 height: 200,
                 modal: true,
                 buttons: {
                     "OK": function () {
                         document.location = "PesquisaClassificador.aspx?";
                         $(this).dialog("close");
                         return true;
                     }
                 }

             });
             return false;
         }

         function MessageBoxClassificadorCriado(refString) {
             $("#dialog-ClassificadorCriado").dialog({
                 title: "CMSCK - Gestor de Conteúdos",
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
                 title: "CMSCK - Gestor de Conteúdos",
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
