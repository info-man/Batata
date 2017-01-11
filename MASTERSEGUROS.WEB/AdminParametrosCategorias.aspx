<%@ Page Title="Categorias" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdminParametrosCategorias.aspx.cs" Inherits="MASTERSEGUROS.WEB.AdminParametrosCategorias" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <br />
        <asp:FormView ID="FormView1" runat="server" DataKeyNames="ModeloID" DataSourceID="SqlDataSourceINSERTALLCt" DefaultMode="Insert" Width="100%">
        <InsertItemTemplate>
         <table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td colspan="2">
                    <div id="accordion">
                        <h3>Parâmetros - Categorias</h3>
                        <div>
                            <table border="0" cellpadding="0" cellspacing="0"   style="width:100%;border-collapse:collapse;font-size: 13px;">
                 <tr>
                     <td style="width:130px">Descrição:</td>
                    <td>
                        <asp:TextBox ID="DescricaoTextBox" runat="server" Text='<%# Bind("Descricao") %>' TextMode="SingleLine" Width="350" MaxLength="200" />
                        &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator3" ValidationGroup="Form" Display="Dynamic" runat="server" Text="*" ControlToValidate="DescricaoTextBox" class="erro" ToolTip="" SetFocusOnError="true">&otimes;</asp:RequiredFieldValidator>
                    </td>
                 </tr>

                 <tr>
                    <td>Valor:</td>
                    <td>
                        <asp:TextBox ID="ValorTextBox" runat="server" Text='<%# Bind("Valor") %>' Width="250" MaxLength="100" />
                        &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator1" ValidationGroup="Form" Display="Dynamic" runat="server" Text="*" ControlToValidate="ValorTextBox" class="erro" ToolTip="" SetFocusOnError="true">&otimes;</asp:RequiredFieldValidator>
                    </td>
                </tr>

               <tr>
                   <td>Ocupantes:</td>
                        <td>
                           <asp:DropDownList Width="105" MaxLength="100" runat="server" Text='<%# Bind("Ocupantes") %>' ID="OpcaoOcupantesComboBox" AppendDataBoundItems="true" >
                            <asp:ListItem Text="Sim" Value="1"> </asp:ListItem>
                           <asp:ListItem Text="Não" Value="0"> </asp:ListItem>
                           </asp:DropDownList>
                       </td>
                  </tr>

                 <tr>
                    <td>Danos Próprios:</td>
                    <td>
                       <asp:DropDownList ID="DanosDropDownList" runat="server" Text='<%# Bind("DanosProprios") %>' Width="105" MaxLength="100" >
                           <asp:ListItem Text="Sim" Value="1"> </asp:ListItem>
                           <asp:ListItem Text="Não" Value="0"> </asp:ListItem>
                      </asp:DropDownList>
                        &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator2" ValidationGroup="Form" Display="Dynamic" runat="server" Text="*" ControlToValidate="DanosDropDownList" class="erro" ToolTip="" SetFocusOnError="true">&otimes;</asp:RequiredFieldValidator>
                    </td>
                </tr>

                <tr>
                    <td>% Danos Próprios:</td>
                    <td>
                        <asp:TextBox ID="PercentagemTextBox" runat="server" Text='<%# Bind("PercDanosPropriosBase") %>' Width="100" MaxLength="100" />
                        &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator5" ValidationGroup="Form" Display="Dynamic" runat="server" Text="*" ControlToValidate="PercentagemTextBox" class="erro" ToolTip="" SetFocusOnError="true">&otimes;</asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="PercentagemTextBox" class="erro" ValidationExpression="(?:\d*)?\d+" ValidationGroup="Form">&otimes;</asp:RegularExpressionValidator>
                        <asp:RangeValidator MaximumValue="100" MinimumValue="0" ValidationGroup="Form"  ErrorMessage="*" SetFocusOnError="true" class="erro" ControlToValidate="PercentagemTextBox" ID="RngValPercentagemTextBox" runat="server" Type="Integer">&otimes;</asp:RangeValidator>

                    </td>
                </tr>

                <tr>
                    <td colspan="2">
                        <br />
                        <asp:Button ID="btnInsertButton" ValidationGroup="Form" CssClass="ui-button ui-corner-all" runat="server" Text="Adicionar" CommandName="Insert" CausesValidation="True" OnClick="btnInsertButton_Click"/>
                                    </td>

                    <tr>
                    <tr>
                       <td colspan="2"> 
                   </td>
              <tr>
          </table>
                        </div>
                        <h3>Categorias</h3>
                              <div>
                                   <asp:GridView ID="GridView1" runat="server" DataKeyNames="CategoriaID"  AllowPaging="True" AutoGenerateColumns="False"
                                    CellPadding="2" DataSourceID="SqlDataSourceINSERTALLCt"
                                    PagerSettings-PageButtonCount="15" PageSize="10"
                                    HeaderStyle-CssClass="SGCRowHeader"
                                    AlternatingRowStyle-CssClass="SGCdadosBodyAlt"
                                    RowStyle-CssClass="SGCdadosBodyNorm">
                                     <AlternatingRowStyle BackColor="White" />
         <Columns>
                 <asp:BoundField DataField="CategoriaID" HeaderText="ID"  ReadOnly="true" SortExpression="CategoriaID" ItemStyle-Width="25px"  ControlStyle-Width="25px" ItemStyle-HorizontalAlign="Right" ></asp:BoundField>

                 <asp:BoundField DataField="Descricao" HeaderText="Descrição" SortExpression="Descricao" ItemStyle-Width="350px"  ControlStyle-Width="350px" ItemStyle-HorizontalAlign="Left" ></asp:BoundField>

                 <asp:BoundField DataField="Valor" HeaderText="Valor"  SortExpression="Valor" ItemStyle-Width="100px"  ControlStyle-Width="75px" ItemStyle-HorizontalAlign="Left" ></asp:BoundField>



               <asp:TemplateField HeaderText="Ocupantes" SortExpression="Ocupantes" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="0px">
                                            <ItemTemplate>
                                                <asp:Label ID="lblEstado" runat="server" Text='<%#Buildocupantes((object)Eval("Ocupantes"))%>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:DropDownList ID="EstadoCombobox" runat="server" Width="80" MaxLength="80" SelectedValue='<%#Bind("Ocupantes")%>'>
                                                    <asp:ListItem Text="Sim" Value="1"> </asp:ListItem>
                                                    <asp:ListItem Text="Não" Value="0"> </asp:ListItem>
                                                </asp:DropDownList>
                                            </EditItemTemplate>
                                        </asp:TemplateField>


                                        <asp:TemplateField HeaderText="Danos Proprios" SortExpression="DanosProprios" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="0px">
                                            <ItemTemplate>
                                                <asp:Label ID="lblEstado" runat="server" Text='<%#Buildocupantes((object)Eval("DanosProprios"))%>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:DropDownList ID="EstadoCombobox2" runat="server" Width="80" MaxLength="80" SelectedValue='<%#Bind("DanosProprios")%>'>
                                                    <asp:ListItem Text="Sim" Value="1"> </asp:ListItem>
                                                    <asp:ListItem Text="Não" Value="0"> </asp:ListItem>
                                                </asp:DropDownList>
                                            </EditItemTemplate>
                                        </asp:TemplateField>

                          <asp:CommandField EditText="Editar" HeaderText="Operações" UpdateText="Actualizar" CancelText="Cancelar" DeleteText="Eliminar" ShowDeleteButton="true" ShowEditButton="True" />

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
                            </div>
                    </div>
                </td>
            </tr>
        </table>
                        
        </InsertItemTemplate>
    </asp:FormView>
  
    
    
    <asp:SqlDataSource ID="SqlDataSourceINSERTALLCt" runat="server"
                ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" 
                InsertCommand="INSERT INTO [master_categoria] ([Descricao], [Valor], [Ocupantes], [DanosProprios], [PercDanosPropriosBase]) VALUES (@Descricao, @Valor, @Ocupantes, @DanosProprios, @PercDanosPropriosBase)"
                UpdateCommand="UPDATE [master_categoria] SET [Descricao] = @Descricao, [Valor] = @Valor, [Ocupantes] = @Ocupantes, [DanosProprios] = @DanosProprios, [PercDanosPropriosBase] = @PercDanosPropriosBase WHERE [CategoriaID] = @CategoriaID" 
                DeleteCommand="DELETE FROM [master_categoria] WHERE [CategoriaID] = @CategoriaID" 
                SelectCommand="SELECT * FROM [master_categoria]">
        <DeleteParameters>
            <asp:Parameter Name="CategoriaID" Type="Int32" />
        </DeleteParameters>
        
        <InsertParameters>
            <asp:Parameter Name="Descricao" Type="String" />
            <asp:Parameter Name="Valor" Type="Decimal" />
            <asp:ControlParameter ControlID="ctl00$MainContent$FormView1$OpcaoOcupantesComboBox" PropertyName="SelectedValue" Name="OpcaoOcupantesID"   Type="Int32"  DefaultValue="0"/>
            <asp:ControlParameter ControlID="ctl00$MainContent$FormView1$DanosDropDownList" PropertyName="SelectedValue" Name="DanosProprios" type="Int32"  DefaultValue="0"/>
            <asp:Parameter Name="PercDanosPropriosBase" Type="Int32" />
        </InsertParameters>

        <UpdateParameters>
            <asp:Parameter Name="Descricao" Type="String" />
            <asp:Parameter Name="Valor" Type="Decimal" />
            <asp:ControlParameter ControlID="ctl00$MainContent$FormView1$OpcaoOcupantesComboBox" PropertyName="SelectedValue" Name="OpcaoOcupantesID" Type="Int32"  DefaultValue="0"/>
            <asp:ControlParameter ControlID="ctl00$MainContent$FormView1$DanosDropDownList" PropertyName="SelectedValue" Name="DanosProprios" type="Int32"  DefaultValue="0"/>
            <asp:Parameter Name="PercDanosPropriosBase" Type="Int32" />
            <asp:Parameter Name="CategoriaID" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
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
