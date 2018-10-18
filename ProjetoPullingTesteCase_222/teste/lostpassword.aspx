<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="lostpassword.aspx.cs" Inherits="teste.lostpassword" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Pulling TestCase - Login</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" />
    <link rel="stylesheet" href="css/signin.css" />
    
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
    <script src="js/root.js"></script>

    <script type="text/javascript">

        //*** Previne ação padrão de POST do formulários
        $(document).ready(function () {
            $("form").on('submit', function (e) { e.preventDefault(); });
        });

        //*** Abre diálogo modal (BOOTSTRAP)
        function openModal(title, message) {
            $('#exampleModalLabel').html(title);
            $('#divPopupMensagem').html(message);
            $('#exampleModal').modal('show');
        }

        //*** Fecha diálogo modal (BOOTSTRAP)
        function closeModal() {
            $('#exampleModal').modal('hide');
        }

        //*** Processa LOGIN via server CALLBACK
        function identify() {

            /*** Cria objeto e relaciona dados de recuperação de login ***/
            var logindata = {};
            logindata.username = $.trim($("#txtUsername").val());
            logindata.email = $.trim($("#txtEmail").val());

            /*** Executa chamada ao webmethod de validação de recuperação de login ***/
            if (logindata.username !== '' && logindata.email !== '') {

                //*** Esconde botão e abre diálogo de processamento
                $("#btnAction").hide();
                openModal("Password Recovery", "Sending message to " + logindata.email + "...");

                var result;
                CallServerFunction("lostpassword.aspx/ValidateUser", JSON.stringify(logindata), function (result) {

                    //*** Valida resultado do login e acina POST
                    if (result.d === "Ok")
                    {
                        //*** Define mensagem
                        message = "Your password has been sucefully sent to " + logindata.email + "<br />";
                        message += "You will be redirected to Sign In";

                        //*** Redefine e exibe botão
                        $('#btnAction').html('Sign In');
                        $('#btnAction').attr("onclick", "JavaScript: location.href = 'login.aspx'");
                        $("#btnAction").show();

                        //*** Exibe diálogo de redirecionamento
                        openModal("Password Recovery", message);
                    }
                    else
                    {
                        //*** Exibe botão e mostra mensagem de erro retornada pelo servidor
                        $("#btnAction").show();
                        openModal("Password Recovery", "Error sending message to " + logindata.email + "<br />" + result.d);
                    }
                });
            }
        }

    </script>
</head>
<body class="text-center">
    <form class="form-signin" id="frmLogin">
      <h1 class="h3 mb-3 font-weight-normal">Pulling TestCase</h1>
      <img class="center-block" src="images/bad.gif" alt="" width="72" height="72">
      <p>Always Alert!</p>
      <h1 class="h3 mb-3 font-weight-normal">Password Recovery</h1>
      <p>Please type your username and password</p>
      <label for="txtUsername" class="sr-only">Username</label>
      <input type="text" id="txtUsername" class="form-control" maxlength="20" placeholder="Username" required autofocus>
      <label for="txtEmail" class="sr-only">Email</label>
      <input type="email" id="txtEmail" class="form-control" maxlength="100" placeholder="Email" required>
      <button type="submit" class="btn btn-lg btn-primary btn-block" onclick="JavaScript: identify();">Send me my password</button>
      <a href="login.aspx">Sign In</a>&nbsp;|&nbsp;<a href="newuser.aspx">New user?</a>
    </form>

    <!-- Modal -->
    <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body" id="divPopupMensagem">
              ...
          </div>
          <div class="modal-footer">
            <button id="btnAction" type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
          </div>
        </div>
      </div>
    </div>
</body>
</html>
