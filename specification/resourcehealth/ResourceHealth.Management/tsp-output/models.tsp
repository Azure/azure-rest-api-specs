import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.ResourceHealth;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * Impacted resource status of the resource.
 */
enum AvailabilityStateValues {
  Available,
  Unavailable,
  Degraded,
  Unknown,
}

/**
 * Chronicity of the availability transition.
 */
enum ReasonChronicityTypes {
  Transient,
  Persistent,
}

enum Scenario {
  Alerts,
}

/**
 * Type of event.
 */
enum EventTypeValues {
  ServiceIssue,
  PlannedMaintenance,
  HealthAdvisory,
  RCA,
  EmergingIssues,
  SecurityAdvisory,
}

/**
 * Sub type of the event. Currently used to determine retirement communications for health advisory events
 */
enum EventSubTypeValues {
  Retirement,
}

/**
 * Source of event.
 */
enum EventSourceValues {
  ResourceHealth,
  ServiceHealth,
}

/**
 * Current status of event.
 */
enum EventStatusValues {
  Active,
  Resolved,
}

/**
 * Level of insight.
 */
enum LevelValues {
  Critical,
  Warning,
}

/**
 * Level of event.
 */
enum EventLevelValues {
  Critical,
  Error,
  Warning,
  Informational,
}

/**
 * Type of link.
 */
enum LinkTypeValues {
  Button,
  Hyperlink,
}

/**
 * The severity level of this active event.
 */
enum SeverityValues {
  Information,
  Warning,
  Error,
}

/**
 * The stage of this active event.
 */
enum StageValues {
  Active,
  Resolve,
  Archived,
}

enum IssueNameParameter {
  default,
}

/**
 * When the resource's availabilityState is Unavailable, it describes where the health impacting event was originated.
 */
enum ReasonTypeValues {
  Unplanned,
  Planned,
  UserInitiated,
}

/**
 * The List availabilityStatus operation response.
 */
model AvailabilityStatusListResult is Azure.Core.Page<AvailabilityStatus>;

/**
 * availabilityStatus of a resource.
 */
model AvailabilityStatus {
  /**
   * Azure Resource Manager Identity for the availabilityStatuses resource.
   */
  id?: string;

  /**
   * current.
   */
  name?: string;

  /**
   * Microsoft.ResourceHealth/AvailabilityStatuses.
   */
  type?: string;

  /**
   * Azure Resource Manager geo location of the resource.
   */
  location?: string;

  /**
   * Properties of availability state.
   */
  properties?: AvailabilityStatusProperties;
}

/**
 * Properties of availability state.
 */
model AvailabilityStatusProperties {
  /**
   * Availability status of the resource. When it is null, this availabilityStatus object represents an availability impacting event
   */
  availabilityState?: AvailabilityStateValues;

  /**
   * Title description of the availability status.
   */
  title?: string;

  /**
   * Summary description of the availability status.
   */
  summary?: string;

  /**
   * Details of the availability status.
   */
  detailedStatus?: string;

  /**
   * When the resource's availabilityState is Unavailable, it describes where the health impacting event was originated. Examples are planned, unplanned, user initiated or an outage etc.
   */
  reasonType?: string;

  /**
   * When an event is created, it can either be triggered by a customer or the platform of the resource and this field will illustrate that. This field is connected to the category field in this object.
   */
  context?: string;

  /**
   * When a context field is set to Platform, this field will reflect if the event was planned or unplanned. If the context field does not have a value of Platform, then this field will be ignored.
   */
  category?: string;

  /**
   * The Article Id
   */
  articleId?: string;

  /**
   * When the resource's availabilityState is Unavailable, it provides the Timestamp for when the health impacting event was received.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  rootCauseAttributionTime?: utcDateTime;

  /**
   * In case of an availability impacting event, it describes when the health impacting event was originated. Examples are Lifecycle, Downtime, Fault Analysis etc.
   */
  healthEventType?: string;

  /**
   * In case of an availability impacting event, it describes where the health impacting event was originated. Examples are PlatformInitiated, UserInitiated etc.
   */
  healthEventCause?: string;

  /**
   * In case of an availability impacting event, it describes the category of a PlatformInitiated health impacting event. Examples are Planned, Unplanned etc.
   */
  healthEventCategory?: string;

  /**
   * It is a unique Id that identifies the event
   */
  healthEventId?: string;

  /**
   * When the resource's availabilityState is Unavailable and the reasonType is not User Initiated, it provides the date and time for when the issue is expected to be resolved.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  resolutionETA?: utcDateTime;

  /**
   * Timestamp for when last change in health status occurred.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  occuredTime?: utcDateTime;

  /**
   * Chronicity of the availability transition.
   */
  reasonChronicity?: ReasonChronicityTypes;

  /**
   * Timestamp for when the health was last checked.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  reportedTime?: utcDateTime;

  /**
   * An annotation describing a change in the availabilityState to Available from Unavailable with a reasonType of type Unplanned
   */
  recentlyResolved?: AvailabilityStatusPropertiesRecentlyResolved;

  /**
   * Lists actions the user can take based on the current availabilityState of the resource.
   */
  recommendedActions?: RecommendedAction[];

  /**
   * Lists the service impacting events that may be affecting the health of the resource.
   */
  serviceImpactingEvents?: ServiceImpactingEvent[];
}

