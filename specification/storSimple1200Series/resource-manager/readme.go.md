## Go

These settings apply only when `--go` is specified on the command line.

```yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  namespace: storsimple
  clear-output-folder: true
```

### Go multi-api

```yaml $(go) && $(multiapi)
batch:
  - tag: package-2016-10
```

### Tag: package-2016-10 and go

These settings apply only when `--tag=package-2016-10 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-2016-10' && $(go)
output-folder: $(go-sdk-folder)/services/storsimple1200series/mgmt/2016-10-01/$(namespace)
```
