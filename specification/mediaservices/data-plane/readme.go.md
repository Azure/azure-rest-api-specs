## Go

These settings apply only when `--go` is specified on the command line.

```yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  namespace: lvaEdge-client
  clear-output-folder: true
```

``` yaml $(tag) == 'package-lva-1-0-0-preview' && $(go)
output-folder: $(go-sdk-folder)/services/mediaservices/package-lva-1-0-0-preview/$(namespace)
```