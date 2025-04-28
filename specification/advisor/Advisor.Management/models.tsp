import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Advisor;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union Scenario {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Alerts: "Alerts",
}

/**
 * Minimum percentage threshold for Advisor low CPU utilization evaluation. Valid only for subscriptions. Valid values: 5 (default), 10, 15 or 20.
 */
union CpuThreshold {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `5`: "5",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `10`: "10",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `15`: "15",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `20`: "20",
}

/**
 * Minimum duration for Advisor low CPU utilization evaluation. Valid only for subscriptions. Valid values: 7 (default), 14, 21, 30, 60 or 90.
 */
union Duration {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `7`: "7",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `14`: "14",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `21`: "21",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `30`: "30",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `60`: "60",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `90`: "90",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union Category {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  HighAvailability: "HighAvailability",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Security: "Security",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Performance: "Performance",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Cost: "Cost",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  OperationalExcellence: "OperationalExcellence",
}

/**
 * State of digest configuration.
 */
union DigestConfigState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Active: "Active",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union ConfigurationName {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  default: "default",
}

/**
 * The business impact of the recommendation.
 */
union Impact {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  High: "High",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Medium: "Medium",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Low: "Low",
}

/**
 * The potential risk of not implementing the recommendation.
 */
union Risk {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Error: "Error",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Warning: "Warning",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  None: "None",
}

/**
 * The state of the Recommendation
 */
union State {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Approved: "Approved",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Rejected: "Rejected",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Pending: "Pending",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  InProgress: "InProgress",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Postponed: "Postponed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Dismissed: "Dismissed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Completed: "Completed",
}

/**
 * The reason the state of the Recommendation was changed.
 */
union Reason {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ExcessiveInvestment: "ExcessiveInvestment",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  TooComplex: "TooComplex",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AlternativeSolution: "AlternativeSolution",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Incompatible: "Incompatible",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Unclear: "Unclear",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  RiskAccepted: "RiskAccepted",
}

/**
 * The Priority of the Recommendation.
 */
union Priority {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Critical: "Critical",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  High: "High",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Medium: "Medium",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Low: "Low",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Informational: "Informational",
}

/**
 * Type of the prediction.
 */
union PredictionType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  PredictiveRightsizing: "PredictiveRightsizing",
}

/**
 * The aggregation level of the score.
 */
union Aggregated {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  week: "week",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  day: "day",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  month: "month",
}

/**
 * Review status string, returns the Reviews by the given status (e.g. 'New', 'Triaged', 'Completed').
 */
union ReviewStatus {
  string,

  /**
   * New
   */
  New: "New",

  /**
   * In Progress
   */
  InProgress: "InProgress",

  /**
   * Triaged
   */
  Triaged: "Triaged",

  /**
   * Completed
   */
  Completed: "Completed",
}

/**
 * Recommendation priority name enum.
 */
union PriorityName {
  string,

  /**
   * High
   */
  High: "High",

  /**
   * Medium
   */
  Medium: "Medium",

  /**
   * Low
   */
  Low: "Low",
}

/**
 * Recommendation status name enum.
 */
union RecommendationStatusName {
  string,

  /**
   * Approved
   */
  Approved: "Approved",

  /**
   * Rejected
   */
  Rejected: "Rejected",

  /**
   * Pending
   */
  Pending: "Pending",
}

/**
 * Reason for rejecting recommendation name enum.
 */
union ReasonForRejectionName {
  string,

  /**
   * Not A Risk
   */
  NotARisk: "NotARisk",

  /**
   * Risk Accepted
   */
  RiskAccepted: "RiskAccepted",
}

/**
 * The metadata entity properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
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
}

/**
 * ARM error response body.
 */
