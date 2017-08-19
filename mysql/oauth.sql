DROP DATABASE IF EXISTS `oauth`;
CREATE DATABASE `oauth`;
USE oauth;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `oauth_client`
-- ----------------------------
DROP TABLE IF EXISTS `oauth_client`;
CREATE TABLE `oauth_client` (
  `client_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '客户端ID',
  `client_key` varchar(255) DEFAULT '' COMMENT '客户端key',
  `client_secret` varchar(255) DEFAULT '' COMMENT '秘钥',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`client_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='客户端表';

SET FOREIGN_KEY_CHECKS = 1;
