docker-compose down
rm -rf ./master/data/*
rm -rf ./slave/data/*
docker-compose build
docker-compose up -d


countdown()
(
  IFS=:
  set -- $*
  secs=$(( ${1#0} * 3600 + ${2#0} * 60 + ${3#0} ))
  while [ $secs -gt 0 ]
  do
    sleep 1 &
    printf "\r%02d:%02d:%02d" $((secs/3600)) $(( (secs/60)%60)) $((secs%60))
    secs=$(( $secs - 1 ))
    wait
  done
  echo
)

mysql_master_docker_ip=$(docker inspect --format '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' mysql_master)
echo "mysql_master_docker_ip:" $mysql_master_docker_ip
REPLICATION_PASSWORD=123456
REPLICATION_ID=mydb_slave_user

until docker exec mysql_master sh -c "export MYSQL_PWD=$REPLICATION_PASSWORD; mysql -u $REPLICATION_ID -e ';'"
do
    echo "Waiting for mysql_master database connection..."
    countdown "00:00:10" 
done

until docker exec mysql_slave sh -c "export MYSQL_PWD=$REPLICATION_PASSWORD; mysql -u $REPLICATION_ID -e ';'"
do
    echo "Waiting for mysql_slave database connection..."
    countdown "00:00:10" 
done

# echo "Step1.@Slave:stop slave"
# countdown "00:00:05" 
# docker-compose exec mysql_slave mysql -u$REPLICATION_ID -p$REPLICATION_PASSWORD -e "STOP SLAVE;";

echo "Step2.@Master:flush logs"
countdown "00:00:05"
docker-compose exec mysql_master mysql -u$REPLICATION_ID -p$REPLICATION_PASSWORD -e "flush logs;"

echo "Step3.Get master_status_File && master_status_Position"
countdown "00:00:10" 
# \r沒去乾淨
master_status_File=$(docker-compose exec mysql_master mysql -u$REPLICATION_ID -p$REPLICATION_PASSWORD -e "show master status \G"| grep File | sed -n -e 's/^.*: //p')
echo "This is master_status_File:" $master_status_File 
master_status_File=${master_status_File//$'\r'}                                        
countdown "00:00:10" 
master_status_Position=$(docker-compose exec mysql_master mysql -u$REPLICATION_ID -p$REPLICATION_PASSWORD -e "show master status \G"| grep Position | sed -n -e 's/^.*: //p')
echo "This is master_status_Position:" $master_status_Position


# 需要倒數十秒往下做才ok
countdown "00:00:10" 
# docker-compose exec mysql_slave mysql -u$REPLICATION_ID -p$REPLICATION_PASSWORD -e "STOP SLAVE;\
# CHANGE MASTER TO MASTER_HOST='$mysql_master_docker_ip', MASTER_PORT=3306, MASTER_USER='$REPLICATION_ID', \
# MASTER_PASSWORD='$REPLICATION_PASSWORD', MASTER_LOG_FILE='master_bin.000004', MASTER_LOG_POS=154; \
# START SLAVE;"

docker-compose exec mysql_slave mysql -u$REPLICATION_ID -p$REPLICATION_PASSWORD -e "STOP SLAVE;\
CHANGE MASTER TO MASTER_HOST='$mysql_master_docker_ip', MASTER_PORT=3306, MASTER_USER='$REPLICATION_ID', \
MASTER_PASSWORD='$REPLICATION_PASSWORD', MASTER_LOG_FILE='$master_status_File', MASTER_LOG_POS=$master_status_Position; \
START SLAVE;"



docker-compose exec mysql_slave mysql -u$REPLICATION_ID -p$REPLICATION_PASSWORD -e "show SLAVE status;"
# docker-compose exec mysql_master mysql -u$REPLICATION_ID -p$REPLICATION_PASSWORD -e "show master status;"

echo "test create db"
countdown "00:00:30" 
docker-compose exec mysql_master mysql -u$REPLICATION_ID -p$REPLICATION_PASSWORD -e "CREATE DATABASE rockman;"
echo "finish"

