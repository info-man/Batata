<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Teste.aspx.cs" Inherits="MASTERSEGUROS.WEB.Teste" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
    ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" 
    DeleteCommand="DELETE FROM [tblFichaRelatorioCIP] WHERE [ID] = @ID" 
    InsertCommand="INSERT INTO [tblFichaRelatorioCIP] ([Data], [HoraInicio], [HoraFim], [Organizacao], [NomeActivistaId], [Activista], [EducadorPar], [LocalActividade], [Provincia], [Municipio], [GrupoAlvoSexo], [GrupoAlvoCamionistas], [GrupoAlvoClientes], [GrupoAlvoOutros], [BeneficiariosSexo], [ParticipantesSexo], [BeneficiariosCamionistas], [ParticipantesCamionistas], [TipoActividade], [CartoesSexo], [CartoesCamionista], [CartoesClientes], [CartoesOutros], [PreservativosSexo], [PreservativosCamionistas], [PreservativosClientes], [PreservativosOutros], [FolhetosSexo], [FolhetosCamionistas], [FolhetosClientes], [FolhetosOutros], [CartoesRecargaSexo], [CartoesRecargaCamionistas], [CartoesRecargaClientes], [CartoesRecargaOutros], [OutroMaterialSexo], [OutroMaterialCamionistas], [OutroMaterialClientes], [OutroMaterialOutros], [ComentariosAdicionais], [DataCriacao], [DataActualizacao], [UserCriacao], [UserActualizacao], [Aberto], [BeneficiariosClientes], [ParticipantesClientes], [BeneficiariosOutros], [ParticipantesOutros]) VALUES (@Data, @HoraInicio, @HoraFim, @Organizacao, @NomeActivistaId, @Activista, @EducadorPar, @LocalActividade, @Provincia, @Municipio, @GrupoAlvoSexo, @GrupoAlvoCamionistas, @GrupoAlvoClientes, @GrupoAlvoOutros, @BeneficiariosSexo, @ParticipantesSexo, @BeneficiariosCamionistas, @ParticipantesCamionistas, @TipoActividade, @CartoesSexo, @CartoesCamionista, @CartoesClientes, @CartoesOutros, @PreservativosSexo, @PreservativosCamionistas, @PreservativosClientes, @PreservativosOutros, @FolhetosSexo, @FolhetosCamionistas, @FolhetosClientes, @FolhetosOutros, @CartoesRecargaSexo, @CartoesRecargaCamionistas, @CartoesRecargaClientes, @CartoesRecargaOutros, @OutroMaterialSexo, @OutroMaterialCamionistas, @OutroMaterialClientes, @OutroMaterialOutros, @ComentariosAdicionais, @DataCriacao, @DataActualizacao, @UserCriacao, @UserActualizacao, @Aberto, @BeneficiariosClientes, @ParticipantesClientes, @BeneficiariosOutros, @ParticipantesOutros)" 
    SelectCommand="SELECT [ID], [Data], [HoraInicio], [HoraFim], [Organizacao], [NomeActivistaId], [Activista], [EducadorPar], [LocalActividade], [Provincia], [Municipio], [GrupoAlvoSexo], [GrupoAlvoCamionistas], [GrupoAlvoClientes], [GrupoAlvoOutros], [BeneficiariosSexo], [ParticipantesSexo], [BeneficiariosCamionistas], [ParticipantesCamionistas], [TipoActividade], [CartoesSexo], [CartoesCamionista], [CartoesClientes], [CartoesOutros], [PreservativosSexo], [PreservativosCamionistas], [PreservativosClientes], [PreservativosOutros], [FolhetosSexo], [FolhetosCamionistas], [FolhetosClientes], [FolhetosOutros], [CartoesRecargaSexo], [CartoesRecargaCamionistas], [CartoesRecargaClientes], [CartoesRecargaOutros], [OutroMaterialSexo], [OutroMaterialCamionistas], [OutroMaterialClientes], [OutroMaterialOutros], [ComentariosAdicionais], [DataCriacao], [DataActualizacao], [UserCriacao], [UserActualizacao], [Aberto], [BeneficiariosClientes], [ParticipantesClientes], [BeneficiariosOutros], [ParticipantesOutros] FROM [tblFichaRelatorioCIP]" 
    
        
        UpdateCommand="UPDATE [tblFichaRelatorioCIP] SET [Data] = @Data, [HoraInicio] = @HoraInicio, [HoraFim] = @HoraFim, [Organizacao] = @Organizacao, [NomeActivistaId] = @NomeActivistaId, [Activista] = @Activista, [EducadorPar] = @EducadorPar, [LocalActividade] = @LocalActividade, [Provincia] = @Provincia, [Municipio] = @Municipio, [GrupoAlvoSexo] = @GrupoAlvoSexo, [GrupoAlvoCamionistas] = @GrupoAlvoCamionistas, [GrupoAlvoClientes] = @GrupoAlvoClientes, [GrupoAlvoOutros] = @GrupoAlvoOutros, [BeneficiariosSexo] = @BeneficiariosSexo, [ParticipantesSexo] = @ParticipantesSexo, [BeneficiariosCamionistas] = @BeneficiariosCamionistas, [ParticipantesCamionistas] = @ParticipantesCamionistas, [TipoActividade] = @TipoActividade, [CartoesSexo] = @CartoesSexo, [CartoesCamionista] = @CartoesCamionista, [CartoesClientes] = @CartoesClientes, [CartoesOutros] = @CartoesOutros, [PreservativosSexo] = @PreservativosSexo, [PreservativosCamionistas] = @PreservativosCamionistas, [PreservativosClientes] = @PreservativosClientes, [PreservativosOutros] = @PreservativosOutros, [FolhetosSexo] = @FolhetosSexo, [FolhetosCamionistas] = @FolhetosCamionistas, [FolhetosClientes] = @FolhetosClientes, [FolhetosOutros] = @FolhetosOutros, [CartoesRecargaSexo] = @CartoesRecargaSexo, [CartoesRecargaCamionistas] = @CartoesRecargaCamionistas, [CartoesRecargaClientes] = @CartoesRecargaClientes, [CartoesRecargaOutros] = @CartoesRecargaOutros, [OutroMaterialSexo] = @OutroMaterialSexo, [OutroMaterialCamionistas] = @OutroMaterialCamionistas, [OutroMaterialClientes] = @OutroMaterialClientes, [OutroMaterialOutros] = @OutroMaterialOutros, [ComentariosAdicionais] = @ComentariosAdicionais, [DataCriacao] = @DataCriacao, [DataActualizacao] = @DataActualizacao, [UserCriacao] = @UserCriacao, [UserActualizacao] = @UserActualizacao, [Aberto] = @Aberto, [BeneficiariosClientes] = @BeneficiariosClientes, [ParticipantesClientes] = @ParticipantesClientes, [BeneficiariosOutros] = @BeneficiariosOutros, [ParticipantesOutros] = @ParticipantesOutros WHERE [ID] = @ID">
    <DeleteParameters>
        <asp:Parameter Name="ID" Type="Int32" />
    </DeleteParameters>
    <InsertParameters>
        <asp:Parameter Name="Data" Type="DateTime" />
        <asp:Parameter Name="HoraInicio" Type="DateTime" />
        <asp:Parameter Name="HoraFim" Type="DateTime" />
        <asp:Parameter Name="Organizacao" Type="String" />
        <asp:Parameter Name="NomeActivistaId" Type="Int32" />
        <asp:Parameter Name="Activista" Type="String" />
        <asp:Parameter Name="EducadorPar" Type="Int32" />
        <asp:Parameter Name="LocalActividade" Type="Int32" />
        <asp:Parameter Name="Provincia" Type="Int32" />
        <asp:Parameter Name="Municipio" Type="Int32" />
        <asp:Parameter Name="GrupoAlvoSexo" Type="Boolean" />
        <asp:Parameter Name="GrupoAlvoCamionistas" Type="Boolean" />
        <asp:Parameter Name="GrupoAlvoClientes" Type="Boolean" />
        <asp:Parameter Name="GrupoAlvoOutros" Type="Boolean" />
        <asp:Parameter Name="BeneficiariosSexo" Type="Int32" />
        <asp:Parameter Name="ParticipantesSexo" Type="Int32" />
        <asp:Parameter Name="BeneficiariosCamionistas" Type="Int32" />
        <asp:Parameter Name="ParticipantesCamionistas" Type="Int32" />
        <asp:Parameter Name="TipoActividade" Type="Int32" />
        <asp:Parameter Name="CartoesSexo" Type="Int32" />
        <asp:Parameter Name="CartoesCamionista" Type="Int32" />
        <asp:Parameter Name="CartoesClientes" Type="Int32" />
        <asp:Parameter Name="CartoesOutros" Type="Int32" />
        <asp:Parameter Name="PreservativosSexo" Type="Int32" />
        <asp:Parameter Name="PreservativosCamionistas" Type="Int32" />
        <asp:Parameter Name="PreservativosClientes" Type="Int32" />
        <asp:Parameter Name="PreservativosOutros" Type="Int32" />
        <asp:Parameter Name="FolhetosSexo" Type="Int32" />
        <asp:Parameter Name="FolhetosCamionistas" Type="Int32" />
        <asp:Parameter Name="FolhetosClientes" Type="Int32" />
        <asp:Parameter Name="FolhetosOutros" Type="Int32" />
        <asp:Parameter Name="CartoesRecargaSexo" Type="Int32" />
        <asp:Parameter Name="CartoesRecargaCamionistas" Type="Int32" />
        <asp:Parameter Name="CartoesRecargaClientes" Type="Int32" />
        <asp:Parameter Name="CartoesRecargaOutros" Type="Int32" />
        <asp:Parameter Name="OutroMaterialSexo" Type="Int32" />
        <asp:Parameter Name="OutroMaterialCamionistas" Type="Int32" />
        <asp:Parameter Name="OutroMaterialClientes" Type="Int32" />
        <asp:Parameter Name="OutroMaterialOutros" Type="Int32" />
        <asp:Parameter Name="ComentariosAdicionais" Type="String" />
        <asp:Parameter Name="DataCriacao" Type="DateTime" />
        <asp:Parameter Name="DataActualizacao" Type="DateTime" />
        <asp:Parameter Name="UserCriacao" Type="String" />
        <asp:Parameter Name="UserActualizacao" Type="String" />
        <asp:Parameter Name="Aberto" Type="Boolean" />
        <asp:Parameter Name="BeneficiariosClientes" Type="Int32" />
        <asp:Parameter Name="ParticipantesClientes" Type="Int32" />
        <asp:Parameter Name="BeneficiariosOutros" Type="Int32" />
        <asp:Parameter Name="ParticipantesOutros" Type="Int32" />
    </InsertParameters>
    <UpdateParameters>
        <asp:Parameter Name="Data" Type="DateTime" />
        <asp:Parameter Name="HoraInicio" Type="DateTime" />
        <asp:Parameter Name="HoraFim" Type="DateTime" />
        <asp:Parameter Name="Organizacao" Type="String" />
        <asp:Parameter Name="NomeActivistaId" Type="Int32" />
        <asp:Parameter Name="Activista" Type="String" />
        <asp:Parameter Name="EducadorPar" Type="Int32" />
        <asp:Parameter Name="LocalActividade" Type="Int32" />
        <asp:Parameter Name="Provincia" Type="Int32" />
        <asp:Parameter Name="Municipio" Type="Int32" />
        <asp:Parameter Name="GrupoAlvoSexo" Type="Boolean" />
        <asp:Parameter Name="GrupoAlvoCamionistas" Type="Boolean" />
        <asp:Parameter Name="GrupoAlvoClientes" Type="Boolean" />
        <asp:Parameter Name="GrupoAlvoOutros" Type="Boolean" />
        <asp:Parameter Name="BeneficiariosSexo" Type="Int32" />
        <asp:Parameter Name="ParticipantesSexo" Type="Int32" />
        <asp:Parameter Name="BeneficiariosCamionistas" Type="Int32" />
        <asp:Parameter Name="ParticipantesCamionistas" Type="Int32" />
        <asp:Parameter Name="TipoActividade" Type="Int32" />
        <asp:Parameter Name="CartoesSexo" Type="Int32" />
        <asp:Parameter Name="CartoesCamionista" Type="Int32" />
        <asp:Parameter Name="CartoesClientes" Type="Int32" />
        <asp:Parameter Name="CartoesOutros" Type="Int32" />
        <asp:Parameter Name="PreservativosSexo" Type="Int32" />
        <asp:Parameter Name="PreservativosCamionistas" Type="Int32" />
        <asp:Parameter Name="PreservativosClientes" Type="Int32" />
        <asp:Parameter Name="PreservativosOutros" Type="Int32" />
        <asp:Parameter Name="FolhetosSexo" Type="Int32" />
        <asp:Parameter Name="FolhetosCamionistas" Type="Int32" />
        <asp:Parameter Name="FolhetosClientes" Type="Int32" />
        <asp:Parameter Name="FolhetosOutros" Type="Int32" />
        <asp:Parameter Name="CartoesRecargaSexo" Type="Int32" />
        <asp:Parameter Name="CartoesRecargaCamionistas" Type="Int32" />
        <asp:Parameter Name="CartoesRecargaClientes" Type="Int32" />
        <asp:Parameter Name="CartoesRecargaOutros" Type="Int32" />
        <asp:Parameter Name="OutroMaterialSexo" Type="Int32" />
        <asp:Parameter Name="OutroMaterialCamionistas" Type="Int32" />
        <asp:Parameter Name="OutroMaterialClientes" Type="Int32" />
        <asp:Parameter Name="OutroMaterialOutros" Type="Int32" />
        <asp:Parameter Name="ComentariosAdicionais" Type="String" />
        <asp:Parameter Name="DataCriacao" Type="DateTime" />
        <asp:Parameter Name="DataActualizacao" Type="DateTime" />
        <asp:Parameter Name="UserCriacao" Type="String" />
        <asp:Parameter Name="UserActualizacao" Type="String" />
        <asp:Parameter Name="Aberto" Type="Boolean" />
        <asp:Parameter Name="BeneficiariosClientes" Type="Int32" />
        <asp:Parameter Name="ParticipantesClientes" Type="Int32" />
        <asp:Parameter Name="BeneficiariosOutros" Type="Int32" />
        <asp:Parameter Name="ParticipantesOutros" Type="Int32" />
        <asp:Parameter Name="ID" Type="Int32" />
    </UpdateParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="SqlDataSource2" runat="server" 
    ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" 
    DeleteCommand="DELETE FROM [tblFichaSupervisaoAlvo] WHERE [ID] = @ID" 
    InsertCommand="INSERT INTO [tblFichaSupervisaoAlvo] ([Data], [HoraInicio], [HoraFim], [Organizacao], [NomeActivistaId], [Activista], [EducadorPar], [LocalActividade], [Provincia], [Municipio], [GrupoAlvoSexo], [GrupoAlvoCamionistas], [GrupoAlvoClientes], [GrupoAlvoOutros], [BeneficiariosSexo], [ParticipantesSexo], [BeneficiariosCamionistas], [ParticipantesCamionistas], [BeneficiariosClientes], [ParticipantesClientes], [BeneficiariosOutros], [ParticipantesOutros], [MensagemSessao], [TipoActividade], [A_MensagemApresentada], [B_MensagemUtil], [C_OradorCompreendeu], [D_DificilAcompanhar], [E_AssistiuActividade], [F_SessaoRealizda], [G_TomarMedidas], [H_FazerPerguntas], [ComentariosAdicionais], [DataCriacao], [DataActualizacao], [UserCriacao], [UserActualizacao], [Aberto]) VALUES (@Data, @HoraInicio, @HoraFim, @Organizacao, @NomeActivistaId, @Activista, @EducadorPar, @LocalActividade, @Provincia, @Municipio, @GrupoAlvoSexo, @GrupoAlvoCamionistas, @GrupoAlvoClientes, @GrupoAlvoOutros, @BeneficiariosSexo, @ParticipantesSexo, @BeneficiariosCamionistas, @ParticipantesCamionistas, @BeneficiariosClientes, @ParticipantesClientes, @BeneficiariosOutros, @ParticipantesOutros, @MensagemSessao, @TipoActividade, @A_MensagemApresentada, @B_MensagemUtil, @C_OradorCompreendeu, @D_DificilAcompanhar, @E_AssistiuActividade, @F_SessaoRealizda, @G_TomarMedidas, @H_FazerPerguntas, @ComentariosAdicionais, @DataCriacao, @DataActualizacao, @UserCriacao, @UserActualizacao, @Aberto)" 
    SelectCommand="SELECT [ID], [Data], [HoraInicio], [HoraFim], [Organizacao], [NomeActivistaId], [Activista], [EducadorPar], [LocalActividade], [Provincia], [Municipio], [GrupoAlvoSexo], [GrupoAlvoCamionistas], [GrupoAlvoClientes], [GrupoAlvoOutros], [BeneficiariosSexo], [ParticipantesSexo], [BeneficiariosCamionistas], [ParticipantesCamionistas], [BeneficiariosClientes], [ParticipantesClientes], [BeneficiariosOutros], [ParticipantesOutros], [MensagemSessao], [TipoActividade], [A_MensagemApresentada], [B_MensagemUtil], [C_OradorCompreendeu], [D_DificilAcompanhar], [E_AssistiuActividade], [F_SessaoRealizda], [G_TomarMedidas], [H_FazerPerguntas], [ComentariosAdicionais], [DataCriacao], [DataActualizacao], [UserCriacao], [UserActualizacao], [Aberto] FROM [tblFichaSupervisaoAlvo]" 
    
        UpdateCommand="UPDATE [tblFichaSupervisaoAlvo] SET [Data] = @Data, [HoraInicio] = @HoraInicio, [HoraFim] = @HoraFim, [Organizacao] = @Organizacao, [NomeActivistaId] = @NomeActivistaId, [Activista] = @Activista, [EducadorPar] = @EducadorPar, [LocalActividade] = @LocalActividade, [Provincia] = @Provincia, [Municipio] = @Municipio, [GrupoAlvoSexo] = @GrupoAlvoSexo, [GrupoAlvoCamionistas] = @GrupoAlvoCamionistas, [GrupoAlvoClientes] = @GrupoAlvoClientes, [GrupoAlvoOutros] = @GrupoAlvoOutros, [BeneficiariosSexo] = @BeneficiariosSexo, [ParticipantesSexo] = @ParticipantesSexo, [BeneficiariosCamionistas] = @BeneficiariosCamionistas, [ParticipantesCamionistas] = @ParticipantesCamionistas, [BeneficiariosClientes] = @BeneficiariosClientes, [ParticipantesClientes] = @ParticipantesClientes, [BeneficiariosOutros] = @BeneficiariosOutros, [ParticipantesOutros] = @ParticipantesOutros, [MensagemSessao] = @MensagemSessao, [TipoActividade] = @TipoActividade, [A_MensagemApresentada] = @A_MensagemApresentada, [B_MensagemUtil] = @B_MensagemUtil, [C_OradorCompreendeu] = @C_OradorCompreendeu, [D_DificilAcompanhar] = @D_DificilAcompanhar, [E_AssistiuActividade] = @E_AssistiuActividade, [F_SessaoRealizda] = @F_SessaoRealizda, [G_TomarMedidas] = @G_TomarMedidas, [H_FazerPerguntas] = @H_FazerPerguntas, [ComentariosAdicionais] = @ComentariosAdicionais, [DataCriacao] = @DataCriacao, [DataActualizacao] = @DataActualizacao, [UserCriacao] = @UserCriacao, [UserActualizacao] = @UserActualizacao, [Aberto] = @Aberto WHERE [ID] = @ID">
    <DeleteParameters>
        <asp:Parameter Name="ID" Type="Int32" />
    </DeleteParameters>
    <InsertParameters>
        <asp:Parameter Name="Data" Type="DateTime" />
        <asp:Parameter Name="HoraInicio" Type="DateTime" />
        <asp:Parameter Name="HoraFim" Type="DateTime" />
        <asp:Parameter Name="Organizacao" Type="String" />
        <asp:Parameter Name="NomeActivistaId" Type="Int32" />
        <asp:Parameter Name="Activista" Type="String" />
        <asp:Parameter Name="EducadorPar" Type="Int32" />
        <asp:Parameter Name="LocalActividade" Type="Int32" />
        <asp:Parameter Name="Provincia" Type="Int32" />
        <asp:Parameter Name="Municipio" Type="Int32" />
        <asp:Parameter Name="GrupoAlvoSexo" Type="Boolean" />
        <asp:Parameter Name="GrupoAlvoCamionistas" Type="Boolean" />
        <asp:Parameter Name="GrupoAlvoClientes" Type="Boolean" />
        <asp:Parameter Name="GrupoAlvoOutros" Type="Boolean" />
        <asp:Parameter Name="BeneficiariosSexo" Type="Int32" />
        <asp:Parameter Name="ParticipantesSexo" Type="Int32" />
        <asp:Parameter Name="BeneficiariosCamionistas" Type="Int32" />
        <asp:Parameter Name="ParticipantesCamionistas" Type="Int32" />
        <asp:Parameter Name="BeneficiariosClientes" Type="Int32" />
        <asp:Parameter Name="ParticipantesClientes" Type="Int32" />
        <asp:Parameter Name="BeneficiariosOutros" Type="Int32" />
        <asp:Parameter Name="ParticipantesOutros" Type="Int32" />
        <asp:Parameter Name="MensagemSessao" Type="Int32" />
        <asp:Parameter Name="TipoActividade" Type="Int32" />
        <asp:Parameter Name="A_MensagemApresentada" Type="Int32" />
        <asp:Parameter Name="B_MensagemUtil" Type="Int32" />
        <asp:Parameter Name="C_OradorCompreendeu" Type="Int32" />
        <asp:Parameter Name="D_DificilAcompanhar" Type="Int32" />
        <asp:Parameter Name="E_AssistiuActividade" Type="Int32" />
        <asp:Parameter Name="F_SessaoRealizda" Type="Int32" />
        <asp:Parameter Name="G_TomarMedidas" Type="Int32" />
        <asp:Parameter Name="H_FazerPerguntas" Type="Int32" />
        <asp:Parameter Name="ComentariosAdicionais" Type="String" />
        <asp:Parameter Name="DataCriacao" Type="DateTime" />
        <asp:Parameter Name="DataActualizacao" Type="DateTime" />
        <asp:Parameter Name="UserCriacao" Type="String" />
        <asp:Parameter Name="UserActualizacao" Type="String" />
        <asp:Parameter Name="Aberto" Type="Boolean" />
    </InsertParameters>
    <UpdateParameters>
        <asp:Parameter Name="Data" Type="DateTime" />
        <asp:Parameter Name="HoraInicio" Type="DateTime" />
        <asp:Parameter Name="HoraFim" Type="DateTime" />
        <asp:Parameter Name="Organizacao" Type="String" />
        <asp:Parameter Name="NomeActivistaId" Type="Int32" />
        <asp:Parameter Name="Activista" Type="String" />
        <asp:Parameter Name="EducadorPar" Type="Int32" />
        <asp:Parameter Name="LocalActividade" Type="Int32" />
        <asp:Parameter Name="Provincia" Type="Int32" />
        <asp:Parameter Name="Municipio" Type="Int32" />
        <asp:Parameter Name="GrupoAlvoSexo" Type="Boolean" />
        <asp:Parameter Name="GrupoAlvoCamionistas" Type="Boolean" />
        <asp:Parameter Name="GrupoAlvoClientes" Type="Boolean" />
        <asp:Parameter Name="GrupoAlvoOutros" Type="Boolean" />
        <asp:Parameter Name="BeneficiariosSexo" Type="Int32" />
        <asp:Parameter Name="ParticipantesSexo" Type="Int32" />
        <asp:Parameter Name="BeneficiariosCamionistas" Type="Int32" />
        <asp:Parameter Name="ParticipantesCamionistas" Type="Int32" />
        <asp:Parameter Name="BeneficiariosClientes" Type="Int32" />
        <asp:Parameter Name="ParticipantesClientes" Type="Int32" />
        <asp:Parameter Name="BeneficiariosOutros" Type="Int32" />
        <asp:Parameter Name="ParticipantesOutros" Type="Int32" />
        <asp:Parameter Name="MensagemSessao" Type="Int32" />
        <asp:Parameter Name="TipoActividade" Type="Int32" />
        <asp:Parameter Name="A_MensagemApresentada" Type="Int32" />
        <asp:Parameter Name="B_MensagemUtil" Type="Int32" />
        <asp:Parameter Name="C_OradorCompreendeu" Type="Int32" />
        <asp:Parameter Name="D_DificilAcompanhar" Type="Int32" />
        <asp:Parameter Name="E_AssistiuActividade" Type="Int32" />
        <asp:Parameter Name="F_SessaoRealizda" Type="Int32" />
        <asp:Parameter Name="G_TomarMedidas" Type="Int32" />
        <asp:Parameter Name="H_FazerPerguntas" Type="Int32" />
        <asp:Parameter Name="ComentariosAdicionais" Type="String" />
        <asp:Parameter Name="DataCriacao" Type="DateTime" />
        <asp:Parameter Name="DataActualizacao" Type="DateTime" />
        <asp:Parameter Name="UserCriacao" Type="String" />
        <asp:Parameter Name="UserActualizacao" Type="String" />
        <asp:Parameter Name="Aberto" Type="Boolean" />
        <asp:Parameter Name="ID" Type="Int32" />
    </UpdateParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="SqlDataSource3" runat="server" 
    ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" 
    DeleteCommand="DELETE FROM [tblFichaAcompanhamento] WHERE [ID] = @ID" 
    InsertCommand="INSERT INTO [tblFichaAcompanhamento] ([Numero], [Data], [CIP_Activista], [CIP_EducacaoPar], [CIP_Outro], [GRUPO_Individual], [GRUPO_Pequeno], [GRUPO_Grande], [GRUPO_Freiras], [LOCAL_Foco], [LOCAL_ParqueEstacionamento], [LOCAL_Gam], [SERVICOS_Aconselhamento], [UnidadeSaude], [DataTecnico], [SERVICOSPRESTADOS_Aconselhamento], [SERVICOSPRESTADOS_Testagem], [REFERENCIADO_Rastreio], [REFERENCIADO_Planeamento], [REFERENCIADO_Tratamento], [REFERENCIADO_Acompanhamento], [OUTRO], [ComentariosAdicionais], [DataCriacao], [DataActualizacao], [UserCriacao], [UserActualizacao]) VALUES (@Numero, @Data, @CIP_Activista, @CIP_EducacaoPar, @CIP_Outro, @GRUPO_Individual, @GRUPO_Pequeno, @GRUPO_Grande, @GRUPO_Freiras, @LOCAL_Foco, @LOCAL_ParqueEstacionamento, @LOCAL_Gam, @SERVICOS_Aconselhamento, @UnidadeSaude, @DataTecnico, @SERVICOSPRESTADOS_Aconselhamento, @SERVICOSPRESTADOS_Testagem, @REFERENCIADO_Rastreio, @REFERENCIADO_Planeamento, @REFERENCIADO_Tratamento, @REFERENCIADO_Acompanhamento, @OUTRO, @ComentariosAdicionais, @DataCriacao, @DataActualizacao, @UserCriacao, @UserActualizacao)" 
    SelectCommand="SELECT [Numero], [Data], [CIP_Activista], [CIP_EducacaoPar], [CIP_Outro], [GRUPO_Individual], [GRUPO_Pequeno], [GRUPO_Grande], [GRUPO_Freiras], [LOCAL_Foco], [LOCAL_ParqueEstacionamento], [LOCAL_Gam], [SERVICOS_Aconselhamento], [UnidadeSaude], [DataTecnico], [SERVICOSPRESTADOS_Aconselhamento], [SERVICOSPRESTADOS_Testagem], [REFERENCIADO_Rastreio], [REFERENCIADO_Planeamento], [REFERENCIADO_Tratamento], [REFERENCIADO_Acompanhamento], [OUTRO], [ID], [ComentariosAdicionais], [DataCriacao], [DataActualizacao], [UserCriacao], [UserActualizacao] FROM [tblFichaAcompanhamento]" 
    UpdateCommand="UPDATE [tblFichaAcompanhamento] SET [Numero] = @Numero, [Data] = @Data, [CIP_Activista] = @CIP_Activista, [CIP_EducacaoPar] = @CIP_EducacaoPar, [CIP_Outro] = @CIP_Outro, [GRUPO_Individual] = @GRUPO_Individual, [GRUPO_Pequeno] = @GRUPO_Pequeno, [GRUPO_Grande] = @GRUPO_Grande, [GRUPO_Freiras] = @GRUPO_Freiras, [LOCAL_Foco] = @LOCAL_Foco, [LOCAL_ParqueEstacionamento] = @LOCAL_ParqueEstacionamento, [LOCAL_Gam] = @LOCAL_Gam, [SERVICOS_Aconselhamento] = @SERVICOS_Aconselhamento, [UnidadeSaude] = @UnidadeSaude, [DataTecnico] = @DataTecnico, [SERVICOSPRESTADOS_Aconselhamento] = @SERVICOSPRESTADOS_Aconselhamento, [SERVICOSPRESTADOS_Testagem] = @SERVICOSPRESTADOS_Testagem, [REFERENCIADO_Rastreio] = @REFERENCIADO_Rastreio, [REFERENCIADO_Planeamento] = @REFERENCIADO_Planeamento, [REFERENCIADO_Tratamento] = @REFERENCIADO_Tratamento, [REFERENCIADO_Acompanhamento] = @REFERENCIADO_Acompanhamento, [OUTRO] = @OUTRO, [ComentariosAdicionais] = @ComentariosAdicionais, [DataCriacao] = @DataCriacao, [DataActualizacao] = @DataActualizacao, [UserCriacao] = @UserCriacao, [UserActualizacao] = @UserActualizacao WHERE [ID] = @ID">
    <DeleteParameters>
        <asp:Parameter Name="ID" Type="Int32" />
    </DeleteParameters>
    <InsertParameters>
        <asp:Parameter Name="Numero" Type="Int32" />
        <asp:Parameter Name="Data" Type="DateTime" />
        <asp:Parameter Name="CIP_Activista" Type="Boolean" />
        <asp:Parameter Name="CIP_EducacaoPar" Type="Boolean" />
        <asp:Parameter Name="CIP_Outro" Type="Boolean" />
        <asp:Parameter Name="GRUPO_Individual" Type="Boolean" />
        <asp:Parameter Name="GRUPO_Pequeno" Type="Boolean" />
        <asp:Parameter Name="GRUPO_Grande" Type="Boolean" />
        <asp:Parameter Name="GRUPO_Freiras" Type="Boolean" />
        <asp:Parameter Name="LOCAL_Foco" Type="Boolean" />
        <asp:Parameter Name="LOCAL_ParqueEstacionamento" Type="Boolean" />
        <asp:Parameter Name="LOCAL_Gam" Type="Boolean" />
        <asp:Parameter Name="SERVICOS_Aconselhamento" Type="Boolean" />
        <asp:Parameter Name="UnidadeSaude" Type="String" />
        <asp:Parameter DbType="Date" Name="DataTecnico" />
        <asp:Parameter Name="SERVICOSPRESTADOS_Aconselhamento" Type="Boolean" />
        <asp:Parameter Name="SERVICOSPRESTADOS_Testagem" Type="Boolean" />
        <asp:Parameter Name="REFERENCIADO_Rastreio" Type="Boolean" />
        <asp:Parameter Name="REFERENCIADO_Planeamento" Type="Boolean" />
        <asp:Parameter Name="REFERENCIADO_Tratamento" Type="Boolean" />
        <asp:Parameter Name="REFERENCIADO_Acompanhamento" Type="Boolean" />
        <asp:Parameter Name="OUTRO" Type="String" />
        <asp:Parameter Name="ComentariosAdicionais" Type="String" />
        <asp:Parameter Name="DataCriacao" Type="DateTime" />
        <asp:Parameter Name="DataActualizacao" Type="DateTime" />
        <asp:Parameter Name="UserCriacao" Type="String" />
        <asp:Parameter Name="UserActualizacao" Type="String" />
    </InsertParameters>
    <UpdateParameters>
        <asp:Parameter Name="Numero" Type="Int32" />
        <asp:Parameter Name="Data" Type="DateTime" />
        <asp:Parameter Name="CIP_Activista" Type="Boolean" />
        <asp:Parameter Name="CIP_EducacaoPar" Type="Boolean" />
        <asp:Parameter Name="CIP_Outro" Type="Boolean" />
        <asp:Parameter Name="GRUPO_Individual" Type="Boolean" />
        <asp:Parameter Name="GRUPO_Pequeno" Type="Boolean" />
        <asp:Parameter Name="GRUPO_Grande" Type="Boolean" />
        <asp:Parameter Name="GRUPO_Freiras" Type="Boolean" />
        <asp:Parameter Name="LOCAL_Foco" Type="Boolean" />
        <asp:Parameter Name="LOCAL_ParqueEstacionamento" Type="Boolean" />
        <asp:Parameter Name="LOCAL_Gam" Type="Boolean" />
        <asp:Parameter Name="SERVICOS_Aconselhamento" Type="Boolean" />
        <asp:Parameter Name="UnidadeSaude" Type="String" />
        <asp:Parameter DbType="Date" Name="DataTecnico" />
        <asp:Parameter Name="SERVICOSPRESTADOS_Aconselhamento" Type="Boolean" />
        <asp:Parameter Name="SERVICOSPRESTADOS_Testagem" Type="Boolean" />
        <asp:Parameter Name="REFERENCIADO_Rastreio" Type="Boolean" />
        <asp:Parameter Name="REFERENCIADO_Planeamento" Type="Boolean" />
        <asp:Parameter Name="REFERENCIADO_Tratamento" Type="Boolean" />
        <asp:Parameter Name="REFERENCIADO_Acompanhamento" Type="Boolean" />
        <asp:Parameter Name="OUTRO" Type="String" />
        <asp:Parameter Name="ComentariosAdicionais" Type="String" />
        <asp:Parameter Name="DataCriacao" Type="DateTime" />
        <asp:Parameter Name="DataActualizacao" Type="DateTime" />
        <asp:Parameter Name="UserCriacao" Type="String" />
        <asp:Parameter Name="UserActualizacao" Type="String" />
        <asp:Parameter Name="ID" Type="Int32" />
    </UpdateParameters>
</asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource4" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" 
        SelectCommand="SELECT [ID], [Data], [HoraInicio], [HoraFim], [Organizacao], [NomeActivistaId], [NomeActivista], [Provincia], [Municipio], [TipoFicha], [ProvinciaId], [MunicipioId] FROM [vw_appListaFecho] WHERE (([Data] = @Data) AND ([Data] = @Data2) AND ([TipoFicha] = @TipoFicha))">
        <SelectParameters>
            <asp:Parameter DefaultValue="1" Name="Data" Type="DateTime" />
            <asp:Parameter DefaultValue="2" Name="Data2" Type="DateTime" />
            <asp:Parameter DefaultValue="3" Name="TipoFicha" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource5" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" 
        DeleteCommand="DELETE FROM [tblFichaSupervisaoActivista] WHERE [ID] = @ID" 
        InsertCommand="INSERT INTO [tblFichaSupervisaoActivista] ([Data], [HoraInicio], [HoraFim], [Organizacao], [NomeActivistaId], [Activista], [EducadorPar], [LocalActividade], [Provincia], [Municipio], [GrupoAlvoSexo], [GrupoAlvoCamionistas], [GrupoAlvoClientes], [GrupoAlvoOutros], [BeneficiariosSexo], [ParticipantesSexo], [BeneficiariosCamionistas], [ParticipantesCamionistas], [BeneficiariosClientes], [ParticipantesClientes], [BeneficiariosOutros], [ParticipantesOutros], [TipoActividade], [A_MotivoSaida], [B_DemonstraRespeito], [C_ComunicaEntendimento], [D_RecepcaoCalorosa], [E_AtencaoParticipantes], [F_RespeitaGrupoAlvo], [A_ConversaFeedback], [B_SolicitaExperiencias], [A_ConflitosActivista], [B_SuperaQuestoes], [A_UsoAdequadoFerramentas], [A_UsoAdequadoMsg], [A_EncaminhaQuandoNaoSabe], [B_EstavaPreparadoActividade], [C_ReferenciasEficazes], [D_PreservativosDistribuidos], [E_ExplicouApoio], [ComentariosAdicionais], [DataCriacao], [DataActualizacao], [UserCriacao], [UserActualizacao], [Aberto]) VALUES (@Data, @HoraInicio, @HoraFim, @Organizacao, @NomeActivistaId, @Activista, @EducadorPar, @LocalActividade, @Provincia, @Municipio, @GrupoAlvoSexo, @GrupoAlvoCamionistas, @GrupoAlvoClientes, @GrupoAlvoOutros, @BeneficiariosSexo, @ParticipantesSexo, @BeneficiariosCamionistas, @ParticipantesCamionistas, @BeneficiariosClientes, @ParticipantesClientes, @BeneficiariosOutros, @ParticipantesOutros, @TipoActividade, @A_MotivoSaida, @B_DemonstraRespeito, @C_ComunicaEntendimento, @D_RecepcaoCalorosa, @E_AtencaoParticipantes, @F_RespeitaGrupoAlvo, @A_ConversaFeedback, @B_SolicitaExperiencias, @A_ConflitosActivista, @B_SuperaQuestoes, @A_UsoAdequadoFerramentas, @A_UsoAdequadoMsg, @A_EncaminhaQuandoNaoSabe, @B_EstavaPreparadoActividade, @C_ReferenciasEficazes, @D_PreservativosDistribuidos, @E_ExplicouApoio, @ComentariosAdicionais, @DataCriacao, @DataActualizacao, @UserCriacao, @UserActualizacao, @Aberto)" 
        SelectCommand="SELECT [ID], [Data], [HoraInicio], [HoraFim], [Organizacao], [NomeActivistaId], [Activista], [EducadorPar], [LocalActividade], [Provincia], [Municipio], [GrupoAlvoSexo], [GrupoAlvoCamionistas], [GrupoAlvoClientes], [GrupoAlvoOutros], [BeneficiariosSexo], [ParticipantesSexo], [BeneficiariosCamionistas], [ParticipantesCamionistas], [BeneficiariosClientes], [ParticipantesClientes], [BeneficiariosOutros], [ParticipantesOutros], [TipoActividade], [A_MotivoSaida], [B_DemonstraRespeito], [C_ComunicaEntendimento], [D_RecepcaoCalorosa], [E_AtencaoParticipantes], [F_RespeitaGrupoAlvo], [A_ConversaFeedback], [B_SolicitaExperiencias], [A_ConflitosActivista], [B_SuperaQuestoes], [A_UsoAdequadoFerramentas], [A_UsoAdequadoMsg], [A_EncaminhaQuandoNaoSabe], [B_EstavaPreparadoActividade], [C_ReferenciasEficazes], [D_PreservativosDistribuidos], [E_ExplicouApoio], [ComentariosAdicionais], [DataCriacao], [DataActualizacao], [UserCriacao], [UserActualizacao], [Aberto] FROM [tblFichaSupervisaoActivista]" 
        UpdateCommand="UPDATE [tblFichaSupervisaoActivista] SET [Data] = @Data, [HoraInicio] = @HoraInicio, [HoraFim] = @HoraFim, [Organizacao] = @Organizacao, [NomeActivistaId] = @NomeActivistaId, [Activista] = @Activista, [EducadorPar] = @EducadorPar, [LocalActividade] = @LocalActividade, [Provincia] = @Provincia, [Municipio] = @Municipio, [GrupoAlvoSexo] = @GrupoAlvoSexo, [GrupoAlvoCamionistas] = @GrupoAlvoCamionistas, [GrupoAlvoClientes] = @GrupoAlvoClientes, [GrupoAlvoOutros] = @GrupoAlvoOutros, [BeneficiariosSexo] = @BeneficiariosSexo, [ParticipantesSexo] = @ParticipantesSexo, [BeneficiariosCamionistas] = @BeneficiariosCamionistas, [ParticipantesCamionistas] = @ParticipantesCamionistas, [BeneficiariosClientes] = @BeneficiariosClientes, [ParticipantesClientes] = @ParticipantesClientes, [BeneficiariosOutros] = @BeneficiariosOutros, [ParticipantesOutros] = @ParticipantesOutros, [TipoActividade] = @TipoActividade, [A_MotivoSaida] = @A_MotivoSaida, [B_DemonstraRespeito] = @B_DemonstraRespeito, [C_ComunicaEntendimento] = @C_ComunicaEntendimento, [D_RecepcaoCalorosa] = @D_RecepcaoCalorosa, [E_AtencaoParticipantes] = @E_AtencaoParticipantes, [F_RespeitaGrupoAlvo] = @F_RespeitaGrupoAlvo, [A_ConversaFeedback] = @A_ConversaFeedback, [B_SolicitaExperiencias] = @B_SolicitaExperiencias, [A_ConflitosActivista] = @A_ConflitosActivista, [B_SuperaQuestoes] = @B_SuperaQuestoes, [A_UsoAdequadoFerramentas] = @A_UsoAdequadoFerramentas, [A_UsoAdequadoMsg] = @A_UsoAdequadoMsg, [A_EncaminhaQuandoNaoSabe] = @A_EncaminhaQuandoNaoSabe, [B_EstavaPreparadoActividade] = @B_EstavaPreparadoActividade, [C_ReferenciasEficazes] = @C_ReferenciasEficazes, [D_PreservativosDistribuidos] = @D_PreservativosDistribuidos, [E_ExplicouApoio] = @E_ExplicouApoio, [ComentariosAdicionais] = @ComentariosAdicionais, [DataCriacao] = @DataCriacao, [DataActualizacao] = @DataActualizacao, [UserCriacao] = @UserCriacao, [UserActualizacao] = @UserActualizacao, [Aberto] = @Aberto WHERE [ID] = @ID">
        <DeleteParameters>
            <asp:Parameter Name="ID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="Data" Type="DateTime" />
            <asp:Parameter Name="HoraInicio" Type="DateTime" />
            <asp:Parameter Name="HoraFim" Type="DateTime" />
            <asp:Parameter Name="Organizacao" Type="String" />
            <asp:Parameter Name="NomeActivistaId" Type="Int32" />
            <asp:Parameter Name="Activista" Type="String" />
            <asp:Parameter Name="EducadorPar" Type="Int32" />
            <asp:Parameter Name="LocalActividade" Type="Int32" />
            <asp:Parameter Name="Provincia" Type="Int32" />
            <asp:Parameter Name="Municipio" Type="Int32" />
            <asp:Parameter Name="GrupoAlvoSexo" Type="Boolean" />
            <asp:Parameter Name="GrupoAlvoCamionistas" Type="Boolean" />
            <asp:Parameter Name="GrupoAlvoClientes" Type="Boolean" />
            <asp:Parameter Name="GrupoAlvoOutros" Type="Boolean" />
            <asp:Parameter Name="BeneficiariosSexo" Type="Int32" />
            <asp:Parameter Name="ParticipantesSexo" Type="Int32" />
            <asp:Parameter Name="BeneficiariosCamionistas" Type="Int32" />
            <asp:Parameter Name="ParticipantesCamionistas" Type="Int32" />
            <asp:Parameter Name="BeneficiariosClientes" Type="Int32" />
            <asp:Parameter Name="ParticipantesClientes" Type="Int32" />
            <asp:Parameter Name="BeneficiariosOutros" Type="Int32" />
            <asp:Parameter Name="ParticipantesOutros" Type="Int32" />
            <asp:Parameter Name="TipoActividade" Type="Int32" />
            <asp:Parameter Name="A_MotivoSaida" Type="Int32" />
            <asp:Parameter Name="B_DemonstraRespeito" Type="Int32" />
            <asp:Parameter Name="C_ComunicaEntendimento" Type="Int32" />
            <asp:Parameter Name="D_RecepcaoCalorosa" Type="Int32" />
            <asp:Parameter Name="E_AtencaoParticipantes" Type="Int32" />
            <asp:Parameter Name="F_RespeitaGrupoAlvo" Type="Int32" />
            <asp:Parameter Name="A_ConversaFeedback" Type="Int32" />
            <asp:Parameter Name="B_SolicitaExperiencias" Type="Int32" />
            <asp:Parameter Name="A_ConflitosActivista" Type="Int32" />
            <asp:Parameter Name="B_SuperaQuestoes" Type="Int32" />
            <asp:Parameter Name="A_UsoAdequadoFerramentas" Type="Int32" />
            <asp:Parameter Name="A_UsoAdequadoMsg" Type="Int32" />
            <asp:Parameter Name="A_EncaminhaQuandoNaoSabe" Type="Int32" />
            <asp:Parameter Name="B_EstavaPreparadoActividade" Type="Int32" />
            <asp:Parameter Name="C_ReferenciasEficazes" Type="Int32" />
            <asp:Parameter Name="D_PreservativosDistribuidos" Type="Int32" />
            <asp:Parameter Name="E_ExplicouApoio" Type="Int32" />
            <asp:Parameter Name="ComentariosAdicionais" Type="String" />
            <asp:Parameter Name="DataCriacao" Type="DateTime" />
            <asp:Parameter Name="DataActualizacao" Type="DateTime" />
            <asp:Parameter Name="UserCriacao" Type="String" />
            <asp:Parameter Name="UserActualizacao" Type="String" />
            <asp:Parameter Name="Aberto" Type="Boolean" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="Data" Type="DateTime" />
            <asp:Parameter Name="HoraInicio" Type="DateTime" />
            <asp:Parameter Name="HoraFim" Type="DateTime" />
            <asp:Parameter Name="Organizacao" Type="String" />
            <asp:Parameter Name="NomeActivistaId" Type="Int32" />
            <asp:Parameter Name="Activista" Type="String" />
            <asp:Parameter Name="EducadorPar" Type="Int32" />
            <asp:Parameter Name="LocalActividade" Type="Int32" />
            <asp:Parameter Name="Provincia" Type="Int32" />
            <asp:Parameter Name="Municipio" Type="Int32" />
            <asp:Parameter Name="GrupoAlvoSexo" Type="Boolean" />
            <asp:Parameter Name="GrupoAlvoCamionistas" Type="Boolean" />
            <asp:Parameter Name="GrupoAlvoClientes" Type="Boolean" />
            <asp:Parameter Name="GrupoAlvoOutros" Type="Boolean" />
            <asp:Parameter Name="BeneficiariosSexo" Type="Int32" />
            <asp:Parameter Name="ParticipantesSexo" Type="Int32" />
            <asp:Parameter Name="BeneficiariosCamionistas" Type="Int32" />
            <asp:Parameter Name="ParticipantesCamionistas" Type="Int32" />
            <asp:Parameter Name="BeneficiariosClientes" Type="Int32" />
            <asp:Parameter Name="ParticipantesClientes" Type="Int32" />
            <asp:Parameter Name="BeneficiariosOutros" Type="Int32" />
            <asp:Parameter Name="ParticipantesOutros" Type="Int32" />
            <asp:Parameter Name="TipoActividade" Type="Int32" />
            <asp:Parameter Name="A_MotivoSaida" Type="Int32" />
            <asp:Parameter Name="B_DemonstraRespeito" Type="Int32" />
            <asp:Parameter Name="C_ComunicaEntendimento" Type="Int32" />
            <asp:Parameter Name="D_RecepcaoCalorosa" Type="Int32" />
            <asp:Parameter Name="E_AtencaoParticipantes" Type="Int32" />
            <asp:Parameter Name="F_RespeitaGrupoAlvo" Type="Int32" />
            <asp:Parameter Name="A_ConversaFeedback" Type="Int32" />
            <asp:Parameter Name="B_SolicitaExperiencias" Type="Int32" />
            <asp:Parameter Name="A_ConflitosActivista" Type="Int32" />
            <asp:Parameter Name="B_SuperaQuestoes" Type="Int32" />
            <asp:Parameter Name="A_UsoAdequadoFerramentas" Type="Int32" />
            <asp:Parameter Name="A_UsoAdequadoMsg" Type="Int32" />
            <asp:Parameter Name="A_EncaminhaQuandoNaoSabe" Type="Int32" />
            <asp:Parameter Name="B_EstavaPreparadoActividade" Type="Int32" />
            <asp:Parameter Name="C_ReferenciasEficazes" Type="Int32" />
            <asp:Parameter Name="D_PreservativosDistribuidos" Type="Int32" />
            <asp:Parameter Name="E_ExplicouApoio" Type="Int32" />
            <asp:Parameter Name="ComentariosAdicionais" Type="String" />
            <asp:Parameter Name="DataCriacao" Type="DateTime" />
            <asp:Parameter Name="DataActualizacao" Type="DateTime" />
            <asp:Parameter Name="UserCriacao" Type="String" />
            <asp:Parameter Name="UserActualizacao" Type="String" />
            <asp:Parameter Name="Aberto" Type="Boolean" />
            <asp:Parameter Name="ID" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource6" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" DeleteCommand="DELETE FROM [mpla_militante] WHERE [MilitanteID] = @MilitanteID" InsertCommand="INSERT INTO [mpla_militante] ([CAPID], [Nome], [Pseudonino], [NomePai], [NomeMae], [DataNascimento], [LocalNascimento], [ProvinciaNascID], [MunicipioNascID], [ComunaNascID], [BI], [DataEmissao], [Arquivo], [NomeEmpresa], [MoradaEmpresa], [TelefoneEmpresa], [Profissao], [Funcao], [HabilitacoesID], [EstadoCivilID], [NomeConjuge], [Morada], [ProvinciaMoradaID], [MunicipioMoradaID], [ComunaMoradaID], [Telemovel], [Email], [NIF], [NumeroEleitor], [GrupoEleitor], [RecomendacaoNomeMilitante1], [RecomendacaoComiteAccao1], [RecomendacaoAnosMilitancia1], [RecomendacaoConheceReq1], [RecomendacaoNomeMilitante2], [RecomendacaoComiteAccao2], [RecomendacaoAnosMilitancia2], [RecomendacaoConheceReq2], [ConfirmacaoNomeMilitante], [ConfirmacaoAtribuicao], [UserIDCriacao], [DataCriacao], [UserIDActualizacao], [DataActualizacao], [Estado]) VALUES (@CAPID, @Nome, @Pseudonino, @NomePai, @NomeMae, @DataNascimento, @LocalNascimento, @ProvinciaNascID, @MunicipioNascID, @ComunaNascID, @BI, @DataEmissao, @Arquivo, @NomeEmpresa, @MoradaEmpresa, @TelefoneEmpresa, @Profissao, @Funcao, @HabilitacoesID, @EstadoCivilID, @NomeConjuge, @Morada, @ProvinciaMoradaID, @MunicipioMoradaID, @ComunaMoradaID, @Telemovel, @Email, @NIF, @NumeroEleitor, @GrupoEleitor, @RecomendacaoNomeMilitante1, @RecomendacaoComiteAccao1, @RecomendacaoAnosMilitancia1, @RecomendacaoConheceReq1, @RecomendacaoNomeMilitante2, @RecomendacaoComiteAccao2, @RecomendacaoAnosMilitancia2, @RecomendacaoConheceReq2, @ConfirmacaoNomeMilitante, @ConfirmacaoAtribuicao, @UserIDCriacao, @DataCriacao, @UserIDActualizacao, @DataActualizacao, @Estado)" SelectCommand="SELECT * FROM [mpla_militante]" UpdateCommand="UPDATE [mpla_militante] SET [CAPID] = @CAPID, [Nome] = @Nome, [Pseudonino] = @Pseudonino, [NomePai] = @NomePai, [NomeMae] = @NomeMae, [DataNascimento] = @DataNascimento, [LocalNascimento] = @LocalNascimento, [ProvinciaNascID] = @ProvinciaNascID, [MunicipioNascID] = @MunicipioNascID, [ComunaNascID] = @ComunaNascID, [BI] = @BI, [DataEmissao] = @DataEmissao, [Arquivo] = @Arquivo, [NomeEmpresa] = @NomeEmpresa, [MoradaEmpresa] = @MoradaEmpresa, [TelefoneEmpresa] = @TelefoneEmpresa, [Profissao] = @Profissao, [Funcao] = @Funcao, [HabilitacoesID] = @HabilitacoesID, [EstadoCivilID] = @EstadoCivilID, [NomeConjuge] = @NomeConjuge, [Morada] = @Morada, [ProvinciaMoradaID] = @ProvinciaMoradaID, [MunicipioMoradaID] = @MunicipioMoradaID, [ComunaMoradaID] = @ComunaMoradaID, [Telemovel] = @Telemovel, [Email] = @Email, [NIF] = @NIF, [NumeroEleitor] = @NumeroEleitor, [GrupoEleitor] = @GrupoEleitor, [RecomendacaoNomeMilitante1] = @RecomendacaoNomeMilitante1, [RecomendacaoComiteAccao1] = @RecomendacaoComiteAccao1, [RecomendacaoAnosMilitancia1] = @RecomendacaoAnosMilitancia1, [RecomendacaoConheceReq1] = @RecomendacaoConheceReq1, [RecomendacaoNomeMilitante2] = @RecomendacaoNomeMilitante2, [RecomendacaoComiteAccao2] = @RecomendacaoComiteAccao2, [RecomendacaoAnosMilitancia2] = @RecomendacaoAnosMilitancia2, [RecomendacaoConheceReq2] = @RecomendacaoConheceReq2, [ConfirmacaoNomeMilitante] = @ConfirmacaoNomeMilitante, [ConfirmacaoAtribuicao] = @ConfirmacaoAtribuicao, [UserIDCriacao] = @UserIDCriacao, [DataCriacao] = @DataCriacao, [UserIDActualizacao] = @UserIDActualizacao, [DataActualizacao] = @DataActualizacao, [Estado] = @Estado WHERE [MilitanteID] = @MilitanteID">
        <DeleteParameters>
            <asp:Parameter Name="MilitanteID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="CAPID" Type="Int32" />
            <asp:Parameter Name="Nome" Type="String" />
            <asp:Parameter Name="Pseudonino" Type="String" />
            <asp:Parameter Name="NomePai" Type="String" />
            <asp:Parameter Name="NomeMae" Type="String" />
            <asp:Parameter Name="DataNascimento" Type="DateTime" />
            <asp:Parameter Name="LocalNascimento" Type="String" />
            <asp:Parameter Name="ProvinciaNascID" Type="Int32" />
            <asp:Parameter Name="MunicipioNascID" Type="Int32" />
            <asp:Parameter Name="ComunaNascID" Type="Int32" />
            <asp:Parameter Name="BI" Type="String" />
            <asp:Parameter Name="DataEmissao" Type="DateTime" />
            <asp:Parameter Name="Arquivo" Type="String" />
            <asp:Parameter Name="NomeEmpresa" Type="String" />
            <asp:Parameter Name="MoradaEmpresa" Type="String" />
            <asp:Parameter Name="TelefoneEmpresa" Type="String" />
            <asp:Parameter Name="Profissao" Type="String" />
            <asp:Parameter Name="Funcao" Type="String" />
            <asp:Parameter Name="HabilitacoesID" Type="Int32" />
            <asp:Parameter Name="EstadoCivilID" Type="Int32" />
            <asp:Parameter Name="NomeConjuge" Type="String" />
            <asp:Parameter Name="Morada" Type="String" />
            <asp:Parameter Name="ProvinciaMoradaID" Type="Int32" />
            <asp:Parameter Name="MunicipioMoradaID" Type="Int32" />
            <asp:Parameter Name="ComunaMoradaID" Type="Int32" />
            <asp:Parameter Name="Telemovel" Type="String" />
            <asp:Parameter Name="Email" Type="String" />
            <asp:Parameter Name="NIF" Type="String" />
            <asp:Parameter Name="NumeroEleitor" Type="String" />
            <asp:Parameter Name="GrupoEleitor" Type="String" />
            <asp:Parameter Name="RecomendacaoNomeMilitante1" Type="String" />
            <asp:Parameter Name="RecomendacaoComiteAccao1" Type="Int32" />
            <asp:Parameter Name="RecomendacaoAnosMilitancia1" Type="Int32" />
            <asp:Parameter Name="RecomendacaoConheceReq1" Type="Int32" />
            <asp:Parameter Name="RecomendacaoNomeMilitante2" Type="String" />
            <asp:Parameter Name="RecomendacaoComiteAccao2" Type="Int32" />
            <asp:Parameter Name="RecomendacaoAnosMilitancia2" Type="Int32" />
            <asp:Parameter Name="RecomendacaoConheceReq2" Type="Int32" />
            <asp:Parameter Name="ConfirmacaoNomeMilitante" Type="String" />
            <asp:Parameter Name="ConfirmacaoAtribuicao" Type="DateTime" />
            <asp:Parameter Name="UserIDCriacao" Type="Object" />
            <asp:Parameter Name="DataCriacao" Type="DateTime" />
            <asp:Parameter Name="UserIDActualizacao" Type="Object" />
            <asp:Parameter Name="DataActualizacao" Type="DateTime" />
            <asp:Parameter Name="Estado" Type="Int32" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="CAPID" Type="Int32" />
            <asp:Parameter Name="Nome" Type="String" />
            <asp:Parameter Name="Pseudonino" Type="String" />
            <asp:Parameter Name="NomePai" Type="String" />
            <asp:Parameter Name="NomeMae" Type="String" />
            <asp:Parameter Name="DataNascimento" Type="DateTime" />
            <asp:Parameter Name="LocalNascimento" Type="String" />
            <asp:Parameter Name="ProvinciaNascID" Type="Int32" />
            <asp:Parameter Name="MunicipioNascID" Type="Int32" />
            <asp:Parameter Name="ComunaNascID" Type="Int32" />
            <asp:Parameter Name="BI" Type="String" />
            <asp:Parameter Name="DataEmissao" Type="DateTime" />
            <asp:Parameter Name="Arquivo" Type="String" />
            <asp:Parameter Name="NomeEmpresa" Type="String" />
            <asp:Parameter Name="MoradaEmpresa" Type="String" />
            <asp:Parameter Name="TelefoneEmpresa" Type="String" />
            <asp:Parameter Name="Profissao" Type="String" />
            <asp:Parameter Name="Funcao" Type="String" />
            <asp:Parameter Name="HabilitacoesID" Type="Int32" />
            <asp:Parameter Name="EstadoCivilID" Type="Int32" />
            <asp:Parameter Name="NomeConjuge" Type="String" />
            <asp:Parameter Name="Morada" Type="String" />
            <asp:Parameter Name="ProvinciaMoradaID" Type="Int32" />
            <asp:Parameter Name="MunicipioMoradaID" Type="Int32" />
            <asp:Parameter Name="ComunaMoradaID" Type="Int32" />
            <asp:Parameter Name="Telemovel" Type="String" />
            <asp:Parameter Name="Email" Type="String" />
            <asp:Parameter Name="NIF" Type="String" />
            <asp:Parameter Name="NumeroEleitor" Type="String" />
            <asp:Parameter Name="GrupoEleitor" Type="String" />
            <asp:Parameter Name="RecomendacaoNomeMilitante1" Type="String" />
            <asp:Parameter Name="RecomendacaoComiteAccao1" Type="Int32" />
            <asp:Parameter Name="RecomendacaoAnosMilitancia1" Type="Int32" />
            <asp:Parameter Name="RecomendacaoConheceReq1" Type="Int32" />
            <asp:Parameter Name="RecomendacaoNomeMilitante2" Type="String" />
            <asp:Parameter Name="RecomendacaoComiteAccao2" Type="Int32" />
            <asp:Parameter Name="RecomendacaoAnosMilitancia2" Type="Int32" />
            <asp:Parameter Name="RecomendacaoConheceReq2" Type="Int32" />
            <asp:Parameter Name="ConfirmacaoNomeMilitante" Type="String" />
            <asp:Parameter Name="ConfirmacaoAtribuicao" Type="DateTime" />
            <asp:Parameter Name="UserIDCriacao" Type="Object" />
            <asp:Parameter Name="DataCriacao" Type="DateTime" />
            <asp:Parameter Name="UserIDActualizacao" Type="Object" />
            <asp:Parameter Name="DataActualizacao" Type="DateTime" />
            <asp:Parameter Name="Estado" Type="Int32" />
            <asp:Parameter Name="MilitanteID" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>
