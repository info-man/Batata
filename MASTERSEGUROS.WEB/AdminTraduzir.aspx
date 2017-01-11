<%@ Page Title="Classificadores" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdminTraduzir.aspx.cs" Inherits="MASTERSEGUROS.WEB.AdminTraduzir"  %>
<%@ Register TagPrefix="cc" Namespace="Winthusiasm.HtmlEditor" Assembly="Winthusiasm.HtmlEditor" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
   
        <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePartialRendering="true" />
    <h3>Classificadores ><asp:Label ID="lblBread"   runat="server"></asp:Label>Classificador</h3>
    <br />


    <asp:FormView ID="FormView1" runat="server" DataKeyNames="ClassificadorID" DataSourceID="SqlDataSourceClassificador" DefaultMode="Insert" >
        <InsertItemTemplate>
   
             <table border="0" cellpadding="2" cellspacing="0" style="vertical-align: top">
                            <tr>
                                <td>Classificador Pai:</td>
                                <td>
                                    <asp:TextBox ID="ClassificadorPaiIDTextBox" ReadOnly="true"  runat="server" Text='<%# Bind("ClassificadorPaiID") %>' Width="30" MaxLength="4" />
                                    
                                </td>
                            </tr>
                            <tr>
                                <td>Nome:</td>
                                <td>
                                    <asp:TextBox ID="NomeTextBox" runat="server" Text='<%# Bind("Nome") %>' Width="398" MaxLength="400" />&nbsp;Tradução de: <asp:Label ID="NomeLabel" runat="server"  Visible="true"  Text='<%# Bind("Nome") %>'></asp:Label>
                                    &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator5" ValidationGroup="Form" Display="Dynamic" runat="server" Text="*" ControlToValidate="NomeTextBox" class="erro" ToolTip="" SetFocusOnError="true">Preenchimento Obrigatório</asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td>Descrição:</td>
                                <td>
                                    <asp:TextBox ID="DescricaoTextBox" runat="server" Text='<%# Bind("Descricao") %>' TextMode="MultiLine" Width="395px" Rows="2" MaxLength="400" />
                                </td>
                            </tr>


                             <tr>
                                <td>Media:</td>
                                <td>
                                    <asp:FileUpload ID="MediaUpload" runat="server" Width="200" CssClass="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" style="width: 400px;padding:0px 0px;border:0px"/>
                                </td>
                            </tr>
                             <tr>
                                <td>Template/Url:</td>
                                <td>
                                    <asp:DropDownList runat="server"  ID="UrltemplateComboBox" AutoPostBack ="false" DataSourceID="SqlDataSourceTemplate"  DataTextField="NomeTemplate"  DataValueField="UrlTemplate"  AppendDataBoundItems="true"  onchange="javascript:SetURL(this)" >
                                        <asp:ListItem Text="" Value=""></asp:ListItem>
                                    </asp:DropDownList>&nbsp;<asp:TextBox ID="UrlTemplateTextBox"  runat="server" Text='<%# Bind("UrlTemplate") %>' Width="230" MaxLength="400" />
                                </td>
                            </tr>
                            <tr>
                                <td>Tipo:</td>
                                <td>
                                    <asp:DropDownList runat="server"  ID="TipoComboBox" AutoPostBack ="false" DataSourceID="SqlDataSourceTipo"  DataTextField="Descricao"  DataValueField="TipoID"  AppendDataBoundItems="true" >
                                                                    
                                    </asp:DropDownList>
                                     &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator4" ValidationGroup="Form" Display="Dynamic" runat="server" Text="*" ControlToValidate="TipoComboBox" class="erro" ToolTip="" SetFocusOnError="true">Preenchimento Obrigatório</asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td>Lingua:</td>
                                <td>
                                    <asp:DropDownList runat="server"  ID="LinguaComboBox"  AppendDataBoundItems="true" AutoPostBack ="false" DataSourceID="SqlDataSourceLingua"  DataTextField="Descricao"  DataValueField="LinguaID"  >
                                    </asp:DropDownList>
                                     &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator3" ValidationGroup="Form" Display="Dynamic" runat="server" Text="*" ControlToValidate="LinguaComboBox" class="erro" ToolTip="" SetFocusOnError="true">Preenchimento Obrigatório</asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td>Nível de Interesse:</td>
                                <td>
                                    <asp:DropDownList runat="server"  ID="NivelInteresseIDComboBox" AutoPostBack ="false" DataSourceID="SqlDataSourceNivelInteresse"  DataTextField="Descricao"  DataValueField="NivelInteresseID">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td>Estado:</td>
                                <td>
                                    <asp:DropDownList runat="server"  ID="EstadoComboBox" AutoPostBack ="false" AppendDataBoundItems="true" >
                                        <asp:ListItem Value="1" Text="Válido" Selected="True"></asp:ListItem>  
                                        <asp:ListItem Value="0" Text="Inválido" Selected="false"></asp:ListItem>                           
                                    </asp:DropDownList>
                                     &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator2" ValidationGroup="Form" Display="Dynamic" runat="server" Text="*" ControlToValidate="EstadoComboBox" class="erro" ToolTip="" SetFocusOnError="true">Preenchimento Obrigatório</asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td>Ordem:</td>
                                <td>
                                    <asp:TextBox ID="OrdemTextBox" runat="server" Text='<%# Bind("Ordem") %>' Width="30" MaxLength="4" />
                                    
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                <hr />
                                </td>
                            </tr>
            </table>
            
            <asp:Button ID="InsertButton" ValidationGroup="Form" CssClass="ui-button2 ui-widget ui-state-default ui-corner-all ui-button-text-only" runat="server" Text="Adicionar" CommandName="Insert" CausesValidation="True"  />
              
        </InsertItemTemplate>

        <EditItemTemplate>
            <table border="0" cellpadding="2" cellspacing="0" style="vertical-align: top">
                            <tr>
                                <td>Classificador Pai:</td>
                                <td>
                                    <asp:TextBox ID="ClassificadorPaiIDTextBox" runat="server" Text='<%# Bind("ClassificadorPaiID") %>' Width="30" MaxLength="4" />&nbsp;<asp:Button ID="btnSeleccionaClassificadorPai" ValidationGroup="Form" CssClass="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" runat="server" Text="Escolher Pai" CausesValidation="false" OnClientClick="return ConfirmEscolheClassificadorPai();" />
                                    
                                </td>
                            </tr>
                 
                 
                               
                            <tr>
                                <td>Nome:</td>
                                <td>
                                    <asp:TextBox ID="NomeTextBox" runat="server" Text='<%# Bind("Nome") %>' Width="398" MaxLength="400" /><asp:Label ID="NomeLabel" runat="server"  Visible="true"  Text='<%# Bind("Nome") %>'>AA</asp:Label>
                                    &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator5" ValidationGroup="Form" Display="Dynamic" runat="server" Text="*" ControlToValidate="NomeTextBox" class="erro" ToolTip="" SetFocusOnError="true">Preenchimento Obrigatório</asp:RequiredFieldValidator>
                                </td>
                            </tr>
                           
                            <tr>
                                <td>Descrição:</td>
                                <td>
                                    <asp:TextBox ID="DescricaoTextBox" runat="server" Text='<%# Bind("Descricao") %>' Rows="2" MaxLength="400" />
                                </td>
                            </tr>
                               


                             <tr>
                                <td>Media:</td>
                                <td>
                                    <asp:FileUpload ID="MediaUpload" runat="server" Width="200" CssClass="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" style="width: 400px;padding:0px 0px;border:0px"/>
                                    <asp:Button ID="btnVerMedia" CommandArgument='<%# Bind("Media") %>'  CommandName='<%# Bind("Media") %>' ValidationGroup="Form" CssClass="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" runat="server" Text="Ver Media" CausesValidation="false" OnClientClick="return ConfirmVerMedia();" />&nbsp;&nbsp;<asp:Button ID="btnApagarMedia" ValidationGroup="Form" CssClass="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" runat="server" Text="Apagar Media" CausesValidation="false" OnClientClick="return ClearFileUpload();"  OnClick="btnApagarMedia_Click" />
                                    
                                </td>
                            </tr>
                             <tr>
                                <td>Template/Url:</td>
                                <td>
                                    <asp:DropDownList runat="server"  ID="UrltemplateComboBox" AutoPostBack ="false" DataSourceID="SqlDataSourceTemplate"  DataTextField="NomeTemplate"  DataValueField="UrlTemplate"  AppendDataBoundItems="true"  onchange="javascript:SetURL(this)" >
                                        <asp:ListItem Text="" Value=""></asp:ListItem>
                                    </asp:DropDownList>&nbsp;<asp:TextBox ID="UrlTemplateTextBox"  runat="server" Text='<%# Bind("UrlTemplate") %>' Width="230" MaxLength="400" />
                                </td>
                            </tr>
                            <tr>
                                <td>Tipo:</td>
                                <td>
                                    <asp:DropDownList runat="server"  ID="TipoComboBox" AutoPostBack ="false" DataSourceID="SqlDataSourceTipo"  DataTextField="Descricao"  DataValueField="TipoID"  AppendDataBoundItems="true" >
                                                                    
                                    </asp:DropDownList>
                                     &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator4" ValidationGroup="Form" Display="Dynamic" runat="server" Text="*" ControlToValidate="TipoComboBox" class="erro" ToolTip="" SetFocusOnError="true">Preenchimento Obrigatório</asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td>Lingua:</td>
                                <td>
                                    <asp:DropDownList runat="server"  ID="LinguaComboBox" AutoPostBack ="false" DataSourceID="SqlDataSourceLingua"  DataTextField="Descricao"  DataValueField="LinguaID"  >
                                    </asp:DropDownList>
                                     &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator3" ValidationGroup="Form" Display="Dynamic" runat="server" Text="*" ControlToValidate="LinguaComboBox" class="erro" ToolTip="" SetFocusOnError="true">Preenchimento Obrigatório</asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td>Nível de Interesse:</td>
                                <td>
                                    <asp:DropDownList runat="server"  ID="NivelInteresseIDComboBox" AutoPostBack ="false" DataSourceID="SqlDataSourceNivelInteresse"  DataTextField="Descricao"  DataValueField="NivelInteresseID">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td>Estado:</td>
                                <td>
                                    <asp:DropDownList runat="server"  ID="EstadoComboBox" AutoPostBack ="false" AppendDataBoundItems="true" >
                                        <asp:ListItem Value="1" Text="Válido" Selected="True"></asp:ListItem>  
                                        <asp:ListItem Value="0" Text="Inválido" Selected="false"></asp:ListItem>                           
                                    </asp:DropDownList>
                                     &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator2" ValidationGroup="Form" Display="Dynamic" runat="server" Text="*" ControlToValidate="EstadoComboBox" class="erro" ToolTip="" SetFocusOnError="true">Preenchimento Obrigatório</asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td>Ordem:</td>
                                <td>
                                    <asp:TextBox ID="OrdemTextBox" runat="server" Text='<%# Bind("Ordem") %>' Width="30" MaxLength="4" />
                                    
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                <hr />
                                </td>
                            </tr>
            </table>

              <asp:Button ID="BackButton" ValidationGroup="Form" CssClass="ui-button2 ui-widget ui-state-default ui-corner-all ui-button-text-only" runat="server" Text="Voltar"  CausesValidation="True" OnClientClick="history.back(-1);" />
              <asp:Button ID="UpdateButton" ValidationGroup="Form" CssClass="ui-button2 ui-widget ui-state-default ui-corner-all ui-button-text-only" runat="server" Text="Gravar" CommandName="Update" CausesValidation ="True"  />

        </EditItemTemplate>
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
	
     <asp:GridView ID="gridviewClassificador" runat="server"
        AllowPaging="False" AllowSorting="False" AutoGenerateColumns="False"
        CellPadding="4" DataKeyNames="ClassificadorID" DataSourceID="SqlDataSourceClassificadorPopUp"
        PagerSettings-PageButtonCount="15" PageSize="15"
        HeaderStyle-CssClass="SGCRowHeader"
        AlternatingRowStyle-CssClass="SGCdadosBodyAlt"
        RowStyle-CssClass="SGCdadosBodyNorm" >
        <AlternatingRowStyle BackColor="White" />
        <Columns>

             <asp:BoundField DataField="ClassificadorPaiID" HeaderText="Classificador Pai" 
            SortExpression="ClassificadorPaiID"  ItemStyle-HorizontalAlign="Right"/>
            
            <asp:BoundField DataField="ClassificadorID" HeaderText="Classificador" 
            SortExpression="ClassificadorID"  ItemStyle-HorizontalAlign="Right" />

                 <asp:BoundField DataField="Nome" HeaderText="Nome" 
            SortExpression="Nome"  ItemStyle-HorizontalAlign="Left" />
      
          <asp:TemplateField HeaderText="Operações"  ItemStyle-HorizontalAlign="Left">
                <ItemTemplate>
                    <asp:LinkButton ID="lnkSelClassificador" runat="server" Text='Seleccionar'  OnClientClick='<%# Eval("ClassificadorID", "SelClassificador(\"{0}\");") %>'></asp:LinkButton>
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
        UpdateCommand="UPDATE [cmsck_classificador] SET [ClassificadorPaiID]=@ClassificadorPaiID, [Nome]=@Nome, [Descricao]=@Descricao, [Ordem]=@Ordem, [Estado]=@Estado, [Lingua]=@Lingua, [Media]=@Media, [UrlTemplate]=@UrlTemplate, [Tipo]=@Tipo, [NivelInteresseID]=@NivelInteresseID WHERE [ClassificadorId] = @ClassificadorId">
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
   
   <asp:SqlDataSource ID="SqlDataSourceTipo" runat="server"
        ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"
        SelectCommand="SELECT * FROM [cmsck_tipo_classificador] "></asp:SqlDataSource>

   <asp:SqlDataSource ID="SqlDataSourceLingua" runat="server"
        ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"
        SelectCommand="SELECT * FROM [cmsck_lingua] "></asp:SqlDataSource>

   <asp:SqlDataSource ID="SqlDataSourceNivelInteresse" runat="server"
        ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"
        SelectCommand="SELECT * FROM [cmsck_nivel_interesse] "></asp:SqlDataSource>

   <asp:SqlDataSource ID="SqlDataSourceTemplate" runat="server"
        ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"
        SelectCommand="SELECT * FROM [cmsck_template] "></asp:SqlDataSource>

   <script type="text/javascript">


       function SetURL(selectObject) {
           var indexValue = new String("");
           indexValue = selectObject.options[selectObject.selectedIndex].value;
           document.all['<%=FormView1.FindControl("UrlTemplateTextBox").UniqueID%>'].value = indexValue;
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
           document.all['<%=FormView1.FindControl("ClassificadorPaiIDTextBox").UniqueID%>'].value = value;
           $("#dialog-form").dialog("close");
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
                         document.location = 'PesquisaClassificador.aspx';
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
            //Reference the FileUpload and get its Id and Name.
            var fileUpload = document.getElementById("<%=((FileUpload)FormView1.FindControl("MediaUpload")).ClientID %>");
            var id = fileUpload.id;
            var name = fileUpload.name;
 
            //Create a new FileUpload element.
            var newFileUpload = document.createElement("INPUT");
            newFileUpload.type = "FILE";
 
            //Append it next to the original FileUpload.
            fileUpload.parentNode.insertBefore(newFileUpload, fileUpload.nextSibling);
 
            //Remove the original FileUpload.
            fileUpload.parentNode.removeChild(fileUpload);
 
            //Set the Id and Name to the new FileUpload.
            newFileUpload.id = id;
            newFileUpload.name = name;
            return true;
        }
</script>
           
</asp:Content>
