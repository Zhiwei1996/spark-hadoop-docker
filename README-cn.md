# 在Docker容器内运行Hadoop和Spark 集群



## 3节点Hadoop集群


##### 1. pull docker 镜像

```bash
sudo docker pull zhiwei1997/spark-hadoop:1.1
```

##### 2. 克隆github仓库

```bash
git clone https://github.com/Zhiwei1996/spark-hadoop-docker.git
```

##### 3. 创建集群网络

```bash
./create-network.sh
```


##### 4. 启动容器
```bash
cd spark-hadoop-docker
sudo ./start-container.sh

> output:
start spark-master container...
start spark-slave1 container...
start spark-slave2 container...
root@spark-master:~#

```
*  启动3个容器, 1个 master 和 2个 slave
*  将进入spark-master容器的/ root目录


##### 5.更改spark-master的root密码

```bash
root@spark-master:~# passwd
Enter new UNIX password:             # set 123456 here
Retype new UNIX password:
passwd: password updated successfully
```

*   可以使用ssh通过本地IP地址连接spark-master
*   默认ssh端口更改为2222
```bash
$ ssh -p 2222 root@192.168.1.3       # 192.168.1.3 is my local ip                                                                                  
root@192.168.1.3's password:         # enter 123456
Welcome to Ubuntu 16.04.3 LTS (GNU/Linux 4.9.49-moby x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage
root@spark-master:~#
```


##### 6. 启动集群

```bash
./start-spark-hadoop.sh
```

##### 7. 运行 wordcount

```bash
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



### 启动任意节点数量群集

##### 1. pull docker 镜像和 克隆github仓库

重复执行第一部分中 1~3 的操作


##### 2. 重建 docker 镜像

```bash
sudo ./resize-cluster.sh 5

```

*   指定参数> 1：2，3 ..
*   这个脚本只是使用不同的**slaves**文件重建hadoop映像，它指定了所有从节点的名称


##### 3. 启动容器

```bash
sudo ./start-container.sh 5
```

*   使用与步骤2相同的参数

#### 4. 运行 spark 集群

重复执行第一部分中 6~7 的操作