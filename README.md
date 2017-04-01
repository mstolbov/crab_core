[![CircleCI](https://circleci.com/gh/mstolbov/crab_core.svg?style=svg)](https://circleci.com/gh/mstolbov/crab_core)
[![Coverage](https://coveralls.io/repos/github/mstolbov/crab_core/badge.svg?branch=master)](https://coveralls.io/github/mstolbov/crab_core?branch=master)

# Crab Core
Simple Scrabble Scorer

## Run server
`bin/server -o 0.0.0.0 -p 8080`

## Usage
```sh
> curl -X GET 'http://localhost:8080/score/lala'
{"word":"lala","valid":false}
```
