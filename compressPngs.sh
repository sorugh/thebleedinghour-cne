#!/bin/bash
find . -type f -name "*.png" -exec oxipng -o max --strip all --alpha {} \;
