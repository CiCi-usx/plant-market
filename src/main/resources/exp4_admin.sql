CREATE TABLE exp4_admin(
adminName VARCHAR( 50 ) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
adminPwd VARCHAR( 100 ) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
PRIMARY KEY ( adminName )
) ENGINE = innoDB;

Insert into exp4_admin values('admin','admin');MariaDB [db23136236]> SHOW CREATE TABLE exp4_admin;
+------------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Table      | Create Table                                                                                                                                                         |
+------------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| exp4_admin | CREATE TABLE `exp4_admin` (
  `adminName` varchar(50) NOT NULL,
  `adminPwd` varchar(100) NOT NULL,
  PRIMARY KEY (`adminName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 |
+------------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------+
1 row in set (0.027 sec)

MariaDB [db23136236]> SELECT * FROM exp4_admin;
+-----------+----------+
| adminName | adminPwd |
+-----------+----------+
| admin     | admin    |
+-----------+----------+
1 row in set (0.022 sec)

MariaDB [db23136236]> NOTEE;
