<%@ Page Title="Rota de Entrega" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Rota.aspx.cs" Inherits="MASTERSEGUROS.WEB.Rota" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

  <script type="text/javascript" src="//maps.google.com/maps/api/js?sensor=true"></script>
  <script type="text/javascript" src="scripts/gmaps.js"></script>
  <script type="text/javascript" src="scripts/prettify.js"></script>
  <link href='//fonts.googleapis.com/css?family=Convergence|Bitter|Droid+Sans|Ubuntu+Mono' rel='stylesheet' type='text/css' />
  <link href='css/styles.css' rel='stylesheet' type='text/css' />
  <link href='css/prettify.css' rel='stylesheet' type='text/css' />
  <link rel="stylesheet" type="text/css" href="css/examples.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <h3>Envio > Rota</h3>
    <br />

    <asp:UpdatePanel ID="UpdatePanel2" runat="server"> 
        <ContentTemplate>  
           
           
               
            <div id="dialog-confirmDeleteClassificador" title="CTT" style="display: none">
        <br />
        <b>Tem a certeza que pretende remover o a Rota?</b>
    </div>

            <div id="dialog-form" title="CTT" style="display: none">
       <b>Correios de Angola:</b>
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

            <asp:GridView ID="GridViewEnvio" runat="server"
        AllowPaging="True" AutoGenerateColumns="False"
        CellPadding="2" DataKeyNames="RemetenteID" DataSourceID="SqlDataSourceEnvio"
        PagerSettings-PageButtonCount="15" PageSize="10"
        HeaderStyle-CssClass="SGCRowHeader"
        AlternatingRowStyle-CssClass="SGCdadosBodyAlt"
        RowStyle-CssClass="SGCdadosBodyNorm">
        <AlternatingRowStyle BackColor="White" />
        <Columns>
            <asp:TemplateField HeaderText="Seleccionar"  ItemStyle-HorizontalAlign="Center" ItemStyle-Width="40px" HeaderStyle-Width="40px">
                <HeaderTemplate>
                            <asp:CheckBox ID="chkboxSelectAll" runat="server" onclick="CheckAllEmp(this);" />
                        </HeaderTemplate>
                <ItemTemplate>
                    <asp:CheckBox ID="chkSelecionar" runat="server" />
                    
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="RemetenteID" HeaderText="Nr. Cliente" SortExpression="RemetenteID" ItemStyle-Width="70px" />
            <asp:BoundField DataField="Nome" HeaderText="Nome" SortExpression="Nome" ItemStyle-Width="200px"/>
            <asp:BoundField DataField="NomeDestinatario" HeaderText="Destinatário" SortExpression="NomeDestinatario" />
            <asp:BoundField DataField="MoradaDestinatario" HeaderText="Morada" SortExpression="MoradaDestinatario" />
             <asp:BoundField DataField="Palavra1Destinatario" HeaderText="1ª Palavra" SortExpression="Palavra1Destinatario" />
             <asp:BoundField DataField="Palavra2Destinatario" HeaderText="2ª Palavra" SortExpression="Palavra2Destinatario" />
             <asp:BoundField DataField="Palavra3Destinatario" HeaderText="3ª Palavra" SortExpression="Palavra3Destinatario" />

            <asp:TemplateField HeaderText="Estado" SortExpression="Estado" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="50px">
                <ItemTemplate>  
                    <asp:ImageButton runat="server" ID="imgEstado" OnClick="imgEstado_Click" Estado='<%#(object)Eval("Estado")%>' IDMIL='<%#(object)Eval("RemetenteID")%>'  ImageUrl='<%# BuildEstado((object)Eval("Estado"))%>' ToolTip='<%# BuildToolTipEstado((object)Eval("Estado"),(object)Eval("Nome"))%>' />
                </ItemTemplate>
             </asp:TemplateField>
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

             <table border="0" cellpadding="1" cellspacing="0"   style="vertical-align: top;width:100%;border-collapse:collapse;font-size: 14px;">
                <tr>
                    <td colspan="2">
                        <br />
                          <hr />
                        <asp:Button ID="btnRota" CssClass="ui-button2 ui-widget ui-state-default ui-corner-all ui-button-text-only" runat="server" Text="Definir Rota"/>
                        <asp:Button ID="btnLimpar" CssClass="ui-button2 ui-widget ui-state-default ui-corner-all ui-button-text-only" runat="server" Text="Limpar" CommandName="Cancel" onclick="btnLimpar_Click" />
                      
                    </td>
                </tr>
            </table>
            <a id="MapaID" href="#"></a>
            <table border="0" cellpadding="1" cellspacing="0"   style="vertical-align: top;width:100%;border-collapse:collapse;font-size: 14px;">
                <tr>
                    <td>
                        <div id="mapcontent" class="span11">
                            <div class="popin">
                                <div id="map"></div>
                            </div>
                            <div class="row" >
                              <!--<a href="#" id="start_travel" class="btn small">start</a>-->
                              <ul id="instructions">
                              </ul>
                            </div>
                        </div>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel> 
    
    <asp:SqlDataSource ID="SqlDataSourceEnvio"  runat="server"
        ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"
        SelectCommandType="Text" 
        SelectCommand="SELECT [EnvioID]
      ,[RemetenteID]
      ,[NomeDestinatario]
      ,[MoradaDestinatario]
      ,[Palavra1Destinatario]
      ,[Palavra2Destinatario]
      ,[Palavra3Destinatario]
      ,[dbo].[sige_envio].[ProvinciaID]
      ,[dbo].[sige_envio].[MunicipioID]
      ,[dbo].[sige_envio].[ComunaID]
      ,[dbo].[sige_envio].[Estado]
	  ,[dbo].[mpla_militante].Nome
  FROM [dbo].[sige_envio] INNER JOIN [dbo].[mpla_militante] ON [dbo].[sige_envio].RemetenteID = [dbo].[mpla_militante].MilitanteID">
      
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
        var map;
        $(document).ready(function () {
            prettyPrint();
            map = new GMaps({
                div: '#map',
                lat: -8.812105,
                lng: 13.230167
            });
            //add marker Correios de Angola
            map.addMarker({
                lat: -8.812105,
                lng: 13.230167,
                title: 'Correios de Angola',
                infoWindow: {
                    content: 'Correios de Angola'
                }
            });


            $('#ctl00_MainContent_btnRota').click(function (e) {
              
                e.preventDefault();

                window.location.href = "#MapaID";

                map.addMarker({
                    lat: -8.829148,
                    lng: 13.253598,
                    title: 'Vila Alice',
                    infoWindow: {
                        content: 'Vila Alice'
                    }
                });

                map.addMarker({
                    lat: -8.828702,
                    lng: 13.251120,
                    title: 'Vila Alice (Suave)',
                    infoWindow: {
                        content: 'Vila Alice (Suave)'
                    }
                });

                map.addMarker({
                    lat: -8.824751899999999,
                    lng: 13.235852999999999,
                    title: 'Sagrada Família',
                    infoWindow: {
                        content: 'Sagrada Família'
                    }
                });


                map.travelRoute({
                    origin: [-8.812105, 13.230167],
                    destination: [-8.829148, 13.253598],
                    travelMode: 'driving',
                    step: function (e) {
                        $('#instructions').append('<li>' + e.instructions + '</li>');
                        $('#instructions li:eq(' + e.step_number + ')').delay(450 * e.step_number).fadeIn(200, function () {
                            map.setCenter(e.end_location.lat(), e.end_location.lng());
                            map.drawPolyline({
                                path: e.path,
                                strokeColor: '#131540',
                                strokeOpacity: 0.6,
                                strokeWeight: 6
                            });
                        });
                    }
                });

                map.travelRoute({
                    origin: [-8.829148, 13.253598],
                    destination: [-8.828702, 13.251120],
                    travelMode: 'driving',
                    step: function (e) {
                        $('#instructions').append('<li>' + e.instructions + '</li>');
                        $('#instructions li:eq(' + e.step_number + ')').delay(450 * e.step_number).fadeIn(200, function () {
                            map.setCenter(e.end_location.lat(), e.end_location.lng());
                            map.drawPolyline({
                                path: e.path,
                                strokeColor: '#131540',
                                strokeOpacity: 0.6,
                                strokeWeight: 6
                            });
                        });
                    }
                });

                map.travelRoute({
                    origin: [-8.828702, 13.251120],
                    destination: [-8.824751899999999, 13.235852999999999],
                    travelMode: 'driving',
                    step: function (e) {
                        $('#instructions').append('<li>' + e.instructions + '</li>');
                        $('#instructions li:eq(' + e.step_number + ')').delay(450 * e.step_number).fadeIn(200, function () {
                            map.setCenter(e.end_location.lat(), e.end_location.lng());
                            map.drawPolyline({
                                path: e.path,
                                strokeColor: '#131540',
                                strokeOpacity: 0.6,
                                strokeWeight: 6
                            });
                        });
                    }
                });


                map.travelRoute({
                    origin: [-8.824751899999999, 13.235852999999999],
                    destination: [-8.812105, 13.230167],
                    travelMode: 'driving',
                    step: function (e) {
                        $('#instructions').append('<li>' + e.instructions + '</li>');
                        $('#instructions li:eq(' + e.step_number + ')').delay(450 * e.step_number).fadeIn(200, function () {
                            map.setCenter(e.end_location.lat(), e.end_location.lng());
                            map.drawPolyline({
                                path: e.path,
                                strokeColor: 'Green',
                                strokeOpacity: 0.6,
                                strokeWeight: 6
                            });
                        });
                    }
                });
            });
        });

        function CheckAllEmp(Checkbox) {
         
            var GridVwHeaderChckbox = document.getElementById("<%=GridViewEnvio.ClientID %>");
            for (i = 1; i < GridVwHeaderChckbox.rows.length; i++) {
                GridVwHeaderChckbox.rows[i].cells[0].getElementsByTagName("INPUT")[0].checked = Checkbox.checked;
            }
        }


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

<asp:Button ID="Button1" CssClass="ui-button2 ui-widget ui-state-default ui-corner-all ui-button-text-only" runat="server" Text="Imprimir Rota" OnClientClick="window.print();" />

</asp:Content>
