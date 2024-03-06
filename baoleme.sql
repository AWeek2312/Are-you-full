-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: baoleme
-- ------------------------------------------------------
-- Server version	8.0.34

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `customers`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customers` (
  `customer_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `gender` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_number` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`customer_id`),
  KEY `idx_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` VALUES (1,'John Doe','Male','123456789','password123');
INSERT INTO `customers` VALUES (2,'mary','Female','98765432100','123456');
INSERT INTO `customers` VALUES (3,'mpw','male','15200073664','123456');
INSERT INTO `customers` VALUES (5,'123','male','1234567890000','123456');
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `before_insert_update_all_tables` BEFORE INSERT ON `customers` FOR EACH ROW BEGIN
    IF EXISTS (
        SELECT 1 FROM (
            SELECT contact_number FROM restaurant_staff
            UNION
            SELECT contact_number FROM delivery_staff
            UNION
            SELECT contact_number FROM customers
        ) AS all_contacts
        WHERE all_contacts.contact_number = NEW.contact_number
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Duplicate contact number in customers, restaurant_staff, or delivery_staff table';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `delivery_staff`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `delivery_staff` (
  `delivery_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `gender` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_number` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`delivery_id`),
  KEY `idx_name_delivery_staff` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `delivery_staff`
--

INSERT INTO `delivery_staff` VALUES (1,'Sam Brown','Male','555555555','deliverypass');
INSERT INTO `delivery_staff` VALUES (2,'钱七','男','3333333333','deliverypass');
INSERT INTO `delivery_staff` VALUES (3,'孙八','女','4444444444','fastdeliver');
INSERT INTO `delivery_staff` VALUES (4,'马盼旺','男','123456','123456');

--
-- Table structure for table `dishes`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dishes` (
  `dish_id` int NOT NULL AUTO_INCREMENT,
  `dish_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `dish_price` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `dish_description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dish_image_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dish_sales` int DEFAULT '0',
  PRIMARY KEY (`dish_id`),
  KEY `idx_dish_id` (`dish_id`),
  KEY `idx_dish_image_path` (`dish_image_path`),
  KEY `idx_dish_name` (`dish_name`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dishes`
--

INSERT INTO `dishes` VALUES (2,'兰州拉面','55.00','兰州人拉的面，热乎的','https://p8.itc.cn/q_70/images01/20211028/e366b427a3a3439d9bce6fe1a72ec498.jpeg',5);
INSERT INTO `dishes` VALUES (14,'小鸡炖蘑菇','30.00','大大的蘑菇小小的鸡鸡','https://img1.baidu.com/it/u=4191364855,3385090189&fm=253&fmt=auto&app=138&f=JPEG?w=590&h=500',3);
INSERT INTO `dishes` VALUES (15,'黄焖鸡米饭','40.00',' 香气四溢，每一口都是家的味道。','https://i01piccdn.sogoucdn.com/407fae706e423932',1);
INSERT INTO `dishes` VALUES (16,'毛血旺','65.00',' 辣得犹如火焰，独特的麻辣体验。','https://i02piccdn.sogoucdn.com/5178a9a06a4efcf7',0);
INSERT INTO `dishes` VALUES (21,'炸鸡套餐','22.00',' 酥脆金黄，一口咬下满满幸福感。','https://i02piccdn.sogoucdn.com/c13667214f11f2a4',1);
INSERT INTO `dishes` VALUES (22,'佛跳墙','114514.00',' 佛系满足，一碗汤汁包含的是心动的味道。','https://i01piccdn.sogoucdn.com/1baebf2ddf1d67e3',1);
INSERT INTO `dishes` VALUES (25,'烤鱼拼盘','38.00','丰富多样的烤鱼组合','https://i04piccdn.sogoucdn.com/7cd5adc46de6bea3',0);
INSERT INTO `dishes` VALUES (26,'酸菜鱼火锅','68.00','麻辣鲜香，好味不腻','https://i01piccdn.sogoucdn.com/3526acda9d3bd51a',0);
INSERT INTO `dishes` VALUES (27,'芝士炸鸡','25.00','外酥里嫩，芝士浓郁','https://i04piccdn.sogoucdn.com/fb1388fce5ef0347',0);
INSERT INTO `dishes` VALUES (28,'椒盐脆皮鸭','48.00','外皮香脆，肉质鲜嫩','https://i02piccdn.sogoucdn.com/e1e123a1765afc65',0);
INSERT INTO `dishes` VALUES (29,'三文鱼刺身','45.00','健康美味，鲜嫩可口','https://i01piccdn.sogoucdn.com/f9df53e977fdd159',0);
INSERT INTO `dishes` VALUES (30,'巧克力慕斯','20.00','香浓巧克力，口感细腻','https://i04piccdn.sogoucdn.com/e578fc20542ea82b',1);
INSERT INTO `dishes` VALUES (31,'水果沙拉','18.00','新鲜水果搭配清爽沙拉','https://i01piccdn.sogoucdn.com/38799979943d97e2',1);
INSERT INTO `dishes` VALUES (32,'红烧牛肉面','28.00','经典红烧，醇香美味','https://i04piccdn.sogoucdn.com/84cc27387998fb13',0);
INSERT INTO `dishes` VALUES (33,'菠萝咕噜肉','32.00','甜酸口感，外酥里嫩','https://i02piccdn.sogoucdn.com/5933d1c42ec9cd57',1);
INSERT INTO `dishes` VALUES (34,'茄汁意大利面','22.00','番茄味浓郁，面条弹滑','https://i02piccdn.sogoucdn.com/60f174387e9bc2b8',1);

--
-- Table structure for table `order_details`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_details` (
  `order_detail_id` int NOT NULL AUTO_INCREMENT,
  `order_id` int DEFAULT NULL,
  `dish_id` int DEFAULT NULL,
  `dish_image_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dish_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`order_detail_id`),
  KEY `order_id` (`order_id`),
  KEY `fk_dish_id` (`dish_id`),
  CONSTRAINT `fk_dish_id` FOREIGN KEY (`dish_id`) REFERENCES `dishes` (`dish_id`) ON DELETE CASCADE,
  CONSTRAINT `order_details_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_details`
