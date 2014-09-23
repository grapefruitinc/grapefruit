#!/bin/bash

if [[ $TRAVIS_BRANCH == 'dev' ]]; then
  RAILS_ENV=development bundle exec rake db:reset --trace
  cap stage1 deploy
fi
