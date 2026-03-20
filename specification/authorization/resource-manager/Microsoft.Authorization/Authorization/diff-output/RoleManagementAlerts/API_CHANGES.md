## Swagger Changes

### Changes for `description`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CloudError.properties.error.description__added` | added | `An error response from the service.` |
| `paths['/{scope}/providers/microsoft.Authorization/roleManagementAlerts/{alertId}/refresh'].post.responses.202.headers.Location.description__added` | added | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/{scope}/providers/microsoft.Authorization/roleManagementAlerts/refresh'].post.responses.202.headers.Location.description__added` | added | `The Location header contains the URL where the status of the long running operation can be checked.` |

### Changes for `allOf`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Alert.allOf__added` | added | `[{"$ref":"../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource"}]` |
| `definitions.AlertConfiguration.allOf__added` | added | `[{"$ref":"../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource"}]` |
| `definitions.AlertDefinition.allOf__added` | added | `[{"$ref":"../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource"}]` |
| `definitions.AlertIncident.allOf__added` | added | `[{"$ref":"../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource"}]` |

### Changes for `id`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Alert.properties.id__deleted` | deleted | `{"type":"string","description":"The alert ID.","readOnly":true}` |
| `definitions.AlertConfiguration.properties.id__deleted` | deleted | `{"type":"string","description":"The alert configuration ID.","readOnly":true}` |
| `definitions.AlertDefinition.properties.id__deleted` | deleted | `{"type":"string","description":"The alert definition ID.","readOnly":true}` |
| `definitions.AlertIncident.properties.id__deleted` | deleted | `{"type":"string","description":"The alert incident ID.","readOnly":true}` |

### Changes for `name`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Alert.properties.name__deleted` | deleted | `{"type":"string","description":"The alert name.","readOnly":true}` |
| `definitions.AlertConfiguration.properties.name__deleted` | deleted | `{"type":"string","description":"The alert configuration name.","readOnly":true}` |
| `definitions.AlertDefinition.properties.name__deleted` | deleted | `{"type":"string","description":"The alert definition name.","readOnly":true}` |
| `definitions.AlertIncident.properties.name__deleted` | deleted | `{"type":"string","description":"The alert incident name.","readOnly":true}` |

### Changes for `type`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Alert.properties.type__deleted` | deleted | `{"type":"string","description":"The alert type.","readOnly":true}` |
| `definitions.AlertConfiguration.properties.type__deleted` | deleted | `{"type":"string","description":"The alert configuration type.","readOnly":true}` |
| `definitions.AlertDefinition.properties.type__deleted` | deleted | `{"type":"string","description":"The alert definition type.","readOnly":true}` |
| `definitions.AlertIncident.properties.type__deleted` | deleted | `{"type":"string","description":"The alert incident type.","readOnly":true}` |

### Changes for `x-ms-client-flatten`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AlertConfiguration.properties.properties['x-ms-client-flatten__deleted']` | deleted | `true` |
| `definitions.AlertIncident.properties.properties['x-ms-client-flatten__deleted']` | deleted | `true` |

### Changes for `required`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AlertConfigurationListResult.required__added` | added | `["value"]` |
| `definitions.AlertDefinitionListResult.required__added` | added | `["value"]` |
| `definitions.AlertIncidentListResult.required__added` | added | `["value"]` |
| `definitions.AlertListResult.required__added` | added | `["value"]` |

### Changes for `readOnly`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AlertConfigurationProperties.properties.alertConfigurationType.readOnly__deleted` | deleted | `false` |
| `definitions.AlertConfigurationProperties.properties.isEnabled.readOnly__deleted` | deleted | `false` |
| `definitions.AlertIncidentProperties.properties.alertIncidentType.readOnly__deleted` | deleted | `false` |
| `definitions.TooManyOwnersAssignedToResourceAlertConfigurationProperties.properties.thresholdNumberOfOwners.readOnly__deleted` | deleted | `false` |
| `definitions.TooManyOwnersAssignedToResourceAlertConfigurationProperties.properties.thresholdPercentageOfOwnersOutOfAllRoleMembers.readOnly__deleted` | deleted | `false` |
| `definitions.TooManyPermanentOwnersAssignedToResourceAlertConfigurationProperties.properties.thresholdNumberOfPermanentOwners.readOnly__deleted` | deleted | `false` |
| `definitions.TooManyPermanentOwnersAssignedToResourceAlertConfigurationProperties.properties.thresholdPercentageOfPermanentOwnersOutOfAllOwners.readOnly__deleted` | deleted | `false` |

