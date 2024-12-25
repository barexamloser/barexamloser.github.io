#!/bin/bash

# Function to display usage
usage() {
    echo "Usage: $0 'Post Title' 'Tags (comma-separated, optional)'"
    exit 1
}

# Check if a title is provided
if [ -z "$1" ]; then
    usage
fi

# Variables
TITLE="$1"
DATE=$(date '+%Y-%m-%d')
TIME=$(date '+%Y-%m-%d %H:%M:%S %z')
FILENAME="${DATE}-$(echo "$TITLE" | tr ' ' '-' | tr '[:upper:]' '[:lower:]').md"
POSTS_DIR="_posts"

# Ensure the _posts directory exists
if [ ! -d "$POSTS_DIR" ]; then
    mkdir -p "$POSTS_DIR"
    echo "Created directory: $POSTS_DIR"
fi

# Process tags if provided
if [ -n "$2" ]; then
    TAGS=$(echo "$2" | tr ',' '\n' | awk '{print $1}' | paste -sd ',' -)
else
    TAGS="life"
fi

HEADER="---
layout: post
title:  \"$TITLE\"
date:   $DATE $(date '+%H:%M:%S %z')
tags: [$TAGS]
---
"

# Create the file in _posts folder
FILEPATH="${POSTS_DIR}/${FILENAME}"
echo "$HEADER" > "$FILEPATH"

# Notify the user
echo "Blog post created: $FILEPATH"
