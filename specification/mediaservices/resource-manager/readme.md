# MediaServices

> see https://aka.ms/autorest

This is the AutoRest configuration file for MediaServices.

---

## Getting Started

To build the SDK for MediaServices, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

## Configuration

### Basic Information

These are the global settings for the MediaServices API.

```yaml
openapi-type: arm
tag: package-2021-11
opt-in-extensible-enums: true
```

### Suppression

```yaml
directive:
  - suppress: R2016
    where: $.definitions.TrackedResource.required
    reason: we are still using PUT definition for PATCH, which has location as required property. this is existing suppression added to avoid breaking change.

  - suppress: DeleteOperationResponses
    reason: Per ARM Specs, async APIs must return 202 when a response is accepted.
    where: '$.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Media/mediaServices/{accountName}/assets/{assetName}/tracks/{trackName}"].delete.responses'
    from: AssetsAndAssetFilters.json

  - suppress: RequiredReadOnlySystemData
    reason: Per ARM Specs, only top level tracked resources return systemMetadata.
    where:
      - '$.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Media/mediaServices/{accountName}/assets/{assetName}/tracks/{trackName}"].put'
      - '$.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Media/mediaServices/{accountName}/assets/{assetName}/tracks/{trackName}"].get'
      - '$.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Media/mediaServices/{accountName}/assets/{assetName}/tracks/{trackName}"].patch'
      - '$.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Media/mediaServices/{accountName}/assets/{assetName}/tracks/{trackName}/operationResults/{operationId}"].get'

    from: AssetsAndAssetFilters.json

  - suppress: RequiredReadOnlySystemData
    reason: Per ARM Specs, only top level tracked resources return systemMetadata.
    where:
      - '$.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Media/mediaservices/{accountName}/privateEndpointConnections/{name}"].get'
      - '$.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Media/mediaservices/{accountName}/privateEndpointConnections/{name}"].put'
      - '$.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Media/mediaservices/{accountName}/privateLinkResources/{name}"].get'
    from: Accounts.json
```

### Tag: package-2021-11

These settings apply only when `--tag=package-2021-11` is specified on the command line.

```yaml $(tag) == 'package-2021-11'
input-file:
  - Microsoft.Media/stable/2021-11-01/AccountFilters.json
  - Microsoft.Media/stable/2021-06-01/Accounts.json
  - Microsoft.Media/stable/2021-11-01/AssetsAndAssetFilters.json
  - Microsoft.Media/stable/2021-11-01/ContentKeyPolicies.json
  - Microsoft.Media/stable/2021-11-01/Encoding.json
  - Microsoft.Media/stable/2021-11-01/StreamingPoliciesAndStreamingLocators.json
  - Microsoft.Media/stable/2021-11-01/streamingservice.json
```

### Tag: package-2021-06

These settings apply only when `--tag=package-2021-06` is specified on the command line.

```yaml $(tag) == 'package-2021-06'
input-file:
  - Microsoft.Media/stable/2021-06-01/Accounts.json
  - Microsoft.Media/stable/2021-06-01/AccountFilters.json
  - Microsoft.Media/stable/2021-06-01/AssetsAndAssetFilters.json
  - Microsoft.Media/stable/2021-06-01/ContentKeyPolicies.json
  - Microsoft.Media/stable/2021-06-01/Encoding.json
  - Microsoft.Media/stable/2021-06-01/StreamingPoliciesAndStreamingLocators.json
  - Microsoft.Media/stable/2021-06-01/streamingservice.json
directive:
  - suppress: R2016
    where: $.definitions.TrackedResource.required
    reason: location is a required property for our patch calls
```

### Tag: package-2021-05

These settings apply only when `--tag=package-2021-05` is specified on the command line.

