# Twitter API

:hammer: Everything from scratch

## Usage

1. Get application access token

  - Fill in `api_key` and `api_secret` in `config/credentials.yml`
  - Run `rake util:access_token`
  - Fill in the `access_token` in `config/credentials.yml`

2. Run tests

  ```bash
  $ rake test
  ```

3. Run quality tests

  ```bash
  $ rake quality
  ```
