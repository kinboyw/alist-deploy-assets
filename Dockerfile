# 使用 Debian 作为基础镜像
FROM debian:buster-slim

# 替换为清华大学镜像源
RUN sed -i 's/deb.debian.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list && \
    sed -i 's/security.debian.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list

# 更新包列表并安装必要的依赖
RUN apt-get update && apt-get install -y \
    libpthread-stubs0-dev \
    libc6 \
    && rm -rf /var/lib/apt/lists/*

# 将本地的 alist-proxy 文件复制到镜像内的 /bin/ 目录下
COPY ./alist-proxy /bin/alist-proxy

# 确保 alist-proxy 文件具有执行权限
RUN chmod +x /bin/alist-proxy

# 验证文件是否存在并有执行权限
RUN ls -l /bin/alist-proxy

# 检查 alist-proxy 的依赖项
RUN ldd /bin/alist-proxy || echo "No shared library dependencies found"

# 设置默认环境变量
ENV ALIST_ADDRESS=""
ENV ALIST_TOKEN=""
ENV ALIST_PROXY_PORT="5243"

# 设置工作目录
WORKDIR /bin

# 暴露端口，默认端口为 5243
EXPOSE ${ALIST_PROXY_PORT}

#ENTRYPOINT [ "/bin/alist-proxy" ]
# 启动命令
CMD ["sh", "-c", "echo [port:${ALIST_PROXY_PORT}, address:${ALIST_ADDRESS}, token:${ALIST_TOKEN}] && /bin/alist-proxy -port ${ALIST_PROXY_PORT} -address ${ALIST_ADDRESS} -token ${ALIST_TOKEN}"]