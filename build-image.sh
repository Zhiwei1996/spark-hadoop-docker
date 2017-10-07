#!/bin/bash

echo ""

echo -e "\nbuild docker spark image\n"
sudo docker build -t zhiwei1997/spark-hadoop:1.1 .

echo ""