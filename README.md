[![CircleCI](https://circleci.com/gh/mstolbov/crab_core.svg?style=svg)](https://circleci.com/gh/mstolbov/crab_core)
[![Coverage](https://coveralls.io/repos/github/mstolbov/crab_core/badge.svg?branch=master)](https://coveralls.io/github/mstolbov/crab_core?branch=master)

# Crab Core
Simple Scrabble Scorer

## Try
Service was deployed on `heroku`, so here you can try it.
```sh
https://crab-core.herokuapp.com/score/aa
```
But the dictionary in there contais only first 10000 words (tariff plan
restriction).

## Run manualy

### Dependencies
Scorer written on ruby, so you need install ruby interpreter. I
recommend to use [rbenv](https://github.com/rbenv/rbenv#installation) to
install ruby. You can use rvm or install ruby from image, it's up to
you.
To store the dictionary Scorer use Postgresql.

### Database Config
To make the applications work with DB, you have to configure
credentials. You can do it in DB config file.
DB config is in `config/database.yml`, by default it use `development`
enviropment.

### Prepare to run
After install dependencies but before run Scorer need to execute few
following command
- `bundle install` - it will install used gems to ruby
- `bundle exec rake db:setup` - it will create database and table to
  store dictionary
- `bundle exec rake app:import['import/sowpods.txt']` - it'll import
  dictionary to DB. It's long action, so just wait. `import/sowpods.txt`
it's path where it takes data to import, you can change it to another
file or run it to inport new words.

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

Funnaly , run tests
```sh
bundle exec rake test
```
or just
```sh
bundle exec rake
```
`test` is default command to `rake`, so you don't have to pass it each
time.