```yaml $(tag) == 'package-2021-05'
input-file:
  - Microsoft.Media/stable/2020-05-01/AccountFilters.json
  - Microsoft.Media/stable/2021-05-01/Accounts.json
  - Microsoft.Media/stable/2020-05-01/AssetsAndAssetFilters.json
  - Microsoft.Media/stable/2020-05-01/ContentKeyPolicies.json
  - Microsoft.Media/stable/2020-05-01/Encoding.json
  - Microsoft.Media/stable/2020-05-01/StreamingPoliciesAndStreamingLocators.json
  - Microsoft.Media/stable/2020-05-01/streamingservice.json
  - Microsoft.Media/stable/2020-05-01/Common.json
directive:
  - suppress: R2016
    where: $.definitions.TrackedResource.required
    reason: location is a required property for our patch calls
```

### Tag: package-2020-05

These settings apply only when `--tag=package-2020-05` is specified on the command line.

```yaml $(tag) == 'package-2020-05'
input-file:
  - Microsoft.Media/stable/2020-05-01/AccountFilters.json
  - Microsoft.Media/stable/2020-05-01/Accounts.json
  - Microsoft.Media/stable/2020-05-01/AssetsAndAssetFilters.json
  - Microsoft.Media/stable/2020-05-01/ContentKeyPolicies.json
  - Microsoft.Media/stable/2020-05-01/Encoding.json
  - Microsoft.Media/stable/2020-05-01/StreamingPoliciesAndStreamingLocators.json
  - Microsoft.Media/stable/2020-05-01/streamingservice.json
  - Microsoft.Media/stable/2020-05-01/Common.json
directive:
  - suppress: R2016
    where: $.definitions.TrackedResource.required
    reason: location is a required property for our patch calls
```

### Tag: package-2020-02-preview

These settings apply only when `--tag=package-2020-02-preview` is specified on the command line.

```yaml $(tag) == 'package-2020-02-preview'
input-file:
  - Microsoft.Media/stable/2018-07-01/AccountFilters.json
  - Microsoft.Media/stable/2018-07-01/Accounts.json
  - Microsoft.Media/stable/2018-07-01/AssetsAndAssetFilters.json
  - Microsoft.Media/stable/2018-07-01/ContentKeyPolicies.json
  - Microsoft.Media/stable/2018-07-01/Encoding.json
  - Microsoft.Media/preview/2020-02-01-preview/MediaGraphs.json
  - Microsoft.Media/stable/2018-07-01/StreamingPoliciesAndStreamingLocators.json
  - Microsoft.Media/stable/2018-07-01/streamingservice.json
```

### Tag: package-2019-09-preview

These settings apply only when `--tag=package-2019-09-preview` is specified on the command line.

```yaml $(tag) == 'package-2019-09-preview'
input-file:
  - Microsoft.Media/stable/2018-07-01/AccountFilters.json
  - Microsoft.Media/stable/2018-07-01/Accounts.json
  - Microsoft.Media/stable/2018-07-01/AssetsAndAssetFilters.json
  - Microsoft.Media/stable/2018-07-01/ContentKeyPolicies.json
  - Microsoft.Media/stable/2018-07-01/Encoding.json
  - Microsoft.Media/preview/2019-09-01-preview/MediaGraphs.json
  - Microsoft.Media/stable/2018-07-01/StreamingPoliciesAndStreamingLocators.json
  - Microsoft.Media/stable/2018-07-01/streamingservice.json
```

### Tag: package-2019-05-preview

These settings apply only when `--tag=package-2019-05-preview` is specified on the command line.

```yaml $(tag) == 'package-2019-05-preview'
input-file:
  - Microsoft.Media/preview/2019-05-01-preview/AccountFilters.json
  - Microsoft.Media/preview/2019-05-01-preview/Accounts.json
  - Microsoft.Media/preview/2019-05-01-preview/AssetsAndAssetFilters.json
  - Microsoft.Media/preview/2019-05-01-preview/Common.json
  - Microsoft.Media/preview/2019-05-01-preview/ContentKeyPolicies.json
  - Microsoft.Media/preview/2019-05-01-preview/Encoding.json
  - Microsoft.Media/preview/2019-05-01-preview/StreamingPoliciesAndStreamingLocators.json
  - Microsoft.Media/preview/2019-05-01-preview/streamingservice.json
```

