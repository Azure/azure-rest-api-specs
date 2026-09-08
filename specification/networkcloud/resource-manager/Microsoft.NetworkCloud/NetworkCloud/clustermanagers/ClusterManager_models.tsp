import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Microsoft.NetworkCloud;

/**
 * The detailed status that provides additional information about the cluster manager.
 */
union ClusterManagerDetailedStatus {
  string,

  /**
   * The Error status.
   */
  Error: "Error",

  /**
   * The Available status.
   */
  Available: "Available",

  /**
   * The Provisioning status.
   */
  Provisioning: "Provisioning",

  /**
   * The ProvisioningFailed status.
   */
  ProvisioningFailed: "ProvisioningFailed",

  /**
   * The Updating status.
   */
  Updating: "Updating",

  /**
   * The UpdateFailed status.
   */
  UpdateFailed: "UpdateFailed",
}

/**
 * The provisioning state of the cluster manager.
 */
union ClusterManagerProvisioningState {
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
   * The Provisioning status.
   */
  Provisioning: "Provisioning",

  /**
   * The Accepted status.
   */
  Accepted: "Accepted",

  /**
   * The Updating status.
   */
  Updating: "Updating",
}

/**
 * The state to set for the private endpoint connection.
 */
@added(Versions.v2026_01_01_preview)
union RelayPrivateEndpointConnectionState {
  string,

  /**
   * The private endpoint connection is approved.
   */
  Approved: "Approved",

  /**
   * The private endpoint connection is rejected.
   */
  Rejected: "Rejected",
}

/**
 * ClusterManagerList represents a list of cluster manager objects.
 */
model ClusterManagerList is Azure.Core.Page<ClusterManager>;

/**
 * ClusterManagerProperties represents the properties of a cluster manager.
 */
model ClusterManagerProperties {
  /**
   * The resource ID of the Log Analytics workspace that is used for the logs collection.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  analyticsWorkspaceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.OperationalInsights/workspaces";
    }
  ]>;

  /**
   * The Azure availability zones within the region that will be used to support the cluster manager resource.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  availabilityZones?: string[];

  /**
   * The list of the cluster versions the manager supports. It is used as input in clusterVersion property of a cluster resource.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["targetClusterVersion"])
  clusterVersions?: ClusterAvailableVersion[];

  /**
   * The detailed status that provides additional information about the cluster manager.
   */
  @visibility(Lifecycle.Read)
  detailedStatus?: ClusterManagerDetailedStatus;

  /**
   * The descriptive message about the current detailed status.
   */
  @visibility(Lifecycle.Read)
  detailedStatusMessage?: string;

  /**
   * The resource ID of the fabric controller that has one to one mapping with the cluster manager.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  fabricControllerId: Azure.Core.armResourceIdentifier;

  /**
   * The configuration of the managed resource group associated with the resource.
   */
  managedResourceGroupConfiguration?: ManagedResourceGroupConfiguration;

  /**
   * The extended location (custom location) that represents the cluster manager's control plane location. This extended location is used when creating cluster and rack manifest resources.
   */
  @visibility(Lifecycle.Read)
  managerExtendedLocation?: Foundations.ExtendedLocation;

  /**
   * The provisioning state of the cluster manager.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ClusterManagerProvisioningState;

  /**
   * The relay configuration for the cluster manager.
   */
  @added(Versions.v2026_01_01_preview)
  @visibility(Lifecycle.Read)
  relayConfiguration?: ClusterManagerRelayConfiguration;

  /**
   * The size of the Azure virtual machines to use for hosting the cluster manager resource.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  vmSize?: string;
}

/**
 * ClusterAvailableVersion represents the cluster version that the cluster manager can be asked to create and manage.
 */
model ClusterAvailableVersion {
  /**
   * The last date the version of the platform is supported.
   */
  @visibility(Lifecycle.Read)
  supportExpiryDate?: string;

  /**
   * The version of the cluster to be deployed.
   */
  @visibility(Lifecycle.Read)
  targetClusterVersion?: string;
}

/**
 * ClusterManagerRelayConfiguration represents the relay configuration for the cluster manager.
 */
@added(Versions.v2026_01_01_preview)
model ClusterManagerRelayConfiguration {
  /**
   * The resource ID of the Azure relay namespace managed by the cluster manager.
   */
  relayNamespaceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Relay/namespaces";
    }
  ]>;
}

/**
 * ClusterManagerPatchParameters represents the body of the request to patch the cluster properties.
 */
model ClusterManagerPatchParameters {
  /**
   * The identity for the resource.
   */
  identity?: CommonTypes.ManagedServiceIdentity;

  /**
   * The Azure resource tags that will replace the existing ones.
   */
  ...Foundations.ArmTagsProperty;
}

/**
 * ClusterManagerUpdateRelayPrivateEndpointConnectionParameters represents the body of the request to approve or reject the relay private endpoint connection for the private relay managed by a cluster manager.
 */
@added(Versions.v2026_01_01_preview)
model ClusterManagerUpdateRelayPrivateEndpointConnectionParameters {
  /**
   * The state to set for the private endpoint connection.
   */
  connectionState: RelayPrivateEndpointConnectionState;

  /**
   * The description to associate with the private endpoint connection.
   */
  description?: string;

  /**
   * The resource ID of private endpoint to be permitted or denied connection to the relay namespace.
   */
  privateEndpointResourceId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/privateEndpoints";
    }
  ]>;
}
