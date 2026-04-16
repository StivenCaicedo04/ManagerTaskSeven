function validateLogin() {
    var username = $("#username").val();
    var password = $("#password").val();

    $(".error-msg").text("");
    $("input").removeClass("error");

    var user = $("#username").val().trim();
    var pass = $("#password").val().trim();

    var isValid = true;

    if (!user) {
        $("#errUsername").text("El usuario es obligatorio");
        $("#username").addClass("error");
        isValid = false;
    }

    if (!pass) {
        $("#errPassword").text("La contraseña es obligatoria");
        $("#password").addClass("error");
        isValid = false;
    }

    if (!isValid) return;

    $.ajax({
        type: "POST",
        url: "Login.aspx/LoginUser",
        data: JSON.stringify({
            username: username,
            password: password
        }),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (response) {

            var result = response.d;

            if (result.success) {
                window.location.href = "Dashboard.aspx";
            } else {
                $("#message").text("Credenciales incorrectas");
            }
        },
        error: function (xhr) {
            console.log("Error:", xhr.responseText);
        }
    });
}

function loadDashboard() {
    $.ajax({
        url: "Dashboard.aspx/GetDashboardData",
        type: "POST",
        contentType: "application/json",
        success: function (data) {

            var d = data.d;

            $("#totalUsers").text(d.TotalUsers);
            $("#totalProjects").text(d.TotalProjects);
            $("#pendingTasks").text(d.PendingTasks);
            $("#inProgressTasks").text(d.InProgressTasks);
            $("#finishTasks").text(d.FinishTasks);
        }
    });
}

function loadUsers(filter = "") {

    $.ajax({
        url: "Users.aspx/GetUsers",
        type: "POST",
        data: JSON.stringify({ filter: filter }),
        contentType: "application/json",
        success: function (data) {

            var tbody = $("#tblUsers tbody");
            tbody.empty();

            $(data.d).each(function () {

                tbody.append(`
                    <tr>
                        <td>${this.Nombre}</td>
                        <td>${this.Apellido}</td>
                        <td>${this.Cedula}</td>
                        <td>${this.RolNombre}</td>
                        <td>
                            <button class="btn-edit" type="button" onclick="editUser(${this.Id})">Editar</button>
                            <button class="btn-delete" type="button" onclick="deleteUser(${this.Id})">Eliminar</button>
                        </td>
                    </tr>
                `);
            });
        }
    });
}

function deleteUser(id) {

    if (!confirm("¿Seguro que deseas eliminar este usuario?")) return;

    $.ajax({
        url: "Users.aspx/DeleteUser",
        type: "POST",
        data: JSON.stringify({ id: id }),
        contentType: "application/json",
        success: function () {
            alert("Usuario eliminado");
            loadUsers();
        }
    });
}

function editUser(id) {

    $.ajax({
        url: "Users.aspx/GetUserById",
        type: "POST",
        data: JSON.stringify({ id: id }),
        contentType: "application/json",
        success: function (data) {

            var u = data.d;

            $("#userId").val(u.Id);
            $("#txtName").val(u.Nombre);
            $("#txtLastName").val(u.Apellido);
            $("#txtCedula").val(u.Cedula);

            $("#ddlRole").val(u.RolId);
            $("#ddlGender").val(u.GeneroId);
            $("#ddlCivilStatus").val(u.EstadoCivilId);

            $("#txtBirthDate").datepicker("setDate", parseDotNetDate(u.FechaNacimiento));

            $("#txtUsername").hide();
            $("#lblUsername").hide();
            $("#txtPassword").hide();
            $("#lblPassword").hide();

            $("#modalTitle").text("Editar Usuario");

            $("#userModal").fadeIn(200);

            loadUsers();
        }
    });
}

function clearFormUser() {
    $("#userId").val("");
    $("#txtName").val("");
    $("#txtLastName").val("");
    $("#txtCedula").val("");
    $("#txtBirthDate").val("");
    $("#txtUsername").val("");
    $("#txtPassword").val("");
}

function loadSelects() {
    $.ajax({
        type: "POST",
        url: "Users.aspx/GetLookups",
        data: "{}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (response) {
            var data = response.d;

            $.each(data.Roles, function (i, role) {
                $("#ddlRole").append($("<option>", { value: role.Id, text: role.Name }));
            });

            $.each(data.Genders, function (i, gender) {
                $("#ddlGender").append($("<option>", { value: gender.Id, text: gender.Name }));
            });

            $.each(data.CivilStatus, function (i, status) {
                $("#ddlCivilStatus").append($("<option>", { value: status.Id, text: status.Name }));
            });
        }
    });
}

function parseDotNetDate(dotNetDate) {
    if (!dotNetDate) return "";
    var timestamp = parseInt(dotNetDate.replace(/\/Date\((\d+)\)\//, "$1"));
    var date = new Date(timestamp);
    return date.toISOString().split("T")[0];
}

function saveUser() {

    $(".error-msg").text("");
    $("input").removeClass("error");

    var isValid = true;

    var name = $("#txtName").val().trim();
    var lastName = $("#txtLastName").val().trim();
    var cedula = $("#txtCedula").val().trim();
    var role = $("#ddlRole").val().trim();
    var gender = $("#ddlGender").val().trim();
    var civilStatus = $("#ddlCivilStatus").val().trim();
    var date = $("#txtBirthDate").val().trim();
    var username = $("#txtUsername").val().trim();
    var password = $("#txtPassword").val().trim();

    if (!name) {
        $("#errName").text("El nombre es obligatorio");
        $("#txtName").addClass("error");
        isValid = false;
    }

    if (!lastName) {
        $("#errLastName").text("El apellido es obligatorio");
        $("#txtLastName").addClass("error");
        isValid = false;
    }

    if (!cedula) {
        $("#errCedula").text("La cédula es obligatoria");
        $("#txtCedula").addClass("error");
        isValid = false;
    }

    if (!username) {
        $("#errUsername").text("El username es obligatorio");
        $("#txtUsername").addClass("error");
        isValid = false;
    }

    if (!password) {
        $("#errPassword").text("El password es obligatorio");
        $("#txtPassword").addClass("error");
        isValid = false;
    }

    if (!date) {
        $("#errBirthDate").text("La fecha de nacimiento es obligatoria");
        $("#txtBirthDate").addClass("error");
        isValid = false;
    }

    if (!isValid) return;

    var user = {
        Id: parseInt($("#userId").val()) || 0,
        Nombre: $("#txtName").val(),
        Apellido: $("#txtLastName").val(),
        Cedula: $("#txtCedula").val(),
        RolId: $("#ddlRole").val(),
        GeneroId: $("#ddlGender").val(),
        EstadoCivilId: $("#ddlCivilStatus").val(),
        FechaNacimiento: $("#txtBirthDate").val(),
        Username: $("#txtUsername").val(),
        Password: $("#txtPassword").val()
    };

    $.ajax({
        url: "Users.aspx/SaveUser",
        type: "POST",
        data: JSON.stringify({ user: user }),
        contentType: "application/json",
        success: function () {
            alert("Guardado correctamente");
            $("#userModal").fadeOut();
            loadUsers();
        }
    });
}