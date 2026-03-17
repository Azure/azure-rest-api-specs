## Swagger Changes

### Changes for `$ref`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.IoTSecurityAggregatedAlertProperties.properties.topDevicesList.items.$ref__added` | added | `#/definitions/IoTSecurityAggregatedAlertPropertiesTopDevicesListItem` |
| `definitions.IoTSecuritySolutionAnalyticsModelProperties.properties.devicesMetrics.items.$ref__added` | added | `#/definitions/IoTSecuritySolutionAnalyticsModelPropertiesDevicesMetricsItem` |
| `definitions.IoTSecuritySolutionAnalyticsModelProperties.properties.mostPrevalentDeviceAlerts.$ref__deleted` | deleted | `#/definitions/IoTSecurityDeviceAlertsList` |
| `definitions.IoTSecuritySolutionAnalyticsModelProperties.properties.mostPrevalentDeviceRecommendations.$ref__deleted` | deleted | `#/definitions/IoTSecurityDeviceRecommendationsList` |
| `definitions.IoTSecuritySolutionAnalyticsModelProperties.properties.topAlertedDevices.$ref__deleted` | deleted | `#/definitions/IoTSecurityAlertedDevicesList` |
| `definitions.IoTSecuritySolutionProperties.properties.recommendationsConfiguration.$ref__deleted` | deleted | `#/definitions/RecommendationConfigurationList` |
| `definitions.UpdateIoTSecuritySolutionProperties.properties.recommendationsConfiguration.$ref__deleted` | deleted | `#/definitions/RecommendationConfigurationList` |
| `paths['/{resourceId}/providers/microsoft.Security/deviceSecurityGroups'].get.parameters[0].$ref__deleted` | deleted | `./common/v1/types.json#/parameters/ResourceId` |

### Changes for `name`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/{resourceId}/providers/microsoft.Security/deviceSecurityGroups'].get.parameters[0].name__added` | added | `resourceId` |

### Changes for `in`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/{resourceId}/providers/microsoft.Security/deviceSecurityGroups'].get.parameters[0].in__added` | added | `path` |

### Changes for `required`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DeviceSecurityGroupList.required__added` | added | `["value"]` |
| `definitions.ListCustomAlertRule.required__added` | added | `["ruleType"]` |
| `paths['/{resourceId}/providers/microsoft.Security/deviceSecurityGroups'].get.parameters[0].required__added` | added | `true` |

### Changes for `type`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DeviceSecurityGroupProperties.properties.allowlistRules.items.type__deleted` | deleted | `object` |
| `definitions.DeviceSecurityGroupProperties.properties.denylistRules.items.type__deleted` | deleted | `object` |
| `definitions.DeviceSecurityGroupProperties.properties.thresholdRules.items.type__deleted` | deleted | `object` |
| `definitions.DeviceSecurityGroupProperties.properties.timeWindowRules.items.type__deleted` | deleted | `object` |
| `definitions.IoTSecuritySolutionAnalyticsModelProperties.properties.metrics.type__deleted` | deleted | `object` |
| `definitions.IoTSecuritySolutionProperties.properties.recommendationsConfiguration.type__added` | added | `array` |
| `definitions.UpdateIoTSecuritySolutionProperties.properties.recommendationsConfiguration.type__added` | added | `array` |
| `paths['/{resourceId}/providers/microsoft.Security/deviceSecurityGroups'].get.parameters[0].type__added` | added | `string` |

### Changes for `x-ms-skip-url-encoding`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/{resourceId}/providers/microsoft.Security/deviceSecurityGroups'].get.parameters[0]['x-ms-skip-url-encoding__added']` | added | `true` |

### Changes for `IoTSecurityAlertedDevicesList`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.IoTSecurityAlertedDevicesList__deleted` | deleted | `{"type":"array","description":"List of devices with open alerts including the count of alerts per de...` |

### Changes for `IoTSecurityDeviceAlertsList`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.IoTSecurityDeviceAlertsList__deleted` | deleted | `{"type":"array","description":"List of alerts with the count of raised alerts","items":{"$ref":"#/de...` |

### Changes for `IoTSecurityDeviceRecommendationsList`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.IoTSecurityDeviceRecommendationsList__deleted` | deleted | `{"type":"array","description":"List of aggregated recommendation data, per recommendation type, per ...` |

### Changes for `RecommendationConfigurationList`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.RecommendationConfigurationList__deleted` | deleted | `{"type":"array","description":"List of the configuration status for each recommendation type.","item...` |

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

