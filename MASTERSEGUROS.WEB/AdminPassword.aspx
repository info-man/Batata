<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdminPassword.aspx.cs" Inherits="MASTERSEGUROS.WEB.AdminPassword" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
  <table border="0" cellpadding="0" cellspacing="0" width="100%">
                 <tr>
                     <td colspan="2">
                        <div id="accordion">
        <h3>Alterar Palavra-Passe</h3>
            <div>

                    <asp:ChangePassword ID="ChangeUserPassword" runat="server" CancelDestinationPageUrl="~/" EnableViewState="false" RenderOuterTable="false" 
         SuccessPageUrl="~/MudaPasswordSucesso.aspx"  NewPasswordRegularExpressionErrorMessage="Palavra-Passe incorrecta. Nova password tem de ter pelo menos 6 caracteres." >
        <ChangePasswordTemplate>
            <span class="erro">
                <asp:Literal ID="FailureText" runat="server"></asp:Literal>
            </span>
            <asp:ValidationSummary ID="ChangeUserPasswordValidationSummary" runat="server" CssClass="erro" 
                 ValidationGroup="ChangeUserPasswordValidationGroup"/>
             <table border ="0" cellpadding ="1" cellspacing ="0" style="width:100%;border-collapse:collapse;font-size: 13px;vertical-align:top" >
                
                <tr>
                    <td style="width:180px;font-size:13px;"><asp:Label style="font-weight:500;" ID="CurrentPasswordLabel" runat="server" AssociatedControlID="CurrentPassword">Palavra-Passe Antiga:</asp:Label></td>
                    <td><asp:TextBox ID="CurrentPassword" runat="server" CssClass="passwordEntry" TextMode="Password" Width="150px" ></asp:TextBox>
                        <asp:RequiredFieldValidator ID="CurrentPasswordRequired" runat="server" ControlToValidate="CurrentPassword" 
                             CssClass="erro" ErrorMessage="O Preenchimento da Palavra-Passe antiga é obrigatório." ToolTip="O Preenchimento da Palavra-Passe antiga é obrigatório." 
                             ValidationGroup="ChangeUserPasswordValidationGroup">*</asp:RequiredFieldValidator>
                    </td>
                </tr>

                <tr>
                    <td style="width:180px"><asp:Label style="font-weight:500;" ID="NewPasswordLabel" runat="server" AssociatedControlID="NewPassword">Palavra-Passe Nova:</asp:Label></td>
                    <td><asp:TextBox ID="NewPassword" runat="server" CssClass="passwordEntry" TextMode="Password" Width="150px"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="NewPasswordRequired" runat="server" ControlToValidate="NewPassword" 
                             CssClass="erro" ErrorMessage="O Preenchimento da Nova Palavra-Passe é obrigatório." ToolTip="O Preenchimento da Nova Palavra-Passe é obrigatório." 
                             ValidationGroup="ChangeUserPasswordValidationGroup">*</asp:RequiredFieldValidator>
                                 
                    </td>
                </tr>

                <tr>
                    <td style="width:180px"><asp:Label style="font-weight:500;" ID="ConfirmNewPasswordLabel" runat="server" AssociatedControlID="ConfirmNewPassword">Confirmação Palavra-Passe:</asp:Label></td>
                    <td> <asp:TextBox ID="ConfirmNewPassword" runat="server" CssClass="passwordEntry" TextMode="Password" Width="150px"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="ConfirmNewPasswordRequired" runat="server" ControlToValidate="ConfirmNewPassword" 
                             CssClass="erro" Display="Dynamic" ErrorMessage="A Confirmação da Nova Palavra-Passe é obrigatório."
                             ToolTip="Confirm New Password is required." ValidationGroup="ChangeUserPasswordValidationGroup">*</asp:RequiredFieldValidator>
                        <asp:CompareValidator ID="NewPasswordCompare" runat="server" ControlToCompare="NewPassword" ControlToValidate="ConfirmNewPassword" 
                             CssClass="erro" Display="Dynamic" ErrorMessage="A Confirmação da Nova Palavra-Passe deve coincidir."
                             ValidationGroup="ChangeUserPasswordValidationGroup">*</asp:CompareValidator>
                    </td>
                </tr>
            </table>
        </ChangePasswordTemplate>
    </asp:ChangePassword>
    </div>
    </div>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                    <hr />
                    </td>
                </tr>
                <tr>
                   <td colspan="2" >
                                  <asp:Button ID="CancelPushButton" runat="server" CssClass="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" CausesValidation="False" CommandName="Cancel" Text="Cancelar"/>
                    <asp:Button ID="ChangePasswordPushButton" runat="server" CssClass="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" CommandName="ChangePassword" Text="Alterar" 
                         ValidationGroup="ChangeUserPasswordValidationGroup"/>
                    </td>
                </tr>
        </table>



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
    </script>
</asp:Content>
