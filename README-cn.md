##  Docker 中运行 Hadoop 和 Spark 集群
> 一直在模仿，抄 github 和呼吸一样，感谢开源
>
> 山寨项目： https://github.com/kiwenlau/hadoop-cluster-docker


### 3 Nodes Hadoop Cluster

##### 1. pull docker image

```
sudo docker pull zhiwei1997/spark-hadoop:1.1
```

##### 2. clone github repository

```
git clone https://github.com/Zhiwei1996/spark-hadoop-docker.git
```

##### 3. create spark network

```
./create-network.sh
```

##### 4. start container

```
cd spark-hadoop-docker
sudo ./start-container.sh

> output:
start spark-master container...
start spark-slave1 container...
start spark-slave2 container...
root@spark-master:~#
```
- start 3 containers with 1 master and 2 slaves
- you will get into the /root directory of spark-master container


##### 5.change spark-master's root password
```bash
root@spark-master:~# passwd
Enter new UNIX password:             # set 123456 here
Retype new UNIX password:
passwd: password updated successfully
```
- now you can use ssh to connect spark-master through your local ip address
- default ssh port is changed to 2222
```bash
$ ssh -p 2222 root@192.168.1.3       # 192.168.1.3 is my local ip                                                                                  
root@192.168.1.3's password:         # enter 123456
Welcome to Ubuntu 16.04.3 LTS (GNU/Linux 4.9.49-moby x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage
root@spark-master:~#
```

##### 6. start cluster

```
./start-spark-hadoop.sh
```

##### 7. run wordcount

```
./run-wordcount.sh

> output:
input file1.txt:
Hello Hadoop

input file2.txt:
Hello Docker

wordcount output:
Docker    1
Hadoop    1
Hello    2
```

### Arbitrary size Spark cluster

##### 1. pull docker images and clone github repository

do 1~3 like section A

##### 2. rebuild docker image

```
sudo ./resize-cluster.sh 5
```
- specify parameter > 1: 2, 3..
- this script just rebuild hadoop image with different **slaves** file, which pecifies the name of all slave nodes


##### 3. start container

```
sudo ./start-container.sh 5
```
- use the same parameter as the step 2

##### 4. run spark cluster

do 5~6 like section A

