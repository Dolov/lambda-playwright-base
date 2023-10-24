# lambda-playwright-base
在 aws lambda 运行 playwright 的基础镜像

> 在 aws lambda 运行 playwright 需要安装 playwright 的基础镜像、aws-lambda-ric 以及 aws-lambda-ric 的运行环境。国内网络安装十分缓慢，动辄半个小时。所以上传了一个阿里云镜像以供使用。


### 使用示例
```Dockerfile
FROM registry.cn-hangzhou.aliyuncs.com/clickapaas/lambda-playwright-base:v1.26.1-focal-amd64

WORKDIR /function
COPY app.js package.json ./
RUN mv ../aws-lambda-ric  ./aws-lambda-ric

ENTRYPOINT ["aws-lambda-ric/node_modules/.bin/aws-lambda-ric"]
CMD ["app.handler"]
```

### 说明
aws-lambda-ric 文件夹内是 aws-lambda-ric@3.0.0 版本，如果二次打包镜像无法下载到 aws-lambda-ric，可以将 aws-lambda-ric 复制到镜像中。

