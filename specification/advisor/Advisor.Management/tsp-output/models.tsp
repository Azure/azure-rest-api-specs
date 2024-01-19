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

@doc("Minimum percentage threshold for Advisor low CPU utilization evaluation. Valid only for subscriptions. Valid values: 5 (default), 10, 15 or 20.")
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

@doc("State of digest configuration.")
enum DigestConfigState {
  Active,
  Disabled,
}

enum ConfigurationName {
  default,
}

@doc("The business impact of the recommendation.")
enum Impact {
  High,
  Medium,
  Low,
}

@doc("The potential risk of not implementing the recommendation.")
enum Risk {
  Error,
  Warning,
  None,
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
}

@doc("ARM error response body.")
@error
model ARMErrorResponseBody {
  @doc("Gets or sets the string that describes the error in detail and provides debugging information.")
  message?: string;

  @doc("Gets or sets the string that can be used to programmatically identify the error.")
  code?: string;
}

@error
model ArmErrorResponse {
  @doc("ARM error response body.")
  error?: ARMErrorResponseBody;
}

@doc("The list of Advisor configurations.")
model ConfigurationListResult is Azure.Core.Page<ConfigData>;

@doc("The Advisor configuration data structure.")
model ConfigData extends Resource {
  @doc("The Advisor configuration data structure.")
  properties?: ConfigDataProperties;
}

@doc("Configuration data properties")
model ConfigDataProperties {
  @doc("Exclude the resource from Advisor evaluations. Valid values: False (default) or True.")
  exclude?: boolean;

  @doc("Minimum percentage threshold for Advisor low CPU utilization evaluation. Valid only for subscriptions. Valid values: 5 (default), 10, 15 or 20.")
  lowCpuThreshold?: CpuThreshold;

  @doc("Advisor digest configuration. Valid only for subscriptions")
  digests?: DigestConfig[];
}

@doc("Advisor Digest configuration entity")
model DigestConfig {
  @doc("Name of digest configuration. Value is case-insensitive and must be unique within a subscription.")
  name?: string;

  @doc("Action group resource id used by digest.")
  actionGroupResourceId?: string;

  @doc("Frequency that digest will be triggered, in days. Value must be between 7 and 30 days inclusive.")
  frequency?: int32;

  @doc("Categories to send digest for. If categories are not provided, then digest will be sent for all categories.")
  categories?: Category[];

  @doc("Language for digest content body. Value must be ISO 639-1 code for one of Azure portal supported languages. Otherwise, it will be converted into one. Default value is English (en).")
  language?: string;

  @doc("State of digest configuration.")
  state?: DigestConfigState;
}

@doc("An Azure resource.")
model Resource {
  @doc("The resource ID.")
  @visibility("read")
  id?: string;

  @doc("The name of the resource.")
  @visibility("read")
  name?: string;

  @doc("The type of the resource.")
  @visibility("read")
  type?: string;
}

@doc("The properties of the recommendation.")
model RecommendationProperties {
  @doc("The category of the recommendation.")
  category?: Category;

  @doc("The business impact of the recommendation.")
  impact?: Impact;

  @doc("The resource type identified by Advisor.")
  impactedField?: string;

  @doc("The resource identified by Advisor.")
  impactedValue?: string;

  @doc("The most recent time that Advisor checked the validity of the recommendation.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdated?: utcDateTime;

  @doc("The recommendation metadata.")
  metadata?: Record<Record<unknown>>;

  @doc("The recommendation-type GUID.")
  recommendationTypeId?: string;

  @doc("The potential risk of not implementing the recommendation.")
  risk?: Risk;

  @doc("A summary of the recommendation.")
  shortDescription?: ShortDescription;

  @doc("The list of snoozed and dismissed rules for the recommendation.")
  suppressionIds?: string[];

  @doc("Extended properties")
  extendedProperties?: Record<string>;

  @doc("Metadata of resource that was assessed")
  resourceMetadata?: ResourceMetadata;

  @doc("The detailed description of recommendation.")
  description?: string;

  @doc("The label of recommendation.")
  label?: string;

  @doc("The link to learn more about recommendation and generation logic.")
  learnMoreLink?: string;

  @doc("The potential benefit of implementing recommendation.")
  potentialBenefits?: string;

  @doc("The list of recommended actions to implement recommendation.")
  actions?: Record<Record<unknown>>[];

  @doc("The automated way to apply recommendation.")
  remediation?: Record<Record<unknown>>;

  @doc("The recommendation metadata properties exposed to customer to provide additional information.")
  exposedMetadataProperties?: Record<Record<unknown>>;
}

@doc("A summary of the recommendation.")
model ShortDescription {
  @doc("The issue or opportunity identified by the recommendation.")
  problem?: string;

  @doc("The remediation action suggested by the recommendation.")
  solution?: string;
}

@doc("Recommendation resource metadata")
model ResourceMetadata {
  @doc("Azure resource Id of the assessed resource")
  resourceId?: string;

  @doc("Source from which recommendation is generated")
  source?: string;

  @doc("The action to view resource.")
  action?: Record<Record<unknown>>;

  @doc("The singular user friendly name of resource type. eg: virtual machine")
  singular?: string;

  @doc("The plural user friendly name of resource type. eg: virtual machines")
  plural?: string;
}

@doc("The operation supported by Advisor.")
model OperationEntity {
  @doc("Operation name: {provider}/{resource}/{operation}.")
  name?: string;

  @doc("The operation supported by Advisor.")
  display?: OperationDisplayInfo;
}

@doc("The operation supported by Advisor.")
model OperationDisplayInfo {
  @doc("The description of the operation.")
  description?: string;

  @doc("The action that users can perform, based on their permission level.")
  operation?: string;

  @doc("Service provider: Microsoft Advisor.")
  provider?: string;

  @doc("Resource on which the operation is performed.")
  resource?: string;
}

@doc("The properties of the suppression.")
model SuppressionProperties {
  @doc("The GUID of the suppression.")
  suppressionId?: string;

  @doc("The duration for which the suppression is valid.")
  ttl?: string;

  @doc("Gets or sets the expiration time stamp.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expirationTimeStamp?: utcDateTime;
}
