## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: ContentSafetyStudio
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
  - tag: release_2023-04-30-preview
```

### Tag: release_2023_04_30_preview and go

These settings apply only when `--tag=release_2023_04_30_preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'release_2023_04_30_preview' && $(go)
output-folder: $(go-sdk-folder)/services/cognitiveservices/2023_04_30_preview/$(namespace)
```
