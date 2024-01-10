

``` yaml

library-name: ApplicationInsights
isAzureSpec: true
isArm: true
require: https://github.com/Azure/azure-rest-api-specs/blob/1fea23ac36b111293dc3efc30f725e9ebb790f7f/specification/applicationinsights/resource-manager/readme.md
skip-csproj: true
modelerfour:
  flatten-payloads: false

format-by-name-rules:
  'tenantId': 'uuid'
  'ETag': 'etag'
  'location': 'azure-location'
  '*Uri': 'Uri'
  '*Uris': 'Uri'


list-exception:
  - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.insights/components/{resourceName}/linkedStorageAccounts/{storageType}

rename-mapping:
  WebTest.properties.Frequency: FrequencyInSeconds
  WebTest.properties.Timeout: TimeoutInSeconds
  ApplicationInsightsComponent.properties.DisableIpMasking: IsDisableIpMasking
  ApplicationInsightsComponent.properties.ImmediatePurgeDataOn30Days: IsImmediatePurgeDataOn30Days
  ApplicationInsightsComponent.properties.DisableLocalAuth: IsDisableLocalAuth
  ApplicationInsightsComponent.properties.ForceCustomerStorageForProfiler: IsForceCustomerStorageForProfiler
  MyWorkbook.properties.tags: Tags
  Workbook.properties.tags: Tags
  WebTest.properties.Enabled: IsEnabled
  Workbook.properties.timeModified: ModifiedOn
  WorkbookTemplate.properties.localized: LocalizedGalleries
  ApplicationInsightsComponentDataVolumeCap.StopSendNotificationWhenHitThreshold: IsStopSendNotificationWhenHitThreshold
  ApplicationInsightsComponentDataVolumeCap.StopSendNotificationWhenHitCap: IsStopSendNotificationWhenHitCap
  ApplicationInsightsComponentProactiveDetectionConfiguration.Enabled: IsEnabled
  WorkItemCreateConfiguration.ValidateOnly: IsValidateOnly
  WebTest.properties.RetryEnabled: IsRetryEnabled
  WebTestPropertiesValidationRules.SSLCheck: CheckSsl
  ApplicationInsightsComponentFeature.ResouceId: ResourceId
  ItemScopePath.myanalyticsItems: MyAnalyticsItems
  MyWorkbookResource: MyWorkbookResourceContent
  PrivateLinkScopedResource: PrivateLinkScopedResourceContent
  TagsResource: ComponentTag

directive:
  - from: webTestLocations_API.json
    where: $.definitions
    transform: >
      $["ApplicationInsightsWebTestLocationsListResult"] = {
        "description": "Describes the list of web test locations available to an Application Insights Component.",
        "type": "array",
        "items": {
          "$ref": "#/definitions/ApplicationInsightsComponentWebTestLocation"
        },
        "x-ms-identifiers": [
          "DisplayName"
        ]
      }
    reason: workaround incorrect definition in swagger
  - where-operation: webTestLocations_List
    debug: true
    transform: >
      delete $["x-ms-pageable"]

override-operation-name:
  ComponentQuotaStatus_Get: GetComponentQuotaStatus
```
