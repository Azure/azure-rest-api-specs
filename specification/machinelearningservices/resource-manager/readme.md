# MachineLearningServices

> see https://aka.ms/autorest

This is the AutoRest configuration file for Machine Learning Services.

---

## Getting Started

To build the SDK for Azure Machine Learning, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

## Configuration

### Basic Information

These are the global settings for the Machine Learning Services API.

``` yaml
openapi-type: arm
tag: package-preview-2024-04
```


### Tag: package-preview-2024-04

These settings apply only when `--tag=package-preview-2024-04` is specified on the command line.

```yaml $(tag) == 'package-preview-2024-04'
input-file:
  - Microsoft.MachineLearningServices/preview/2024-04-01-preview/machineLearningServices.json
  - Microsoft.MachineLearningServices/preview/2024-04-01-preview/mfe.json
  - Microsoft.MachineLearningServices/preview/2024-04-01-preview/registries.json
  - Microsoft.MachineLearningServices/preview/2024-04-01-preview/workspaceFeatures.json
  - Microsoft.MachineLearningServices/preview/2024-04-01-preview/workspaceRP.json
suppressions:
  - code: ProvisioningStateSpecifiedForLROPut
    reason: Below APIs are created for migration, the existing API contract is like this and won't able to change, got exceptions from ARM reviewer.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/connections/{connectionName}/deployments/{deploymentName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/connections/{connectionName}/raiPolicies/{raiPolicyName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/endpoints/{endpointName}/raiPolicies/{raiPolicyName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/connections/{connectionName}/raiBlocklists/{raiBlocklistName}/raiBlocklistItems/{raiBlocklistItemName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/connections/{connectionName}/raiBlocklists/{raiBlocklistName}"].put
```
### Tag: package-preview-2024-01

These settings apply only when `--tag=package-preview-2024-01` is specified on the command line.

``` yaml $(tag) == 'package-preview-2024-01'
input-file:
  - Microsoft.MachineLearningServices/preview/2024-01-01-preview/machineLearningServices.json
  - Microsoft.MachineLearningServices/preview/2024-01-01-preview/mfe.json
  - Microsoft.MachineLearningServices/preview/2024-01-01-preview/registries.json
  - Microsoft.MachineLearningServices/preview/2024-01-01-preview/workspaceFeatures.json
  - Microsoft.MachineLearningServices/preview/2024-01-01-preview/workspaceRP.json
suppressions:
  - code: PathForResourceAction
    reason: Keep identical to stable GA version to avoid breaking changes. https://dev.azure.com/msdata/Vienna/_workitems/edit/2803196
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/registries/{registryName}/datareferences/{name}/versions/{version}"].post
  - code: AvoidAdditionalProperties
    reason: As discussed these are hyperparameters which can vary by model and fine tuning task types so cannot have strictly typed properties.
    where:
      - $.definitions["CustomModelFineTuning"].properties["hyperParameters"]
  - code: AvoidAdditionalProperties
    reason: This is coming for wrong reason, just inheriting from JobBase.
    where:
      - $.definitions["FineTuningJob"].allOf[0]["allOf"][0].properties["properties"]
      - $.definitions["FineTuningJob"].allOf[0].properties["notificationSetting"].properties["webhooks"]
      - $.definitions["FineTuningJob"].allOf[0].properties["secretsConfiguration"]
      - $.definitions["FineTuningJob"].allOf[0].properties["services"]
      - $.definitions["FineTuningJob"].allOf[0].properties["services"].additionalProperties["properties"].properties
  - code: AvoidAdditionalProperties
    reason: There is a similar usage in existing jobs.
    where:
      - $.definitions["FineTuningJob"].properties["outputs"]
  - code: ProvisioningStateSpecifiedForLROPut
    reason: Service already using 202 response code for the below APIs, got exceptions from ARM reviewer.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/endpoints/{endpointName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/endpoints/{endpointName}/deployments/{deploymentName}"].put
  - code: PutResponseCodes
    reason: Service already using 202 response code for the below APIs, got exceptions from ARM reviewer.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/endpoints/{endpointName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/endpoints/{endpointName}/deployments/{deploymentName}"].put
  - code: AvoidAdditionalProperties
    reason: This is an external reference right now, we will have full control on the schema returned in the upcoming version and will avoid this.
    from: workspaceRP.json
    where:
      - $.definitions.AccountModel.properties.finetuneCapabilities
      - $.definitions.AccountModel.properties.capabilities
      - $.definitions.EndpointModels.properties.value.items.properties.capabilities
      - $.definitions.EndpointModels.properties.value.items.properties.finetuneCapabilities
  - code: GuidUsage
    reason: This property has always been a GUID, we just didn't mark its format before, this can't be change without breaking the customer.
    from: workspaceRP.json    
    where:
      - $.definitions.WorkspaceConnectionOAuth2.properties.clientId.format
```

