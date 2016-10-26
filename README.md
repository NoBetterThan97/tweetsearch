# Twitter API

[![Build Status](https://travis-ci.org/NoBetterThan97/tweetsearch.svg?branch=master)](https://travis-ci.org/NoBetterThan97/tweetsearch)

:hammer: Everything from scratch

## Usage

1. Get application access token

  - Fill in `api_key` and `api_secret` in `config/credentials.yml`
  - Run `rake util:access_token`
  - Fill in the `access_token` in `config/credentials.yml`

2. Run tests

  ```bash
  $ bundle exec rake test
  ```

3. Run quality tests

  ```bash
  $ bundle exec rake quality
  ```
