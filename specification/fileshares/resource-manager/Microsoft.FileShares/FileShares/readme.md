# Azure API Center




> see https://aka.ms/autorest



This is the AutoRest configuration file for Azure API Center.




## Getting Started




To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:




> `autorest readme.md`



To see additional help and options, run:




> `autorest --help`



For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.




---




## Configuration




### Basic Information




These are the global settings for the Azure API Center.




``` yaml

openapi-type: arm

tag: package-2025-06-01-preview

```



### Tag: package-2025-06-01-preview



These settings apply only when `--tag=package-2025-06-01-preview` is specified on the command line.




```yaml $(tag) == 'package-2025-06-01-preview'

input-file:

  - preview/2025-06-01-preview/fileshares.json

```




### Suppression




``` yaml

directive:

  - suppress: PreviewVersionOverOneYear

    reason: We are still due to go public preview in next quarter.

  - suppress: AvoidAdditionalProperties

    reason: 1. These are created as part of Record<string> and properties constructs.

  - suppress: OperationIdNounVerb

    reason: FileShare is both in parent and child resource.

    where:

      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.FileShares/fileShares/{resourceName}/fileShareSnapshots"].get.operationId

      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.FileShares/fileShares/{resourceName}/fileShareSnapshots/{name}"].put.operationId

      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.FileShares/fileShares/{resourceName}/fileShareSnapshots/{name}"].get.operationId

      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.FileShares/fileShares/{resourceName}/fileShareSnapshots/{name}"].delete.operationId

      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.FileShares/fileShares/{resourceName}/fileShareSnapshots/{name}"].patch.operationId

  - suppress: ProvisioningStateSpecifiedForLROPut

    reason: "RP doesn't support 201 Created pattern for proxy resources in public preview. To be addressed in GA."

    where:

      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.FileShares/fileShares/{resourceName}/fileShareSnapshots/{name}"].put

  - suppress: ProvisioningStateSpecifiedForLROPatch

    reason: "RP doesn't support 201 Created pattern for proxy resources in public preview. To be addressed in GA."

    where:

      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.FileShares/fileShares/{resourceName}/fileShareSnapshots/{name}"].patch.responses["200"]

  - suppress: PutResponseCodes

    reason: "RP doesn't support 201 Created pattern for proxy resources in public preview. To be addressed in GA."

    where:

      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.FileShares/fileShares/{resourceName}/fileShareSnapshots/{name}"].put

  - suppress: PutGetPatchResponseSchema

    reason: "Cannot support same schema object for PUT/GET/PATCH for proxy object due to 202 response"

    where:

      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.FileShares/fileShares/{resourceName}/fileShareSnapshots/{name}"]

```




---
