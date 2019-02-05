#!/bin/sh
cd /code

# let the postgres container create the db
sleep 5

invoke app.db.upgrade
invoke app.run