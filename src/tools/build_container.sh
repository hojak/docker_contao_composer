#! /bin/sh
set -e

cd src
cp contao_base/composer* docker/
cd docker

docker build . -t dev-contao:latest

rm composer.json composer.lock
