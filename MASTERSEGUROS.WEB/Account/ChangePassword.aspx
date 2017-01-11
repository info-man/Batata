<%@ Page Title="Alteração de Palavra-Passe" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ChangePassword.aspx.cs" Inherits="MASTERSEGUROS.WEB.Account.ChangePassword" %>
<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="MainContent">
    Administração > Alterar Palavra-passe<br /> <br />
    <p>
        As novas palavras-passe passwords devem ter <%= Membership.MinRequiredPasswordLength %> no mínimo 6 caracteres.
    </p>
    <table border ="0" cellpadding ="2" cellspacing ="0" style="vertical-align:top" >
        <tr>
            <td><asp:Label ID="CurrentPasswordLabel" runat="server" AssociatedControlID="CurrentPassword">Palavra-Passe Antiga:</asp:Label></td>
            <td>
                <asp:TextBox ID="CurrentPassword" runat="server" CssClass="textEntry" Width="200px" TextMode="Password"></asp:TextBox>
                <asp:RequiredFieldValidator ID="CurrentPasswordRequired" runat="server" ControlToValidate="CurrentPassword" 
                             CssClass="erro" ErrorMessage="Palavra-Passe obrigatória." ToolTip="Palavra-Passe Antiga Obrigatória." 
                             ValidationGroup="ChangeUserPasswordValidationGroup">*</asp:RequiredFieldValidator> 
            </td>
        </tr>
        <tr>
            <td><asp:Label ID="NewPasswordLabel" runat="server" AssociatedControlID="NewPassword">Palavra-Passe Nova:</asp:Label></td>
            <td><asp:TextBox ID="NewPassword" runat="server" CssClass="passwordEntry" TextMode="Password"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="NewPasswordRequired" runat="server" ControlToValidate="NewPassword" 
                             CssClass="erro" ErrorMessage="É obrigatório o preenchimento da nova palavra-passe. " ToolTip="Nova palvra-passe obrigatória." 
                             ValidationGroup="ChangeUserPasswordValidationGroup">*</asp:RequiredFieldValidator></td>
        </tr>
        <tr>
            <td><asp:Label ID="ConfirmNewPasswordLabel" runat="server" AssociatedControlID="ConfirmNewPassword">Confirmação Nova Palavra-Passe:</asp:Label></td>
            <td><asp:TextBox ID="ConfirmNewPassword" runat="server" CssClass="passwordEntry" TextMode="Password"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="ConfirmNewPasswordRequired" runat="server" ControlToValidate="ConfirmNewPassword" 
                             CssClass="erro" Display="Dynamic" ErrorMessage="É obrigatório o preenchimento da confirmação da nova palavra-passe."
                             ToolTip="Confirmação de nova palavra-passe é obrigatória." ValidationGroup="ChangeUserPasswordValidationGroup">*</asp:RequiredFieldValidator>
                        <asp:CompareValidator ID="NewPasswordCompare" runat="server" ControlToCompare="NewPassword" ControlToValidate="ConfirmNewPassword" 
                             CssClass="erro" Display="Dynamic" ErrorMessage="A confirmação da nova palavra-passe deve ser igual à nova palavra-passe."
                             ValidationGroup="ChangeUserPasswordValidationGroup">*</asp:CompareValidator></td>

        </tr>
        <tr>
            <td colspan ="2"><hr /></td>
        </tr>   
        <tr>
            <td colspan="2">
                <asp:Button ID="CancelPushButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancelar" CssClass="botao"/>
                <asp:Button ID="ChangePasswordPushButton" runat="server" CssClass="botao" CommandName="ChangePassword" Text="Alterar Palavra-Passe" ValidationGroup="ChangeUserPasswordValidationGroup"/>
            </td>
        </tr>
    </table>
 </asp:Content>
