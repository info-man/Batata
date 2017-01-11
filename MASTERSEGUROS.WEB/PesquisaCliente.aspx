<%@ Page Title="Clientes" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PesquisaCliente.aspx.cs" Inherits="MASTERSEGUROS.WEB.PesquisaCliente" %>


<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

    <table border="0" cellpadding="0" cellspacing="0" width="100%">
        <tr>
            <td colspan="2">
                <div id="accordion">
                    <h3>Pesquisa de Cliente</h3>
                    <div>
                        <table border="0" cellpadding="1" cellspacing="0" style="vertical-align: top; width: 100%; border-collapse: collapse; font-size: 13px;">
                            <tr>
                                <td style="width: 90px">Nr. Cliente:</td>
                                <td>
                                    <asp:TextBox ID="ClienteIDTextBox" runat="server" Width="49" MaxLength="6" />
                                </td>
                            </tr>

                            <tr>
                                <td>Nome:</td>
                                <td>
                                    <asp:TextBox ID="NomeTextBox" runat="server" Width="398" MaxLength="400" />

                                </td>
                            </tr>

                            <tr>
                                <td>Província:</td>
                                <td>
                                    <asp:DropDownList runat="server" ID="ProvinciaIDComboBox" AutoPostBack="false" Width="200px" AppendDataBoundItems="true" DataSourceID="SqlDataSourceProvincia" DataValueField="ProvinciaId" DataTextField="Nome">
                                        <asp:ListItem Value="-1" Text="Seleccione um opção"></asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>

                            <tr>
                                <td>Telemóvel:</td>
                                <td>
                                    <asp:TextBox ID="TelemovelTextbox" runat="server" Width="398" MaxLength="400" />

                                </td>
                            </tr>

                            <tr>
                                <td colspan="2"></td>
                            </tr>
                        </table>
                        <asp:Button ID="btnPesquisar" ValidationGroup="Form" CssClass="ui-button ui-corner-all" runat="server" Text="Pesquisar" CommandName="Select" OnClick="btnPesquisar_Click" />
                    </div>
                    <h3>Resultados da Pesquisa</h3>
                    <div>
                        <asp:GridView ID="GridViewCliente" runat="server"
                            AllowPaging="True" AutoGenerateColumns="False"
                            CellPadding="2" DataKeyNames="ClienteID" DataSourceID="ClienteDatasource"
                            PagerSettings-PageButtonCount="15" PageSize="10"
                            HeaderStyle-CssClass="SGCRowHeader"
                            AlternatingRowStyle-CssClass="SGCdadosBodyAlt"
                            RowStyle-CssClass="SGCdadosBodyNorm">
                            <AlternatingRowStyle BackColor="White" />
                            <Columns>
                                <asp:BoundField DataField="ClienteID" HeaderText="Número" SortExpression="ClienteID" ItemStyle-Width="50px" ItemStyle-HorizontalAlign="Right" />
                                <asp:BoundField DataField="Nome" HeaderText="Nome" SortExpression="Nome" ItemStyle-Width="200px" />
                                <asp:BoundField DataField="Morada" HeaderText="Morada" SortExpression="Morada" ItemStyle-Width="200px" />
                                <asp:TemplateField HeaderText="Província" SortExpression="ProvinciaID" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="70px">
                                    <ItemTemplate>
                                        <asp:Label ID="lblProvincia" runat="server" Text='<%# BuildProvincia((object)Eval("ProvinciaID"))%>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="Telemovel" HeaderText="Telemovel" SortExpression="Morada" ItemStyle-Width="80px" />
                                <asp:TemplateField HeaderText="Operações" ItemStyle-HorizontalAlign="Left">
                                    <ItemTemplate>
                                        <asp:DropDownList runat="server" ID="ddlOperation" CLI_ID='<%#(object)Eval("ClienteID")%>' Style="font-family: Open Sans; font-size: 11px; padding: 0px; margin: 3px;" AppendDataBoundItems="true" OnChange="javascript: RedirectCliente(this);">
                                            <asp:ListItem Text="Escolha um opção" Value="0"></asp:ListItem>
                                            <asp:ListItem Text="Editar" Value="1"> </asp:ListItem>
                                        </asp:DropDownList>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <EditRowStyle />
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
                            <EmptyDataTemplate>Não foram encontrados resultados</EmptyDataTemplate>
                        </asp:GridView>

                    </div>
                </div>
            </td>
        </tr>
    </table>

    <asp:SqlDataSource ID="ClienteDatasource" runat="server"
        ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"
        SelectCommandType="StoredProcedure"
        SelectCommand="spGetListCliente">
        <SelectParameters>
            <asp:ControlParameter ControlID="ClienteIDTextBox" PropertyName="Text" Name="ClienteID" Type="Int32" DefaultValue="-1" />
            <asp:ControlParameter ControlID="ProvinciaIDComboBox" PropertyName="Text" Name="ProvinciaID" ConvertEmptyStringToNull="False" Type="string" />
            <asp:ControlParameter ControlID="NomeTextbox" PropertyName="Text" Name="Nome" ConvertEmptyStringToNull="False" Type="string" />
            <asp:ControlParameter ControlID="TelemovelTextBox" PropertyName="Text" Name="Telemovel" ConvertEmptyStringToNull="False" Type="string" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceProvincia" runat="server"
        ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"
        SelectCommand="SELECT * FROM [master_provincia] ORDER BY NOME  "></asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceMunicipio" runat="server"
        ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"
        SelectCommand="SELECT * FROM [master_municipio] ORDER BY NOME"></asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceCTTPopUp" runat="server"
        ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"
        SelectCommand="SELECT cap.CAPID, cap.Numero, cap.Nome, p.ProvinciaId, p.Nome as NomeProvincia, m.MunicipioId,m.Nome as NomeMunicipio, c.ComunaId, c.Nome as NomeComuna FROM [dbo].[mpla_cap] cap 
        INNER JOIN [dbo].[master_provincia] p ON cap.ProvinciaID = p.ProvinciaId
        INNER JOIN [dbo].[master_municipio] m on cap.MunicipioID= m.MunicipioId
        INNER JOIN [dbo].[master_comuna] c ON cap.ComunaId = c.ComunaId"></asp:SqlDataSource>

    <script type="text/javascript">
        
        $("#accordion").accordion({
            heightStyle: "content"
        });


        function GetState ()
        {
            return "true";
        }

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

        function SetAcordion(acordID) {
            alert(acordID);
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

            $("#accordion").accordion({
                active: acordID
            });

        }

        function RedirectCliente(obj)
        {
            if (obj.value==0) 
                return false; 
            else
            { 
                if (obj.value=='1')
                    location.href = 'admincliente.aspx?Cl=' + obj.getAttribute('CLI_ID');      
                
            }
            obj.value=0;
        }
    </script>

</asp:Content>