### Changes for `IoTSecurityAggregatedAlertPropertiesTopDevicesListItem`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.IoTSecurityAggregatedAlertPropertiesTopDevicesListItem__added` | added | `{"type":"object","properties":{"deviceId":{"type":"string","description":"Name of the device.","read...` |

### Changes for `IoTSecuritySolutionAnalyticsModelPropertiesDevicesMetricsItem`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.IoTSecuritySolutionAnalyticsModelPropertiesDevicesMetricsItem__added` | added | `{"type":"object","properties":{"date":{"type":"string","format":"date-time","description":"Aggregati...` |

### Changes for `properties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ActiveConnectionsNotInAllowedRange.properties__deleted` | deleted | `{}` |
| `definitions.AmqpC2DMessagesNotInAllowedRange.properties__deleted` | deleted | `{}` |
| `definitions.AmqpC2DRejectedMessagesNotInAllowedRange.properties__deleted` | deleted | `{}` |
| `definitions.AmqpD2CMessagesNotInAllowedRange.properties__deleted` | deleted | `{}` |
| `definitions.ConnectionFromIpNotAllowed.properties__deleted` | deleted | `{}` |
| `definitions.ConnectionToIpNotAllowed.properties__deleted` | deleted | `{}` |
| `definitions.DirectMethodInvokesNotInAllowedRange.properties__deleted` | deleted | `{}` |
| `definitions.FailedLocalLoginsNotInAllowedRange.properties__deleted` | deleted | `{}` |
| `definitions.FileUploadsNotInAllowedRange.properties__deleted` | deleted | `{}` |
| `definitions.HttpC2DMessagesNotInAllowedRange.properties__deleted` | deleted | `{}` |
| `definitions.HttpC2DRejectedMessagesNotInAllowedRange.properties__deleted` | deleted | `{}` |
| `definitions.HttpD2CMessagesNotInAllowedRange.properties__deleted` | deleted | `{}` |
| `definitions.IoTSecurityAggregatedAlertProperties.properties.topDevicesList.items.properties__deleted` | deleted | `{"deviceId":{"type":"string","description":"Name of the device.","readOnly":true},"alertsCount":{"ty...` |
| `definitions.IoTSecuritySolutionAnalyticsModelProperties.properties.devicesMetrics.items.properties__deleted` | deleted | `{"date":{"type":"string","format":"date-time","description":"Aggregation of IoT Security solution de...` |
| `definitions.LocalUserNotAllowed.properties__deleted` | deleted | `{}` |
| `definitions.MqttC2DMessagesNotInAllowedRange.properties__deleted` | deleted | `{}` |
| `definitions.MqttC2DRejectedMessagesNotInAllowedRange.properties__deleted` | deleted | `{}` |
| `definitions.MqttD2CMessagesNotInAllowedRange.properties__deleted` | deleted | `{}` |
| `definitions.ProcessNotAllowed.properties__deleted` | deleted | `{}` |
| `definitions.QueuePurgesNotInAllowedRange.properties__deleted` | deleted | `{}` |
| `definitions.TwinUpdatesNotInAllowedRange.properties__deleted` | deleted | `{}` |
| `definitions.UnauthorizedOperationsNotInAllowedRange.properties__deleted` | deleted | `{}` |

