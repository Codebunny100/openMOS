#!/bin/bash

set -e

# === CONFIG ===
VERSION_FILE="version.txt"

# === INIT VERSION FILE IF MISSING ===
if [ ! -f $VERSION_FILE ]; then
  echo "0.0.0" > $VERSION_FILE
fi

# === READ CURRENT VERSION ===
VERSION=$(cat $VERSION_FILE)

# === AUTO INCREMENT PATCH VERSION ===
IFS='.' read -r MAJOR MINOR PATCH <<< "$VERSION"
PATCH=$((PATCH + 1))
NEW_VERSION="$MAJOR.$MINOR.$PATCH"

echo $NEW_VERSION > $VERSION_FILE

# === COMMIT MESSAGE ===
MSG="openMOS v$NEW_VERSION"

# === BUILD openMOS ===
echo "🔧 Building openMOS..."
make clean && make

# === GIT FLOW ===
git add .
git commit -m "$MSG" || echo "No changes to commit"

# Pull safely (avoids your earlier errors)
git pull origin main --rebase || true

# Push
git push origin main

# OPTIONAL: create a Git tag
git tag "v$NEW_VERSION"
git push origin "v$NEW_VERSION"

echo "🚀 Deployed version $NEW_VERSION"