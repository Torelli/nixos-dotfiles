#!/bin/sh
grim -g "$(slurp)" ~/.cache/ocr.png && tesseract -l eng+rus ~/.cache/ocr.png stdout | wl-copy
rm ~/.cache/ocr.png
