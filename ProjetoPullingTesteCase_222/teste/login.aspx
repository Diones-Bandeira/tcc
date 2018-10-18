<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="teste.login" %>

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
            user = $("#<%=this.txtUser.ClientID%>").val();
            pass = $("#<%=this.txtPass.ClientID%>").val();
            if (user !== '' && pass !== '')
                processLogin('Ok', user, pass, 'false');
        });

        //*** Abre diálogo modal (BOOTSTRAP)
        function openModal(title, message) {
            $('#exampleModalLabel').html(title);
            $('#divPopupMensagem').html(message);
            $('#exampleModal').modal('show');
        }

        //*** Processa LOGIN via server CALLBACK
        function login() {

            /*** Cria objeto e relaciona dados de login ***/
            var logindata = {};
            logindata.username = $.trim($("#txtUsername").val());
            logindata.password = $.trim($("#txtPassword").val());
            logindata.remember = $.trim($('#chkRemember').is(":checked"));

            /*** Executa chamada ao webmethod de validação de login ***/
            if (logindata.username !== '' && logindata.password !== '') {
                var result;
                CallServerFunction("login.aspx/ValidateLogin", JSON.stringify(logindata), function (result) { processLogin(result.d, logindata.username, logindata.password, logindata.remember); });
            }
        }

        function processLogin(result, username, password, remember) {

            //*** Valida resultado do login e acina POST
            if (result === "Ok") {
                //*** Realiza POST
                var datafields = {};
                datafields[0] = { "key": "username", "value": username };
                datafields[1] = { "key": "password", "value": password };
                datafields[2] = { "key": "remember", "value": remember };
                DoPost('access.aspx', datafields);
            }
            else {
                //*** Notifica exibindo mensagem obtida do Server Callback
                openModal("Sign In", result);
            }
        }

    </script>
</head>
<body class="text-center">
    <form class="form-signin" id="frmLogin" runat="server">
        <input type="hidden" id="txtUser" runat="server" />
        <input type="hidden" id="txtPass" runat="server" />
        <h1 class="h3 mb-3 font-weight-normal">Pulling TestCase</h1>
        <img class="center-block" src="images/bad.gif" alt="" width="72" height="72">
        <p>Always Alert!</p>
        <h1 class="h3 mb-3 font-weight-normal">Please sign in</h1>
        <label for="txtUsername" class="sr-only">Username</label>
        <input type="text" id="txtUsername" class="form-control" maxlength="20" placeholder="Username" required autofocus>
        <label for="txtPassword" class="sr-only">Password</label>
        <input type="password" id="txtPassword" class="form-control" maxlength="10" placeholder="Password" required>
        <div class="checkbox mb-3">
            <label>
                <input id="chkRemember" type="checkbox" value="remember-me">
                Remember my login
            </label>
        </div>
        <button type="submit" class="btn btn-lg btn-primary btn-block" onclick="JavaScript: login();">Sign in</button>
        <a href="newuser.aspx">New user?</a>&nbsp;|&nbsp;<a href="lostpassword.aspx">Lost Password?</a>
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
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