### Changes for `x-ms-discriminator-value`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ActiveConnectionsNotInAllowedRange['x-ms-discriminator-value__added']` | added | `ActiveConnectionsNotInAllowedRange` |
| `definitions.AmqpC2DMessagesNotInAllowedRange['x-ms-discriminator-value__added']` | added | `AmqpC2DMessagesNotInAllowedRange` |
| `definitions.AmqpC2DRejectedMessagesNotInAllowedRange['x-ms-discriminator-value__added']` | added | `AmqpC2DRejectedMessagesNotInAllowedRange` |
| `definitions.AmqpD2CMessagesNotInAllowedRange['x-ms-discriminator-value__added']` | added | `AmqpD2CMessagesNotInAllowedRange` |
| `definitions.ConnectionFromIpNotAllowed['x-ms-discriminator-value__added']` | added | `ConnectionFromIpNotAllowed` |
| `definitions.ConnectionToIpNotAllowed['x-ms-discriminator-value__added']` | added | `ConnectionToIpNotAllowed` |
| `definitions.DenylistCustomAlertRule['x-ms-discriminator-value__added']` | added | `DenylistCustomAlertRule` |
| `definitions.DirectMethodInvokesNotInAllowedRange['x-ms-discriminator-value__added']` | added | `DirectMethodInvokesNotInAllowedRange` |
| `definitions.FailedLocalLoginsNotInAllowedRange['x-ms-discriminator-value__added']` | added | `FailedLocalLoginsNotInAllowedRange` |
| `definitions.FileUploadsNotInAllowedRange['x-ms-discriminator-value__added']` | added | `FileUploadsNotInAllowedRange` |
| `definitions.HttpC2DMessagesNotInAllowedRange['x-ms-discriminator-value__added']` | added | `HttpC2DMessagesNotInAllowedRange` |
| `definitions.HttpC2DRejectedMessagesNotInAllowedRange['x-ms-discriminator-value__added']` | added | `HttpC2DRejectedMessagesNotInAllowedRange` |
| `definitions.HttpD2CMessagesNotInAllowedRange['x-ms-discriminator-value__added']` | added | `HttpD2CMessagesNotInAllowedRange` |
| `definitions.LocalUserNotAllowed['x-ms-discriminator-value__added']` | added | `LocalUserNotAllowed` |
| `definitions.MqttC2DMessagesNotInAllowedRange['x-ms-discriminator-value__added']` | added | `MqttC2DMessagesNotInAllowedRange` |
| `definitions.MqttC2DRejectedMessagesNotInAllowedRange['x-ms-discriminator-value__added']` | added | `MqttC2DRejectedMessagesNotInAllowedRange` |
| `definitions.MqttD2CMessagesNotInAllowedRange['x-ms-discriminator-value__added']` | added | `MqttD2CMessagesNotInAllowedRange` |
| `definitions.ProcessNotAllowed['x-ms-discriminator-value__added']` | added | `ProcessNotAllowed` |
| `definitions.QueuePurgesNotInAllowedRange['x-ms-discriminator-value__added']` | added | `QueuePurgesNotInAllowedRange` |
| `definitions.TwinUpdatesNotInAllowedRange['x-ms-discriminator-value__added']` | added | `TwinUpdatesNotInAllowedRange` |
| `definitions.UnauthorizedOperationsNotInAllowedRange['x-ms-discriminator-value__added']` | added | `UnauthorizedOperationsNotInAllowedRange` |

### Changes for `discriminator`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AllowlistCustomAlertRule.discriminator__added` | added | `ruleType` |
| `definitions.ListCustomAlertRule.discriminator__added` | added | `ruleType` |
| `definitions.ThresholdCustomAlertRule.discriminator__added` | added | `ruleType` |
| `definitions.TimeWindowCustomAlertRule.discriminator__added` | added | `ruleType` |

### Changes for `ruleType`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AllowlistCustomAlertRule.properties.ruleType__added` | added | `{"type":"string","description":"Discriminator property for AllowlistCustomAlertRule."}` |
| `definitions.ListCustomAlertRule.properties.ruleType__added` | added | `{"type":"string","description":"Discriminator property for ListCustomAlertRule."}` |
| `definitions.ThresholdCustomAlertRule.properties.ruleType__added` | added | `{"type":"string","description":"Discriminator property for ThresholdCustomAlertRule."}` |
| `definitions.TimeWindowCustomAlertRule.properties.ruleType__added` | added | `{"type":"string","description":"Discriminator property for TimeWindowCustomAlertRule."}` |

### Changes for `readOnly`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DeviceSecurityGroupList.readOnly__deleted` | deleted | `true` |

### Changes for `tags`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.IoTSecurityAggregatedAlert.properties.tags__added` | added | `{"type":"object","description":"Resource tags","additionalProperties":{"type":"string"}}` |
| `definitions.IoTSecurityAggregatedRecommendation.properties.tags__added` | added | `{"type":"object","description":"Resource tags","additionalProperties":{"type":"string"}}` |
| `definitions.IoTSecuritySolutionModel.properties.tags__added` | added | `{"type":"object","description":"Resource tags.","additionalProperties":{"type":"string"}}` |

### Changes for `items`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.IoTSecuritySolutionAnalyticsModelProperties.properties.mostPrevalentDeviceAlerts.items__added` | added | `{"$ref":"#/definitions/IoTSecurityDeviceAlert"}` |
| `definitions.IoTSecuritySolutionAnalyticsModelProperties.properties.mostPrevalentDeviceRecommendations.items__added` | added | `{"$ref":"#/definitions/IoTSecurityDeviceRecommendation"}` |
| `definitions.IoTSecuritySolutionAnalyticsModelProperties.properties.topAlertedDevices.items__added` | added | `{"$ref":"#/definitions/IoTSecurityAlertedDevice"}` |
| `definitions.IoTSecuritySolutionProperties.properties.recommendationsConfiguration.items__added` | added | `{"$ref":"#/definitions/RecommendationConfigurationProperties"}` |
| `definitions.UpdateIoTSecuritySolutionProperties.properties.recommendationsConfiguration.items__added` | added | `{"$ref":"#/definitions/RecommendationConfigurationProperties"}` |

