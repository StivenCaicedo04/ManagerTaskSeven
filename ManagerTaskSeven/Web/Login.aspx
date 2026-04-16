<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="ManagerTaskSeven.Web.Login" %>

<!DOCTYPE html>

<html>
<head>
    <title>Login</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="../Scripts/functionsUser.js"></script>
    <link href="../Styles/Login.css" rel="stylesheet" />
    <script>
        $(document).ready(function () {
            $("#btnLogin").click(function (e) {
                e.preventDefault();
                validateLogin();
            });

            $("input").on("input", function () {
                $(this).removeClass("error");
                $(this).nextAll(".error-msg:first").text("");
            });
        });
    </script>
</head>

<body>
    <form id="form1" runat="server">

        <div class="login-container">

            <div class="login-card">

                <h2>Inicio de Sesión</h2>

                <div class="form-group">
                    <label>Usuario</label>
                    <input type="text" id="username" />
                    <span class="error-msg" id="errUsername"></span>
                </div>

                <div class="form-group">
                    <label>Contraseña</label>
                    <input type="password" id="password" />
                    <span class="error-msg" id="errPassword"></span>
                </div>

                <button type="button" id="btnLogin">Ingresar</button>

                <p id="message"></p>

            </div>

        </div>

    </form>
</body>