### Tag: package-2018-07

These settings apply only when `--tag=package-2018-07` is specified on the command line.

```yaml $(tag) == 'package-2018-07'
input-file:
  - Microsoft.Media/stable/2018-07-01/AccountFilters.json
  - Microsoft.Media/stable/2018-07-01/Accounts.json
  - Microsoft.Media/stable/2018-07-01/AssetsAndAssetFilters.json
  - Microsoft.Media/stable/2018-07-01/Common.json
  - Microsoft.Media/stable/2018-07-01/ContentKeyPolicies.json
  - Microsoft.Media/stable/2018-07-01/Encoding.json
  - Microsoft.Media/stable/2018-07-01/StreamingPoliciesAndStreamingLocators.json
  - Microsoft.Media/stable/2018-07-01/streamingservice.json
```

### Tag: package-2015-10

These settings apply only when `--tag=package-2015-10` is specified on the command line.

```yaml $(tag) == 'package-2015-10'
input-file:
  - Microsoft.Media/stable/2015-10-01/media.json
```

### Tag: package-2018-03-preview

These settings apply only when `--tag=package-2018-03-preview` is specified on the command line.

```yaml $(tag) == 'package-2018-03-preview'
input-file:
  - Microsoft.Media/preview/2018-03-30-preview/Accounts.json
  - Microsoft.Media/preview/2018-03-30-preview/Assets.json
  - Microsoft.Media/preview/2018-03-30-preview/ContentKeyPolicies.json
  - Microsoft.Media/preview/2018-03-30-preview/Encoding.json
  - Microsoft.Media/preview/2018-03-30-preview/StreamingPoliciesAndStreamingLocators.json
  - Microsoft.Media/preview/2018-03-30-preview/streamingservice.json
```

### Tag: package-2018-06-preview

These settings apply only when `--tag=package-2018-06-preview` is specified on the command line.

```yaml $(tag) == 'package-2018-06-preview'
input-file:
  - Microsoft.Media/preview/2018-06-01-preview/Accounts.json
  - Microsoft.Media/preview/2018-06-01-preview/Assets.json
  - Microsoft.Media/preview/2018-06-01-preview/ContentKeyPolicies.json
  - Microsoft.Media/preview/2018-06-01-preview/Encoding.json
  - Microsoft.Media/preview/2018-06-01-preview/StreamingPoliciesAndStreamingLocators.json
  - Microsoft.Media/preview/2018-06-01-preview/streamingservice.json
```

---

# Code Generation

## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

```yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-net
  - repo: azure-sdk-for-python-track2
  - repo: azure-sdk-for-java
  - repo: azure-sdk-for-go
  - repo: azure-sdk-for-go-track2
  - repo: azure-sdk-for-js
  - repo: azure-sdk-for-node
  - repo: azure-sdk-for-ruby
    after_scripts:
      - bundle install && rake arm:regen_all_profiles['azure_mgmt_media_services']
  - repo: azure-resource-manager-schemas
  - repo: azure-powershell
```

## C

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

```yaml $(csharp)
csharp:
  # last generated from commit 3586e2989d502434c4f607dd38d40e46aabede5c
  azure-arm: true
  payload-flattening-threshold: 2
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: Microsoft.Azure.Management.Media
  output-folder: $(csharp-sdks-folder)/mediaservices/Microsoft.Azure.Management.Media/src/Generated
  clear-output-folder: true
```

## Python

See configuration in [readme.python.md](./readme.python.md)

## Go

See configuration in [readme.go.md](./readme.go.md)

## Java

See configuration in [readme.java.md](./readme.java.md)

## Suppression

```yaml
directive:
  - suppress: OBJECT_MISSING_REQUIRED_PROPERTY
    from: Encoding.json
    where: $.definitions.JobProperties
    reason: Input not required for Job update
  - suppress: OBJECT_MISSING_REQUIRED_PROPERTY
    from: Encoding.json
    where: $.definitions.JobProperties
    reason: Output not required for job update
```
