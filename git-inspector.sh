#!/bin/bash

# Check if a path was passed
if [ -z "$1" ]; then
  echo "Usage: $0 /path/to/git/repo"
  exit 1
fi

REPO_PATH="$1"

# Check if it's a valid Git repo
if [ ! -d "$REPO_PATH/.git" ]; then
  echo "Error: '$REPO_PATH' is not a valid Git repository."
  exit 2
fi

cd "$REPO_PATH" || exit

echo "===== GIT REPOSITORY SNAPSHOT ====="
echo "Repository Path: $(pwd)"
echo "Repository Name: $(basename $(pwd))"
echo "Current Branch: $(git rev-parse --abbrev-ref HEAD)"
echo ""

echo "----- Last 5 Commits -----"
git log -5 --oneline --graph
echo ""

echo "----- Uncommitted Changes -----"
git status --short
echo ""

echo "----- Staged Files -----"
git diff --cached --name-only
echo ""

echo "----- Top Contributors -----"
git shortlog -sne
echo ""

echo "----- Remote URL -----"
git remote get-url origin 2>/dev/null || echo "No remote found"
echo ""

echo "----- Git Config (User) -----"
git config user.name
git config user.email
