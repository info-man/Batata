<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="mobile.aspx.cs" Inherits="MASTERSEGUROS.WEB.mobile" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Correios de Angola</title>
        <link rel="stylesheet" href="css/normalize.css" />
        <link href='http://fonts.googleapis.com/css?family=Nunito:400,300' rel='stylesheet' type='text/css' />
        <link rel="stylesheet" href="css/main.css" />
       <script  type="text/javascript" src="Scripts/jquery-1.4.2.min.js"></script>

    <script type="text/javascript" src="Scripts/jquery-1.8.2.js"></script>
    <script type="text/javascript" src="Scripts/jquery-ui.js"></script>
    </head>
    <body>

      <form action="mobile.aspx" method="post">
      
        <h1>A Minha Localização</h1>
        
        <fieldset>
          <legend><span class="number"></span>Preencha os seus dados</legend>
          <label for="name">Nome:</label>
          <input type="text" id="name" name="user_name" />
          
          <label for="mail">Email:</label>
          <input type="email" id="mail" name="user_email" />
          
          <label for="tel">Telefone:</label>
          <input type="tel" id="tel" name="user_tel" />
         
          </fieldset>
        <button onclick="javascript:getLocalizacao(); return false;" type="submit">Clique aqui para saber a sua Localização</button>
      </form>
      
    </body>

     <script type="text/javascript">

         function getLocalizacao() {
             navigator.geolocation.getCurrentPosition(function (location) {
                 data = {
                     'key': '5GEZ5L3C',
                     'position': location.coords.latitude + ',' + location.coords.longitude,
                     'lang': 'PT'
                 };
                 //alert(location.coords.latitude);
                 //alert(location.coords.longitude);

                 $.post('http://api.what3words.com/position', data, function (response) {
                     alert('A sua localização é: ' + response.words[0] + '.' + response.words[1] + '.' + response.words[2]);
                     //ctl00_MainContent_FormView1_Palavra1TextBox.value = response.words[0];
                     //ctl00_MainContent_FormView1_Palavra2TextBox.value = response.words[1];
                     //ctl00_MainContent_FormView1_Palavra3TextBox.value = response.words[2];
                 });
             });
         };

         
  </script>

</html>

