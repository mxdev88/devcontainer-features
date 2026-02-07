## Running the Gateway

```sh
cd /opt/ibkr/api-gw
./bin/run.sh
```

The Web API will be available on http://localhost:5000.

## Authentication

Authentication is handled via the Gateway’s browser-based login.
Credentials are never stored by this feature.

## Notes

Supports both paper and live trading (account dependent)

The Gateway must remain running while using the API.

## OS Support

This Feature should work on recent versions of Debian/Ubuntu-based distributions with the `apt` package manager installed.

`bash` is required to execute the `install.sh` script.

