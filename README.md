# pmacct-docker-kafka
**pmacct-docker-kafka** is a docker image of [Pmacct] with [Kafka] plugin.\
By default it starts sfacctd daemon. If you want to start nfacctd daemon just override command while runnig up the container.

### Runnig the container

Place your config file into sfacctd.conf and run:
```
docker run --name pmacct-docker-kafka -p 6345:6343/UDP -v sfacctd.conf:/etc/pmacct/sfacctd.conf kvitex/pmacct-docker-kafka 
```


[//]:#

[pmacct]: <http://www.pmacct.net/>
[kafka]: <https://kafka.apache.org/>
