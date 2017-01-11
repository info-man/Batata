<%@ Page Title="Configurações Gerais" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdminParametrosConfiguracoes.aspx.cs" Inherits="MASTERSEGUROS.WEB.AdminParametrosConfiguracoes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePartialRendering="true" />
    <table border="0" cellpadding="0" cellspacing="0" width="100%">
        <tr>
            <td colspan="2">
                <div id="accordion">
                    <h3>Configurações Gerais</h3>
                    <div>


                        <asp:GridView ID="GridView1" runat="server"
                            AllowPaging="True" AutoGenerateColumns="False"
                            CellPadding="3" DataKeyNames="ConfigId" DataSourceID="SqlDataSourceconfiguracoes"
                            PagerSettings-PageButtonCount="15" PageSize="10"
                            HeaderStyle-CssClass="SGCRowHeader"
                            AlternatingRowStyle-CssClass="SGCdadosBodyAlt"
                            RowStyle-CssClass="SGCdadosBodyNorm">
                            <AlternatingRowStyle BackColor="White" />

                            <Columns>
                                <asp:BoundField DataField="ConfigId" ReadOnly="true" Visible="false" HeaderText="ID" InsertVisible="False" SortExpression="ConfigId" />
                                <asp:BoundField DataField="ConfigType" ReadOnly="true" HeaderText="Tipo" SortExpression="ConfigType" />
                                <asp:BoundField DataField="ConfigKey" ReadOnly="true" HeaderText="Chave" SortExpression="ConfigKey" />
                                <asp:BoundField DataField="Descricao" ReadOnly="true" HeaderText="Descrição" SortExpression="Descricao" />
                                <asp:BoundField DataField="Valor" HeaderText="Valor" SortExpression="Valor" ItemStyle-HorizontalAlign="Right" />
                                <asp:CommandField EditText="Editar" HeaderText="Operações" Visible="false" UpdateText="Actualizar" CancelText="Cancelar" ShowDeleteButton="False" ShowEditButton="True" />

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

                        <asp:SqlDataSource ID="SqlDataSourceconfiguracoes" runat="server"
                            ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"
                            DeleteCommand="DELETE FROM [master_configuracao] WHERE [ConfigId] = @ConfigId"
                            InsertCommand="INSERT INTO [master_configuracao] ([ConfigType], [ConfigKey], [Descricao], [Valor]) VALUES (@ConfigType, @ConfigKey, @Descricao, @Valor)"
                            SelectCommand="SELECT * FROM [master_configuracao] ORDER  BY ConfigType"
                            UpdateCommand="UPDATE [master_configuracao] SET  [Valor] = @Valor WHERE [ConfigId] = @ConfigId">
                            <DeleteParameters>
                                <asp:Parameter Name="ConfigId" Type="Int32" />
                            </DeleteParameters>
                            <InsertParameters>
                                <asp:Parameter Name="ConfigType" Type="String" />
                                <asp:Parameter Name="ConfigKey" Type="String" />
                                <asp:Parameter Name="Descricao" Type="String" />
                                <asp:Parameter Name="Valor" Type="String" />
                            </InsertParameters>
                            <UpdateParameters>
                                <asp:Parameter Name="ConfigType" Type="String" />
                                <asp:Parameter Name="ConfigKey" Type="String" />
                                <asp:Parameter Name="Descricao" Type="String" />
                                <asp:Parameter Name="Valor" Type="String" />
                                <asp:Parameter Name="ConfigId" Type="Int32" />
                            </UpdateParameters>
                        </asp:SqlDataSource>
                    </div>
                </div>

            </td>
        </tr>
    </table>


    <div id="ctl00_MainContent_FormView1_ValSummary" style="color: Red; display: none;">
    </div>
    <span id="ctl00_MainContent_FormView1_cstConverterApolice" style="color: Red; display: none;"></span>

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
