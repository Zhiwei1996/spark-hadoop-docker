#!/bin/bash

echo -e "\n"
echo "stop dfs..."
$HADOOP_HOME/sbin/stop-dfs.sh

echo -e "\n"
echo "stop yarn..."
$HADOOP_HOME/sbin/stop-yarn.sh

echo -e "\n"
echo "stop spark..."
$SPARK_HOME/sbin/stop-all.sh

echo -e "\n"
