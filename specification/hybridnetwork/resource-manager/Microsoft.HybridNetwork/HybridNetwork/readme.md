# hybridnetwork

> see https://aka.ms/autorest

This is the AutoRest configuration file for hybridnetwork.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

## For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

## Configuration

### Basic Information

These are the global settings for the hybridnetwork.

```yaml
openapi-type: arm
openapi-subtype: rpaas
tag: package-2025-03-30
```

### Tag: package-2025-03-30

These settings apply only when `--tag=package-2025-03-30` is specified on the command line.

```yaml $(tag) == 'package-2025-03-30'
input-file:
  - stable/2025-03-30/openapi.json
suppressions:
  - code: PatchSkuProperty
    from: openapi.json
    reason: sku cannot be patched
  - code: PostResponseCodes
    from: openapi.json
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridNetwork/networkFunctions/{networkFunctionName}/executeRequest"].post
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridNetwork/publishers/{publisherName}/artifactStores/{artifactStoreName}/addNetworkFabricControllerEndPoints"].post
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridNetwork/publishers/{publisherName}/artifactStores/{artifactStoreName}/approvePrivateEndPoints"].post
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridNetwork/publishers/{publisherName}/artifactStores/{artifactStoreName}/deleteNetworkFabricControllerEndPoints"].post
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridNetwork/publishers/{publisherName}/artifactStores/{artifactStoreName}/removePrivateEndPoints"].post
    reason: >
      Pre-existing response shapes carried forward unchanged from the API version 2024-04-15,
      where these operations declare the identical response codes. The deployed service returns
      these codes today; altering them in 2025-03-30 would misrepresent the service contract and
      break existing clients. Tracked for correction in the next API version.
  - code: DeleteResponseCodes
    from: openapi.json
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridNetwork/networkFunctions/{networkFunctionName}"].delete
    reason: >
      Pre-existing. NetworkFunctions_Delete returns 200/202/204/default in the API version
      2024-04-15 and the deployed service still returns 200. Removing the 200 response would be a
      breaking change for existing clients. Tracked for correction in the next API version.
  - code: PatchIdentityProperty
    from: openapi.json
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridNetwork/networkFunctions/{networkFunctionName}"].patch
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridNetwork/publishers/{publisherName}"].patch
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridNetwork/siteNetworkServices/{siteNetworkServiceName}"].patch
    reason: >
      These PATCH operations are tags-only updates (TagsObject request body) carried forward
      unchanged from the API version 2024-04-15. Identity is not updatable through these
      operations by design, so the request body intentionally omits the identity property.
  - code: ProvisioningStateSpecifiedForLROPatch
    from: openapi.json
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridNetwork/publishers/{publisherName}/artifactStores/{artifactStoreName}/artifactVersions/{artifactVersionName}"].patch
    reason: >
      Pre-existing. ProxyArtifact_UpdateState is carried forward unchanged from the API version
      2024-04-15. Its 200 response returns the artifact state overview, which has no
      provisioningState property in the deployed contract. Adding one would be a breaking change.
  - code: AvoidAdditionalProperties
    from: openapi.json
    where:
      - $.definitions["SiteNetworkServicePropertiesFormat"].properties["desiredStateConfigurationGroupValueReferences"]
      - $.definitions["SiteNetworkServicePropertiesFormat"].properties["lastStateConfigurationGroupValueReferences"]
      - $.definitions["networkServiceDesignVersionPropertiesFormat"].properties["configurationGroupSchemaReferences"]
      - $.definitions["networkServiceDesignVersionPropertiesFormat"].properties["nfvisFromSite"]
    reason: >
      These are user-defined key-value maps whose keys are chosen by the publisher at design time
      and therefore cannot be modelled as a fixed schema. They are carried forward unchanged from
      the API version 2024-04-15; converting them to a closed schema would be a breaking change.
  - code: XMSSecretInResponse
    from: openapi.json
    where:
      - $.definitions["AzureContainerRegistryScopedTokenCredential"].properties["acrToken"]
    reason: >
      By design. acrToken is the intended payload of ArtifactManifests_ListCredential, an explicit
      POST list* credential action - the ARM-sanctioned pattern for surfacing a secret. The
      x-ms-secret annotation declares that a property must never appear in any response, so
      applying it here would contradict the sole purpose of the operation, fail Swagger
      ModelValidation (SECRET_PROPERTY) against ArtifactManifestListCredential.json, and risk the
      token being stripped at runtime - breaking a GA contract shipped since 2023-09-01. The secret
      is already correctly gated: it is never returned on the resource GET, is only issued from an
      explicit POST action, and is short-lived (see the expiry property).
  - code: NestedResourcesMustHaveListOperation
    from: openapi.json
    where:
      - $.definitions["ProxyArtifactVersionsListOverview"]
    reason: >
      Pre-existing. ProxyArtifactVersionsListOverview is carried forward unchanged from API
      version 2024-04-15. It is an overview projection returned by the artifact versions list
      operation rather than an independently addressable nested resource, so a dedicated list
      operation does not apply.
```

