function loadTasks() {

    $.ajax({
        url: "Task.aspx/GetTasks",
        type: "POST",
        contentType: "application/json",
        success: function (res) {

            var tbody = $("#tblTasks tbody");
            tbody.empty();

            $(res.d).each(function () {

                tbody.append(`
                    <tr>
                        <td>${this.Titulo}</td>
                        <td>${this.Descripcion}</td>
                        <td>
                            <span class="${getStatusClass(this.Estado)}">
                                ${this.Estado}
                            </span>
                        </td>
                        <td>${parseDotNetDate(this.FechaCreacion)}</td>
                        <td>${this.Nombre + " " + this.Apellido}</td>
                        <td>${this.TituloProyecto}</td>
                        <td>
                            <button class="btn-edit" type="button" onclick="editTask(${this.Id})">Editar</button>
                            <button class="btn-delete" type="button" onclick="deleteTask(${this.Id})">Eliminar</button>
                        </td>
                    </tr>
                `);
            });
        }
    });
}

function getStatusClass(status) {
    if (status === "Pendiente") return "status pendiente";
    if (status === "En Progreso") return "status progreso";
    if (status === "Finalizada") return "status finalizado";
}

function parseDotNetDate(dotNetDate) {
    if (!dotNetDate) return "";
    var timestamp = parseInt(dotNetDate.replace(/\/Date\((\d+)\)\//, "$1"));
    var date = new Date(timestamp);
    return date.toISOString().split("T")[0];
}

function clearTaskForm() {
    $("#taskId").val("");
    $("#txtTaskTitle").val("");
    $("#txtTaskDesc").val("");
    $("#txtTaskDate").val("");
    $("#commentsList").empty();
}

function saveTask() {

    $(".error-msg").text("");
    $("input").removeClass("error");

    var isValid = true;

    var title = $("#txtTaskTitle").val().trim();
    var desc = $("#txtTaskDesc").val().trim();
    var project = $("#ddlProject").val().trim();
    var user = $("#ddlUser").val().trim();
    var status = $("#ddlStatus").val().trim();
    var date = $("#txtTaskDate").val().trim();

    if (!title) {
        $("#errTaskTitle").text("El título es obligatorio");
        $("#txtTaskTitle").addClass("error");
        isValid = false;
    }

    if (!desc) {
        $("#errTaskDesc").text("La descripción es obligatoria");
        $("#txtTaskDesc").addClass("error");
        isValid = false;
    }

    if (!project) {
        $("#errProject").text("El proyecto es obligatorio");
        $("#ddlProject").addClass("error");
        isValid = false;
    }

    if (!user) {
        $("#errUser").text("El usuario es obligatorio");
        $("#ddlUser").addClass("error");
        isValid = false;
    }

    if (!status) {
        $("#errStatus").text("El estado es obligatorio");
        $("#ddlStatus").addClass("error");
        isValid = false;
    }

    if (!date) {
        $("#errTaskDate").text("La fecha de creación es obligatoria");
        $("#txtTaskDate").addClass("error");
        isValid = false;
    }

    if (!isValid) return;

    var task = {
        Id: parseInt($("#taskId").val()) || 0,
        Titulo: $("#txtTaskTitle").val(),
        Descripcion: $("#txtTaskDesc").val(),
        ProyectoId: $("#ddlProject").val(),
        UsuarioId: $("#ddlUser").val(),
        Estado: $("#ddlStatus").val(),
        FechaCreacion: $("#txtTaskDate").val()
    };

    $.ajax({
        url: "Task.aspx/SaveTask",
        type: "POST",
        data: JSON.stringify({ task: task }),
        contentType: "application/json",
        success: function () {

            alert("Tarea guardada");

            $("#taskModal").fadeOut();
            loadTasks();
        }
    });
}

function loadSelects() {
    $.ajax({
        type: "POST",
        url: "Task.aspx/GetLookups",
        data: "{}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (response) {
            var data = response.d;

            $.each(data.Users, function (i, user) {
                $("#ddlUser").append($("<option>", { value: user.Id, text: user.Name }));
            });

            $.each(data.projects, function (i, project) {
                $("#ddlProject").append($("<option>", { value: project.Id, text: project.Name }));
            });
        }
    });
}

function editTask(id) {
    loadComments(id);
    $.ajax({
        url: "Task.aspx/GetTaskById",
        type: "POST",
        data: JSON.stringify({ id: id }),
        contentType: "application/json",
        success: function (res) {

            var t = res.d;

            $("#taskId").val(t.Id);
            $("#txtTaskTitle").val(t.Titulo);
            $("#txtTaskDesc").val(t.Descripcion);
            $("#ddlProject").val(t.ProyectoId);
            $("#ddlUser").val(t.UsuarioId);
            $("#ddlStatus").val(t.Estado);

            $("#txtTaskDate").datepicker("setDate", parseDotNetDate(t.FechaCreacion));

            $("#modalTitleTask").text("Editar Tarea");

            $("#taskModal").fadeIn(200);

            loadTasks();
        }
    });
}

function deleteTask(id) {

    if (!confirm("¿Seguro que deseas eliminar esta tarea?")) return;

    $.ajax({
        url: "Task.aspx/DeleteTask",
        type: "POST",
        data: JSON.stringify({ id: id }),
        contentType: "application/json",
        success: function () {
            alert("tarea eliminada");
            loadTasks();
        }
    });
}

function loadComments(taskId) {

    $.ajax({
        url: "Task.aspx/GetCommentsByTask",
        type: "POST",
        data: JSON.stringify({ taskId: taskId }),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (res) {

            var tbody = $("#commentsTable tbody");
            tbody.empty();

            if (res.d.length === 0) {
                tbody.append(`
                    <tr>
                        <td colspan="3" style="text-align:center; color:#999;">
                            No hay comentarios aún
                        </td>
                    </tr>
                `);
                return;
            }

            $(res.d).each(function () {

                tbody.append(`
                    <tr>
                        <td class="comment-date">
                            ${parseDotNetDate(this.Fecha)}
                        </td>
                        <td class="comment-user">
                            ${this.UsuarioNombre}
                        </td>
                        <td class="comment-text">
                            ${this.Comentario}
                        </td>
                    </tr>
                `);
            });
        }
    });
}

function addComment() {
    if (!$("#taskId").val()) {
        alert("Guarda la tarea primero");
        return;
    }

    var comment = {
        TaskId: $("#taskId").val(),
        Comentario: $("#txtComment").val()
    };

    $.ajax({
        url: "Task.aspx/AddComment",
        type: "POST",
        data: JSON.stringify({ comment: comment }),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function () {

            $("#txtComment").val("");
            loadComments(comment.TaskId);
        }
    });
}