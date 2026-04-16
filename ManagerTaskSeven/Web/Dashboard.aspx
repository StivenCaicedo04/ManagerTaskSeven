<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="ManagerTaskSeven.Web.Dashboard" %>
<%@ Register Src="~/Header.ascx" TagPrefix="uc" TagName="Header" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Dashboard</title>
    <link href="../Styles/Dashboard.css" rel="stylesheet" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="../Scripts/functionsUser.js"></script>
    <script>
        $(document).ready(function () {
            loadDashboard();
        });        
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <uc:Header runat="server" ID="Header" />
        <div>
            <div class="dashboard-container">

                <div class="cards">

                    <div class="card users">
                        <div class="card-icon">👤</div>
                        <div>
                            <h3 id="totalUsers">0</h3>
                            <p>Usuarios</p>
                        </div>
                    </div>

                    <div class="card projects">
                        <div class="card-icon">📁</div>
                        <div>
                            <h3 id="totalProjects">0</h3>
                            <p>Proyectos</p>
                        </div>
                    </div>

                    <div class="card warning">
                        <div class="card-icon">⏳</div>
                        <div>
                            <h3 id="pendingTasks">0</h3>
                            <p>Tareas Pendientes</p>
                        </div>
                    </div>

                    <div class="card progress">
                        <div class="card-icon">🚧</div>
                        <div>
                            <h3 id="inProgressTasks">0</h3>
                            <p>Tareas En Progreso</p>
                        </div>
                    </div>

                    <div class="card success">
                        <div class="card-icon">✅</div>
                        <div>
                            <h3 id="finishTasks">0</h3>
                            <p>Tareas Finalizadas</p>
                        </div>
                    </div>

                </div>

            </div>

        </div>
    </form>
</body>
</html>
