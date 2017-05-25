# AR experiments [![Build Status](https://travis-ci.com/barmidrol/AR-API.svg?token=u9ztxSApigp7kgKmap6z&branch=master)](https://travis-ci.com/barmidrol/AR-API)

## Dependencies
  * [RVM](https://rvm.io/)
  * PostgreSQL
  * Ruby 3.2.1

## Installation
  * `bundle install` from the root of the project
  * `bundle ex rake db:create db:migrate`
  * Specify `SECRET_KEY_BASE` and `GOOGLE_MAP_API_KEY` env variables
  * `rails s`
  * Visit `localhost:3000`
  * Enjoy!

## Linter
There's `.rubocop.yml` file in the root which is necessary for `rubocop` to inspect files.
To run linter, type `rubocop` from the root of the project

## Deployment
Automatic deployment from the `master` branch is enabled. Note that build must pass `TravisCI` before it will be deployed.
