## Go

These settings apply only when `--go` is specified on the command line.

```yaml $(go) && !$(track2)
go:
  license-header: MICROSOFT_MIT_NO_VERSION
  clear-output-folder: true

directive:
    # dynamically add a DummyOrchestrationServiceName value to the enum and then remove it from the generated code to avoid the generator generates the code by hard-coding the single-entry enum value
    # this directive adds a DummyOrchestrationServiceName to the enum type
  - from: ComputeRP/virtualMachineScaleSet.json
    where: $..enum
    transform: >-
      if( $.length === 1 && $[0] === "AutomaticRepairs") { 
        $.push('DummyOrchestrationServiceName');
      }
      return $;

    # this directive removes the DummyOrchestrationServiceName from the generated code, so that we still have only one enum entry in this enum type.
  - from: source-file-go
    where: $ 
    transform: >-
      return $.
        replace(/\/\/ (OrchestrationServiceNames)?DummyOrchestrationServiceName .../g,'').
        replace(/(OrchestrationServiceNames)?DummyOrchestrationServiceName OrchestrationServiceNames = "DummyOrchestrationServiceName"\n/g,'').
        replace(/,(OrchestrationServiceNames)?DummyOrchestrationServiceName/,'').
        replace(/, '(OrchestrationServiceNames)?DummyOrchestrationServiceName'/,'');
```

``` yaml $(go) && $(track2)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/compute/armcompute
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
azure-arm: true

directive:
  # we do not need to hack to add a dummy enum entry in track 2, because track 2 generator will generate the enum type even if it only has on entry 
  - from: disk.json
    where: "$.definitions.PurchasePlan"
    transform: >
      $["x-ms-client-name"] = "DiskPurchasePlan";
```

### Go multi-api

```yaml $(go) && $(multiapi)
batch:
  - tag: package-2021-12-01
  - tag: package-2021-11-01
  - tag: package-2021-08-01
  - tag: package-2021-07-01
  - tag: package-2021-04-01
  - tag: package-2021-03-01
  - tag: package-2020-12-01
  - tag: package-2020-10-01-preview
  - tag: profile-hybrid-2020-09-01
  - tag: package-2020-06-30
  - tag: package-2020-06-01
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

### Tag: package-2021-12-01 and go

These settings apply only when `--tag=package-2021-12-01 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag)=='package-2021-12-01' && $(go)
namespace: compute
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2021-12-01/$(namespace)
```

### Tag: package-2021-11-01 and go

These settings apply only when `--tag=package-2021-11-01 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag)=='package-2021-11-01' && $(go)
namespace: compute
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2021-11-01/$(namespace)
```

### Tag: package-2021-08-01 and go

These settings apply only when `--tag=package-2021-08-01 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag)=='package-2021-08-01' && $(go)
namespace: compute
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2021-08-01/$(namespace)
```

### Tag: package-2021-07-01 and go

These settings apply only when `--tag=package-2021-07-01 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag)=='package-2021-07-01' && $(go)
namespace: compute
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2021-07-01/$(namespace)
```

### Tag: package-2021-04-01 and go

These settings apply only when `--tag=package-2021-04-01 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag)=='package-2021-04-01' && $(go)
namespace: compute
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2021-04-01/$(namespace)
```

### Tag: package-2021-03-01 and go

These settings apply only when `--tag=package-2021-03-01 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag)=='package-2021-03-01' && $(go)
namespace: compute
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2021-03-01/$(namespace)
```

### Tag: package-2020-12-01 and go

These settings apply only when `--tag=package-2020-12-01 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag)=='package-2020-12-01' && $(go)
namespace: compute
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2020-12-01/$(namespace)
```

### Tag: package-2020-10-01-preview and go

These settings apply only when `--tag=package-2020-10-01-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag)=='package-2020-10-01-preview' && $(go)
namespace: compute
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2020-10-01-preview/$(namespace)
```

### Tag: profile-hybrid-2020-09-01 and go

These settings apply only when `--tag=profile-hybrid-2020-09-01 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag)=='profile-hybrid-2020-09-01' && $(go)
namespace: compute
output-folder: $(go-sdk-folder)/profiles/2020-09-01/compute/mgmt/compute
```

### Tag: package-2020-06-30 and go

These settings apply only when `--tag=package-2020-06-30 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag)=='package-2020-06-30' && $(go)
namespace: compute
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2020-06-30/$(namespace)
```

### Tag: package-2020-06-01 and go

These settings apply only when `--tag=package-2020-06-01 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag)=='package-2020-06-01' && $(go)
namespace: compute
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2020-06-01/$(namespace)
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
