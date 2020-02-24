#!/bin/bash
# JAR包版本号
JAR_VERSION="0.0.1"
# JAR包端口号
JAR_PORT=8082
# 私服仓库地址
REGISTRY_URL=47.115.142.193:5000
# 镜像名称
IMAGE_NAME="$WORKSPACE:$JAR_VERSION"
# 容器名称
CONTAINER_NAME=$WORKSPACE

# 构建docker镜像
docker build -t $IMAGE_NAME .

# 推送docker镜像
docker push $REGISTRY_URL/$IMAGE_NAME

# 删除同名docker容器
cid=$(docker ps | grep "$CONTAINER_NAME" | awk '{print $1}')
if [ "$cid" != "" ]; then
	 docker stop $cid
   docker rm -f $cid
fi

# 启动docker 容器
docker run --restart=always --privileged=true -d -p $JAR_PORT:$JAR_PORT --name $CONTAINER_NAME $IMAGE_NAME