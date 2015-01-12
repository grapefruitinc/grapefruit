#!/bin/bash

cp config/database-example.yml config/database.yml
cp config/settings-demo.yml config/settings.yml
gem install capistrano --no-ri --no-rdoc