### Tag: package-2024-04-15

These settings apply only when `--tag=package-2024-04-15` is specified on the command line.

```yaml $(tag) == 'package-2024-04-15'
input-file:
  - stable/2024-04-15/common.json
  - stable/2024-04-15/configurationGroupSchema.json
  - stable/2024-04-15/configurationGroupValues.json
  - stable/2024-04-15/networkFunction.json
  - stable/2024-04-15/networkFunctionDefinition.json
  - stable/2024-04-15/networkServiceDesign.json
  - stable/2024-04-15/operation.json
  - stable/2024-04-15/publisher.json
  - stable/2024-04-15/pureProxyArtifact.json
  - stable/2024-04-15/site.json
  - stable/2024-04-15/siteNetworkService.json
suppressions:
  - code: PatchSkuProperty
    from: siteNetworkService.json
    reason: sku cannot be patched
```

### Tag: package-2023-09-01

These settings apply only when `--tag=package-2023-09-01` is specified on the command line.

```yaml $(tag) == 'package-2023-09-01'
input-file:
  - stable/2023-09-01/common.json
  - stable/2023-09-01/configurationGroupSchema.json
  - stable/2023-09-01/configurationGroupValues.json
  - stable/2023-09-01/networkFunction.json
  - stable/2023-09-01/networkFunctionDefinition.json
  - stable/2023-09-01/networkServiceDesign.json
  - stable/2023-09-01/operation.json
  - stable/2023-09-01/publisher.json
  - stable/2023-09-01/pureProxyArtifact.json
  - stable/2023-09-01/site.json
  - stable/2023-09-01/siteNetworkService.json

suppressions:
  - code: PatchSkuProperty
    from: siteNetworkService.json
    reason: sku cannot be patched
```

### Tag: package-2022-01-01-preview

These settings apply only when `--tag=package-2022-01-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2022-01-01-preview'
input-file:
  - preview/2022-01-01-preview/common.json
  - preview/2022-01-01-preview/device.json
  - preview/2022-01-01-preview/networkFunction.json
  - preview/2022-01-01-preview/networkFunctionVendor.json
  - preview/2022-01-01-preview/operation.json
  - preview/2022-01-01-preview/vendor.json
  - preview/2022-01-01-preview/vendorNetworkFunction.json
```
### Tag: package-2021-05-01

These settings apply only when `--tag=package-2021-05-01` is specified on the command line.

``` yaml $(tag) == 'package-2021-05-01'
input-file:
  - stable/2021-05-01/common.json
  - stable/2021-05-01/networkFunction.json
  - stable/2021-05-01/device.json
  - stable/2021-05-01/operation.json
  - stable/2021-05-01/vendor.json
  - stable/2021-05-01/networkFunctionVendor.json
  - stable/2021-05-01/vendorNetworkFunction.json
```

### Tag: package-2020-01-01-preview

These settings apply only when `--tag=package-2020-01-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2020-01-01-preview'
input-file:
  - preview/2020-01-01-preview/common.json
  - preview/2020-01-01-preview/networkFunction.json
  - preview/2020-01-01-preview/device.json
  - preview/2020-01-01-preview/operation.json
  - preview/2020-01-01-preview/vendor.json
  - preview/2020-01-01-preview/networkFunctionVendor.json
  - preview/2020-01-01-preview/vendorNetworkFunction.json
```

# Code Generation

## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

``` yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-python
  - repo: azure-sdk-for-java
  - repo: azure-sdk-for-go
  - repo: azure-sdk-for-js
  - repo: azure-sdk-for-ruby
    after_scripts:
      - bundle install && rake arm:regen_all_profiles['azure_mgmt_hybridnetwork']
  - repo: azure-resource-manager-schemas
  - repo: azure-powershell
```

## Go

See configuration in [readme.go.md](./readme.go.md)

## Python

See configuration in [readme.python.md](./readme.python.md)

## Ruby

See configuration in [readme.ruby.md](./readme.ruby.md)

## TypeScript

See configuration in [readme.typescript.md](./readme.typescript.md)

## CSharp

See configuration in [readme.csharp.md](./readme.csharp.md)
