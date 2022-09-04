# Schetify API

This is a repository of applications created by the team "Back Door" at the hackathon "OPEN HACK U 2022 TOKYO".

## Install

- docker

## Setup

### 1. Clone

```shell
git clone git@github.com:ITK13201/schetify-api.git
cd schetify-api
```

### 2. Init environments

```shell
./bin/init.sh
```

### 3. Edit .env file

Edit the `backend/.env` file as needed.

### 4. Build

```shell
docker compose build
```

## Usage

### Start container

```shell
docker compose up
```

### Stop container

```shell
docker compose down
```

### Logging

```shell
docker compose logs -f
```