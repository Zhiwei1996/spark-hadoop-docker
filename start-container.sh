#!/bin/bash

# the default node number is 3
N=${1:-3}


# start spark master container
sudo docker rm -f spark-master &> /dev/null
echo "start spark-master container..."
sudo docker run -itd \
                --net=spark \
                -p 2222:22 \
                -p 4040:4040 \
                -p 8080:8080 \
                -p 8088:8088 \
                -p 50070:50070 \
                --name spark-master \
                --hostname spark-master \
                zhiwei1997/spark-hadoop:1.1 &> /dev/null


# start spark slave container
i=1
while [ $i -lt $N ]
do
	sudo docker rm -f spark-slave$i &> /dev/null
	echo "start spark-slave$i container..."
	sudo docker run -itd \
	                --net=spark \
	                --name spark-slave$i \
	                --hostname spark-slave$i \
	                zhiwei1997/spark-hadoop:1.1 &> /dev/null
	i=$(( $i + 1 ))
done

# get into spark master container
sudo docker exec -it spark-master bash
