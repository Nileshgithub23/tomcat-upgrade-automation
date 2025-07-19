#!/bin/bash

TOMCAT_DIR="/opt/tomcat/latest"
CATALINA_JAR="$TOMCAT_DIR/lib/catalina.jar"

if [ ! -f "$CATALINA_JAR" ]; then
  echo "[ERROR] Tomcat not found at $CATALINA_JAR"
  exit 1
fi

# Check if unzip is available
if ! command -v unzip &>/dev/null; then
  echo "[ERROR] unzip command not found. Please install it: yum install unzip -y"
  exit 2
fi

version=$(unzip -p "$CATALINA_JAR" META-INF/MANIFEST.MF 2>/dev/null | grep "Specification-Version" | awk '{print $2}')

if [ -n "$version" ]; then
  echo "✅ Tomcat Version: $version"
else
  echo "⚠️  Could not determine Tomcat version from $CATALINA_JAR"
  exit 3
fi

