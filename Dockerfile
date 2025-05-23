FROM python:3.9-slim

# 设置工作目录
WORKDIR /app

# 设置环境变量
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV TZ=Asia/Shanghai

# 安装依赖
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 复制项目文件
COPY . .

# 设置启动脚本权限
RUN chmod +x /app/docker-entrypoint.sh

# 暴露端口
EXPOSE 5000

# 启动命令
ENTRYPOINT ["/app/docker-entrypoint.sh"]