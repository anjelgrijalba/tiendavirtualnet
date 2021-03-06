USE [tiendavirtual]
GO
/****** Object:  Table [dbo].[facturas]    Script Date: 14/02/2018 15:29:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[facturas](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Numero] [varchar](20) NOT NULL,
	[Fecha] [date] NOT NULL,
	[UsuariosId] [int] NOT NULL,
 CONSTRAINT [PK_facturas] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[lineasfactura]    Script Date: 14/02/2018 15:29:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[lineasfactura](
	[FacturaId] [int] NOT NULL,
	[ProductoId] [int] NOT NULL,
	[Cantidad] [int] NOT NULL,
 CONSTRAINT [PK_lineasfactura] PRIMARY KEY CLUSTERED 
(
	[FacturaId] ASC,
	[ProductoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[productos]    Script Date: 14/02/2018 15:29:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[productos](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[Precio] [money] NULL,
 CONSTRAINT [PK_productos] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[usuarios]    Script Date: 14/02/2018 15:29:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[usuarios](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nick] [nvarchar](50) NOT NULL,
	[Contra] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_usuarios] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  View [dbo].[TotalesPorProducto]    Script Date: 14/02/2018 15:29:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[TotalesPorProducto]
AS
SELECT        p.Nombre, SUM(l.Cantidad) AS Cantidad, SUM(l.Cantidad * p.Precio) AS Total
FROM            dbo.facturas AS f INNER JOIN
                         dbo.lineasfactura AS l ON f.Id = l.FacturaId INNER JOIN
                         dbo.productos AS p ON l.ProductoId = p.Id
GROUP BY p.Nombre

GO
SET IDENTITY_INSERT [dbo].[facturas] ON 

INSERT [dbo].[facturas] ([Id], [Numero], [Fecha], [UsuariosId]) VALUES (2, N'2018001', CAST(N'2018-01-01' AS Date), 3)
INSERT [dbo].[facturas] ([Id], [Numero], [Fecha], [UsuariosId]) VALUES (3, N'2018002', CAST(N'2018-01-01' AS Date), 3)
INSERT [dbo].[facturas] ([Id], [Numero], [Fecha], [UsuariosId]) VALUES (5, N'2018003', CAST(N'2018-01-05' AS Date), 2)
SET IDENTITY_INSERT [dbo].[facturas] OFF
INSERT [dbo].[lineasfactura] ([FacturaId], [ProductoId], [Cantidad]) VALUES (2, 2, 5)
INSERT [dbo].[lineasfactura] ([FacturaId], [ProductoId], [Cantidad]) VALUES (2, 3, 10)
INSERT [dbo].[lineasfactura] ([FacturaId], [ProductoId], [Cantidad]) VALUES (3, 1, 2)
INSERT [dbo].[lineasfactura] ([FacturaId], [ProductoId], [Cantidad]) VALUES (3, 2, 5)
SET IDENTITY_INSERT [dbo].[productos] ON 

INSERT [dbo].[productos] ([Id], [Nombre], [Precio]) VALUES (1, N'Placa', 15.0000)
INSERT [dbo].[productos] ([Id], [Nombre], [Precio]) VALUES (2, N'Ratón', 5.0000)
INSERT [dbo].[productos] ([Id], [Nombre], [Precio]) VALUES (3, N'Monitor', 100.0000)
SET IDENTITY_INSERT [dbo].[productos] OFF
SET IDENTITY_INSERT [dbo].[usuarios] ON 

INSERT [dbo].[usuarios] ([Id], [Nick], [Contra]) VALUES (2, N'pepeperez', N'Cambiado')
INSERT [dbo].[usuarios] ([Id], [Nick], [Contra]) VALUES (3, N'Modificado', N'Modificadez')
INSERT [dbo].[usuarios] ([Id], [Nick], [Contra]) VALUES (7, N'javier', N'contra')
SET IDENTITY_INSERT [dbo].[usuarios] OFF
ALTER TABLE [dbo].[facturas]  WITH CHECK ADD  CONSTRAINT [FK_facturas_usuarios] FOREIGN KEY([UsuariosId])
REFERENCES [dbo].[usuarios] ([Id])
GO
ALTER TABLE [dbo].[facturas] CHECK CONSTRAINT [FK_facturas_usuarios]
GO
ALTER TABLE [dbo].[lineasfactura]  WITH CHECK ADD  CONSTRAINT [FK_lineasfactura_factura] FOREIGN KEY([FacturaId])
REFERENCES [dbo].[facturas] ([Id])
GO
ALTER TABLE [dbo].[lineasfactura] CHECK CONSTRAINT [FK_lineasfactura_factura]
GO
ALTER TABLE [dbo].[lineasfactura]  WITH CHECK ADD  CONSTRAINT [FK_lineasfactura_productos] FOREIGN KEY([ProductoId])
REFERENCES [dbo].[productos] ([Id])
GO
ALTER TABLE [dbo].[lineasfactura] CHECK CONSTRAINT [FK_lineasfactura_productos]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4[30] 2[40] 3) )"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2[66] 3) )"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2) )"
      End
      ActivePaneConfig = 14
   End
   Begin DiagramPane = 
      PaneHidden = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "f"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 263
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "l"
            Begin Extent = 
               Top = 6
               Left = 301
               Bottom = 119
               Right = 526
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "p"
            Begin Extent = 
               Top = 6
               Left = 564
               Bottom = 119
               Right = 789
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      PaneHidden = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      PaneHidden = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'TotalesPorProducto'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'TotalesPorProducto'
GO