@error
model ARMErrorResponseBody {
  /**
   * Gets or sets the string that describes the error in detail and provides debugging information.
   */
  message?: string;

  /**
   * Gets or sets the string that can be used to programmatically identify the error.
   */
  code?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
@error
model ArmErrorResponse {
  /**
   * ARM error response body.
   */
  error?: ARMErrorResponseBody;
}

/**
 * The Advisor configuration data structure.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ConfigData extends Resource {
  /**
   * The Advisor configuration data structure.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: ConfigDataProperties;
}

/**
 * Configuration data properties
 */
model ConfigDataProperties {
  /**
   * Exclude the resource from Advisor evaluations. Valid values: False (default) or True.
   */
  exclude?: boolean;

  /**
   * Minimum percentage threshold for Advisor low CPU utilization evaluation. Valid only for subscriptions. Valid values: 5 (default), 10, 15 or 20.
   */
  lowCpuThreshold?: CpuThreshold;

  /**
   * Minimum duration for Advisor low CPU utilization evaluation. Valid only for subscriptions. Valid values: 7 (default), 14, 21, 30, 60 or 90.
   */
  duration?: Duration;

  /**
   * Advisor digest configuration. Valid only for subscriptions
   */
  @OpenAPI.extension("x-ms-identifiers", #["name"])
  digests?: DigestConfig[];
}

/**
 * Advisor Digest configuration entity
 */
model DigestConfig {
  /**
   * Name of digest configuration. Value is case-insensitive and must be unique within a subscription.
   */
  name?: string;

  /**
   * Action group resource id used by digest.
   */
  actionGroupResourceId?: string;

  /**
   * Frequency that digest will be triggered, in days. Value must be between 7 and 30 days inclusive.
   */
  frequency?: int32;

  /**
   * Categories to send digest for. If categories are not provided, then digest will be sent for all categories.
   */
  categories?: Category[];

  /**
   * Language for digest content body. Value must be ISO 639-1 code for one of Azure portal supported languages. Otherwise, it will be converted into one. Default value is English (en).
   */
  language?: string;

  /**
   * State of digest configuration.
   */
  state?: DigestConfigState;
}

/**
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
model Resource {
  /**
   * Fully qualified resource ID for the resource. E.g. "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}"
   */
  @visibility(Lifecycle.Read)
  id?: Azure.Core.armResourceIdentifier;

  /**
   * The name of the resource
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts"
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Azure Resource Manager metadata containing createdBy and modifiedBy information.
   */
  @visibility(Lifecycle.Read)
  systemData?: SystemData;
}

/**
 * The properties of the recommendation.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model RecommendationProperties {
  /**
   * The category of the recommendation.
   */
  category?: Category;

  /**
   * The business impact of the recommendation.
   */
  impact?: Impact;

  /**
   * The resource type identified by Advisor.
   */
  impactedField?: string;

  /**
   * The resource identified by Advisor.
   */
  impactedValue?: string;

  /**
   * The most recent time that Advisor checked the validity of the recommendation.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdated?: utcDateTime;

  /**
   * The recommendation metadata.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  metadata?: Record<Record<unknown>>;

  /**
   * The recommendation-type GUID.
   */
  recommendationTypeId?: string;

  /**
   * The potential risk of not implementing the recommendation.
   */
  risk?: Risk;

  /**
   * A summary of the recommendation.
   */
  shortDescription?: ShortDescription;

  /**
   * The list of snoozed and dismissed rules for the recommendation.
   */
  suppressionIds?: string[];

  /**
   * Extended properties
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  extendedProperties?: Record<string>;

  /**
   * Metadata of resource that was assessed
   */
  resourceMetadata?: ResourceMetadata;

  /**
   * The detailed description of recommendation.
   */
  description?: string;

  /**
   * The label of recommendation.
   */
  label?: string;

  /**
   * The link to learn more about recommendation and generation logic.
   */
  learnMoreLink?: string;

  /**
   * The potential benefit of implementing recommendation.
   */
  potentialBenefits?: string;

  /**
   * The list of recommended actions to implement recommendation.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  actions?: Record<Record<unknown>>[];

  /**
   * The automated way to apply recommendation.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  remediation?: Record<Record<unknown>>;

  /**
   * The recommendation metadata properties exposed to customer to provide additional information.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  exposedMetadataProperties?: Record<Record<unknown>>;

  /**
   * If the Recommendation has Tracking enabled.
   */
  tracked?: boolean;

  /**
   * The properties of a tracked recommendation.
   */
  trackedProperties?: TrackedRecommendationProperties;

  /**
   * The Review that this Recommendation belongs to.
   */
  review?: RecommendationPropertiesReview;

  /**
   * The Workload that this Resource belongs to.
   */
  resourceWorkload?: RecommendationPropertiesResourceWorkload;

  /**
   * The Source System that this Recommendation originated from.
   */
  sourceSystem?: string;

  /**
   * Additional notes for the Recommendation
   */
  notes?: string;
}

