<%@ Page Title="Impressão de cartões" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ImpressaoCartao.aspx.cs" Inherits="MASTERSEGUROS.WEB.ImpressaoCartao" %>


<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <h3>Militante > Impressão de Cartão</h3>
    <br />
  <asp:UpdatePanel ID="UpdatePanel2" runat="server"> 
        <ContentTemplate>  
          
         <asp:Image runat="server" ID="imgCartaoMilitante" Width="550px" Height="335px" BorderColor="Black" BorderWidth="1px" ImageUrl="~/img/BI_FRT.jpg" /><br />
  <asp:Button ID="InsertButton" ValidationGroup="Form" CssClass="ui-button2 ui-widget ui-state-default ui-corner-all ui-button-text-only" runat="server" Text="Imprimir" CommandName="Insert" CausesValidation="True"  />
    </ContentTemplate>
    </asp:UpdatePanel> 
   

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
