import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;

namespace Microsoft.NetworkCloud;

/**
 * The more detailed status of the metrics configuration.
 */
union ClusterMetricsConfigurationDetailedStatus {
  string,

  /**
   * The Processing status.
   */
  Processing: "Processing",

  /**
   * The Applied status.
   */
  Applied: "Applied",

  /**
   * The Error status.
   */
  Error: "Error",
}

/**
 * The provisioning state of the metrics configuration.
 */
union ClusterMetricsConfigurationProvisioningState {
  string,

  /**
   * The Succeeded status.
   */
  Succeeded: "Succeeded",

  /**
   * The Failed status.
   */
  Failed: "Failed",

  /**
   * The Canceled status.
   */
  Canceled: "Canceled",

  /**
   * The Accepted status.
   */
  Accepted: "Accepted",

  /**
   * The Provisioning status.
   */
  Provisioning: "Provisioning",
}

/**
 * ClusterMetricsConfigurationList represents a list of metrics configuration of the cluster.
 */
model ClusterMetricsConfigurationList
  is Azure.Core.Page<ClusterMetricsConfiguration>;

/**
 * ClusterMetricsConfigurationProperties represents the properties of metrics configuration for the cluster.
 */
model ClusterMetricsConfigurationProperties {
  ...ClusterMetricsConfigurationSpec;
  ...ClusterMetricsConfigurationStatus;

  /**
   * The provisioning state of the metrics configuration.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ClusterMetricsConfigurationProvisioningState;
}

/**
 * ClusterMetricsConfigurationSpec represents the properties that are used as an input to the operator.
 */
model ClusterMetricsConfigurationSpec {
  /**
   * The list of metric names that have been chosen to be enabled in addition to the core set of enabled metrics.
   */
  enabledMetrics?: string[];

  /**
   * The interval in minutes by which metrics will be collected.
   */
  @maxValue(1440)
  @minValue(1)
  collectionInterval: int64;
}

/**
 * ClusterMetricsConfigurationStatus represents the properties produced by the API implementing logic in the operator.
 */
model ClusterMetricsConfigurationStatus {
  /**
   * The more detailed status of the metrics configuration.
   */
  @visibility(Lifecycle.Read)
  detailedStatus?: ClusterMetricsConfigurationDetailedStatus;

  /**
   * The descriptive message about the current detailed status.
   */
  @visibility(Lifecycle.Read)
  detailedStatusMessage?: string;

  /**
   * The list of metrics that are available for the cluster but disabled at the moment.
   */
  @visibility(Lifecycle.Read)
  disabledMetrics?: string[];
}

/**
 * ClusterMetricsConfigurationPatchParameters represents the body of the request to patch the metrics configuration of cluster.
 */
model ClusterMetricsConfigurationPatchParameters {
  /**
   * The list of the resource properties.
   */
  properties?: ClusterMetricsConfigurationPatchProperties;

  /**
   * The Azure resource tags that will replace the existing ones.
   */
  ...Foundations.ArmTagsProperty;
}

/**
 * ClusterMetricsConfigurationPatchProperties represents the properties of metrics configuration for the cluster for patching.
 */
model ClusterMetricsConfigurationPatchProperties {
  /**
   * The interval in minutes by which metrics will be collected.
   */
  @maxValue(1440)
  @minValue(1)
  collectionInterval?: int64;

  /**
   * The list of metric names that have been chosen to be enabled in addition to the core set of enabled metrics.
   */
  enabledMetrics?: string[];
}
