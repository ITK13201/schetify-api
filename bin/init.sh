#!/bin/bash -x

RELATIVE_PROJECT_DIR_PATH=..
PROJECT_DIR=$(cd $(dirname $0);cd $RELATIVE_PROJECT_DIR_PATH; pwd)

# init environment variables
cp -v ${PROJECT_DIR}/backend/.env.example ${PROJECT_DIR}/backend/.env

# init mysql log files
mkdir -p ${PROJECT_DIR}/log/mysql
touch ${PROJECT_DIR}/log/mysql/mysqld.log

# init log file permission
find ${PROJECT_DIR}/log -type f -print | xargs chmod 666
