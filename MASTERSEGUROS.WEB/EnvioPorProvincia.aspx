<%@ Page Title="Envio por dia" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EnvioPorProvincia.aspx.cs" Inherits="MASTERSEGUROS.WEB.EnvioPorProvincia"  %>
<%@ Register TagPrefix="cc" Namespace="Winthusiasm.HtmlEditor" Assembly="Winthusiasm.HtmlEditor" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
   
        <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePartialRendering="true" />
    <h3>Envio ><asp:Label ID="lblBread"   runat="server"></asp:Label> Envio por Província</h3>
    <br />
       
        <script src="amcharts/amcharts.js" type="text/javascript"></script>
        <script src="amcharts/pie.js" type="text/javascript"></script>

        <script type="text/javascript">
            AmCharts.makeChart("chartdiv", {
                "type": "pie",
                "titles": [{
                    "text": "",
                    "size": 18
                }],
                "dataProvider": [{
                    "country": "Bengo",
                    "visits": 52
                }, {
                    "country": "Benguela",
                    "visits": 32
                }, {
                    "country": "Bié",
                    "visits": 19
                }, {
                    "country": "Cabinda",
                    "visits": 122
                }, {
                    "country": "Huambo",
                    "visits": 122
                }, {
                    "country": "Huíla",
                    "visits": 414
                }, {
                    "country": "Kuando-Kubango",
                    "visits": 384
                }, {
                    "country": "Cunene",
                    "visits": 201
                }, {
                    "country": "Kuwanza-Norte",
                    "visits": 354
                }, {
                    "country": "Kuanza-Sul",
                    "visits": 211
                }, {
                    "country": "Luanda",
                    "visits": 711
                }, {
                    "country": "Kuwanza-Norte",
                    "visits": 184
                }, {
                    "country": "Kuanza-Sul",
                    "visits": 111
                }, {
                    "country": "Malange",
                    "visits": 711
                }, {
                    "country": "Moxico",
                    "visits": 584
                }, {
                    "country": "Namibe",
                    "visits": 119
                }, {
                    "country": "Uíge",
                    "visits": 114
                }, {
                    "country": "Zaire",
                    "visits": 111
                }],
                "valueField": "visits",
                "titleField": "country",
                "startEffect": "elastic",
                "startDuration": 2,
                "labelRadius": 15,
                "innerRadius": "50%",
                "depth3D": 10,
                "balloonText": "[[title]]<br><span style='font-size:14px'><b>[[value]]</b> ([[percents]]%)</span>",
                "angle": 15,
                "legend": {
                    "position": "right"
                },
                "responsive": {
                    "enabled": true
                }
            });
        </script>
  

  
        <div id="chartdiv" style="width: 100%; height: 400px;"></div>
    
           
</asp:Content>
