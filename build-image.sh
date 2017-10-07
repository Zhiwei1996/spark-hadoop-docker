#!/bin/bash

echo ""

echo -e "\nbuild docker spark image\n"
sudo docker build -t zhiweio/spark-hadoop:1.0 .

echo ""