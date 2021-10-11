# API scenario integrate with armTemplate

## Background

In some cases, we need to do some more complex operations before creating a resource. For example,

- Create Azure SignalR service with a global unique name. Using ARMTemplate to generate a random unique string.
- Create VM with a storage account. Using ARMTemplate to provision storage account and passing the storage account resourceId as VM creation parameter.

## Examples

Here is an example about `generate unique resource name for signalR service`

#### Generate unique resource name

We use `armTemplate output` to overwrite `resourceName` variable and following `createResource` step will use this variable. Below is generate unique name armTemplate. This armTemplate output `resourceName` variables, so API scenario following step will using the output variable.

```json
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    "resourceNamePrefix": {
      "type": "string",
      "defaultValue": "signalr-"
    }
  },
  "variables": {
    "resourceName": "[concat(parameters('resourceNamePrefix'), uniqueString(resourceGroup().id))]"
  },
  "resources": [],
  "outputs": {
    "resourceName": {
      "type": "string",
      "value": "[variables('resourceName')]"
    }
  }
}
```

After we have this armTemplate, we could define current API scenario file. We defined `resourceName` variable globally. `./generate_unique_string.json` is armTemplate.

`SignalR_CreateOrUpdate.json`

```json
{
  "parameters": {
    "parameters": {
      "tag": {
        "key1": "tag1"
      },
      "properties":{
        ...
      }
    },
    "api-version": "2020-07-01-preview",
    "subscriptionId": "00000000-0000-0000-0000-000000000000",
    "resourceGroupName": "myResourceGroup",
    "resourceName": "mySignalRService123xx"
  },
  "responses": {
    "200": {
      "body": {
        ...
      }
    },
    "201": {
      "body": {
        ...
      }
    },
    "202": {}
  }
}
```

> NOTE: the example file `../examples/SignalR_CreateOrUpdate` has the same parameter name `resourceName`. So it will be automatically overwrite in runner.

```yaml
scope: ResourceGroup
variables:
  resourceName: ""
scenarios:
  - scenario: quickStart
    description: Microsoft.SignalRService/signalR CRUD
    steps:
      - step: Generate_Unique_string
        armTemplateDeployment: ./generate_unique_string.json
      - step: SignalR_checknameAvailability
        exampleFile: ../examples/SignalR_CheckNameAvailability.json
      - step: SignalR_CreateOrUpdate
        exampleFile: ../examples/SignalR_CreateOrUpdate.json
      - step: SignalR_ListKey
        exampleFile: ../examples/SignalR_ListKeys.json
      - step: SignalR_Delete
        exampleFile: ../examples/SignalR_Delete.json
```

**Result**:

![](./armTemplate.png)

## Reference

- [ARMTemplate deployment script](https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/deployment-script-template)
