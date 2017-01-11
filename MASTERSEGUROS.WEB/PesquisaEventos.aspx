<%@ Page Title="CMSCK - Gestor de Conteúdos" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PesquisaEventos.aspx.cs" Inherits="MASTERSEGUROS.WEB.PesquisaEventos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <h3>Links > Pesquisa de Eventos</h3>
    <br />
   <asp:UpdatePanel ID="UpdatePanel2" runat="server"> 
        <ContentTemplate>  
        <table border="0" cellpadding="3" cellspacing="0" style="vertical-align: top">
                            <tr>
                                <td>ID Link:</td>
                                <td>
                                    <asp:TextBox ID="LinkIDTextBox" runat="server"  Width="30" MaxLength="4" />&nbsp;&nbsp;ID Classificador:&nbsp;<asp:TextBox ID="ClassificadorIDTextBox" Visible="False" runat="server" Width="30" MaxLength="4" />
                                    
                                </td>
                            </tr>
                            <tr>
                                <td>Título:</td>
                                <td>
                                    <asp:TextBox ID="TituloTextBox" runat="server"  Width="398" MaxLength="400" />
                                </td>
                            </tr>
                            <tr>
                                <td>Sub-Título:</td>
                                <td>
                                    <asp:TextBox ID="SubtituloTextBox" runat="server"  Width="398" MaxLength="400" />
                                </td>
                            </tr>
                            <tr>
                                <td>Data:</td>
                                <td>Entrada depois de:&nbsp;<asp:TextBox ID="DataEntradaTextBox"  ValidationGroup="Form" runat="server"  Width ="80" MaxLength="10" />&nbsp;<a class="linkData" name="A_DataEntradaTextBox" id="A_DataEntradaTextBox" href="#" onclick="cal.select(ctl00_MainContent_DataEntradaTextBox,'A_DataEntradaTextBox','dd/MM/yyyy'); return false;"><img style="vertical-align:middle;border:0 "  alt="" onclick=""  src ="images/31.png"/></a><asp:RequiredFieldValidator ValidationGroup="Form" ID="reqValDataEntradaTextBox" Display="Dynamic" runat="server" Text="*"  ControlToValidate="DataEntradaTextBox"  class="erro"  ToolTip="">&nbsp;Preenchimento Obrigatório</asp:RequiredFieldValidator><asp:CompareValidator ID="cVal_DataEntradaTextBox"  Operator="DataTypeCheck"  ControlToValidate="DataEntradaTextBox" runat="server"  Type="Date"  Display="Dynamic" class="erro">&nbsp;Formato incorrecto</asp:CompareValidator>&nbsp;Saída antes de: <asp:TextBox ID="DataSaidaTextBox"  ValidationGroup="Form" runat="server" Width ="80" MaxLength="10" />&nbsp;<a class="linkData" name="A_DataSaidaTextBox" id="A_DataSaidaTextBox" href="#" onclick="cal.select(ctl00_MainContent_DataSaidaTextBox,'A_DataSaidaTextBox','dd/MM/yyyy'); return false;"><img style="vertical-align:middle;border:0 "  alt="" onclick=""  src ="images/31.png"/></a><asp:CompareValidator ID="cVal_DataSaidaTextBox"  Operator="DataTypeCheck"  ControlToValidate="DataSaidaTextBox" runat="server"  Type="Date"  Display="Dynamic" class="erro">&nbsp;Formato incorrecto</asp:CompareValidator>
                                </td>
                            </tr>
                            <tr>
                                <td>Lingua:</td>
                                <td>
                                    Estado:
                                   <asp:DropDownList runat="server"  ID="EstadoComboBox" AutoPostBack ="false" AppendDataBoundItems="true" >
                                        <asp:ListItem Value="-1" Text="" Selected="True"></asp:ListItem>
                                        <asp:ListItem Value="1" Text="Válido" Selected="False"></asp:ListItem>  
                                        <asp:ListItem Value="0" Text="Inválido" Selected="false"></asp:ListItem>                           
                                    </asp:DropDownList><asp:DropDownList runat="server"  Visible="false" ID="LinguaComboBox" AppendDataBoundItems="true"  AutoPostBack ="false" DataSourceID="SqlDataSourceLingua"  DataTextField="Descricao"  DataValueField="LinguaID"  >
                                    <asp:ListItem Value="-1" Text="" Selected="True"></asp:ListItem>
                                    </asp:DropDownList>
                                   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                </td>
                            </tr>
              
                <tr>
                    <td colspan="2">
                       
                        <asp:Button ID="btnPesquisar" CssClass="ui-button2 ui-widget ui-state-default ui-corner-all ui-button-text-only" runat="server" Text="Pesquisar" CommandName="Select" onclick="btnPesquisar_Click"/>
                        <asp:Button ID="btnLimpar" CssClass="ui-button2 ui-widget ui-state-default ui-corner-all ui-button-text-only" runat="server" Text="Limpar" CommandName="Cancel" onclick="btnLimpar_Click" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                    <hr />
                    </td>
                </tr>
            </table>
               
        <div id="dialog-confirmDeleteLink" title="CMSCK" style="display: none">
        <br />
        <b>Tem a certeza que pretende remover o Link?</b>
    </div>

        <asp:GridView ID="GridViewLinks" runat="server"
        AllowPaging="True" AutoGenerateColumns="False"
        CellPadding="2" DataKeyNames="LinkID,Lingua" DataSourceID="SqlDataSourceLink"
        PagerSettings-PageButtonCount="15" PageSize="10"
        HeaderStyle-CssClass="SGCRowHeader"
        AlternatingRowStyle-CssClass="SGCdadosBodyAlt"
        RowStyle-CssClass="SGCdadosBodyNorm">
        <AlternatingRowStyle BackColor="White" />
        <Columns>
            <asp:BoundField DataField="LinkID" HeaderText="ID" SortExpression="LinkID" ItemStyle-Width="50px" />
            <asp:TemplateField HeaderText="Língua" SortExpression="Lingua" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="50px">
                <ItemTemplate>
                    <asp:Label ID="lblLingua" runat="server" Text='<%# BuildLingua((object)Eval("Lingua"))%>'></asp:Label>
                </ItemTemplate>
             </asp:TemplateField>
            <asp:TemplateField HeaderText="Estado" SortExpression="Estado" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="50px">
                <ItemTemplate>  
                    <asp:ImageButton runat="server" ID="imgEstado" OnClick="imgEstado_Click" Estado='<%#(object)Eval("Estado")%>' IDLink='<%#(object)Eval("LinkID")%>' IDLingua='<%#(object)Eval("Lingua")%>'  ImageUrl='<%# BuildEstado((object)Eval("Estado"))%>' ToolTip='<%# BuildToolTipEstado((object)Eval("Estado"),(object)Eval("Titulo"))%>' />
                </ItemTemplate>
             </asp:TemplateField>
             <asp:BoundField DataField="Titulo" HeaderText="Título" SortExpression="Título" />
             <asp:TemplateField HeaderText="Operações" ItemStyle-HorizontalAlign="Center">
                <ItemTemplate>
                    <asp:DropDownList runat="server" ID="ddlOperation" AutoPostBack="true" IDLink='<%#(object)Eval("LinkID")%>' IDLingua='<%#(object)Eval("Lingua")%>' AppendDataBoundItems="true" Font-Size="12px"  onchange="javascript:if (this.value=='0') {return false;} if (this.value=='2') {return ConfirmDeleteLink(this);} else {true; }" OnSelectedIndexChanged="Operation_SelectedIndexChanged">
                        <asp:ListItem Text="Escolha um opção" Value="0"></asp:ListItem>
                        <asp:ListItem Text="Alterar" Value="1" ></asp:ListItem>
                        <asp:ListItem Text="Remover" Value="2"></asp:ListItem>
                        <asp:ListItem Text="Convidar" Value="4"></asp:ListItem>
                       
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

   <asp:SqlDataSource ID="SqlDataSourceLink" OnUpdated="On_Updated"  OnInserted="On_Inserted" runat="server"
        ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"
        SelectCommandType="StoredProcedure" SelectCommand="spGetListLink">
       <SelectParameters>
           <asp:ControlParameter ControlID="LinkIDTextbox" PropertyName="Text" Name="LinkID" Type="Int32" DefaultValue="-1" />
           <asp:ControlParameter ControlID="ClassificadorIDTextbox" PropertyName="Text" Name="ClassificadorID" Type="Int32" DefaultValue="-1" />
           <asp:ControlParameter ControlID="TituloTextbox" PropertyName="Text" Name="Titulo" ConvertEmptyStringToNull="False" Type="string" />
           <asp:ControlParameter ControlID="SubTituloTextbox" PropertyName="Text" Name="SubTitulo" ConvertEmptyStringToNull="False" Type="string" />
           <asp:ControlParameter ControlID="LinguaComboBox" PropertyName="SelectedValue" Name="Lingua" DefaultValue="-1" Type="Int32" />
           <asp:ControlParameter ControlID="EstadoComboBox" PropertyName="SelectedValue" Name="Estado" DefaultValue="-1" Type="Int32" />
           <asp:ControlParameter ControlID="DataEntradaTextbox" PropertyName="Text" Name="DataEntrada" DefaultValue="01-01-1901" Type="DateTime" />
           <asp:ControlParameter ControlID="DataSaidaTextbox" PropertyName="Text" Name="DataSaida" DefaultValue="01-01-1901" Type="DateTime" />
       </SelectParameters>
    </asp:SqlDataSource>
    
   <asp:SqlDataSource ID="SqlDataSourceTipo" runat="server"
        ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"
        SelectCommand="SELECT * FROM [cmsck_tipo_Link] "></asp:SqlDataSource>

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

       function ConfirmDeleteLink(obj) {
           $("#dialog-confirmDeleteLink").dialog({
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
