

```yaml
library-name: DefenderEasm
isAzureSpec: true
isArm: true
require: https://github.com/Azure/azure-rest-api-specs/blob/23d88533ddfde4d1565a897fe95d42fb0d9333e5/specification/riskiq/resource-manager/readme.md
#tag: package-preview-2023-04
skip-csproj: true
modelerfour:
    flatten-payloads: false

#mgmt-debug:
#  show-serialized-names: true

rename-mapping:
    LabelResource: EasmLabel
    LabelResourceList: EasmLabelListResult
    ResourceState: EasmResourceProvisioningState
    TaskResource: EasmTask
    WorkspaceResource: EasmWorkspace
    WorkspaceResourceList: EasmWorkspaceListResult

override-operation-name:
    Tasks_GetByWorkspace: GetTaskByWorkspace

format-by-name-rules:
    "tenantId": "uuid"
    "ETag": "etag"
    "location": "azure-location"
    "*Uri": "Uri"
    "*Uris": "Uri"


request-path-is-non-resource:
    - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Easm/workspaces/{workspaceName}/tasks/{taskId}
```
