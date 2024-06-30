/*
SQLyog Community v13.0.1 (64 bit)
MySQL - 5.5.20-log : Database - bus_go
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`bus_go` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `bus_go`;

/*Table structure for table `bus` */

DROP TABLE IF EXISTS `bus`;

CREATE TABLE `bus` (
  `bus_id` int(11) NOT NULL AUTO_INCREMENT,
  `lid` int(11) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `place` varchar(50) DEFAULT NULL,
  `contact` bigint(20) DEFAULT NULL,
  `vehicle_no` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `status` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`bus_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `bus` */

insert  into `bus`(`bus_id`,`lid`,`name`,`place`,`contact`,`vehicle_no`,`email`,`status`) values 
(1,2,'Rolex','kalpetta',1234567890,'kl 12 b 618','rolex@gmail.com','pending'),
(2,3,'Jayanthi','bathery',1234567890,'kl 12 5 322','jayanthi@gmail.com','pending');

/*Table structure for table `chat` */

DROP TABLE IF EXISTS `chat`;

CREATE TABLE `chat` (
  `chat_id` int(11) NOT NULL AUTO_INCREMENT,
  `from_id` int(11) DEFAULT NULL,
  `to_id` int(11) DEFAULT NULL,
  `message` varchar(200) DEFAULT NULL,
  `date` date DEFAULT NULL,
  PRIMARY KEY (`chat_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

/*Data for the table `chat` */

insert  into `chat`(`chat_id`,`from_id`,`to_id`,`message`,`date`) values 
(1,5,4,'hi','2023-01-20'),
(2,6,5,'hi','2023-01-20'),
(3,6,4,'hi','2023-01-20'),
(4,6,4,'','2023-01-20'),
(5,5,4,'hi','2023-01-20'),
(6,5,4,'hi','2023-01-20'),
(7,6,4,'hi','2023-01-20'),
(8,5,6,'hi','2023-01-20'),
(9,5,6,'','2023-01-20'),
(10,5,6,'hi','2023-01-20'),
(11,4,5,'helloo','2023-01-20'),
(12,5,4,'hai','2023-01-20');

/*Table structure for table `complaint` */

DROP TABLE IF EXISTS `complaint`;

CREATE TABLE `complaint` (
  `complaint_id` int(11) NOT NULL AUTO_INCREMENT,
  `login_id` int(11) DEFAULT NULL,
  `complaint` varchar(100) DEFAULT NULL,
  `reply` varchar(100) DEFAULT NULL,
  `date` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`complaint_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `complaint` */

/*Table structure for table `location` */

DROP TABLE IF EXISTS `location`;

CREATE TABLE `location` (
  `location_id` int(11) NOT NULL AUTO_INCREMENT,
  `login_id` int(11) DEFAULT NULL,
  `latitude` varchar(50) DEFAULT NULL,
  `longitude` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`location_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `location` */

/*Table structure for table `login` */

DROP TABLE IF EXISTS `login`;

CREATE TABLE `login` (
  `login_id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`login_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

/*Data for the table `login` */

insert  into `login`(`login_id`,`username`,`password`,`type`) values 
(1,'admin','admin','admin'),
(2,'rolex','rolex','bus'),
(3,'jayanthi','jayanthi','bus'),
(4,'athul','athul','user'),
(5,'thejas','thejas','user'),
(6,'amit','amit','user');

/*Table structure for table `request` */

DROP TABLE IF EXISTS `request`;

CREATE TABLE `request` (
  `reg_id` int(11) NOT NULL AUTO_INCREMENT,
  `from_id` int(50) DEFAULT NULL,
  `to_id` int(50) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`reg_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `request` */

insert  into `request`(`reg_id`,`from_id`,`to_id`,`date`,`status`) values 
(1,5,4,'2023-01-20','accepted');

/*Table structure for table `route` */

DROP TABLE IF EXISTS `route`;

CREATE TABLE `route` (
  `route_id` int(11) NOT NULL AUTO_INCREMENT,
  `from` varchar(50) DEFAULT NULL,
  `to` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`route_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `route` */

insert  into `route`(`route_id`,`from`,`to`) values 
(1,'kalpetta','bathery'),
(2,'bathery','kalpetta');

/*Table structure for table `schedule` */

DROP TABLE IF EXISTS `schedule`;

CREATE TABLE `schedule` (
  `schedule_id` int(11) NOT NULL AUTO_INCREMENT,
  `trip_id` int(11) DEFAULT NULL,
  `stop_id` int(11) DEFAULT NULL,
  `trip_time` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`schedule_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;

/*Data for the table `schedule` */

insert  into `schedule`(`schedule_id`,`trip_id`,`stop_id`,`trip_time`) values 
(1,1,1,'10:10'),
(2,1,2,'10:20'),
(3,1,3,'10:30'),
(4,1,4,'11:10'),
(5,2,5,'11:40'),
(6,2,6,'11:50'),
(7,2,8,'12:20'),
(8,2,9,'12:40'),
(9,3,1,'10:10'),
(10,3,2,'10:20'),
(11,3,3,'10:30'),
(12,3,4,'11:00'),
(13,4,5,'11:10'),
(14,4,6,'11:20'),
(15,4,8,'11:40'),
(16,4,9,'12:00');

/*Table structure for table `stop` */

DROP TABLE IF EXISTS `stop`;

CREATE TABLE `stop` (
  `stop_id` int(11) NOT NULL AUTO_INCREMENT,
  `route_id` int(11) DEFAULT NULL,
  `stop_no` int(11) DEFAULT NULL,
  `stop` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`stop_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

/*Data for the table `stop` */

insert  into `stop`(`stop_id`,`route_id`,`stop_no`,`stop`) values 
(1,1,1,'jayithra'),
(2,1,2,'civil'),
(3,1,3,'muttil'),
(4,1,4,'bathery'),
(5,2,1,'court'),
(6,2,2,'beenachi'),
(8,2,3,'muttil'),
(9,2,4,'kalpetta');

/*Table structure for table `trip` */

DROP TABLE IF EXISTS `trip`;

CREATE TABLE `trip` (
  `trip_id` int(11) NOT NULL AUTO_INCREMENT,
  `bus_id` int(11) DEFAULT NULL,
  `route_id` int(11) DEFAULT NULL,
  `trip_time` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`trip_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Data for the table `trip` */

insert  into `trip`(`trip_id`,`bus_id`,`route_id`,`trip_time`) values 
(1,2,1,'10:00'),
(2,2,2,'11:30'),
(3,3,1,'09:00'),
(4,3,2,'10:00');

/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `login_id` int(11) DEFAULT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `place` varchar(50) DEFAULT NULL,
  `post` varchar(50) DEFAULT NULL,
  `pin` int(11) DEFAULT NULL,
  `contact` bigint(20) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Data for the table `user` */

insert  into `user`(`user_id`,`login_id`,`first_name`,`last_name`,`place`,`post`,`pin`,`contact`,`email`) values 
(1,4,'Athul','Mathai','Kalpetta','kalpetta',673124,8606363540,'athulmathai333@gmail.com'),
(2,5,'Thejas','Biju','Bathery ','bathery',565656,8568568568,'theju424@gmail.com'),
(3,6,'Amit','C','bathery','batgery',565656,8528528521,'amit@gmail.com');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
