<%@ Page Title="Bancos" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdminParametrosBancos.aspx.cs" Inherits="MASTERSEGUROS.WEB.AdminParametrosBancos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <asp:FormView ID="FormView1" runat="server" DataKeyNames="bancoID" DataSourceID="SqlDataSourceINSERTALL" DefaultMode="Insert" Width="100%">
        <InsertItemTemplate>
            <table border="0" cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td colspan="2">
                        <div id="accordion">
                            <h3>Parâmetros - Bancos</h3>
                            <div>
                                <table border="0" cellpadding="0" cellspacing="0" style="width: 100%; border-collapse: collapse; font-size: 13px;">

                                    <tr>
                                        <td style="width: 120px">Nome do Banco:</td>
                                        <td>
                                            <asp:TextBox ID="nomeTextBox" runat="server" Text='<%# Bind("nome") %>' Width="200" MaxLength="100" />
                                            &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator2" ValidationGroup="Form" Display="Dynamic" runat="server" Text="*" ControlToValidate="nomeTextBox" class="erro" ToolTip="" SetFocusOnError="true">&otimes;</asp:RequiredFieldValidator>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td>Morada da Sede:</td>
                                        <td>
                                            <asp:TextBox ID="moradasedeTextBox" runat="server" Text='<%# Bind("moradasede") %>' Width="250" MaxLength="50" />
                                            &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator1" ValidationGroup="Form" Display="Dynamic" runat="server" Text="*" ControlToValidate="moradasedeTextBox" class="erro" ToolTip="" SetFocusOnError="true">&otimes;</asp:RequiredFieldValidator>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td>Telefone da Sede:</td>
                                        <td>
                                            <asp:TextBox ID="telefonesedeTextBox" runat="server" Text='<%# Bind("telefonesede") %>' Width="100" MaxLength="10" />
                                            &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator3" ValidationGroup="Form" Display="Dynamic" runat="server" Text="*" ControlToValidate="telefonesedeTextBox" class="erro" ToolTip="" SetFocusOnError="true">&otimes;</asp:RequiredFieldValidator>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td>Nome do Contacto:</td>
                                        <td>
                                            <asp:TextBox ID="nomecontactoTextBox" runat="server" Text='<%# Bind("nomecontacto") %>' Width="200" MaxLength="50" />
                                            &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator4" ValidationGroup="Form" Display="Dynamic" runat="server" Text="*" ControlToValidate="nomecontactoTextBox" class="erro" ToolTip="" SetFocusOnError="true">&otimes;</asp:RequiredFieldValidator>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td>E-mail:</td>
                                        <td>
                                            <asp:TextBox ID="emailTextBox" runat="server" Text='<%# Bind("email") %>' Width="200" MaxLength="50" />
                                            &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator5" ValidationGroup="Form" Display="Dynamic" runat="server" Text="*" ControlToValidate="emailTextBox" class="erro" ToolTip="" SetFocusOnError="true">&otimes;</asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="emailTextBox"  class="erro" Font-Size="10px"  ValidationExpression="^([\w\.\-]+)@([\w\-]+)((\.(\w){2,3})+)$" ValidationGroup="Form">&otimes;</asp:RegularExpressionValidator>
                                        </td>
                                    </tr>


                                    <tr>
                                        <td>Conta:</td>
                                        <td>
                                            <asp:TextBox ID="ContaTextBox" runat="server" Text='<%# Bind("Conta") %>' Width="200" MaxLength="10" />
                                            &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator7" ValidationGroup="Form" Display="Dynamic" runat="server" Text="*" ControlToValidate="ContaTextBox" class="erro" ToolTip="" SetFocusOnError="true">&otimes;</asp:RequiredFieldValidator>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td>NIB:</td>
                                        <td>
                                            <asp:TextBox ID="nibTextBox" runat="server" Text='<%# Bind("NIB") %>' Width="200" MaxLength="21" />
                                            &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator6" ValidationGroup="Form" Display="Dynamic" runat="server" Text="*" ControlToValidate="nibTextBox" class="erro" ToolTip="" SetFocusOnError="true">&otimes;</asp:RequiredFieldValidator>
                                 <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="nibTextBox" ErrorMessage="NIB invalido . Só é permitido Numeros." class="erro" Font-Size="10px"  ValidationExpression="(?:\d*)?\d+" ValidationGroup="Form">&otimes;</asp:RegularExpressionValidator>

                                             
                                        </td>
                                    </tr>


                                    <tr>
                                        <td colspan="2">
                                            <br />
                                            <asp:Button ID="btnInsertButton" ValidationGroup="Form" CssClass="ui-button ui-corner-all" runat="server" Text="Adicionar" CommandName="Insert" CausesValidation="True" OnClick="btnInsertButton_Click" />
                                        </td>

                                        <tr>

                                            <tr>
                                                <td colspan="2"></td>
                                                <tr>
                                </table>
                            </div>
                            <h3>Bancos</h3>
                            <div>
                                <asp:GridView ID="GridView1" runat="server"
                                    AllowPaging="True" AutoGenerateColumns="False"
                                    CellPadding="2" DataKeyNames="bancoID" DataSourceID="SqlDataSourceINSERTALL"
                                    PagerSettings-PageButtonCount="15" PageSize="10"
                                    HeaderStyle-CssClass="SGCRowHeader"
                                    AlternatingRowStyle-CssClass="SGCdadosBodyAlt"
                                    RowStyle-CssClass="SGCdadosBodyNorm">
                                    <AlternatingRowStyle BackColor="White" />
                                    <Columns>
                                        <asp:BoundField DataField="bancoID" ReadOnly="true" HeaderText="ID" SortExpression="bancoID" ItemStyle-Width="20px" ControlStyle-Width="20px" ItemStyle-HorizontalAlign="Right" Visible="false"></asp:BoundField>
                                        <asp:BoundField DataField="nome" HeaderText="Nome" SortExpression="nome" ItemStyle-Width="150px" ControlStyle-Width="150px" ItemStyle-HorizontalAlign="Left"></asp:BoundField>
                                        <asp:BoundField DataField="moradasede" HeaderText="Morada" SortExpression="moradasede" ItemStyle-Width="150" />
                                        <asp:BoundField DataField="telefonesede" HeaderText="Telefone" SortExpression="telefonesede" ItemStyle-Width="80" />
                                        <asp:BoundField DataField="nomecontacto" HeaderText="Nome contacto" SortExpression="nomecontacto" ItemStyle-Width="120" />
                                        <asp:BoundField DataField="email" HeaderText="Email" SortExpression="email" />
                                        <asp:BoundField DataField="conta" HeaderText="conta" SortExpression="conta" />
                                        <asp:BoundField DataField="nib" HeaderText="NIB" SortExpression="NIB" />

                                        <asp:CommandField EditText="Editar" HeaderText="Operações" UpdateText="Actualizar" CancelText="Cancelar" DeleteText="Eliminar" ShowDeleteButton="true" ShowEditButton="True" />

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
                            </div>
                        </div>
                    </td>
                </tr>
            </table>
        </InsertItemTemplate>
    </asp:FormView>

    <div id="dialog-confirmInserePeriodo" title="" style="display: none">
        <br />
        <b>Tem a certeza que pretende adicionar um Banco?</b>
    </div>

    <div id="dialog-confirmActualizarPeriodo" title="" style="display: none">
        <br />
        <b>Tem a certeza que pretende actualizar o Banco?</b>
    </div>





    <asp:SqlDataSource ID="SqlDataSourceINSERTALL" runat="server"
        ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"
        InsertCommand="INSERT INTO [master_banco] ([nome], [moradasede], [telefonesede], [nomecontacto], [email],[conta], [nib]) VALUES (@nome, @moradasede, @telefonesede, @nomecontacto, @email, @conta,@nib)"
        UpdateCommand="UPDATE [master_banco] SET [nome] = @nome, [moradasede] = @moradasede, [telefonesede] = @telefonesede, [nomecontacto] = @nomecontacto, [email] = @email, [conta] = @conta,[nib] = @nib WHERE [bancoID] = @bancoID"
        DeleteCommand="DELETE FROM [master_banco] WHERE [bancoID] = @bancoID"
        SelectCommand="SELECT * FROM [master_banco]">

        <DeleteParameters>
            <asp:Parameter Name="bancoID" Type="Int32" />
        </DeleteParameters>

        <InsertParameters>
            <asp:Parameter Name="nome" Type="String" />
            <asp:Parameter Name="moradasede" Type="String" />
            <asp:Parameter Name="telefonesede" Type="String" />
            <asp:Parameter Name="nomecontacto" Type="String" />
            <asp:Parameter Name="email" Type="String" />
            <asp:Parameter Name="conta" Type="String" />
            <asp:Parameter Name="nib" Type="String" />
        </InsertParameters>

        <UpdateParameters>
            <asp:Parameter Name="nome" Type="String" />
            <asp:Parameter Name="moradasede" Type="String" />
            <asp:Parameter Name="telefonesede" Type="String" />
            <asp:Parameter Name="nomecontacto" Type="String" />
            <asp:Parameter Name="email" Type="String" />
            <asp:Parameter Name="conta" Type="String" />
            <asp:Parameter Name="nib" Type="String" />
            <asp:Parameter Name="bancoID" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>

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
