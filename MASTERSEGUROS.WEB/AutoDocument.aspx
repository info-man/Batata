<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AutoDocument.aspx.cs" Inherits="MASTERSEGUROS.WEB.AutoDocument" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <asp:Literal ID="ltEmbed" runat="server" />
         <asp:SqlDataSource ID="SqlDataSourceApoliceAutoFrotaViatura" runat="server"
        ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"
        SelectCommand="SELECT [master_apolice_auto_frota].*, [master_marca_veiculo].Descricao as Marca, [master_modelo_veiculo].Descricao as Modelo FROM [master_apolice_auto_frota] inner join [master_marca_veiculo] ON [master_apolice_auto_frota].MarcaID = [master_marca_veiculo].MarcaID inner join [master_modelo_veiculo] ON [master_apolice_auto_frota].ModeloID = [master_modelo_veiculo].ModeloID WHERE [ApoliceID]=@ApoliceID">
         <SelectParameters>
            <asp:QueryStringParameter QueryStringField="aplID" Name="ApoliceID" DefaultValue="0" />
          </SelectParameters>
    </asp:SqlDataSource>
    </div>
    </form>
</body> 
</html>