/**
 * An annotation describing a change in the availabilityState to Available from Unavailable with a reasonType of type Unplanned
 */
model AvailabilityStatusPropertiesRecentlyResolved {
  /**
   * Timestamp for when the availabilityState changed to Unavailable
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  unavailableOccuredTime?: utcDateTime;

  /**
   * Timestamp when the availabilityState changes to Available.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  resolvedTime?: utcDateTime;

  /**
   * Brief description of cause of the resource becoming unavailable.
   */
  unavailableSummary?: string;
}

/**
 * Lists actions the user can take based on the current availabilityState of the resource.
 */
model RecommendedAction {
  /**
   * Recommended action.
   */
  action?: string;

  /**
   * Link to the action
   */
  actionUrl?: string;

  /**
   * the comment for the Action
   */
  @projectedName("json", "_ActionUrl.Comment")
  ActionUrlComment?: string;

  /**
   * Substring of action, it describes which text should host the action URL.
   */
  actionUrlText?: string;
}

/**
 * Lists the service impacting events that may be affecting the health of the resource.
 */
model ServiceImpactingEvent {
  /**
   * Timestamp for when the event started.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  eventStartTime?: utcDateTime;

  /**
   * Timestamp for when event was submitted/detected.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  eventStatusLastModifiedTime?: utcDateTime;

  /**
   * Correlation id for the event
   */
  correlationId?: string;

  /**
   * Status of the service impacting event.
   */
  status?: ServiceImpactingEventStatus;

  /**
   * Properties of the service impacting event.
   */
  incidentProperties?: ServiceImpactingEventIncidentProperties;
}

/**
 * Status of the service impacting event.
 */
model ServiceImpactingEventStatus {
  /**
   * Current status of the event
   */
  value?: string;
}

/**
 * Properties of the service impacting event.
 */
model ServiceImpactingEventIncidentProperties {
  /**
   * Title of the incident.
   */
  title?: string;

  /**
   * Service impacted by the event.
   */
  service?: string;

  /**
   * Region impacted by the event.
   */
  region?: string;

  /**
   * Type of Event.
   */
  incidentType?: string;
}

/**
 * The metadata entity properties
 */
model MetadataEntityProperties {
  /**
   * The display name.
   */
  displayName?: string;

  /**
   * The list of keys on which this entity depends on.
   */
  dependsOn?: string[];

  /**
   * The list of scenarios applicable to this metadata entity.
   */
  applicableScenarios?: Scenario[];

  /**
   * The list of supported values.
   */
  supportedValues?: MetadataSupportedValueDetail[];
}

/**
 * The metadata supported value detail.
 */
model MetadataSupportedValueDetail {
  /**
   * The id.
   */
  id?: string;

  /**
   * The display name.
   */
  displayName?: string;

  /**
   * The list of associated resource types.
   */
  resourceTypes?: string[];
}

/**
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
model Resource {
  /**
   * Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}
   */
  @visibility("read")
  id?: string;

  /**
   * The name of the resource
   */
  @visibility("read")
  name?: string;

  /**
   * The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts"
   */
  @visibility("read")
  type?: string;

  /**
   * Azure Resource Manager metadata containing createdBy and modifiedBy information.
   */
  @visibility("read")
  systemData?: SystemData;
}

/**
 * Properties of impacted resource.
 */
model EventImpactedResourceProperties {
  /**
   * Resource type within Microsoft cloud.
   */
  @visibility("read")
  targetResourceType?: string;

  /**
   * Identity for resource within Microsoft cloud.
   */
  @visibility("read")
  targetResourceId?: string;

  /**
   * Impacted resource region name.
   */
  @visibility("read")
  targetRegion?: string;

  /**
   * Resource name of the impacted resource.
   */
  @visibility("read")
  resourceName?: string;

  /**
   * Resource group name of the impacted resource.
   */
  @visibility("read")
  resourceGroup?: string;

  /**
   * Status of the impacted resource.
   */
  @visibility("read")
  status?: string;

  /**
   * Start time of maintenance for the impacted resource.
   */
  @visibility("read")
  maintenanceStartTime?: string;

  /**
   * End time of maintenance for the impacted resource.
   */
  @visibility("read")
  maintenanceEndTime?: string;

  /**
   * Additional information.
   */
  info?: KeyValueItem[];
}

