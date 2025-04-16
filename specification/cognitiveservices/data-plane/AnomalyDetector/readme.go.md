## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_MIT_NO_VERSION
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
