## Swagger Changes

### Changes for `$ref`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/{scope}/providers/microsoft.Security/compliances'].get.parameters[0].$ref__deleted` | deleted | `./common/v1/types.json#/parameters/Scope` |
| `paths['/{scope}/providers/microsoft.Security/informationProtectionPolicies'].get.parameters[0].$ref__deleted` | deleted | `./common/v1/types.json#/parameters/Scope` |

### Changes for `name`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/{scope}/providers/microsoft.Security/compliances'].get.parameters[0].name__added` | added | `scope` |
| `paths['/{scope}/providers/microsoft.Security/informationProtectionPolicies'].get.parameters[0].name__added` | added | `scope` |

### Changes for `in`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/{scope}/providers/microsoft.Security/compliances'].get.parameters[0].in__added` | added | `path` |
| `paths['/{scope}/providers/microsoft.Security/informationProtectionPolicies'].get.parameters[0].in__added` | added | `path` |

### Changes for `required`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AutoProvisioningSettingList.required__added` | added | `["value"]` |
| `definitions.ComplianceList.required__added` | added | `["value"]` |
| `definitions.InformationProtectionPolicyList.required__added` | added | `["value"]` |
| `paths['/{scope}/providers/microsoft.Security/compliances'].get.parameters[0].required__added` | added | `true` |
| `paths['/{scope}/providers/microsoft.Security/informationProtectionPolicies'].get.parameters[0].required__added` | added | `true` |

### Changes for `type`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.InformationProtectionPolicyProperties.properties.informationTypes.additionalProperties.type__deleted` | deleted | `object` |
| `definitions.InformationProtectionPolicyProperties.properties.labels.additionalProperties.type__deleted` | deleted | `object` |
| `paths['/{scope}/providers/microsoft.Security/compliances'].get.parameters[0].type__added` | added | `string` |
| `paths['/{scope}/providers/microsoft.Security/informationProtectionPolicies'].get.parameters[0].type__added` | added | `string` |

### Changes for `x-ms-skip-url-encoding`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/{scope}/providers/microsoft.Security/compliances'].get.parameters[0]['x-ms-skip-url-encoding__added']` | added | `true` |
| `paths['/{scope}/providers/microsoft.Security/informationProtectionPolicies'].get.parameters[0]['x-ms-skip-url-encoding__added']` | added | `true` |

### Changes for `CloudError`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CloudError__added` | added | `{"type":"object","description":"Common error response for all Azure Resource Manager APIs to return ...` |

### Changes for `CloudErrorBody`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CloudErrorBody__added` | added | `{"type":"object","description":"The error detail.","properties":{"code":{"type":"string","descriptio...` |

### Changes for `ErrorAdditionalInfo`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ErrorAdditionalInfo__added` | added | `{"type":"object","description":"The resource management error additional info.","properties":{"type"...` |

### Changes for `readOnly`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Compliance.readOnly__deleted` | deleted | `true` |
| `definitions.ComplianceList.readOnly__deleted` | deleted | `true` |
| `definitions.InformationProtectionPolicyList.readOnly__deleted` | deleted | `true` |

### Changes for `format`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ComplianceProperties.properties.resourceCount.format__added` | added | `int32` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `definitions.AutoProvisioningSetting.allOf[0].$ref` | `./common/v1/types.json#/definitions/Resource` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.Compliance.allOf[0].$ref` | `./common/v1/types.json#/definitions/Resource` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.InformationProtectionPolicy.allOf[0].$ref` | `./common/v1/types.json#/definitions/Resource` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.WorkspaceSetting.allOf[0].$ref` | `./common/v1/types.json#/definitions/Resource` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `paths['/{scope}/providers/microsoft.Security/compliances'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/{scope}/providers/microsoft.Security/compliances/{complianceName}'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/{scope}/providers/microsoft.Security/informationProtectionPolicies'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/{scope}/providers/microsoft.Security/informationProtectionPolicies/{informationProtectionPolicyName}'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/{scope}/providers/microsoft.Security/informationProtectionPolicies/{informationProtectionPolicyName}'].put.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/autoProvisioningSettings'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/autoProvisioningSettings/{settingName}'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/autoProvisioningSettings/{settingName}'].put.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/workspaceSettings'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/workspaceSettings/{workspaceSettingName}'].delete.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/workspaceSettings/{workspaceSettingName}'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/workspaceSettings/{workspaceSettingName}'].patch.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/workspaceSettings/{workspaceSettingName}'].put.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |

