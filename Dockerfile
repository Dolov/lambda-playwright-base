FROM registry.cn-hangzhou.aliyuncs.com/clickapaas/playwright:v1.39.0-focal

# 更改 apt-get 源，在国内环境阿里云的源安装比较快
RUN cp -ra /etc/apt/sources.list /etc/apt/sources.list.bak && \
  sed -i "s/\(ports\|archive\|security\).ubuntu.com/mirrors.aliyun.com/g" /etc/apt/sources.list && \
  sed -i "/^#/d" /etc/apt/sources.list

# aws-lambda-ric 需要下面这些依赖环境
RUN apt-get update && \
    apt-get install -y \
    g++ \
    make \
    cmake \
    unzip \
    libtool \
    autoconf \
    build-essential \
    libcurl4-openssl-dev

# lambda aws-lambda-ric 是AWS Lambda中的运行时接口（Runtime Interface Client，简称RIC）。它的作用是实现Lambda函数与Lambda运行时（如Java、Python、Node.js等）之间的通信。
# 具体来说，当一个Lambda函数被触发时，Lambda服务会通过调用RIC来启动并运行函数。RIC负责接收Lambda运行时的指令，并执行函数的代码逻辑、处理事件输入以及生成函数的响应结果。同时，它还负责与Lambda服务之间的通信，将函数的请求和响应传递给Lambda服务进行处理。
# 总之，lambda aws-lambda-ric在AWS Lambda中充当着连接Lambda函数和Lambda运行时之间的桥梁，负责函数的执行和与Lambda服务的通信。
# 如果使用了官方镜像可以不使用 aws-lambda-ric，eg.public.ecr.aws/lambda/nodejs:18

WORKDIR /aws-lambda-ric
COPY aws-lambda-ric ./


