<%@ Page Title="Marcas" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdminParametrosMarcas.aspx.cs" Inherits="MASTERSEGUROS.WEB.AdminParametrosMarcas" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">


    <asp:FormView ID="FormView1" runat="server" DataKeyNames="MarcaID" DataSourceID="SqlDataSourceINSERTALL" DefaultMode="Insert" Width="100%" OnPageIndexChanging="FormView1_PageIndexChanging">
        <EditItemTemplate>
            MarcaID:
            <asp:Label ID="MarcaIDLabel1" runat="server" Text='<%# Eval("MarcaID") %>' />
            <br />
            Descricao:
            <asp:TextBox ID="DescricaoTextBox" runat="server" Text='<%# Bind("Descricao") %>' />
            <br />
            Estado:
            <asp:TextBox ID="EstadoTextBox" runat="server" Text='<%# Bind("Estado") %>' />
            <br />
            <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" />
            &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
        </EditItemTemplate>
        <InsertItemTemplate>
            <table border="0" cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td colspan="2">
                        <div id="accordion">
                            <h3>Parâmetros - Marcas</h3>
                            <div>
                                <table border="0" cellpadding="0" cellspacing="0" style="width: 100%; border-collapse: collapse; font-size: 13px;">


                                    <tr>

                                        <td  style="width:120px" >Descricao:</td>
                                        <td>
                                            <asp:TextBox ID="DescricaoTextBox" runat="server" Text='<%# Bind("Descricao") %>' />
                                            &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator2" ValidationGroup="Form" Display="Dynamic" runat="server" Text="*" ControlToValidate="DescricaoTextBox" class="erro" ToolTip="" SetFocusOnError="true">Preenchimento Obrigatório</asp:RequiredFieldValidator>
                                            <br />
                                        </td>
                                    </tr>

                                    <tr>
                                        <td>Estado:</td>
                                        <td>
                                            <asp:DropDownList runat="server" Text='<%# Bind("Estado") %>' ID="Estado_Marca">
                                                <asp:ListItem Selected="True" Text="Activo" Value="1"></asp:ListItem>
                                                 <asp:ListItem Text="Inactivo" Value="0"></asp:ListItem>
                                            </asp:DropDownList>
                                            <%--<asp:TextBox ID="EstadoTextBox" runat="server" Text='<%# Bind("Estado") %>' />--%>
               &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator3" ValidationGroup="Form" Display="Dynamic" runat="server" Text="*" ControlToValidate="Estado_Marca" class="erro" ToolTip="" SetFocusOnError="true">Preenchimento Obrigatório</asp:RequiredFieldValidator>
                                            <br />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <br />


                                            <asp:Button ID="InsertButton" ValidationGroup="Form" CssClass="ui-button ui-corner-all" runat="server" CausesValidation="True" CommandName="Insert" Text="Adicionar" />
                                            <%--&nbsp;<asp:Button ID="btnapagar" CssClass="ui-button ui-corner-all" runat="server" CausesValidation="False" CommandName="Delete" Text="Eliminar selecionados" OnClick="btnapagar_Click" />--%>
                                </table>



                            </div>
                            <h3>Marcas</h3>

                            <div>


                                <asp:GridView ID="GridView1" runat="server"
                                    AllowPaging="True" AutoGenerateColumns="False"
                                    CellPadding="3" DataKeyNames="MarcaID" DataSourceID="SqlDataSourceINSERTALL"
                                    PagerSettings-PageButtonCount="15" PageSize="10"
                                    HeaderStyle-CssClass="SGCRowHeader"
                                    AlternatingRowStyle-CssClass="SGCdadosBodyAlt"
                                    RowStyle-CssClass="SGCdadosBodyNorm">
                                    <AlternatingRowStyle BackColor="White" />
                                    <Columns>
                                        <asp:BoundField DataField="MarcaID" Visible="false" HeaderStyle-Width="250px" HeaderText="MarcaID"
                                            SortExpression="MarcaID" ItemStyle-Width="250px" ControlStyle-Width="250px" ItemStyle-HorizontalAlign="Left" ReadOnly="True" InsertVisible="False"></asp:BoundField>

                                        <asp:BoundField DataField="Descricao" HeaderText="Descricao"
                                            SortExpression="Descricao" ItemStyle-Width="300px" ControlStyle-Width="300px" ItemStyle-HorizontalAlign="Left"></asp:BoundField>
                                        <asp:TemplateField HeaderText="Estado" SortExpression="Estado" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="0px">
                                            <ItemTemplate>
                                                <asp:Label ID="lblEstado" runat="server" Text='<%# BuildEstado((object)Eval("Estado"))%>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:DropDownList ID="EstadoCombobox" runat="server" Width="80" MaxLength="80" SelectedValue='<%#Bind("Estado")%>'>
                                                    <asp:ListItem Text="Activo" Value="1"> </asp:ListItem>
                                                    <asp:ListItem Text="Inactivo" Value="0"> </asp:ListItem>
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


                            </div>
                    </td>
                </tr>
               
            </table>

        </InsertItemTemplate>



        <ItemTemplate>
            MarcaID:
            <asp:Label ID="MarcaIDLabel" runat="server" Text='<%# Eval("MarcaID") %>' />
            <br />
            Descricao:
            <asp:Label ID="DescricaoLabel" runat="server" Text='<%# Bind("Descricao") %>' />
            <br />
            Estado:
            <asp:Label ID="EstadoLabel" runat="server" Text='<%# Bind("Estado") %>' />
            <br />



        </ItemTemplate>


    </asp:FormView>






    <asp:SqlDataSource ID="SqlDataSourceINSERTALL" runat="server"
        ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"
        SelectCommand="SELECT * FROM [master_marca_veiculo]" DeleteCommand="DELETE FROM [master_marca_veiculo] WHERE [MarcaID] = @MarcaID" InsertCommand="INSERT INTO [master_marca_veiculo] ([Descricao], [Estado]) VALUES (@Descricao, @Estado)" UpdateCommand="UPDATE [master_marca_veiculo] SET [Descricao] = @Descricao, [Estado] = @Estado WHERE [MarcaID] = @MarcaID">
        <DeleteParameters>
            <asp:Parameter Name="MarcaID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="Descricao" Type="String" />
            <asp:Parameter Name="Estado" Type="Int32" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="Descricao" Type="String" />
            <asp:Parameter Name="Estado" Type="Int32" />
            <asp:Parameter Name="MarcaID" Type="Int32" />
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

