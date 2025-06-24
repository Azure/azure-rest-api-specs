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

``` yaml
openapi-type: arm
openapi-subtype: rpaas
tag: package-2022-12-01
```

### Tag: package-2025-07-01-preview
These settings apply only when `--tag=2025-07-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2025-07-01-preview'
input-file:
  - Microsoft.LoadTestService/playwright/preview/2025-07-01-preview/playwright.json
```

### Tag: package-2024-12-01-preview

These settings apply only when `--tag=package-2024-12-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2024-12-01-preview'
input-file:
  - Microsoft.LoadTestService/loadtesting/preview/2024-12-01-preview/loadtestservice.json
directive:
  - where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.LoadTestService/loadTests/{loadTestName}/limits/maxMonthlyVirtualUserHours"]
    suppress: PathForNestedResource
    reason: Load test resource limits API design.
  - where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.LoadTestService/loadTests/{loadTestName}/limits/maxMonthlyVirtualUserHours"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.LoadTestService/loadTests/{loadTestName}/limits/maxMonthlyVirtualUserHours/set"]
    suppress: ResourceNameRestriction
    reason: The parent loadTests resource (existing API) does not have pattern restriction.
  - where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.LoadTestService/loadTests/{loadTestName}/limits/maxMonthlyVirtualUserHours/set"]
    suppress: PathForResourceAction
    reason: API design for post action for the load testing resource limits.
suppressions:
  - code: ResourceNameRestriction
    from: loadtestservice.json
    reason: Existing API, will be a breaking change for this api-version.
    where:
      - $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.LoadTestService/locations/{location}/quotas/{quotaBucketName}"]
      - $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.LoadTestService/locations/{location}/quotas/{quotaBucketName}/checkAvailability"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.LoadTestService/loadTests/{loadTestName}"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.LoadTestService/loadTests/{loadTestName}/outboundNetworkDependenciesEndpoints"]
  - code: RequiredPropertiesMissingInResourceModel
    from: loadtestservice.json
    reason: Existing API, will be a breaking change for this api-version.
    where:
      - $.definitions["PagedOutboundEnvironmentEndpoint"]
```

### Tag: package-2023-12-01-preview

These settings apply only when `--tag=package-2023-12-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2023-12-01-preview'
input-file:
  - Microsoft.LoadTestService/loadtesting/preview/2023-12-01-preview/loadtestservice.json
suppressions:
  - code: ResourceNameRestriction
    from: loadtestservice.json
    reason: Existing API, will be a breaking change for this api-version.
    where:
      - $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.LoadTestService/locations/{location}/quotas/{quotaBucketName}"]
      - $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.LoadTestService/locations/{location}/quotas/{quotaBucketName}/checkAvailability"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.LoadTestService/loadTests/{loadTestName}"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.LoadTestService/loadTests/{loadTestName}/outboundNetworkDependenciesEndpoints"]
  - code: RequiredPropertiesMissingInResourceModel
    from: loadtestservice.json
    reason: Existing API, will be a breaking change for this api-version.
    where:
      - $.definitions["PagedOutboundEnvironmentEndpoint"]
```

### Tag: package-2022-12-01

These settings apply only when `--tag=package-2022-12-01` is specified on the command line.

```yaml $(tag) == 'package-2022-12-01'
input-file:
  - Microsoft.LoadTestService/loadtesting/stable/2022-12-01/loadtestservice.json
suppressions:
  - code: ResourceNameRestriction
    from: loadtestservice.json
    reason: Existing API, will be a breaking change for this api-version.
    where:
      - $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.LoadTestService/locations/{location}/quotas/{quotaBucketName}"]
      - $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.LoadTestService/locations/{location}/quotas/{quotaBucketName}/checkAvailability"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.LoadTestService/loadTests/{loadTestName}"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.LoadTestService/loadTests/{loadTestName}/outboundNetworkDependenciesEndpoints"]
  - code: RequiredPropertiesMissingInResourceModel
    from: loadtestservice.json
    reason: Existing API, will be a breaking change for this api-version.
    where:
      - $.definitions["PagedOutboundEnvironmentEndpoint"]
```
