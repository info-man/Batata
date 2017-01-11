<%@ Page Title="Tipo de categorias" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdminParametrosTipocategoria.aspx.cs" Inherits="MASTERSEGUROS.WEB.AdminParametrosTipocategoria" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:FormView ID="FormView1" runat="server" DataKeyNames="codigo" DataSourceID="SqlDataSourceTipocategoria" DefaultMode="Insert" Width="100%">
        <InsertItemTemplate>
            <table border="0" cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td colspan="2">
                        <div id="accordion">
                            <h3>Parâmetros - Tipo Categorias</h3>
                            <div>

                                <table>
                                    <tr>
                                        <td>Codigo:
                                        </td>

                                        <td>
                                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Codigo") %>' MaxLength="5" />
                                       <asp:RequiredFieldValidator ID="RequiredFieldValidator5" ValidationGroup="Form" Display="Dynamic" runat="server" Text="*" ControlToValidate="TextBox1" class="erro" ToolTip="" SetFocusOnError="true">&otimes;</asp:RequiredFieldValidator>
                                         <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="TextBox1"  CssClass="erro"  ValidationExpression="(?:\d*)?\d+" ValidationGroup="Form">&otimes;</asp:RegularExpressionValidator>

                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Categoria:
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="DropDownList1" runat="server" Text='<%# Bind("CategoriaID") %>' DataSourceID="SqlDataSource_CategoriaID" DataTextField="Descricao" DataValueField="CategoriaID">
                                            </asp:DropDownList>

                                        </td>
                                    </tr>

                                    <tr>
                                        <td>Descricao Categoria:
                                        </td>
                                        <td>
                                            <asp:TextBox ID="Descricao_CategoriaTextBox" runat="server" Text='<%# Bind("Descricao") %>' />
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ValidationGroup="Form" Display="Dynamic" runat="server" Text="*" ControlToValidate="Descricao_CategoriaTextBox" class="erro" ToolTip="" SetFocusOnError="true">&otimes;</asp:RequiredFieldValidator>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>TXDP:
                                        </td>
                                        <td>
                                            <asp:TextBox ID="TXDPTextBox" runat="server" Text='<%# Bind("TXDP") %>' />
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ValidationGroup="Form" Display="Dynamic" runat="server" Text="*" ControlToValidate="TXDPTextBox" class="erro" ToolTip="" SetFocusOnError="true">&otimes;</asp:RequiredFieldValidator>
                                         <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="TXDPTextBox" class="erro" ValidationExpression="(?:\d*)?\d+" ValidationGroup="Form">&otimes;</asp:RegularExpressionValidator>
                                        </td>

                                    </tr>
                                    <tr>
                                        <td>Ocupantes:
                                        </td>
                                        <td>

                                            <asp:DropDownList runat="server" Text='<%# Bind("Ocupantes") %>' ID="DropDownListOcupantes">
                                                <asp:ListItem Text="Sim" Value="0"></asp:ListItem>
                                                <asp:ListItem Text="Não" Value="0"></asp:ListItem>
                                            </asp:DropDownList>
                                            &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator1" ValidationGroup="Form" Display="Dynamic" runat="server" Text="*" ControlToValidate="DropDownListOcupantes" class="erro" ToolTip="" SetFocusOnError="true">&otimes;</asp:RequiredFieldValidator>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>CapitalRC:</td>
                                        <td>
                                            <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("CapitalRC") %>' />
                                       <asp:RequiredFieldValidator ID="RequiredFieldValidator4" ValidationGroup="Form" Display="Dynamic" runat="server" Text="*" ControlToValidate="TextBox3" class="erro" ToolTip="" SetFocusOnError="true">&otimes;</asp:RequiredFieldValidator>

                                     <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="TextBox3" class="erro"  ValidationExpression="(?:\d*)?\d+" ValidationGroup="Form">&otimes;</asp:RegularExpressionValidator>

                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Premio Fixo:</td>
                                        <td>
                                            <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("PremioFixo") %>' />
                                                                                   <asp:RequiredFieldValidator ID="RequiredFieldValidator6" ValidationGroup="Form" Display="Dynamic" runat="server" Text="*" ControlToValidate="TextBox4" class="erro" ToolTip="" SetFocusOnError="true">&otimes;</asp:RequiredFieldValidator>

                                       <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="TextBox4" class="erro" ValidationExpression="(?:\d*)?\d+" ValidationGroup="Form">&otimes;</asp:RegularExpressionValidator>

                                        </td>
                                    </tr>

                                </table>



                                <asp:Button ID="InsertButton" runat="server"  ValidationGroup="Form" CssClass="ui-button ui-corner-all" CausesValidation="True" CommandName="Insert" Text="Adicionar" />
                                <%-- <asp:Button ID="btneliminar" CssClass="ui-button ui-corner-all" runat="server" CausesValidation="False" CommandName="Cancel" Text="Eliminar seleção" OnClick="btneliminar_Click1" />--%>
                            </div>
                            <h3>Tipos de Categorias</h3>

                            <div>

                                <asp:GridView ID="GridView1" runat="server"
                                    AllowPaging="True" AutoGenerateColumns="False"
                                    CellPadding="3" DataKeyNames="Codigo" DataSourceID="SqlDataSourceTipocategoria"
                                    PagerSettings-PageButtonCount="15" PageSize="10"
                                    HeaderStyle-CssClass="SGCRowHeader"
                                    AlternatingRowStyle-CssClass="SGCdadosBodyAlt"
                                    RowStyle-CssClass="SGCdadosBodyNorm">
                                    <AlternatingRowStyle BackColor="White" />


                                    <Columns>
                                        <asp:BoundField DataField="Codigo" HeaderText="Codigo" ReadOnly="True" SortExpression="Codigo" />
                                        <asp:BoundField DataField="CategoriaID" HeaderText="CategoriaID" ReadOnly="true" SortExpression="CategoriaID" />
                                        <asp:BoundField DataField="Descricao" HeaderText="Descricao" SortExpression="Descricao" />

                                        <asp:BoundField DataField="TXDP" HeaderText="TXDP" SortExpression="TXDP" />
                                        <asp:TemplateField HeaderText="Ocupantes" SortExpression="Ocupantes" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="0px" >
                                            <ItemTemplate>
                                                <asp:Label ID="lblEstado" runat="server" Text='<%#Buildocupantes((object)Eval("Ocupantes"))%>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:DropDownList ID="EstadoCombobox" runat="server" Width="80" MaxLength="80" SelectedValue='<%#Bind("Ocupantes")%>'>
                                                    <asp:ListItem Text="Sim" Value="1"> </asp:ListItem>
                                                    <asp:ListItem Text="Não" Value="0"> </asp:ListItem>
                                                </asp:DropDownList>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="Ocupantes" HeaderText="Ocupantes" Visible="false" SortExpression="Ocupantes" />
                                        <asp:BoundField DataField="CapitalRC" HeaderText="CapitalRC" SortExpression="CapitalRC" />
                                        <asp:BoundField DataField="PremioFixo" HeaderText="PremioFixo" SortExpression="PremioFixo" />


                                        
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
        </InsertItemTemplate>
   <%--     <ItemTemplate>
            Codigo:
            <asp:Label ID="CodigoLabel" runat="server" Text='<%# Eval("Codigo") %>' />
            <br />
            CategoriaID:
            <asp:Label ID="CategoriaIDLabel" runat="server" Text='<%# Bind("CategoriaID") %>' />
            <br />
            Descricao:
            <asp:Label ID="DescricaoLabel" runat="server" Text='<%# Bind("Descricao") %>' />
            <br />
            TXDP:
            <asp:Label ID="TXDPLabel" runat="server" Text='<%# Bind("TXDP") %>' />
            <br />
            Ocupantes:
            <asp:Label ID="OcupantesLabel" runat="server" Text='<%# Bind("Ocupantes") %>' />
            <br />
            CapitalRC:
            <asp:Label ID="CapitalRCLabel" runat="server" Text='<%# Bind("CapitalRC") %>' />
            <br />
            PremioFixo:
            <asp:Label ID="PremioFixoLabel" runat="server" Text='<%# Bind("PremioFixo") %>' />
            <br />
            <asp:LinkButton ID="EditButton" runat="server" CausesValidation="True" CommandName="Edit" Text="Edit" />
            &nbsp;<asp:LinkButton ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete" />
            &nbsp;<asp:LinkButton ID="NewButton" runat="server" CausesValidation="False" CommandName="New" Text="New" />
        </ItemTemplate>--%>


