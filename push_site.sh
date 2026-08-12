#!/bin/bash
# 推送 ghpages 到 GitHub（令牌从同目录 .gh_token 读取，不写死在脚本里）
# 加固：github.com 网络抖动时不再挂死 —— 每次 push 硬性限时（低速 25s 即断），失败最多重试 6 次。
DIR="$(cd "$(dirname "$0")" && pwd)"
TOKEN="$(cat "$DIR/.gh_token")"
cd "$DIR" || exit 1
URL="https://cuicycycy:${TOKEN}@github.com/cuicycycy/zongbu.git"

for i in 1 2 3 4 5 6; do
  OUT=$(GIT_TERMINAL_PROMPT=0 git -c http.lowSpeedLimit=1000 -c http.lowSpeedTime=25 push "$URL" main 2>&1)
  RC=$?                                  # 必须这样取退出码；`cmd | tail` 后的 $? 恒为 0 会假报成功
  echo "try$i rc=$RC :: $(echo "$OUT" | sed "s#${TOKEN}#***#g" | tr '\n' ' ')"
  [ $RC -eq 0 ] && { echo "PUSH_SUCCESS"; exit 0; }
done

echo "PUSH_FAILED after 6 tries"
exit 1
