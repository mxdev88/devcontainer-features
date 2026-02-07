
# IBKR Client Portal API Gateway (ibkr-api-gw)

This devcontainer feature installs the **Interactive Brokers Client Portal API Gateway**, a Java-based service that exposes REST and WebSocket APIs for IBKR accounts.

## Example Usage

```json
"features": {
    "ghcr.io/mxdev88/devcontainer-features/ibkr-api-gw:1": {}
}
```



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



---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/mxdev88/devcontainer-features/blob/main/src/ibkr-api-gw/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
