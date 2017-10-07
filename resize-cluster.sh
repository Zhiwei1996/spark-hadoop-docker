#!/bin/bash

# N is the node number of hadoop cluster
N=$1

if [ $# = 0 ]
then
	echo "Please specify the node number of spark cluster!"
	exit 1
fi

# change slaves file
i=1
rm config/slaves
while [ $i -lt $N ]
do
	echo "spark-slave$i" >> config/slaves
	((i++))
done

echo ""

echo -e "\nbuild docker spark image\n"

# rebuild kiwenlau/hadoop image
sudo docker build -t zhiwei1997/spark-hadoop:1.0 .

echo ""
