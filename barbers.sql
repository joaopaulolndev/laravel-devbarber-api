-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: barbers
-- ------------------------------------------------------
-- Server version	5.7.29-log

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
-- Table structure for table `barber_availabilities`
--

DROP TABLE IF EXISTS `barber_availabilities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `barber_availabilities` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `barber_id` int(10) unsigned NOT NULL,
  `weekday` int(11) NOT NULL,
  `hours` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `barber_availabilities_barber_id_foreign` (`barber_id`),
  CONSTRAINT `barber_availabilities_barber_id_foreign` FOREIGN KEY (`barber_id`) REFERENCES `barbers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `barber_availabilities`
--

LOCK TABLES `barber_availabilities` WRITE;
/*!40000 ALTER TABLE `barber_availabilities` DISABLE KEYS */;
INSERT INTO `barber_availabilities` VALUES (1,5,0,'10:00,11:00,12:00,13:00,14:00,15:00,16:00,17:00','2020-11-16 22:08:42','2020-11-16 22:08:42'),(2,2,2,'07:00,08:00,09:00,10:00,11:00,12:00,13:00,14:00','2020-11-16 22:08:42','2020-11-16 22:08:42'),(3,4,0,'08:00,09:00,10:00,11:00,12:00,13:00,14:00,15:00','2020-11-16 22:08:42','2020-11-16 22:08:42'),(4,4,3,'10:00,11:00,12:00,13:00,14:00,15:00,16:00,17:00','2020-11-16 22:08:42','2020-11-16 22:08:42'),(5,3,4,'07:00,08:00,09:00,10:00,11:00,12:00,13:00,14:00','2020-11-16 22:08:42','2020-11-16 22:08:42');
/*!40000 ALTER TABLE `barber_availabilities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `barber_comments`
--

DROP TABLE IF EXISTS `barber_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `barber_comments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `barber_id` int(10) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `rate` double(8,2) NOT NULL DEFAULT '0.00',
  `body` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `barber_comments_barber_id_foreign` (`barber_id`),
  CONSTRAINT `barber_comments_barber_id_foreign` FOREIGN KEY (`barber_id`) REFERENCES `barbers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `barber_comments`
--

LOCK TABLES `barber_comments` WRITE;
/*!40000 ALTER TABLE `barber_comments` DISABLE KEYS */;
INSERT INTO `barber_comments` VALUES (1,5,'Prof. Federico Ward',2.20,'Corporis sapiente omnis et cum. Quae modi eum ullam voluptas est ut. Consectetur dolor perspiciatis eligendi assumenda.','2020-11-16 22:08:42','2020-11-16 22:08:42'),(2,2,'Eliezer Mayert',3.70,'Perferendis et sed et et doloremque autem. Maiores adipisci voluptas dolor id amet sed. Excepturi distinctio et qui aspernatur fugit expedita.','2020-11-16 22:08:42','2020-11-16 22:08:42'),(3,5,'Helen Bednar MD',3.10,'Iste ipsam magnam delectus quia. Voluptate ut sunt sunt fugit. In aut similique ipsam iste et est pariatur.','2020-11-16 22:08:42','2020-11-16 22:08:42'),(4,1,'Destinee Daugherty',3.40,'Earum commodi ut ipsam eligendi facilis aliquam vel. Est beatae consequatur suscipit eum quasi.','2020-11-16 22:08:42','2020-11-16 22:08:42'),(5,1,'Miss Janis Berge MD',4.40,'Fugit aut illo est. Vero molestiae quia aut rerum nobis qui et. Cum sed dolore qui architecto. Dolor necessitatibus ducimus incidunt et et saepe.','2020-11-16 22:08:42','2020-11-16 22:08:42');
/*!40000 ALTER TABLE `barber_comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `barber_photos`
--

DROP TABLE IF EXISTS `barber_photos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `barber_photos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `barber_id` int(10) unsigned NOT NULL,
  `url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `barber_photos_barber_id_foreign` (`barber_id`),
  CONSTRAINT `barber_photos_barber_id_foreign` FOREIGN KEY (`barber_id`) REFERENCES `barbers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `barber_photos`
--

LOCK TABLES `barber_photos` WRITE;
/*!40000 ALTER TABLE `barber_photos` DISABLE KEYS */;
INSERT INTO `barber_photos` VALUES (1,4,'3.png','2020-11-16 22:08:41','2020-11-16 22:08:41'),(2,3,'2.png','2020-11-16 22:08:41','2020-11-16 22:08:41'),(3,4,'2.png','2020-11-16 22:08:41','2020-11-16 22:08:41'),(4,3,'1.png','2020-11-16 22:08:41','2020-11-16 22:08:41'),(5,3,'2.png','2020-11-16 22:08:42','2020-11-16 22:08:42');
/*!40000 ALTER TABLE `barber_photos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `barber_reviews`
--

DROP TABLE IF EXISTS `barber_reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `barber_reviews` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `barber_id` int(10) unsigned NOT NULL,
  `rate` double(8,2) NOT NULL DEFAULT '0.00',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `barber_reviews_barber_id_foreign` (`barber_id`),
  CONSTRAINT `barber_reviews_barber_id_foreign` FOREIGN KEY (`barber_id`) REFERENCES `barbers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `barber_reviews`
--

LOCK TABLES `barber_reviews` WRITE;
/*!40000 ALTER TABLE `barber_reviews` DISABLE KEYS */;
INSERT INTO `barber_reviews` VALUES (1,2,3.50,'2020-11-16 22:08:42','2020-11-16 22:08:42'),(2,2,3.20,'2020-11-16 22:08:42','2020-11-16 22:08:42'),(3,1,4.30,'2020-11-16 22:08:42','2020-11-16 22:08:42'),(4,4,2.10,'2020-11-16 22:08:42','2020-11-16 22:08:42'),(5,1,4.70,'2020-11-16 22:08:42','2020-11-16 22:08:42');
/*!40000 ALTER TABLE `barber_reviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `barber_services`
--

DROP TABLE IF EXISTS `barber_services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `barber_services` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `barber_id` int(10) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` double(8,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `barber_services_barber_id_foreign` (`barber_id`),
  CONSTRAINT `barber_services_barber_id_foreign` FOREIGN KEY (`barber_id`) REFERENCES `barbers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `barber_services`
--

LOCK TABLES `barber_services` WRITE;
/*!40000 ALTER TABLE `barber_services` DISABLE KEYS */;
INSERT INTO `barber_services` VALUES (1,4,'Ocie Flatley',51.00,'2020-11-16 22:08:41','2020-11-16 22:08:41'),(2,4,'Gudrun Glover Sr.',61.00,'2020-11-16 22:08:41','2020-11-16 22:08:41'),(3,4,'Guiseppe Mayert',58.00,'2020-11-16 22:08:41','2020-11-16 22:08:41'),(4,5,'Cedrick Hermiston',31.00,'2020-11-16 22:08:41','2020-11-16 22:08:41'),(5,5,'Kamille Turner',82.00,'2020-11-16 22:08:41','2020-11-16 22:08:41');
/*!40000 ALTER TABLE `barber_services` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `barbers`
--

DROP TABLE IF EXISTS `barbers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `barbers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `avatar` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'default.png',
  `starts` double(8,2) NOT NULL DEFAULT '0.00',
  `latitude` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `longitude` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `barbers`
--

LOCK TABLES `barbers` WRITE;
/*!40000 ALTER TABLE `barbers` DISABLE KEYS */;
INSERT INTO `barbers` VALUES (1,'Timmothy Connelly','2.png',4.20,'-23.5930907','-46.6982795','2020-11-16 22:08:41','2020-11-16 22:08:41'),(2,'Carmelo Champlin','3.png',3.00,'-23.5530907','-46.6582795','2020-11-16 22:08:41','2020-11-16 22:08:41'),(3,'Prof. Jesus Macejkovic','1.png',2.90,'-23.5130907','-46.6482795','2020-11-16 22:08:41','2020-11-16 22:08:41'),(4,'Sydnie Steuber II','3.png',4.70,'-23.5830907','-46.6282795','2020-11-16 22:08:41','2020-11-16 22:08:41'),(5,'Miss Fleta Jacobson','3.png',4.30,'-23.5330907','-46.6682795','2020-11-16 22:08:41','2020-11-16 22:08:41');
/*!40000 ALTER TABLE `barbers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'2014_10_12_000000_create_users_table',1),(2,'2014_10_12_100000_create_password_resets_table',1),(3,'2016_06_01_000001_create_oauth_auth_codes_table',1),(4,'2016_06_01_000002_create_oauth_access_tokens_table',1),(5,'2016_06_01_000003_create_oauth_refresh_tokens_table',1),(6,'2016_06_01_000004_create_oauth_clients_table',1),(7,'2016_06_01_000005_create_oauth_personal_access_clients_table',1),(8,'2020_11_13_173736_create_barbers_table',1),(9,'2020_11_13_173747_create_user_favorites_table',1),(10,'2020_11_13_173834_create_user_appointments_table',1),(11,'2020_11_13_175858_create_barber_photos_table',1),(12,'2020_11_13_180011_create_barber_reviews_table',1),(13,'2020_11_13_180021_create_barber_services_table',1),(14,'2020_11_13_180436_create_barber_comments_table',1),(15,'2020_11_13_180852_create_barber_availabilities_table',1);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_access_tokens`
--

DROP TABLE IF EXISTS `oauth_access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth_access_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `client_id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_access_tokens_user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_access_tokens`
--

LOCK TABLES `oauth_access_tokens` WRITE;
/*!40000 ALTER TABLE `oauth_access_tokens` DISABLE KEYS */;
INSERT INTO `oauth_access_tokens` VALUES ('4191b9de973e2bcf9858bd99abdd0c461059f1137e6793f8e99f6c75d7d8da987ba6278bc5e4c198',6,2,NULL,'[]',0,'2020-11-17 17:00:25','2020-11-17 17:00:25','2020-11-17 15:00:24'),('8cd376468033c0e1d3b8ca862292b24e3e03cad1f930032f409afa8f5f31e9c3236f0c940ac247ed',6,2,NULL,'[]',0,'2020-11-16 22:13:18','2020-11-16 22:13:18','2020-11-16 20:13:18'),('bdb4c37e5839d6ca06e38bcbfcde2874a7173e47862fc0465403d2570c065a77089d748ca59cd1fe',6,2,NULL,'[]',0,'2020-11-17 00:24:06','2020-11-17 00:24:06','2020-11-16 22:24:06'),('f3da4d995e95f075774f3dddbef8206316815ceca26187e01f7dc33438d3f1d7def2896a7cb2e1c7',6,2,NULL,'[]',0,'2020-11-16 23:14:43','2020-11-16 23:14:43','2020-11-16 21:14:43');
/*!40000 ALTER TABLE `oauth_access_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_auth_codes`
--

DROP TABLE IF EXISTS `oauth_auth_codes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth_auth_codes` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_auth_codes`
--

LOCK TABLES `oauth_auth_codes` WRITE;
/*!40000 ALTER TABLE `oauth_auth_codes` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth_auth_codes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_clients`
--

DROP TABLE IF EXISTS `oauth_clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth_clients` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `secret` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `redirect` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `personal_access_client` tinyint(1) NOT NULL,
  `password_client` tinyint(1) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_clients_user_id_index` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_clients`
--

LOCK TABLES `oauth_clients` WRITE;
/*!40000 ALTER TABLE `oauth_clients` DISABLE KEYS */;
INSERT INTO `oauth_clients` VALUES (1,NULL,'Laravel Personal Access Client','PV7OGJzcR82asL9IzgtTGE2MjYhCoYule8MCT340','http://localhost',1,0,0,'2020-11-16 22:08:53','2020-11-16 22:08:53'),(2,NULL,'Laravel Password Grant Client','3XhQ9q6ls1RpZWkM69XpShsMGVBejbIPrC7waWVH','http://localhost',0,1,0,'2020-11-16 22:08:54','2020-11-16 22:08:54');
/*!40000 ALTER TABLE `oauth_clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_personal_access_clients`
--

DROP TABLE IF EXISTS `oauth_personal_access_clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth_personal_access_clients` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `client_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_personal_access_clients_client_id_index` (`client_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_personal_access_clients`
--

LOCK TABLES `oauth_personal_access_clients` WRITE;
/*!40000 ALTER TABLE `oauth_personal_access_clients` DISABLE KEYS */;
INSERT INTO `oauth_personal_access_clients` VALUES (1,1,'2020-11-16 22:08:54','2020-11-16 22:08:54');
/*!40000 ALTER TABLE `oauth_personal_access_clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_refresh_tokens`
--

DROP TABLE IF EXISTS `oauth_refresh_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth_refresh_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `access_token_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_refresh_tokens_access_token_id_index` (`access_token_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_refresh_tokens`
--

LOCK TABLES `oauth_refresh_tokens` WRITE;
/*!40000 ALTER TABLE `oauth_refresh_tokens` DISABLE KEYS */;
INSERT INTO `oauth_refresh_tokens` VALUES ('0dbd714b121de6777b17c4f6759f0cbc7ce7f9bfc409a3daa664f860794c8fe044f115bd7fe4bad5','f3da4d995e95f075774f3dddbef8206316815ceca26187e01f7dc33438d3f1d7def2896a7cb2e1c7',0,'2021-11-16 20:14:43'),('79cde4dea680a762a9716d95c1b786629a83187a2ddc1b3f83b14a7b3738763d2a62f8d76a550d5b','bdb4c37e5839d6ca06e38bcbfcde2874a7173e47862fc0465403d2570c065a77089d748ca59cd1fe',0,'2021-11-16 21:24:06'),('b49682e45c90f056624c78fc276df38906d0c215092104bda7f47eaba21552aba6e305b72dad782e','4191b9de973e2bcf9858bd99abdd0c461059f1137e6793f8e99f6c75d7d8da987ba6278bc5e4c198',0,'2021-11-17 14:00:25'),('ba3bf7a78b339bf1dd7a3a3c5a684c5974fff54a5a6c0710431a021dedc15101d1db4170a7a2cf0a','8cd376468033c0e1d3b8ca862292b24e3e03cad1f930032f409afa8f5f31e9c3236f0c940ac247ed',0,'2021-11-16 19:13:18');
/*!40000 ALTER TABLE `oauth_refresh_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_resets`
--

DROP TABLE IF EXISTS `password_resets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_resets`
--

LOCK TABLES `password_resets` WRITE;
/*!40000 ALTER TABLE `password_resets` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_resets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_appointments`
--

DROP TABLE IF EXISTS `user_appointments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_appointments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `barber_id` int(10) unsigned NOT NULL,
  `barber_service_id` int(10) unsigned NOT NULL,
  `appointment_datetime` datetime NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_appointments_user_id_foreign` (`user_id`),
  KEY `user_appointments_barber_id_foreign` (`barber_id`),
  CONSTRAINT `user_appointments_barber_id_foreign` FOREIGN KEY (`barber_id`) REFERENCES `barbers` (`id`) ON DELETE CASCADE,
  CONSTRAINT `user_appointments_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_appointments`
--

LOCK TABLES `user_appointments` WRITE;
/*!40000 ALTER TABLE `user_appointments` DISABLE KEYS */;
INSERT INTO `user_appointments` VALUES (3,6,4,1,'2020-11-18 11:00:00','2020-11-17 00:36:35','2020-11-17 00:36:35'),(4,6,4,2,'2020-11-18 14:00:00','2020-11-17 00:40:58','2020-11-17 00:40:58');
/*!40000 ALTER TABLE `user_appointments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_favorites`
--

DROP TABLE IF EXISTS `user_favorites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_favorites` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `barber_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_favorites_user_id_foreign` (`user_id`),
  KEY `user_favorites_barber_id_foreign` (`barber_id`),
  CONSTRAINT `user_favorites_barber_id_foreign` FOREIGN KEY (`barber_id`) REFERENCES `barbers` (`id`) ON DELETE CASCADE,
  CONSTRAINT `user_favorites_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_favorites`
--

LOCK TABLES `user_favorites` WRITE;
/*!40000 ALTER TABLE `user_favorites` DISABLE KEYS */;
INSERT INTO `user_favorites` VALUES (7,6,4,'2020-11-17 17:15:13','2020-11-17 17:15:13'),(8,6,3,'2020-11-17 17:15:17','2020-11-17 17:15:17'),(9,6,1,'2020-11-17 17:15:21','2020-11-17 17:15:21');
/*!40000 ALTER TABLE `user_favorites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `avatar` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'default.png',
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Eric Franecki I','gottlieb.eunice@example.net','$2y$10$mk/uzQAskLn21kuDd9.mAec.eciBAnDw62WLfkbzBtyX4hvvhvv2K','default.png','xHgM5dXG4Z','2020-11-16 22:08:41','2020-11-16 22:08:41'),(2,'Tommie Lebsack','brenna.rempel@example.com','$2y$10$tL825UpX/GM./waQnhEf6um26i5opg5s85AHyCJjTR3wVnYFERnWq','default.png','xYPRsQ4un1','2020-11-16 22:08:41','2020-11-16 22:08:41'),(3,'Prof. Mitchell Ortiz MD','daugherty.audrey@example.org','$2y$10$JZrRVAQMRtxsk2n1l2uCFOwkL/6UJFKCmim3QwzKYTgivOONhNDGS','default.png','S9UAmBQ3gp','2020-11-16 22:08:41','2020-11-16 22:08:41'),(4,'Broderick Gleichner','pwiza@example.com','$2y$10$JR8xin7ALJnYFQPDNzDbKeenq.lFM0cv47OVS1ufsIpKGv0r8lflC','default.png','CbgFr0qx8H','2020-11-16 22:08:41','2020-11-16 22:08:41'),(5,'Miss Jacynthe Hammes II','hyatt.breanne@example.com','$2y$10$Bav710SVShvus1Dgqa/MnO/rnhnVYEfSXsdyS7RKye0XPnptU2ope','default.png','rEeC6D78cp','2020-11-16 22:08:41','2020-11-16 22:08:41'),(6,'rodinei update','rodineiapi@teste.com','$2y$10$RHVuC6nH/ThnMvCh3l6QFeLYga0QA0U7kYOmFtNe2GzJma7vwaKaW','1605624673-849470_788a_2.jpg',NULL,'2020-11-16 22:13:18','2020-11-17 17:51:13');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-11-17 12:03:00
