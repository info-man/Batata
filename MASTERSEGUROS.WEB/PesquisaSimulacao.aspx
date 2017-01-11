<%@ Page Title="Consultar Simulações/Proposta" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PesquisaSimulacao.aspx.cs" Inherits="MASTERSEGUROS.WEB.PesquisaSimulacao" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

    <table border="0" cellpadding="0" cellspacing="0" width="100%">
        <tr>
            <td colspan="2">
                <div id="accordion">
                    <h3>Pesquisa de Simulações/Propostas</h3>
                    <div>
                        <table border="0" cellpadding="0" cellspacing="0" style="width: 100%; border-collapse: collapse; font-size: 13px;">

                            <tr>
                                <td style="width: 80px">Número:</td>
                                <td>
                                    <asp:TextBox ID="NumeroTextBox" runat="server" Width="40" MaxLength="4" /></td>
                            </tr>
                            <tr>
                                <td>Ramo:</td>
                                <td>
                                    <asp:DropDownList runat="server" ID="RamoComboBox" DataSourceID="SqlDataSourceRamo" DataTextField="Descricao" DataValueField="RamoId" AppendDataBoundItems="true" AutoPostBack="false" Width="160px">
                                        <asp:ListItem Value="" Text="Seleccione um opção"></asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td>Província:</td>
                                <td>
                                    <asp:DropDownList runat="server" ID="ProvinciaIDComboBox" AutoPostBack="false" Width="160px" AppendDataBoundItems="true" DataSourceID="SqlDataSourceProvincia" DataValueField="ProvinciaId" DataTextField="Nome">
                                        <asp:ListItem Value="-1" Text="Seleccione um opção"></asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td>Tomador:</td>
                                <td>
                                    <asp:TextBox ID="NomeTextbox" runat="server" Width="300" MaxLength="300" />

                                </td>
                            </tr>
                            <tr>
                                <td>Gestor:</td>
                                <td>
                                    <asp:TextBox ID="GestorTextBox" runat="server" Width="300" MaxLength="300" />

                                </td>
                            </tr>
                            <tr>
                                <td>Data Início:</td>
                                <td>
                                    <asp:TextBox ID="DataInicioTextBox" Text='<%#Bind("DataInicio") %>' runat="server" Width="75" MaxLength="10" /><img alt="Data de Início" src="images/31.png" style="vertical-align: text-bottom" />
                                    <asp:RangeValidator ID="RngValDataInicioTextBox" ValidationGroup="Form" Display="Dynamic" runat="server" Type="Date" ControlToValidate="DataInicioTextBox" MaximumValue="01-01-2100" MinimumValue="01-01-1900" ToolTip="" SetFocusOnError="true">&otimes;</asp:RangeValidator>
                                    Data Fim:&nbsp;
                                <asp:TextBox ID="DataFimTextBox" Text='<%#Bind("DataFim") %>' runat="server" Width="75" MaxLength="10" /><img alt="Data de Início" src="images/31.png" style="vertical-align: text-bottom" />
                                    <asp:RangeValidator ID="RngValDataFimTextBox" ValidationGroup="Form" Display="Dynamic" runat="server" Type="Date" ControlToValidate="DataFimTextBox" MaximumValue="01-01-2100" MinimumValue="01-01-1900" ToolTip="" SetFocusOnError="true">&otimes;</asp:RangeValidator>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <br />

                                </td>
                            </tr>
                        </table>
                        <asp:Button ID="btnPesquisar" ValidationGroup="Form" CssClass="ui-button ui-corner-all" runat="server" Text="Pesquisar" CommandName="Select" OnClick="btnPesquisar_Click" />

                    </div>
                    <h3>Resultados da Pesquisa</h3>
                    <div>
                        <asp:GridView ID="GridViewProposta" runat="server" Width="900px"
                            AllowPaging="True" AutoGenerateColumns="False"
                            CellPadding="2" DataKeyNames="PropostaID" DataSourceID="SqlDataSourceProposta"
                            PagerSettings-PageButtonCount="15" PageSize="10"
                            HeaderStyle-CssClass="SGCRowHeader"
                            AlternatingRowStyle-CssClass="SGCdadosBodyAlt"
                            RowStyle-CssClass="SGCdadosBodyNorm">
                            <AlternatingRowStyle BackColor="White" />
                            <Columns>
                                <asp:BoundField DataField="NumeroProposta" HeaderText="Nr. Proposta" SortExpression="NumeroProposta" ItemStyle-Width="110px" />
                                <asp:TemplateField HeaderText="Produto" SortExpression="Produto" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="100px">
                                    <ItemTemplate>
                                        <asp:Label ID="lblTipo" runat="server" Text='<%# BuildTipo((object)Eval("Tipo"))%>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Ramo" SortExpression="Ramo" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="70px">
                                    <ItemTemplate>
                                        <asp:Label ID="lblRamo" runat="server" Text='<%# BuildRamo((object)Eval("RamoId"))%>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="Nome" HeaderText="Nome" SortExpression="Nome" />

                                <asp:TemplateField HeaderText="Província" SortExpression="ProvinciaID" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="70px">
                                    <ItemTemplate>
                                        <asp:Label ID="lblProvincia" runat="server" Text='<%# BuildProvincia((object)Eval("ProvinciaID"))%>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="DataInicio" HeaderText="Data Início" SortExpression="DataInicio" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="80px" DataFormatString="{0:MM-dd-yyyy}" />

                                <asp:BoundField DataField="Username" HeaderText="Gestor" SortExpression="Username" ItemStyle-Width="120px" />
                                <asp:TemplateField HeaderText="Operações" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="90px">
                                    <ItemTemplate>
                                        <asp:DropDownList runat="server" ID="ddlOperation" TIPO='<%#(object)Eval("Tipo")%>' APLID='<%#(object)Eval("PropostaID")%>' Style="font-family: Open Sans; font-size: 11px; padding: 0px; margin: 3px;" OnChange="javascript: RedirectProposta(this);">
                                            <asp:ListItem Text="Escolha uma opção" Value="0"></asp:ListItem>
                                            <asp:ListItem Text="Editar" Value="1"></asp:ListItem>
                                            <asp:ListItem Text="Remover" Value="2"></asp:ListItem>
                                        </asp:DropDownList>
                                    </ItemTemplate>
                                </asp:TemplateField>

                            </Columns>
                            <EditRowStyle />
                            <FooterStyle Font-Bold="False" ForeColor="White" />
                            <HeaderStyle Font-Bold="False" ForeColor="White" HorizontalAlign="Center" />
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
 
    <div id="dialog-confirmDeleteClassificador" title="CTT" style="display: none">
        <br />
        <b>Tem a certeza que pretende remover?</b>
    </div>

    <asp:SqlDataSource ID="SqlDataSourceProposta" runat="server"
        ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"
        SelectCommandType="StoredProcedure"
        SelectCommand="spGetListProposta">
        <SelectParameters>
            <asp:ControlParameter ControlID="NumeroTextBox" PropertyName="Text" Name="NumeroProposta" ConvertEmptyStringToNull="False" Type="string" />
            <asp:ControlParameter ControlID="RamoComboBox" PropertyName="SelectedValue" Name="RamoID" DefaultValue="-1" Type="Int32" />
            <asp:ControlParameter ControlID="ProvinciaIDComboBox" PropertyName="SelectedValue" Name="ProvinciaID" DefaultValue="-1" Type="Int32" />
            <asp:ControlParameter ControlID="NomeTextbox" PropertyName="Text" Name="Nome" ConvertEmptyStringToNull="False" Type="string" />
            <asp:ControlParameter ControlID="GestorTextBox" PropertyName="Text" Name="Gestor" ConvertEmptyStringToNull="False" Type="string" />
            <asp:ControlParameter ControlID="DataInicioTextBox" PropertyName="Text" Name="DataInicio" DefaultValue="01-01-1901" Type="DateTime" />
            <asp:ControlParameter ControlID="DataFimTextBox" PropertyName="Text" Name="DataFim" DefaultValue="01-01-1901" Type="DateTime" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceProvincia" runat="server"
        ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"
        SelectCommand="SELECT * FROM [master_provincia] ORDER BY NOME "></asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceRamo" runat="server"
        ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"
        SelectCommand="SELECT * FROM [master_ramo] ORDER BY descricao"></asp:SqlDataSource>

    <script type="text/javascript">
    
        $("#accordion").accordion({
            heightStyle: "content"
        });

        $(function () {

            $("#ctl00_MainContent_DataInicioTextBox").datepicker();
            $("#ctl00_MainContent_DataInicioTextBox").datepicker("option", "dateFormat", "dd/mm/yy");

            $("#ctl00_MainContent_DataFimTextBox").datepicker();
            $("#ctl00_MainContent_DataFimTextBox").datepicker("option", "dateFormat", "dd/mm/yy");


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
            //alert(acordID);
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

        function RedirectProposta(obj)
        {
            if (obj.value==0) 
                return false; 
            else
            { 
                if (obj.getAttribute('TIPO')=='1')
                    location.href = 'AdminSimulacaoUpdate.aspx?prpID=' + obj.getAttribute('APLID');

                if (obj.getAttribute('TIPO')=='2')
                    location.href = 'AdminSimulacaoFrotaUpdate.aspx?prpID=' + obj.getAttribute('APLID');
            }
            obj.value=0
        }
    </script>

</asp:Content>
