import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Advisor;

interface Operations extends Azure.ResourceManager.Operations {}

enum Scenario {
  Alerts,
}

/**
 * Minimum percentage threshold for Advisor low CPU utilization evaluation. Valid only for subscriptions. Valid values: 5 (default), 10, 15 or 20.
 */
enum CpuThreshold {
  `5`,
  `10`,
  `15`,
  `20`,
}

enum Category {
  HighAvailability,
  Security,
  Performance,
  Cost,
  OperationalExcellence,
}

/**
 * State of digest configuration.
 */
enum DigestConfigState {
  Active,
  Disabled,
}

enum ConfigurationName {
  default,
}

/**
 * The business impact of the recommendation.
 */
enum Impact {
  High,
  Medium,
  Low,
}

/**
 * The potential risk of not implementing the recommendation.
 */
enum Risk {
  Error,
  Warning,
  None,
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

@error
model ArmErrorResponse {
  /**
   * ARM error response body.
   */
  error?: ARMErrorResponseBody;
}

/**
 * The list of Advisor configurations.
 */
model ConfigurationListResult is Azure.Core.Page<ConfigData>;

/**
 * The Advisor configuration data structure.
 */
model ConfigData extends Resource {
  /**
   * The Advisor configuration data structure.
   */
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
   * Advisor digest configuration. Valid only for subscriptions
   */
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
 * An Azure resource.
 */
model Resource {
  /**
   * The resource ID.
   */
  @visibility("read")
  id?: string;

  /**
   * The name of the resource.
   */
  @visibility("read")
  name?: string;

  /**
   * The type of the resource.
   */
  @visibility("read")
  type?: string;
}

/**
 * The properties of the recommendation.
 */
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
  actions?: Record<Record<unknown>>[];

  /**
   * The automated way to apply recommendation.
   */
  remediation?: Record<Record<unknown>>;

  /**
   * The recommendation metadata properties exposed to customer to provide additional information.
   */
  exposedMetadataProperties?: Record<Record<unknown>>;
}

/**
 * A summary of the recommendation.
 */
model ShortDescription {
  /**
   * The issue or opportunity identified by the recommendation.
   */
  problem?: string;

  /**
   * The remediation action suggested by the recommendation.
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

/**
 * The properties of the suppression.
 */
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
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expirationTimeStamp?: utcDateTime;
}
