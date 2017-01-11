<%@ Page Title="Log In" Language="C#"  AutoEventWireup="true"
    CodeBehind="LoginExt.aspx.cs" Inherits="MASTERSEGUROS.WEB.Account.LoginExt" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>


	<!-- General meta information -->
	<title>Acesso</title>
	<meta name="keywords" content="" />
	<meta name="description" content="" />
	<meta name="robots" content="index, follow" />
	<meta charset="utf-8" />
	<!-- // General meta information -->
	
	
	<!-- Load Javascript -->
	<script type="text/javascript" src="../scripts/jquery.js"></script>
	<script type="text/javascript" src="../scripts/jquery.query-2.1.7.js"></script>
	<script type="text/javascript" src="../scripts/rainbows.js"></script>
	<!-- // Load Javascipt -->

	<!-- Load stylesheets -->
	<link type="text/css" rel="stylesheet" href="../Styles/style.css" media="screen" />
	<!-- // Load stylesheets -->
	
<script>


    $(document).ready(function () {

        $("#submit1").hover(
        function () {
            $(this).animate({ "opacity": "0" }, "slow");
        },
        function () {
            $(this).animate({ "opacity": "1" }, "slow");
        });
    });


</script>
	
</head>
<body>
<form runat="server" method="post" id="FormUser">
 
	<div id="wrapper">
		<div id="wrappertop"></div>

		<div id="wrappermiddle">

			<h2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;CLIENTES EXTERNOS - LOGIN</h2>
			<div id="username_input">

				<div id="username_inputleft"></div>

				<div id="username_inputmiddle">
				
					<input type="text" runat="server"  name="link" id="url" value="Nome do Utilizador" onfocus="document.all['url_user'].src='../images/usericon.png'" onclick="this.value = ''">
					<img runat="server" id="url_user" src="../images/usericon.png" alt="">
				
				</div>

				<div id="username_inputright"></div>

			</div>

			<div id="password_input">

				<div id="password_inputleft"></div>

				<div id="password_inputmiddle">
				
					<input runat="server" type="password" name="link" id="pwd" value="Password" onfocus="document.all['url_password'].src='../images/passicon.png'" onclick="this.value = ''">
					<img runat="server" id="url_password" src="../images/passicon.png" alt="">
				
				</div>

				<div id="password_inputright"></div>

			</div>

			<div id="submit">
				
				<input type="image" src="../images/submit_hover.png" id="submit1" value="Entrar">
				<input type="image" src="../images/submit.png" id="submit2" value="Entrar">
				
			</div>


			<div id="links_left">

			<a href="#">Esqueci-me da palavra-passe.</a> <br />
            <a href="#">Se não tem um registo clique aqui</a>

			</div><br />
 			<!--<div id="links_right"><a href="#">Not a Member Yet?</a></div>-->

		</div>

		<div id="wrapperbottom"></div>
		
		<div id="powered">
		
		</div>
	</div>
</form>
</body>
</html>