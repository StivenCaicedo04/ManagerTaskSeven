<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Projects.aspx.cs" Inherits="ManagerTaskSeven.Web.Projects" %>
<%@ Register Src="~/Header.ascx" TagPrefix="uc" TagName="Header" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Projects</title>
    <link href="../Styles/Projects.css" rel="stylesheet" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css" />
    <script src="../Scripts/functionsProjects.js"></script>
    <script>
        $(document).ready(function () {
            loadProjects();

            $("#btnNewProject").click(function () {
                clearFormProjects();
                $("#modalTitleProject").text("Nuevo Proyecto");
                $("#projectModal").fadeIn(200);
            });

            $("#btnSaveProject").click(function () {
                saveProject();
            });

            $("#btnClose").click(function () {
                $("#projectModal").fadeOut();
                $("#txtStartDate, #txtEndDate").datepicker("hide");
            });

            $(window).click(function (e) {

                if ($(e.target).is("#projectModal")) {
                    $("#txtStartDate, #txtEndDate").datepicker("hide");
                    $("#projectModal").fadeOut();
                }
            });

            $("#btnCalendarStart").click(function () {
                $("#txtStartDate").datepicker("show");
            });

            $("#btnCalendarEnd").click(function () {
                $("#txtEndDate").datepicker("show");
            });

            $("#txtEndDate").datepicker({
                dateFormat: "yy-mm-dd",
                changeMonth: true,
                changeYear: true,
                yearRange: "1900:2026",

                beforeShow: function (input, inst) {
                    setTimeout(function () {
                        inst.dpDiv.css({
                            top: $("#btnCalendarEnd").offset().top + $("#btnCalendarEnd").outerHeight(),
                            left: $("#btnCalendarEnd").offset().left
                        });
                    }, 0);
                }
            });

            $("#txtStartDate").datepicker({
                dateFormat: "yy-mm-dd",
                changeMonth: true,
                changeYear: true,
                yearRange: "1900:2026",

                beforeShow: function (input, inst) {
                    setTimeout(function () {
                        inst.dpDiv.css({
                            top: $("#btnCalendarStart").offset().top + $("#btnCalendarStart").outerHeight(),
                            left: $("#btnCalendarStart").offset().left
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

                <h2>Gestión de Proyectos</h2>
                    <button type="button" id="btnNewProject">+ Nuevo Proyecto</button>

                    <table id="tblProjects" border="1" cellpadding="5">
                        <thead>
                            <tr>
                                <th>Nombre</th>
                                <th>Fechas</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody></tbody>
                    </table>
                    <div id="projectModal" class="modal">
                        <div class="modal-content">

                            <h3 id="modalTitleProject">Nuevo Proyecto</h3>

                            <input type="hidden" id="projectId" />

                            <div class="form-grid">
                                <div class="form-group">
                                    <label>Nombre del proyecto</label>
                                    <input type="text" id="txtProjectName" />
                                    <span class="error-msg" id="errProjectName"></span>
                                </div>

                                <div class="form-group">
                                    <label>Descripción</label>
                                    <input type="text" id="txtProjectDesc" />
                                    <span class="error-msg" id="errProjectDesc"></span>
                                </div>

                                <div class="form-group">
                                    <label>Fecha de inicio</label>
                                    <div class="date-container">
                                        <input type="text" id="txtStartDate" /> 
                                        <span id="btnCalendarStart" class="calendar-icon">📅</span>
                                    </div>
                                    <span class="error-msg" id="errStartDate"></span>
                                </div>

                                <div class="form-group">
                                    <label>Fecha de fin</label>
                                    <div class="date-container">
                                        <input type="text" id="txtEndDate" />
                                        <span id="btnCalendarEnd" class="calendar-icon">📅</span>
                                    </div>
                                    <span class="error-msg" id="errEndDate"></span>
                                </div>
                            </div>
                            <br /><br />

                            <button type="button" id="btnSaveProject">Guardar</button>
                            <button type="button" id="btnClose">Cerrar</button>

                        </div>
                    </div>
            </div>
        </div>
    </form>
</body>
</html>
