#!/bin/bash
git checkout dev
sed -i 's/k8s.jaagalabs.com/oip.dev.code-alpha.org/g' `find . -maxdepth 1 -type f`
git commit -am 'moved to Social Alpha domain'
git push
git checkout master
git merge dev
git push