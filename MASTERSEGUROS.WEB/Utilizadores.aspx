<%@ Page Title="Utilizadores" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Utilizadores.aspx.cs" Inherits="MASTERSEGUROS.WEB.Utilizadores" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
     <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <h3>Utilizadores > Visualisar</h3>
    <br />
   <asp:UpdatePanel ID="UpdatePanel2" runat="server">
       <ContentTemplate>  
 <asp:GridView ID="GridViewUtilizadores" runat="server"
        AllowPaging="True" AllowSorting="False" AutoGenerateColumns="False"
        CellPadding="2" DataKeyNames="UserId" DataSourceID="SqlDataSourceUtilizadores" OnRowDataBound="GridViewUtilizadores_RowDataBound"
        PagerSettings-PageButtonCount="15" PageSize="10"
        HeaderStyle-CssClass="SGCRowHeader"
        AlternatingRowStyle-CssClass="SGCdadosBodyAlt"
        RowStyle-CssClass="SGCdadosBodyNorm">
        <AlternatingRowStyle BackColor="White" />
        <Columns>
            
            <asp:BoundField DataField="UserName" HeaderText="Nome do Utilizador" 
            SortExpression="UserName" ItemStyle-Width="150px" ControlStyle-Width="150px" ItemStyle-HorizontalAlign="Left" />

            <asp:BoundField DataField="CreateDate" HeaderText="Data Criação" 
            SortExpression="CreateDate" ItemStyle-Width="150px" ControlStyle-Width="150px" ItemStyle-HorizontalAlign="Left" />

            <asp:BoundField DataField="LastActivityDate" HeaderText="Última Actividade" 
            SortExpression="LastActivityDate" ItemStyle-Width="150px" ControlStyle-Width="150px" ItemStyle-HorizontalAlign="Left" />

             <asp:BoundField DataField="LastLoginDate" HeaderText="Último Acesso" 
            SortExpression="LastLoginDate" ItemStyle-Width="150px" ControlStyle-Width="150px" ItemStyle-HorizontalAlign="Left" />

          
            
            <asp:TemplateField HeaderText="Estado" SortExpression="IsLockedOut" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="50px">
                <ItemTemplate>  
                    <asp:ImageButton runat="server" ID="imgEstado" OnClick="imgEstado_Click" Estado='<%#(object)Eval("IsLockedOut")%>' userID='<%#(object)Eval("userID")%>' ImageUrl='<%# BuildEstado((object)Eval("IsLockedOut"))%>' ToolTip='<%# BuildToolTipEstado((object)Eval("IsLockedOut"),(object)Eval("UserName"))%>' />
                </ItemTemplate>
             </asp:TemplateField>
            
            <asp:CommandField  Visible="false" EditText="Editar" UpdateText="Actualizar" CancelText="Cancelar" ShowDeleteButton="False" ShowEditButton="False"  />
        </Columns>
         <EditRowStyle />
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


   <asp:SqlDataSource ID="SqlDataSourceUtilizadores" runat="server"
        ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"
        DeleteCommand="DELETE FROM [Bimestre] WHERE ([BimestreId] = @BimestreId)"
        InsertCommand="INSERT INTO [Bimestre] ([Nome],[DescricaoCompleta]) VALUES (@Nome,@DescricaoCompleta)"
        SelectCommand="SELECT u.ApplicationId, u.UserId, u.UserName, u.LoweredUserName, u.MobileAlias, u.IsAnonymous, u.LastActivityDate, m.LastLoginDate, m.[IsLockedOut], m.CreateDate FROM aspnet_Users u INNER JOIN [aspnet_Membership] m on u.UserId = m.UserId ORDER BY LastActivityDate DESC"
        UpdateCommand="UPDATE [aspnet_Membership] SET IsLockedOut=@IsLockedOut WHERE UserId=@UserId">
        
        <UpdateParameters>
           <asp:Parameter Name="IsLockedOut" Type="Boolean" />
           <asp:Parameter Name="UserId" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>
   
  
</asp:Content>
