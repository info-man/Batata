<%@ Page Title="CTT" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PesquisaMilitante.aspx.cs" Inherits="MASTERSEGUROS.WEB.PesquisaMilitante" %>


<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <h3>Militantes > Pesquisa de Militantes</h3>
    <br />

    <asp:UpdatePanel ID="UpdatePanel2" runat="server"> 
        <ContentTemplate>  
            <table border="0" cellpadding="3" cellspacing="0" style="vertical-align: top">
                <tr>
                    <td>Nr. CAP:</td>
                    <td>

                        <asp:TextBox ID="CAPIDTextBox" runat="server" Width="30" MaxLength="4" />&nbsp;<asp:Button ID="Button2" ValidationGroup="Form" CssClass="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" runat="server" Text="Seleccionar" CausesValidation="false" OnClientClick="return ConfirmEscolheClassificadorPai();" />
                    </td>
                </tr>

                <tr>
                    <td>Nr. Militante:</td>
                    <td>
                        <asp:TextBox ID="MilitanteIDTextbox" runat="server" Width="30" MaxLength="4" />
                    </td>
                </tr>

                <tr>
                    <td>Nome:</td>
                    <td>
                        <asp:TextBox ID="NomeTextBox" runat="server"  Width="398" MaxLength="400" />

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
                    <td>Nome:</td>
                    <td>
                        <asp:TextBox ID="BITextbox" runat="server"  Width="398" MaxLength="400" />

                    </td>
                </tr>


              
                <tr>
                    <td>Estado:</td>
                    <td>
                        <asp:DropDownList runat="server"  ID="EstadoComboBox" AutoPostBack ="false" AppendDataBoundItems="true" >
                            <asp:ListItem Value="-1" Text="" Selected="True"></asp:ListItem>
                            <asp:ListItem Value="1" Text="Válido" Selected="False"></asp:ListItem>  
                            <asp:ListItem Value="0" Text="Inválido" Selected="false"></asp:ListItem>                           
                        </asp:DropDownList>
                            &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator2" ValidationGroup="Form" Display="Dynamic" runat="server" Text="*" ControlToValidate="EstadoComboBox" class="erro" ToolTip="" SetFocusOnError="true">Preenchimento Obrigatório</asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <asp:Button ID="btnPesquisar" CssClass="ui-button2 ui-widget ui-state-default ui-corner-all ui-button-text-only" runat="server" Text="Pesquisar" CommandName="Select" onclick="btnPesquisar_Click"/>
                        <asp:Button ID="btnLimpar" CssClass="ui-button2 ui-widget ui-state-default ui-corner-all ui-button-text-only" runat="server" Text="Limpar" CommandName="Cancel" onclick="btnLimpar_Click" />
                        <hr />
                    </td>
                </tr>
            </table>
               
            <div id="dialog-confirmDeleteClassificador" title="CTT" style="display: none">
        <br />
        <b>Tem a certeza que pretende remover o Militante?</b>
    </div>

            <div id="dialog-form" title="CTT" style="display: none">
       <b>Comités de Acção Política:</b>
 <table id="users" class="ui-widget ui-widget-content">
	
     <asp:GridView ID="gridviewCAP" runat="server"
        AllowPaging="False" AllowSorting="False" AutoGenerateColumns="False"
        CellPadding="4" DataKeyNames="CAPID" DataSourceID="SqlDataSourceCTTPopUp"
        PagerSettings-PageButtonCount="15" PageSize="15"
        HeaderStyle-CssClass="SGCRowHeader"
        AlternatingRowStyle-CssClass="SGCdadosBodyAlt"
        RowStyle-CssClass="SGCdadosBodyNorm" >
        <AlternatingRowStyle BackColor="White" />
        <Columns>

             <asp:BoundField DataField="CAPID" HeaderText="ID" 
            SortExpression="CAPID"  ItemStyle-HorizontalAlign="Right"/>

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

            <asp:GridView ID="GridViewMilitante" runat="server"
        AllowPaging="True" AutoGenerateColumns="False"
        CellPadding="2" DataKeyNames="MilitanteID" DataSourceID="SqlDataSourceMilitante"
        PagerSettings-PageButtonCount="15" PageSize="10"
        HeaderStyle-CssClass="SGCRowHeader"
        AlternatingRowStyle-CssClass="SGCdadosBodyAlt"
        RowStyle-CssClass="SGCdadosBodyNorm">
        <AlternatingRowStyle BackColor="White" />
        <Columns>
            <asp:BoundField DataField="CAPID" HeaderText="Nr. CAP" SortExpression="CAPID" ItemStyle-Width="50px" />
            <asp:BoundField DataField="MilitanteID" HeaderText="Nr. Militante" SortExpression="MilitanteID" ItemStyle-Width="70px" />
            <asp:BoundField DataField="Nome" HeaderText="Nome" SortExpression="Nome" ItemStyle-Width="200px"/>
            <asp:BoundField DataField="BI" HeaderText="BI" SortExpression="BI" />
            <asp:TemplateField HeaderText="Estado" SortExpression="Estado" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="50px">
                <ItemTemplate>  
                    <asp:ImageButton runat="server" ID="imgEstado" OnClick="imgEstado_Click" Estado='<%#(object)Eval("Estado")%>' IDMIL='<%#(object)Eval("MilitanteID")%>'  ImageUrl='<%# BuildEstado((object)Eval("Estado"))%>' ToolTip='<%# BuildToolTipEstado((object)Eval("Estado"),(object)Eval("Nome"))%>' />
                </ItemTemplate>
             </asp:TemplateField>
             <asp:TemplateField HeaderText="Operações" ItemStyle-HorizontalAlign="Center">
                <ItemTemplate>
                    <asp:DropDownList runat="server" ID="ddlOperation" AutoPostBack="true" IDClass='<%#(object)Eval("MilitanteID")%>'  AppendDataBoundItems="true" Font-Size="12px"  onchange="javascript:if (this.value=='0') {return false;} if (this.value=='2') {return ConfirmDeleteClassificador(this);} else {true; }" OnSelectedIndexChanged="Operation_SelectedIndexChanged">
                        <asp:ListItem Text="Escolha um opção" Value="0"></asp:ListItem>
                        <asp:ListItem Text="Alterar" Value="1" ></asp:ListItem>
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
    
    <asp:SqlDataSource ID="SqlDataSourceMilitante"  runat="server"
        ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"
        SelectCommandType="StoredProcedure" 
        SelectCommand="spGetListMilitante">
       <SelectParameters>
           <asp:ControlParameter ControlID="CAPIDTextBox" PropertyName="Text" Name="CAPID" Type="Int32" DefaultValue="-1" />
           <asp:ControlParameter ControlID="MilitanteIDTextbox" PropertyName="Text" Name="MilitanteID" Type="Int32" DefaultValue="-1" />
           <asp:ControlParameter ControlID="NomeTextbox" PropertyName="Text" Name="Nome" ConvertEmptyStringToNull="False" Type="string" />
           <asp:ControlParameter ControlID="ProvinciaIDComboBox" PropertyName="Text" Name="ProvinciaID" ConvertEmptyStringToNull="False" Type="string" />
           <asp:ControlParameter ControlID="MunicipioIDComboBox" PropertyName="SelectedValue" Name="MunicipioID" Type="Int32" />
           <asp:ControlParameter ControlID="BITextbox" PropertyName="Text" Name="BI" ConvertEmptyStringToNull="False" Type="string" />
           <asp:ControlParameter ControlID="EstadoComboBox" PropertyName="SelectedValue" Name="Estado" DefaultValue="-1" Type="Int32" />
       </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceProvincia" runat="server"
        ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"
        SelectCommand="SELECT * FROM [master_provincia] ORDER BY NOME "></asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceMunicipio" runat="server"
        ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"
        SelectCommand="SELECT * FROM [master_municipio] ORDER BY NOME"></asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceCTTPopUp" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" 
        SelectCommand="SELECT cap.CAPID, cap.Numero, cap.Nome, p.ProvinciaId, p.Nome as NomeProvincia, m.MunicipioId,m.Nome as NomeMunicipio, c.ComunaId, c.Nome as NomeComuna FROM [dbo].[mpla_cap] cap 
        INNER JOIN [dbo].[master_provincia] p ON cap.ProvinciaID = p.ProvinciaId
        INNER JOIN [dbo].[master_municipio] m on cap.MunicipioID= m.MunicipioId
        INNER JOIN [dbo].[master_comuna] c ON cap.ComunaId = c.ComunaId">
</asp:SqlDataSource>

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
