#!/bin/bash

if [ "$HADOOP_HOME" != "" ];then
    HADOOP_HOME=$HADOOP_HOME
fi

if [ "$HADOOP_HOME" = "" ];then
    export HADOOP_HOME=/usr/local/hadoop
fi

if [ "$SPARK_HOME" != "" ];then
    SPARK_HOME=$SPARK_HOME
fi

if [ "$SPARK_HOME" = "" ];then
    export SPARK_HOME=/usr/local/spark-2.1.1-bin-hadoop2.7
fi

echo -e "\n"
echo "start dfs..."
$HADOOP_HOME/sbin/start-dfs.sh

echo -e "\n"
echo "start yarn..."
$HADOOP_HOME/sbin/start-yarn.sh

echo -e "\n"
echo "start spark..."
$SPARK_HOME/sbin/start-all.sh

echo -e "\n"
