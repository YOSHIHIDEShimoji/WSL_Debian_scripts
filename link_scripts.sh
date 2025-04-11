#!/bin/bash

SCRIPT_DIR="$HOME/scripts"
TARGET_DIR="$HOME/.local/bin"

echo "$SCRIPT_DIR 以下の .sh スクリプトを $TARGET_DIR にリンクします（拡張子なし）..."

# ディレクトリが存在するか確認
if [ ! -d "$SCRIPT_DIR" ]; then
  echo "エラー: $SCRIPT_DIR が存在しません。"
  exit 1
fi

mkdir -p "$TARGET_DIR"

# .sh ファイルを再帰的に探してリンク
find "$SCRIPT_DIR" -type f -name "*.sh" | while read -r filepath; do
  filename=$(basename "$filepath" .sh)  # 拡張子を除く
  linkpath="$TARGET_DIR/$filename"
  ln -sf "$filepath" "$linkpath"
  echo "$filename をリンクしました"
done

echo "リンク作成が完了しました。"
