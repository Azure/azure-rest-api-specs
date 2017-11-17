# ApplicationInsights
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for ApplicationInsights.



---
## Getting Started 
To build the SDK for ApplicationInsights, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration



### Basic Information 
These are the global settings for the ApplicationInsights API.

``` yaml
title: ApplicationInsightsManagementClient
description: Composite Swagger for Application Insights Management Client
openapi-type: arm
tag: package-2015-05
azure-validator: true
```

## Suppression
``` yaml
directive:
  - suppress: TrackedResourceListByImmediateParent
    reason: we do have a list api to get all export configuraitons as "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.insights/components/{resourceName}/exportconfiguration"
    #where:
    #  -   $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.insights/components/{resourceName}/exportconfiguration/{exportId}  

  - suppress: PutRequestResponseScheme
    reason: This api was existing there from 2015, it will break existing client if we change the request/response format
    #where:
    #  - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.insights/components/{resourceName}/exportconfiguration/{exportId}"].put

  - suppress: ListInOperationName
    reason: The return value is an object, not an array. Looks like a false positive of the validation tool.
    #where:
    #  - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.insights/components/{resourceName}/currentbillingfeatures"].get.operationId

  - suppress: PutInOperationName
    reason: We are not doing create on this api, it is only doing update in this PUT api call.
    #where:
    #  - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.insights/components/{resourceName}/exportconfiguration/{exportId}"].put.operationId
    #  - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.insights/components/{resourceName}/currentbillingfeatures"].put.operationId
  
  - suppress: XmsResourceInPutResponse
    reason: This api was existing there from 2015, it will break existing client if we change the request/response format
    #where:
    #  - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.insights/components/{resourceName}/exportconfiguration/{exportId}"].put
    #  - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.insights/components/{resourceName}/currentbillingfeatures"].put 

  - suppress: RequiredPropertiesMissingInResourceModel  
    reason: This api was existing there from 2015, it will break existing client if we change the response format
    #where:
    #  - $.definitions.ApplicationInsightsComponentExportConfiguration
    #  - $.definitions.ApplicationInsightsComponentBillingFeatures

  - suppress: BodyTopLevelProperties
    reason: This api was existing there from 2015, it will break existing client if we change the response format
    #where:
    #  - $.definitions.ApplicationInsightsComponentExportConfiguration.properties
    #  - $.definitions.ApplicationInsightsComponentBillingFeatures.properties

  - suppress: EnumInsteadOfBoolean
    reason: This api was existing there from 2015, it will break existing client if we change the type
    #where:
    #  - $.definitions.WebTestProperties.properties.Enabled
    #  - $.definitions.WebTestProperties.properties.RetryEnabled
    #  - $.definitions.ApplicationInsightsComponentDataVolumeCap.properties.StopSendNotificationWhenHitThreshold
    #  - $.definitions.ApplicationInsightsComponentDataVolumeCap.properties.StopSendNotificationWhenHitCap
    #  - $.definitions.ApplicationInsightsComponentQuotaStatus.properties.ShouldBeThrottled

  - suppress: DefinitionsPropertiesNamesCamelCase
    reason: This api was existing there from 2015, it will break existing client if we change the name
    #where:
    #  - $.definitions.ApplicationInsightsComponentProperties.properties.ApplicationId
    #  - $.definitions.ApplicationInsightsComponentProperties.properties.AppId
    #  - $.definitions.ApplicationInsightsComponentProperties.properties.Application_Type
    #  - $.definitions.ApplicationInsightsComponentProperties.properties.Flow_Type
    #  - $.definitions.ApplicationInsightsComponentProperties.properties.Request_Source
    #  - $.definitions.ApplicationInsightsComponentProperties.properties.InstrumentationKey
    #  - $.definitions.ApplicationInsightsComponentProperties.properties.CreationDate
    #  - $.definitions.ApplicationInsightsComponentProperties.properties.TenantId
    #  - $.definitions.ApplicationInsightsComponentProperties.properties.HockeyAppId
    #  - $.definitions.ApplicationInsightsComponentProperties.properties.HockeyAppToken
    #  - $.definitions.ApplicationInsightsComponentProperties.properties.SamplingPercentage
    #  - $.definitions.WebTestProperties.properties.SyntheticMonitorId
    #  - $.definitions.WebTestProperties.properties.Name
    #  - $.definitions.WebTestProperties.properties.Description
    #  - $.definitions.WebTestProperties.properties.Enabled
    #  - $.definitions.WebTestProperties.properties.Frequency
    #  - $.definitions.WebTestProperties.properties.Timeout
    #  - $.definitions.WebTestProperties.properties.Kind
    #  - $.definitions.WebTestProperties.properties.RetryEnabled
    #  - $.definitions.WebTestProperties.properties.Locations
    #  - $.definitions.WebTestProperties.properties.Configuration
    #  - $.definitions.WebTestGeolocation.properties.Id 
    #  - $.definitions.ApplicationInsightsComponentExportRequest.properties.RecordTypes
    #  - $.definitions.ApplicationInsightsComponentExportRequest.properties.DestinationType
    #  - $.definitions.ApplicationInsightsComponentExportRequest.properties.DestinationAddress
    #  - $.definitions.ApplicationInsightsComponentExportRequest.properties.IsEnabled
    #  - $.definitions.ApplicationInsightsComponentExportRequest.properties.NotificationQueueEnabled
    #  - $.definitions.ApplicationInsightsComponentExportRequest.properties.NotificationQueueUri
    #  - $.definitions.ApplicationInsightsComponentExportRequest.properties.DestinationStorageSubscriptionId
    #  - $.definitions.ApplicationInsightsComponentExportRequest.properties.DestinationStorageLocationId
    #  - $.definitions.ApplicationInsightsComponentExportRequest.properties.DestinationAccountId
    #  - $.definitions.ApplicationInsightsComponentExportConfiguration.properties.ExportId
    #  - $.definitions.ApplicationInsightsComponentExportConfiguration.properties.InstrumentationKey
    #  - $.definitions.ApplicationInsightsComponentExportConfiguration.properties.RecordTypes
    #  - $.definitions.ApplicationInsightsComponentExportConfiguration.properties.ApplicationName
    #  - $.definitions.ApplicationInsightsComponentExportConfiguration.properties.SubscriptionId
    #  - $.definitions.ApplicationInsightsComponentExportConfiguration.properties.ResourceGroup
    #  - $.definitions.ApplicationInsightsComponentExportConfiguration.properties.DestinationStorageSubscriptionId
    #  - $.definitions.ApplicationInsightsComponentExportConfiguration.properties.DestinationStorageLocationId
    #  - $.definitions.ApplicationInsightsComponentExportConfiguration.properties.DestinationAccountId
    #  - $.definitions.ApplicationInsightsComponentExportConfiguration.properties.DestinationType
    #  - $.definitions.ApplicationInsightsComponentExportConfiguration.properties.IsUserEnabled
    #  - $.definitions.ApplicationInsightsComponentExportConfiguration.properties.LastUserUpdate
    #  - $.definitions.ApplicationInsightsComponentExportConfiguration.properties.NotificationQueueEnabled
    #  - $.definitions.ApplicationInsightsComponentExportConfiguration.properties.ExportStatus
    #  - $.definitions.ApplicationInsightsComponentExportConfiguration.properties.LastSuccessTime
    #  - $.definitions.ApplicationInsightsComponentExportConfiguration.properties.LastGapTime
    #  - $.definitions.ApplicationInsightsComponentExportConfiguration.properties.PermanentErrorReason
    #  - $.definitions.ApplicationInsightsComponentExportConfiguration.properties.StorageName
    #  - $.definitions.ApplicationInsightsComponentExportConfiguration.properties.ContainerName
    #  - $.definitions.ApplicationInsightsComponentBillingFeatures.properties.DataVolumeCap
    #  - $.definitions.ApplicationInsightsComponentBillingFeatures.properties.CurrentBillingFeatures
    #  - $.definitions.ApplicationInsightsComponentDataVolumeCap.properties.Cap
    #  - $.definitions.ApplicationInsightsComponentDataVolumeCap.properties.ResetTime
    #  - $.definitions.ApplicationInsightsComponentDataVolumeCap.properties.WarningThreshold
    #  - $.definitions.ApplicationInsightsComponentDataVolumeCap.properties.StopSendNotificationWhenHitThreshold
    #  - $.definitions.ApplicationInsightsComponentDataVolumeCap.properties.StopSendNotificationWhenHitCap
    #  - $.definitions.ApplicationInsightsComponentDataVolumeCap.properties.MaxHistoryCap
    #  - $.definitions.ApplicationInsightsComponentQuotaStatus.properties.AppId
    #  - $.definitions.ApplicationInsightsComponentQuotaStatus.properties.ShouldBeThrottled
    #  - $.definitions.ApplicationInsightsComponentQuotaStatus.properties.ExpirationTime
```

### Tag: package-2015-05

These settings apply only when `--tag=package-2015-05` is specified on the command line.

``` yaml $(tag) == 'package-2015-05'
input-file:
- microsoft.insights/2015-05-01/aiOperations_API.json
- microsoft.insights/2015-05-01/components_API.json
- microsoft.insights/2015-05-01/webTests_API.json
- microsoft.insights/2015-05-01/componentContinuousExport_API.json
- microsoft.insights/2015-05-01/componentFeaturesAndPricing_API.json
- microsoft.insights/2015-05-01/componentApiKeys_API.json
```
---
# Code Generation


## C# 

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

``` yaml $(csharp)
csharp:
  azure-arm: true
  payload-flattening-threshold: 1
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: Microsoft.Azure.Management.ApplicationInsights.Management
  output-folder: $(csharp-sdks-folder)/ApplicationInsights/Management.ApplicationInsights/Generated
  clear-output-folder: true
```
## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  namespace: insights
  clear-output-folder: true
```

### Tag: package-2015-05 and go

These settings apply only when `--tag=package-2015-05 --go` is specified on he command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2015-05' && $(go)
output-folder: $(go-sdk-folder)/services/appinsights/mgmt/2015-05-01/insights
```
