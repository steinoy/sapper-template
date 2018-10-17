#!/bin/bash
cd $(dirname $0)/..

# make sure we're on master, and delete the rollup and webpack branches
git symbolic-ref HEAD refs/heads/master
git reset --hard
git branch -D rollup webpack

# create the rollup branch off the current master
git checkout -b rollup
node _template/build-pkg.js rollup
git rm -r --cached _template package_template.json webpack.config.js
git add package.json
git commit -m 'Sapper template for Rollup'
git symbolic-ref HEAD refs/heads/master
git reset --hard

# create the webpack branch off the current master
git checkout -b webpack
node _template/build-pkg.js webpack
git rm -r --cached _template package_template.json rollup.config.js
git add package.json
git commit -m 'Sapper template for Webpack'
git symbolic-ref HEAD refs/heads/master
git reset --hard

# force push rollup and webpack branches
git push origin rollup -f
git push origin webpack -f
