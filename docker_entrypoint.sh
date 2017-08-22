#!/bin/bash

bundle check > /dev/null 2>&1 || bundle install

if [ "$#" == 0 ]
then
  bundle exec middleman --port=3000
fi

exec $@