### Changes for `systemData`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.IoTSecuritySolutionModel.properties.systemData__deleted` | deleted | `{"$ref":"../../../../../../common-types/resource-management/v2/types.json#/definitions/systemData","...` |

### Changes for `x-ms-mutability`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.IoTSecuritySolutionModel.properties.location['x-ms-mutability__added']` | added | `["create","read"]` |

### Changes for `description`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.IoTSecuritySolutionProperties.properties.recommendationsConfiguration.description__added` | added | `List of the configuration status for each recommendation type.` |
| `definitions.IoTSecuritySolutionProperties.properties.userDefinedResources.description__added` | added | `Properties of the IoT Security solution's user defined resources.` |
| `definitions.UpdateIoTSecuritySolutionProperties.properties.recommendationsConfiguration.description__added` | added | `List of the configuration status for each recommendation type.` |
| `definitions.UpdateIoTSecuritySolutionProperties.properties.userDefinedResources.description__added` | added | `Properties of the IoT Security solution's user defined resources.` |

### Changes for `pattern`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.UserDefinedResourcesProperties.properties.querySubscriptions.items.pattern__deleted` | deleted | `^[0-9A-Fa-f]{8}-([0-9A-Fa-f]{4}-){3}[0-9A-Fa-f]{12}$` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `definitions.DeviceSecurityGroup.allOf[0].$ref` | `./common/v1/types.json#/definitions/Resource` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.IoTSecurityAggregatedAlert.allOf[0].$ref` | `./common/v1/types.json#/definitions/Resource` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.IoTSecurityAggregatedRecommendation.allOf[0].$ref` | `./common/v1/types.json#/definitions/Resource` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.IoTSecurityAggregatedRecommendationProperties.properties.reportedSeverity.description` | `Assessed recommendation severity.` | `Assessed alert severity.` |
| `definitions.IoTSecurityDeviceAlert.properties.reportedSeverity.description` | `Assessed Alert severity.` | `Assessed alert severity.` |
| `definitions.IoTSecurityDeviceRecommendation.properties.reportedSeverity.description` | `Assessed recommendation severity.` | `Assessed alert severity.` |
| `definitions.IoTSecuritySolutionAnalyticsModel.allOf[0].$ref` | `./common/v1/types.json#/definitions/Resource` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.IoTSecuritySolutionAnalyticsModelProperties.properties.mostPrevalentDeviceAlerts.type` | `object` | `array` |
| `definitions.IoTSecuritySolutionAnalyticsModelProperties.properties.mostPrevalentDeviceRecommendations.type` | `object` | `array` |
| `definitions.IoTSecuritySolutionAnalyticsModelProperties.properties.topAlertedDevices.type` | `object` | `array` |
| `definitions.IoTSecuritySolutionModel.allOf[0].$ref` | `./common/v1/types.json#/definitions/Resource` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/Resource` |
| `definitions.IoTSecuritySolutionModel.properties.location.description` | `The resource location.` | `The geo-location where the resource lives` |
| `paths['/{resourceId}/providers/microsoft.Security/deviceSecurityGroups'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/{resourceId}/providers/microsoft.Security/deviceSecurityGroups/{deviceSecurityGroupName}'].delete.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/{resourceId}/providers/microsoft.Security/deviceSecurityGroups/{deviceSecurityGroupName}'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/{resourceId}/providers/microsoft.Security/deviceSecurityGroups/{deviceSecurityGroupName}'].put.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/iotSecuritySolutions'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/iotSecuritySolutions'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/iotSecuritySolutions/{solutionName}'].delete.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/iotSecuritySolutions/{solutionName}'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/iotSecuritySolutions/{solutionName}'].patch.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/iotSecuritySolutions/{solutionName}'].put.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/iotSecuritySolutions/{solutionName}/analyticsModels'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/iotSecuritySolutions/{solutionName}/analyticsModels/default'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/iotSecuritySolutions/{solutionName}/analyticsModels/default/aggregatedAlerts'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/iotSecuritySolutions/{solutionName}/analyticsModels/default/aggregatedAlerts/{aggregatedAlertName}'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/iotSecuritySolutions/{solutionName}/analyticsModels/default/aggregatedAlerts/{aggregatedAlertName}/dismiss'].post.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/iotSecuritySolutions/{solutionName}/analyticsModels/default/aggregatedRecommendations'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/iotSecuritySolutions/{solutionName}/analyticsModels/default/aggregatedRecommendations/{aggregatedRecommendationName}'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |

