// Copyright (c) 2021 Microsoft Corporation
//
// This software is released under the MIT License.
// https://opensource.org/licenses/MIT

# Test scenario integrate with armTemplate

## Background

In some cases, we need to do some more complex operations before creating a resource. For example, some Azure resource name is global unique, so we need to generate an unique name before create resource. some Azure resource creation relays on some external dependency such as storage account, keyVault certificate. ARMTemplate can meet this requirement.

## Examples

#### Generate unique resource name

We use `armTemplate output` to overwrite `resourceName` variable and following `createResource` step will use this variable. Below is generate unique name armTemplate. This armTemplate output `resourceName` variables, so test scenario following step will using the output variable.

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

After we have this armTemplate, we could define current test scenario file. We defined `resourceName` variable globally. `./generate_unique_string.json` is armTemplate.

```yaml
scope: ResourceGroup
variables:
  resourceName: ""
testScenarios:
  - description: Microsoft.SignalRService/signalR CRUD
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
