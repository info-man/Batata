<%@ Page Title="Modelos" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="adminparametrosmodelos.aspx.cs" Inherits="MASTERSEGUROS.WEB.adminparametrosmodelos" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePartialRendering="true" />

    

    <br />
        <asp:FormView ID="FormView1" runat="server" DataKeyNames="ModeloID" DataSourceID="SqlDataSourceINSERTALL" DefaultMode="Insert" Width="100%">
        
            <InsertItemTemplate>
                  <table border="0" cellpadding="0" cellspacing="0" width="100%">
                 <tr>
                     <td colspan="2">
                          <div id="accordion">
                              <h3>Parâmetros - Modelos</h3>
                              <div>
           


           <table border="0" cellpadding="1" cellspacing="0" style="width:100%;border-collapse:collapse;font-size: 13px;">
                 <tr>
                    <td style="width:120px">Marca:</td>
                    <td>
                        <asp:DropDownList ID="MarcaIDDropDownList" DataSourceID="SqlDataSourceMARCA" runat="server" Text='<%# Bind("marca") %>' Width="250" MaxLength="100" DataValueField="MarcaID"  DataTextField="Descricao"/>
                        &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator1" ValidationGroup="Form" Display="Dynamic" runat="server" Text="*" ControlToValidate="MarcaIDDropDownList" class="erro" ToolTip="" SetFocusOnError="true">Preenchimento Obrigatório</asp:RequiredFieldValidator>
                    </td>
                </tr>

                 <tr>
                    <td>Descrição :</td>
                    <td>
                        <asp:TextBox ID="DescricaoTextBox" runat="server" Text='<%# Bind("Descricao") %>'  Width="246" MaxLength="100" />
                        &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator3" ValidationGroup="Form" Display="Dynamic" runat="server" Text="*" ControlToValidate="DescricaoTextBox" class="erro" ToolTip="" SetFocusOnError="true">Preenchimento Obrigatório</asp:RequiredFieldValidator>
                    </td>
                 </tr>

                 <tr>
                    <td>Estado:</td>
                    <td>
                       <asp:DropDownList ID="EstadoDropDownList" runat="server" Text='<%# Bind("estado") %>' Width="100" MaxLength="100" >
                           <asp:ListItem Text="Activo" Value="1"> </asp:ListItem>
                           <asp:ListItem Text="Inactivo" Value="0"> </asp:ListItem>
                      </asp:DropDownList>
                        &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator5" ValidationGroup="Form" Display="Dynamic" runat="server" Text="*" ControlToValidate="EstadoDropDownList" class="erro" ToolTip="" SetFocusOnError="true">Preenchimento Obrigatório</asp:RequiredFieldValidator>
                    </td>
                </tr>

                 <tr>
                    <td colspan="2">
                        <br />
                        <asp:Button ID="btnInsertButton" ValidationGroup="Form" CssClass="ui-button ui-corner-all" runat="server" Text="Adicionar" CommandName="Insert" CausesValidation="True" OnClick="btnInsertButton_Click1"/>
                    </td>
                    <tr>
                    <tr>
                       <td colspan="2"> 
                     </td>
               <tr>
          </table>
