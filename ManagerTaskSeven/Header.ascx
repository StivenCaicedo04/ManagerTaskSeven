<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Header.ascx.cs" Inherits="ManagerTaskSeven.Header" %>

<style>
    .header-bar {
        background: #2196F3;
        padding: 14px 24px;
        color: white;
        display: flex;
        justify-content: space-between;
        align-items: center;

        border-radius: 0 0 12px 12px;
        box-shadow: 0 4px 12px rgba(0,0,0,0.12);
    }

    .left-menu a {
        color: white;
        text-decoration: none;
        margin-right: 15px;
        font-weight: 500;
    }

    .left-menu a:hover {
        text-decoration: underline;
    }

    .right-user {
        font-size: 14px;
    }

    .right-user a {
        color: white;
        margin-left: 10px;
        text-decoration: underline;
    }
</style>
<div class="header-bar">

    <div class="left-menu">
        <a href="Dashboard.aspx">🏠 Dashboard</a>
        <a href="Task.aspx">📋 Tareas</a>
        <a href="Projects.aspx">📁 Proyectos</a>
        <a href="Users.aspx">👤 Usuarios</a>
    </div>

    <div class="right-user">
        👤 <asp:Label ID="lblUserName" runat="server" />
        |
        <asp:LinkButton ID="btnLogout" runat="server" OnClick="btnLogout_Click">
            Cerrar sesión
        </asp:LinkButton>
    </div>

</div>