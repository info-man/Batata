<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdminParametrosMunicipios.aspx.cs" Inherits="MASTERSEGUROS.WEB.AdminParametrosMunicipios" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:FormView ID="FormView1" runat="server" DataKeyNames="MunicipioId" DataSourceID="SqlDataSourcemunicipi" DefaultMode="Insert" Width="100%">
        <InsertItemTemplate>
            <table border="0" cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td colspan="2">
                        <div id="accordion">
                            <h3>Parâmetros - Municípios</h3>
                            <div>

                                <table border="0" cellpadding="0" cellspacing="0" style="width: 100%; border-collapse: collapse; font-size: 13px;">
                                    <tr>
                                        <td style="width: 120px">Província:</td>
                                        <td>
                                            <asp:DropDownList ID="ProvinciaIdDropDownList" DataSourceID="SqlDataSourceProv" runat="server" Text='<%# Bind("Nome") %>' Width="250" MaxLength="100" DataValueField="ProvinciaId" DataTextField="Nome" />
                                            &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator1" ValidationGroup="Form" Display="Dynamic" runat="server" Text="*" ControlToValidate="ProvinciaIdDropDownList" class="erro" ToolTip="" SetFocusOnError="true">Preenchimento Obrigatório</asp:RequiredFieldValidator>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td>Municipio :</td>
                                        <td>
                                            <asp:TextBox ID="NomeTextBox" runat="server" Text='<%# Bind("Nome") %>' Width="250" MaxLength="100" />
                                            &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator3" ValidationGroup="Form" Display="Dynamic" runat="server" Text="*" ControlToValidate="NomeTextBox" class="erro" ToolTip="" SetFocusOnError="true">Preenchimento Obrigatório</asp:RequiredFieldValidator>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td>Estado:</td>
                                        <td>
                                            <asp:DropDownList ID="VisibleDropDownList" runat="server" Text='<%# Bind("Visible") %>' Width="100" MaxLength="100">
                                                <asp:ListItem Text="Activo" Value="1"> </asp:ListItem>
                                                <asp:ListItem Text="Inativo" Value="0"> </asp:ListItem>
                                            </asp:DropDownList>
                                            &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator5" ValidationGroup="Form" Display="Dynamic" runat="server" Text="*" ControlToValidate="VisibleDropDownList" class="erro" ToolTip="" SetFocusOnError="true">Preenchimento Obrigatório</asp:RequiredFieldValidator>
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

                       <br />
                           
                                <asp:GridView ID="GridView1" runat="server" DataKeyNames="MunicipioId"
                                    AllowPaging="True" AutoGenerateColumns="False"
                                    CellPadding="4" DataSourceID="SqlDataSourcemunicipi"
                                    PagerSettings-PageButtonCount="15" PageSize="10"
                                    HeaderStyle-CssClass="SGCRowHeader"
                                    AlternatingRowStyle-CssClass="SGCdadosBodyAlt"
                                    RowStyle-CssClass="SGCdadosBodyNorm" OnRowUpdating="GridView1_RowUpdating" OnRowCommand="GridView1_RowCommand" OnRowDataBound="GridView1_RowDataBound">
                                    <AlternatingRowStyle BackColor="White" />
                                    <Columns>
                                        <asp:BoundField DataField="MunicipioId" HeaderText="ID" SortExpression="MunicipioId" ItemStyle-Width="25px" Visible="false" ControlStyle-Width="25px" ItemStyle-HorizontalAlign="Left" InsertVisible="False" ReadOnly="True">
                                            <ControlStyle Width="25px"></ControlStyle>
                                            <ItemStyle HorizontalAlign="Left" Width="25px"></ItemStyle>
                                        </asp:BoundField>
                                        <asp:TemplateField HeaderText="Província" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="120px">
                                            <EditItemTemplate>
                                                <asp:DropDownList runat="server" ID="ProvinciaIdComboBox" AutoPostBack="false" DataSourceID="SqlDataSourceProv" DataTextField="Nome" DataValueField="ProvinciaId" Width="120" AppendDataBoundItems="true" SelectedValue='<%#Bind("ProvinciaId")%>'>
                                                </asp:DropDownList>
                                            </EditItemTemplate>
                                            <ItemTemplate>
                                                <asp:Label runat="server" ItemStyle-HorizontalAlign="Left" Text='<%# ((object)Eval("Nome_Provincia"))%>' /><%--<asp:BoundField DataField="Nome_Provincia" ReadOnly="true" HeaderText="Província" SortExpression="Nome_Provincia" ItemStyle-Width="150px" ControlStyle-Width="150px" ItemStyle-HorizontalAlign="Left"><ControlStyle Width="150px"></ControlStyle><ItemStyle HorizontalAlign="Left" Width="150px"></ItemStyle></asp:BoundField>--%>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="Nome" HeaderText="Município" SortExpression="Nome" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="120px" />
                                        <%-- <asp:BoundField DataField="Visible" HeaderText="Estado" SortExpression="Visible" ItemStyle-HorizontalAlign="Left" />--%>
                                        <asp:TemplateField HeaderText="Estado" ItemStyle-HorizontalAlign="Center" ItemStyle-CssClass="Centro" ItemStyle-Width="80px">
                                            <EditItemTemplate>
                                                <asp:DropDownList ID="VisibleDropDownList2" AutoPostBack="false" AppendDataBoundItems="true" SelectedValue='<%#Bind("visible")%>' runat="server">
                                                    <asp:ListItem Text="Activo" Value='True'></asp:ListItem>
                                                    <asp:ListItem Text="Inactivo" Value='False'></asp:ListItem>
                                                </asp:DropDownList>
                                            </EditItemTemplate>
                                            <ItemTemplate>
                                                <asp:Label runat="server" ItemStyle-HorizontalAlign="Left" Text='<%# BuidDescValor((object)Eval("visible")) %>' />

                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:CommandField HeaderText="Operações" UpdateText="Actualizar" CancelText="Cancelar" EditText="Editar" DeleteText="Eliminar" ShowDeleteButton="True" ShowEditButton="True" ItemStyle-HorizontalAlign="Left" />
                                        <%--<asp:TemplateField HeaderText="Seleccionar" ItemStyle-HorizontalAlign="Center">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="CheckBox1" runat="server" MNCP_ID='<%#(object)Eval("MunicipioId")%>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>--%>
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

    <asp:SqlDataSource ID="SqlDataSourceProv" runat="server"
        ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"
        SelectCommand="SELECT * FROM [master_provincia]"></asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourcemunicipi" runat="server"
        ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"
        SelectCommand="SELECT pr.ProvinciaId as ProvinciaId, mun.MunicipioId as MunicipioId, pr.Nome as Nome_Provincia, mun.Nome as Nome, mun.Visible FROM [master_municipio]  mun inner join [master_provincia] as 
						 pr on mun.ProvinciaId=pr.ProvinciaId ORDER BY  pr.Nome, mun.Nome"
        DeleteCommand="DELETE FROM [master_municipio] WHERE [MunicipioId] = @MunicipioId"
        InsertCommand="INSERT INTO [master_municipio] ([ProvinciaId], [Nome], [Visible]) VALUES (@ProvinciaId, @Nome, @Visible)"
        UpdateCommand="UPDATE [master_municipio] SET  [Nome] = @Nome, [Visible] = @Visible, ProvinciaId=@ProvinciaId WHERE [MunicipioId] = @MunicipioId">

        <DeleteParameters>
            <asp:Parameter Name="MunicipioId" Type="Int32" />
        </DeleteParameters>

        <InsertParameters>
            <asp:ControlParameter ControlID="ctl00$MainContent$FormView1$ProvinciaIdDropDownList" PropertyName="SelectedValue" Name="ProvinciaId" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="Nome" Type="String" />
            <asp:ControlParameter ControlID="ctl00$MainContent$FormView1$VisibleDropDownList" PropertyName="SelectedValue" Name="Visible" Type="Int32" DefaultValue="0" />
        </InsertParameters>

        <UpdateParameters>
            <asp:Parameter Name="ProvinciaId" Type="Int32" />
            <asp:Parameter Name="Nome" Type="String" />
            <asp:Parameter Name="Visible" />
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
