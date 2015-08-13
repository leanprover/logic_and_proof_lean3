#!/usr/bin/env bash
if [ "$#" -ne 2 ]; then
    echo "Usage example: $0 leanprover logic_and_proof"
    exit 1
fi

# 1. Check minify
MINIFY=`pwd`/node_modules/minify/bin/minify.js
hash ${MINIFY} 2>/dev/null || { echo >&2 "minify is not found at ${MINIFY}. Run 'npm install minify' to install it."; exit 1; }

# 2. Build
make
make build_nav_data

# 3. Deploy
mkdir deploy
cd deploy
rm -rf *
git init
cp ../*.html ../logic_and_proof.pdf .
cp -r ../css ../images ../fonts ../js ../ltxpng .
for CSS in css/*.css
do
    ${MINIFY} ${CSS} > ${CSS}.min
    mv ${CSS}.min ${CSS}
done
for JS in js/*.js
do
    ${MINIFY} ${JS} > ${JS}.min
    mv ${JS}.min ${JS}
done
git add -f *.html logic_and_proof.pdf
git add -f css/*
git add -f ltxpng/*
git add -f images/*
git add -f fonts/*
git add -f js/*
git commit -m "Update `date`"
git push git@github.com:$1/$2 +HEAD:gh-pages
cd ../
rm -rf deploy