/**
 * Key value tuple.
 */
model KeyValueItem {
  /**
   * Key of tuple.
   */
  @visibility("read")
  key?: string;

  /**
   * Value of tuple.
   */
  @visibility("read")
  value?: string;
}

/**
 * Properties of event.
 */
model EventProperties {
  /**
   * Type of event.
   */
  eventType?: EventTypeValues;

  /**
   * Sub type of the event. Currently used to determine retirement communications for health advisory events
   */
  eventSubType?: EventSubTypeValues;

  /**
   * Source of event.
   */
  eventSource?: EventSourceValues;

  /**
   * Current status of event.
   */
  status?: EventStatusValues;

  /**
   * Title text of event.
   */
  title?: string;

  /**
   * Summary text of event.
   */
  summary?: string;

  /**
   * Header text of event.
   */
  header?: string;

  /**
   * Level of insight.
   */
  level?: LevelValues;

  /**
   * Level of event.
   */
  eventLevel?: EventLevelValues;

  /**
   * The id of the Incident
   */
  externalIncidentId?: string;

  /**
   * The reason for the Incident
   */
  reason?: string;

  /**
   * Article of event.
   */
  article?: EventPropertiesArticle;

  /**
   * Useful links of event.
   */
  links?: Link[];

  /**
   * It provides the Timestamp for when the health impacting event started.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  impactStartTime?: utcDateTime;

  /**
   * It provides the Timestamp for when the health impacting event resolved.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  impactMitigationTime?: utcDateTime;

  /**
   * List services impacted by the service health event.
   */
  impact?: Impact[];

  /**
   * Recommended actions of event.
   */
  recommendedActions?: EventPropertiesRecommendedActions;

  /**
   * Frequently asked questions for the service health event.
   */
  faqs?: Faq[];

  /**
   * It provides information if the event is High incident rate event or not.
   */
  isHIR?: boolean;

  /**
   * Tells if we want to enable or disable Microsoft Support for this event.
   */
  enableMicrosoftSupport?: boolean;

  /**
   * Contains the communication message for the event, that could include summary, root cause and other details.
   */
  description?: string;

  /**
   * Is true if the event is platform initiated.
   */
  platformInitiated?: boolean;

  /**
   * Tells if we want to enable or disable Microsoft Support for this event.
   */
  enableChatWithUs?: boolean;

  /**
   * Priority level of the event. Has value from 0 to 23. 0 is the highest priority. Service issue events have higher priority followed by planned maintenance and health advisory. Critical events have higher priority followed by error, warning and informational. Furthermore, active events have higher priority than resolved.
   */
  priority?: int32;

  /**
   * It provides the Timestamp for when the health impacting event was last updated.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdateTime?: utcDateTime;

  /**
   * Stage for HIR Document
   */
  hirStage?: string;

  /**
   * Additional information
   */
  additionalInformation?: EventPropertiesAdditionalInformation;

  /**
   * duration in seconds
   */
  duration?: int32;

  /**
   * The type of the impact
   */
  impactType?: string;

  /**
   * Unique identifier for planned maintenance event.
   */
  maintenanceId?: string;

  /**
   * The type of planned maintenance event.
   */
  maintenanceType?: string;

  /**
   * Azure Resource Graph query to fetch the affected resources from their existing Azure Resource Graph locations.
   */
  argQuery?: string;
}

/**
 * Article of event.
 */
model EventPropertiesArticle {
  /**
   * Article content of event.
   */
  articleContent?: string;

  /**
   * Article Id
   */
  articleId?: string;

  /**
   * It provides a map of parameter name and value
   */
  parameters?: Record<unknown>;
}

/**
 * Useful links for service health event.
 */
model Link {
  /**
   * Type of link.
   */
  type?: LinkTypeValues;

  /**
   * Display text of link.
   */
  displayText?: LinkDisplayText;

  /**
   * It provides the name of portal extension to produce link for given service health event.
   */
  extensionName?: string;

  /**
   * It provides the name of portal extension blade to produce link for given service health event.
   */
  bladeName?: string;

  /**
   * It provides a map of parameter name and value for portal extension blade to produce lik for given service health event.
   */
  parameters?: Record<unknown>;
}

/**
 * Display text of link.
 */
model LinkDisplayText {
  /**
   * Display text of link.
   */
  value?: string;

  /**
   * Localized display text of link.
   */
  localizedValue?: string;
}

/**
 * Azure service impacted by the service health event.
 */
model Impact {
  /**
   * Impacted service name.
   */
  impactedService?: string;

  /**
   * List regions impacted by the service health event.
   */
  impactedRegions?: ImpactedServiceRegion[];
}

/**
 * Azure region impacted by the service health event.
 */
