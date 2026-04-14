import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using Azure.Core;

namespace Microsoft.ResourceHealth;

/**
 * Impacted resource status of the resource.
 */
union AvailabilityStateValues {
  string,

  /**
   * Available
   */
  Available: "Available",

  /**
   * Unavailable
   */
  Unavailable: "Unavailable",

  /**
   * Degraded
   */
  Degraded: "Degraded",

  /**
   * Unknown
   */
  Unknown: "Unknown",
}

/**
 * Chronicity of the availability transition.
 */
union reasonChronicityTypes {
  string,

  /**
   * Transient
   */
  Transient: "Transient",

  /**
   * Persistent
   */
  Persistent: "Persistent",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union Scenario {
  string,

  /**
   * Alerts
   */
  Alerts: "Alerts",
}

/**
 * The type of identity that created the resource.
 */
union CreatedByType {
  string,

  /**
   * User
   */
  User: "User",

  /**
   * Application
   */
  Application: "Application",

  /**
   * ManagedIdentity
   */
  ManagedIdentity: "ManagedIdentity",

  /**
   * Key
   */
  Key: "Key",
}

/**
 * Type of event.
 */
union EventTypeValues {
  string,

  /**
   * ServiceIssue
   */
  ServiceIssue: "ServiceIssue",

  /**
   * PlannedMaintenance
   */
  PlannedMaintenance: "PlannedMaintenance",

  /**
   * HealthAdvisory
   */
  HealthAdvisory: "HealthAdvisory",

  /**
   * RCA
   */
  RCA: "RCA",

  /**
   * EmergingIssues
   */
  EmergingIssues: "EmergingIssues",

  /**
   * SecurityAdvisory
   */
  SecurityAdvisory: "SecurityAdvisory",

  /**
   * Billing
   */
  Billing: "Billing",
}

/**
 * Sub-type of event.
 */
union EventSubTypeValues {
  string,

  /**
   * Retirement
   */
  Retirement: "Retirement",

  /**
   * ForeignExchangeRateChange
   */
  ForeignExchangeRateChange: "ForeignExchangeRateChange",

  /**
   * Underbilling
   */
  Underbilling: "Underbilling",

  /**
   * Overbilling
   */
  Overbilling: "Overbilling",

  /**
   * PriceChanges
   */
  PriceChanges: "PriceChanges",

  /**
   * TaxChanges
   */
  TaxChanges: "TaxChanges",

  /**
   * MeterIDChanges
   */
  MeterIDChanges: "MeterIDChanges",

  /**
   * UnauthorizedPartyAbuse
   */
  UnauthorizedPartyAbuse: "UnauthorizedPartyAbuse",
}

/**
 * Source of event.
 */
union EventSourceValues {
  string,

  /**
   * ResourceHealth
   */
  ResourceHealth: "ResourceHealth",

  /**
   * ServiceHealth
   */
  ServiceHealth: "ServiceHealth",
}

/**
 * Current status of event.
 */
union EventStatusValues {
  string,

  /**
   * Active
   */
  Active: "Active",

  /**
   * Resolved
   */
  Resolved: "Resolved",
}

/**
 * Level of insight.
 */
union LevelValues {
  string,

  /**
   * Critical
   */
  Critical: "Critical",

  /**
   * Warning
   */
  Warning: "Warning",
}

/**
 * Level of event.
 */
union EventLevelValues {
  string,

  /**
   * Critical
   */
  Critical: "Critical",

  /**
   * Error
   */
  Error: "Error",

  /**
   * Warning
   */
  Warning: "Warning",

  /**
   * Informational
   */
  Informational: "Informational",
}

/**
 * Type of link.
 */
union LinkTypeValues {
  string,

  /**
   * Button
   */
  Button: "Button",

  /**
   * Hyperlink
   */
  Hyperlink: "Hyperlink",
}

/**
 * The severity level of this active event.
 */
union SeverityValues {
  string,

  /**
   * Information
   */
  Information: "Information",

  /**
   * Warning
   */
  Warning: "Warning",

  /**
   * Error
   */
  Error: "Error",
}

/**
 * The stage of this active event.
 */
union StageValues {
  string,

  /**
   * Active
   */
  Active: "Active",

  /**
   * Resolve
   */
  Resolve: "Resolve",

  /**
   * Archived
   */
  Archived: "Archived",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union IssueNameParameter {
  string,

  /**
   * default
   */
  default: "default",
}

/**
 * When the resource's availabilityState is Unavailable, it describes where the health impacting event was originated.
 */
union ReasonTypeValues {
  string,

  /**
   * Unplanned
   */
  Unplanned: "Unplanned",

