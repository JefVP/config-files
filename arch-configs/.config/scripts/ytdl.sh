#!/bin/bash
read -p "URL: " url
youtube-dl --extract-audio --audio-format "mp3" --audio-quality "128k" "$url"
unset url