### Tag: package-preview-2023-08

These settings apply only when `--tag=package-preview-2023-08` is specified on the command line.

``` yaml $(tag) == 'package-preview-2023-08'
input-file:
  - Microsoft.MachineLearningServices/preview/2023-08-01-preview/machineLearningServices.json
  - Microsoft.MachineLearningServices/preview/2023-08-01-preview/mfe.json
  - Microsoft.MachineLearningServices/preview/2023-08-01-preview/registries.json
  - Microsoft.MachineLearningServices/preview/2023-08-01-preview/workspaceFeatures.json
  - Microsoft.MachineLearningServices/preview/2023-08-01-preview/workspaceRP.json
suppressions:
  - code: LroPostReturn
    reason: LRO does not return 200 by design.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/computes/{computeName}/resize"].post
  - code: TrackedResourcePatchOperation
    reason: server side don't support Patch yet track with https://msdata.visualstudio.com/Vienna/_workitems/edit/2702298.
    where:
      - $.definitions.PrivateEndpointConnection
```

### Tag: package-2023-10

These settings apply only when `--tag=package-2023-10` is specified on the command line.

``` yaml $(tag) == 'package-2023-10'
input-file:
  - Microsoft.MachineLearningServices/stable/2023-10-01/machineLearningServices.json
  - Microsoft.MachineLearningServices/stable/2023-10-01/mfe.json
  - Microsoft.MachineLearningServices/stable/2023-10-01/registries.json
  - Microsoft.MachineLearningServices/stable/2023-10-01/workspaceFeatures.json
```

### Tag: package-preview-2023-06

These settings apply only when `--tag=package-preview-2023-06` is specified on the command line.

``` yaml $(tag) == 'package-preview-2023-06'
input-file:
  - Microsoft.MachineLearningServices/preview/2023-06-01-preview/machineLearningServices.json
  - Microsoft.MachineLearningServices/preview/2023-06-01-preview/mfe.json
  - Microsoft.MachineLearningServices/preview/2023-06-01-preview/registries.json
  - Microsoft.MachineLearningServices/preview/2023-06-01-preview/workspaceFeatures.json
  - Microsoft.MachineLearningServices/preview/2023-06-01-preview/workspaceRP.json
```

### Tag: package-2023-04

These settings apply only when `--tag=package-2023-04` is specified on the command line.

``` yaml $(tag) == 'package-2023-04'
input-file:
  - Microsoft.MachineLearningServices/stable/2023-04-01/machineLearningServices.json
  - Microsoft.MachineLearningServices/stable/2023-04-01/mfe.json
  - Microsoft.MachineLearningServices/stable/2023-04-01/registries.json
  - Microsoft.MachineLearningServices/stable/2023-04-01/workspaceFeatures.json
```

### Tag: package-preview-2023-04

These settings apply only when `--tag=package-preview-2023-04` is specified on the command line.

``` yaml $(tag) == 'package-preview-2023-04'
input-file:
  - Microsoft.MachineLearningServices/preview/2023-04-01-preview/machineLearningServices.json
  - Microsoft.MachineLearningServices/preview/2023-04-01-preview/mfe.json
  - Microsoft.MachineLearningServices/preview/2023-04-01-preview/registries.json
  - Microsoft.MachineLearningServices/preview/2023-04-01-preview/workspaceFeatures.json
```

### Tag: package-preview-2023-02

These settings apply only when `--tag=package-preview-2023-02` is specified on the command line.

``` yaml $(tag) == 'package-preview-2023-02'
input-file:
  - Microsoft.MachineLearningServices/preview/2023-02-01-preview/machineLearningServices.json
  - Microsoft.MachineLearningServices/preview/2023-02-01-preview/mfe.json
  - Microsoft.MachineLearningServices/preview/2023-02-01-preview/registries.json
  - Microsoft.MachineLearningServices/preview/2023-02-01-preview/workspaceFeatures.json
```

### Tag: package-preview-2022-12

These settings apply only when `--tag=package-preview-2022-12` is specified on the command line.

``` yaml $(tag) == 'package-preview-2022-12'
input-file:
  - Microsoft.MachineLearningServices/preview/2022-12-01-preview/machineLearningServices.json
  - Microsoft.MachineLearningServices/preview/2022-12-01-preview/mfe.json
  - Microsoft.MachineLearningServices/preview/2022-12-01-preview/registries.json
  - Microsoft.MachineLearningServices/preview/2022-12-01-preview/workspaceFeatures.json
```

