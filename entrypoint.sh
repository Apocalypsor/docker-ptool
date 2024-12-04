#!/bin/bash

touch /config/ptool.toml
[ -f /config/brush.sh ] || echo "#!/bin/bash" >/config/brush.sh

# 打印启动信息
echo "Starting crond and running periodic tasks..."

chmod +x /config/brush.sh

bash /config/brush.sh

touch /var/log/cron.log

# 启动 cron 服务
# -f: 前台运行
# -l 8: 设置日志级别为 8 (DEBUG)
crond -f -l 8 &
CRON_PID=$!

# 将 /var/log/cron.log 输出到容器日志
tail -f /var/log/cron.log &

# 捕获退出信号
trap "echo 'Stopping container...'; kill $CRON_PID; exit 0" SIGTERM SIGINT

# 保持脚本运行
wait $CRON_PID
