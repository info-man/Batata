﻿<%@ Page Title="Envio por dia" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EnvioPorDia.aspx.cs" Inherits="MASTERSEGUROS.WEB.EnvioPorDia"  %>


<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
   
        <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePartialRendering="true" />
    <h3>Envio><asp:Label ID="lblBread"   runat="server"></asp:Label> Envio por dia</h3>
       
     <script src="amcharts/amcharts.js" type="text/javascript"></script>
     <script src="amcharts/pie.js" type="text/javascript"></script>
     <script src="amcharts/plugins/responsive/responsive.min.js" type="text/javascript"></script>

  <style type="text/css">
  body, html {
    height: 100%;
    padding: 0;
    margin: 0;
  }
  </style>
  <script type="text/javascript">

    var chartData = [];
    generateChartData();

    var chart = AmCharts.makeChart("chartdiv", {
      "type": "serial",
      "dataProvider": chartData,
      "categoryField": "date",
      "categoryAxis": {
        "parseDates": true,
        "gridAlpha": 0.15,
        "minorGridEnabled": true,
        "axisColor": "#DADADA"
      },
      "valueAxes": [{
        "axisAlpha": 0.2,
        "id": "v1"
      }],
      "graphs": [{
        "title": "red line",
        "id": "g1",
        "valueAxis": "v1",
        "valueField": "visits",
        "bullet": "round",
        "bulletBorderColor": "#FFFFFF",
        "bulletBorderAlpha": 1,
        "lineThickness": 2,
        "lineColor": "#b5030d",
        "negativeLineColor": "#0352b5",
        "balloonText": "[[category]]<br><b><span style='font-size:14px;'>value: [[value]]</span></b>"
      }],
      "chartCursor": {
        "fullWidth": true,
        "cursorAlpha": 0.1
      },
      "chartScrollbar": {
        "scrollbarHeight": 40,
        "color": "#FFFFFF",
        "autoGridCount": true,
        "graph": "g1"
      },
      "mouseWheelZoomEnabled": true,
      "responsive": {
        "enabled": true
      }
    });

    chart.addListener("dataUpdated", zoomChart);


    // generate some random data, quite different range
    function generateChartData() {
      var firstDate = new Date();
      firstDate.setDate(firstDate.getDate() - 500);

      for (var i = 0; i < 500; i++) {
        // we create date objects here. In your data, you can have date strings
        // and then set format of your dates using chart.dataDateFormat property,
        // however when possible, use date objects, as this will speed up chart rendering.
        var newDate = new Date(firstDate);
        newDate.setDate(newDate.getDate() + i);

        var visits = Math.round(Math.random() * 40) - 20;

        chartData.push({
            date: newDate,
            visits: visits
        });
      }
    }

    // this method is called when chart is first inited as we listen for "dataUpdated" event
    function zoomChart() {
      // different zoom methods can be used - zoomToIndexes, zoomToDates, zoomToCategoryValues
      chart.zoomToIndexes(chartData.length - 40, chartData.length - 1);
    }

  </script>

           
</asp:Content>
