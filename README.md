# 文本转语音服务 (TTS Service)

这是一个基于Flask和腾讯云TTS API的文本转语音服务，可以将输入的文本转换为语音文件。

## 功能特点

- 支持多种音色选择（女声、男声、情感音色等）
- 简洁直观的用户界面
- 实时语音合成和播放

## 本地开发环境配置

### 依赖安装

```bash
pip install -r requirements.txt
```

### 运行开发服务器

```bash
python app.py
```

服务将在 http://127.0.0.1:5000 上运行。

## 生产环境部署

### 使用Supervisor管理服务

1. 安装Supervisor

```bash
sudo apt-get update
sudo apt-get install supervisor
```

2. 创建Supervisor配置文件

```bash
sudo nano /etc/supervisor/conf.d/tts-service.conf
```

将以下内容复制到配置文件中（注意修改路径）：

```ini
[program:tts-service]
command=/path/to/venv/bin/gunicorn -w 4 -b 0.0.0.0:5000 app:app
directory=/var/www/tts-service
user=www-data
autostart=true
autorestart=true
stdout_logfile=/var/log/tts-service/gunicorn.log
stderr_logfile=/var/log/tts-service/gunicorn_error.log
environment=PATH="/path/to/venv/bin"
```

3. 创建日志目录

```bash
sudo mkdir -p /var/log/tts-service
sudo chown www-data:www-data /var/log/tts-service
```

4. 重新加载Supervisor配置

```bash
sudo supervisorctl reread
sudo supervisorctl update
```

5. 启动服务

```bash
sudo supervisorctl start tts-service
```

### 常见问题排查

#### 服务无法启动

检查Supervisor配置文件中的服务名称是否正确：

```bash
# 查看所有服务
sudo supervisorctl status

# 重启服务（注意服务名称中的连字符）
sudo supervisorctl restart tts-service
```

注意：服务名称应与配置文件中的program名称一致，如果配置文件中使用的是`[program:tts-service]`，则重启命令应为`sudo supervisorctl restart tts-service`。

#### 查看日志

```bash
# 查看标准输出日志
sudo tail -f /var/log/tts-service/gunicorn.log

# 查看错误日志
sudo tail -f /var/log/tts-service/gunicorn_error.log
```

## 注意事项

- 请确保腾讯云API密钥配置正确
- 生产环境中建议使用HTTPS保护API请求
- 避免在开发服务器和Supervisor管理的服务同时运行，以防止端口冲突