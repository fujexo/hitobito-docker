#!/bin/bash

bundle exec rake db:create
bundle exec rake db:setup:all

bundle exec rails server -b 0.0.0.0 -p 80
