FROM centos:7.9.2009
MAINTAINER pader "huangmnlove@163.com"

# set environment
ENV MODE="cluster" \
    PREFER_HOST_MODE="ip"\
    BASE_DIR="/home/nacos" \
    CLASSPATH=".:/home/nacos/conf:$CLASSPATH" \
    CLUSTER_CONF="/home/nacos/conf/cluster.conf" \
    FUNCTION_MODE="all" \
    JAVA_HOME="/usr/lib/jvm/java-1.8.0-openjdk" \
    NACOS_USER="nacos" \
    JVM_XMS="1g" \
    JVM_XMX="1g" \
    JVM_XMN="512m" \
    JVM_MS="128m" \
    JVM_MMS="320m" \
    NACOS_DEBUG="n" \
    TOMCAT_ACCESSLOG_ENABLED="false" \
    TIME_ZONE="Asia/Shanghai"


#ARG NACOS_VERSION=2.3.0
ARG HOT_FIX_FLAG=""

WORKDIR $BASE_DIR

ADD ./nacos-server-*.tar.gz /home/

RUN  cd /etc/yum.repos.d \
     && sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-* \
     && sed -i  's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-* \
     && yum makecache

RUN rm -rf /home/nacos/bin/* /home/nacos/conf/*.properties /home/nacos/conf/*.example /home/nacos/conf/nacos-mysql.sql \
    && set -x \
    && yum update -y \
    && yum install -y java-1.8.0-openjdk java-1.8.0-openjdk-devel wget iputils nc vim libcurl \
    && java -version

RUN mkdir -p /usr/lib/jvm \
    && wget https://github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.11%2B9/OpenJDK17U-jdk_x64_linux_hotspot_17.0.11_9.tar.gz \
    && tar -xzvf OpenJDK17U-jdk_x64_linux_hotspot_17.0.11_9.tar.gz -C /usr/lib/jvm \
    && mv /usr/lib/jvm/jdk-17.0.11+9 /usr/lib/jvm/java-17-openjdk \
    && rm OpenJDK17U-jdk_x64_linux_hotspot_17.0.11_9.tar.gz \
    && java -version

# 默认使用JDK17，可通过环境变量切换
ENV JAVA_HOME="/usr/lib/jvm/java-17-openjdk" \
    JAVA="/usr/lib/jvm/java-17-openjdk/bin/java"

RUN yum autoremove -y wget \
    && ln -snf /usr/share/zoneinfo/$TIME_ZONE /etc/localtime && echo $TIME_ZONE > /etc/timezone \
    && yum clean all




ADD bin/docker-startup.sh bin/docker-startup.sh
ADD conf/application.properties conf/application.properties


# set startup log dir
RUN mkdir -p logs \
	&& cd logs \
	&& touch start.out \
	&& ln -sf /dev/stdout start.out \
	&& ln -sf /dev/stderr start.out
RUN chmod +x bin/docker-startup.sh

EXPOSE 8848
ENTRYPOINT ["bin/docker-startup.sh"]
