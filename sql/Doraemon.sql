/*
SQLyog Ultimate v13.1.1 (64 bit)
MySQL - 8.0.18 : Database - Doraemon
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`Doraemon` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `Doraemon`;

/*Table structure for table `sys_wxuser` */

DROP TABLE IF EXISTS `sys_wxuser`;

CREATE TABLE `sys_wxuser` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `nick_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '微信名',
  `gender` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '性别',
  `city` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '城市',
  `province` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '省份',
  `country` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '国家',
  `avatar_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '头像',
  `openid` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '微信openid',
  `create_user_id` bigint(20) NOT NULL COMMENT '创建人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_user_id` bigint(20) NOT NULL COMMENT '更新人',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_enabled` int(1) NOT NULL DEFAULT '1' COMMENT '是否启用',
  `del_flag` int(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `description` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '备注',
  `lock_version` int(11) DEFAULT NULL COMMENT '乐观锁',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `sys_wxuser` */

/*Table structure for table `t_sys_announcement` */

DROP TABLE IF EXISTS `t_sys_announcement`;

CREATE TABLE `t_sys_announcement` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `title` varchar(256) NOT NULL COMMENT '公告标题',
  `content` text NOT NULL COMMENT '公告内容',
  `type` int(11) NOT NULL COMMENT '公告类型 1通知 2简介 3card',
  `card_type` int(11) DEFAULT NULL COMMENT '卡片类型 1.联系 2日志 3图片',
  `create_user_id` bigint(20) NOT NULL,
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_user_id` bigint(20) NOT NULL,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_enabled` int(1) NOT NULL DEFAULT '1',
  `del_flag` int(1) NOT NULL DEFAULT '0',
  `description` varchar(256) DEFAULT NULL,
  `lock_version` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `t_sys_announcement` */

/*Table structure for table `t_sys_api` */

DROP TABLE IF EXISTS `t_sys_api`;

CREATE TABLE `t_sys_api` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '名称',
  `perm_flag` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'api权限编码',
  `request_type` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '请求方式',
  `url_path` varchar(3072) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '请求地址',
  `create_user_id` bigint(20) NOT NULL COMMENT '创建人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_user_id` bigint(20) NOT NULL COMMENT '更新人',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_enabled` int(1) NOT NULL DEFAULT '1' COMMENT '是否启用',
  `del_flag` int(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `description` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '备注',
  `lock_version` int(11) DEFAULT NULL COMMENT '乐观锁',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='菜单 ';

/*Data for the table `t_sys_api` */

/*Table structure for table `t_sys_dept` */

DROP TABLE IF EXISTS `t_sys_dept`;

CREATE TABLE `t_sys_dept` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '名称',
  `leader` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '负责人',
  `phone` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '电话',
  `email` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '邮箱',
  `parent_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '父级',
  `sort` int(11) NOT NULL DEFAULT '100000' COMMENT '排序',
  `ancestors` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT '祖级关系',
  `create_user_id` bigint(20) NOT NULL COMMENT '创建人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_user_id` bigint(20) NOT NULL COMMENT '更新人',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_enabled` int(1) NOT NULL DEFAULT '1' COMMENT '是否启用',
  `del_flag` int(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `description` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '备注',
  `version` int(11) DEFAULT NULL COMMENT '乐观锁',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='部门 ';

/*Data for the table `t_sys_dept` */

/*Table structure for table `t_sys_login_log` */

DROP TABLE IF EXISTS `t_sys_login_log`;

CREATE TABLE `t_sys_login_log` (
  `lock_version` int(11) DEFAULT NULL COMMENT '乐观锁',
  `create_user_id` bigint(20) NOT NULL COMMENT '创建人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_user_id` bigint(20) NOT NULL COMMENT '更新人',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_enabled` int(1) NOT NULL DEFAULT '1' COMMENT '是否启用',
  `del_flag` int(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `description` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '备注',
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'ip',
  `location` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '地址',
  `os` bigint(20) DEFAULT NULL COMMENT '平台',
  `login_result` varchar(3072) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '结果',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='菜单 ';

/*Data for the table `t_sys_login_log` */

/*Table structure for table `t_sys_menu` */

DROP TABLE IF EXISTS `t_sys_menu`;

CREATE TABLE `t_sys_menu` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '名称',
  `enname` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '组件名称',
  `parent_id` bigint(20) NOT NULL COMMENT '父菜单id',
  `path` varchar(3072) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '路由地址',
  `component` varchar(3072) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '组件地址',
  `icon` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '图标',
  `sort` int(11) DEFAULT NULL COMMENT '展示顺序',
  `create_user_id` bigint(20) NOT NULL COMMENT '创建人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_user_id` bigint(20) NOT NULL COMMENT '更新人',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_enabled` int(1) NOT NULL DEFAULT '1' COMMENT '是否启用',
  `del_flag` int(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `description` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '备注',
  `lock_version` int(11) DEFAULT NULL COMMENT '乐观锁',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='菜单 ';

/*Data for the table `t_sys_menu` */

/*Table structure for table `t_sys_operation_log` */

DROP TABLE IF EXISTS `t_sys_operation_log`;

CREATE TABLE `t_sys_operation_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `action_url` varchar(3072) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '操作方法',
  `operation_status` varchar(20) DEFAULT NULL COMMENT '操作状态',
  `operation_type` varchar(218) DEFAULT NULL COMMENT '操作类型',
  `action_method` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '请求方式',
  `ip` varchar(32) DEFAULT NULL COMMENT 'ip',
  `location` varchar(3072) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '地址',
  `platform` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '平台',
  `create_user_id` bigint(20) NOT NULL COMMENT '创建人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_user_id` bigint(20) NOT NULL COMMENT '更新人',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_enabled` int(1) NOT NULL DEFAULT '1' COMMENT '是否启用',
  `del_flag` int(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `description` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '备注',
  `lock_version` int(11) DEFAULT NULL COMMENT '乐观锁',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='菜单 ';

/*Data for the table `t_sys_operation_log` */

/*Table structure for table `t_sys_post` */

DROP TABLE IF EXISTS `t_sys_post`;

CREATE TABLE `t_sys_post` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '名称',
  `number` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '编码',
  `sort` int(11) DEFAULT NULL COMMENT '排序',
  `create_user_id` bigint(20) NOT NULL COMMENT '创建人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_user_id` bigint(20) NOT NULL COMMENT '更新人',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_enabled` int(1) NOT NULL DEFAULT '1' COMMENT '是否启用',
  `del_flag` int(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `description` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '备注',
  `lock-version` int(11) DEFAULT NULL COMMENT '乐观锁',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='岗位 ';

/*Data for the table `t_sys_post` */

/*Table structure for table `t_sys_role` */

DROP TABLE IF EXISTS `t_sys_role`;

CREATE TABLE `t_sys_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '名称',
  `code` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '标识',
  `sort` int(11) DEFAULT NULL COMMENT '排序',
  `create_user_id` bigint(20) NOT NULL COMMENT '创建人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_user_id` bigint(20) NOT NULL COMMENT '更新人',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_enabled` int(1) NOT NULL DEFAULT '1' COMMENT '是否启用',
  `del_flag` int(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `description` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '备注',
  `lock-version` int(11) DEFAULT NULL COMMENT '乐观锁',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='角色 ';

/*Data for the table `t_sys_role` */

/*Table structure for table `t_sys_role_apis` */

DROP TABLE IF EXISTS `t_sys_role_apis`;

CREATE TABLE `t_sys_role_apis` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `role_id` bigint(20) NOT NULL COMMENT '角色id',
  `api_id` bigint(20) NOT NULL COMMENT 'apiid',
  `create_user_id` bigint(20) NOT NULL COMMENT '创建人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_user_id` bigint(20) NOT NULL COMMENT '更新人',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_enabled` int(1) NOT NULL DEFAULT '1' COMMENT '是否启用',
  `del_flag` int(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `description` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '备注',
  `lock_version` int(11) DEFAULT NULL COMMENT '乐观锁',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='角色权限 ';

/*Data for the table `t_sys_role_apis` */

/*Table structure for table `t_sys_role_menus` */

DROP TABLE IF EXISTS `t_sys_role_menus`;

CREATE TABLE `t_sys_role_menus` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `role_id` bigint(20) NOT NULL COMMENT '角色id',
  `menu_id` bigint(20) NOT NULL COMMENT '菜单id',
  `create_user_id` bigint(20) NOT NULL COMMENT '创建人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_user_id` bigint(20) NOT NULL COMMENT '更新人',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_enabled` int(1) NOT NULL DEFAULT '1' COMMENT '是否启用',
  `del_flag` int(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `description` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '备注',
  `lock_version` int(11) DEFAULT NULL COMMENT '乐观锁',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='角色权限 ';

/*Data for the table `t_sys_role_menus` */

/*Table structure for table `t_sys_user_account` */

DROP TABLE IF EXISTS `t_sys_user_account`;

CREATE TABLE `t_sys_user_account` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `user_id` bigint(20) NOT NULL COMMENT '用户id',
  `username` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户账号',
  `password` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户密码',
  `pwd_salt` varchar(64) NOT NULL COMMENT '密码盐值',
  `account_status` int(1) NOT NULL DEFAULT '0' COMMENT '账户状态 0待审核 1正常 2冻结 3封号',
  `create_user_id` bigint(20) NOT NULL COMMENT '创建人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_user_id` bigint(20) NOT NULL COMMENT '更新人',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_enabled` int(1) NOT NULL DEFAULT '1' COMMENT '是否启用',
  `del_flag` int(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `description` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '备注',
  `lock-version` int(11) DEFAULT NULL COMMENT '乐观锁',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='用户账号 ';

/*Data for the table `t_sys_user_account` */

/*Table structure for table `t_sys_user_dept` */

DROP TABLE IF EXISTS `t_sys_user_dept`;

CREATE TABLE `t_sys_user_dept` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `user_id` bigint(20) NOT NULL COMMENT '角色id',
  `dept_id` bigint(20) NOT NULL COMMENT '部门id',
  `create_user_id` bigint(20) NOT NULL COMMENT '创建人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_user_id` bigint(20) NOT NULL COMMENT '更新人',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_enabled` int(1) NOT NULL DEFAULT '1' COMMENT '是否启用',
  `del_flag` int(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `description` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '备注',
  `lock-version` int(11) DEFAULT NULL COMMENT '乐观锁',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='角色数据权限 ';

/*Data for the table `t_sys_user_dept` */

/*Table structure for table `t_sys_user_info` */

DROP TABLE IF EXISTS `t_sys_user_info`;

CREATE TABLE `t_sys_user_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `nick_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '昵称',
  `phone_number` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户手机号',
  `gender` int(1) DEFAULT NULL COMMENT '性别 0女 1男',
  `avatar` varchar(3072) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '头像',
  `email` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '邮箱',
  `dept_id` bigint(20) DEFAULT NULL COMMENT '部门',
  `is_admin` int(1) NOT NULL DEFAULT '0' COMMENT '是否为admin账号',
  `create_user_id` bigint(20) NOT NULL COMMENT '创建人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_user_id` bigint(20) NOT NULL COMMENT '更新人',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_enabled` int(1) NOT NULL DEFAULT '1' COMMENT '是否启用',
  `del_flag` int(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `description` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '备注',
  `lock-version` int(11) DEFAULT NULL COMMENT '乐观锁',
  PRIMARY KEY (`id`,`nick_name`,`phone_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='用户信息 ';

/*Data for the table `t_sys_user_info` */

/*Table structure for table `t_sys_user_post` */

DROP TABLE IF EXISTS `t_sys_user_post`;

CREATE TABLE `t_sys_user_post` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `user_id` bigint(20) NOT NULL COMMENT '用户id',
  `post_id` bigint(20) NOT NULL COMMENT '岗位id',
  `create_user_id` bigint(20) NOT NULL COMMENT '创建人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_user_id` bigint(20) NOT NULL COMMENT '更新人',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_enabled` int(1) NOT NULL DEFAULT '1' COMMENT '是否启用',
  `del_flag` int(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `description` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '备注',
  `lock-version` int(11) DEFAULT NULL COMMENT '乐观锁',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='用户岗位 ';

/*Data for the table `t_sys_user_post` */

/*Table structure for table `t_sys_user_role` */

DROP TABLE IF EXISTS `t_sys_user_role`;

CREATE TABLE `t_sys_user_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `user_id` bigint(20) NOT NULL COMMENT '用户id',
  `role_id` bigint(20) NOT NULL COMMENT '角色id',
  `create_user_id` bigint(20) NOT NULL COMMENT '创建人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_user_id` bigint(20) NOT NULL COMMENT '更新人',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_enabled` int(1) NOT NULL DEFAULT '1' COMMENT '是否启用',
  `del_flag` int(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `description` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '备注',
  `lock-version` int(11) DEFAULT NULL COMMENT '乐观锁',
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='用户角色 ';

/*Data for the table `t_sys_user_role` */

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
