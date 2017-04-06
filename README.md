[![CircleCI](https://circleci.com/gh/mstolbov/crab_core.svg?style=svg)](https://circleci.com/gh/mstolbov/crab_core)
[![Coverage](https://coveralls.io/repos/github/mstolbov/crab_core/badge.svg?branch=master)](https://coveralls.io/github/mstolbov/crab_core?branch=master)

# Crab Core
Simple Scrabble Scorer

## Try
Service was deployed on `heroku`, so here you can try it.
```sh
https://crab-core.herokuapp.com/score/aa
```
Heroku dictionary contais first 10000 words only (tariff plan
restriction).

## Run manualy

### Dependencies
Scorer written on ruby, so you need install ruby interpreter. I
recommend to use [rbenv](https://github.com/rbenv/rbenv#installation) to
install ruby. You can use rvm or install ruby from image, it's up to
you.
To store the dictionary Scorer use SQLite, so you don't have to install
any database server.

### Database Config
Application already have prepared dictionary DB, so you don't have to do
anything else. But if you want to use another DB, you can configure it
in `config/database.yml` file, by default it use `development`
enviropment.

### Prepare to run
After install dependencies but before run Scorer need to execute
following command
- `bundle install` - it will install used gems to ruby

Application already have prepared dictionary DB, so you don't have to do
anything else. If you want to add new words, you can do it by this way:
- `bundle exec rake app:import[':path_to_file']` - it'll read words from
  file and fill it to dictionary DB.

### Run server
Seems that you ready to run application server, the following command to
do it.
`bundle exec bin/server -o 0.0.0.0 -p 8080`

It accept options like host and port, see allowed options in `bin/server
--help`

## Usage
Just simple example to show how to get score of word in console
```sh
> curl -X GET 'http://localhost:8080/score/lala'
{"word":"lala","valid":false}
```

## Tests
Test enviropment should be configured too before run tests. Make sure
that DB configured and test database exists.
To setup database run the following command `RACK_ENV=true bundle exec
rake db:setup`, it will create database and table to store dictionary.
Btw, you don't have to import the dectionary to run tests.

Funnaly, run tests
```sh
bundle exec rake test
```
or just
```sh
bundle exec rake
```
`test` is default command to `rake`, so you don't have to pass it each
time.
