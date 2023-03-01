#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install
#bundle exec rake assets:precompile - we shouldn't need these for api-only
#bundle exec rake assets:clean - we shouldn't need these for api-only
bundle exec rake db:migrate