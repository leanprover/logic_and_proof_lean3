#!/usr/bin/env bash
set -e
if [ "$#" -ne 2 ]; then
    echo "Usage example: $0 leanprover logic_and_proof"
    exit 1
fi

# Build
make clean images html latexpdf

# 3. Deploy
rm -rf deploy
mkdir deploy
cd deploy
git init
cp -r ../_build/html/./ .
cp ../_build/latex/logic_and_proof.pdf .
git add .
git commit -m "Update `date`"
git push git@github.com:$1/$2 +HEAD:gh-pages
cd ../
rm -rf deploy
