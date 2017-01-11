<%@ Page Title="Alterar Palavra-Passe" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdminAlteraPalavraPasse.aspx.cs" Inherits="MASTERSEGUROS.WEB.AdminAlteraPalavraPasse" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h3>Administração > Alterar Palavra-passe </h3><br />
    
     As novas palavras-passe devem ter no mínimo <%= Membership.MinRequiredPasswordLength %> caracteres.<br /><br />   
    
    
    <asp:ChangePassword ID="ChangeUserPassword"  runat="server"  CancelDestinationPageUrl="~/" EnableViewState="false" BorderStyle="None" RenderOuterTable="true" 
         SuccessPageUrl="AdminAlteraPalavraPasseSuccess.aspx"  ChangePasswordFailureText="Palavra-Passe incorrecta ou Nova Palavra-Passe inválida. Comprimento mínimo da nova Palavra-Passe: 6.">
        <ChangePasswordTemplate >
            <span class="erro">
                <asp:Literal  ID="FailureText" runat="server" ></asp:Literal>
            </span>
            <asp:ValidationSummary ID="ChangeUserPasswordValidationSummary" runat="server" CssClass="erro" 
                 ValidationGroup="ChangeUserPasswordValidationGroup"/>
     
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
            <td><asp:Label ID="NewPasswordLabel" runat="server" AssociatedControlID="NewPassword">Nova Palavra-Passe:</asp:Label></td>
            <td><asp:TextBox ID="NewPassword" runat="server" CssClass="passwordEntry" Width="200px" TextMode="Password"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="NewPasswordRequired" runat="server" ControlToValidate="NewPassword" 
                             CssClass="erro" ErrorMessage="É obrigatório o preenchimento da nova palavra-passe. " ToolTip="Nova palavra-passe obrigatória." 
                             ValidationGroup="ChangeUserPasswordValidationGroup">*</asp:RequiredFieldValidator></td>
        </tr>
        <tr>
            <td><asp:Label ID="ConfirmNewPasswordLabel" runat="server" AssociatedControlID="ConfirmNewPassword">Confirmação Nova Palavra-Passe:</asp:Label></td>
            <td><asp:TextBox ID="ConfirmNewPassword" runat="server" CssClass="passwordEntry" Width="200px" TextMode="Password"></asp:TextBox>
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
                <asp:Button ID="ChangePasswordPushButton" runat="server" CssClass="botao" CommandName="ChangePassword" Text="Alterar Palavra-Passe" ValidationGroup="ChangeUserPasswordValidationGroup"/>
                <asp:Button ID="CancelPushButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancelar" CssClass="botao"/>
                
            </td>
        </tr>
    </table>
            </ChangePasswordTemplate>
    </asp:ChangePassword>
</asp:Content>