### Tag: package-preview-2022-10

These settings apply only when `--tag=package-preview-2022-10` is specified on the command line.

``` yaml $(tag) == 'package-preview-2022-10'
input-file:
  - Microsoft.MachineLearningServices/preview/2022-10-01-preview/machineLearningServices.json
  - Microsoft.MachineLearningServices/preview/2022-10-01-preview/mfe.json
  - Microsoft.MachineLearningServices/preview/2022-10-01-preview/workspaceFeatures.json
  - Microsoft.MachineLearningServices/preview/2022-10-01-preview/registries.json
```

### Tag: package-2022-10

These settings apply only when `--tag=package-2022-10` is specified on the command line.

``` yaml $(tag) == 'package-2022-10'
input-file:
  - Microsoft.MachineLearningServices/stable/2022-10-01/machineLearningServices.json
  - Microsoft.MachineLearningServices/stable/2022-10-01/mfe.json
  - Microsoft.MachineLearningServices/stable/2022-10-01/workspaceFeatures.json
```

### Tag: package-preview-2022-06

These settings apply only when `--tag=package-preview-2022-06` is specified on the command line.

``` yaml $(tag) == 'package-preview-2022-06'
input-file:
  - Microsoft.MachineLearningServices/preview/2022-06-01-preview/machineLearningServices.json
  - Microsoft.MachineLearningServices/preview/2022-06-01-preview/mfe.json
  - Microsoft.MachineLearningServices/preview/2022-06-01-preview/workspaceFeatures.json
```

### Tag: package-2022-05-01

These settings apply only when `--tag=package-2022-05-01` is specified on the command line.

``` yaml $(tag) == 'package-2022-05-01'
input-file:
  - Microsoft.MachineLearningServices/stable/2022-05-01/machineLearningServices.json
  - Microsoft.MachineLearningServices/stable/2022-05-01/mfe.json
  - Microsoft.MachineLearningServices/stable/2022-05-01/workspaceFeatures.json
```

### Tag: package-2022-02-01-preview

These settings apply only when `--tag=package-2022-02-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2022-02-01-preview'
input-file:
  - Microsoft.MachineLearningServices/preview/2022-02-01-preview/machineLearningServices.json
  - Microsoft.MachineLearningServices/preview/2022-02-01-preview/mfe.json
  - Microsoft.MachineLearningServices/preview/2022-02-01-preview/workspaceFeatures.json
```

### Tag: package-2022-01-01-preview

These settings apply only when `--tag=package-2022-01-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2022-01-01-preview'
input-file:
  - Microsoft.MachineLearningServices/preview/2022-01-01-preview/machineLearningServices.json
  - Microsoft.MachineLearningServices/preview/2022-01-01-preview/workspaceFeatures.json
  - Microsoft.MachineLearningServices/preview/2022-01-01-preview/workspaceSkus.json
```

### Tag: package-2021-07-01

These settings apply only when `--tag=package-2021-07` is specified on the command line.

``` yaml $(tag) == 'package-2021-07-01'
input-file:
  - Microsoft.MachineLearningServices/stable/2021-07-01/machineLearningServices.json
  - Microsoft.MachineLearningServices/stable/2021-07-01/workspaceFeatures.json
  - Microsoft.MachineLearningServices/stable/2021-07-01/workspaceSkus.json
```

### Tag: package-2021-04-01

These settings apply only when `--tag=package-2021-04` is specified on the command line.

``` yaml $(tag) == 'package-2021-04-01'
input-file:
  - Microsoft.MachineLearningServices/stable/2021-04-01/machineLearningServices.json
```

### Tag: package-2021-01-01

These settings apply only when `--tag=package-2021-01` is specified on the command line.

``` yaml $(tag) == 'package-2021-01-01'
input-file:
  - Microsoft.MachineLearningServices/stable/2021-01-01/machineLearningServices.json
```

### Tag: package-2021-03-01-preview

These settings apply only when `--tag=package-2021-03-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2021-03-01-preview'
input-file:
  - Microsoft.MachineLearningServices/preview/2021-03-01-preview/machineLearningServices.json
  - Microsoft.MachineLearningServices/preview/2021-03-01-preview/mfe.json
  - Microsoft.MachineLearningServices/preview/2021-03-01-preview/workspaceFeatures.json
  - Microsoft.MachineLearningServices/preview/2021-03-01-preview/workspaceSkus.json
```

### Tag: package-2020-08-01

These settings apply only when `--tag=package-2020-08` is specified on the command line.

``` yaml $(tag) == 'package-2020-08-01'
input-file:
  - Microsoft.MachineLearningServices/stable/2020-08-01/machineLearningServices.json
```

