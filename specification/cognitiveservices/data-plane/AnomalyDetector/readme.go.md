## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  namespace: anomalydetector
  clear-output-folder: true

directive:
  # Replace the default client constructor with the one that enables TLS renegotiation.
  - from: client.go
    where: $
    transform: >-
      return $.
        replace( /"context"/g, "\"context\"\n\"crypto/tls\"" ).
        replace( /autorest\.NewClientWithUserAgent\(UserAgent\(\)\)/g, "autorest.NewClientWithOptions(autorest.ClientOptions{UserAgent: UserAgent(), Renegotiation: tls.RenegotiateFreelyAsClient})" )
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: release_1_0
```

### Tag: release_1_0 and go

These settings apply only when `--tag=release_1_0 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'release_1_0' && $(go)
output-folder: $(go-sdk-folder)/services/preview/cognitiveservices/v1.0/$(namespace)
```
