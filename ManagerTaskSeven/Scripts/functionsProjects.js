function loadProjects() {
    $.ajax({
        url: "Projects.aspx/GetProjects",
        type: "POST",
        contentType: "application/json",
        success: function (res) {

            var tbody = $("#tblProjects tbody");
            tbody.empty();

            $(res.d).each(function () {
                tbody.append(`
                    <tr>
                        <td>${this.Nombre}</td>
                        <td>${parseDotNetDate(this.FechaInicio)} - ${parseDotNetDate(this.FechaFin)}</td>
                        <td>
                            <button class="btn-edit" type="button" onclick="editProject(${this.Id})">Editar</button>
                            <button class="btn-delete" type="button" onclick="deleteProject(${this.Id})">Eliminar</button>
                        </td>
                    </tr>
                `);
            });
        }
    });
}

function clearFormProjects() {
    $("#projectId").val("");
    $("#txtProjectName").val("");
    $("#txtProjectDesc").val("");
    $("#txtStartDate").val("");
    $("#txtEndDate").val("");
}

function saveProject() {

    $(".error-msg").text("");
    $("input").removeClass("error");

    var isValid = true;

    var nombre = $("#txtProjectName").val().trim();
    var descripcion = $("#txtProjectDesc").val().trim();
    var fechaInicio = $("#txtStartDate").val().trim();
    var fechaFin = $("#txtEndDate").val().trim();


    if (!nombre) {
        $("#errProjectName").text("El nombre del proyecto es obligatorio");
        $("#txtProjectName").addClass("error");
        isValid = false;
    }

    if (!descripcion) {
        $("#errProjectDesc").text("La descripción es obligatoria");
        $("#txtProjectDesc").addClass("error");
        isValid = false;
    }

    if (!fechaInicio) {
        $("#errStartDate").text("La fecha de inicio es obligatoria");
        $("#txtStartDate").addClass("error");
        isValid = false;
    }

    if (!fechaFin) {
        $("#errEndDate").text("La fecha de fin es obligatoria");
        $("#txtEndDate").addClass("error");
        isValid = false;
    }

    if (fechaInicio && fechaFin && fechaInicio > fechaFin) {
        $("#errEndDate").text("La fecha fin no puede ser menor a la fecha inicio");
        $("#txtEndDate").addClass("error");
        isValid = false;
    }

    if (!isValid) return;

    var project = {
        Id: parseInt($("#projectId").val()) || 0,
        Nombre: $("#txtProjectName").val(),
        Descripcion: $("#txtProjectDesc").val(),
        FechaInicio: $("#txtStartDate").val(),
        FechaFin: $("#txtEndDate").val()
    };

    $.ajax({
        url: "Projects.aspx/SaveProject",
        type: "POST",
        data: JSON.stringify({ project: project }),
        contentType: "application/json",
        success: function () {
            alert("Guardado");
            $("#projectModal").fadeOut();
            loadProjects();
        }
    });
}

function parseDotNetDate(dotNetDate) {
    if (!dotNetDate) return "";
    var timestamp = parseInt(dotNetDate.replace(/\/Date\((\d+)\)\//, "$1"));
    var date = new Date(timestamp);
    return date.toISOString().split("T")[0];
}

function editProject(id) {

    $.ajax({
        url: "Projects.aspx/GetProjectById",
        type: "POST",
        data: JSON.stringify({ id: id }),
        contentType: "application/json",
        success: function (data) {

            var u = data.d;

            $("#projectId").val(u.Id);
            $("#txtProjectName").val(u.Nombre);
            $("#txtProjectDesc").val(u.Descripcion);
            $("#txtStartDate").datepicker("setDate", parseDotNetDate(u.FechaInicio));
            $("#txtEndDate").datepicker("setDate", parseDotNetDate(u.FechaFin));

            $("#modalTitleProject").text("Editar Proyecto");

            $("#projectModal").fadeIn(200);

            loadProjects();
        }
    });
}

function deleteProject(id) {

    if (!confirm("¿Seguro que deseas eliminar este Proyecto?")) return;

    $.ajax({
        url: "Projects.aspx/DeleteProjects",
        type: "POST",
        data: JSON.stringify({ id: id }),
        contentType: "application/json",
        success: function () {
            alert("Proyecto eliminado");
            loadProjects();
        }
    });
}