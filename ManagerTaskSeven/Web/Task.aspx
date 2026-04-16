<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Task.aspx.cs" Inherits="ManagerTaskSeven.Web.Task" %>
<%@ Register Src="~/Header.ascx" TagPrefix="uc" TagName="Header" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Tareas</title>
    <link href="../Styles/Task.css" rel="stylesheet" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css" />
    <script src="../Scripts/functionsTask.js"></script>
    <script>
        $(document).ready(function () {
            loadTasks();
            loadSelects();

            $("#txtTaskDate").datepicker({
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

            $("#btnCalendar").click(function () {
                $("#txtTaskDate").datepicker("show");
            });

            $("#btnNewTask").click(function () {
                clearTaskForm();
                $("#modalTitleTask").text("Nueva Tarea");
                $("#taskModal").fadeIn(200);
            });

            $(window).click(function (e) {

                if ($(e.target).is("#taskModal")) {
                    clearTaskForm();
                    $("#txtTaskDate").datepicker("hide");
                    $("#taskModal").fadeOut();
                }
            });

            $("#btnCloseTask").click(function () {
                $("#taskModal").fadeOut();
                $("#txtTaskDate").datepicker("hide");
            });

            $("#btnSaveTask").click(function () {
                saveTask();
            });

            $("#btnAddComment").click(function () {
                addComment();
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

                <h2>Gestión de Tareas</h2>

                <button type="button" id="btnNewTask">+ Nueva Tarea</button>

                <table id="tblTasks" border="1" cellpadding="5">
                    <thead>
                        <tr>
                            <th>Título</th>
                            <th>Descripción</th>
                            <th>Estado</th>
                            <th>Fecha</th>
                            <th>Proyecto</th>
                            <th>Usuario</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody></tbody>
                </table>

                <div id="taskModal" class="modal">

                    <div class="modal-content">

                        <h3 id="modalTitleTask">Nueva Tarea</h3>

                        <input type="hidden" id="taskId" />

                         <div class="form-grid">
                             <div class="form-group">
                                <label>Título</label>
                                <input type="text" id="txtTaskTitle" />
                                <span class="error-msg" id="errTaskTitle"></span>
                            </div>

                             <div class="form-group">
                                <label>Descripción</label>
                                <input type="text" id="txtTaskDesc" />
                                <span class="error-msg" id="errTaskDesc"></span>
                            </div>

                             <div class="form-group">
                                <label>Proyecto</label>
                                <select id="ddlProject"></select>
                                <span class="error-msg" id="errProject"></span>
                            </div>

                             <div class="form-group">
                                <label>Usuario</label>
                                <select id="ddlUser"></select>
                                <span class="error-msg" id="errUser"></span>
                            </div>

                             <div class="form-group">
                                <label>Estado</label>
                                <select id="ddlStatus">
                                    <option value="Pendiente">Pendiente</option>
                                    <option value="En Progreso">En Progreso</option>
                                    <option value="Finalizada">Finalizada</option>
                                </select>
                                <span class="error-msg" id="errStatus"></span>
                            </div>

                             <div class="form-group">
                                <label>Fecha de creación</label>
                                <div class="date-container">
                                    <input type="text" id="txtTaskDate"/>
                                    <span id="btnCalendar" class="calendar-icon">📅</span>
                                </div>
                                <span class="error-msg" id="errTaskDate"></span>
                            </div>
                         </div>      

                        <br />

                        <button type="button" id="btnSaveTask">Guardar</button>
                        <button type="button" id="btnCloseTask">Cerrar</button>

                        <hr />

                        <h4>Comentarios</h4>

                        <div id="commentsSection">
                            <div style="max-height:200px; overflow-y:auto;">
                                <table id="commentsTable">
                                    <thead>
                                        <tr>
                                            <th>Fecha</th>
                                            <th>Usuario</th>
                                            <th>Comentario</th>
                                        </tr>
                                    </thead>
                                    <tbody></tbody>
                                </table>
                            </div>                           

                            <textarea id="txtComment" placeholder="Escribe un comentario..." style="width:100%; margin-top:10px;"></textarea>

                            <button type="button" id="btnAddComment">Agregar Comentario</button>

                        </div>

                    </div>

                </div>
            </div>
        </div>
    </form>
</body>
</html>
