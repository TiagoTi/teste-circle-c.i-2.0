#!/bin/bash

# Este script gera commits e branches
# A intenção é treinar com o circle c.i lhida com visões baseada em com tag

VERSAO=$(cat ./versao)


echo $VERSAO

VERSAO=$(( $VERSAO + 1 ))
RELEASE=0
TAG=0


if [ $(( $VERSAO % 2 )) = 0 ]
then
	echo "TAG"
	TAG=$(( $VERSAO / 2 ))
	git add .
	echo $TAG >> tags
	echo $VERSAO >> changelog.txt
	git commit -m "versao: 0.0.$VERSAO"
	git push
	git tag -a "v0.$TAG.$VERSAO"  -m "tag-version: 0.$TAG.$VERSAO"
	git push --tags
else
	echo "RELEASE"
	RELEASE="release-0.$RELEASE.$VERSAO"
	git checkout -b $RELEASE
	echo $RELEASE >> release
	echo $RELEASE >> changelog.txt
	git add .
	git commit -m "versao: 0.0.$VERSAO"
	git push --set-upstream origin $RELEASE
	git checkout master
	git branch -D $RELEASE
fi

echo $VERSAO
echo $VERSAO > ./versao 
