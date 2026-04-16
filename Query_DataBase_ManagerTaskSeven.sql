USE [ManagerTaskSeven]
GO
/****** Object:  Table [dbo].[EstadoCivil]    Script Date: 15/04/2026 8:07:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EstadoCivil](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Generos]    Script Date: 15/04/2026 8:07:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Generos](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Projects]    Script Date: 15/04/2026 8:07:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Projects](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](100) NOT NULL,
	[Descripcion] [nvarchar](255) NULL,
	[FechaInicio] [date] NOT NULL,
	[FechaFin] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 15/04/2026 8:07:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TaskComments]    Script Date: 15/04/2026 8:07:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TaskComments](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TaskId] [int] NOT NULL,
	[UserId] [int] NOT NULL,
	[Comment] [nvarchar](500) NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tasks]    Script Date: 15/04/2026 8:07:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tasks](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProjectId] [int] NOT NULL,
	[AssignedUserId] [int] NOT NULL,
	[Title] [nvarchar](150) NOT NULL,
	[Description] [nvarchar](255) NULL,
	[Status] [nvarchar](50) NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 15/04/2026 8:07:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](100) NOT NULL,
	[Apellido] [nvarchar](100) NOT NULL,
	[Cedula] [nvarchar](50) NOT NULL,
	[GeneroId] [int] NOT NULL,
	[FechaNacimiento] [date] NOT NULL,
	[EstadoCivilId] [int] NOT NULL,
	[RolId] [int] NOT NULL,
	[Username] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[EstadoCivil] ON 
GO
INSERT [dbo].[EstadoCivil] ([Id], [Nombre]) VALUES (1, N'Soltero')
GO
INSERT [dbo].[EstadoCivil] ([Id], [Nombre]) VALUES (2, N'Casado')
GO
INSERT [dbo].[EstadoCivil] ([Id], [Nombre]) VALUES (3, N'Divorciado')
GO
SET IDENTITY_INSERT [dbo].[EstadoCivil] OFF
GO
SET IDENTITY_INSERT [dbo].[Generos] ON 
GO
INSERT [dbo].[Generos] ([Id], [Nombre]) VALUES (1, N'Masculino')
GO
INSERT [dbo].[Generos] ([Id], [Nombre]) VALUES (2, N'Femenino')
GO
INSERT [dbo].[Generos] ([Id], [Nombre]) VALUES (3, N'Otro')
GO
SET IDENTITY_INSERT [dbo].[Generos] OFF
GO
SET IDENTITY_INSERT [dbo].[Projects] ON 
GO
INSERT [dbo].[Projects] ([Id], [Nombre], [Descripcion], [FechaInicio], [FechaFin]) VALUES (1006, N'Sistema de Gestión de Tareas', N'Aplicación web para administración de tareas internas', CAST(N'2026-01-10' AS Date), CAST(N'2026-06-30' AS Date))
GO
INSERT [dbo].[Projects] ([Id], [Nombre], [Descripcion], [FechaInicio], [FechaFin]) VALUES (1007, N'Portal de Clientes', N'Sistema para gestión de clientes y soporte', CAST(N'2026-02-01' AS Date), CAST(N'2026-07-15' AS Date))
GO
INSERT [dbo].[Projects] ([Id], [Nombre], [Descripcion], [FechaInicio], [FechaFin]) VALUES (1008, N'App de Inventario', N'Control de inventario para bodega principal', CAST(N'2026-03-05' AS Date), CAST(N'2026-03-25' AS Date))
GO
SET IDENTITY_INSERT [dbo].[Projects] OFF
GO
SET IDENTITY_INSERT [dbo].[Roles] ON 
GO
INSERT [dbo].[Roles] ([Id], [Nombre]) VALUES (1, N'Administrador')
GO
INSERT [dbo].[Roles] ([Id], [Nombre]) VALUES (2, N'Usuario')
GO
SET IDENTITY_INSERT [dbo].[Roles] OFF
GO
SET IDENTITY_INSERT [dbo].[TaskComments] ON 
GO
INSERT [dbo].[TaskComments] ([Id], [TaskId], [UserId], [Comment], [CreatedAt]) VALUES (5, 1004, 10, N'Ya inicié el diseño del login en Figma', CAST(N'2026-04-15T19:29:28.817' AS DateTime))
GO
INSERT [dbo].[TaskComments] ([Id], [TaskId], [UserId], [Comment], [CreatedAt]) VALUES (6, 1005, 11, N'Revisar lineamientos de UI antes de continuar', CAST(N'2026-04-15T19:29:28.817' AS DateTime))
GO
INSERT [dbo].[TaskComments] ([Id], [TaskId], [UserId], [Comment], [CreatedAt]) VALUES (7, 1006, 12, N'Base de datos lista y normalizada', CAST(N'2026-04-15T19:29:28.817' AS DateTime))
GO
INSERT [dbo].[TaskComments] ([Id], [TaskId], [UserId], [Comment], [CreatedAt]) VALUES (8, 1007, 13, N'Empecé el CRUD de clientes con formularios ASPX', CAST(N'2026-04-15T19:29:28.817' AS DateTime))
GO
INSERT [dbo].[TaskComments] ([Id], [TaskId], [UserId], [Comment], [CreatedAt]) VALUES (9, 1008, 13, N'Estoy trabajando en la exportación a PDF', CAST(N'2026-04-15T19:29:28.817' AS DateTime))
GO
INSERT [dbo].[TaskComments] ([Id], [TaskId], [UserId], [Comment], [CreatedAt]) VALUES (10, 1004, 10, N'Validaciones de stock casi listas', CAST(N'2026-04-15T19:29:28.817' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[TaskComments] OFF
GO
SET IDENTITY_INSERT [dbo].[Tasks] ON 
GO
INSERT [dbo].[Tasks] ([Id], [ProjectId], [AssignedUserId], [Title], [Description], [Status], [CreatedAt]) VALUES (1004, 1007, 10, N'Diseñar interfaz login', N'Crear UI de acceso al sistema', N'En Progreso', CAST(N'2026-04-15T19:28:11.717' AS DateTime))
GO
INSERT [dbo].[Tasks] ([Id], [ProjectId], [AssignedUserId], [Title], [Description], [Status], [CreatedAt]) VALUES (1005, 1007, 11, N'Crear base de datos', N'Modelado inicial de tablas', N'Finalizada', CAST(N'2026-04-15T19:28:11.717' AS DateTime))
GO
INSERT [dbo].[Tasks] ([Id], [ProjectId], [AssignedUserId], [Title], [Description], [Status], [CreatedAt]) VALUES (1006, 1006, 12, N'Módulo de clientes', N'CRUD de clientes', N'Pendiente', CAST(N'2026-04-15T19:28:11.717' AS DateTime))
GO
INSERT [dbo].[Tasks] ([Id], [ProjectId], [AssignedUserId], [Title], [Description], [Status], [CreatedAt]) VALUES (1007, 1008, 10, N'Reporte de inventario', N'Generar reportes en PDF', N'En Progreso', CAST(N'2026-04-15T19:28:11.717' AS DateTime))
GO
INSERT [dbo].[Tasks] ([Id], [ProjectId], [AssignedUserId], [Title], [Description], [Status], [CreatedAt]) VALUES (1008, 1008, 13, N'Ajustes de stock', N'Validación de entradas y salidas', N'Pendiente', CAST(N'2026-04-15T19:28:11.717' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[Tasks] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 
GO
INSERT [dbo].[Users] ([Id], [Nombre], [Apellido], [Cedula], [GeneroId], [FechaNacimiento], [EstadoCivilId], [RolId], [Username], [Password]) VALUES (1, N'Admin', N'Principal', N'123456', 1, CAST(N'2012-05-17' AS Date), 1, 1, N'admin', N'123456')
GO
INSERT [dbo].[Users] ([Id], [Nombre], [Apellido], [Cedula], [GeneroId], [FechaNacimiento], [EstadoCivilId], [RolId], [Username], [Password]) VALUES (10, N'Carlos', N'Ramírez', N'1002456789', 1, CAST(N'1992-05-14' AS Date), 1, 1, N'cramirez', N'12345')
GO
INSERT [dbo].[Users] ([Id], [Nombre], [Apellido], [Cedula], [GeneroId], [FechaNacimiento], [EstadoCivilId], [RolId], [Username], [Password]) VALUES (11, N'Laura', N'Gómez', N'1002987456', 2, CAST(N'1995-09-22' AS Date), 2, 2, N'lgomez', N'12345')
GO
INSERT [dbo].[Users] ([Id], [Nombre], [Apellido], [Cedula], [GeneroId], [FechaNacimiento], [EstadoCivilId], [RolId], [Username], [Password]) VALUES (12, N'Andrés', N'Martínez', N'1003765432', 1, CAST(N'1990-01-10' AS Date), 1, 2, N'amartinez', N'12345')
GO
INSERT [dbo].[Users] ([Id], [Nombre], [Apellido], [Cedula], [GeneroId], [FechaNacimiento], [EstadoCivilId], [RolId], [Username], [Password]) VALUES (13, N'Sofía', N'Hernández', N'1004123987', 2, CAST(N'1998-07-30' AS Date), 1, 2, N'shernandez', N'12345')
GO
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
ALTER TABLE [dbo].[TaskComments] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Tasks] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[TaskComments]  WITH CHECK ADD  CONSTRAINT [FK_Comments_Task] FOREIGN KEY([TaskId])
REFERENCES [dbo].[Tasks] ([Id])
GO
ALTER TABLE [dbo].[TaskComments] CHECK CONSTRAINT [FK_Comments_Task]
GO
ALTER TABLE [dbo].[TaskComments]  WITH CHECK ADD  CONSTRAINT [FK_Comments_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[TaskComments] CHECK CONSTRAINT [FK_Comments_User]
GO
ALTER TABLE [dbo].[Tasks]  WITH CHECK ADD  CONSTRAINT [FK_Tasks_Project] FOREIGN KEY([ProjectId])
REFERENCES [dbo].[Projects] ([Id])
GO
ALTER TABLE [dbo].[Tasks] CHECK CONSTRAINT [FK_Tasks_Project]
GO
ALTER TABLE [dbo].[Tasks]  WITH CHECK ADD  CONSTRAINT [FK_Tasks_User] FOREIGN KEY([AssignedUserId])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[Tasks] CHECK CONSTRAINT [FK_Tasks_User]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_EstadoCivil] FOREIGN KEY([EstadoCivilId])
REFERENCES [dbo].[EstadoCivil] ([Id])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_EstadoCivil]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_Genero] FOREIGN KEY([GeneroId])
REFERENCES [dbo].[Generos] ([Id])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_Genero]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_Rol] FOREIGN KEY([RolId])
REFERENCES [dbo].[Roles] ([Id])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_Rol]
GO
