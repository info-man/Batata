<%@ Page Title="CMSCK - Gestor de Conteúdos" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PesquisaClassificador.aspx.cs" Inherits="MASTERSEGUROS.WEB.PesquisaClassificador" %>


<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <h3>Classificadores > Pesquisa de Classificadores</h3>
    <br />
  <asp:UpdatePanel ID="UpdatePanel2" runat="server"> 
        <ContentTemplate>  
            <table border="0" cellpadding="3" cellspacing="0" style="vertical-align: top">
                <tr>
                    <td>ID:</td>
                    <td>
                        <asp:TextBox ID="ClassificadorIDTextBox" runat="server"  Width="30" MaxLength="4" />&nbsp;&nbsp;ID Pai:&nbsp;<asp:TextBox ID="ClassificadorPaiIDTextBox" runat="server" Width="30" MaxLength="4" />
                    </td>
                </tr>
                <tr>
                    <td>Nome:</td>
                    <td>
                        <asp:TextBox ID="NomeTextBox" runat="server"  Width="398" MaxLength="400" />
                        &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator5" ValidationGroup="Form" Display="Dynamic" runat="server" Text="*" ControlToValidate="NomeTextBox" class="erro" ToolTip="" SetFocusOnError="true">Preenchimento Obrigatório</asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td>Descrição:</td>
                    <td>
                        <asp:TextBox ID="DescricaoTextBox" Rows="3"  runat="server" TextMode="MultiLine" Width="394"  Height="30" />
                                    
                    </td>
                </tr>
                <tr>
                    <td>Lingua:</td>
                    <td>
                        <asp:DropDownList runat="server"  ID="LinguaComboBox" AppendDataBoundItems="true"  AutoPostBack ="false" DataSourceID="SqlDataSourceLingua"  DataTextField="Descricao"  DataValueField="LinguaID"  >
                        <asp:ListItem Value="-1" Text="" Selected="True"></asp:ListItem>
                        </asp:DropDownList>
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
               
   <div id="dialog-confirmDeleteClassificador" title="CMSCK" style="display: none">
        <br />
        <b>Tem a certeza que pretende remover o classificador?</b>
    </div>

    
 <asp:GridView ID="GridViewClassificador" runat="server"
        AllowPaging="True" AutoGenerateColumns="False"
        CellPadding="2" DataKeyNames="ClassificadorID,Lingua" DataSourceID="SqlDataSourceClassificador"
        PagerSettings-PageButtonCount="15" PageSize="10"
        HeaderStyle-CssClass="SGCRowHeader"
        AlternatingRowStyle-CssClass="SGCdadosBodyAlt"
        RowStyle-CssClass="SGCdadosBodyNorm">
        <AlternatingRowStyle BackColor="White" />
        <Columns>
            
             <asp:BoundField DataField="ClassificadorID" HeaderText="ID" SortExpression="ClassificadorID" ItemStyle-Width="50px" />
             <asp:BoundField DataField="ClassificadorPaiID" HeaderText="ID Pai" SortExpression="ClassificadorPaiID" ItemStyle-Width="50px" />
             <asp:BoundField DataField="Ordem" HeaderText="Ordem" SortExpression="Ordem" ItemStyle-Width="40px" />
            <asp:TemplateField HeaderText="Língua" SortExpression="Lingua" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="50px">
                <ItemTemplate>
                    <asp:Label ID="lblLingua" runat="server" Text='<%# BuildLingua((object)Eval("Lingua"))%>'></asp:Label>
                </ItemTemplate>
             </asp:TemplateField>
            <asp:TemplateField HeaderText="Estado" SortExpression="Estado" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="50px">
                <ItemTemplate>  
                    <asp:ImageButton runat="server" ID="imgEstado" OnClick="imgEstado_Click" Estado='<%#(object)Eval("Estado")%>' IDClass='<%#(object)Eval("ClassificadorID")%>' IDLingua='<%#(object)Eval("Lingua")%>'  ImageUrl='<%# BuildEstado((object)Eval("Estado"))%>' ToolTip='<%# BuildToolTipEstado((object)Eval("Estado"),(object)Eval("Nome"))%>' />
                </ItemTemplate>
             </asp:TemplateField>
             <asp:BoundField DataField="Nome" HeaderText="Nome" SortExpression="Nome" />
             <asp:TemplateField HeaderText="Operações" ItemStyle-HorizontalAlign="Center">
                <ItemTemplate>
                    <asp:DropDownList runat="server" ID="ddlOperation" AutoPostBack="true" IDClass='<%#(object)Eval("ClassificadorID")%>' IDLingua='<%#(object)Eval("Lingua")%>' AppendDataBoundItems="true" Font-Size="12px"  onchange="javascript:if (this.value=='0') {return false;} if (this.value=='2') {return ConfirmDeleteClassificador(this);} else {true; }" OnSelectedIndexChanged="Operation_SelectedIndexChanged">
                        <asp:ListItem Text="Escolha um opção" Value="0"></asp:ListItem>
                        <asp:ListItem Text="Alterar" Value="1" ></asp:ListItem>
                        <asp:ListItem Text="Remover" Value="2"></asp:ListItem>
                        <asp:ListItem Text="Traduzir" Value="3"></asp:ListItem>
                        <asp:ListItem Text="Conteúdos" Value="4"></asp:ListItem>
                        <asp:ListItem Text="Associar | Ver" Value="5"></asp:ListItem>
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
        <EmptyDataTemplate >Não foram encontrados registos</EmptyDataTemplate>
     
    </asp:GridView>
    </ContentTemplate>
    </asp:UpdatePanel> 
    <asp:SqlDataSource ID="SqlDataSourceClassificador" OnUpdated="On_Updated"  OnInserted="On_Inserted" runat="server"
        ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"
        SelectCommandType="StoredProcedure" 
        SelectCommand="spGetListClassificador">
       <SelectParameters>
           <asp:ControlParameter ControlID="ClassificadorIDTextbox" PropertyName="Text" Name="ClassificadorID" Type="Int32" DefaultValue="-1" />
           <asp:ControlParameter ControlID="ClassificadorPaiIDTextbox" PropertyName="Text" Name="ClassificadorPaiID" Type="Int32" DefaultValue="-1" />
           <asp:ControlParameter ControlID="NomeTextbox" PropertyName="Text" Name="Nome" ConvertEmptyStringToNull="False" Type="string" />
           <asp:ControlParameter ControlID="DescricaoTextbox" PropertyName="Text" Name="Descricao" ConvertEmptyStringToNull="False" Type="string" />
             <asp:ControlParameter ControlID="LinguaComboBox" PropertyName="SelectedValue" Name="Lingua" Type="Int32" />
           <asp:ControlParameter ControlID="EstadoComboBox" PropertyName="SelectedValue" Name="Estado" DefaultValue="-1" Type="Int32" />

            

       </SelectParameters>
    </asp:SqlDataSource>
   
   <asp:SqlDataSource ID="SqlDataSourceTipo" runat="server"
        ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"
        SelectCommand="SELECT * FROM [cmsck_tipo_classificador] "></asp:SqlDataSource>

   <asp:SqlDataSource ID="SqlDataSourceLingua" runat="server"
        ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"
        SelectCommand="SELECT * FROM [cmsck_lingua] "></asp:SqlDataSource>

   <asp:SqlDataSource ID="SqlDataSourceNivelInteresse" runat="server"
        ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"
        SelectCommand="SELECT * FROM [cmsck_nivel_interesse] "></asp:SqlDataSource>

   <asp:SqlDataSource ID="SqlDataSourceTemplate" runat="server"
        ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"
        SelectCommand="SELECT * FROM [cmsck_template] "></asp:SqlDataSource>


<script type="text/javascript">

    function ConfirmDeleteClassificador(obj) {
        $("#dialog-confirmDeleteClassificador").dialog({
            title: "CMSCK - Gestor de Conteúdos",
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

</script>

</asp:Content>
