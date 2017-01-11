<%@ Page Title="Proposta de Seguro" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdminPropostaApolice.aspx.cs" Inherits="MASTERSEGUROS.WEB.AdminPropostaApolice"  %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
   
        <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePartialRendering="true" />
    
  <asp:UpdatePanel ID="UpdatePanel2" runat="server"> 
            <ContentTemplate>
    <asp:FormView ID="FormView1" runat="server"   Width="100%" DataKeyNames="CAPID" DataSourceID="SqlDataSourceCTT" DefaultMode="Insert" >

        <InsertItemTemplate>
            
             <table border="0" cellpadding="0" cellspacing="0" width="100%">
                 <tr>
                     <td colspan="2">
                          <div id="accordion">
                              <h3>Dados do Gerais da Proposta</h3>
                              <div>
                            <table border="0" cellpadding="0" cellspacing="0"   style="width:100%;border-collapse:collapse;font-size: 13px;">
                                <tr>
                                    <td style="width:90px" >Ramo:</td>
                                    <td>
                                        <asp:DropDownList runat="server" ID="RamoComboBox" Width="115px">
                                            <asp:ListItem Text="Automóvel" Value="1"></asp:ListItem>
                                            <asp:ListItem Text="Vida" Value="2"></asp:ListItem>
                                            <asp:ListItem Text="Saúde" Value="3"></asp:ListItem>
                                            <asp:ListItem Text="Viagem" Value="4"></asp:ListItem>
                                            <asp:ListItem Text="Ac. Pessoais" Value="5"></asp:ListItem>
                                            <asp:ListItem Text="Ac. Trabalho" Value="6"></asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width:90px" >Tipo:</td>
                                    <td>
                                        <asp:DropDownList runat="server" ID="TipoSeguroComboBox" Width="115px">
                                            <asp:ListItem Text="Novo" Value="1"></asp:ListItem>
                                            <asp:ListItem Text="Alteração" Value="2"></asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                        <td style="width:50px">Broker:</td>
                                        <td>
                                            <asp:DropDownList runat="server" ID="BrokerComboBox"  Width="115px">
                                                <asp:ListItem Text="Seguradora" Value="1"></asp:ListItem>
                                                <asp:ListItem Text="Mediador" Value="2"></asp:ListItem>
                                                <asp:ListItem Text="Agente" Value="3"></asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                 <tr>
                                        <td style="width:90px" >Número:</td>
                                        <td>
                                            <asp:TextBox ID="NumeroExecutanteTextBox" runat="server"  Width="110px" MaxLength="10" />
                                            &nbsp;<asp:RequiredFieldValidator ID="ReqValNumeroExecutanteTextBox" ValidationGroup="Form" Display="Dynamic" runat="server" Text="*" ControlToValidate="NumeroExecutanteTextBox" ToolTip="" SetFocusOnError="true">&otimes;</asp:RequiredFieldValidator>

                                        </td>
                                    </tr>
                             </table>
                                  </div>
 
                              <h3>Questões</h3>
                              <div>
                                <table border="0" cellpadding="0" cellspacing="0"   style="width:100%;border-collapse:collapse;font-size: 13px;">
                                     <tr>
                                        <td style="width:120px;">Tipo de Veículo:</td>
                                        <td>
                                            <asp:DropDownList runat="server" ID="TipoVeiculoComboBox" DataSourceID="SqlDataSourceTipoVeiculo"  DataTextField="Descricao" DataValueField="Codigo">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                <tr>
                                        <td style="width:120px" >Data de Fabrico:</td>
                                        <td>
                                             <asp:TextBox ID="DataFabricoTextBox" runat="server"  Width="75" MaxLength="10" /><img alt="Data de Fabrico" src="images/31.png" style="vertical-align:text-bottom" />&nbsp;
                                            &nbsp;<asp:RequiredFieldValidator ID="ReqValDataFabricoTextBox" ValidationGroup="Form" Display="Dynamic" runat="server" Text="*" ControlToValidate="DataFabricoTextBox" ToolTip="" SetFocusOnError="true">&otimes;</asp:RequiredFieldValidator>
                                        </td>
                                    </tr>
        
                                    <tr>
                                        <td style="width:120px" >Idade do condutor:</td>
                                        <td>
                                            <asp:TextBox ID="IdadeCondutorTextBox" runat="server"  Width="30" MaxLength="2" />&nbsp;
                                                &nbsp;<asp:RequiredFieldValidator ID="ReqValIdadeCondutorTextBox" ValidationGroup="Form" Display="Dynamic" runat="server" Text="*" ControlToValidate="IdadeCondutorTextBox"  ToolTip="" SetFocusOnError="true">&otimes;</asp:RequiredFieldValidator>
                                                <asp:RangeValidator MaximumValue="99" MinimumValue="16" ControlToValidate="IdadeCondutorTextBox" ID="rngvalIdadeCondutorTextBox" runat="server" Type="Integer">&otimes;</asp:RangeValidator>
                                        
                                        </td>
                                    </tr>
       
                                    <tr>
                                        <td>Anos de carta:</td>
                                        <td>
                                            <asp:TextBox ID="AnosCartaTextBox" runat="server"  Width="30" MaxLength="2" />
                                            &nbsp;<asp:RequiredFieldValidator ID="ReqValAnosCartaTextBox" ValidationGroup="Form" Display="Dynamic" runat="server" Text="*" ControlToValidate="AnosCartaTextBox"  ToolTip="" SetFocusOnError="true">&otimes;</asp:RequiredFieldValidator>
                                            <asp:RangeValidator MaximumValue="99" MinimumValue="0" ControlToValidate="AnosCartaTextBox" ID="rngvalAnosCartaTextBox" runat="server" Type="Integer">&otimes;</asp:RangeValidator>
                
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Bónus:</td>
                                        <td>
                                            <asp:TextBox ID="BonusTextBox" runat="server"  Width="30" MaxLength="4" />
                                            &nbsp;<asp:RequiredFieldValidator ID="ReqValBonusTextBox" ValidationGroup="Form" Display="Dynamic" runat="server" Text="*" ControlToValidate="BonusTextBox"  ToolTip="" SetFocusOnError="true">&otimes;</asp:RequiredFieldValidator>
                                            <asp:RangeValidator MaximumValue="100" MinimumValue="0" ControlToValidate="BonusTextBox" ID="rngvalBonusTextBox" runat="server" Type="Double">&otimes;</asp:RangeValidator>
                
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Malus:</td>
                                        <td>
                                            <asp:TextBox ID="MalusTextBox" runat="server"  Width="30" MaxLength="4" />
                                            &nbsp;<asp:RequiredFieldValidator ID="ReqValMalusTextBox" ValidationGroup="Form" Display="Dynamic" runat="server" Text="*" ControlToValidate="MalusTextBox"  ToolTip="" SetFocusOnError="true">&otimes;</asp:RequiredFieldValidator>
                                            <asp:RangeValidator MaximumValue="100" MinimumValue="0" ControlToValidate="MalusTextBox" ID="rngvalMalusTextBox" runat="server" Type="Double">&otimes;</asp:RangeValidator>
                
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Pagamento:</td>
                                        <td>
                                            <asp:DropDownList Width="200" runat="server" ID="ParcelamentoComboBox" AppendDataBoundItems="true" DataSourceID="ParcelamentoDatasource" DataTextField="Descricao" DataValueField="ConfigKey" >
                                                   <asp:ListItem Value="" Text="Seleccione um opção"></asp:ListItem>
                                                </asp:DropDownList>
                                                &nbsp;<asp:RequiredFieldValidator ID="ReqValParcelamentoCombobox" ValidationGroup="Form" Display="Dynamic" runat="server" Text="*" ControlToValidate="ParcelamentoComboBox" ToolTip="" SetFocusOnError="true">&otimes;</asp:RequiredFieldValidator>
                
                                        </td>
                                    </tr>
                                </table>
      
                              </div>
                              <h3>Informação Geral Obrigatória</h3>
                              <div>
                                <table border="0" cellpadding="0" cellspacing="0"   style="width:100%;border-collapse:collapse;font-size: 13px;">
                                    <tr>
                                        <td style="width:120px">Matrícula:</td>
                                        <td>
                                             <asp:TextBox ID="MatriculaTextBox" runat="server"  Width="95" MaxLength="10"  />
                                            &nbsp;<asp:RequiredFieldValidator ID="ReqValMatriculaTextBox" ValidationGroup="Form" Display="Dynamic" runat="server" Text="*" ControlToValidate="MatriculaTextBox" ToolTip="" SetFocusOnError="true">&otimes;</asp:RequiredFieldValidator>

                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width:120px" >Marca:</td>
                                        <td>
                                                <asp:DropDownList Width="200" runat="server" ID="MarcaComboBox" AppendDataBoundItems="true" DataSourceID="MarcaDatasource" DataTextField="Descricao" DataValueField="MarcaID" OnSelectedIndexChanged="MarcaComboBox_SelectedIndexChanged" AutoPostBack="true"  >
                                                    <asp:ListItem Value="" Text="Seleccione um opção"></asp:ListItem>
                                                </asp:DropDownList>
                                            &nbsp;<asp:RequiredFieldValidator ID="ReqValMarcaComboBox" ValidationGroup="Form" Display="Dynamic" runat="server" Text="*" ControlToValidate="MarcaComboBox"  ToolTip="" SetFocusOnError="true">&otimes;</asp:RequiredFieldValidator>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width:120px" >Modelo:</td>
                                        <td>
                                                <asp:DropDownList Width="200" runat="server" ID="ModeloComboBox" AppendDataBoundItems="true" DataSourceID="ModeloDatasource" DataTextField="Descricao" DataValueField="ModeloID" >
                                                   <asp:ListItem Value="" Text="Seleccione um opção"></asp:ListItem>
                                                </asp:DropDownList>
                                                &nbsp;<asp:RequiredFieldValidator ID="ReqValModeloComboBox" ValidationGroup="Form" Display="Dynamic" runat="server" Text="*" ControlToValidate="ModeloComboBox" ToolTip="" SetFocusOnError="true">&otimes;</asp:RequiredFieldValidator>

                                        </td>
                                    </tr>
                                    
                                    <tr>
                                        <td style="width:120px" >Cor:</td>
                                        <td>
                                                <asp:DropDownList Width="200" runat="server" ID="CorComboBox" AppendDataBoundItems="true" DataSourceID="CorDatasource" DataTextField="Descricao" DataValueField="CorID" >
                                                   <asp:ListItem Value="" Text="Seleccione um opção"></asp:ListItem>
                                                </asp:DropDownList>
                                                &nbsp;<asp:RequiredFieldValidator ID="ReqValCorComboBox" ValidationGroup="Form" Display="Dynamic" runat="server" Text="*" ControlToValidate="CorComboBox" ToolTip="" SetFocusOnError="true">&otimes;</asp:RequiredFieldValidator>

                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width:120px">Nº Chassi:</td>
                                        <td>
                                             <asp:TextBox ID="ChassiTextBox" runat="server"  Width="195" MaxLength="30" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width:120px" >Estado Veículo:</td>
                                        <td>
                                                <asp:DropDownList Width="80" runat="server" ID="EstadoVeiculoComboBox">
                                                   <asp:ListItem Value="1" Text="Novo"></asp:ListItem>
                                                   <asp:ListItem Value="2" Text="Bom"></asp:ListItem>
                                                   <asp:ListItem Value="3" Text="Razoável"></asp:ListItem>
                                                </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width:120px" >Danos:</td>
                                        <td>
                                                <asp:DropDownList Width="80" runat="server" ID="DanosComboBox">
                                                   <asp:ListItem Value="0" Text="Não"></asp:ListItem>
                                                   <asp:ListItem Value="1" Text="Sim"></asp:ListItem>
                                                </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width:120px">Detalhe Danos:</td>
                                        <td>
                                             <asp:TextBox ID="DetalheDanoTextBox" TextMode="MultiLine" runat="server"  Width="300"  Rows="3" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width:120px">Seguros Prévios:</td>
                                        <td>
                                              <asp:DropDownList Width="80" runat="server" ID="SegurosPreviosComboBox">
                                                   <asp:ListItem Value="0" Text="Não"></asp:ListItem>
                                                   <asp:ListItem Value="1" Text="Sim"></asp:ListItem>
                                                </asp:DropDownList>
                                        </td>
                                    </tr>
                                     <tr>
                                        <td style="width:120px" >Seguradora:</td>
                                        <td>
                                             <asp:DropDownList Width="200" runat="server" ID="SeguradoraAnteriorComboBox" >
                                                 <asp:ListItem Value="1" Text="Ensa"></asp:ListItem>
                                                 <asp:ListItem Value="2" Text="Global"></asp:ListItem>
                                                 <asp:ListItem Value="3" Text="Nossa"></asp:ListItem>
                                                 <asp:ListItem Value="4" Text="Universal"></asp:ListItem>
                                                 <asp:ListItem Value="5" Text="Saham"></asp:ListItem>
                                                 <asp:ListItem Value="6" Text="Mundial "></asp:ListItem>
                                                 <asp:ListItem Value="7" Text="Trevo"></asp:ListItem>
                                             </asp:DropDownList>
                                        </td>
                                    </tr>
                                     <tr>
                                        <td style="width:120px">Emprést. Bancário:</td>
                                        <td>
                                              <asp:DropDownList Width="80" runat="server" ID="EmpBancarioComboBox">
                                                   <asp:ListItem Value="0" Text="Não"></asp:ListItem>
                                                   <asp:ListItem Value="1" Text="Sim"></asp:ListItem>
                                                </asp:DropDownList>
                                        </td>
                                    </tr>
                                     <tr>
                                        <td style="width:120px" >Nome do Banco:</td>
                                        <td>
                                              <asp:DropDownList Width="200" runat="server" ID="BancoComboBox" AppendDataBoundItems="true" DataSourceID="BancoDatasource" DataTextField="Nome" DataValueField="BancoID" >
                                                <asp:ListItem Value="" Text="Seleccione um opção"></asp:ListItem>
                                              </asp:DropDownList>
                                        </td>
                                    </tr>
                                </table>
                              </div>
                        </div> 
                     </td>
                </tr>
                <tr>
                    <td colspan="2">
                    <hr />
                    </td>
                </tr>
        </table>
            
            
            <asp:Button ID="SimularButton" ValidationGroup="Form" CssClass="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" runat="server" Text="Simular"  OnClick="SimularButton_Click" CausesValidation ="True"  />
        </InsertItemTemplate>
    </asp:FormView>
         
            
            </ContentTemplate>
        </asp:UpdatePanel>    
    
     <div id="dialog-SimulacaoSucesso" title="Master Seguros" style="display: none">
        <br />
        <b>Detalhe da simulação.</b>
        <p id="hidden-input"></p>
        <table border="0" cellpadding="0" cellspacing="10"   style="width:100%;border-collapse:collapse;font-size: 13px;" >
            <tr>
                <td style="width:170px">PRÉMIO PURO:</td>
                <td>
                    <input type="text" style="border-color:white;width:80px;text-align: right;" id="PremioPuro" readonly="readonly" />
                </td>
            </tr>
            <tr>
                <td style="width:120px">PRÉMIO COMERCIAL:</td>
                <td>
                    <input type="text" style="border-color:white;width:80px;text-align: right;" id="PremioComercial" readonly="readonly" />

                </td>
            </tr>
            <tr>
                    <td style="width:120px">ENCARGOS:</td>
                    <td>
                            <input type="text" style="border-color:white;width:80px;text-align: right;"  id="Encargos" readonly="readonly" />
                    </td>
            </tr>
            <tr>
                    <td style="width:120px">ENCARGOS PARCEL.:</td>
                    <td>
                            <input type="text" style="border-color:white;width:80px;text-align: right;"  id="EncargosParcelamento" readonly="readonly" />
                    </td>
                </tr>
            <tr>
                    <td style="width:120px">IMPOSTO SELO:</td>
                    <td>
                        <input type="text" style="border-color:white;width:80px;text-align: right;"  id="ImpostoSelo" readonly="readonly" />
                    </td>
                </tr>
            <tr>
                    <td style="width:120px"><b>TOTAL:</b></td>
                    <td>
                            <input type="text" style="border-color:white;width:80px;text-align: right;" id="PremioTotal" readonly="readonly" />
                    </td>
                </tr>
        </table>
    </div>

   <asp:SqlDataSource ID="SqlDataSourceClassificador"   OnInserted="On_Inserted" OnUpdated="On_Updated" OnUpdating="On_Updating" runat="server"
        ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"
        DeleteCommand="DELETE FROM [CTT_classificador] WHERE [ClassificadorID] = @ClassificadorID AND [Lingua]=@Lingua"
        InsertCommand="INSERT INTO [CTT_classificador] ([ClassificadorID], [ClassificadorPaiID], [Nome], [Descricao], [Ordem], [Estado], [Lingua], [Media], [UrlTemplate], [Tipo], [NivelInteresseID]) VALUES (@ClassificadorID,@ClassificadorPaiID, @Nome, @Descricao, @Ordem, @Estado, @Lingua, @Media, @UrlTemplate, @Tipo, @NivelInteresseID)"
        SelectCommand="SELECT * FROM [CTT_classificador] WHERE [ClassificadorID]=@ClassificadorID AND [Lingua]=@Lingua"
        UpdateCommand="UPDATE [CTT_classificador] SET [ClassificadorPaiID]=@ClassificadorPaiID, [Nome]=@Nome, [Descricao]=@Descricao, [Ordem]=@Ordem, [Estado]=@Estado, [Lingua]=@Lingua, [Media]=@Media, [UrlTemplate]=@UrlTemplate, [Tipo]=@Tipo, [NivelInteresseID]=@NivelInteresseID WHERE [ClassificadorId] = @ClassificadorId AND [Lingua]=@Lingua">
        <DeleteParameters>
            <asp:Parameter Name="ClassificadorID" Type="Int32" />
            <asp:Parameter Name="Lingua" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="ClassificadorID" Type="Int32" />
            <asp:Parameter Name="ClassificadorPai" Type="Int32" ConvertEmptyStringToNull="false" />
            <asp:Parameter Name="Nome" Type="String" />
            <asp:Parameter Name="Descricao" Type="String" />
            <asp:Parameter Name="Media" Type="String" />
            <asp:Parameter Name="UrlTemplate" Type="String" ConvertEmptyStringToNull="true" />
            <asp:ControlParameter ControlID="ctl00$MainContent$FormView1$TipoComboBox" PropertyName="SelectedValue" Name="Tipo"  Type="Int32" DefaultValue="0" />
            <asp:ControlParameter ControlID="ctl00$MainContent$FormView1$LinguaComboBox" PropertyName="SelectedValue" Name="Lingua"  Type="Int32" DefaultValue="0" />
            <asp:ControlParameter ControlID="ctl00$MainContent$FormView1$NivelInteresseIDComboBox" PropertyName="SelectedValue" Name="NivelInteresseID"  Type="Int32" DefaultValue="0" />
            <asp:ControlParameter ControlID="ctl00$MainContent$FormView1$EstadoComboBox" PropertyName="SelectedValue" Name="Estado"  Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="Ordem" Type="Int32" DefaultValue="0" />    
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="ClassificadorPai" Type="Int32" ConvertEmptyStringToNull="false" />
            <asp:Parameter Name="Nome" Type="String" />
            <asp:Parameter Name="Descricao" Type="String" />
            <asp:Parameter Name="Media" Type="String" />
            <asp:Parameter Name="UrlTemplate" Type="String" ConvertEmptyStringToNull="true" />
            <asp:ControlParameter ControlID="ctl00$MainContent$FormView1$TipoComboBox" PropertyName="SelectedValue" Name="Tipo"  Type="Int32" DefaultValue="0" />
            <asp:ControlParameter ControlID="ctl00$MainContent$FormView1$LinguaComboBox" PropertyName="SelectedValue" Name="Lingua"  Type="Int32" DefaultValue="0" />
            <asp:ControlParameter ControlID="ctl00$MainContent$FormView1$NivelInteresseIDComboBox" PropertyName="SelectedValue" Name="NivelInteresseID"  Type="Int32" DefaultValue="0" />
            <asp:ControlParameter ControlID="ctl00$MainContent$FormView1$EstadoComboBox" PropertyName="SelectedValue" Name="Estado"  Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="Ordem" Type="Int32" DefaultValue="0" />    
        </UpdateParameters>
       <SelectParameters>
           <asp:Parameter Name="ClassificadorID" Type="Int32" />
           <asp:Parameter Name="Lingua" Type="Int32" />
       </SelectParameters>
        

    </asp:SqlDataSource>

   <asp:SqlDataSource ID="SqlDataSourceCTT"  OnInserted="On_Inserted" OnUpdated="On_Updated"  OnInserting ="SqlDataSourceCTT_Inserting" OnUpdating="On_Updating" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" 
        DeleteCommand="DELETE FROM [sige_cliente] WHERE [MilitanteID] = @MilitanteID" 
        InsertCommand="INSERT INTO [sige_cliente] ([CAPID], [ProvinciaID], [MunicipioID], [ComunaID],[Palavra1],[Palavra2],[Palavra3], [Nome], [Pseudonino], [NomePai], [NomeMae], [DataNascimento], [LocalNascimento], [ProvinciaNascID], [MunicipioNascID], [ComunaNascID], [BI], [DataEmissao], [Arquivo], [NomeEmpresa], [MoradaEmpresa], [TelefoneEmpresa], [Profissao], [Funcao], [HabilitacoesID], [EstadoCivilID], [NomeConjuge], [Morada], [ProvinciaMoradaID], [MunicipioMoradaID], [ComunaMoradaID], [Telemovel], [Email], [NIF], [NumeroEleitor], [GrupoEleitor] , [Foto], [RecomendacaoNomeMilitante1], [RecomendacaoComiteAccao1], [RecomendacaoAnosMilitancia1], [RecomendacaoConheceReq1], [RecomendacaoNomeMilitante2], [RecomendacaoComiteAccao2], [RecomendacaoAnosMilitancia2], [RecomendacaoConheceReq2], [ConfirmacaoNomeMilitante], [ConfirmacaoAtribuicao], [UserIDCriacao], [DataCriacao], [UserIDActualizacao], [DataActualizacao], [Estado]) VALUES (@CAPID,  @ProvinciaID, @MunicipioID, @ComunaID, @Palavra1, @Palavra2, @Palavra3, @Nome, @Pseudonino, @NomePai, @NomeMae, @DataNascimento, @LocalNascimento, @ProvinciaNascID, @MunicipioNascID, @ComunaNascID, @BI, @DataEmissao, @Arquivo, @NomeEmpresa, @MoradaEmpresa, @TelefoneEmpresa, @Profissao, @Funcao, @HabilitacoesID, @EstadoCivilID, @NomeConjuge, @Morada, @ProvinciaMoradaID, @MunicipioMoradaID, @ComunaMoradaID, @Telemovel, @Email, @NIF, @NumeroEleitor, @GrupoEleitor, @Foto, @RecomendacaoNomeMilitante1, @RecomendacaoComiteAccao1, @RecomendacaoAnosMilitancia1, @RecomendacaoConheceReq1, @RecomendacaoNomeMilitante2, @RecomendacaoComiteAccao2, @RecomendacaoAnosMilitancia2, @RecomendacaoConheceReq2, @ConfirmacaoNomeMilitante, @ConfirmacaoAtribuicao, @UserIDCriacao, @DataCriacao, @UserIDActualizacao, @DataActualizacao, @Estado)" 
        SelectCommand="SELECT * FROM [sige_cliente] WHERE [MilitanteID] = @MilitanteID"  
        UpdateCommand="UPDATE [sige_cliente] SET [CAPID] = @CAPID, [Nome] = @Nome, [Pseudonino] = @Pseudonino, [NomePai] = @NomePai, [NomeMae] = @NomeMae, [DataNascimento] = @DataNascimento, [LocalNascimento] = @LocalNascimento, [ProvinciaNascID] = @ProvinciaNascID, [MunicipioNascID] = @MunicipioNascID, [ComunaNascID] = @ComunaNascID, [BI] = @BI, [DataEmissao] = @DataEmissao, [Arquivo] = @Arquivo, [NomeEmpresa] = @NomeEmpresa, [MoradaEmpresa] = @MoradaEmpresa, [TelefoneEmpresa] = @TelefoneEmpresa, [Profissao] = @Profissao, [Funcao] = @Funcao, [HabilitacoesID] = @HabilitacoesID, [EstadoCivilID] = @EstadoCivilID, [NomeConjuge] = @NomeConjuge, [Morada] = @Morada, [ProvinciaMoradaID] = @ProvinciaMoradaID, [MunicipioMoradaID] = @MunicipioMoradaID, [ComunaMoradaID] = @ComunaMoradaID, [Telemovel] = @Telemovel, [Email] = @Email, [NIF] = @NIF, [NumeroEleitor] = @NumeroEleitor, [GrupoEleitor] = @GrupoEleitor, [RecomendacaoNomeMilitante1] = @RecomendacaoNomeMilitante1, [RecomendacaoComiteAccao1] = @RecomendacaoComiteAccao1, [RecomendacaoAnosMilitancia1] = @RecomendacaoAnosMilitancia1, [RecomendacaoConheceReq1] = @RecomendacaoConheceReq1, [RecomendacaoNomeMilitante2] = @RecomendacaoNomeMilitante2, [RecomendacaoComiteAccao2] = @RecomendacaoComiteAccao2, [RecomendacaoAnosMilitancia2] = @RecomendacaoAnosMilitancia2, [RecomendacaoConheceReq2] = @RecomendacaoConheceReq2, [ConfirmacaoNomeMilitante] = @ConfirmacaoNomeMilitante, [ConfirmacaoAtribuicao] = @ConfirmacaoAtribuicao, [UserIDCriacao] = @UserIDCriacao, [DataCriacao] = @DataCriacao, [UserIDActualizacao] = @UserIDActualizacao, [DataActualizacao] = @DataActualizacao, [Estado] = @Estado WHERE [MilitanteID] = @MilitanteID">
        
        <InsertParameters>
            <asp:Parameter Name="CAPID" Type="Int32" />
            <asp:ControlParameter ControlID="ctl00$MainContent$FormView1$ProvinciaIDComboBox" PropertyName="SelectedValue" Name="ProvinciaID"  Type="Int32" DefaultValue="0" />
            <asp:ControlParameter ControlID="ctl00$MainContent$FormView1$MunicipioIDComboBox" PropertyName="SelectedValue" Name="MunicipioID"  Type="Int32" DefaultValue="0" />
            <asp:ControlParameter ControlID="ctl00$MainContent$FormView1$ComunaIDComboBox" PropertyName="SelectedValue" Name="ComunaID"  Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="Nome" Type="String" />
            <asp:Parameter Name="Palavra1" Type="String" />
            <asp:Parameter Name="Palavra2" Type="String" />
            <asp:Parameter Name="Palavra3" Type="String" />
            <asp:Parameter Name="Pseudonino" Type="String" />
            <asp:Parameter Name="NomePai" Type="String" />
            <asp:Parameter Name="NomeMae" Type="String" />
            <asp:Parameter Name="DataNascimento" Type="DateTime" />
            <asp:Parameter Name="LocalNascimento" Type="String" />
            <asp:ControlParameter ControlID="ctl00$MainContent$FormView1$ProvinciaNascIDComboBox" PropertyName="SelectedValue" Name="ProvinciaNascID"  Type="Int32" DefaultValue="0" />
            <asp:ControlParameter ControlID="ctl00$MainContent$FormView1$MunicipioNascIDComboBox" PropertyName="SelectedValue" Name="MunicipioNascID"  Type="Int32" DefaultValue="0" />
            <asp:ControlParameter ControlID="ctl00$MainContent$FormView1$ComunaNascIDComboBox" PropertyName="SelectedValue" Name="ComunaNascID"  Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="BI" Type="String" />
            <asp:Parameter Name="DataEmissao" Type="DateTime" />
            <asp:Parameter Name="Arquivo" Type="String" />
            <asp:Parameter Name="NomeEmpresa" Type="String" />
            <asp:Parameter Name="MoradaEmpresa" Type="String" />
            <asp:Parameter Name="TelefoneEmpresa" Type="String" />
            <asp:Parameter Name="Profissao" Type="String" />
            <asp:Parameter Name="Funcao" Type="String" />
            <asp:ControlParameter ControlID="ctl00$MainContent$FormView1$HabilitacoesIDComboBox" PropertyName="SelectedValue" Name="HabilitacoesID"  Type="Int32" DefaultValue="0" />
            <asp:ControlParameter ControlID="ctl00$MainContent$FormView1$EstadoCivilIDComboBox" PropertyName="SelectedValue" Name="EstadoCivilID"  Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="NomeConjuge" Type="String" />
            <asp:Parameter Name="Morada" Type="String" />
            <asp:ControlParameter ControlID="ctl00$MainContent$FormView1$ProvinciaMoradaIDComboBox" PropertyName="SelectedValue" Name="ProvinciaMoradaID"  Type="Int32" DefaultValue="0" />
            <asp:ControlParameter ControlID="ctl00$MainContent$FormView1$MunicipioMoradaIDComboBox" PropertyName="SelectedValue" Name="MunicipioMoradaID"  Type="Int32" DefaultValue="0" />
            <asp:ControlParameter ControlID="ctl00$MainContent$FormView1$ComunaMoradaIDComboBox" PropertyName="SelectedValue" Name="ComunaMoradaID"  Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="Telemovel" Type="String" />
            <asp:Parameter Name="Email" Type="String" />
            <asp:Parameter Name="NIF" Type="String" />
            <asp:Parameter Name="NumeroEleitor" Type="String" />
            <asp:Parameter Name="GrupoEleitor" Type="String" />
            <asp:Parameter Name="Foto" Type="String" />
            <asp:Parameter Name="RecomendacaoNomeMilitante1" Type="String" />
            <asp:Parameter Name="RecomendacaoComiteAccao1" Type="Int32" />
            <asp:Parameter Name="RecomendacaoAnosMilitancia1" Type="Int32" />
            <asp:Parameter Name="RecomendacaoConheceReq1"  Type="Int32" DefaultValue="" />
            <asp:Parameter Name="RecomendacaoNomeMilitante2" Type="String" />
            <asp:Parameter Name="RecomendacaoComiteAccao2" Type="Int32" />
            <asp:Parameter Name="RecomendacaoAnosMilitancia2" Type="Int32" />
            <asp:Parameter Name="RecomendacaoConheceReq2"  Type="Int32" DefaultValue="" />
            <asp:Parameter Name="ConfirmacaoNomeMilitante" Type="String" />
            <asp:Parameter Name="ConfirmacaoAtribuicao" Type="DateTime" />
            <asp:Parameter Name="UserIDCriacao" Type="String" />
            <asp:Parameter Name="DataCriacao" Type="DateTime" />
            <asp:Parameter Name="UserIDActualizacao" Type="String" />
            <asp:Parameter Name="DataActualizacao" Type="DateTime" />
            <asp:Parameter Name="Estado"  Type="Int32" DefaultValue="1" />
        </InsertParameters>
         <SelectParameters>
           <asp:Parameter Name="MilitanteID" Type="Int32" />
       </SelectParameters>
       
    </asp:SqlDataSource>

   <asp:SqlDataSource ID="SqlDataSourceTipoVeiculo" runat="server"
        ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"
        SelectCommand="SELECT * FROM [master_tipo_categoria]"></asp:SqlDataSource>

   <asp:SqlDataSource ID="MarcaDatasource" runat="server"
        ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"
        SelectCommand="SELECT * FROM [master_marca_veiculo] WHERE Estado=1"></asp:SqlDataSource>

   <asp:SqlDataSource ID="ModeloDatasource" runat="server"
        ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"
        SelectCommand="SELECT * FROM [master_modelo_veiculo] WHERE  MarcaID=@MarcaID AND Estado=1">
        <SelectParameters>
            <asp:ControlParameter ControlID="ctl00$MainContent$FormView1$MarcaComboBox" PropertyName="SelectedValue"
                                  Name="MarcaID" Type="Int32" DefaultValue="0" />
          </SelectParameters>
    </asp:SqlDataSource>
    
   <asp:SqlDataSource ID="ParcelamentoDatasource" runat="server"
        ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"
        SelectCommand="SELECT  ConfigKey, Descricao FROM master_configuracao WHERE ConfigType= 'PARCELA_PAGAMENTO'">
    </asp:SqlDataSource>

   <asp:SqlDataSource ID="CorDatasource" runat="server"
        ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"
        SelectCommand="SELECT * FROM [master_cor]"></asp:SqlDataSource>

   <asp:SqlDataSource ID="BancoDatasource" runat="server"
        ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"
        SelectCommand="SELECT * FROM [master_banco]"></asp:SqlDataSource>

   <script type="text/javascript">
       SetInitialize();

       function SetInitialize() {
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

      
           $("#ctl00_MainContent_FormView1_DataFabricoTextBox").datepicker();

           $('#ctl00_MainContent_FormView1_MatriculaTextBox').mask("LD-99-99-aa");

           $('#ctl00_MainContent_FormView1_MatriculaTextBox').blur(function () {
               this.value = this.value.toUpperCase();
           });
        

       }

       
       
       function SetDatapicker() {
           $("#ctl00_MainContent_FormView1_DataFabricoTextBox").datepicker();

       }

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


       function MessageBoxSimulacaoSucesso(PremioPuro, PremioComercial, Encargos, EncargosParcelamento, ImpostoSelo, PremioTotal) {
           //var message = refString;
           $("#PremioPuro").val(PremioPuro);
           $("#PremioComercial").val(PremioComercial);
           $("#Encargos").val(Encargos);
           $("#EncargosParcelamento").val(EncargosParcelamento);
           $("#ImpostoSelo").val(ImpostoSelo);
           $("#PremioTotal").val(PremioTotal);
           
           $("#dialog-SimulacaoSucesso").dialog({
               title: "MASTER SEGUROS",
               resizable: false,
               width: 530,
               height: 400,
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

</script>
           
</asp:Content>