/**
 * A summary of the recommendation.
 */
model ShortDescription {
  /**
   * The issue or opportunity identified by the recommendation and proposed solution.
   */
  problem?: string;

  /**
   * The issue or opportunity identified by the recommendation and proposed solution.
   */
  solution?: string;
}

/**
 * Recommendation resource metadata
 */
model ResourceMetadata {
  /**
   * Azure resource Id of the assessed resource
   */
  resourceId?: string;

  /**
   * Source from which recommendation is generated
   */
  source?: string;

  /**
   * The action to view resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  action?: Record<Record<unknown>>;

  /**
   * The singular user friendly name of resource type. eg: virtual machine
   */
  singular?: string;

  /**
   * The plural user friendly name of resource type. eg: virtual machines
   */
  plural?: string;
}

/**
 * The tracked properties of a Recommendation
 */
model TrackedRecommendationProperties {
  /**
   * The state of the Recommendation
   */
  state?: State;

  /**
   * The time the Recommendation was postponed until.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  postponedTime?: utcDateTime;

  /**
   * The reason the state of the Recommendation was changed.
   */
  reason?: Reason;

  /**
   * The Priority of the Recommendation.
   */
  priority?: Priority;
}

/**
 * The Review that this Recommendation belongs to.
 */
model RecommendationPropertiesReview {
  /**
   * The ARM Resource Id of the Review
   */
  id?: string;

  /**
   * The Name of the Review
   */
  name?: string;
}

/**
 * The Workload that this Resource belongs to.
 */
model RecommendationPropertiesResourceWorkload {
  /**
   * The Id of the Workload
   */
  id?: string;

  /**
   * The Name of the Workload
   */
  name?: string;
}

/**
 * The operation supported by Advisor.
 */
model OperationEntity {
  /**
   * Operation name: {provider}/{resource}/{operation}.
   */
  name?: string;

  /**
   * The operation supported by Advisor.
   */
  display?: OperationDisplayInfo;
}

/**
 * The operation supported by Advisor.
 */
