use db23136236;

CREATE TABLE exp4_category(
cId int AUTO_INCREMENT NOT NULL ,
cName VARCHAR( 200 ) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL unique,
PRIMARY KEY ( cId)
) ENGINE = innoDB;

insert into exp4_class(cName) values('果树');
insert into exp4_class(cName) values('非果树');MariaDB [db23136236]> SHOW CREATE TABLE exp4_category;
+---------------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Table         | Create Table                                                                                                                                                                                                         |
+---------------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| exp4_category | CREATE TABLE `exp4_category` (
  `cId` int(11) NOT NULL AUTO_INCREMENT,
  `cName` varchar(200) NOT NULL,
  PRIMARY KEY (`cId`),
  UNIQUE KEY `cName` (`cName`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 |
+---------------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
1 row in set (0.041 sec)

MariaDB [db23136236]> SELECT * FROM exp4_category;
+-----+-----------+
| cId | cName     |
+-----+-----------+
|   1 | 果树      |
|   2 | 非果树    |
+-----+-----------+
2 rows in set (0.023 sec)

MariaDB [db23136236]> NOTEE;
