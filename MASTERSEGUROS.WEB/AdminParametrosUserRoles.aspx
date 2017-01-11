<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdminParametrosUserRoles.aspx.cs" Inherits="MASTERSEGUROS.WEB.AdminParametrosUserRoles" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:Label ID="Msg" ForeColor="maroon" runat="server" />

    <table border="0" cellpadding="0" cellspacing="0" width="100%">
        <tr>
            <td colspan="2">
                <div id="accordion">
                    <h3>Criar Utilizador</h3>
                    <div>
                        <asp:CreateUserWizard ID="RegisterUser" runat="server" EnableViewState="false" OnCreatedUser="RegisterUser_CreatedUser">
                            <LayoutTemplate>
                                <asp:PlaceHolder ID="wizardStepPlaceholder" runat="server"></asp:PlaceHolder>
                                <asp:PlaceHolder ID="navigationPlaceholder" runat="server"></asp:PlaceHolder>
                            </LayoutTemplate>
                            <WizardSteps>
                                <asp:CreateUserWizardStep ID="RegisterUserWizardStep" runat="server" >
                                    <ContentTemplate>
                                        <span class="failureNotification">
                                            <asp:Literal ID="ErrorMessage" runat="server"></asp:Literal>
                                        </span>
                                        <asp:ValidationSummary ID="RegisterUserValidationSummary" runat="server" CssClass="failureNotification"
                                            ValidationGroup="RegisterUserValidationGroup" />
                                        <div class="accountInfo">
                                            <fieldset class="register" style="width:800px">
                                                 <table border="0" cellpadding="0" cellspacing="0"   style="width:100%;border-collapse:collapse;font-size: 13px;">
                                                    <tr>
                                                        <td style="width:160px"><asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName">Nome de Utilizador:</asp:Label></td>
                                                        <td><asp:TextBox ID="UserName" runat="server" CssClass="textEntry" Width="200" MaxLength="30"></asp:TextBox>&nbsp; <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName"
                                                            CssClass="failureNotification" ErrorMessage="O nome do utilizador é de preenchimento obrigatório." ToolTip="O nome do utilizador é de preenchimento obrigatório."
                                                            ValidationGroup="RegisterUserValidationGroup">&otimes;</asp:RequiredFieldValidator></td>
                                                    </tr>
                                                     <tr>
                                                         <td><asp:Label ID="EmailLabel" runat="server" AssociatedControlID="Email">E-mail:</asp:Label></td>
                                                         <td> <asp:TextBox ID="Email" runat="server" CssClass="textEntry"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="EmailRequired" runat="server" ControlToValidate="Email"
                                                            CssClass="failureNotification" ErrorMessage="O E-mail é de preenchimento obrigatório." ToolTip="O E-mail é de preenchimento obrigatório."
                                                            ValidationGroup="RegisterUserValidationGroup">&otimes;</asp:RequiredFieldValidator></td>
                                                     </tr>
                                                     <tr>
                                                         <td> <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="Password">Palavra-Passe:</asp:Label></td>
                                                         <td><asp:TextBox ID="Password" runat="server" CssClass="passwordEntry" TextMode="Password"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password"
                                                            CssClass="failureNotification" ErrorMessage="A Palavra-Passe é de preenchimento obrigatório." ToolTip="A Palavra-Passe é de preenchimento obrigatório"
                                                            ValidationGroup="RegisterUserValidationGroup">&otimes;</asp:RequiredFieldValidator></td>
                                                     </tr>
                                                     <tr>
                                                         <td> <asp:Label ID="ConfirmPasswordLabel" runat="server" AssociatedControlID="ConfirmPassword">Confirmar Palavra-Passe:</asp:Label></td>
                                                         <td><asp:TextBox ID="ConfirmPassword" runat="server" CssClass="passwordEntry" TextMode="Password"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ControlToValidate="ConfirmPassword" CssClass="failureNotification" Display="Dynamic"
                                                            ErrorMessage="A confirmação é de preenchimento obrigatório." ID="ConfirmPasswordRequired" runat="server"
                                                            ToolTip="A confirmação é de preenchimento obrigatório." ValidationGroup="RegisterUserValidationGroup">&otimes;</asp:RequiredFieldValidator>
                                                        <asp:CompareValidator ID="PasswordCompare" runat="server" ControlToCompare="Password" ControlToValidate="ConfirmPassword"
                                                            CssClass="failureNotification" Display="Dynamic" ErrorMessage="A Palavra-Passe e a confirmação têm de coincidir."
                                                            ValidationGroup="RegisterUserValidationGroup">&otimes;</asp:CompareValidator></td>
                                                     </tr>
                                                     <tr>
                                                         <td>&nbsp;</td>
                                                     </tr>
                                                     <tr >
                                                         <td colspan="2"><asp:Button ID="CreateUserButton"  CssClass="ui-button ui-corner-all" runat="server" CommandName="MoveNext" Text="Criar Utilizador"
                                                    ValidationGroup="RegisterUserValidationGroup" /></td>
                                                     </tr>
                                                </table>
                                            </fieldset>

                                        </div>
                                    </ContentTemplate>
                                    <CustomNavigationTemplate>
                                    </CustomNavigationTemplate>
                                </asp:CreateUserWizardStep>
                            </WizardSteps>
                        </asp:CreateUserWizard>
                    </div>
                    <h3>Utilizadores e Grupos</h3>
                    <div>
                        <table>
                            <tr>
                                <td>
                                    <asp:ListBox ID="RolesListBox" runat="server" Rows="8" AutoPostBack="true" Width="150px" /></td>
                                <td>
                                    <asp:ListBox ID="UsersListBox" DataTextField="Username" Rows="8" SelectionMode="Multiple" runat="server" Width="163px" /></td>
                                <td colspan="2">
                                    <br />
                                    <asp:Button Text="Adicionar Utilizador ao Grupo" CssClass="ui-button ui-corner-all" ID="AddUsersButton" runat="server" OnClick="AddUsersButton_Click" /></td>
                            </tr>
                            <tr>
                            </tr>
                        </table>
                    </div>
                    <h3>Utilizadores no Grupo</h3>

                    <div>
                        <asp:GridView runat="server" CellPadding="4" ID="UsersInRoleGrid" AllowPaging="true" AutoGenerateColumns="false" GridLines="Both"
                            CellSpacing="0" PagerSettings-PageButtonCount="15" OnRowCommand="UsersInRoleGrid_RowCommand" Width="650px"
                            HeaderStyle-CssClass="SGCRowHeader" AlternatingRowStyle-CssClass="SGCdadosBodyAlt" RowStyle-CssClass="SGCdadosBodyNorm">

                            <AlternatingRowStyle BackColor="White" />
                            <Columns>
                                <asp:TemplateField HeaderText="Nome de Utilizador">
                                    <ItemTemplate>
                                        <%# Container.DataItem.ToString() %>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:ButtonField Text="Remover" ButtonType="Link" HeaderText="Operação" />

                            </Columns>
                            <FooterStyle Font-Bold="False" ForeColor="White" />
                            <HeaderStyle Font-Bold="False" ForeColor="White" />
                            <PagerSettings PageButtonCount="15"></PagerSettings>
                            <PagerStyle ForeColor="White" HorizontalAlign="Center" CssClass="PagerStyle" />
                            <RowStyle BackColor="#E3EAEB" />
                            <SelectedRowStyle BackColor="#C5BBAF" Font-Bold="False" ForeColor="#333333" />
                            <SortedAscendingCellStyle BackColor="#F8FAFA" />
                            <SortedAscendingHeaderStyle BackColor="#1F6500" />
                            <SortedDescendingCellStyle BackColor="#D4DFE1" />
                            <SortedDescendingHeaderStyle BackColor="#1F6500" />
                            <EmptyDataRowStyle BorderStyle="None" BorderWidth="0" BorderColor="White" ForeColor="#427c97" />
                            <EmptyDataTemplate></EmptyDataTemplate>
                        </asp:GridView>

                        <%--                       <asp:GridView runat="server" DataKeyNames="CategoriaID"  AllowPaging="True" AutoGenerateColumns="False"
                                    CellPadding="4" OnRowCommand="UsersInRoleGrid_RowCommand"
                                    PagerSettings-PageButtonCount="15" PageSize="10"
                                    HeaderStyle-CssClass="SGCRowHeader"´AlternatingRowStyle-CssClass="SGCdadosBodyAlt" RowStyle-CssClass="SGCdadosBodyNorm">
                                    <AlternatingRowStyle BackColor="White" />
         
         <Columns>
                        <asp:TemplateField HeaderText="User Name" >
                        <ItemTemplate>
                  <%# Container.DataItem.ToString() %>
                </ItemTemplate>
              </asp:TemplateField>
              <asp:ButtonField Text="Remover" ButtonType="Link" />
            </Columns>
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
        <EmptyDataRowStyle   BorderStyle="None"  BorderWidth="0" BorderColor="White" ForeColor="#427c97" />
        <EmptyDataTemplate></EmptyDataTemplate>
        </asp:GridView>--%>
                    </div>
                </div>
            </td>
        </tr>

    </table>
    <script type="text/javascript">
        $("#accordion").accordion({
            heightStyle: "content"
        });



        $(function () {
            $("#accordion").accordion();

            var isPostBack = <%=Convert.ToString(Page.IsPostBack).ToLower()%>;
            if (isPostBack)
            {
                $("#accordion").accordion({
                    active: 1
                });
            }
            else
            {
                $("#accordion").accordion({
                    active: 0
                });
            }


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

        });
    </script>



</asp:Content>


