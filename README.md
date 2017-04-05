# hive-usage-script
How many queries is your Hive instance servicing over time? This script scrapes hiveserver logs to help you get a sense of what kind of queries are running over time.

# Usage
```shell
./hiveserver2_queries.pl -h
Usage: ./hiveserver2_queries.pl --granularity <DAY|HOUR|MINUTE> --search <"Starting command:|Parsing command:"> <file list to search>
```

Notes:
* Granularity defaults to HOUR.
* The "file list to search" can include gz files.
* Results are CSV, including a header. You can capture the output a file into Excel if you wish.
* The script's defaults
  * --granularity (-g) : HOUR
  * --search (-s) : "Starting command:"

# Examples
By day:
```shell
$ ~/hiveserver2_queries.pl -g=DAY hiveserver2.log /Users/me/Downloads/hiveserver2.log.00100204.tar.gz
Date,ALTER,CREATE DATABASE,CREATE TABLE,CREATE VIEW,DESC,DROP TABLE,DROP VIEW,FROM,INSERT,SELECT,SHOW CREATE,SHOW DATABASES,SHOW TABLES,SHOW TBLPROPERTIES,USE
20161105,42,0,1678,0,0,1631,0,6580,9995,88,0,112,1,0,14
20170309,0,17,478,13,335,246,24,25,0,0,10660,1155,376,4931,230
```
By hour:
```shell
$ ~/hiveserver2_queries.pl -g=HOUR hiveserver2.log /Users/me/Downloads/hiveserver2.log.00100204.tar.gz
Date,Hour,ALTER,CREATE DATABASE,CREATE TABLE,CREATE VIEW,DESC,DROP TABLE,DROP VIEW,FROM,INSERT,SELECT,SHOW CREATE,SHOW DATABASES,SHOW TABLES,SHOW TBLPROPERTIES,USE
20161105,00,0,0,0,0,0,0,0,0,4,0,0,5,0,0,0
20161105,01,3,0,54,0,0,50,0,201,303,5,0,4,0,0,1
20161105,02,0,0,92,0,0,89,0,357,516,0,0,4,0,0,0
20161105,03,0,0,18,0,0,21,0,85,138,4,0,4,0,0,0
20161105,04,0,0,0,0,0,0,0,0,5,0,0,4,0,0,0
20161105,05,0,0,0,0,0,0,0,0,0,1,0,5,1,0,1
20161105,06,0,0,0,0,0,0,0,0,0,0,0,6,0,0,0
20161105,07,4,0,0,0,0,0,0,6,21,0,0,5,0,0,1
20161105,08,0,0,110,0,0,106,0,427,615,4,0,4,0,0,0
20161105,09,3,0,174,0,0,169,0,677,1045,10,0,5,0,0,1
20161105,10,0,0,4,0,0,5,0,19,34,1,0,4,0,0,0
20161105,11,4,0,88,0,0,83,0,337,507,5,0,5,0,0,1
20161105,12,0,0,67,0,0,65,0,265,381,1,0,4,0,0,0
20161105,13,3,0,172,0,0,169,0,678,1020,10,0,5,0,0,1
20161105,14,0,0,2,0,0,3,0,9,47,1,0,4,0,0,0
20161105,15,4,0,0,0,0,0,0,4,18,0,0,5,0,0,1
20161105,16,0,0,60,0,0,55,0,227,330,5,0,4,0,0,0
20161105,17,3,0,213,0,0,207,0,834,1235,9,0,5,0,0,1
20161105,18,3,0,98,0,0,94,0,382,586,5,0,5,0,0,1
20161105,19,0,0,75,0,0,75,0,298,463,4,0,4,0,0,0
20161105,20,3,0,204,0,0,199,0,801,1197,10,0,5,0,0,1
20161105,21,3,0,124,0,0,122,0,487,761,8,0,5,0,0,1
20161105,22,9,0,109,0,0,106,0,431,674,4,0,7,0,0,3
20161105,23,0,0,14,0,0,13,0,55,95,1,0,4,0,0,0
20170309,00,0,1,14,11,45,13,14,13,0,0,1289,172,32,7,13
20170309,01,0,0,1,0,22,7,8,0,0,0,659,140,23,376,3
20170309,02,0,3,12,0,30,12,0,12,0,0,912,108,19,0,12
20170309,03,0,4,204,0,159,208,0,0,0,0,4828,481,180,2402,120
20170309,04,0,1,0,1,19,0,2,0,0,0,378,96,18,218,0
20170309,05,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0
20170309,06,0,0,0,1,3,4,0,0,0,0,55,26,4,16,2
20170309,07,0,8,247,0,57,2,0,0,0,0,2539,132,100,1911,80
```



