

``` yaml
library-name: ResourceHealth
isAzureSpec: true
isArm: true
require: https://github.com/Azure/azure-rest-api-specs/blob/4bafbf3ab1532e390ad5757433679e9ebb5cbf38/specification/resourcehealth/resource-manager/readme.md
tag: package-preview-2023-10
skip-csproj: true
modelerfour:
  flatten-payloads: false

#mgmt-debug:
#  show-serialized-names: true

rename-mapping:
  Link.type: LinkType
  EmergingIssuesGetResult: ServiceEmergingIssue
  AvailabilityStatusPropertiesRecentlyResolved: ResourceHealthAvailabilityStateRecentlyResolved
  EventPropertiesArticle: ResourceHealthEventArticle
  EventPropertiesRecommendedActions: ResourceHealthEventRecommendedActions
  EventPropertiesRecommendedActionsItem: ResourceHealthEventRecommendedActionsItem
  EventPropertiesAdditionalInformation: ResourceHealthEventAdditionalInformation
  Events: ResourceHealthEventListResult
  LevelValues: ResourceHealthEventInsightLevelValues
  Faq: ResourceHealthEventFaq
  Impact: ResourceHealthEventImpact
  IssueNameParameter: EmergingIssueNameContent
  Link: ResourceHealthEventLink
  LinkDisplayText: ResourceHealthEventLinkDisplayText
  LinkTypeValues: ResourceHealthEventLinkTypeValues
  Scenario: MetadataEntityScenario
  SeverityValues: ResourceHealthEventSeverityLevel
  StageValues: ResourceHealthEventStageValues
  StatusActiveEvent: EmergingIssueActiveEventType
  StatusBanner: EmergingIssueBannerType
  Update: ResourceHealthEventUpdate
  Event.properties.isHIR: IsHirEvent
  Event.properties.platformInitiated: IsPlatformInitiated
  StatusActiveEvent.published: IsPublished
  EventTypeValues.RCA: Rca
  MetadataSupportedValueDetail.resourceTypes: -|resource-type
  AvailabilityStatusProperties.resolutionETA: ResolutionEta
  EventImpactedResource.properties.targetResourceType: -|resource-type
  EventImpactedResource.properties.targetResourceId: -|arm-id
  EmergingIssuesGetResult.properties.refreshTimestamp: RefreshedOn
  Update.updateDateTime: UpdatedOn
  Event.properties.enableMicrosoftSupport: IsMicrosoftSupportEnabled
  Event.properties.enableChatWithUs: IsChatWithUsEnabled
  EventLevelValues: ResourceHealthEventLevelValue
  ImpactedRegion: EmergingIssueImpactedRegion
  ImpactedServiceRegion: ResourceHealthEventImpactedServiceRegion

prepend-rp-prefix:
  - AvailabilityStatus
  - AvailabilityStatusProperties
  - AvailabilityStateValues
  - AvailabilityStatusListResult
  - Event
  - MetadataEntity
  - EventImpactedResource
  - KeyValueItem
  - EventSourceValues
  - EventStatusValues
  - EventTypeValues
  - RecommendedAction

format-by-name-rules:
  'tenantId': 'uuid'
  'ETag': 'etag'
  'location': 'azure-location'
  '*Uri': 'Uri'
  '*Uris': 'Uri'


override-operation-name:
  Events_ListBySingleResource: GetHealthEventsOfSingleResource
  ChildResources_List: GetAvailabilityStatusOfChildResources
  ChildAvailabilityStatuses_GetByResource: GetAvailabilityStatusOfChildResource
  ChildAvailabilityStatuses_List: GetHistoricalAvailabilityStatusesOfChildResource
  AvailabilityStatuses_GetByResource: GetAvailabilityStatus
  AvailabilityStatuses_ListBySubscriptionId: GetAvailabilityStatusesBySubscription

request-path-to-resource-name:
  /subscriptions/{subscriptionId}/providers/Microsoft.ResourceHealth/events/{eventTrackingId}/impactedResources/{impactedResourceName}: ResourceHealthEventImpactedResource
  /subscriptions/{subscriptionId}/providers/Microsoft.ResourceHealth/events/{eventTrackingId}: ResourceHealthEvent
  /providers/Microsoft.ResourceHealth/events/{eventTrackingId}/impactedResources/{impactedResourceName}: TenantResourceHealthEventImpactedResource
  /providers/Microsoft.ResourceHealth/events/{eventTrackingId}: TenantResourceHealthEvent

request-path-is-non-resource:
  - /{resourceUri}/providers/Microsoft.ResourceHealth/childAvailabilityStatuses/current
  - /{resourceUri}/providers/Microsoft.ResourceHealth/availabilityStatuses/current

```
