<%@ Page Title="Início" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeBehind="Default.aspx.cs" Inherits="MASTERSEGUROS.WEB._Default" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>&nbsp;&nbsp;&nbsp;&nbsp;DASHBOARDS
    </h2>
    <p>
    </p>

    <p>
        <asp:LoginView ID="HeadLoginView" Visible="false" runat="server" EnableViewState="false">
            <AnonymousTemplate>
                Para começar a utilizar o sistema clique em <a href="~/Account/Login.aspx" id="HeadLoginStatus" runat="server">Iniciar Sessão</a>. 
            </AnonymousTemplate>
        </asp:LoginView>

    </p>
    <section class="content">
     
       <div class="row">
        <div class="col-lg-3 col-xs-6">
          <!-- small box -->
          <div class="small-box bg-aqua">
            <div class="inner">
              <h3><%=getApolices()%></h3>

              <p>Apólices Automóvel</p>
            </div>
            <div class="icon">
              <i class="ion ion-bag"></i>
            </div>
            <a href="#" class="small-box-footer">Mais info <i class="fa fa-arrow-circle-right"></i></a>
          </div>
        </div>
        <!-- ./col -->
        <div class="col-lg-3 col-xs-6">
          <!-- small box -->
          <div class="small-box bg-green">
            <div class="inner">
              <!--<h3>53<sup style="font-size: 20px">%</sup></h3>-->
                <h3><%=getAvisosPagamento()%><sup style="font-size: 20px"></sup></h3>
                <p>Apólices em Pagamento</p>
            </div>
            <div class="icon">
              <i class="ion ion-stats-bars"></i>
            </div>
            <a href="#" class="small-box-footer">Mais Info <i class="fa fa-arrow-circle-right"></i></a>
          </div>
        </div>
        <!-- ./col -->
        <div class="col-lg-3 col-xs-6">
          <!-- small box -->
          <div class="small-box bg-yellow">
            <div class="inner">
              <h3><%=getCountClientes()%></h3>

              <p>Clientes</p>
            </div>
            <div class="icon">
              <i class="ion ion-person-add"></i>
            </div>
            <a href="#" class="small-box-footer">Mais info <i class="fa fa-arrow-circle-right"></i></a>
          </div>
        </div>
        <!-- ./col -->
        <div class="col-lg-3 col-xs-6">
          <!-- small box -->
          <div class="small-box bg-red">
            <div class="inner">
              <h3><%=GetPagamentosDia()%></h3>

              <p>Pagamentos em <%=DateTime.Now.ToString().Substring(0,10)%></p>
            </div>
            <div class="icon">
              <i class="ion ion-pie-graph"></i>
            </div>
            <a href="#" class="small-box-footer">Mais info <i class="fa fa-arrow-circle-right"></i></a>
          </div>
        </div>
        <!-- ./col -->
      </div>     
    
    </section>


    <div align="center">

        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <!--<img alt="" src="images/logocentral.png" style="border:0"  border="0" align="middle" /> -->
    </div>

</asp:Content>