model OperationDisplayInfo {
  /**
   * The description of the operation.
   */
  description?: string;

  /**
   * The action that users can perform, based on their permission level.
   */
  operation?: string;

  /**
   * Service provider: Microsoft Advisor.
   */
  provider?: string;

  /**
   * Resource on which the operation is performed.
   */
  resource?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model TrackedRecommendationPropertiesPayload {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  properties?: TrackedRecommendationPropertiesPayloadProperties;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model TrackedRecommendationPropertiesPayloadProperties {
  /**
   * The tracked properties of a Recommendation
   */
  trackedProperties?: TrackedRecommendationProperties;
}

/**
 * The properties of the suppression.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model SuppressionProperties {
  /**
   * The GUID of the suppression.
   */
  suppressionId?: string;

  /**
   * The duration for which the suppression is valid.
   */
  ttl?: string;

  /**
   * Gets or sets the expiration time stamp.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expirationTimeStamp?: utcDateTime;
}

/**
 * Parameters for predict recommendation.
 */
model PredictionRequest {
  /**
   * Request properties for prediction recommendation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: PredictionRequestProperties;
}

/**
 * Properties given for the predictor.
 */
model PredictionRequestProperties {
  /**
   * Type of the prediction.
   */
  predictionType?: PredictionType;

  /**
   * Extended properties are arguments specific for each prediction type.
   */
  extendedProperties?: Record<unknown>;
}

/**
 * Response used by predictions.
 */
model PredictionResponse {
  /**
   * The properties of the prediction.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: PredictionResponseProperties;
}

/**
 * Properties of the prediction
 */
model PredictionResponseProperties {
  /**
   * Extended properties
   */
  extendedProperties?: Record<unknown>;

  /**
   * Type of the prediction.
   */
  predictionType?: PredictionType;

  /**
   * The category of the recommendation.
   */
  category?: Category;

  /**
   * The business impact of the recommendation.
   */
  impact?: Impact;

  /**
   * The resource type identified by Advisor.
   */
  impactedField?: string;

  /**
   * The most recent time that Advisor checked the validity of the recommendation.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdated?: utcDateTime;

  /**
   * A summary of the recommendation.
   */
  shortDescription?: ShortDescription;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model AdvisorScoreResponse {
  /**
   * The list of operations.
   */
  value?: AdvisorScoreEntity[];
}

/**
 * The Advisor score data.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model AdvisorScoreEntityProperties {
  /**
   * The details of latest available score.
   */
  lastRefreshedScore?: ScoreEntity;

  /**
   * The historic Advisor score data.
   */
  timeSeries?: TimeSeriesEntityItem[];
}

/**
 * The details of Advisor Score
 */
model ScoreEntity {
  /**
   * The date score was calculated.
   */
  date?: string;

  /**
   * The percentage score.
   */
  score?: float32;

  /**
   * The consumption units for the score.
   */
  consumptionUnits?: float32;

  /**
   * The number of impacted resources.
   */
  impactedResourceCount?: float32;

  /**
   * The potential percentage increase in overall score at subscription level once all recommendations in this scope are implemented.
   */
  potentialScoreIncrease?: float32;

  /**
   * The count of impacted categories.
   */
  @visibility(Lifecycle.Read)
  categoryCount?: float32;
}

/**
 * The data from different aggregation levels.
 */
model TimeSeriesEntityItem {
  /**
   * The aggregation level of the score.
   */
  aggregationLevel?: Aggregated;

  /**
   * The past score data
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  scoreHistory?: ScoreEntity[];
}

/**
 * Assessment result properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model AssessmentResultProperties {
  /**
   * Workload Id.
   */
  workloadId?: string;

  /**
   * Workload Name.
   */
  @visibility(Lifecycle.Read)
  workloadName?: string;

  /**
   * Assessment Id.
   */
  @visibility(Lifecycle.Read)
  assessmentId?: string;

  /**
   * Assessment Type Description.
   */
  @visibility(Lifecycle.Read)
  description?: string;

  /**
   * Assessment Type Id.
   */
  typeId?: string;

  /**
   * Assessment Type.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Assessment Score.
   */
  @visibility(Lifecycle.Read)
  score?: int32;

  /**
   * Assessment State.
   */
  @visibility(Lifecycle.Read)
  state?: string;

  /**
   * Assessment Type Version.
   */
  @visibility(Lifecycle.Read)
  typeVersion?: string;

  /**
   * Assessment Type Locale.
   */
  locale?: string;
}

/**
 * The Advisor assessment type list result data structure.
 */
model AssessmentTypeListResult is Azure.Core.Page<AssessmentTypeResult>;

/**
 * The Advisor assessment type result data structure.
 */
model AssessmentTypeResult {
  /**
   * Assessment Type Id
   */
  id?: string;

  /**
   * Assessment Type Title
   */
  title?: string;

  /**
   * Assessment Type Description
   */
  description?: string;

  /**
   * Assessment Type Locale
   */
  locale?: string;

  /**
   * Assessment Type Version
   */
  version?: string;
}

/**
 * The Workload list result data structure.
 */
model WorkloadListResult is Azure.Core.Page<WorkloadResult>;

/**
 * The Workload result data structure.
 */
model WorkloadResult {
  /**
   * Workload Id
   */
  id?: string;

  /**
   * Workload Name
   */
  name?: string;

  /**
   * Subscription Id
   */
  subscriptionId?: string;

  /**
   * Subscription Name
   */
  subscriptionName?: string;
}

/**
 * Collection of Resiliency Reviews.
 */
model ResiliencyReviewCollection is Azure.Core.Page<ResiliencyReview>;

/**
 * Resiliency review properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model ResiliencyReviewProperties {
  /**
   * Review name.
   */
  @visibility(Lifecycle.Read)
  reviewName?: string;

  /**
   * Workload Name.
   */
  @visibility(Lifecycle.Read)
  workloadName?: string;

  /**
   * Review status.
   */
  @visibility(Lifecycle.Read)
  reviewStatus?: ReviewStatus;

  /**
   * Review recommendations count.
   */
  @visibility(Lifecycle.Read)
  recommendationsCount?: int32;

  /**
   * Review last updated timestamp.
   */
  @visibility(Lifecycle.Read)
  publishedAt?: string;

  /**
   * Review last updated timestamp.
   */
  @visibility(Lifecycle.Read)
  updatedAt?: string;
}

/**
 * Collection of Advisor triage recommendations.
 */
model TriageRecommendationCollection is Azure.Core.Page<TriageRecommendation>;

/**
 * Triage recommendation properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model TriageRecommendationProperties {
  /**
   * Review id.
   */
  @visibility(Lifecycle.Read)
  reviewId?: string;

  /**
   * Recommendation label.
   */
  @visibility(Lifecycle.Read)
  title?: string;

  /**
   * Recommendation priority.
   */
  @visibility(Lifecycle.Read)
  priority?: PriorityName;

  /**
   * List of subscription ids.
   */
  @visibility(Lifecycle.Read)
  appliesToSubscriptions?: string[];

  /**
   * Recommendation status.
   */
  @visibility(Lifecycle.Read)
  recommendationStatus?: RecommendationStatusName;

  /**
   * Recommendation potential benefit.
   */
  @visibility(Lifecycle.Read)
  updatedAt?: string;

  /**
   * Recommendation rejection reason.
   */
  @visibility(Lifecycle.Read)
  rejectReason?: string;

  /**
   * Recommendation potential benefit.
   */
  @visibility(Lifecycle.Read)
  potentialBenefits?: string;

  /**
   * Recommendation description.
   */
  @visibility(Lifecycle.Read)
  description?: string;

  /**
   * Recommendation notes.
   */
  @visibility(Lifecycle.Read)
  notes?: string;
}

/**
 * Recommendation reject body.
 */
model RecommendationRejectBody {
  /**
   * Reason for rejecting recommendation.
   */
  reasonForRejection?: ReasonForRejectionName;
}

/**
 * Triage resource properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model TriageResourceProperties {
  /**
   * Unique identifier for the review resource this triageResource belongs to.
   */
  @visibility(Lifecycle.Read)
  reviewId?: string;

  /**
   * Unique identifier for the recommendation resource this triageResource belongs to.
   */
  @visibility(Lifecycle.Read)
  recommendationId?: string;

  /**
   * Unique identifier for the subscription resource this triageResource belongs to.
   */
  @visibility(Lifecycle.Read)
  subscriptionId?: string;

  /**
   * Name of the resource group this triageResource belongs to.
   */
  @visibility(Lifecycle.Read)
  resourceGroup?: string;

  /**
   * Type of resource this triageResource corresponds to e.g. "Cosmos DB".
   */
  @visibility(Lifecycle.Read)
  resourceType?: string;

  /**
   * Full Azure resource id path of the resource this triageResource corresponds to.
   */
  @visibility(Lifecycle.Read)
  resourceId?: Azure.Core.armResourceIdentifier;

  /**
   * Name of the resource this triageResource corresponds to.
   */
  @visibility(Lifecycle.Read)
  resourceName?: string;
}

/**
 * Collection of Advisor triage resources.
 */
model TriageResourceCollection is Azure.Core.Page<TriageResource>;
