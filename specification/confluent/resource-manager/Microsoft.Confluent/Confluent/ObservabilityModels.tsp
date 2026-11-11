import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";

using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Microsoft.Confluent;

/**
 * Indicates whether a monitor is currently sending Azure logs to its configured
 * Confluent topic.
 */
@added(Microsoft.Confluent.Versions.v2026_10_21_preview)
union MonitoringStatus {
  string,

  /**
   * The monitor is sending logs selected by its configured rule sets.
   */
  Enabled: "Enabled",

  /**
   * The monitor is not currently sending Azure logs.
   */
  Disabled: "Disabled",
}

/**
 * Specifies whether activity logs from Azure resources matching a tag are
 * included or excluded.
 */
@added(Microsoft.Confluent.Versions.v2026_10_21_preview)
union TagAction {
  string,

  /**
   * Includes activity logs from Azure resources matching the tag filter.
   */
  Include: "Include",

  /**
   * Excludes activity logs from Azure resources matching the tag filter.
   * Exclusion takes precedence over inclusion.
   */
  Exclude: "Exclude",
}

/**
 * The Confluent log destination and current status of a monitor.
 */
@added(Microsoft.Confluent.Versions.v2026_10_21_preview)
model MonitorProperties {
  /**
   * The identifier of the Confluent organization that contains the destination
   * environment.
   */
  @minLength(1)
  @visibility(Lifecycle.Create, Lifecycle.Read)
  organizationId?: string;

  /**
   * The identifier of the Confluent environment that contains the destination
   * cluster.
   */
  @minLength(1)
  @visibility(Lifecycle.Create, Lifecycle.Read)
  environmentId: string;

  /**
   * The display name of the Confluent environment that contains the destination
   * cluster.
   */
  @minLength(1)
  @visibility(Lifecycle.Create, Lifecycle.Read)
  environmentName?: string;

  /**
   * The identifier of the Confluent cluster containing the destination topic.
   */
  @minLength(1)
  @visibility(Lifecycle.Create, Lifecycle.Read)
  clusterId: string;

  /**
   * The display name of the Confluent cluster containing the destination topic.
   */
  @minLength(1)
  @visibility(Lifecycle.Create, Lifecycle.Read)
  clusterName?: string;

  /**
   * The identifier of the Confluent topic that receives the selected Azure logs.
   */
  @minLength(1)
  @visibility(Lifecycle.Create, Lifecycle.Read)
  topicId?: string;

  /**
   * The name of the Confluent topic that receives the selected Azure logs.
   */
  @minLength(1)
  @visibility(Lifecycle.Create, Lifecycle.Read)
  topicName: string;

  /**
   * Additional key-value information associated with the monitor.
   */
  @identifiers(#["key"])
  dictionary?: KeyValuePair[];

  /**
   * The status of the most recent operation performed on the monitor.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisionState;

  /**
   * Indicates whether the monitor is currently sending Azure logs to Confluent.
   */
  @visibility(Lifecycle.Read)
  monitoringStatus?: MonitoringStatus;
}

/**
 * The parameters for updating the Azure resource tags of a Confluent monitor.
 */
@added(Microsoft.Confluent.Versions.v2026_10_21_preview)
model MonitorResourceUpdateParameters {
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;
}

/**
 * The Azure log-selection rules and current status of a monitor rule set.
 */
@added(Microsoft.Confluent.Versions.v2026_10_21_preview)
model MonitorTagRuleProperties {
  /**
   * The status of the most recent operation performed on the rule set.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisionState;

  /**
   * Rules that specify which Azure logs are sent to the monitor's configured
   * Confluent topic.
   */
  logRules?: LogRules;
}

/**
 * Rules that select Azure log categories and Azure resources whose logs are
 * sent to the monitor's configured Confluent topic.
 */
@added(Microsoft.Confluent.Versions.v2026_10_21_preview)
model LogRules {
  /**
   * Specifies whether Microsoft Entra ID logs are sent to Confluent.
   */
  sendAadLogs?: boolean;

  /**
   * Specifies whether Azure subscription logs are sent to Confluent.
   */
  sendSubscriptionLogs?: boolean;

  /**
   * Specifies whether activity logs from Azure resources are sent to Confluent.
   */
  sendActivityLogs?: boolean;

  /**
   * Azure resource-tag filters applied when activity logs are enabled. If only
   * exclusion filters are present, logs from all resources except matching
   * resources are sent. If any inclusion filter is present, logs are sent only
   * from matching resources. Exclusion filters take precedence over inclusion
   * filters.
   */
  @identifiers(#[])
  filteringTags?: FilteringTag[];
}

/**
 * A tag filter that includes or excludes activity logs from matching Azure
 * resources.
 */
@added(Microsoft.Confluent.Versions.v2026_10_21_preview)
model FilteringTag {
  /**
   * The Azure resource tag name to match.
   */
  @minLength(1)
  name: string;

  /**
   * The Azure resource tag value to match. When omitted, the filter matches any
   * value for the specified tag name.
   */
  value?: string;

  /**
   * Specifies whether logs from resources matching the tag filter are included
   * or excluded.
   */
  action: TagAction;
}
