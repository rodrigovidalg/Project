-- MySQL dump 10.13  Distrib 8.0.38, for Win64 (x86_64)
--
-- Host: localhost    Database: db_sistemaempresa
-- ------------------------------------------------------
-- Server version	8.0.39

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `clientes`
--

DROP TABLE IF EXISTS `clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clientes` (
  `id_cliente` int NOT NULL AUTO_INCREMENT,
  `nombres` varchar(60) NOT NULL,
  `apellidos` varchar(60) NOT NULL,
  `nit` varchar(12) DEFAULT NULL,
  `genero` bit(1) DEFAULT NULL,
  `telefono` varchar(25) DEFAULT NULL,
  `correo_electronico` varchar(45) DEFAULT NULL,
  `fecha_ingreso` datetime DEFAULT NULL,
  PRIMARY KEY (`id_cliente`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientes`
--

LOCK TABLES `clientes` WRITE;
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
INSERT INTO `clientes` VALUES (1,'Juan','Perez','CF',_binary '','1234567','juan.p@gmail.com','2024-11-01 14:19:00'),(2,'Maria','Gonzalez','1234',_binary '\0','1234','mariagoz10@gmail.com','2024-11-01 14:21:00'),(3,'Anita','La Huerfanita','CF',_binary '\0','34512674','anitahuerfana@gmail.com','2024-11-01 15:51:00');
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `compras`
--

DROP TABLE IF EXISTS `compras`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `compras` (
  `id_compra` int NOT NULL AUTO_INCREMENT,
  `no_orden_compra` int NOT NULL,
  `id_proveedor` int DEFAULT NULL,
  `fecha_orden` date DEFAULT NULL,
  `fecha_ingreso` datetime DEFAULT NULL,
  PRIMARY KEY (`id_compra`),
  KEY `index_id_proveedor_Proveedores_Compras_idx` (`id_proveedor`),
  CONSTRAINT `id_proveedor_Proveedores_Compras` FOREIGN KEY (`id_proveedor`) REFERENCES `proveedores` (`id_proveedor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `compras`
--

LOCK TABLES `compras` WRITE;
/*!40000 ALTER TABLE `compras` DISABLE KEYS */;
/*!40000 ALTER TABLE `compras` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `compras_detalle`
--

DROP TABLE IF EXISTS `compras_detalle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `compras_detalle` (
  `id_compras_detalle` int NOT NULL AUTO_INCREMENT,
  `id_compra` int DEFAULT NULL,
  `id_producto` int DEFAULT NULL,
  `cantidad` int DEFAULT NULL,
  `precio_costo_unitario` decimal(8,2) DEFAULT NULL,
  PRIMARY KEY (`id_compras_detalle`),
  KEY `index_id_compra_Compras_Compras_detalle_idx` (`id_compra`) /*!80000 INVISIBLE */,
  KEY `index_id_producto_Productos_Compras_detalle_idx` (`id_producto`) /*!80000 INVISIBLE */,
  CONSTRAINT `id_compra_Compras_Compras_detalle` FOREIGN KEY (`id_compra`) REFERENCES `compras` (`id_compra`),
  CONSTRAINT `id_producto_Productos_Compras_detalle` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `compras_detalle`
--

LOCK TABLES `compras_detalle` WRITE;
/*!40000 ALTER TABLE `compras_detalle` DISABLE KEYS */;
/*!40000 ALTER TABLE `compras_detalle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `empleados`
--

DROP TABLE IF EXISTS `empleados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `empleados` (
  `id_empleado` int NOT NULL AUTO_INCREMENT,
  `nombres` varchar(60) NOT NULL,
  `apellidos` varchar(60) NOT NULL,
  `direccion` varchar(80) DEFAULT NULL,
  `telefono` varchar(25) DEFAULT NULL,
  `dpi` varchar(25) DEFAULT NULL,
  `genero` bit(1) DEFAULT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  `id_puesto` smallint DEFAULT NULL,
  `fecha_inicio_labores` date DEFAULT NULL,
  `fecha_ingreso` datetime DEFAULT NULL,
  PRIMARY KEY (`id_empleado`),
  KEY `id_puesto_Puestos_Empleados_idx` (`id_puesto`) /*!80000 INVISIBLE */,
  CONSTRAINT `id_puesto_Puestos_Empleados` FOREIGN KEY (`id_puesto`) REFERENCES `puestos` (`id_puesto`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empleados`
--

LOCK TABLES `empleados` WRITE;
/*!40000 ALTER TABLE `empleados` DISABLE KEYS */;
INSERT INTO `empleados` VALUES (1,'Ricardo','Revolorio','Guatemala','1234','3040507910101',_binary '','1996-12-07',1,'2024-11-01','2024-11-01 14:22:00'),(2,'Christian','Ordoñez','Guatemala','12345','315066690108',_binary '','2024-11-01',4,'2024-11-01','2024-11-01 14:27:00'),(3,'Rodrigo','Guzman','Guatemala','123456','3304567900108',_binary '','2000-06-07',6,'2024-11-01','2024-11-01 14:34:00'),(4,'Carlos','Sarti','Guatemala','1234567','3145654230108',_binary '','2000-05-10',5,'2024-11-01','2024-11-01 14:22:00'),(5,'Herber','De Quiej','Guatemala','12345678','1980234650101',_binary '','1978-09-15',2,'2024-11-01','2024-11-01 14:37:00'),(6,'Sofia','Rojas','Guatemala','12345678','2230564710101',_binary '\0','2002-05-10',3,'2024-11-01','2024-11-01 15:44:00');
/*!40000 ALTER TABLE `empleados` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `marcas`
--

DROP TABLE IF EXISTS `marcas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `marcas` (
  `id_marca` smallint NOT NULL AUTO_INCREMENT,
  `marca` varchar(45) NOT NULL,
  PRIMARY KEY (`id_marca`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `marcas`
--

LOCK TABLES `marcas` WRITE;
/*!40000 ALTER TABLE `marcas` DISABLE KEYS */;
INSERT INTO `marcas` VALUES (1,'Verde Valle'),(2,'Ideal'),(3,'Caña Real'),(4,'Ana Belly'),(5,'Dos Pinos'),(6,'NesCafe'),(7,'Quaker'),(8,'Bimbo'),(9,'Oîkos'),(10,'Ariel'),(11,'Colgate'),(12,'Coca Cola');
/*!40000 ALTER TABLE `marcas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menus`
--

DROP TABLE IF EXISTS `menus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menus` (
  `id_menu` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(60) NOT NULL,
  `rama_padre` int DEFAULT NULL,
  `posicion` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id_menu`),
  KEY `fk_rama_padre` (`rama_padre`),
  CONSTRAINT `fk_rama_padre` FOREIGN KEY (`rama_padre`) REFERENCES `menus` (`id_menu`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menus`
--

LOCK TABLES `menus` WRITE;
/*!40000 ALTER TABLE `menus` DISABLE KEYS */;
INSERT INTO `menus` VALUES (1,'Producto',NULL,'1'),(2,'Ventas',NULL,'2'),(3,'Compras',NULL,'3'),(4,'Reportes',NULL,'4'),(5,'Marcas',1,'1.1'),(6,'Clientes',2,'2.1'),(7,'Empleados',2,'2.2'),(8,'Proveedores',3,'3.1'),(9,'Puestos',7,'2.2.1'),(12,'Inventario',1,'1.2'),(13,'Venta Nueva',2,'2.4'),(14,'Compra Nueva',3,'3.2'),(15,'Puestos',2,'2.3'),(16,'Generar Reporte',4,'4.1');
/*!40000 ALTER TABLE `menus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productos`
--

DROP TABLE IF EXISTS `productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productos` (
  `id_producto` int NOT NULL AUTO_INCREMENT,
  `producto` varchar(50) NOT NULL,
  `id_marca` smallint DEFAULT NULL,
  `descripcion` varchar(100) DEFAULT NULL,
  `imagen` varchar(100) DEFAULT NULL,
  `precio_costo` decimal(8,2) DEFAULT NULL,
  `precio_venta` decimal(8,2) DEFAULT NULL,
  `existencia` int DEFAULT NULL,
  `fecha_ingreso` datetime DEFAULT NULL,
  PRIMARY KEY (`id_producto`),
  KEY `index_id_marca_Marcas_Productos_idx` (`id_marca`),
  CONSTRAINT `id_marca_Marcas_Productos` FOREIGN KEY (`id_marca`) REFERENCES `marcas` (`id_marca`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productos`
--

LOCK TABLES `productos` WRITE;
/*!40000 ALTER TABLE `productos` DISABLE KEYS */;
INSERT INTO `productos` VALUES (1,'Arroz Blanco',1,'Bolsa de 400g','http://localhost/imagenes_productos/1730479546028_arroz blanco.jpg',5.70,7.10,600,'2024-11-01 10:45:00'),(2,'Frijol Grano',1,'Bolsa de 400g','http://localhost/imagenes_productos/1730479728186_frijol.jpg',8.60,9.90,600,'2024-11-01 10:45:00'),(3,'Aceite',2,'Botella 800ml','http://localhost/imagenes_productos/1730479920809_aceite.jpg',19.20,20.35,400,'2024-11-01 10:51:00'),(4,'Azucar',3,'Bolsa 500g','http://localhost/imagenes_productos/1730480173045_azucar 5000g.jpg',4.00,4.90,500,'2024-11-01 10:56:00'),(5,'Azucar',3,'bolsa 2500g','http://localhost/imagenes_productos/1730480281320_azucar 2500g.jpg',19.20,20.50,400,'2024-11-01 10:57:00'),(6,'Sal',4,'bolsa de 907g','http://localhost/imagenes_productos/1730480415835_sal.jpg',1.80,2.60,600,'2024-11-01 11:00:00'),(7,'Mayonesa',4,'Bolsa 375g','http://localhost/imagenes_productos/1730480495998_mayonesa.png',11.40,12.50,500,'2024-11-01 11:01:00'),(8,'Ketchup',4,'Bolsa 375g','http://localhost/imagenes_productos/1730480592783_ketchup.jpg',11.50,12.85,600,'2024-11-01 11:02:00'),(9,'Aderezo',4,'Botella 495g','http://localhost/imagenes_productos/1730480757428_aderezo.jpg',12.50,14.00,400,'2024-11-01 11:05:00'),(10,'Leche Entera',5,'Leche liquida 1000ml','http://localhost/imagenes_productos/1730480856784_leche entera.jpg',15.00,16.35,400,'2024-11-01 11:07:00'),(11,'Cafe Instantaneo',6,'Frasco 300g','http://localhost/imagenes_productos/1730480983932_cafe instantaneo.jpg',21.10,22.00,500,'2024-11-01 11:09:00'),(12,'Avena',7,'Bolsa 900g','http://localhost/imagenes_productos/1730481066311_avena.jpg',19.20,20.00,500,'2024-11-01 11:10:00'),(13,'Cereal Corazon',7,'Caja 300g','http://localhost/imagenes_productos/1730481129227_quaker corazon.jpg',21.35,22.10,400,'2024-11-01 11:11:00'),(14,'Pan Familiar',8,'Pan blanco bolsa 720g','http://localhost/imagenes_productos/1730481237953_pan bimbo.jpg',23.60,24.90,500,'2024-11-01 11:13:00'),(15,'Pan tostado',8,'Bolsa 720g','http://localhost/imagenes_productos/1730481311644_pan tostado.jpg',23.50,24.20,500,'2024-11-01 11:14:00'),(16,'Yogurt Fresa',9,'150g','http://localhost/imagenes_productos/1730481497720_yogurt fresa.jpg',11.35,12.50,500,'2024-11-01 11:18:00'),(17,'Yogurt Arandano',9,'150g','http://localhost/imagenes_productos/1730481530814_yogurt arandano.jpg',11.35,12.50,500,'2024-11-01 11:18:00'),(18,'Yogurt Natural',9,'150g','http://localhost/imagenes_productos/1730481552972_yogurt natural.jpg',11.35,12.50,500,'2024-11-01 11:19:00'),(19,'Detergente',10,'Bolsa 350g','http://localhost/imagenes_productos/1730481676298_detergente ariel 350gm.jpg',5.60,7.20,600,'2024-11-01 11:21:00'),(20,'Detergente Downy',10,'350g','http://localhost/imagenes_productos/1730481717730_downy 350gr.jpeg',5.80,8.00,600,'2024-11-01 11:21:00'),(21,'Pasta Dental Triple Accion',11,'160ml','http://localhost/imagenes_productos/1730481840879_colgate triple accion.jpg',11.00,12.00,800,'2024-11-01 11:23:00'),(22,'Pasta Dental Total 12',11,'150ml','http://localhost/imagenes_productos/1730481922481_total 12.jpg',20.80,22.00,800,'2024-11-01 11:25:00'),(23,'Pasta Dental Luminus White',11,'150ml','http://localhost/imagenes_productos/1730481970458_luminus white.jpg',33.90,35.50,800,'2024-11-01 11:26:00');
/*!40000 ALTER TABLE `productos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proveedores`
--

DROP TABLE IF EXISTS `proveedores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `proveedores` (
  `id_proveedor` int NOT NULL AUTO_INCREMENT,
  `proveedor` varchar(60) NOT NULL,
  `nit` varchar(12) DEFAULT NULL,
  `direccion` varchar(80) DEFAULT NULL,
  `telefono` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`id_proveedor`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proveedores`
--

LOCK TABLES `proveedores` WRITE;
/*!40000 ALTER TABLE `proveedores` DISABLE KEYS */;
INSERT INTO `proveedores` VALUES (1,'Coca Cola','1234567','Guatemala','20201515');
/*!40000 ALTER TABLE `proveedores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `puestos`
--

DROP TABLE IF EXISTS `puestos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `puestos` (
  `id_puesto` smallint NOT NULL AUTO_INCREMENT,
  `puesto` varchar(50) NOT NULL,
  PRIMARY KEY (`id_puesto`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `puestos`
--

LOCK TABLES `puestos` WRITE;
/*!40000 ALTER TABLE `puestos` DISABLE KEYS */;
INSERT INTO `puestos` VALUES (1,'Administrador'),(2,'Mensajero'),(3,'Secretaria'),(4,'Sub Administrador'),(5,'Vendedor'),(6,'Encargado de Compras'),(7,'Analista');
/*!40000 ALTER TABLE `puestos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `id_usuario` int NOT NULL AUTO_INCREMENT,
  `usuario` varchar(25) NOT NULL,
  `password` varchar(12) NOT NULL,
  `rol` smallint DEFAULT NULL,
  PRIMARY KEY (`id_usuario`),
  KEY `id_puesto_Puestos_Usuarios_idx` (`rol`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'admin','123',1),(2,'Ventas','123',2),(3,'Compras','321',6),(4,'Bodega','4321',4);
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ventas`
--

DROP TABLE IF EXISTS `ventas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ventas` (
  `id_venta` int NOT NULL AUTO_INCREMENT,
  `no_factura` int NOT NULL,
  `serie` char(1) DEFAULT NULL,
  `fecha_factura` date DEFAULT NULL,
  `id_cliente` int DEFAULT NULL,
  `id_empleado` int DEFAULT NULL,
  `fecha_ingreso` datetime DEFAULT NULL,
  PRIMARY KEY (`id_venta`),
  KEY `index_id_cliente_Cliente_Ventas_idx` (`id_cliente`) /*!80000 INVISIBLE */,
  KEY `id_empleado_Empleados_Ventas_idx` (`id_empleado`) /*!80000 INVISIBLE */,
  CONSTRAINT `id_clientes_Clientes_Ventas` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id_cliente`),
  CONSTRAINT `id_empleado_Empleados_ventas` FOREIGN KEY (`id_empleado`) REFERENCES `empleados` (`id_empleado`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ventas`
--

LOCK TABLES `ventas` WRITE;
/*!40000 ALTER TABLE `ventas` DISABLE KEYS */;
/*!40000 ALTER TABLE `ventas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ventas_detalle`
--

DROP TABLE IF EXISTS `ventas_detalle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ventas_detalle` (
  `id_venta_detalle` bigint NOT NULL AUTO_INCREMENT,
  `id_venta` int DEFAULT NULL,
  `id_producto` int DEFAULT NULL,
  `cantidad` int DEFAULT NULL,
  `precio_unitario` decimal(8,2) DEFAULT NULL,
  PRIMARY KEY (`id_venta_detalle`),
  KEY `index_id_venta_Venta_Ventas_detalle_idx` (`id_venta`) /*!80000 INVISIBLE */,
  KEY `index_id_producto_Productos_Ventas_detalle_idx` (`id_producto`),
  CONSTRAINT `id_producto_Productos_Ventas_detalle` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`),
  CONSTRAINT `id_venta_Ventas_Ventas_detalle` FOREIGN KEY (`id_venta`) REFERENCES `ventas` (`id_venta`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ventas_detalle`
--

LOCK TABLES `ventas_detalle` WRITE;
/*!40000 ALTER TABLE `ventas_detalle` DISABLE KEYS */;
/*!40000 ALTER TABLE `ventas_detalle` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-11-01 17:21:21
