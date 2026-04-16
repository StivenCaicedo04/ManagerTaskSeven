<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Users.aspx.cs" Inherits="ManagerTaskSeven.Web.Users" %>
<%@ Register Src="~/Header.ascx" TagPrefix="uc" TagName="Header" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Users</title>
    <link href="../Styles/Users.css" rel="stylesheet" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css" />
    <script src="../Scripts/functionsUser.js"></script>
    <script>
        $(document).ready(function () {
            loadUsers();
            loadSelects();

            $("#txtSearch").keyup(function () {
                loadUsers($(this).val());
            });

            $("#btnNew").click(function () {
                clearFormUser();
                $("#modalTitle").text("Nuevo Usuario");
                $("#userModal").fadeIn(200);
            });

            $("#btnSave").click(function () {
                saveUser();
            });

            $("#btnClose").click(function () {
                $("#userModal").fadeOut();
                $("#txtBirthDate").datepicker("hide");
            });

            $(window).click(function (e) {

                if ($(e.target).is("#userModal")) {
                    $("#txtBirthDate").datepicker("hide");
                    $("#userModal").fadeOut();                    
                }
            });

            $("#btnCalendar").click(function () {
                $("#txtBirthDate").datepicker("show");
            });

            $("#txtBirthDate").datepicker({
                dateFormat: "yy-mm-dd", 
                changeMonth: true,
                changeYear: true,
                yearRange: "1900:2026",
                beforeShow: function (input, inst) {
                    setTimeout(function () {
                        inst.dpDiv.css({
                            top: $("#btnCalendar").offset().top + $("#btnCalendar").outerHeight(),
                            left: $("#btnCalendar").offset().left
                        });
                    }, 0);
                }
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
        <uc:Header runat="server" ID="Header" />
        <div>
            <div class="container">

                <h2>Gestión de Usuarios</h2>

                <button type="button" id="btnNew">+ Nuevo Usuario</button>

                <input type="text" id="txtSearch" placeholder="Buscar por nombre o cédula..." />

                <table id="tblUsers" border="1" cellpadding="5">
                    <thead>
                        <tr>
                            <th>Nombre</th>
                            <th>Apellido</th>
                            <th>Cédula</th>
                            <th>Rol</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody></tbody>
                </table>
                <div id="userModal" class="modal">

                    <div class="modal-content">

                        <h3 id="modalTitle">Nuevo Usuario</h3>

                        <input type="hidden" id="userId" />

                        <div class="form-grid">
                            <div class="form-group">
                                <label>Nombres</label>
                                <input type="text" id="txtName" />
                                <span class="error-msg" id="errName"></span>
                            </div>
                            
                            <div class="form-group">
                                <label>Apellidos</label>
                                <input type="text" id="txtLastName" />
                                <span class="error-msg" id="errLastName"></span>
                            </div>

                            <div class="form-group">
                                <label>Cédula</label>
                                <input type="text" id="txtCedula" />
                                <span class="error-msg" id="errCedula"></span>
                            </div>

                            <div class="form-group">
                                <label>Rol</label>
                                <select id="ddlRole"></select>
                                <span class="error-msg" id="errRole"></span>
                            </div>

                            <div class="form-group">
                                <label>Género</label>
                                <select id="ddlGender"></select>
                                <span class="error-msg" id="errGender"></span>
                            </div>

                            <div class="form-group">
                                <label>Estado civil</label>
                                <select id="ddlCivilStatus"></select>
                                <span class="error-msg" id="errCivilStatus"></span>
                            </div>

                            <div class="form-group">
                                <label>Fecha de nacimiento</label>
                                <div class="date-container">
                                    <input type="text" id="txtBirthDate" />
                                    <span id="btnCalendar" class="calendar-icon">📅</span>
                                </div>
                                <span class="error-msg" id="errBirthDate"></span>
                            </div>

                            <div class="form-group">
                                <label id="lblUsername">Username</label>
                                <input type="text" id="txtUsername" />
                                <span class="error-msg" id="errUsername"></span>
                            </div>

                            <div class="form-group">
                                <label id="lblPassword">Password</label>
                                <input type="text" id="txtPassword" />
                                <span class="error-msg" id="errPassword"></span>
                            </div>

                        </div>

                        <br /><br />

                        <button type="button" id="btnSave">Guardar</button>
                        <button type="button" id="btnClose">Cerrar</button>

                    </div>

                </div>
            </div>
        </div>
    </form>
</body>
</html>
