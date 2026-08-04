#!/bin/bash
# 推送 ghpages 到 GitHub（访问码从同目录 .gh_token 读取，不写死在脚本里）
set -e
DIR="$(cd "$(dirname "$0")" && pwd)"
TOKEN="$(cat "$DIR/.gh_token")"
cd "$DIR"
git push "https://cuicycycy:${TOKEN}@github.com/cuicycycy/zongbu.git" main
