#!/bin/bash

set -e  # エラーが出たら止める

REPOS=(
  "$HOME/dotfiles"
  "$HOME/projects"
)

for repo in "${REPOS[@]}"; do
  echo "🚀 Pushing $repo"
  cd "$repo"
  git add .
  git commit -m "Auto commit"
  git push
done

echo "✅ All repositories pushed!"