### Tag: package-2020-06-01

These settings apply only when `--tag=package-2020-06` is specified on the command line.

``` yaml $(tag) == 'package-2020-06-01'
input-file:
  - Microsoft.MachineLearningServices/stable/2020-06-01/machineLearningServices.json
```

### Tag: package-preview-2020-05

These settings apply only when `--tag=package-preview-2020-05` is specified on the command line.

``` yaml $(tag) == 'package-preview-2020-05'
input-file:
  - Microsoft.MachineLearningServices/preview/2020-05-15-preview/machineLearningServices.json
```

### Tag: package-2020-04-01

These settings apply only when `--tag=package-2020-04` is specified on the command line.

``` yaml $(tag) == 'package-2020-04-01'
input-file:
  - Microsoft.MachineLearningServices/stable/2020-04-01/machineLearningServices.json
```

### Tag: package-2020-03-01

These settings apply only when `--tag=package-2020-03` is specified on the command line.

``` yaml $(tag) == 'package-2020-03-01'
input-file:
  - Microsoft.MachineLearningServices/stable/2020-03-01/machineLearningServices.json
```

### Tag: package-2020-01-01

These settings apply only when `--tag=package-2020-01` is specified on the command line.

``` yaml $(tag) == 'package-2020-01-01'
input-file:
  - Microsoft.MachineLearningServices/stable/2020-01-01/machineLearningServices.json
```

### Tag: package-2019-11-01

These settings apply only when `--tag=package-2019-11` is specified on the command line.

``` yaml $(tag) == 'package-2019-11-01'
input-file:
  - Microsoft.MachineLearningServices/stable/2019-11-01/machineLearningServices.json
```

### Tag: package-2019-06-01

These settings apply only when `--tag=package-2019-06-01` is specified on the command line.

``` yaml $(tag) == 'package-2019-06-01'
input-file:
- Microsoft.MachineLearningServices/stable/2019-06-01/machineLearningServices.json
```

### Tag: package-2019-05-01

These settings apply only when `--tag=package-2019-05-01` is specified on the command line.

``` yaml $(tag) == 'package-2019-05-01'
input-file:
- Microsoft.MachineLearningServices/stable/2019-05-01/machineLearningServices.json
```

### Tag: package-2018-11-19

These settings apply only when `--tag=package-2018-11-19` is specified on the command line.

``` yaml $(tag) == 'package-2018-11-19'
input-file:
- Microsoft.MachineLearningServices/stable/2018-11-19/machineLearningServices.json
```

### Tag: package-2020-09-01-preview

These settings apply only when `--tag=package-2020-09-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2020-09-01-preview'
input-file:
- Microsoft.MachineLearningServices/preview/2020-09-01-preview/jobs.json
- Microsoft.MachineLearningServices/preview/2020-09-01-preview/machineLearningServices.json
```

### Tag: package-2020-05-01-preview

These settings apply only when `--tag=package-2020-05-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2020-05-01-preview'
input-file:
- Microsoft.MachineLearningServices/preview/2020-05-01-preview/machineLearningServices.json
```

### Tag: package-2020-04-01-preview

These settings apply only when `--tag=package-2020-04-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2020-04-01-preview'
input-file:
- Microsoft.MachineLearningServices/preview/2020-04-01-preview/machineLearningServices.json
```

### Tag: package-2020-02-18-preview

These settings apply only when `--tag=package-2020-02-18-preview` is specified on the command line.

``` yaml $(tag) == 'package-2020-02-18-preview'
input-file:
- Microsoft.MachineLearningServices/preview/2020-02-18-preview/machineLearningServices.json
```

### Tag: package-2018-03-preview

These settings apply only when `--tag=package-2018-03-preview` is specified on the command line.

``` yaml $(tag) == 'package-2018-03-preview'
input-file:
- Microsoft.MachineLearningServices/preview/2018-03-01-preview/machineLearningServices.json
```

---

# Code Generation

## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

``` yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-net-track2
  - repo: azure-sdk-for-go
  - repo: azure-sdk-for-python
  - repo: azure-sdk-for-java
  - repo: azure-sdk-for-js
  - repo: azure-sdk-for-node
  - repo: azure-cli-extensions
  - repo: azure-resource-manager-schemas
  - repo: azure-powershell
```

## C#

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

``` yaml $(csharp)
csharp:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: Microsoft.Azure.Management.MachineLearningServices
  output-folder: $(csharp-sdks-folder)/machinelearningservices/Microsoft.Azure.Management.MachineLearningServices/src/Generated
  clear-output-folder: true
```

## Go

See configuration in [readme.go.md](./readme.go.md)

## Java

See configuration in [readme.java.md](./readme.java.md)
