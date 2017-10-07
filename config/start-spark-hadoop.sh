#!/bin/bash

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
