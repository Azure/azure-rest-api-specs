import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ReplicationProtectionCluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.RecoveryServices;
/**
 * Recovery point.
 */
model ClusterRecoveryPoint {
  /**
   * The recovery point Id.
   */
  id?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.RecoveryServices/vaults/replicationFabrics/replicationProtectionContainers/replicationProtectionClusters/recoveryPoints";
    }
  ]>;

  /**
   * The name of the recovery point.
   */
  name?: string;

  /**
   * The resource type.
   */
  type?: string;

  /**
   * The recovery point properties.
   */
  properties?: ClusterRecoveryPointProperties;
}

alias ClusterRecoveryPointOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** The name of the recovery services vault. */
    @path
    @segment("vaults")
    @key
    @pattern("^[A-Za-z0-9][A-Za-z0-9-]*[A-Za-z0-9]$")
    resourceName: string;

    /** Fabric name. */
    @path
    @segment("replicationFabrics")
    @key
    @pattern("^[A-Za-z0-9][A-Za-z0-9-]*[A-Za-z0-9]$")
    fabricName: string;

    /** Protection container name. */
    @path
    @segment("replicationProtectionContainers")
    @key
    @pattern("^[A-Za-z0-9][A-Za-z0-9-]*[A-Za-z0-9]$")
    protectionContainerName: string;

    /** Replication protection cluster name. */
    @path
    @segment("replicationProtectionClusters")
    @key
    @pattern("^[A-Za-z0-9][A-Za-z0-9-]*[A-Za-z0-9]$")
    replicationProtectionClusterName: string;
  },
  {
    /** The recovery point name. */
    @path
    @segment("recoveryPoints")
    @key
    @pattern("^[A-Za-z0-9][A-Za-z0-9-]*[A-Za-z0-9]$")
    recoveryPointName: string;
  }
>;

@armResourceOperations
interface ClusterRecoveryPoints {
  /**
   * Get the details of specified recovery point.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Gets a recovery point.")
  get is ClusterRecoveryPointOps.Read<ClusterRecoveryPoint>;

  /**
   * The list of cluster recovery points.
   */
  @summary("Gets the list of cluster recovery points.")
  listByReplicationProtectionCluster is ClusterRecoveryPointOps.List<
    ClusterRecoveryPoint,
    Response = ArmResponse<ClusterRecoveryPointCollection>
  >;
}

@@doc(ClusterRecoveryPoint.name, "The recovery point name.");
@@doc(ClusterRecoveryPoint.properties, "The recovery point properties.");