</asp:FormView>



    <asp:SqlDataSource ID="SqlDataSource_CategoriaID" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"
        SelectCommand="SELECT [Descricao], [CategoriaID] FROM [master_categoria]" DeleteCommand="DELETE FROM [master_categoria] WHERE [CategoriaID] = @CategoriaID" InsertCommand="INSERT INTO [master_categoria] ([Descricao]) VALUES (@Descricao)" UpdateCommand="UPDATE [master_categoria] SET [Descricao] = @Descricao WHERE [CategoriaID] = @CategoriaID">
        <DeleteParameters>
            <asp:Parameter Name="CategoriaID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="Descricao" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="Descricao" Type="String" />
            <asp:Parameter Name="CategoriaID" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceTipocategoria" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"
        DeleteCommand="DELETE FROM [master_tipo_categoria] WHERE [Codigo] = @Codigo"
        InsertCommand="INSERT INTO [master_tipo_categoria] ([Codigo], [CategoriaID], [Descricao], [TXDP], [Ocupantes], [CapitalRC], [PremioFixo]) VALUES (@Codigo, @CategoriaID, @Descricao, @TXDP, @Ocupantes, @CapitalRC, @PremioFixo)"
        SelectCommand="SELECT * FROM [master_tipo_categoria]"
        UpdateCommand="UPDATE [master_tipo_categoria] SET [CategoriaID] = @CategoriaID, [Descricao] = @Descricao, [TXDP] = @TXDP, [Ocupantes] = @Ocupantes, [CapitalRC] = @CapitalRC, [PremioFixo] = @PremioFixo WHERE [Codigo] = @Codigo">
        <DeleteParameters>
            <asp:Parameter Name="Codigo" Type="String" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="Codigo" Type="String" />

            <asp:Parameter Name="CategoriaID" Type="Int32" />
            <asp:Parameter Name="Descricao" Type="String" />
            <asp:Parameter Name="TXDP" Type="Int32" />
            <asp:Parameter Name="Ocupantes" Type="Int32" />
            <asp:Parameter Name="CapitalRC" Type="Decimal" />
            <asp:Parameter Name="PremioFixo" Type="Decimal" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="CategoriaID" Type="Int32" />
            <asp:Parameter Name="Descricao" Type="String" />
            <asp:Parameter Name="TXDP" Type="Int32" />
            <asp:Parameter Name="Ocupantes" Type="Int32" />
            <asp:Parameter Name="CapitalRC" Type="Decimal" />
            <asp:Parameter Name="PremioFixo" Type="Decimal" />
            <asp:Parameter Name="Codigo" Type="String" />
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
