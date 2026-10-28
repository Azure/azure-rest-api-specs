import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./KubernetesCluster_models.tsp";

using Azure.ResourceManager;

namespace Microsoft.NetworkCloud;

/**
 * The current status of the agent pool.
 */
union AgentPoolDetailedStatus {
  string,

  /**
   * The Available status.
   */
  Available: "Available",

  /**
   * The Error status.
   */
  Error: "Error",

  /**
   * The Provisioning status.
   */
  Provisioning: "Provisioning",
}

/**
 * The selection of how this agent pool is utilized, either as a system pool or a user pool. System pools run the features and critical services for the Kubernetes Cluster, while user pools are dedicated to user workloads. Every Kubernetes cluster must contain at least one system node pool with at least one node.
 */
union AgentPoolMode {
  string,

  /**
   * System agent pool
   */
  System: "System",

  /**
   * User agent pool
   */
  User: "User",

  /**
   * Not applicable
   */
  NotApplicable: "NotApplicable",
}

/**
 * The provisioning state of the agent pool.
 */
union AgentPoolProvisioningState {
  string,

  /**
   * The Accepted status.
   */
  Accepted: "Accepted",

  /**
   * The Canceled status.
   */
  Canceled: "Canceled",

  /**
   * The Deleting status.
   */
  Deleting: "Deleting",

  /**
   * The Failed status.
   */
  Failed: "Failed",

  /**
   * The InProgress status.
   */
  InProgress: "InProgress",

  /**
   * The Succeeded status.
   */
  Succeeded: "Succeeded",

  /**
   * The Updating status.
   */
  Updating: "Updating",
}

/**
 * AgentPoolList represents a list of Kubernetes cluster agent pools.
 */
model AgentPoolList is Azure.Core.Page<AgentPool>;

/**
 * AgentPoolPatchParameters represents the body of the request to patch the Kubernetes cluster agent pool.
 */
model AgentPoolPatchParameters {
  /**
   * The list of the resource properties.
   */
  properties?: AgentPoolPatchProperties;

  /**
   * The Azure resource tags that will replace the existing ones.
   */
  ...Foundations.ArmTagsProperty;
}

/**
 * AgentPoolPatchProperties represents the properties of an agent pool that can be modified.
 */
model AgentPoolPatchProperties {
  /**
   * The configuration of administrator credentials for the control plane nodes.
   */
  administratorConfiguration?: NodePoolAdministratorConfigurationPatch;

  /**
   * The number of virtual machines that use this configuration.
   */
  count?: int64;

  /**
   * The configuration of the agent pool.
   */
  upgradeSettings?: AgentPoolUpgradeSettings;
}

/**
 * AgentPoolProperties represents the properties of the Kubernetes cluster agent pool.
 */
model AgentPoolProperties {
  ...AgentPoolSpec;
  ...AgentPoolStatus;

  /**
   * The provisioning state of the agent pool.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: AgentPoolProvisioningState;
}

/**
 * AgentPoolSpec represents the properties that are used as an input to the operator.
 */
model AgentPoolSpec {
  ...AgentPoolConfiguration;
}

/**
 * AgentPoolStatus represents the observable properties of the agent pool.
 */
model AgentPoolStatus {
  /**
   * The current status of the agent pool.
   */
  @visibility(Lifecycle.Read)
  detailedStatus?: AgentPoolDetailedStatus;

  /**
   * The descriptive message about the current detailed status.
   */
  @visibility(Lifecycle.Read)
  detailedStatusMessage?: string;

  /**
   * The Kubernetes version running in this agent pool.
   */
  @visibility(Lifecycle.Read)
  kubernetesVersion?: string;
}

/**
 * NodePoolAdministratorConfigurationPatch represents the patching capabilities for the administrator configuration.
 */
model NodePoolAdministratorConfigurationPatch {
  /**
   * SshPublicKey represents the public key used to authenticate with a resource through SSH.
   */
  @identifiers(#["keyData"])
  sshPublicKeys?: SshPublicKey[];
}
