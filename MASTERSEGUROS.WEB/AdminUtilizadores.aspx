<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdminUtilizadores.aspx.cs" Inherits="MASTERSEGUROS.WEB.AdminUtilizadores" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
     <h3>Administração > Novo Utilizador </h3>
<asp:CreateUserWizard ID="RegisterUser" runat="server" EnableViewState="false" OnCreatedUser="RegisterUser_CreatedUser" LoginCreatedUser="false" com CompleteSuccessText="Utilizador criado com sucesso."  ContinueButtonStyle-CssClass="ui-button2 ui-widget ui-state-default ui-corner-all ui-button-text-only" ContinueDestinationPageUrl="~/Default.aspx"  ContinueButtonText="Continuar"  ConfirmPasswordCompareErrorMessage="A palavra-passe e a confirmação não são iguais." DuplicateEmailErrorMessage="O endereço electrónico introduzido já está ser usado. Por favor, introduza outro." DuplicateUserNameErrorMessage="Introduza um nome de utilizador diferente.">
        <LayoutTemplate >
            <asp:PlaceHolder ID="wizardStepPlaceholder" runat="server"></asp:PlaceHolder>
            <asp:PlaceHolder ID="navigationPlaceholder" runat="server"></asp:PlaceHolder>
        </LayoutTemplate>
        <WizardSteps >
            <asp:CreateUserWizardStep ID="RegisterUserWizardStep" runat="server"   >
                <ContentTemplate >
                    <span class="erro">
                        <asp:Literal ID="ErrorMessage" runat="server"></asp:Literal>
                    </span>
                    <asp:ValidationSummary ID="RegisterUserValidationSummary" runat="server" CssClass="erro" 
                         ValidationGroup="RegisterUserValidationGroup"/>
                   <table border ="0" cellpadding ="1" cellspacing ="0" style="width:100%;border-collapse:collapse;font-size: 14px;vertical-align:top" >
                        <tr>
                               <td style="width:180px"> <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName">Nome de Utilizador:</asp:Label></td>
                            <td>
                                 <asp:TextBox ID="UserName" runat="server" CssClass="textEntry" Width="200px" ></asp:TextBox>
                                <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName" 
                                     CssClass="erro" ErrorMessage="O nome do utilizador é de preenchimento obrigatório." ToolTip="O nome do utilizador é de preenchimento obrigatório." 
                                     ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator> 
                            </td>
                        </tr>
                        <tr>
                                <td>Cliente:</td>
                                 <td>
                                    <asp:TextBox ID="MilitanteIDTextBox" runat="server" Text='<%# Bind("MilitanteID") %>' Width="200" MaxLength="4" />&nbsp;<asp:Button ID="Button2" ValidationGroup="Form" CssClass="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" runat="server" Text="Seleccionar" CausesValidation="false" OnClientClick="return ConfirmEscolheCliente();" />
                                    
                                </td>
                            </tr>
                        <tr>
                            <td><asp:Label ID="EmailLabel" runat="server" AssociatedControlID="Email">E-mail:</asp:Label></td>
                            <td><asp:TextBox ID="Email" runat="server" CssClass="textEntry"  Width="200px"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="EmailRequired" runat="server" ControlToValidate="Email" 
                                     CssClass="erro" ErrorMessage="O E-mail é de preenchimento obrigatório." ToolTip="O E-mail é de preenchimento obrigatório." 
                                     ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td><asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="Password">Palavra-Passe:</asp:Label></td>
                            <td>
                                <asp:TextBox ID="Password" runat="server" CssClass="passwordEntry" TextMode="Password"  Width="200px"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password" 
                                     CssClass="erro" ErrorMessage="A Palavra-Passe é de preenchimento obrigatório." ToolTip="A Palavra-Passe é de preenchimento obrigatório" 
                                     ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td><asp:Label ID="ConfirmPasswordLabel" runat="server" AssociatedControlID="ConfirmPassword">Confirmar Palavra-Passe:</asp:Label></td>
                            <td>
                                <asp:TextBox ID="ConfirmPassword" runat="server" CssClass="passwordEntry" TextMode="Password"  Width="200px"></asp:TextBox>
                                <asp:RequiredFieldValidator ControlToValidate="ConfirmPassword" CssClass="erro" Display="Dynamic" 
                                     ErrorMessage="A confirmação é de preenchimento obrigatório." ID="ConfirmPasswordRequired" runat="server" 
                                     ToolTip="A confirmação é de preenchimento obrigatório." ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
                                <asp:CompareValidator ID="PasswordCompare" runat="server" ControlToCompare="Password" ControlToValidate="ConfirmPassword" 
                                     CssClass="erro" Display="Dynamic" ErrorMessage="A Palavra-Passe e a confirmação têm de coincidir."
                                     ValidationGroup="RegisterUserValidationGroup">*</asp:CompareValidator>
                            </td>
                        </tr>
                        <tr>
                           <td><asp:Label ID="labelAdmin" runat="server" AssociatedControlID="chkAdmin">Administrador:</asp:Label></td>
                            <td>
                                <asp:CheckBox ID="chkAdmin"  runat="server"   ToolTip="Permissões de administração"/>
                            </td>
                        </tr>
                         <tr>
                            <td colspan ="2"><hr /></td>
                        <tr>   
                        <tr>
                            <td colspan="2" >
                                <asp:Button ID="CreateUserButton"  CssClass="ui-button2 ui-widget ui-state-default ui-corner-all ui-button-text-only" runat="server"  CommandName="MoveNext" Text="Criar Utilizador" 
                                 ValidationGroup="RegisterUserValidationGroup"/>
                            </td>
                        </tr>
                    </table>
                       
                    </div>
                </ContentTemplate>
                <CustomNavigationTemplate >
                   
                </CustomNavigationTemplate>
            </asp:CreateUserWizardStep>
        </WizardSteps>
    </asp:CreateUserWizard>

      <div id="dialog-form" title="CTT" style="display: none">
       <b>Clientes:</b>
 <table id="users" class="ui-widget ui-widget-content">
	
     <asp:GridView ID="gridviewCAP" runat="server"
        AllowPaging="False" AllowSorting="False" AutoGenerateColumns="False"
        CellPadding="4" DataKeyNames="MilitanteID" DataSourceID="SqlDataSourceCTTPopUp"
        PagerSettings-PageButtonCount="15" PageSize="15"
        HeaderStyle-CssClass="SGCRowHeader"
        AlternatingRowStyle-CssClass="SGCdadosBodyAlt"
        RowStyle-CssClass="SGCdadosBodyNorm" >
        <AlternatingRowStyle BackColor="White" />
        <Columns>

             <asp:BoundField DataField="MilitanteID" HeaderText="ID" 
            SortExpression="CAPID"  ItemStyle-HorizontalAlign="Right"/>
            
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
                    <asp:LinkButton ID="lnkSelClassificador" runat="server" Text='Seleccionar'  OnClientClick='<%# Eval("MilitanteID", "SelClassificador(\"{0}\");") %>'></asp:LinkButton>
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

     <asp:SqlDataSource ID="SqlDataSourceCTTPopUp" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" 
        SelectCommand="SELECT mpla_militante.MilitanteID, mpla_militante.Nome, p.ProvinciaId, p.Nome as NomeProvincia, m.MunicipioId,m.Nome as NomeMunicipio, c.ComunaId, c.Nome as NomeComuna FROM [dbo].[mpla_militante]
        INNER JOIN [dbo].[master_provincia] p ON mpla_militante.ProvinciaID = p.ProvinciaId
        INNER JOIN [dbo].[master_municipio] m on mpla_militante.MunicipioID= m.MunicipioId
        INNER JOIN [dbo].[master_comuna] c ON mpla_militante.ComunaId = c.ComunaId">
</asp:SqlDataSource>

       <script type="text/javascript">
       function ConfirmEscolheCliente() {
              $("#dialog-form").dialog({
               title: "CTT",
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
    </script>
</asp:Content>
