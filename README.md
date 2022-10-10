# Contao & Docker
Tools and setup for running contao in a docker based environment for developing extentions or setting up a website.

## Build the docker image

```bash
tools/build_container.sh
```

## Run the Complete Setup

_hint_: currently does not run under Windows due to problems with the standard databse image (mysql).

```bash
cd src/docker-compose
docker-compose up -d
```
