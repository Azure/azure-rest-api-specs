import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "@typespec/versioning";

using Azure.Core;
using TypeSpec.Versioning;

namespace Microsoft.ContainerService;

/**
 * Bootstrap configuration for a FlexNode pool.
 */
@added(Versions.v2026_05_02_preview)
model PoolBootstrapData {
  /**
   * Azure environment and cluster identity information.
   */
  @visibility(Lifecycle.Read)
  azure?: BootstrapAzureConfig;

  /**
   * Component versions for the node runtime.
   */
  @visibility(Lifecycle.Read)
  components?: BootstrapComponentVersions;

  /**
   * Network configuration for the node.
   */
  @visibility(Lifecycle.Read)
  networking?: BootstrapNetworkingConfig;

  /**
   * Node-level configuration for kubelet, labels, and taints.
   */
  @visibility(Lifecycle.Read)
  node?: BootstrapNodeConfig;
}

/**
 * Azure configuration returned as part of FlexNode bootstrap data.
 */
@added(Versions.v2026_05_02_preview)
model BootstrapAzureConfig {
  /**
   * Azure Resource Manager endpoint for the cloud environment.
   */
  @visibility(Lifecycle.Read)
  resourceManagerEndpoint?: string;

  /**
   * Target cluster identity.
   */
  @visibility(Lifecycle.Read)
  targetCluster?: BootstrapTargetCluster;

  /**
   * Target agent pool name.
   */
  @visibility(Lifecycle.Read)
  targetAgentPoolName?: string;

  /**
   * Bootstrap token for node enrollment. Do not cache or log.
   */
  @secret
  @visibility(Lifecycle.Read)
  bootstrapToken?: BootstrapTokenInfo;
}

/**
 * Target AKS cluster for FlexNode bootstrap.
 */
@added(Versions.v2026_05_02_preview)
model BootstrapTargetCluster {
  /**
   * Azure resource ID of the target AKS cluster.
   */
  @visibility(Lifecycle.Read)
  resourceId?: Azure.Core.armResourceIdentifier;
}

/**
 * Bootstrap token information.
 */
@added(Versions.v2026_05_02_preview)
model BootstrapTokenInfo {
  /**
   * Short-lived bootstrap token for kubelet. Do not cache or log.
   */
  @secret
  @visibility(Lifecycle.Read)
  token?: string;
}

/**
 * Component versions returned as part of FlexNode bootstrap data.
 */
@added(Versions.v2026_05_02_preview)
model BootstrapComponentVersions {
  /**
   * Kubernetes version.
   */
  @visibility(Lifecycle.Read)
  kubernetes?: string;

  /**
   * Containerd version.
   */
  @visibility(Lifecycle.Read)
  containerd?: string;

  /**
   * Runc version.
   */
  @visibility(Lifecycle.Read)
  runc?: string;
}

/**
 * Network configuration returned as part of FlexNode bootstrap data.
 */
@added(Versions.v2026_05_02_preview)
model BootstrapNetworkingConfig {
  /**
   * IP address of the cluster DNS service.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Property name matches existing AKS wire casing for DNS service IP."
  @visibility(Lifecycle.Read)
  dnsServiceIP?: string;

  /**
   * CNI plugin version.
   */
  @visibility(Lifecycle.Read)
  cniVersion?: string;
}

/**
 * Node configuration returned as part of FlexNode bootstrap data.
 */
@added(Versions.v2026_05_02_preview)
model BootstrapNodeConfig {
  /**
   * Maximum pods per node.
   */
  @visibility(Lifecycle.Read)
  maxPods?: int32;

  /**
   * Node labels to apply during registration.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Record<> is used for dynamic key-value structures where keys cannot be pre-defined."
  @visibility(Lifecycle.Read)
  labels?: Record<string>;

  /**
   * Node taints in the format 'key=value:effect'.
   */
  @visibility(Lifecycle.Read)
  taints?: string[];

  /**
   * Kubelet configuration.
   */
  @visibility(Lifecycle.Read)
  kubelet?: BootstrapKubeletConfig;
}

/**
 * Kubelet configuration returned as part of FlexNode bootstrap data.
 */
@added(Versions.v2026_05_02_preview)
model BootstrapKubeletConfig {
  /**
   * FQDN of the Kubernetes API server.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Property name preserves the established AKS FQDN acronym casing."
  @visibility(Lifecycle.Read)
  clusterFQDN?: string;

  /**
   * Base64-encoded PEM certificate of the cluster CA. Do not cache or log.
   */
  @secret
  @visibility(Lifecycle.Read)
  caCertData?: string;
}

/**
 * Empty request body for listing FlexNode bootstrap data.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "The POST action accepts an empty JSON object for forward-compatible request shape."
@added(Versions.v2026_05_02_preview)
model ListBootstrapDataRequest {}
