/*
SQLyog Ultimate v13.1.1 (64 bit)
MySQL - 5.7.31 : Database - multitenant_integrated_trade
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`multitenant_integrated_trade` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `multitenant_integrated_trade`;

/*Table structure for table `sys_api` */

DROP TABLE IF EXISTS `sys_api`;

CREATE TABLE `sys_api` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `code` varchar(64) NOT NULL COMMENT '权限码',
  `url` varchar(255) NOT NULL COMMENT 'api url',
  `request_type` varchar(20) DEFAULT NULL COMMENT '请求方式-get post',
  `perm_flag` varchar(32) DEFAULT NULL COMMENT '菜单权限标识',
  `desc` varchar(255) DEFAULT NULL COMMENT 'api描述',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `del_flag` char(1) NOT NULL DEFAULT '0' COMMENT '0--正常 1--删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `sys_api` */

/*Table structure for table `sys_login_log` */

DROP TABLE IF EXISTS `sys_login_log`;

CREATE TABLE `sys_login_log` (
  `id` bigint(65) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `userid` int(11) NOT NULL COMMENT '用户ID',
  `message` text COMMENT '错误信息',
  `ip` varchar(50) DEFAULT NULL COMMENT '登录IP',
  `location` varchar(255) DEFAULT NULL COMMENT '登录地点',
  `is_succeed` char(1) DEFAULT '1' COMMENT '1成功 2失败',
  `os` varchar(50) DEFAULT NULL COMMENT '登录平台',
  `createtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `sys_login_log` */

/*Table structure for table `sys_menu` */

DROP TABLE IF EXISTS `sys_menu`;

CREATE TABLE `sys_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `name` varchar(32) NOT NULL COMMENT '菜单名称',
  `perm_flag` varchar(32) DEFAULT NULL COMMENT '菜单权限标识',
  `url` varchar(255) DEFAULT NULL COMMENT '前端跳转URL',
  `is_frame` char(1) NOT NULL DEFAULT '1' COMMENT '1 非外链 2 外链',
  `parent_id` int(11) DEFAULT NULL COMMENT '父菜单',
  `level` int(11) NOT NULL DEFAULT '1' COMMENT '所在层级',
  `icon` varchar(32) DEFAULT NULL COMMENT '图标',
  `sort` int(11) DEFAULT NULL COMMENT '排序',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `del_flag` char(1) DEFAULT '0' COMMENT '0--正常 1--删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

/*Data for the table `sys_menu` */

insert  into `sys_menu`(`id`,`name`,`perm_flag`,`url`,`is_frame`,`parent_id`,`level`,`icon`,`sort`,`create_time`,`update_time`,`del_flag`) values 
(1,'菜单管理','sys:menu',NULL,'1',NULL,1,NULL,4,'2020-10-28 08:33:20','2020-10-28 09:15:32','0'),
(2,'用户管理','sys:user',NULL,'1',NULL,1,NULL,2,'2020-10-28 08:33:28','2020-10-28 09:15:30','0'),
(3,'角色管理','sys:role',NULL,'1',NULL,1,NULL,3,'2020-10-28 08:33:33','2020-10-28 09:15:31','0'),
(4,'API管理','sys:api',NULL,'1',NULL,1,NULL,5,'2020-10-28 08:47:44','2020-10-28 09:29:05','0'),
(5,'首页','sys:home',NULL,'1',NULL,1,NULL,1,'2020-10-28 09:15:29','2020-10-28 09:15:29','0');

/*Table structure for table `sys_notice` */

DROP TABLE IF EXISTS `sys_notice`;

CREATE TABLE `sys_notice` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `title` varchar(255) NOT NULL COMMENT '标题',
  `type` char(1) NOT NULL COMMENT '类型',
  `content` text NOT NULL COMMENT '内容',
  `createtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `creater` int(11) NOT NULL COMMENT '创建人',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `sys_notice` */

/*Table structure for table `sys_notice_type` */

DROP TABLE IF EXISTS `sys_notice_type`;

CREATE TABLE `sys_notice_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `type_name` varchar(20) DEFAULT NULL COMMENT '通知类型',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `sys_notice_type` */

/*Table structure for table `sys_operation_log` */

DROP TABLE IF EXISTS `sys_operation_log`;

CREATE TABLE `sys_operation_log` (
  `id` int(64) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `user_id` int(11) NOT NULL COMMENT '用户名',
  `description` varchar(255) DEFAULT NULL COMMENT '操作描述',
  `action_url` varchar(255) DEFAULT NULL COMMENT '请求地址',
  `action_method` text COMMENT '请求方法',
  `start_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '请求时间',
  `finish_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '结束时间',
  `ip` varchar(255) DEFAULT NULL COMMENT '操作IP',
  `location` varchar(255) DEFAULT NULL COMMENT '操作地点',
  `os` varchar(255) DEFAULT NULL COMMENT '操作平台',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `sys_operation_log` */

/*Table structure for table `sys_role` */

DROP TABLE IF EXISTS `sys_role`;

CREATE TABLE `sys_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `role_name` varchar(64) NOT NULL COMMENT '角色名称',
  `tenant_id` int(11) DEFAULT NULL COMMENT '租户ID',
  `role_code` varchar(40) NOT NULL COMMENT '角色标识',
  `remark` varchar(60) DEFAULT NULL COMMENT '角色描述',
  `del_flag` char(1) NOT NULL DEFAULT '0' COMMENT '0-正常,1-删除',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `sys_role` */

/*Table structure for table `sys_role_api` */

DROP TABLE IF EXISTS `sys_role_api`;

CREATE TABLE `sys_role_api` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `role_id` int(11) NOT NULL COMMENT '角色ID',
  `api_id` int(11) NOT NULL COMMENT 'APIID',
  PRIMARY KEY (`id`),
  KEY `role_key_index` (`role_id`),
  KEY `api_key_index` (`api_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `sys_role_api` */

/*Table structure for table `sys_role_menu` */

DROP TABLE IF EXISTS `sys_role_menu`;

CREATE TABLE `sys_role_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `role_id` int(11) NOT NULL COMMENT '角色ID',
  `menu_id` int(11) NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`id`),
  KEY `role_key_index` (`role_id`) COMMENT 'roleid普通索引',
  KEY `menu_key_index` (`menu_id`) COMMENT 'menuid普通索引'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `sys_role_menu` */

/*Table structure for table `sys_tenant` */

DROP TABLE IF EXISTS `sys_tenant`;

CREATE TABLE `sys_tenant` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `name` varchar(255) NOT NULL COMMENT '租户名称',
  `code` varchar(64) NOT NULL COMMENT '租户标识',
  `start_time` timestamp NULL DEFAULT NULL COMMENT '授权开始时间',
  `end_time` timestamp NULL DEFAULT NULL COMMENT '授权结束时间',
  `status` char(1) NOT NULL DEFAULT '0' COMMENT '0正常,1-过期，2-冻结',
  `del_flag` char(1) NOT NULL DEFAULT '0' COMMENT '0-正常,1-删除',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `sys_tenant` */

/*Table structure for table `sys_user` */

DROP TABLE IF EXISTS `sys_user`;

CREATE TABLE `sys_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键自增ID',
  `account` varchar(64) NOT NULL COMMENT '账号',
  `password` varchar(255) NOT NULL COMMENT '密码',
  `salt` varchar(50) NOT NULL COMMENT '密码盐',
  `name` varchar(50) NOT NULL COMMENT '用户名字',
  `email` varchar(30) DEFAULT NULL COMMENT '邮箱',
  `phone` varchar(20) DEFAULT NULL COMMENT '手机号',
  `avatar` varchar(255) DEFAULT NULL COMMENT '头像地址',
  `sex` char(1) DEFAULT NULL COMMENT '性别 1男 2女',
  `createUserId` int(11) unsigned DEFAULT NULL COMMENT '创建者',
  `tenant_id` int(11) DEFAULT NULL COMMENT '租户ID',
  `real_name_id` int(11) DEFAULT NULL COMMENT '实名制信息ID',
  `real_name_flag` char(1) DEFAULT '0' COMMENT '0-非实名制，1-实名制',
  `remark` varchar(100) DEFAULT NULL COMMENT '备注',
  `lock_flag` char(1) NOT NULL DEFAULT '0' COMMENT '0-待审核 ，1-正常，2-锁定',
  `del_flag` char(1) NOT NULL DEFAULT '0' COMMENT '0-正常，1-逻辑删除',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

/*Data for the table `sys_user` */

insert  into `sys_user`(`id`,`account`,`password`,`salt`,`name`,`email`,`phone`,`avatar`,`sex`,`createUserId`,`tenant_id`,`real_name_id`,`real_name_flag`,`remark`,`lock_flag`,`del_flag`,`create_time`,`update_time`) values 
(1,'admin','6ab1f386d715cfb6be85de941d438b02','8pgby','admin',NULL,NULL,NULL,NULL,NULL,1,NULL,'0',NULL,'0','0','2020-10-28 09:30:37','2020-10-28 09:30:37');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
