#!/bin/bash

source .env

if [ ! -d "$MINECRAFT_FOLDER" ]; then
  echo "Error: The directory $MINECRAFT_FOLDER does not exist!"
  exit 1
fi

if [ ! -d "$ROOT_PATH" ]; then
  echo "Error: The directory $ROOT_PATH does not exist!"
  exit 1
fi

mkdir -p "$BEHAVIOR_DIR"
mkdir -p "$RESOURCE_DIR"

for dir in "$ROOT_PATH/src"/*; do
  if [ -d "$dir" ]; then
    folder_name=$(basename "$dir")

    if [[ "$folder_name" == *"BP"* ]]; then
      target_dir="$BEHAVIOR_DIR/$folder_name"
      echo "Copying $folder_name to $BEHAVIOR_DIR..."
      
      if [ -d "$target_dir" ]; then
        echo "Directory $target_dir already exists. Removing..."
        rm -rf "$target_dir"
      fi

      cp -r "$dir" "$BEHAVIOR_DIR/"
    elif [[ "$folder_name" == *"RP"* ]]; then
      target_dir="$RESOURCE_DIR/$folder_name"
      echo "Copying $folder_name to $RESOURCE_DIR..."
      
      if [ -d "$target_dir" ]; then
        echo "Directory $target_dir already exists. Removing..."
        rm -rf "$target_dir"
      fi

      cp -r "$dir" "$RESOURCE_DIR/"
    else
      echo "Directory $folder_name is not BP or RP. Skipping..."
    fi
  fi
done

echo "Operation completed!"
