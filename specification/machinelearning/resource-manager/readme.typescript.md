## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

``` yaml $(typescript)
typescript:
  azure-arm: true
  package-name: "@azure/arm-machinelearning"
  generate-metadata: true
batch:
  - tag: package-webservices-2017-01
  - tag: package-webservices-2016-05-preview
  - tag: package-workspaces-2016-04
  - tag: package-commitmentPlans-2016-05-preview
```

### Tag: package-webservices-2017-01 and TypeScript

These settings apply only when `--tag=package-webservices-2017-01 --typescript` is specified on the command line.
Please also specify `--typescript-sdk-folder=<path to the root directory of your azure-sdk-for-js clone>`.

``` yaml $(tag) == 'package-webservices-2017-01' && $(typescript)
namespace: webservices
output-folder: $(typescript-sdks-folder)/packages/@azure/arm-webservices
```

### Tag: package-webservices-2016-05-preview and TypeScript

These settings apply only when `--tag=package-webservices-2016-05-preview --typescript` is specified on the command line.
Please also specify `--typescript-sdk-folder=<path to the root directory of your azure-sdk-for-js clone>`.

``` yaml $(tag) == 'package-webservices-2016-05-preview' && $(typescript)
namespace: webservices
output-folder: $(typescript-sdks-folder)/packages/@azure/arm-webservices
```

### Tag: package-workspaces-2016-04 and TypeScript

These settings apply only when `--tag=package-workspaces-2016-04 --typescript` is specified on the command line.
Please also specify `--typescript-sdk-folder=<path to the root directory of your azure-sdk-for-js clone>`.

``` yaml $(tag) == 'package-workspaces-2016-04' && $(typescript)
namespace: workspaces
output-folder: $(typescript-sdks-folder)/packages/@azure/arm-workspaces
```

### Tag: package-commitmentPlans-2016-05-preview and TypeScript

These settings apply only when `--tag=package-commitmentPlans-2016-05-preview --typescript` is specified on the command line.
Please also specify `--typescript-sdk-folder=<path to the root directory of your azure-sdk-for-js clone>`.

``` yaml $(tag) == 'package-commitmentPlans-2016-05-preview' && $(typescript)
namespace: commitmentplans
output-folder: $(typescript-sdks-folder)/packages/@azure/arm-commitmentplans
```
