import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.ResourceHealth;

interface Operations extends Azure.ResourceManager.Operations {}

enum AvailabilityStateValues {
  Available,
  Unavailable,
  Degraded,
  Unknown,
}

enum ReasonChronicityTypes {
  Transient,
  Persistent,
}

enum Scenario {
  Alerts,
}

enum CreatedByType {
  User,
  Application,
  ManagedIdentity,
  Key,
}

enum EventTypeValues {
  ServiceIssue,
  PlannedMaintenance,
  HealthAdvisory,
  RCA,
  EmergingIssues,
  SecurityAdvisory,
}

enum EventSubTypeValues {
  Retirement,
}

enum EventSourceValues {
  ResourceHealth,
  ServiceHealth,
}

enum EventStatusValues {
  Active,
  Resolved,
}

enum LevelValues {
  Critical,
  Warning,
}

enum EventLevelValues {
  Critical,
  Error,
  Warning,
  Informational,
}

enum LinkTypeValues {
  Button,
  Hyperlink,
}

enum SeverityValues {
  Information,
  Warning,
  Error,
}

enum StageValues {
  Active,
  Resolve,
  Archived,
}

enum IssueNameParameter {
  default,
}

enum ReasonTypeValues {
  Unplanned,
  Planned,
  UserInitiated,
}

@doc("The List availabilityStatus operation response.")
model AvailabilityStatusListResult is Azure.Core.Page<AvailabilityStatus>;

@doc("availabilityStatus of a resource.")
model AvailabilityStatus {
  @doc("Azure Resource Manager Identity for the availabilityStatuses resource.")
  id?: string;

  @doc("current.")
  name?: string;

  @doc("Microsoft.ResourceHealth/AvailabilityStatuses.")
  type?: string;

  @doc("Azure Resource Manager geo location of the resource.")
  location?: string;

  @doc("Properties of availability state.")
  properties?: AvailabilityStatusProperties;
}

