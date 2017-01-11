<%@ Page Title="Consultar Apólices" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PesquisaApolice.aspx.cs" Inherits="MASTERSEGUROS.WEB.PesquisaApolice" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>


<table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tr>
        <td colspan="2">
            <div id="accordion">
                <h3>Pesquisa de Apólice</h3>
                <div>
                    <table border="0" cellpadding="0" cellspacing="0"   style="width:100%;border-collapse:collapse;font-size: 13px;">
                <tr>
                    <td style="width:80px" >Nr. Cliente:</td>
                <td>
                    <asp:TextBox ID="ClienteIDTextBox" runat="server" Width="40" MaxLength="4" />
                </td>
            </tr>
            <tr>
                <td style="width:80px" >Nr. Apólice:</td>
                <td>
                    <asp:TextBox ID="NumeroApoliceTextBox" runat="server" Width="100" MaxLength="4" />
                </td>
            </tr>
            <tr>
                <td>Ramo:</td>
                <td>
                    <asp:DropDownList runat="server"  ID="RamoComboBox" DataSourceID="SqlDataSourceRamo" DataTextField="Descricao" DataValueField="RamoId"  AppendDataBoundItems="true" AutoPostBack ="false"  Width="160px">
                        <asp:ListItem Value="" Text="Seleccione um opção"></asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
           <tr>
                <td>Província:</td>
                <td>
                    <asp:DropDownList runat="server"  ID="ProvinciaIDComboBox" AutoPostBack ="false"  Width="160px"    AppendDataBoundItems="true"  DataSourceID="SqlDataSourceProvincia"   DataValueField="ProvinciaId"  DataTextField="Nome" >
                        <asp:ListItem Value="-1" Text="Seleccione um opção"></asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            
            <tr>
                <td>Nome:</td>
                <td>
                    <asp:TextBox ID="NomeTextbox" runat="server"  Width="300" MaxLength="300" />

                </td>
            </tr>
            <tr>
                <td>Estado:</td>
                <td>
                    <asp:DropDownList runat="server"  ID="EstadoCombobox" AppendDataBoundItems="true" AutoPostBack ="false"  Width="160px">
                        <asp:ListItem Value="-1" Text="Seleccione um opção"></asp:ListItem>
                         <asp:ListItem Value="1" Text="Em Cobrança"></asp:ListItem>
                         <asp:ListItem Value="2" Text="Pago"></asp:ListItem>
                         <asp:ListItem Value="3" Text="Emitida"></asp:ListItem>
                         <asp:ListItem Value="4" Text="Anulada"></asp:ListItem>


                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <br />
                                      
                </td>
            </tr>
        </table>
                    <asp:Button ID="btnPesquisar" ValidationGroup="Form"  CssClass="ui-button ui-corner-all"  runat="server" Text="Pesquisar" CommandName="Select" onclick="btnPesquisar_Click"/>

                </div> 
    <h3>Resultados da Pesquisa</h3>
            <div>
<asp:GridView ID="GridViewApoliceCliente" runat="server"
        AllowPaging="True" AutoGenerateColumns="False"
        CellPadding="2" DataKeyNames="ClienteID,ApoliceID" DataSourceID="SqlDataSourceApoliceCliente"
        PagerSettings-PageButtonCount="15" PageSize="10"
        HeaderStyle-CssClass="SGCRowHeader"
        AlternatingRowStyle-CssClass="SGCdadosBodyAlt"
        RowStyle-CssClass="SGCdadosBodyNorm" OnRowDataBound="GridViewApoliceCliente_RowDataBound" >
        <AlternatingRowStyle BackColor="White" />
        <Columns>
            <asp:BoundField DataField="ClienteID" HeaderText="Nr. Cliente" SortExpression="ClienteID" ItemStyle-Width="60px" />
            <asp:BoundField DataField="NumeroApolice" HeaderText="Nr. Apólice" SortExpression="NumeroApolice" ItemStyle-Width="80px" />
            <asp:BoundField DataField="ParcelamentoID" HeaderText="Parcelamento" SortExpression="ParcelamentoID" ItemStyle-Width="60px" ItemStyle-HorizontalAlign="Center" />
            <asp:TemplateField HeaderText="Ramo" SortExpression="Ramo" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="70px">
                <ItemTemplate>
                    <asp:Label ID="lblRamo" runat="server" Text='<%# BuildRamo((object)Eval("RamoId"))%>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="Nome" HeaderText="Nome" SortExpression="Nome" ItemStyle-Width="200px"/>
            <asp:BoundField DataField="Morada" HeaderText="Morada" SortExpression="Morada" />
           
            <asp:TemplateField HeaderText="Província" SortExpression="ProvinciaID" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="70px">
                <ItemTemplate>
                    <asp:Label ID="lblProvincia" runat="server" Text='<%# BuildProvincia((object)Eval("ProvinciaID"))%>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
           
             <asp:TemplateField HeaderText="Documentos" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="70px">
                <ItemTemplate>
                    <asp:DropDownList runat="server" ID="ddlOperation" TIPO='<%#(object)Eval("Tipo")%>' ESTADOAPLID='<%#(object)Eval("EstadoApoliceID")%>'   APLID='<%#(object)Eval("ApoliceID")%>'  style="font-family:Open Sans;font-size: 11px;padding: 0px;margin: 3px;"  OnChange="javascript:if (this.value==0) return false; else window.open('AutoDocument.aspx?docID=' + this.value + '&aplID=' + this.getAttribute('APLID') + '&type=' + this.getAttribute('TIPO'), 'blank');this.value=0">

                    </asp:DropDownList>
                </ItemTemplate>
            </asp:TemplateField>

        </Columns>
        <EditRowStyle />
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
     
    </asp:GridView>
        </div>
                 </div>
</td>
    </tr>
</table> 


     <div id="dialog-confirmDeleteClassificador" title="CTT" style="display: none">
        <br />
        <b>Tem a certeza que pretende remover o Militante?</b>
    </div>
   
    <asp:SqlDataSource ID="SqlDataSourceApoliceCliente"  runat="server"
        ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"
        SelectCommandType="StoredProcedure" 
        SelectCommand="spGetListApolice">
      <SelectParameters>
           <asp:ControlParameter ControlID="ClienteIDTextBox" PropertyName="Text" Name="ClienteID" Type="Int32" DefaultValue="-1" />
           <asp:ControlParameter ControlID="NumeroApoliceTextBox" PropertyName="Text" Name="NumeroApolice" ConvertEmptyStringToNull="False" Type="string" />
           <asp:ControlParameter ControlID="RamoComboBox" PropertyName="SelectedValue" Name="RamoID" DefaultValue="-1" Type="Int32" />
           <asp:ControlParameter ControlID="ProvinciaIDComboBox" PropertyName="SelectedValue" Name="ProvinciaID" DefaultValue="-1" Type="Int32" />
           <asp:ControlParameter ControlID="NomeTextBox" PropertyName="Text" Name="Nome" ConvertEmptyStringToNull="False" Type="string" />
           <asp:ControlParameter ControlID="EstadoComboBox" PropertyName="SelectedValue" Name="Estado" DefaultValue="-1" Type="Int32" />
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
</script>

</asp:Content>