--

INSERT INTO `order_details` VALUES (10,3,2,'https://p8.itc.cn/q_70/images01/20211028/e366b427a3a3439d9bce6fe1a72ec498.jpeg','兰州拉面');
INSERT INTO `order_details` VALUES (11,3,2,'https://p8.itc.cn/q_70/images01/20211028/e366b427a3a3439d9bce6fe1a72ec498.jpeg','兰州拉面');
INSERT INTO `order_details` VALUES (12,4,2,'https://p8.itc.cn/q_70/images01/20211028/e366b427a3a3439d9bce6fe1a72ec498.jpeg','兰州拉面');
INSERT INTO `order_details` VALUES (13,5,15,'https://i01piccdn.sogoucdn.com/407fae706e423932','黄焖鸡米饭');
INSERT INTO `order_details` VALUES (14,5,14,'https://img1.baidu.com/it/u=4191364855,3385090189&fm=253&fmt=auto&app=138&f=JPEG?w=590&h=500','小鸡炖蘑菇');
INSERT INTO `order_details` VALUES (15,6,14,'https://img1.baidu.com/it/u=4191364855,3385090189&fm=253&fmt=auto&app=138&f=JPEG?w=590&h=500','小鸡炖蘑菇');
INSERT INTO `order_details` VALUES (16,6,2,'https://p8.itc.cn/q_70/images01/20211028/e366b427a3a3439d9bce6fe1a72ec498.jpeg','兰州拉面');
INSERT INTO `order_details` VALUES (17,12,2,'https://p8.itc.cn/q_70/images01/20211028/e366b427a3a3439d9bce6fe1a72ec498.jpeg','兰州拉面');
INSERT INTO `order_details` VALUES (18,12,14,'https://img1.baidu.com/it/u=4191364855,3385090189&fm=253&fmt=auto&app=138&f=JPEG?w=590&h=500','小鸡炖蘑菇');
INSERT INTO `order_details` VALUES (19,7,21,'https://i02piccdn.sogoucdn.com/c13667214f11f2a4','炸鸡套餐');
INSERT INTO `order_details` VALUES (20,9,22,'https://i01piccdn.sogoucdn.com/1baebf2ddf1d67e3','佛跳墙');
INSERT INTO `order_details` VALUES (21,8,30,'https://i04piccdn.sogoucdn.com/e578fc20542ea82b','巧克力慕斯');
INSERT INTO `order_details` VALUES (22,10,31,'https://i01piccdn.sogoucdn.com/38799979943d97e2','水果沙拉');
INSERT INTO `order_details` VALUES (23,11,34,'https://i02piccdn.sogoucdn.com/60f174387e9bc2b8','茄汁意大利面');
INSERT INTO `order_details` VALUES (24,10,33,'https://i02piccdn.sogoucdn.com/5933d1c42ec9cd57','菠萝咕噜肉');
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `update_dish_sales` AFTER INSERT ON `order_details` FOR EACH ROW BEGIN
    -- 菜品ID
    DECLARE dish_id_val INT;

    -- 获取新插入的菜品ID
    SET dish_id_val = NEW.dish_id;

    -- 更新菜品表的销量字段（假设你有一个菜品表叫做 dishes，包含字段 dish_id 和 sales）
    UPDATE dishes
    SET dish_sales = dish_sales + 1
    WHERE dish_id = dish_id_val;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `orders`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `order_id` int NOT NULL AUTO_INCREMENT,
  `customer_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `review` text COLLATE utf8mb4_unicode_ci COMMENT '评价',
  `delivery_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `contact_number` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `completion_time` timestamp NULL DEFAULT NULL,
  `order_status` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Waiting',
  `acceptance_time` timestamp NULL DEFAULT NULL,
  `expectation_time` datetime DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  KEY `fk_orders_customer` (`customer_name`),
  KEY `fk_orders_delivery_staff` (`delivery_name`),
  CONSTRAINT `fk_orders_customer` FOREIGN KEY (`customer_name`) REFERENCES `customers` (`name`),
  CONSTRAINT `fk_orders_delivery_staff` FOREIGN KEY (`delivery_name`) REFERENCES `delivery_staff` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` VALUES (3,'mpw','不好吃','马盼旺','地址1','1234567890',50.00,'2023-12-12 02:13:09','Completed','2023-12-12 02:13:08','2023-12-12 21:29:17');
INSERT INTO `orders` VALUES (4,'mpw',NULL,'马盼旺','地址2','9876543210',40.00,NULL,'Preparing',NULL,'2023-12-12 21:29:12');
INSERT INTO `orders` VALUES (5,'mpw',NULL,'马盼旺','地址1','1234567890',99.00,NULL,'Preparing',NULL,'2023-12-12 21:29:15');
INSERT INTO `orders` VALUES (6,'mpw',NULL,'马盼旺','地址2','9876543210',40.00,NULL,'Preparing',NULL,'2023-12-12 21:29:16');
INSERT INTO `orders` VALUES (7,'mpw',NULL,'马盼旺','地址2','1234567890',11.00,NULL,'Pending',NULL,'2023-12-12 16:53:54');
INSERT INTO `orders` VALUES (8,'mpw',NULL,'马盼旺','地址2','9876543210',22.00,NULL,'Pending',NULL,'2023-12-12 16:53:57');
INSERT INTO `orders` VALUES (9,'mpw',NULL,'马盼旺','地址2','1234567890',33.00,NULL,'Waiting',NULL,'2023-12-12 16:53:58');
INSERT INTO `orders` VALUES (10,'mpw',NULL,'马盼旺','地址2','1234567890',44.00,NULL,'Waiting',NULL,'2023-12-12 16:53:59');
INSERT INTO `orders` VALUES (11,'mpw','一坨屎','马盼旺','地址2','9876543210',55.00,'2023-12-12 06:39:28','Completed','2023-12-12 06:39:19','2023-12-12 16:54:00');
INSERT INTO `orders` VALUES (12,'mpw',NULL,'Sam Brown','西电南校区海棠公寓','15200073664',114569.00,NULL,'Waiting',NULL,'2023-12-14 08:12:00');

--
-- Table structure for table `restaurant_staff`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `restaurant_staff` (
  `staff_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `gender` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_number` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`staff_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `restaurant_staff`
--

INSERT INTO `restaurant_staff` VALUES (1,'Jane Smith','Female','987654321','securepassword');
INSERT INTO `restaurant_staff` VALUES (2,'解泽阳','male','685479','123456');
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-12-14 21:57:27
