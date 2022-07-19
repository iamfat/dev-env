## 初始化InfluxDB
```bash
docker pull influxdb:1.8-alpine
docker run --rm -it \
-v $PWD/influxdb:/etc/influxb \
-v influxdb:/var/lib/influxdb \
-e INFLUXDB_ADMIN_USER=genee \
-e INFLUXDB_ADMIN_PASSWORD=83719730 \
-e INFLUXDB_USER=gsen \
-e INFLUXDB_USER_PASSWORD=83719730 \
influxdb:1.8-alpine /init-influxdb.sh
```
