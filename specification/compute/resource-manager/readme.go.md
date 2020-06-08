## Go

These settings apply only when `--go` is specified on the command line.

```yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  clear-output-folder: true

directive:
    # dynamically add a DummyOrchestrationServiceName value to the enum 
  - from: compute.json
    where: $..enum
    transform: >-
      if( $.length === 1 && $[0] === "AutomaticRepairs") { 
        $.push('DummyOrchestrationServiceName');
      }
      return $;

  - from: source-file-go
    where: $ 
    transform: >-
      return $.
        replace(/\/\/ DummyOrchestrationServiceName .../g,'').
        replace(/DummyOrchestrationServiceName OrchestrationServiceNames = "DummyOrchestrationServiceName"\n/g,'').
        replace(/,DummyOrchestrationServiceName/,'').
        replace(/, 'DummyOrchestrationServiceName'/,'');
```

### Go multi-api

```yaml $(go) && $(multiapi)
batch:
  - tag: package-2019-12-01
  - tag: package-2019-07
  - tag: package-2019-03-01
  - tag: package-2018-10-01
  - tag: package-2018-06
  - tag: package-compute-2018-04
  - tag: package-compute-2017-12
  - tag: package-compute-2017-03
  - tag: package-compute-2016-04-preview
  - tag: package-compute-2016-03
  - tag: package-compute-2015-06
  - tag: package-skus-2017-09
  - tag: package-container-service-2017-01
  - tag: package-container-service-2016-09
  - tag: package-container-service-2016-03
  - tag: package-container-service-2015-11-preview
```

### Tag: package-2019-12-01 and go

These settings apply only when `--tag=package-2019-12-01 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag)=='package-2019-12-01' && $(go)
namespace: compute
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2019-12-01/$(namespace)
```

### Tag: package-2019-07 and go

These settings apply only when `--tag=package-2019-07 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag)=='package-2019-07' && $(go)
namespace: compute
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2019-07-01/$(namespace)
```

### Tag: package-2019-03-01 and go

These settings apply only when `--tag=package-2019-03-01 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag)=='package-2019-03-01' && $(go)
namespace: compute
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2019-03-01/$(namespace)
```

### Tag: package-2018-10-01 and go

These settings apply only when `--tag=package-2018-10-01 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag)=='package-2018-10-01' && $(go)
namespace: compute
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2018-10-01/$(namespace)
```

### Tag: package-2018-06 and go

These settings apply only when `--tag=package-2018-06 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag)=='package-2018-06' && $(go)
namespace: compute
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2018-06-01/$(namespace)
```

### Tag: package-compute-2018-04 and go

These settings apply only when `--tag=package-compute-2018-04 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag)=='package-compute-2018-04' && $(go)
namespace: compute
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2018-04-01/$(namespace)
```

### Tag: package-compute-2017-12 and go

These settings apply only when `--tag=package-compute-2017-12 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag)=='package-compute-2017-12' && $(go)
namespace: compute
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2017-12-01/$(namespace)
```

### Tag: package-compute-2017-03 and go

These settings apply only when `--tag=package-compute-2017-03 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag)=='package-compute-2017-03' && $(go)
namespace: compute
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2017-03-30/$(namespace)
```

### Tag: package-compute-2016-04-preview and go

These settings apply only when `--tag=package-compute-2016-04-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag)=='package-compute-2016-04-preview' && $(go)
namespace: compute
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2016-04-30-preview/$(namespace)
```

### Tag: package-compute-2016-03 and go

These settings apply only when `--tag=package-compute-2016-03 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag)=='package-compute-2016-03' && $(go)
namespace: compute
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2016-03-30/$(namespace)
```

### Tag: package-compute-2015-06 and go

These settings apply only when `--tag=package-compute-2015-06 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag)=='package-compute-2015-06' && $(go)
namespace: compute
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2015-06-15/$(namespace)
```

### Tag: package-skus-2017-09 and go

These settings apply only when `--tag=package-skus-2017-09 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag)=='package-skus-2017-09' && $(go)
namespace: skus
output-folder: $(go-sdk-folder)/services/compute/mgmt/2017-09-01/$(namespace)
```

### Tag: package-container-service-2017-01 and go

These settings apply only when `--tag=package-container-service-2017-01 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag)=='package-container-service-2017-01' && $(go)
namespace: containerservice
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2017-01-31/$(namespace)
```

### Tag: package-container-service-2016-09 and go

These settings apply only when `--tag=package-container-service-2016-09 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag)=='package-container-service-2016-09' && $(go)
namespace: containerservice
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2016-09-30/$(namespace)
```

### Tag: package-container-service-2016-03 and go

These settings apply only when `--tag=package-container-service-2016-03 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag)=='package-container-service-2016-03' && $(go)
namespace: containerservice
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2016-03-30/$(namespace)
```

### Tag: package-container-service-2015-11-preview and go

These settings apply only when `--tag=package-container-service-2015-11-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag)=='package-container-service-2015-11-preview' && $(go)
namespace: containerservice
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2015-11-01-preview/$(namespace)
```
