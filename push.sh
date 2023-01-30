#!/bin/bash

set -e
set -x

cd $(cd `dirname $0`;pwd)

mkdocs gh-deploy

git add --all
git commit -am "quick commit"
git pull --rebase
git push
