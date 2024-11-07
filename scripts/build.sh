#!/bin/bash

if [ ! -f .env ]; then
  echo "Error: The .env file was not found!"
  exit 1
fi

source .env

if [ -z "$ROOT_PATH" ]; then
  echo "Error: The ROOT_PATH variable is not defined in the .env file!"
  exit 1
fi

if [ ! -d "$ROOT_PATH/src" ]; then
  echo "Error: The directory $ROOT_PATH/src does not exist!"
  exit 1
fi

if [ ! -d "$ROOT_PATH/build" ]; then
  echo "Directory $ROOT_PATH/build not found. Creating..."
  mkdir -p "$ROOT_PATH/build"
fi

current_date=$(date +%Y-%m-%d)

zip_file="$ROOT_PATH/build/build$current_date.zip"

echo "Compressing files to $zip_file..."

(cd "$ROOT_PATH/src" && find . -type f | zip -r "$zip_file" -@ -b "$ROOT_PATH/build/")

if [ $? -eq 0 ]; then
  echo "Backup created successfully: $zip_file"
else
  echo "Error: Failed to create the zip file."
  exit 1
fi
