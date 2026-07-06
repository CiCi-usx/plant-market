DROP TABLE IF EXISTS `exp4_user`;

CREATE TABLE `exp4_user` (
  `uid` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uname` varchar(30) NOT NULL,
  `upwd` varchar(50) NOT NULL,
  `usex` varchar(10) DEFAULT NULL,
  `uemail` varchar(50) DEFAULT NULL,
  `phone` varchar(60) DEFAULT NULL,
  `address` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`uid`),
  UNIQUE KEY `uname` (`uname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;MariaDB [db23136236]> SHOW CREATE TABLE exp4_user;
+-----------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Table     | Create Table                                                                                                                                                                                                                                                                                                                                                                              |
+-----------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| exp4_user | CREATE TABLE `exp4_user` (
  `uid` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uname` varchar(30) NOT NULL,
  `upwd` varchar(50) NOT NULL,
  `usex` varchar(10) DEFAULT NULL,
  `uemail` varchar(50) DEFAULT NULL,
  `phone` varchar(60) DEFAULT NULL,
  `address` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`uid`),
  UNIQUE KEY `uname` (`uname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 |
+-----------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
1 row in set (0.018 sec)

MariaDB [db23136236]> SELECT * FROM exp4_user;
Empty set (0.020 sec)

MariaDB [db23136236]> NOTEE;