model ImpactedServiceRegion {
  /**
   * Impacted region name.
   */
  impactedRegion?: string;

  /**
   * Current status of event in the region.
   */
  status?: EventStatusValues;

  /**
   * List subscription impacted by the service health event.
   */
  impactedSubscriptions?: string[];

  /**
   * List tenant impacted by the service health event.
   */
  impactedTenants?: string[];

  /**
   * It provides the Timestamp for when the last update for the service health event.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdateTime?: utcDateTime;

  /**
   * List of updates for given service health event.
   */
  updates?: Update[];
}

/**
 * Update for service health event.
 */
model Update {
  /**
   * Summary text for the given update for the service health event.
   */
  summary?: string;

  /**
   * It provides the Timestamp for the given update for the service health event.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  updateDateTime?: utcDateTime;
}

/**
 * Recommended actions of event.
 */
model EventPropertiesRecommendedActions {
  /**
   * Recommended action title for the service health event.
   */
  message?: string;

  /**
   * Recommended actions for the service health event.
   */
  actions?: EventPropertiesRecommendedActionsActionsItem[];

  /**
   * Recommended action locale for the service health event.
   */
  localeCode?: string;
}

/**
 * Recommended action for the service health event.
 */
model EventPropertiesRecommendedActionsActionsItem {
  /**
   * Recommended action group Id for the service health event.
   */
  groupId?: int32;

  /**
   * Recommended action text
   */
  actionText?: string;
}

/**
 * Frequently asked question for the service health event
 */
model Faq {
  /**
   * FAQ question for the service health event.
   */
  question?: string;

  /**
   * FAQ answer for the service health event.
   */
  answer?: string;

  /**
   * FAQ locale for the service health event.
   */
  localeCode?: string;
}

/**
 * Additional information
 */
model EventPropertiesAdditionalInformation {
  /**
   * Additional information Message
   */
  message?: string;
}

/**
 * On-going emerging issue from azure status.
 */
model EmergingIssue {
  /**
   * Timestamp for when last time refreshed for ongoing emerging issue.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  refreshTimestamp?: utcDateTime;

  /**
   * The list of emerging issues of banner type.
   */
  statusBanners?: StatusBanner[];

  /**
   * The list of emerging issues of active event type.
   */
  statusActiveEvents?: StatusActiveEvent[];
}

/**
 * Banner type of emerging issue.
 */
model StatusBanner {
  /**
   * The banner title.
   */
  title?: string;

  /**
   * The details of banner.
   */
  message?: string;

  /**
   * The cloud type of this banner.
   */
  cloud?: string;

  /**
   * The last time modified on this banner.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTime?: utcDateTime;
}

/**
 * Active event type of emerging issue.
 */
model StatusActiveEvent {
  /**
   * The active event title.
   */
  title?: string;

  /**
   * The details of active event.
   */
  description?: string;

  /**
   * The tracking id of this active event.
   */
  trackingId?: string;

  /**
   * The impact start time on this active event.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * The cloud type of this active event.
   */
  cloud?: string;

  /**
   * The severity level of this active event.
   */
  severity?: SeverityValues;

  /**
   * The stage of this active event.
   */
  stage?: StageValues;

  /**
   * The boolean value of this active event if published or not.
   */
  published?: boolean;

  /**
   * The last time modified on this banner.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTime?: utcDateTime;

  /**
   * The list of emerging issues impacts.
   */
  impacts?: EmergingIssueImpact[];
}

/**
 * Object of the emerging issue impact on services and regions.
 */
model EmergingIssueImpact {
  /**
   * The impacted service id.
   */
  id?: string;

  /**
   * The impacted service name.
   */
  name?: string;

  /**
   * The list of impacted regions for corresponding emerging issues.
   */
  regions?: ImpactedRegion[];
}

/**
 * Object of impacted region.
 */
model ImpactedRegion {
  /**
   * The impacted region id.
   */
  id?: string;

  /**
   * The impacted region name.
   */
  name?: string;
}

/**
 * impactedResource with health status
 */
model ImpactedResourceStatus extends ProxyResource {
  /**
   * Properties of impacted resource status.
   */
  @extension("x-ms-client-flatten", true)
  properties?: ImpactedResourceStatusProperties;
}

/**
 * Properties of impacted resource status.
 */
model ImpactedResourceStatusProperties {
  /**
   * Impacted resource status of the resource.
   */
  availabilityState?: AvailabilityStateValues;

  /**
   * Title description of the impacted resource status.
   */
  title?: string;

  /**
   * Summary description of the impacted resource status.
   */
  summary?: string;

  /**
   * When the resource's availabilityState is Unavailable, it describes where the health impacting event was originated.
   */
  reasonType?: ReasonTypeValues;

  /**
   * Timestamp for when last change in health status occurred.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  occurredTime?: utcDateTime;
}