</div>
                              <h3>Modelos</h3>
                              <div>
   <asp:GridView ID="GridView1" runat="server"
                AllowPaging="True" AutoGenerateColumns="False"
                CellPadding="2" DataKeyNames="ModeloID" DataSourceID="SqlDataSourceINSERTALL"
                                PagerSettings-PageButtonCount="15" PageSize="10"
                HeaderStyle-CssClass="SGCRowHeader"
        AlternatingRowStyle-CssClass="SGCdadosBodyAlt"
        RowStyle-CssClass="SGCdadosBodyNorm">
               <AlternatingRowStyle BackColor="White" />
                <Columns>
            <asp:BoundField DataField="ModeloID" HeaderText="Nº" Visible="false"  SortExpression="ModeloID" ItemStyle-Width="25px"  ControlStyle-Width="25px" ItemStyle-HorizontalAlign="Left" InsertVisible="False" ReadOnly="True" >
           </asp:BoundField>
           <asp:BoundField DataField="Descricao_Marca" HeaderText="Marca" ReadOnly="true" SortExpression="Descricao_Marca"
                  ItemStyle-Width="150px" ControlStyle-Width="150px" ItemStyle-HorizontalAlign="Left" >
              <ControlStyle Width="150px"></ControlStyle>
              <ItemStyle HorizontalAlign="Left" Width="150px"></ItemStyle>
          </asp:BoundField>
          <asp:BoundField DataField="Descricao" HeaderText="Modelo" SortExpression="Descricao"  ItemStyle-Width="300px" ControlStyle-Width="300px" />
         <asp:TemplateField HeaderText="Estado" SortExpression="Estado" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="0px">
                <ItemTemplate>
                    <asp:Label ID="lblEstado" runat="server" Text='<%# BuildEstado((object)Eval("Estado"))%>'></asp:Label>
                </ItemTemplate>
             <EditItemTemplate>
                 <asp:DropDownList ID="EstadoCombobox" runat="server" Width="80" MaxLength="80" SelectedValue='<%#Bind("Estado")%>'>
                      <asp:ListItem Text="Activo" Value="1"> </asp:ListItem>
                           <asp:ListItem Text="Inactivo" Value="0"> </asp:ListItem>
                 </asp:DropDownList>
             </EditItemTemplate>
             </asp:TemplateField>
            <asp:CommandField EditText="Editar" HeaderText="Operações" UpdateText="Actualizar" CancelText="Cancelar" DeleteText="Eliminar" ShowDeleteButton="true" ShowEditButton="True"/>
                   </Columns>

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
                              
        </InsertItemTemplate>
                

    </asp:FormView>
                          
<div id="ctl00_MainContent_FormView1_ValSummary" style="color:Red;display:none;">

</div>
<span id="ctl00_MainContent_FormView1_cstConverterApolice" style="color:Red;display:none;"></span>        
     

    
    <asp:SqlDataSource ID="SqlDataSourceINSERTALL" runat="server"
                ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" 
                InsertCommand="INSERT INTO [master_modelo_veiculo] ([MarcaID], [Descricao], [Estado]) VALUES (@MarcaID, @Descricao, @Estado)"
                UpdateCommand="UPDATE [master_modelo_veiculo] SET  [Descricao] = @Descricao, [Estado] = @Estado WHERE [ModeloID] = @ModeloID" 
                DeleteCommand="DELETE FROM [master_modelo_veiculo] WHERE [ModeloID] = @ModeloID" 
                SelectCommand="SELECT mode.ModeloID as ModeloID, ma.Descricao as Descricao_Marca, mode.Descricao, mode.Estado FROM [dbo].[master_modelo_veiculo] as mode
                               inner join [dbo].[master_marca_veiculo] as ma on mode.MarcaID=ma.MarcaID ORDER BY Descricao_Marca, mode.Descricao">
        <DeleteParameters>
            <asp:Parameter Name="ModeloID" Type="Int32" />
        </DeleteParameters>
        
        <InsertParameters>
           <asp:ControlParameter ControlID="ctl00$MainContent$FormView1$MarcaIDDropDownList" PropertyName="SelectedValue" Name="MarcaID"   Type="Int32"  DefaultValue="0"/>
            <asp:Parameter Name="Descricao" Type="String" />
           <asp:ControlParameter ControlID="ctl00$MainContent$FormView1$EstadoDropDownList" PropertyName="SelectedValue" Name="Estado" Type="Int32" DefaultValue="0"/>
        </InsertParameters>

        <UpdateParameters>
         <asp:Parameter Name="MarcaID"  Type="Int32" />
         <asp:Parameter Name="Estado"  Type="Int32" />
         <asp:Parameter Name="Descricao" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceMARCA" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" 
    SelectCommand="SELECT * FROM [master_marca_veiculo] ORDER  BY Descricao"></asp:SqlDataSource>


    <script type="text/javascript">
     $("#accordion").accordion({
            heightStyle: "content"
        });



        $(function () {
            $("#accordion").accordion();

            var isPostBack = <%=Convert.ToString(Page.IsPostBack).ToLower()%>;
            if (isPostBack)
            {
                $("#accordion").accordion({
                    active: 1
                });
            }
            else
            {
                $("#accordion").accordion({
                    active: 0
                });
            }


            $("#accordion").accordion({
                heightStyle: "content"
            });
            var icons = {
                header: "ui-icon-circle-arrow-e",
                activeHeader: "ui-icon-circle-arrow-s"
            };
            $("#accordion").accordion({
                icons: icons
            });

        });
    </script>
</asp:Content>
