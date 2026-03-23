## Swagger Changes

### Changes for `$ref`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AlertProperties.properties.extendedLinks.items.$ref__deleted` | deleted | `#/definitions/AlertExtendedLinks` |
| `definitions.AlertProperties.properties.extendedProperties.$ref__deleted` | deleted | `#/definitions/AlertExtendedProperties` |
| `definitions.AlertProperties.properties.supportingEvidence.$ref__added` | added | `#/definitions/AlertPropertiesSupportingEvidence` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/locations/{ascLocation}/alerts'].get.parameters[0].$ref__deleted` | deleted | `./common/v1/types.json#/parameters/AscLocation` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{ascLocation}/alerts'].get.parameters[0].$ref__deleted` | deleted | `./common/v1/types.json#/parameters/AscLocation` |

### Changes for `name`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/locations/{ascLocation}/alerts'].get.parameters[0].name__added` | added | `ascLocation` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{ascLocation}/alerts'].get.parameters[0].name__added` | added | `ascLocation` |

### Changes for `in`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/locations/{ascLocation}/alerts'].get.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{ascLocation}/alerts'].get.parameters[0].in__added` | added | `path` |

### Changes for `required`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/locations/{ascLocation}/alerts'].get.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{ascLocation}/alerts'].get.parameters[0].required__added` | added | `true` |

### Changes for `type`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AlertEntity.additionalProperties.type__deleted` | deleted | `object` |
| `definitions.AlertProperties.properties.extendedLinks.items.type__added` | added | `object` |
| `definitions.AlertProperties.properties.extendedProperties.type__added` | added | `object` |
| `definitions.AlertProperties.properties.supportingEvidence.type__deleted` | deleted | `object` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/locations/{ascLocation}/alerts'].get.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{ascLocation}/alerts'].get.parameters[0].type__added` | added | `string` |

### Changes for `x-ms-long-running-operation-options`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/locations/{ascLocation}/alerts/default/simulate'].post['x-ms-long-running-operation-options__deleted']` | deleted | `{"final-state-via":"original-uri"}` |

### Changes for `headers`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/locations/{ascLocation}/alerts/default/simulate'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |

### Changes for `AlertExtendedLinks`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AlertExtendedLinks__deleted` | deleted | `{"type":"object","description":"Links related to the alert","additionalProperties":{"type":"string"}...` |

### Changes for `AlertExtendedProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AlertExtendedProperties__deleted` | deleted | `{"type":"object","description":"Custom properties for the alert.","additionalProperties":{"type":"st...` |

### Changes for `AlertPropertiesSupportingEvidence`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AlertPropertiesSupportingEvidence__added` | added | `{"type":"object","description":"Changing set of properties depending on the supportingEvidence type....` |

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
| `definitions.AlertProperties.properties.remediationSteps.items.readOnly__deleted` | deleted | `true` |
| `definitions.AlertProperties.properties.subTechniques.items.readOnly__deleted` | deleted | `true` |
| `definitions.AlertProperties.properties.techniques.items.readOnly__deleted` | deleted | `true` |

### Changes for `additionalProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AlertProperties.properties.extendedLinks.items.additionalProperties__added` | added | `{"type":"string"}` |
| `definitions.AlertProperties.properties.extendedProperties.additionalProperties__added` | added | `{"type":"string"}` |
| `definitions.AlertProperties.properties.supportingEvidence.additionalProperties__deleted` | deleted | `{"type":"object"}` |

### Changes for `properties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AlertProperties.properties.supportingEvidence.properties__deleted` | deleted | `{"type":{"type":"string","description":"Type of the supportingEvidence","readOnly":true}}` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `definitions.Alert.allOf[0].$ref` | `./common/v1/types.json#/definitions/Resource` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.AlertSimulatorRequestProperties.additionalProperties` | `true` | `{}` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/alerts'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/locations/{ascLocation}/alerts'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/locations/{ascLocation}/alerts/{alertName}'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/locations/{ascLocation}/alerts/{alertName}/activate'].post.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/locations/{ascLocation}/alerts/{alertName}/dismiss'].post.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/locations/{ascLocation}/alerts/{alertName}/inProgress'].post.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/locations/{ascLocation}/alerts/{alertName}/resolve'].post.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/locations/{ascLocation}/alerts/default/simulate'].post.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/alerts'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{ascLocation}/alerts'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{ascLocation}/alerts/{alertName}'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{ascLocation}/alerts/{alertName}/activate'].post.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{ascLocation}/alerts/{alertName}/dismiss'].post.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{ascLocation}/alerts/{alertName}/inProgress'].post.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{ascLocation}/alerts/{alertName}/resolve'].post.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |

