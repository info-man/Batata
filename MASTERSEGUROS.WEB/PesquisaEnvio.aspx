<%@ Page Title="Clientes" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PesquisaEnvio.aspx.cs" Inherits="MASTERSEGUROS.WEB.PesquisaEnvio" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    
    <asp:UpdatePanel ID="UpdatePanel2" runat="server"> 
        <ContentTemplate>  
           <div id="accordion">
                <h3>Pesquisa de Apólice</h3>
                <div>
                    <table border="0" cellpadding="1" cellspacing="0"   style="vertical-align: top;width:100%;border-collapse:collapse;font-size: 14px;">
            <tr>
                <td style="width:80px" >Nr. Cliente:</td>
                <td>
                    <asp:TextBox ID="TextBox1" runat="server" Width="30" MaxLength="4" />
                </td>
            </tr>
            <tr>
                <td style="width:80px" >Nr. Apólice:</td>
                <td>
                    <asp:TextBox ID="CAPIDTextBox" runat="server" Width="30" MaxLength="4" />
                </td>
            </tr>

            
                
                <tr>
                <td>Província:</td>
                <td>
                    <asp:DropDownList runat="server"  ID="ProvinciaIDComboBox" AutoPostBack ="false"  Width="200px"    AppendDataBoundItems="true"  DataSourceID="SqlDataSourceProvincia"   DataValueField="ProvinciaId"  DataTextField="Nome" >
                                        
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td>Município:</td>
                <td>
                    <asp:DropDownList runat="server"  ID="MunicipioIDComboBox" AutoPostBack ="false"   Width="200px"   AppendDataBoundItems="true"   DataSourceID="SqlDataSourceMunicipio"   DataValueField="MunicipioId"  DataTextField="Nome" >
                                        
                    </asp:DropDownList>
                </td>
            </tr>
                <tr>
                <td>BI:</td>
                <td>
                    <asp:TextBox ID="BITextbox" runat="server"  Width="398" MaxLength="400" />

                </td>
            </tr>
            <tr>
                <td>Estado:</td>
                <td>
                    <asp:DropDownList runat="server"  ID="EstadoComboBox" AutoPostBack ="false" AppendDataBoundItems="true" >
                        <asp:ListItem Value="-1" Text="" Selected="True"></asp:ListItem>
                        <asp:ListItem Value="1" Text="Enviado" Selected="False"></asp:ListItem>
                        <asp:ListItem Value="2" Text="Recolhido" Selected="False"></asp:ListItem>
                        <asp:ListItem Value="3" Text="Em Trânsito" Selected="False"></asp:ListItem>  
                        <asp:ListItem Value="4" Text="Entregue" Selected="False"></asp:ListItem>
                        <asp:ListItem Value="5" Text="Devolvido" Selected="False"></asp:ListItem>                          
                    </asp:DropDownList>
                        &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator2" ValidationGroup="Form" Display="Dynamic" runat="server" Text="*" ControlToValidate="EstadoComboBox" class="erro" ToolTip="" SetFocusOnError="true">Preenchimento Obrigatório</asp:RequiredFieldValidator>
                </td>
            </tr>
                <tr>
                <td colspan="2"></td>
                </tr>
            <tr>
                <td colspan="2">
                    <asp:Button ID="btnPesquisar" CssClass="ui-button2 ui-widget ui-state-default ui-corner-all ui-button-text-only" runat="server" Text="Pesquisar" CommandName="Select" onclick="btnPesquisar_Click"/>
                    <asp:Button ID="btnLimpar" CssClass="ui-button2 ui-widget ui-state-default ui-corner-all ui-button-text-only" runat="server" Text="Limpar" CommandName="Cancel" onclick="btnLimpar_Click" />
                    <hr />
                </td>
            </tr>
        </table>
        </div> 
            </div>
            <div id="dialog-confirmDeleteClassificador" title="CTT" style="display: none">
        <br />
        <b>Tem a certeza que pretende remover o Militante?</b>
    </div>

            <div id="dialog-form" title="CTT" style="display: none">
       <b>Correios de Angola:</b>
 <table id="users" class="ui-widget ui-widget-content">
	
     <asp:GridView ID="gridviewCAP" runat="server"
        AllowPaging="False" AllowSorting="False" AutoGenerateColumns="False"
        CellPadding="4" DataKeyNames="CAPID" DataSourceID=""
        PagerSettings-PageButtonCount="15" PageSize="15"
        HeaderStyle-CssClass="SGCRowHeader"
        AlternatingRowStyle-CssClass="SGCdadosBodyAlt"
        RowStyle-CssClass="SGCdadosBodyNorm" >
        <AlternatingRowStyle BackColor="White" />
        <Columns>

            <asp:BoundField DataField="Numero" HeaderText="Número" 
            SortExpression="Numero"  ItemStyle-HorizontalAlign="Right"/>
            
            <asp:BoundField DataField="Nome" ItemStyle-Width="150px" HeaderText="Nome" 
            SortExpression="Nome"  ItemStyle-HorizontalAlign="Left" />

            <asp:BoundField DataField="NomeProvincia" ItemStyle-Width="75px" HeaderText="Província" 
            SortExpression="NomeProvincia"  ItemStyle-HorizontalAlign="Left" />
      
            <asp:BoundField DataField="NomeMunicipio" ItemStyle-Width="75px" HeaderText="Município" 
            SortExpression="NomeMunicipio"  ItemStyle-HorizontalAlign="Left" />

            <asp:BoundField DataField="NomeComuna" ItemStyle-Width="75px" HeaderText="Comuna" 
            SortExpression="Comuna"  ItemStyle-HorizontalAlign="Left" />


          <asp:TemplateField HeaderText="Operações"  ItemStyle-HorizontalAlign="Left">
                <ItemTemplate>
                    <asp:LinkButton ID="lnkSelClassificador" runat="server" Text='Seleccionar'  OnClientClick='<%# Eval("CAPID", "SelClassificador(\"{0}\");") %>'></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
        
        </Columns>
        <EditRowStyle BackColor="#C2F0C4" />
        <FooterStyle BackColor="#427c97" Font-Bold="False" ForeColor="White" />
        <HeaderStyle Font-Bold="False" ForeColor="White" />
        <PagerSettings PageButtonCount="15"></PagerSettings>
        <PagerStyle BackColor="#427c97" ForeColor="White" HorizontalAlign="Center" Height="10" CssClass="PagerStyle" />
        <RowStyle BackColor="#E3EAEB" />
        <SelectedRowStyle BackColor="#C5BBAF" Font-Bold="False" ForeColor="#333333" />
        <SortedAscendingCellStyle BackColor="#F8FAFA" />
        <SortedAscendingHeaderStyle BackColor="#1F6500" />
        <SortedDescendingCellStyle BackColor="#D4DFE1" />
        <SortedDescendingHeaderStyle BackColor="#1F6500" />
        <EmptyDataRowStyle BorderStyle="None" BorderWidth="0px" />
        <EmptyDataTemplate>Não foram encontrados registos</EmptyDataTemplate>
    </asp:GridView>
 </table>
</div>

            <asp:GridView ID="GridViewApoliceCliente" runat="server"
        AllowPaging="True" AutoGenerateColumns="False"
        CellPadding="2" DataKeyNames="ClienteID,ApoliceID" DataSourceID="SqlDataSourceApoliceCliente"
        PagerSettings-PageButtonCount="15" PageSize="10"
        HeaderStyle-CssClass="SGCRowHeader"
        AlternatingRowStyle-CssClass="SGCdadosBodyAlt"
        RowStyle-CssClass="SGCdadosBodyNorm">
        <AlternatingRowStyle BackColor="White" />
        <Columns>
            <asp:BoundField DataField="ClienteID" HeaderText="Nr. Cliente" SortExpression="ClienteID" ItemStyle-Width="60px" />
            <asp:BoundField DataField="ApoliceID" HeaderText="Nr. Apólice" SortExpression="ClienteID" ItemStyle-Width="60px" />
            <asp:BoundField DataField="ParcelamentoID" HeaderText="Parcelamento" SortExpression="ParcelamentoID" ItemStyle-Width="60px" />
            <asp:BoundField DataField="RamoID" HeaderText="Ramo" SortExpression="RamoID" ItemStyle-Width="60px" />
            <asp:BoundField DataField="Nome" HeaderText="Nome" SortExpression="Nome" ItemStyle-Width="200px"/>
            <asp:BoundField DataField="Morada" HeaderText="Morada" SortExpression="Morada" />
            <asp:BoundField DataField="ProvinciaID" HeaderText="ProvinciaID" SortExpression="ProvinciaID" />
           

             <asp:TemplateField HeaderText="Operações" ItemStyle-HorizontalAlign="Center">
                <ItemTemplate>
                    <asp:DropDownList runat="server" ID="ddlOperation" AutoPostBack="true"   AppendDataBoundItems="true" Font-Size="12px"  OnChange="javascript:document.location='AdminCliente.aspx?cid=' + this.value;"  >
                        <asp:ListItem Text="Escolha um opção" Value="0"></asp:ListItem>
                        <asp:ListItem Text="Ver" Value="1" ></asp:ListItem>
                        <asp:ListItem Text="Remover" Value="2"></asp:ListItem>
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
        </ContentTemplate>
    </asp:UpdatePanel> 
    
    <asp:SqlDataSource ID="SqlDataSourceApoliceCliente"  runat="server"
        ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"
        SelectCommandType="Text" 
        SelectCommand="SELECT  ma.ApoliceID, ma.NumeroApolice, ma.ParcelamentoID, ma.RamoID, mc.ClienteID, Nome, Morada, ProvinciaID, MunicipioID, ComunaID, Telefone, Telemovel, Email, BI, NIF, ProfissaoID, CartaConducaoData
FROM master_cliente mc inner join master_cliente_apolice mca on mc.ClienteID=mca.ClienteID inner join master_apolice ma on mca.ApoliceID = ma.ApoliceID">
      
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceProvincia" runat="server"
        ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"
        SelectCommand="SELECT * FROM [master_provincia] ORDER BY NOME "></asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceMunicipio" runat="server"
        ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"
        SelectCommand="SELECT * FROM [master_municipio] ORDER BY NOME"></asp:SqlDataSource>

   

    <script type="text/javascript">

    function ConfirmDeleteClassificador(obj) {
        $("#dialog-confirmDeleteClassificador").dialog({
            title: "CTT",
            resizable: false,
            width: 430,
            height: 200,
            modal: true,
            buttons: {
                "Sim": function () {
                    $(this).dialog("close");
                    <%=this.Page.ClientScript.GetPostBackEventReference(new PostBackOptions(this.btnLimpar))%>;
                    },
                    "Não": function () {
                        $(this).dialog("close");
                        return false;
                    }
                }

            });
            //return false;
    }

    function ConfirmEscolheClassificadorPai() {
        $("#dialog-form").dialog({
            title: "CTT",
            autoOpen: true,
            resizable: false,
            height: 500,
            width: 550,
            modal: true,
            buttons: {

                "Cancelar": function () {
                    $(this).dialog("close");
                    return false;
                }
            }
        });
        return false;
    }

</script>

</asp:Content>
