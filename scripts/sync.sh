#!/bin/bash

TMP_DIR="$(pwd)/.tmp/semantic-ui"
SRC_PATH="${TMP_DIR}/src"
DEST_PATH="$(pwd)/src/semantic-ui"
UPSTREAM_REPO="https://github.com/Semantic-Org/Semantic-UI.git"
LESS2STYLUS="$(pwd)/node_modules/.bin/less2stylus"

mkdir -p $TMP_DIR

# echo "Cloning ${UPSTREAM_REPO}..."
git clone --depth 1 $UPSTREAM_REPO $TMP_DIR;


echo "Process .less files..."
echo $SRC_PATH
cd $SRC_PATH

# Default config
cp theme.config.example theme.config.less

# Rename files to stylus
for file in `find -E . -type f -regex ".*\.(less|variables|overrides)"`; do
  echo "Convert ${file}"
  $LESS2STYLUS $file --variable-name-prefix ui_ > "$(dirname $file)/$(basename "$file" .less).styl"
done

# for file in `find . -name '*.styl'`; do
#   echo "Let's do some codemon"
# done

echo "Copy files"
for file in `find -E . -type f -regex ".*\.(styl|svg|png|jpg|eot|ttf|woff)"`; do
  rsync -R $file $DEST_PATH
done

# echo "Remove temporary folder..."
rm -fr $TMP_DIR
