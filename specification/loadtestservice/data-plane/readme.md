# loadtestservice

> see https://aka.ms/autorest
This is the AutoRest configuration file for loadtestservice.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`
To see additional help and options, run:

> `autorest --help`
For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the loadtestservice.

```yaml
openapi-type: data-plane
tag: package-2022-06-01-preview
```

### Tag: package-2022-06-01-preview

These settings apply only when `--tag=package-2022-06-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2022-06-01-preview'
input-file:
  - Microsoft.LoadTestService/preview/2022-06-01-preview/loadtestservice.json
```

### Tag: package-2021-07-01-preview

These settings apply only when `--tag=package-2021-07-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2021-07-01-preview'
input-file:
  - Microsoft.LoadTestService/preview/2021-07-01-preview/loadtestservice.json
```

### Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-sdk-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

```yaml $(java)
input-file:
  - Microsoft.LoadTestService/preview/2022-06-01-preview/loadtestservice.json
java: true
regenerate-pom: false
title: LoadTestingClient
security: AADToken
security-scopes: https://loadtest.azure-dev.com/.default
data-plane: true
generate-models: false
generate-samples: false
generate-tests: false
artifact-id: azure-developer-loadtesting
namespace: com.azure.developer.loadtesting
partial-update: true
output-folder: $(azure-sdk-for-java-folder)/sdk/loadtestservice/azure-developer-loadtesting
service-versions:
- 2022-06-01-preview
directive:
- from: swagger-document
  where: '$.paths["/testruns/{testRunId}"].patch'
  transform: >
    $["operationId"] = "TestRun_CreateAndUpdateTestRun";
- from: swagger-document
  where: '$.paths.*[?(@.tags=="AppComponent")]'
  transform: >
    $["operationId"] = $["operationId"].replace("AppComponent_", "LoadTestAdministration_");
- from: swagger-document
  where: '$.paths.*[?(@.tags=="ServerMetrics")]'
  transform: >
    $["operationId"] = $["operationId"].replace("ServerMetrics_", "LoadTestAdministration_");
- from: swagger-document
  where: '$.paths.*[?(@.tags=="Test")]'
  transform: >
    $["operationId"] = $["operationId"].replace("Test_", "LoadTestAdministration_");
```