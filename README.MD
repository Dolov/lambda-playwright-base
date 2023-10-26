# lambda-playwright-base
在 aws lambda 运行 playwright 的基础镜像

> 在 aws lambda 运行 playwright 需要安装 playwright 的基础镜像、aws-lambda-ric 以及 aws-lambda-ric 的运行环境。国内网络安装十分缓慢，动辄半个小时。所以上传了一个阿里云镜像以供使用。


### 使用示例
```Dockerfile
FROM registry.cn-hangzhou.aliyuncs.com/clickapaas/lambda-playwright-base:v1.39.0-focal

WORKDIR /APP
COPY index.js package.json ./
RUN mv ../aws-lambda-ric ./aws-lambda-ric
RUN npm config set registry https://registry.npm.taobao.org && npm i yarn -g && yarn
ENTRYPOINT ["node", "aws-lambda-ric/aws-lambda-ric/bin/index.mjs"]
CMD ["index.handler"]

```

### 说明
1. aws-lambda-ric 文件夹内是 aws-lambda-ric@3.0.0 版本。如果需要其他版本，可以自行下载、或者在 Dockerfile 中自行安装。
2. 构建镜像时务必要打成 --platform linux/amd64 架构，示例：docker build --platform linux/amd64 -t docker-image:test .
3. 启动 chrome 时的必要参数，否则在 lambda 环境会异常报错。
```js
const browser = await chromium.launch({
    headless: true,
    args: ['--no-sandbox', '--disable-setuid-sandbox', '--single-process']
})
```
4. lambda 环境默认只有 /tmp 文件夹有写入权限。
5. 如果要生成测试报告，需要指定输入目录。
```js
const cmd = 'PLAYWRIGHT_HTML_REPORT=/tmp/html-report node node_modules/.bin/playwright test --output=/tmp/test-results'
child_process.exec(cmd, (error, stdout) => {
    console.log('stdout: ', stdout);
    console.log('error: ', error);
})
```