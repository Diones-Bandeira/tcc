<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="newuser.aspx.cs" Inherits="teste.newuser" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Pulling TestCase - New User</title>
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

        //*** Verifica existência do LOGIN via server CALLBACK
        function validate() {

            alert($('.form-signin').isValid());

            /*** Cria objeto e relaciona dados de login ***/
            var logindata = {};
            logindata.username = $.trim($("#txtUsername").val());
            logindata.firstname = $.trim($("#txtFirstname").val());
            logindata.email = $.trim($("#txtEmail").val());
            logindata.password = $.trim($("#txtPassword").val());
            logindata.confirmpassword = $.trim($("#txtConfirmPassword").val());
            logindata.position = $.trim($("#cboPosition").val());
            logindata.experiece = $.trim($("#cboExpirience").val());

            //*** Os valores foram preenchidos?
            if (logindata.username !== "" && logindata.firstname !== "" &&
                logindata.email !== "" && logindata.password !== "" &&
                logindata.confirmpassword !== "" && logindata.position !== "" &&
                logindata.experiece !== "")
            {
                /*** Executa chamada ao webmethod de validação de login ***/
                var result;
                CallServerFunction("newuser.aspx/ValidadeLogin", JSON.stringify(logindata), function (result) 
                { 
                    //*** O usuário já existe?
                    if (result.d !== "Ok")
                    {
                        //*** Notifica operador e encerra processo
                        openModal("Register New User", "User already exists!");
                        return;
                    }
                });

                //*** O usuário informou senha e confirmação corretas?
                if (logindata.password !== logindata.confirmpassword)
                {
                    //*** Notifica operador e encerra processo
                    openModal("Register New User", "Password and confirmation not match!");
                    return;
                }

                //*** Cria novo cadastro de usuário
                CallServerFunction("newuser.aspx/CreateUser", JSON.stringify(logindata), function (result) {

                    //*** O usuário já existe?
                    if (result.d === "Ok") {

                        //*** Notifica operador e redireciona para login
                        openModal("Register New User", "User sucefully created!<br />You will be redirected to Sign In now.");
                        $('#btnAction').html('Sign In');
                        $('#btnAction').attr("onclick", "JavaScript: location.href = 'login.aspx'");
                    }
                    else
                    {
                        //*** Notifica operador e redireciona para login
                        openModal("Register New User", "An error ocurred in user creation!<br />" + result.d);
                    }
                });
            }
        }

        function processLogin(result, username, password) {

            //*** Valida resultado do login e acina POST
            if (result === "Ok") {
                //*** Realiza POST
                var datafields = {};
                datafields[0] = { "key": "username", "value": username };
                datafields[1] = { "key": "password", "value": password };
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
    <form class="form-signin" id="frmRegister">
        <h1 class="h3 mb-3 font-weight-normal">Pulling TestCase</h1>
        <img class="center-block" src="images/bad.gif" alt="" width="72" height="72">
        <p>Always Alert!</p>
        <h1 class="h3 mb-3 font-weight-normal">Please fill the registration form</h1>

        <label for="txtUsername" class="sr-only">Username</label>
        <input type="text" id="txtUsername" class="form-control" maxlength="20" placeholder="Username" required autofocus>

        <label for="txtFirstname" class="sr-only">Firstname</label>
        <input type="text" id="txtFirstname" class="form-control" maxlength="20" placeholder="Firstname" required>

        <label for="txtEmail" class="sr-only">E-mail</label>
        <input type="email" id="txtEmail" class="form-control" maxlength="100" placeholder="E-mail" required>

        <label for="txtPassword" class="sr-only">Password</label>
        <input type="password" id="txtPassword" class="form-control" maxlength="10" placeholder="Password" required>

        <label for="txtConfirmPassword" class="sr-only">Confirm Password</label>
        <input type="password" id="txtConfirmPassword" class="form-control" maxlength="10" placeholder="Confirm Password" required>

        <label for="cboPosition">Position in Company</label>
        <select class="custom-select d-block w-100" id="cboPosition" required>
            <option value="">Choose...</option>
            <option value="Test Analyst">Test Analyst</option>
            <option value="Tecnical Leader">Tecnical Leader</option>
            <option value="Test Analyst">Test Analyst</option>
            <option value="System Analyst">System Analyst</option>
            <option value="Manager TI">Manager TI</option>
        </select>

        <label for="cboExpirience">Time Experience</label>
        <select class="custom-select d-block w-100" id="cboExpirience" required>
            <option value="">Choose...</option>
            <option value="6 months or less">6 months or less</option>
            <option value="At least 1 year">At least 1 year</option>
            <option value="More than 1 year">More than 1 year</option>
        </select>

        <br />

        <button type="submit" class="btn btn-lg btn-primary btn-block" onclick="JavaScript: validate();">Register</button>
        <a href="login.aspx">Sing In</a>&nbsp;|&nbsp;<a href="lostpassword.aspx">Lost Password?</a>
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
