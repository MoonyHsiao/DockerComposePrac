Docker MySQL master-slave replication 
========================

MySQL master-slave replication with using Docker. 

## Run

To run this examples you will need to start containers with "docker-compose" 
and after starting setup replication. See commands inside ./build.sh. 

就是跑
sh build.sh
#### Create 2 MySQL containers with master-slave row-based replication 

```
./build.sh
```

#### Make changes to master

```
docker exec mysql_master sh -c "export MYSQL_PWD=111; mysql -u root mydb -e 'create table code(code int); insert into code values (100), (200)'"
```

#### Read changes from slave

```
docker exec mysql_slave sh -c "export MYSQL_PWD=111; mysql -u root mydb -e 'select * from code \G'"
```

docker exec mysql_slave sh -c "export MYSQL_PWD=111; mysql -u root mydb -e 'SHOW TABLES \G'"
1.docker exec -it mysql_master bash
2.mysql -h localhost -P 4306 -u root -p
mysql -h localhost -P 4306 -u mydb_slave_user -p
## Troubleshooting

#### Check Logs

```
docker-compose logs
```

#### Start containers in "normal" mode

> Go through "build.sh" and run command step-by-step.

#### Check running containers

```
docker-compose ps
```

#### Clean data dir

```
rm -rf ./master/data/*
rm -rf ./slave/data/*
```

#### Run command inside "mysql_master"

```
docker exec mysql_master sh -c 'mysql -u root -p111 -e "SHOW MASTER STATUS \G"'
```

#### Run command inside "mysql_slave"

```
docker exec mysql_slave sh -c 'mysql -u root -p111 -e "SHOW SLAVE STATUS \G"'
```

#### Enter into "mysql_master"

```
docker exec -it mysql_master bash
```

#### Enter into "mysql_slave"

```
docker exec -it mysql_slave bash
```


mysql_master.env 看起來沒作用

查ip
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' mysql_master
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' mysql_slave

====容器跟容器ip問題====
SHOW SLAVE STATUS;
SHOW MASTER STATUS;

STOP SLAVE;

CHANGE MASTER TO
MASTER_HOST='192.11.0.11',
MASTER_PORT=3306,
MASTER_LOG_FILE='mysql-bin.000002',  
MASTER_LOG_POS=1643;	

 
START SLAVE;


https://dotblogs.com.tw/eric_obay_talk/2018/10/24/160017
https://blog.toright.com/posts/5062/mysql-replication-%E4%B8%BB%E5%BE%9E%E5%BC%8F%E6%9E%B6%E6%A7%8B%E8%A8%AD%E5%AE%9A%E6%95%99%E5%AD%B8.html



@Slave: stop slave;
@Master: flush logs
@Master: show master status; — take note of the master log file and master log position

@Slave: CHANGE MASTER TO MASTER_LOG_FILE='log-bin.00000X', MASTER_LOG_POS=106;

@Slave: start slave;