@doc("Properties of availability state.")
model AvailabilityStatusProperties {
  @doc("Availability status of the resource. When it is null, this availabilityStatus object represents an availability impacting event")
  availabilityState?: AvailabilityStateValues;

  @doc("Title description of the availability status.")
  title?: string;

  @doc("Summary description of the availability status.")
  summary?: string;

  @doc("Details of the availability status.")
  detailedStatus?: string;

  @doc("When the resource's availabilityState is Unavailable, it describes where the health impacting event was originated. Examples are planned, unplanned, user initiated or an outage etc.")
  reasonType?: string;

  @doc("When an event is created, it can either be triggered by a customer or the platform of the resource and this field will illustrate that. This field is connected to the category field in this object.")
  context?: string;

  @doc("When a context field is set to Platform, this field will reflect if the event was planned or unplanned. If the context field does not have a value of Platform, then this field will be ignored.")
  category?: string;

  @doc("The Article Id")
  articleId?: string;

  @doc("When the resource's availabilityState is Unavailable, it provides the Timestamp for when the health impacting event was received.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  rootCauseAttributionTime?: utcDateTime;

  @doc("In case of an availability impacting event, it describes when the health impacting event was originated. Examples are Lifecycle, Downtime, Fault Analysis etc.")
  healthEventType?: string;

  @doc("In case of an availability impacting event, it describes where the health impacting event was originated. Examples are PlatformInitiated, UserInitiated etc.")
  healthEventCause?: string;

  @doc("In case of an availability impacting event, it describes the category of a PlatformInitiated health impacting event. Examples are Planned, Unplanned etc.")
  healthEventCategory?: string;

  @doc("It is a unique Id that identifies the event")
  healthEventId?: string;

  @doc("When the resource's availabilityState is Unavailable and the reasonType is not User Initiated, it provides the date and time for when the issue is expected to be resolved.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  resolutionETA?: utcDateTime;

  @doc("Timestamp for when last change in health status occurred.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  occuredTime?: utcDateTime;

  @doc("Chronicity of the availability transition.")
  reasonChronicity?: ReasonChronicityTypes;

  @doc("Timestamp for when the health was last checked. ")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  reportedTime?: utcDateTime;

  @doc("An annotation describing a change in the availabilityState to Available from Unavailable with a reasonType of type Unplanned")
  recentlyResolved?: AvailabilityStatusPropertiesRecentlyResolved;

  @doc("Lists actions the user can take based on the current availabilityState of the resource.")
  recommendedActions?: RecommendedAction[];

  @doc("Lists the service impacting events that may be affecting the health of the resource.")
  serviceImpactingEvents?: ServiceImpactingEvent[];
}

@doc("An annotation describing a change in the availabilityState to Available from Unavailable with a reasonType of type Unplanned")
model AvailabilityStatusPropertiesRecentlyResolved {
  @doc("Timestamp for when the availabilityState changed to Unavailable")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  unavailableOccuredTime?: utcDateTime;

  @doc("Timestamp when the availabilityState changes to Available.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  resolvedTime?: utcDateTime;

  @doc("Brief description of cause of the resource becoming unavailable.")
  unavailableSummary?: string;
}

@doc("Lists actions the user can take based on the current availabilityState of the resource.")
model RecommendedAction {
  @doc("Recommended action.")
  action?: string;

  @doc("Link to the action")
  actionUrl?: string;

  @doc("the comment for the Action")
  @projectedName("json", "_ActionUrl.Comment")
  ActionUrlComment?: string;

  @doc("Substring of action, it describes which text should host the action URL.")
  actionUrlText?: string;
}

@doc("Lists the service impacting events that may be affecting the health of the resource.")
model ServiceImpactingEvent {
  @doc("Timestamp for when the event started.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  eventStartTime?: utcDateTime;

  @doc("Timestamp for when event was submitted/detected.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  eventStatusLastModifiedTime?: utcDateTime;

  @doc("Correlation id for the event")
  correlationId?: string;

  @doc("Status of the service impacting event.")
  status?: ServiceImpactingEventStatus;

  @doc("Properties of the service impacting event.")
  incidentProperties?: ServiceImpactingEventIncidentProperties;
}

@doc("Status of the service impacting event.")
model ServiceImpactingEventStatus {
  @doc("Current status of the event")
  value?: string;
}

@doc("Properties of the service impacting event.")
model ServiceImpactingEventIncidentProperties {
  @doc("Title of the incident.")
  title?: string;

  @doc("Service impacted by the event.")
  service?: string;

  @doc("Region impacted by the event.")
  region?: string;

  @doc("Type of Event.")
  incidentType?: string;
}

@doc("The metadata entity properties")
model MetadataEntityProperties {
  @doc("The display name.")
  displayName?: string;

  @doc("The list of keys on which this entity depends on.")
  dependsOn?: string[];

  @doc("The list of scenarios applicable to this metadata entity.")
  applicableScenarios?: Scenario[];

  @doc("The list of supported values.")
  supportedValues?: MetadataSupportedValueDetail[];
}

@doc("The metadata supported value detail.")
model MetadataSupportedValueDetail {
  @doc("The id.")
  id?: string;

  @doc("The display name.")
  displayName?: string;

  @doc("The list of associated resource types.")
  resourceTypes?: string[];
}

@doc("Common fields that are returned in the response for all Azure Resource Manager resources")
model Resource {
  @doc("Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}")
  @visibility("read")
  id?: string;

  @doc("The name of the resource")
  @visibility("read")
  name?: string;

  @doc("The type of the resource. E.g. \"Microsoft.Compute/virtualMachines\" or \"Microsoft.Storage/storageAccounts\"")
  @visibility("read")
  type?: string;

  @doc("Azure Resource Manager metadata containing createdBy and modifiedBy information.")
  @visibility("read")
  systemData?: SystemData;
}

@doc("Properties of impacted resource.")
model EventImpactedResourceProperties {
  @doc("Resource type within Microsoft cloud.")
  @visibility("read")
  targetResourceType?: string;

  @doc("Identity for resource within Microsoft cloud.")
  @visibility("read")
  targetResourceId?: string;

  @doc("Impacted resource region name.")
  @visibility("read")
  targetRegion?: string;

  @doc("Resource name of the impacted resource.")
  @visibility("read")
  resourceName?: string;

  @doc("Resource group name of the impacted resource.")
  @visibility("read")
  resourceGroup?: string;

  @doc("Status of the impacted resource.")
  @visibility("read")
  status?: string;

  @doc("Start time of maintenance for the impacted resource.")
  @visibility("read")
  maintenanceStartTime?: string;

  @doc("End time of maintenance for the impacted resource.")
  @visibility("read")
  maintenanceEndTime?: string;

  @doc("Additional information.")
  info?: KeyValueItem[];
}

@doc("Key value tuple.")
model KeyValueItem {
  @doc("Key of tuple.")
  @visibility("read")
  key?: string;

  @doc("Value of tuple.")
  @visibility("read")
  value?: string;
}

@doc("Properties of event.")
model EventProperties {
  @doc("Type of event.")
  eventType?: EventTypeValues;

  @doc("Sub type of the event. Currently used to determine retirement communications for health advisory events")
  eventSubType?: EventSubTypeValues;

  @doc("Source of event.")
  eventSource?: EventSourceValues;

  @doc("Current status of event.")
  status?: EventStatusValues;

  @doc("Title text of event.")
  title?: string;

  @doc("Summary text of event.")
  summary?: string;

  @doc("Header text of event.")
  header?: string;

  @doc("Level of insight.")
  level?: LevelValues;

  @doc("Level of event.")
  eventLevel?: EventLevelValues;

  @doc("The id of the Incident")
  externalIncidentId?: string;

  @doc("The reason for the Incident")
  reason?: string;

  @doc("Article of event.")
  article?: EventPropertiesArticle;

  @doc("Useful links of event.")
  links?: Link[];

  @doc("It provides the Timestamp for when the health impacting event started.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  impactStartTime?: utcDateTime;

  @doc("It provides the Timestamp for when the health impacting event resolved.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  impactMitigationTime?: utcDateTime;

  @doc("List services impacted by the service health event.")
  impact?: Impact[];

  @doc("Recommended actions of event.")
  recommendedActions?: EventPropertiesRecommendedActions;

  @doc("Frequently asked questions for the service health event.")
  faqs?: Faq[];

  @doc("It provides information if the event is High incident rate event or not.")
  isHIR?: boolean;

  @doc("Tells if we want to enable or disable Microsoft Support for this event.")
  enableMicrosoftSupport?: boolean;

  @doc("Contains the communication message for the event, that could include summary, root cause and other details.")
  description?: string;

  @doc("Is true if the event is platform initiated.")
  platformInitiated?: boolean;

  @doc("Tells if we want to enable or disable Microsoft Support for this event.")
  enableChatWithUs?: boolean;

  @doc("Priority level of the event. Has value from 0 to 23. 0 is the highest priority. Service issue events have higher priority followed by planned maintenance and health advisory. Critical events have higher priority followed by error, warning and informational. Furthermore, active events have higher priority than resolved.")
  priority?: int32;

  @doc("It provides the Timestamp for when the health impacting event was last updated.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdateTime?: utcDateTime;

  @doc("Stage for HIR Document")
  hirStage?: string;

  @doc("Additional information")
  additionalInformation?: EventPropertiesAdditionalInformation;

  @doc("duration in seconds")
  duration?: int32;

  @doc("The type of the impact")
  impactType?: string;

  @doc("Unique identifier for planned maintenance event.")
  maintenanceId?: string;

  @doc("The type of planned maintenance event.")
  maintenanceType?: string;

  @doc("Azure Resource Graph query to fetch the affected resources from their existing Azure Resource Graph locations.")
  argQuery?: string;
}

@doc("Article of event.")
model EventPropertiesArticle {
  @doc("Article content of event.")
  articleContent?: string;

  @doc("Article Id")
  articleId?: string;

  @doc("It provides a map of parameter name and value")
  parameters?: Record<unknown>;
}

@doc("Useful links for service health event.")
model Link {
  @doc("Type of link.")
  type?: LinkTypeValues;

  @doc("Display text of link.")
  displayText?: LinkDisplayText;

  @doc("It provides the name of portal extension to produce link for given service health event.")
  extensionName?: string;

  @doc("It provides the name of portal extension blade to produce link for given service health event.")
  bladeName?: string;

  @doc("It provides a map of parameter name and value for portal extension blade to produce lik for given service health event.")
  parameters?: Record<unknown>;
}

@doc("Display text of link.")
model LinkDisplayText {
  @doc("Display text of link.")
  value?: string;

  @doc("Localized display text of link.")
  localizedValue?: string;
}

@doc("Azure service impacted by the service health event.")
model Impact {
  @doc("Impacted service name.")
  impactedService?: string;

  @doc("List regions impacted by the service health event.")
  impactedRegions?: ImpactedServiceRegion[];
}

@doc("Azure region impacted by the service health event.")
model ImpactedServiceRegion {
  @doc("Impacted region name.")
  impactedRegion?: string;

  @doc("Current status of event in the region.")
  status?: EventStatusValues;

  @doc("List subscription impacted by the service health event.")
  impactedSubscriptions?: string[];

  @doc("List tenant impacted by the service health event.")
  impactedTenants?: string[];

  @doc("It provides the Timestamp for when the last update for the service health event.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdateTime?: utcDateTime;

  @doc("List of updates for given service health event.")
  updates?: Update[];
}

@doc("Update for service health event.")
model Update {
  @doc("Summary text for the given update for the service health event.")
  summary?: string;

  @doc("It provides the Timestamp for the given update for the service health event.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  updateDateTime?: utcDateTime;
}

@doc("Recommended actions of event.")
model EventPropertiesRecommendedActions {
  @doc("Recommended action title for the service health event.")
  message?: string;

  @doc("Recommended actions for the service health event.")
  actions?: EventPropertiesRecommendedActionsActionsItem[];

  @doc("Recommended action locale for the service health event.")
  localeCode?: string;
}

@doc("Recommended action for the service health event.")
model EventPropertiesRecommendedActionsActionsItem {
  @doc("Recommended action group Id for the service health event.")
  groupId?: int32;

  @doc("Recommended action text")
  actionText?: string;
}

@doc("Frequently asked question for the service health event")
model Faq {
  @doc("FAQ question for the service health event.")
  question?: string;

  @doc("FAQ answer for the service health event.")
  answer?: string;

  @doc("FAQ locale for the service health event.")
  localeCode?: string;
}

@doc("Additional information")
model EventPropertiesAdditionalInformation {
  @doc("Additional information Message")
  message?: string;
}

@doc("On-going emerging issue from azure status.")
model EmergingIssue {
  @doc("Timestamp for when last time refreshed for ongoing emerging issue.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  refreshTimestamp?: utcDateTime;

  @doc("The list of emerging issues of banner type.")
  statusBanners?: StatusBanner[];

  @doc("The list of emerging issues of active event type.")
  statusActiveEvents?: StatusActiveEvent[];
}

@doc("Banner type of emerging issue.")
model StatusBanner {
  @doc("The banner title.")
  title?: string;

  @doc("The details of banner.")
  message?: string;

  @doc("The cloud type of this banner.")
  cloud?: string;

  @doc("The last time modified on this banner.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTime?: utcDateTime;
}

@doc("Active event type of emerging issue.")
model StatusActiveEvent {
  @doc("The active event title.")
  title?: string;

  @doc("The details of active event.")
  description?: string;

  @doc("The tracking id of this active event.")
  trackingId?: string;

  @doc("The impact start time on this active event.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  @doc("The cloud type of this active event.")
  cloud?: string;

  @doc("The severity level of this active event.")
  severity?: SeverityValues;

  @doc("The stage of this active event.")
  stage?: StageValues;

  @doc("The boolean value of this active event if published or not.")
  published?: boolean;

  @doc("The last time modified on this banner.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTime?: utcDateTime;

  @doc("The list of emerging issues impacts.")
  impacts?: EmergingIssueImpact[];
}

@doc("Object of the emerging issue impact on services and regions.")
model EmergingIssueImpact {
  @doc("The impacted service id.")
  id?: string;

  @doc("The impacted service name.")
  name?: string;

  @doc("The list of impacted regions for corresponding emerging issues.")
  regions?: ImpactedRegion[];
}

@doc("Object of impacted region.")
model ImpactedRegion {
  @doc("The impacted region id.")
  id?: string;

  @doc("The impacted region name.")
  name?: string;
}

@doc("impactedResource with health status")
model ImpactedResourceStatus extends ProxyResource {
  @doc("Properties of impacted resource status.")
  properties?: ImpactedResourceStatusProperties;
}

@doc("Properties of impacted resource status.")
model ImpactedResourceStatusProperties {
  @doc("Impacted resource status of the resource.")
  availabilityState?: AvailabilityStateValues;

  @doc("Title description of the impacted resource status.")
  title?: string;

  @doc("Summary description of the impacted resource status.")
  summary?: string;

  @doc("When the resource's availabilityState is Unavailable, it describes where the health impacting event was originated.")
  reasonType?: ReasonTypeValues;

  @doc("Timestamp for when last change in health status occurred.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  occurredTime?: utcDateTime;
}
