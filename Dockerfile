FROM ubuntu:16.04

MAINTAINER WangZhiwei <noparking188@gmail.com>

WORKDIR  /root

# change default apt source
COPY config/sources.list /etc/apt/

# install openssh-server, openjdk and wget
RUN apt-get update &&  apt-get install -y openssh-server openjdk-8-jdk wget

# install hadoop 2.7.4
RUN wget http://mirrors.hust.edu.cn/apache/hadoop/common/hadoop-2.7.4/hadoop-2.7.4.tar.gz && \
    tar -xzvf hadoop-2.7.4.tar.gz && \
    mv hadoop-2.7.4 /usr/local/hadoop && \
    rm hadoop-2.7.4.tar.gz

# install Scala2.10.4
RUN wget http://www.scala-lang.org/files/archive/scala-2.10.4.tgz && \
    tar -xzvf scala-2.10.4.tgz && \
    mv scala-2.10.4 /usr/local/ && \
    rm scala-2.10.4.tgz

# install Spark2.1.1
RUN wget https://d3kbcqa49mib13.cloudfront.net/spark-2.1.1-bin-hadoop2.7.tgz && \
    tar -xzvf spark-2.1.1-bin-hadoop2.7.tgz && \
    mv spark-2.1.1-bin-hadoop2.7 /usr/local && \
    rm spark-2.1.1-bin-hadoop2.7.tgz

# set environment variable
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64

# hadoop
ENV HADOOP_HOME=/usr/local/hadoop
ENV HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
ENV PATH=$PATH:/usr/local/hadoop/bin:/usr/local/hadoop/sbin


# Scala
ENV SCALA_HOME=/usr/local/scala-2.10.4
ENV PATH=$PATH:$SCALA_HOME/bin

# Spark
ENV SPARK_HOME=/usr/local/spark-2.1.1-bin-hadoop2.7
ENV PATH=$PATH:$SPARK_HOME/bin


# ssh without key
RUN ssh-keygen -t rsa -f ~/.ssh/id_rsa -P '' && \
    cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys

RUN mkdir $HADOOP_HOME/logs && \
    mkdir $HADOOP_HOME/tmp

# copy configiure files
COPY config/* /tmp/

RUN mv /tmp/ssh_config ~/.ssh/config && \
    mv /tmp/hadoop-env.sh /usr/local/hadoop/etc/hadoop/hadoop-env.sh && \
    mv /tmp/hdfs-site.xml $HADOOP_HOME/etc/hadoop/hdfs-site.xml && \
    mv /tmp/core-site.xml $HADOOP_HOME/etc/hadoop/core-site.xml && \
    mv /tmp/mapred-site.xml $HADOOP_HOME/etc/hadoop/mapred-site.xml && \
    mv /tmp/yarn-site.xml $HADOOP_HOME/etc/hadoop/yarn-site.xml && \
    mv /tmp/hadoop-slaves $HADOOP_HOME/etc/hadoop/slaves && \
    mv /tmp/spark-slaves $SPARK_HOME/conf/slaves && \
    mv /tmp/start-spark-hadoop.sh ~/start-spark-hadoop.sh && \
    mv /tmp/stop-spark-hadoop.sh ~/stop-spark-hadoop.sh && \
    mv /tmp/run-wordcount.sh ~/run-wordcount.sh

# add hadoop cluster start shell
RUN chmod +x ~/start-spark-hadoop.sh && \
    chmod +x ~/run-wordcount.sh && \
    chmod +x $HADOOP_HOME/sbin/start-dfs.sh && \
    chmod +x $HADOOP_HOME/sbin/start-yarn.sh


# format namenode
RUN /usr/local/hadoop/bin/hdfs namenode -format

CMD [ "sh", "-c", "service ssh start; bash"]