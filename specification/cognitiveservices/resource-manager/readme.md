# CognitiveServices

> see https://aka.ms/autorest

This is the AutoRest configuration file for CognitiveServices.

# Notice

Microsoft will use data you send to Bing Search Services or the Translator Speech API to improve Microsoft products and services. Where you send personal data to these Cognitive Services, you are responsible for obtaining sufficient consent from the data subjects. The General Privacy and Security Terms in the Online Services Terms do not apply to these Cognitive Services. Please refer to the Microsoft Cognitive Services section in the [Online Services Terms](https://www.microsoft.com/en-us/Licensing/product-licensing/products.aspx) for details. Microsoft offers policy controls that may be used to [disable new Cognitive Services deployments](https://learn.microsoft.com/azure/cognitive-services/cognitive-services-apis-create-account).

---

## Getting Started

To build the SDK for CognitiveServices, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

## Configuration

### Basic Information

These are the global settings for the CognitiveServices API.

```yaml
openapi-type: arm
tag: package-2025-07-01-preview
```

### Tag: package-2025-07-01-preview

These settings apply only when `--tag=package-2025-07-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2025-07-01-preview'
input-file:
  - Microsoft.CognitiveServices/preview/2025-07-01-preview/cognitiveservices.json
suppressions:
  - code: PutResponseCodes
    reason: This is existing behavior in all other APIs and already in stable version, will keep the same.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/connections/{connectionName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}/connections/{connectionName}"].put
  - code: PatchResponseCodes
    reason: This is existing behavior in all other APIs and already in stable version, will keep the same.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].patch
  - code: PatchBodyParametersSchema
    reason: this is a required field for in a optional property this experience exist in other stable schemas as well.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/connections/{connectionName}"].patch.parameters[5].schema.properties.properties
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].patch.parameters[3].schema.properties.properties
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].patch.parameters[3].schema.properties.sku
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}/connections/{connectionName}"].patch.parameters[6].schema.properties.properties
  - code: GuidUsage
    reason: Approved to be suppressed in AML swagger.
    where:
      - $.definitions.ConnectionOAuth2.properties.clientId.format
  - code: DeleteResponseCodes
    reason: Behavior is align with other existing API for this RP
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].delete

  - code: AvoidAdditionalProperties
    reason: Approved to be suppressed in AML swagger
    where:
      - $.definitions.ConnectionPropertiesV2.properties.metadata
      - $.definitions.CustomKeys.properties.keys
  - code: NestedResourcesMustHaveListOperation
    reason: This API will be added in the later api version, same behavior as AML RP and already got suppression approved.
    where:
      - $.definitions["CapabilityHostResource"]
  - code: LroLocationHeader
    reason: Align with existing API behavior in other APIs
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].put.responses.202
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].patch.responses.202
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].delete.responses.202
  - code: AvoidAdditionalProperties
    reason: Same as existing account resource, trying to have the same behavior
    where:
      - $.definitions.ProjectProperties.properties.endpoints
```

### Tag: package-2025-06-01

These settings apply only when `--tag=package-2025-06-01` is specified on the command line.

```yaml $(tag) == 'package-2025-06-01'
input-file:
  - Microsoft.CognitiveServices/stable/2025-06-01/cognitiveservices.json
suppressions:
  - code: PutResponseCodes
    reason: This is existing behavior in all other APIs and already in stable version, will keep the same.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/connections/{connectionName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}/connections/{connectionName}"].put
  - code: PatchResponseCodes
    reason: This is existing behavior in all other APIs and already in stable version, will keep the same.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].patch
  - code: PatchBodyParametersSchema
    reason: this is a required field for in a optional property this experience exist in other stable schemas as well.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/connections/{connectionName}"].patch.parameters[5].schema.properties.properties
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].patch.parameters[3].schema.properties.properties
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].patch.parameters[3].schema.properties.sku
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}/connections/{connectionName}"].patch.parameters[6].schema.properties.properties
  - code: GuidUsage
    reason: Approved to be suppressed in AML swagger.
    where:
      - $.definitions.ConnectionOAuth2.properties.clientId.format
  - code: DeleteResponseCodes
    reason: Behavior is align with other existing API for this RP
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].delete

  - code: AvoidAdditionalProperties
    reason: Approved to be suppressed in AML swagger
    where:
      - $.definitions.ConnectionPropertiesV2.properties.metadata
      - $.definitions.CustomKeys.properties.keys
  - code: NestedResourcesMustHaveListOperation
    reason: This API will be added in the later api version, same behavior as AML RP and already got suppression approved.
    where:
      - $.definitions["CapabilityHostResource"]
  - code: LroLocationHeader
    reason: Align with existing API behavior in other APIs
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].put.responses.202
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].patch.responses.202
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].delete.responses.202
  - code: AvoidAdditionalProperties
    reason: Same as existing account resource, trying to have the same behavior
    where:
      - $.definitions.ProjectProperties.properties.endpoints
```

### Tag: package-preview-2025-04-01-preview

These settings apply only when `--tag=package-preview-2025-04-01-preview` is specified on the command line.

```yaml $(tag) == 'package-preview-2025-04-01-preview'
input-file:
  - Microsoft.CognitiveServices/preview/2025-04-01-preview/cognitiveservices.json
suppressions:
  - code: PutResponseCodes
    reason: This is existing behavior in all other APIs and already in stable version, will keep the same.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/connections/{connectionName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}/connections/{connectionName}"].put
  - code: PatchResponseCodes
    reason: This is existing behavior in all other APIs and already in stable version, will keep the same.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].patch
  - code: PatchBodyParametersSchema
    reason: this is a required field for in a optional property this experience exist in other stable schemas as well.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/connections/{connectionName}"].patch.parameters[5].schema.properties.properties
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].patch.parameters[3].schema.properties.properties
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].patch.parameters[3].schema.properties.sku
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}/connections/{connectionName}"].patch.parameters[6].schema.properties.properties
  - code: GuidUsage
    reason: Approved to be suppressed in AML swagger.
    where:
      - $.definitions.ConnectionOAuth2.properties.clientId.format
  - code: DeleteResponseCodes
    reason: Behavior is align with other existing API for this RP
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].delete

  - code: AvoidAdditionalProperties
    reason: Approved to be suppressed in AML swagger
    where:
      - $.definitions.ConnectionPropertiesV2.properties.metadata
      - $.definitions.CustomKeys.properties.keys
  - code: NestedResourcesMustHaveListOperation
    reason: This API will be added in the later api version, same behavior as AML RP and already got suppression approved.
    where:
      - $.definitions["CapabilityHostResource"]
  - code: LroLocationHeader
    reason: Align with existing API behavior in other APIs
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].put.responses.202
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].patch.responses.202
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].delete.responses.202
  - code: AvoidAdditionalProperties
    reason: Same as existing account resource, trying to have the same behavior
    where:
      - $.definitions.ProjectProperties.properties.endpoints
```

### Tag: package-2024-10

These settings apply only when `--tag=package-2024-10` is specified on the command line.

```yaml $(tag) == 'package-2024-10'
input-file:
  - Microsoft.CognitiveServices/stable/2024-10-01/cognitiveservices.json
```

### Tag: package-preview-2024-06

These settings apply only when `--tag=package-preview-2024-06` is specified on the command line.

```yaml $(tag) == 'package-preview-2024-06'
input-file:
  - Microsoft.CognitiveServices/preview/2024-06-01-preview/cognitiveservices.json
```

### Tag: package-preview-2024-04

These settings apply only when `--tag=package-preview-2024-04` is specified on the command line.

```yaml $(tag) == 'package-preview-2024-04'
input-file:
  - Microsoft.CognitiveServices/preview/2024-04-01-preview/cognitiveservices.json
```

### Tag: package-preview-2023-10

These settings apply only when `--tag=package-preview-2023-10` is specified on the command line.

```yaml $(tag) == 'package-preview-2023-10'
input-file:
  - Microsoft.CognitiveServices/preview/2023-10-01-preview/cognitiveservices.json
suppressions:
  - code: ResourceNameRestriction
    reason: The resource name parameter 'deploymentName' is not a new added parameter and was already implemented in previous versions of API, we cannot add pattern now.
    from: cognitiveservices.json
```

### Tag: package-2023-05

These settings apply only when `--tag=package-2023-05` is specified on the command line.

```yaml $(tag) == 'package-2023-05'
input-file:
  - Microsoft.CognitiveServices/stable/2023-05-01/cognitiveservices.json
```

### Tag: package-2022-12

These settings apply only when `--tag=package-2022-12` is specified on the command line.

```yaml $(tag) == 'package-2022-12'
input-file:
  - Microsoft.CognitiveServices/stable/2022-12-01/cognitiveservices.json
```

### Tag: package-2022-10

These settings apply only when `--tag=package-2022-10` is specified on the command line.

```yaml $(tag) == 'package-2022-10'
input-file:
  - Microsoft.CognitiveServices/stable/2022-10-01/cognitiveservices.json
```

### Tag: package-2022-03

These settings apply only when `--tag=package-2022-03` is specified on the command line.

```yaml $(tag) == 'package-2022-03'
input-file:
  - Microsoft.CognitiveServices/stable/2022-03-01/cognitiveservices.json
```

### Tag: package-2021-10

These settings apply only when `--tag=package-2021-10` is specified on the command line.

```yaml $(tag) == 'package-2021-10'
input-file:
  - Microsoft.CognitiveServices/stable/2021-10-01/cognitiveservices.json
```

### Tag: package-2021-04

These settings apply only when `--tag=package-2021-04` is specified on the command line.

```yaml $(tag) == 'package-2021-04'
input-file:
  - Microsoft.CognitiveServices/stable/2021-04-30/cognitiveservices.json
```

### Tag: package-2017-04

These settings apply only when `--tag=package-2017-04` is specified on the command line.

```yaml $(tag) == 'package-2017-04'
input-file:
  - Microsoft.CognitiveServices/stable/2017-04-18/cognitiveservices.json
```

### Tag: package-2016-02-preview

These settings apply only when `--tag=package-2016-02-preview` is specified on the command line.

```yaml $(tag) == 'package-2016-02-preview'
input-file:
  - Microsoft.CognitiveServices/preview/2016-02-01-preview/cognitiveservices.json
```

## Suppression

```yaml
directive:
  - suppress: TrackedResourcePatchOperation
    from: cognitiveservices.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/commitmentPlans/{commitmentPlanName}"]
    reason: The resource accounts/commitmentPlans is not a tracked resource
```

---

# Code Generation

## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

```yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-net
  - repo: azure-sdk-for-python
  - repo: azure-sdk-for-java
  - repo: azure-sdk-for-go
  - repo: azure-sdk-for-js
  - repo: azure-sdk-for-node
  - repo: azure-sdk-for-ruby
    after_scripts:
      - bundle install && rake arm:regen_all_profiles['azure_mgmt_cognitive_services']
  - repo: azure-resource-manager-schemas
  - repo: azure-powershell
```

## Python

See configuration in [readme.python.md](./readme.python.md)

## Go

See configuration in [readme.go.md](./readme.go.md)

## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

```yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.cognitiveservices
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-cognitiveservices
```

### Java multi-api

```yaml $(java) && $(multiapi)
batch:
  - tag: package-2017-04
  - tag: package-2016-02-preview
```

### Tag: package-2017-04 and java

These settings apply only when `--tag=package-2017-04 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

```yaml $(tag) == 'package-2017-04' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.cognitiveservices.v2017_04_18
  output-folder: $(azure-libraries-for-java-folder)/sdk/cognitiveservices/mgmt-v2017_04_18
regenerate-manager: true
generate-interface: true
```

### Tag: package-2016-02-preview and java

These settings apply only when `--tag=package-2016-02-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

```yaml $(tag) == 'package-2016-02-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.cognitiveservices.v2016_02_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/cognitiveservices/mgmt-v2016_02_01_preview
regenerate-manager: true
generate-interface: true
```
