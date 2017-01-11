<%@ Page Title="Provincias" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdminParametrosProvincias.aspx.cs" Inherits="MASTERSEGUROS.WEB.AdminParametrosProvincias" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div id="accordion">
        <h3>Parâmetros - Províncias</h3>
        <div>
            <asp:FormView ID="FormView1" runat="server" DataKeyNames="ProvinciaId" DataSourceID="SqlDataSource1" DefaultMode="Insert" Width="100%">

                <InsertItemTemplate>

                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td colspan="2">

                                <table border="0" cellpadding="1" cellspacing="0" style="width: 100%; border-collapse: collapse; font-size: 13px;">
                                    <tr>
                                        <td style="width: 70px">Nome:</td>
                                        <td>
                                            <asp:TextBox ID="NomeTextBox" runat="server" Text='<%# Bind("Nome") %>' Width="250" MaxLength="100" />
                                            &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator3" ValidationGroup="Form" Display="Dynamic" runat="server" Text="*" ControlToValidate="NomeTextBox" class="erro" ToolTip="" SetFocusOnError="true">Preenchimento Obrigatório</asp:RequiredFieldValidator>
                                        </td>
                                    </tr>

                                    <tr>

                                        <td>Estado:</td>
                                        <td>
                                            <asp:DropDownList ID="VisibleDropDownList" runat="server" Text='<%# Bind("Visible") %>' Width="100" MaxLength="100">
                                                <asp:ListItem Text="Activo" Value="True"> </asp:ListItem>
                                                <asp:ListItem Text="Inactivo" Value="False"> </asp:ListItem>
                                            </asp:DropDownList>

                                        </td>
                                    </tr>
                                    <tr>
                                        <td>&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:LinkButton ID="InsertButton" runat="server" CssClass="ui-button ui-corner-all" CausesValidation="True" CommandName="Insert" Text="Adicionar" />
                                        </td>
                                    </tr>

                                </table>
                                <br />
                                <asp:GridView ID="GridView1" runat="server"
                                    AllowPaging="True" AutoGenerateColumns="False"
                                    CellPadding="3" DataKeyNames="ProvinciaId" DataSourceID="SqlDataSource1"
                                    PagerSettings-PageButtonCount="15" PageSize="10"
                                    HeaderStyle-CssClass="SGCRowHeader"
                                    AlternatingRowStyle-CssClass="SGCdadosBodyAlt"
                                    RowStyle-CssClass="SGCdadosBodyNorm">
                                    <AlternatingRowStyle BackColor="White" />
                                    <Columns>
                                        <asp:BoundField DataField="ProvinciaId" Visible="false" HeaderStyle-Width="250px" HeaderText="ID" SortExpression="ProvinciaId" ItemStyle-Width="250px" ControlStyle-Width="250px" ItemStyle-HorizontalAlign="Left" ReadOnly="True" InsertVisible="False"></asp:BoundField>

                                        <asp:BoundField DataField="Nome" HeaderText="Província" SortExpression="Nome" ItemStyle-Width="150px" ControlStyle-Width="150px" ItemStyle-HorizontalAlign="Left"></asp:BoundField>


                                        <asp:TemplateField HeaderText="Estado" SortExpression="Estado" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="80px">
                                            <ItemTemplate>
                                                <asp:Label ID="lblEstado" runat="server" Text='<%# BuildEstado((object)Eval("Visible"))%>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:DropDownList ID="EstadoCombobox" runat="server" Width="90" MaxLength="90" SelectedValue='<%# Bind("Visible") %>'>
                                                    <asp:ListItem Text="Activo" Value="True"> </asp:ListItem>
                                                    <asp:ListItem Text="Inactivo" Value="False"> </asp:ListItem>
                                                </asp:DropDownList>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
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
                    
                         </td>
                        </tr>
                      </table> 

                               
                </InsertItemTemplate>

            </asp:FormView>
        </div>
        <h3>Parâmetros - Municípios</h3>
        <div>
            <asp:FormView ID="FormView2" runat="server" DataKeyNames="ProvinciaId" DataSourceID="SqlDataSourcemunicipi" DefaultMode="Insert" Width="100%">

                <InsertItemTemplate>

                    <table border="0" cellpadding="0" cellspacing="0" style="width: 100%; border-collapse: collapse; font-size: 13px;">
                        <tr>
                            <td style="width: 120px">Província:</td>
                            <td>
                                <asp:DropDownList ID="ProvinciaIdDropDownList" ValidationGroup="Form2" DataSourceID="SqlDataSourceProv" runat="server" Text='<%# Bind("Nome") %>' Width="250" MaxLength="100" DataValueField="ProvinciaId" DataTextField="Nome" />
                                &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator1" ValidationGroup="Form2" Display="Dynamic" runat="server" Text="*" ControlToValidate="ProvinciaIdDropDownList" class="erro" ToolTip="" SetFocusOnError="true">Preenchimento Obrigatório</asp:RequiredFieldValidator>
                            </td>
                        </tr>

                        <tr>
                            <td>Municipio :</td>
                            <td>
                                <asp:TextBox ID="NomeMunicipioTextBox" runat="server" ValidationGroup="Form2" Text='<%# Bind("Nome") %>' Width="250" MaxLength="100" />
                                &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator2" ValidationGroup="Form2" Display="Dynamic" runat="server" Text="*" ControlToValidate="NomeMunicipioTextBox" class="erro" ToolTip="" SetFocusOnError="true">Preenchimento Obrigatório</asp:RequiredFieldValidator>
                            </td>
                        </tr>

                        <tr>
                            <td>Estado:</td>
                            <td>
                                <asp:DropDownList ID="MunicipioVisibleComboBox" ValidationGroup="Form2" runat="server" Text='<%# Bind("Visible") %>' Width="100" MaxLength="100">
                                    <asp:ListItem Text="Activo" Value="True"> </asp:ListItem>
                                    <asp:ListItem Text="Inativo" Value="False"> </asp:ListItem>
                                </asp:DropDownList>
                                &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator5" ValidationGroup="Form2" Display="Dynamic" runat="server" Text="*" ControlToValidate="MunicipioVisibleComboBox" class="erro" ToolTip="" SetFocusOnError="true">Preenchimento Obrigatório</asp:RequiredFieldValidator>
                            </td>
                        </tr>

                        <tr>
                            <td colspan="2">
                                <br />
                                <asp:Button ID="btnInsertButton2" ValidationGroup="Form2" CssClass="ui-button ui-corner-all" runat="server" Text="Adicionar" CommandName="Insert" CausesValidation="True" />
                            </td>
                            <tr>
                                <tr>
                                    <td colspan="2"></td>
                                    <tr>
                    </table>

                    <br />

                    <asp:GridView ID="GridView2" runat="server" DataKeyNames="MunicipioId"
                        AllowPaging="True" AutoGenerateColumns="False"
                        CellPadding="4" DataSourceID="SqlDataSourcemunicipi"
                        PagerSettings-PageButtonCount="15" PageSize="10"
                        HeaderStyle-CssClass="SGCRowHeader"
                        AlternatingRowStyle-CssClass="SGCdadosBodyAlt"
                        RowStyle-CssClass="SGCdadosBodyNorm">
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
                                        <asp:ListItem Text="Activo" Value="True"></asp:ListItem>
                                        <asp:ListItem Text="Inactivo" Value="False"></asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label runat="server" ItemStyle-HorizontalAlign="Left" Text='<%# BuildEstado((object)Eval("visible")) %>' />

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
                </InsertItemTemplate>
            </asp:FormView>
        </div>

    </div>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"
        DeleteCommand="DELETE FROM [master_provincia] WHERE [ProvinciaId] = @ProvinciaId"
        InsertCommand="INSERT INTO [master_provincia] ([Nome], [Visible]) VALUES (@Nome, @Visible)"
        SelectCommand="SELECT * FROM [master_provincia]"
        UpdateCommand="UPDATE [master_provincia] SET [Nome] = @Nome, [Visible] = @Visible WHERE [ProvinciaId] = @ProvinciaId">
        <DeleteParameters>
            <asp:Parameter Name="ProvinciaId" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="Nome" Type="String" />
            <asp:Parameter Name="Visible" Type="Boolean" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="Nome" Type="String" />
            <asp:Parameter Name="Visible" Type="Boolean" />
            <asp:Parameter Name="ProvinciaId" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>

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
            <asp:ControlParameter ControlID="ctl00$MainContent$FormView2$ProvinciaIdDropDownList" PropertyName="SelectedValue" Name="ProvinciaId" Type="Int32" DefaultValue="0" />
            <asp:ControlParameter ControlID="ctl00$MainContent$FormView2$NomeMunicipioTextBox" PropertyName="Text" Name="Nome" Type="String" />
            <asp:ControlParameter ControlID="ctl00$MainContent$FormView2$MunicipioVisibleComboBox" PropertyName="SelectedValue" Name="Visible" Type="Boolean" DefaultValue="True" />
        </InsertParameters>

        <UpdateParameters>
            <asp:Parameter Name="ProvinciaId" Type="Int32" />
            <asp:Parameter Name="Nome" Type="String" />
            <asp:Parameter Name="Visible" Type="Boolean" />
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
                    active: <%=ActiveAccordion%>
                    });
            }
            /*
        else
        {
            $("#accordion").accordion({
                active: 0
            });
        }
        */

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