  /**
   * Planned
   */
  Planned: "Planned",

  /**
   * UserInitiated
   */
  UserInitiated: "UserInitiated",
}

/**
 * Properties of availability state.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resolutionETA?: utcDateTime;

  /**
   * Timestamp for when last change in health status occurred.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  occuredTime?: utcDateTime;

  /**
   * Chronicity of the availability transition.
   */
  reasonChronicity?: reasonChronicityTypes;

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
  @identifiers(#["action"])
  recommendedActions?: RecommendedAction[];

  /**
   * Lists the service impacting events that may be affecting the health of the resource.
   */
  @identifiers(#["correlationId"])
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
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `_ActionUrl.Comment`?: string;

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
 * Error details.
 */
@error
model ErrorResponse {
  /**
   * The error code.
   */
  @visibility(Lifecycle.Read)
  code?: string;

  /**
   * The error message.
   */
  @visibility(Lifecycle.Read)
  message?: string;

  /**
   * The error details.
   */
  @visibility(Lifecycle.Read)
  details?: string;
}

/**
 * Operation available in the Microsoft.ResourceHealth resource provider.
 */
model Operation {
  /**
   * Name of the operation.
   */
  name?: string;

  /**
   * Properties of the operation.
   */
  display?: OperationDisplay;
}

/**
 * Properties of the operation.
 */
model OperationDisplay {
  /**
   * Provider name.
   */
  provider?: string;

  /**
   * Resource name.
   */
  resource?: string;

  /**
   * Operation name.
   */
  operation?: string;

  /**
   * Description of the operation.
   */
  description?: string;
}

/**
 * The metadata entity properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
   * The id of the metadata value
   */
  id?: string;

  /**
   * The previous value of the id field incase the data has changed.
   */
  previousId?: string;

  /**
   * The permanent guid for the service. Used when the id is a service name.
   */
  serviceGuid?: string;

  /**
   * The display name.
   */
  displayName?: string;

  /**
   * The list of associated resource types.
   */
  resourceTypes?: string[];

  /**
   * Priority of this metadata supported value. Lower number is given higher preference.
   */
  priority?: int32;
}

/**
 * Properties of impacted resource.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model EventImpactedResourceProperties {
  /**
   * Resource type within Microsoft cloud.
   */
  @visibility(Lifecycle.Read)
  targetResourceType?: string;

  /**
   * Identity for resource within Microsoft cloud.
   */
  @visibility(Lifecycle.Read)
  targetResourceId?: string;

  /**
   * Impacted resource region name.
   */
  @visibility(Lifecycle.Read)
  targetRegion?: string;

  /**
   * Additional information.
   */
  @identifiers(#[])
  info?: KeyValueItem[];
}

/**
 * Key value tuple.
 */
model KeyValueItem {
  /**
   * Key of tuple.
   */
  @visibility(Lifecycle.Read)
  key?: string;

  /**
   * Value of tuple.
   */
  @visibility(Lifecycle.Read)
  value?: string;
}

/**
 * The List events operation response.
 */
model Events is Azure.Core.Page<Event>;

/**
 * Properties of event.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model EventProperties {
  /**
   * Type of event.
   */
  eventType?: EventTypeValues;

  /**
   * Sub-type of event.
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
   * Summary text of event. Use fetchEventDetails endpoint to get summary of sensitive events.
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
   * If true the event may contains sensitive data. Use the post events/{trackingId}/fetchEventDetails endpoint to fetch sensitive data see https://learn.microsoft.com/en-us/azure/service-health/security-advisories-elevated-access
   */
  isEventSensitive?: boolean;

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
  @identifiers(#[])
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
  @identifiers(#[])
  impact?: Impact[];

  /**
   * Recommended actions of event.
   */
  recommendedActions?: EventPropertiesRecommendedActions;

  /**
   * Frequently asked questions for the service health event.
   */
  @identifiers(#[])
  faqs?: Faq[];

  /**
   * It provides information if the event is High incident rate event or not.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  isHIR?: boolean;

  /**
   * Tells if we want to enable or disable Microsoft Support for this event.
   */
  enableMicrosoftSupport?: boolean;

  /**
   * Contains the communication message for the event, that could include summary, root cause and other details. Use fetchEventDetails endpoint to get description of sensitive events.
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
   * A list of metadata tags associated with the event. Possible values include:
   *  -Action Recommended: Action may be required by you to avoid possible disruptions or mitigate risks for your services. It is recommended to evaluate these actions and the potential impact on your services.
   * - False Positive: After investigation, we've determined your service is healthy and service issues did not impact your services as originally communicated.
   * - Preliminary PIR: For our largest, most impactful service issues a Preliminary Post Incident Review (PIR) is published generally within 72 hours of mitigation, to summarize what we have learned so far from the still-in-progress investigation.
   * - Final PIR: For service issues, a Final Post Incident Review (PIR) may be published to provide additional details or learnings. Sometimes this requires us to complete an internal retrospective, generally within 14 days of mitigation.
   */
  eventTags?: string[];

  /**
   * Billing rate change information - new rate
   */
  newRate?: float64;

  /**
   * Billing rate change information - old rate
   */
  oldRate?: float64;

  /**
   * Billing currency type information. Example: USD, CAD
   */
  currencyType?: string;

  /**
   * Billing identifier information.
   */
  billingId?: string;
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  parameters?: unknown;
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  parameters?: unknown;
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
   * Impacted service guid. This is the permanent identifier for the impacted service.
   */
  impactedServiceGuid?: string;

  /**
   * List regions impacted by the service health event.
   */
  @identifiers(#[])
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
   * List of updates for given service health event.  Use fetchEventDetails endpoint to get updates of sensitive events.
   */
  @identifiers(#[])
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

  /**
   * A list of metadata tags associated with the event. Possible values include:
   *  -Action Recommended: Action may be required by you to avoid possible disruptions or mitigate risks for your services. It is recommended to evaluate these actions and the potential impact on your services.
   * - False Positive: After investigation, we've determined your service is healthy and service issues did not impact your services as originally communicated.
   * - Preliminary PIR: For our largest, most impactful service issues a Preliminary Post Incident Review (PIR) is published generally within 72 hours of mitigation, to summarize what we have learned so far from the still-in-progress investigation.
   * - Final PIR: For service issues, a Final Post Incident Review (PIR) may be published to provide additional details or learnings. Sometimes this requires us to complete an internal retrospective, generally within 14 days of mitigation.
   */
  eventTags?: string[];
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
  @identifiers(#[])
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
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model EmergingIssue {
  /**
   * Timestamp for when last time refreshed for ongoing emerging issue.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  refreshTimestamp?: utcDateTime;

  /**
   * The list of emerging issues of banner type.
   */
  @identifiers(#[])
  statusBanners?: StatusBanner[];

  /**
   * The list of emerging issues of active event type.
   */
  @identifiers(#[])
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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ImpactedResourceStatus
  extends Azure.ResourceManager.CommonTypes.ProxyResource {
  /**
   * Properties of impacted resource status.
   */
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

/**
 * The List availabilityStatus operation response.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model availabilityStatusListResult {
  /**
   * The list of availabilityStatuses.
   */
  @pageItems
  value: AvailabilityStatus[];

  /**
   * The URI to fetch the next page of availabilityStatuses. Call ListNext() with this URI to fetch the next page of availabilityStatuses.
   */
  @nextLink
  nextLink?: string;
}

/**
 * The list of emerging issues.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model emergingIssueListResult {
  /**
   * The list of emerging issues.
   */
  @pageItems
  value?: EmergingIssuesGetResult[];

  /**
   * The link used to get the next page of emerging issues.
   */
  @nextLink
  nextLink?: string;
}

/**
 * The List of eventImpactedResources operation response.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model eventImpactedResourceListResult {
  /**
   * The list of eventImpactedResources.
   */
  @pageItems
  value: EventImpactedResource[];

  /**
   * The URI to fetch the next page of events. Call ListNext() with this URI to fetch the next page of impacted resource.
   */
  @nextLink
  nextLink?: string;
}

/**
 * Lists the operations response.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model operationListResult {
  /**
   * List of operations available in the Microsoft.ResourceHealth resource provider.
   */
  @pageItems
  @identifiers(#["name"])
  value: Operation[];
}

/**
 * The list of metadata entities
 */
model MetadataEntityListResult {
  /**
   * The list of metadata entities.
   */
  @pageItems
  value?: MetadataEntity[];

  /**
   * The link used to get the next page of metadata.
   */
  @nextLink
  nextLink?: string;
}

/**
 * ARM proxy resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-no-key" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.customAzureResource
model ProxyResource {
  /**
   * Azure Resource Manager Identity for the availabilityStatuses resource.
   */
  id?: armResourceIdentifier;

  /**
   * current.
   */
  #suppress "@azure-tools/typespec-azure-core/key-visibility-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  name?: string;

  /**
   * Microsoft.ResourceHealth/AvailabilityStatuses.
   */
  type?: armResourceType;

  /**
   * Azure Resource Manager geo location of the resource.
   */
  location?: string;
}
