#!/bin/bash

TOMCAT_BASE="/opt/tomcat"
OLD_LINK="$TOMCAT_BASE/latest"
BACKUP_DIR="$TOMCAT_BASE/backup_$(date +%F-%H-%M-%S)"
NEW_VERSION="9.0.85"
NEW_TOMCAT_FOLDER="apache-tomcat-$NEW_VERSION"
NEW_TOMCAT_ARCHIVE="$NEW_TOMCAT_FOLDER.tar.gz"
NEW_TOMCAT_URL="https://downloads.apache.org/tomcat/tomcat-9/v$NEW_VERSION/bin/$NEW_TOMCAT_ARCHIVE"

echo "🔄 Starting Tomcat upgrade to version $NEW_VERSION"

# Stop Tomcat
if [ -x "$OLD_LINK/bin/shutdown.sh" ]; then
  echo "⛔ Stopping old Tomcat..."
  "$OLD_LINK/bin/shutdown.sh"
  sleep 5
else
  echo "[WARNING] Shutdown script not found at $OLD_LINK"
fi

# Backup current install
if [ -d "$OLD_LINK" ]; then
  echo "📦 Backing up $OLD_LINK to $BACKUP_DIR"
  mv "$OLD_LINK" "$BACKUP_DIR"
else
  echo "[WARNING] No existing Tomcat found to back up."
fi

# Download new version if not already present
cd "$TOMCAT_BASE" || exit 1

if [ ! -f "$NEW_TOMCAT_ARCHIVE" ]; then
  echo "⬇️  Downloading $NEW_TOMCAT_URL"
  wget "$NEW_TOMCAT_URL"
else
  echo "[INFO] Archive already exists, skipping download."
fi

# Extract
if [ ! -d "$TOMCAT_BASE/$NEW_TOMCAT_FOLDER" ]; then
  echo "📂 Extracting $NEW_TOMCAT_ARCHIVE"
  tar -xzf "$NEW_TOMCAT_ARCHIVE"
else
  echo "[INFO] $NEW_TOMCAT_FOLDER already extracted, skipping."
fi

# Create symlink
ln -sfn "$TOMCAT_BASE/$NEW_TOMCAT_FOLDER" "$OLD_LINK"

# Start new Tomcat
echo "▶️ Starting new Tomcat..."
"$OLD_LINK/bin/startup.sh"

echo "✅ Tomcat upgrade completed!"

