#!/bin/bash

# -m オプションでコミットメッセージを受け取る
while getopts "m:" opt; do
  case "$opt" in
    m) msg="$OPTARG" ;;
    *) echo "Usage: $0 [-m commit_message]"; exit 1 ;;
  esac
done

# Gitリポジトリかどうか確認
if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
  echo "このディレクトリはGitリポジトリではありません。"
  exit 1
fi

# Gitルートディレクトリに移動
cd "$(git rev-parse --show-toplevel)" || {
  echo "Gitルートへの移動に失敗しました。"
  exit 1
}

# ステータス表示
echo "=== Git Status ==="
git status

# 先に変更をステージング
git add .

# ステージされた変更がなければ終了
if git diff --cached --quiet; then
  echo "変更がないため、何もpushしませんでした。"
  exit 0
fi

# コミットメッセージの確認
if [ -z "$msg" ]; then
  echo ""
  read -p "コミットメッセージを入力してください: " msg
fi

# Git操作
git commit -m "$msg"
git push

echo ""
echo "pushが完了しました"
