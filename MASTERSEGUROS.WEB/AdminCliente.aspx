<%@ Page Title="Clientes" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdminCliente.aspx.cs" Inherits="MASTERSEGUROS.WEB.AdminCliente" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <table border="0" cellpadding="0" cellspacing="0" width="100%">
        <tr>
            <td colspan="2">
                <div id="accordion">
                    <h3>Cliente</h3>
                    <div>
                        <asp:FormView ID="FormView1" runat="server" Width="100%" DataKeyNames="ClienteID" DataSourceID="SqlDataSourceCliente" DefaultMode="Insert">
                            <InsertItemTemplate>
                                <table border="0" cellpadding="0" cellspacing="0" style="width: 100%; border-collapse: collapse; font-size: 13px;">
                                    <tr>
                                        <td style="width: 90px">Nome:  <img alt="" style="vertical-align: middle" src="img/yes.png" /></td>
                                        <td>
                                            <asp:TextBox ID="NomeTextBox" runat="server" Text='<%# Bind("Nome") %>' Width="350" MaxLength="350" />
                                            &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator5" ValidationGroup="Form" Display="Dynamic" runat="server" Text="*" ControlToValidate="NomeTextBox"  ToolTip="" SetFocusOnError="true">&otimes;</asp:RequiredFieldValidator>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Morada:  <img alt="" style="vertical-align: middle" src="img/yes.png" /></td>
                                        <td>
                                            <asp:TextBox ID="MoradaTextBox" runat="server" Text='<%# Bind("Morada") %>' Width="350" MaxLength="350" />
                                            &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator1" ValidationGroup="Form" Display="Dynamic" runat="server" Text="*" ControlToValidate="MoradaTextBox"  ToolTip="" SetFocusOnError="true">&otimes;</asp:RequiredFieldValidator>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Província:</td>
                                        <td>
                                            <asp:DropDownList runat="server" ID="ProvinciaIDComboBox" AutoPostBack="false" Width="200px" AppendDataBoundItems="true" DataSourceID="SqlDataSourceProvincia" DataValueField="ProvinciaId" DataTextField="Nome">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Município:</td>
                                        <td>
                                            <asp:DropDownList runat="server" ID="MunicipioIDComboBox" AutoPostBack="true" Width="200px" AppendDataBoundItems="true" DataSourceID="SqlDataSourceMunicipio" DataValueField="MunicipioId" DataTextField="Nome">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Comuna:</td>
                                        <td>
                                            <asp:DropDownList runat="server" ID="ComunaIDComboBox" AutoPostBack="false" Width="200px" AppendDataBoundItems="false" DataSourceID="SqlDataSourceComuna" DataValueField="ComunaId" DataTextField="Nome">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Telefone:</td>
                                        <td>
                                            <asp:TextBox ID="TelefoneTextBox" runat="server" Text='<%# Bind("Telefone") %>' Width="200" MaxLength="400" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Telemóvel:</td>
                                        <td>
                                            <asp:TextBox ID="TelemovelTextBox" runat="server" Text='<%# Bind("Telemovel") %>' Width="200" MaxLength="400" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>E-mail:</td>
                                        <td>
                                            <asp:TextBox ID="EmailTextBox" runat="server" Text='<%# Bind("Email") %>' Width="300" MaxLength="400" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>BI:</td>
                                        <td>
                                            <asp:TextBox ID="BITextBox" runat="server" Text='<%# Bind("BI") %>' Width="200" MaxLength="400" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>NIF:</td>
                                        <td>
                                            <asp:TextBox ID="NIFTextBox" runat="server" Text='<%# Bind("NIF") %>' Width="200" MaxLength="400" />
                                        </td>
                                        <tr>
                                            <td style="width: 150px">Data de Nascimento:
                                                <img alt="" style="vertical-align: middle" src="img/yes.png" /></td>
                                            <td>
                                                <asp:TextBox ID="DataNascimentoTextBox" Text='<%#Bind("DataNascimento") %>' runat="server" Width="75" MaxLength="10" /><img alt="Data de Nascimento" src="images/31.png" style="vertical-align: text-bottom" />
                                                &nbsp;<asp:RequiredFieldValidator ID="ReqValDataNascimentoTextBox" ValidationGroup="Form" Display="Dynamic"  runat="server" Text="*" ControlToValidate="DataNascimentoTextBox" ToolTip="" SetFocusOnError="true">&otimes;</asp:RequiredFieldValidator>
                                                
                                            </td>
                                        </tr>
                                    </tr>
                                    <tr>
                                        <td>Profissão:</td>
                                        <td>
                                            <asp:DropDownList ID="ProfissaoComboBox" runat="server" Text='<%# Bind("ProfissaoID") %>' Width="250" MaxLength="100" DataSourceID="SqlDataSourceProfissoes" DataValueField="ProfissaoID" DataTextField="Descricao">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Cª Condução:</td>
                                        <td>
                                            <asp:TextBox ID="CartaConducaoTextBox" runat="server" Text='<%# Bind("CartaConducaoNumero") %>' Width="200" MaxLength="400" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>É Tomador ?</td>
                                        <td>
                                            <asp:DropDownList ID="TomadorDropDownList" runat="server" Width="100" MaxLength="100">
                                                <asp:ListItem Value="1" Text="Sim"> </asp:ListItem>
                                                <asp:ListItem Value="0" Text="Não"> </asp:ListItem>
                                            </asp:DropDownList>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ValidationGroup="Form" Display="Dynamic" runat="server" Text="*" ControlToValidate="TomadorDropDownList" class="erro" ToolTip="" SetFocusOnError="true">Preenchimento Obrigatório</asp:RequiredFieldValidator>
                                        </td>
                                    </tr>
                                </table>
                                </div> 
   <br />
                                <asp:Button ID="InsertButton" ValidationGroup="Form" CssClass="ui-button ui-corner-all" runat="server" Text="Adicionar" CommandName="Insert" CausesValidation="True" />
                                <asp:GridView ID="GridView1" runat="server">
                                </asp:GridView>
                            </InsertItemTemplate>

                            <EditItemTemplate>
                                <table border="0" cellpadding="0" cellspacing="0" style="width: 100%; border-collapse: collapse; font-size: 13px;">
                                    <tr>
                                        <td style="width: 90px">Nome:  <img alt="" style="vertical-align: middle" src="img/yes.png" /></td>
                                        <td>
                                            <asp:TextBox ID="NomeTextBox" runat="server" Text='<%# Bind("Nome") %>' Width="350" MaxLength="350" />
                                            &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator5" ValidationGroup="Form" Display="Dynamic" runat="server" Text="*" ControlToValidate="NomeTextBox"  ToolTip="" SetFocusOnError="true">&otimes;</asp:RequiredFieldValidator>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Morada:  <img alt="" style="vertical-align: middle" src="img/yes.png" /></td>
                                        <td>
                                            <asp:TextBox ID="MoradaTextBox" runat="server" Text='<%# Bind("Morada") %>' Width="350" MaxLength="350" />
                                            &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator1" ValidationGroup="Form" Display="Dynamic" runat="server" Text="*" ControlToValidate="MoradaTextBox"  ToolTip="" SetFocusOnError="true">&otimes;</asp:RequiredFieldValidator>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Província:</td>
                                        <td>
                                            <asp:DropDownList runat="server" ID="ProvinciaIDComboBox" AutoPostBack="false" Width="200px" AppendDataBoundItems="true" DataSourceID="SqlDataSourceProvincia" DataValueField="ProvinciaId" DataTextField="Nome">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Município:</td>
                                        <td>
                                            <asp:DropDownList runat="server" ID="MunicipioIDComboBox" AutoPostBack="true" Width="200px" AppendDataBoundItems="true" DataSourceID="SqlDataSourceMunicipio" DataValueField="MunicipioId" DataTextField="Nome">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Comuna:</td>
                                        <td>
                                            <asp:DropDownList runat="server" ID="ComunaIDComboBox" AutoPostBack="false" Width="200px" AppendDataBoundItems="false" DataSourceID="SqlDataSourceComuna" DataValueField="ComunaId" DataTextField="Nome">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Telefone:</td>
                                        <td>
                                            <asp:TextBox ID="TelefoneTextBox" runat="server" Text='<%# Bind("Telefone") %>' Width="200" MaxLength="400" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Telemóvel:</td>
                                        <td>
                                            <asp:TextBox ID="TelemovelTextBox" runat="server" Text='<%# Bind("Telemovel") %>' Width="200" MaxLength="400" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>E-mail:</td>
                                        <td>
                                            <asp:TextBox ID="EmailTextBox" runat="server" Text='<%# Bind("Email") %>' Width="300" MaxLength="400" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>BI:</td>
                                        <td>
                                            <asp:TextBox ID="BITextBox" runat="server" Text='<%# Bind("BI") %>' Width="200" MaxLength="400" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>NIF:</td>
                                        <td>
                                            <asp:TextBox ID="NIFTextBox" runat="server" Text='<%# Bind("NIF") %>' Width="200" MaxLength="400" />
                                        </td>
                                        <tr>
                                            <td style="width: 150px">Data de Nascimento:
                                                <img alt="" style="vertical-align: middle" src="img/yes.png" /></td>
                                            <td>
                                                <asp:TextBox ID="DataNascimentoTextBox" Text='<%# Bind("DataNascimento", "{0:dd/mm/yyyy}") %>' runat="server" Width="75" MaxLength="10" /><img alt="Data de Nascimento" src="images/31.png" style="vertical-align: text-bottom" />
                                                &nbsp;<asp:RequiredFieldValidator ID="ReqValDataNascimentoTextBox" ValidationGroup="Form" Display="Dynamic" runat="server" Text="*" ControlToValidate="DataNascimentoTextBox" ToolTip="" SetFocusOnError="true">&otimes;</asp:RequiredFieldValidator>
                                               
                                            </td>
                                        </tr>
                                    </tr>
                                    <tr>
                                        <td>Profissão:</td>
                                        <td>
                                            <asp:DropDownList ID="ProfissaoComboBox" runat="server" Text='<%# Bind("ProfissaoID") %>' Width="250" MaxLength="100" DataSourceID="SqlDataSourceProfissoes" DataValueField="ProfissaoID" DataTextField="Descricao">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Cª Condução:</td>
                                        <td>
                                            <asp:TextBox ID="CartaConducaoTextBox" runat="server" Text='<%# Bind("CartaConducaoNumero") %>' Width="200" MaxLength="400" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>É Tomador ?</td>
                                        <td>
                                            <asp:DropDownList ID="TomadorDropDownList" runat="server" Width="100" MaxLength="100">
                                                <asp:ListItem Value="1" Text="Sim"> </asp:ListItem>
                                                <asp:ListItem Value="0" Text="Não"> </asp:ListItem>
                                            </asp:DropDownList>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ValidationGroup="Form" Display="Dynamic" runat="server" Text="*" ControlToValidate="TomadorDropDownList" class="erro" ToolTip="" SetFocusOnError="true">Preenchimento Obrigatório</asp:RequiredFieldValidator>
                                        </td>
                                    </tr>
                                </table>

                                </div> 
  <br />
                                <asp:Button ID="UpdateButton" ValidationGroup="Form" CssClass="ui-button ui-corner-all" runat="server" Text="Actualizar" CommandName="Update" CausesValidation="True" />
                                <asp:GridView ID="GridView1" runat="server">
                                </asp:GridView>

                            </EditItemTemplate>
                        </asp:FormView>
                    </div>
                </div>
            </td>
        </tr>

    </table>

    <div id="dialog-ErroGravar" title="Master Seguros" style="display: none">
        <br />
        Ocorreu um erro a gravar os dados.<br />
            Comunique ao administrador de sistemas.
    </div>

    <div id="dialog-SucessoGravar" title="Master Seguros" style="display: none">
        <br />
       O cliente foi gravado com sucesso.
    </div>

    <asp:SqlDataSource ID="SqlDataSourceProfissoes" runat="server"
        SelectCommand="SELECT * FROM [master_Profissoes] ORDER BY Descricao"
        ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"></asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceCliente" runat="server" OnUpdated="On_Updated" OnInserted="On_Inserted" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"
        InsertCommand="INSERT INTO [master_cliente] ([Nome], [Morada], [ProvinciaID], [MunicipioID], [ComunaID], [Telefone], [Telemovel], [Email], [BI], [Passaporte], [NIF], [ProfissaoID], [DataNascimento], [CartaConducaoNumero], [CartaConducaoData], [CartaConducaoValidade], [UserIDCriacao], [DataCriacao], [UserIDActualizacao], [DataActualizacao], [Tomador]) VALUES (@Nome, @Morada, @ProvinciaID, @MunicipioID, @ComunaID, @Telefone, @Telemovel, @Email, @BI, @Passaporte, @NIF, @ProfissaoID, @DataNascimento, @CartaConducaoNumero, @CartaConducaoData, @CartaConducaoValidade, @UserIDCriacao, @DataCriacao, @UserIDActualizacao, @DataActualizacao, @Tomador)"
        SelectCommand="SELECT * FROM [master_cliente]  WHERE [ClienteID] = @ClienteID"
        DeleteCommand="DELETE FROM [master_cliente] WHERE [ClienteID] = @ClienteID"
        UpdateCommand="UPDATE [master_cliente] SET [Nome] = @Nome, [Morada] = @Morada, [ProvinciaID] = @ProvinciaID, [MunicipioID] = @MunicipioID, [ComunaID] = @ComunaID, [Telefone] = @Telefone, [Telemovel] = @Telemovel, [Email] = @Email, [BI] = @BI, [Passaporte] = @Passaporte, [NIF] = @NIF, [ProfissaoID] = @ProfissaoID, [DataNascimento] = @DataNascimento, [CartaConducaoNumero] = @CartaConducaoNumero, [CartaConducaoData] = @CartaConducaoData, [CartaConducaoValidade] = @CartaConducaoValidade, [UserIDCriacao] = @UserIDCriacao, [DataCriacao] = @DataCriacao, [UserIDActualizacao] = @UserIDActualizacao, [DataActualizacao] = @DataActualizacao, [Tomador] = @Tomador WHERE [ClienteID] = @ClienteID">

        <DeleteParameters>
            <asp:Parameter Name="ClienteID" Type="Int32" />
        </DeleteParameters>

        <InsertParameters>
            <asp:Parameter Name="Nome" Type="String" />
            <asp:Parameter Name="Morada" Type="String" />
            <asp:ControlParameter ControlID="ctl00$MainContent$FormView1$ProvinciaIDComboBox" PropertyName="SelectedValue" Name="ProvinciaID" Type="Int32" />
            <asp:ControlParameter ControlID="ctl00$MainContent$FormView1$MunicipioIDComboBox" PropertyName="SelectedValue" Name="MunicipioID" Type="Int32" />
            <asp:ControlParameter ControlID="ctl00$MainContent$FormView1$ComunaIDComboBox" PropertyName="SelectedValue" Name="ComunaID" Type="Int32" />
            <asp:ControlParameter ControlID="ctl00$MainContent$FormView1$TomadorDropDownList" PropertyName="SelectedValue" Name="Tomador" Type="String" />
            <asp:ControlParameter ControlID="ctl00$MainContent$FormView1$ProfissaoComboBox" PropertyName="SelectedValue" Name="ProfissaoID" Type="Int32" />
            <asp:Parameter Name="Telefone" Type="String" />
            <asp:Parameter Name="Telemovel" Type="String" />
            <asp:Parameter Name="Email" Type="String" />
            <asp:Parameter Name="BI" Type="String" />
            <asp:Parameter Name="Passaporte" Type="String" />
            <asp:Parameter Name="NIF" Type="String" />
            <asp:Parameter Name="DataNascimento" Type="DateTime" />
            <asp:Parameter Name="CartaConducaoNumero" Type="String" />
            <asp:Parameter Name="CartaConducaoData" Type="DateTime" />
            <asp:Parameter Name="CartaConducaoValidade" Type="DateTime" />
            <asp:Parameter Name="UserIDCriacao" Type="String" />
            <asp:Parameter Name="DataCriacao" Type="DateTime" />
            <asp:Parameter Name="UserIDActualizacao" Type="String" />
            <asp:Parameter Name="DataActualizacao" Type="DateTime" />
        </InsertParameters>

        <UpdateParameters>
            <asp:Parameter Name="Nome" Type="String" />
            <asp:Parameter Name="Morada" Type="String" />
            <asp:ControlParameter ControlID="ctl00$MainContent$FormView1$ProvinciaIDComboBox" PropertyName="SelectedValue" Name="ProvinciaID" Type="Int32" />
            <asp:ControlParameter ControlID="ctl00$MainContent$FormView1$MunicipioIDComboBox" PropertyName="SelectedValue" Name="MunicipioID" Type="Int32" />
            <asp:ControlParameter ControlID="ctl00$MainContent$FormView1$ComunaIDComboBox" PropertyName="SelectedValue" Name="ComunaID" Type="Int32" />
            <asp:ControlParameter ControlID="ctl00$MainContent$FormView1$TomadorDropDownList" PropertyName="SelectedValue" Name="Tomador" Type="String" />
            <asp:ControlParameter ControlID="ctl00$MainContent$FormView1$ProfissaoComboBox" PropertyName="SelectedValue" Name="ProfissaoID" Type="Int32" />
            <asp:Parameter Name="Telefone" Type="String" />
            <asp:Parameter Name="Telemovel" Type="String" />
            <asp:Parameter Name="Email" Type="String" />
            <asp:Parameter Name="BI" Type="String" />
            <asp:Parameter Name="Passaporte" Type="String" />
            <asp:Parameter Name="NIF" Type="String" />
            <asp:Parameter Name="DataNascimento" Type="DateTime" />
            <asp:Parameter Name="CartaConducaoNumero" Type="String" />
            <asp:Parameter Name="CartaConducaoData" Type="DateTime" />
            <asp:Parameter Name="CartaConducaoValidade" Type="DateTime" />
            <asp:Parameter Name="UserIDCriacao" Type="String" />
            <asp:Parameter Name="DataCriacao" Type="DateTime" />
            <asp:Parameter Name="UserIDActualizacao" Type="String" />
            <asp:Parameter Name="DataActualizacao" Type="DateTime" />
            <asp:Parameter Name="ClienteID" Type="Int32" />
        </UpdateParameters>

        <SelectParameters>
            <asp:Parameter Name="ClienteID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceProvincia" runat="server"
        ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"
        SelectCommand="SELECT * FROM [master_provincia] ORDER BY NOME "></asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceMunicipio" runat="server"
        ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"
        SelectCommand="SELECT * FROM [master_municipio] ORDER BY NOME"></asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceComuna" runat="server"
        ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"
        SelectCommand="SELECT * FROM [master_comuna] ORDER BY NOME"></asp:SqlDataSource>


    <script type="text/javascript">
        
        $("#accordion").accordion({
            heightStyle: "content"
        });


        function GetState ()
        {
            return "true";
        }

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

        $("#ctl00_MainContent_FormView1_DataNascimentoTextBox").datepicker();
        $("#ctl00_MainContent_FormView1_DataNascimentoTextBox").datepicker("option", "dateFormat", "dd/mm/yy");

        function SetAcordion(acordID) {
           
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

            $("#accordion").accordion({
                active: acordID
            });
        }

        function MessageBoxErroGravar(refString) {
            $("#dialog-ErroGravar").dialog({
                title: "MASTER SEGUROS",
                resizable: false,
                width: 430,
                height: 200,
                modal: true,
                buttons: {
                    "OK": function () {
                        $(this).dialog("close");
                        return true;
                    }
                }

            });
            return false;
        }

        function MessageBoxSucessoGravar() {
            $("#dialog-SucessoGravar").dialog({
                title: "MASTER SEGUROS",
                resizable: false,
                width: 430,
                height: 200,
                modal: true,
                buttons: {
                    "OK": function () {
                        location.href = 'pesquisacliente.aspx?acoordion=1';
                        $(this).dialog("close");
                        return true;
                    }
                }

            });
            return false;
        }
    </script>

</asp:Content>
