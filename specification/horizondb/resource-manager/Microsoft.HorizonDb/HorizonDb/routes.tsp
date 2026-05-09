import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./main.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.HorizonDb;

alias HorizonDbPrivateEndpointOperations = Azure.ResourceManager.PrivateEndpoints<PrivateEndpointConnection>;

@armResourceOperations
interface HorizonDbClusters {
  @doc("Gets information about a HorizonDb cluster.")
  get is ArmResourceRead<HorizonDbCluster>;

  @doc("Creates a new HorizonDb cluster or updates an existing cluster.")
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<HorizonDbCluster>;

  @doc("Updates an existing HorizonDb cluster (e.g., tags, virtual cores, replica count).")
  update is ArmCustomPatchAsync<
    HorizonDbCluster,
    HorizonDbClusterForPatchUpdate
  >;

  @doc("Deletes a HorizonDb cluster.")
  delete is ArmResourceDeleteWithoutOkAsync<
    HorizonDbCluster,
    Response = ArmDeleteAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders &
      Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse
  >;

  @doc("Lists all HorizonDb clusters in a resource group.")
  listByResourceGroup is ArmResourceListByParent<HorizonDbCluster>;

  @doc("Lists all HorizonDb clusters in a subscription.")
  listBySubscription is ArmListBySubscription<HorizonDbCluster>;
}

@armResourceOperations
interface HorizonDbPools {
  @doc("Gets information about a HorizonDb pool.")
  get is ArmResourceRead<HorizonDbPool>;

  @doc("Lists all HorizonDb pools in a cluster.")
  list is ArmResourceListByParent<HorizonDbPool>;
}

@armResourceOperations
interface HorizonDbReplicas {
  @doc("Gets information about a HorizonDb replica.")
  get is ArmResourceRead<HorizonDbReplica>;

  @doc("Lists all HorizonDb replicas in a pool.")
  list is ArmResourceListByParent<HorizonDbReplica>;

  @doc("Creates a new HorizonDb replica or updates an existing replica.")
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<HorizonDbReplica>;

  @doc("Updates an existing HorizonDb replica (e.g., role).")
  update is ArmCustomPatchAsync<
    HorizonDbReplica,
    HorizonDbReplicaForPatchUpdate
  >;

  @doc("Deletes a HorizonDb replica.")
  delete is ArmResourceDeleteWithoutOkAsync<
    HorizonDbReplica,
    Response = ArmDeleteAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders &
      Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse
  >;
}

@armResourceOperations
interface HorizonDbFirewallRules {
  @doc("Gets information about a HorizonDb firewall rule.")
  get is ArmResourceRead<HorizonDbFirewallRule>;

  @doc("Lists all HorizonDb firewall rules in a pool.")
  list is ArmResourceListByParent<HorizonDbFirewallRule>;

  @doc("Creates a new HorizonDb firewall rule or updates an existing rule.")
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<HorizonDbFirewallRule>;

  @doc("Deletes a HorizonDb firewall rule.")
  delete is ArmResourceDeleteWithoutOkAsync<
    HorizonDbFirewallRule,
    Response = ArmDeleteAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders &
      Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse
  >;
}

@armResourceOperations
interface HorizonDbPrivateEndpointConnections {
  @doc("Gets a private endpoint connection.")
  get is HorizonDbPrivateEndpointOperations.Read<
    HorizonDbCluster,
    PrivateEndpointConnectionResource
  >;

  @doc("Lists private endpoint connections in a HorizonDb cluster.")
  list is HorizonDbPrivateEndpointOperations.ListByParent<
    HorizonDbCluster,
    PrivateEndpointConnectionResource
  >;

  @doc("Updates a private endpoint connection.")
  update is HorizonDbPrivateEndpointOperations.CustomPatchAsync<PrivateEndpointConnectionResource>;

  @doc("Deletes a private endpoint connection.")
  delete is HorizonDbPrivateEndpointOperations.DeleteAsync<
    PrivateEndpointConnectionResource,
    Response = ArmDeleteAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders &
      Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse
  >;
}

@armResourceOperations
interface HorizonDbPrivateLinkResources {
  @doc("Gets a private link resource.")
  get is ArmResourceRead<HorizonDbPrivateLinkResource>;

  @doc("Lists private link resources in a HorizonDb cluster.")
  list is ArmResourceListByParent<HorizonDbPrivateLinkResource>;
}

@armResourceOperations
interface HorizonDbParameterGroups {
  @doc("Gets information about a HorizonDb parameter group.")
  get is ArmResourceRead<HorizonDbParameterGroup>;

  @doc("Creates a new HorizonDb parameter group or updates an existing parameter group.")
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<HorizonDbParameterGroup>;

  @doc("Updates an existing HorizonDb parameter group.")
  update is ArmCustomPatchAsync<
    HorizonDbParameterGroup,
    HorizonDbParameterGroupForPatchUpdate
  >;

  @doc("Deletes a HorizonDb parameter group.")
  delete is ArmResourceDeleteWithoutOkAsync<
    HorizonDbParameterGroup,
    Response = ArmDeleteAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders &
      Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse
  >;

  @doc("Lists all HorizonDb parameter groups in a resource group.")
  listByResourceGroup is ArmResourceListByParent<HorizonDbParameterGroup>;

  @doc("Lists all HorizonDb parameter groups in a subscription.")
  listBySubscription is ArmListBySubscription<HorizonDbParameterGroup>;

  @doc("Gets all connections to a parameter group.")
  @get
  @list
  @action("connections")
  listConnections is ArmResourceActionSync<
    HorizonDbParameterGroup,
    void,
    ArmResponse<Azure.ResourceManager.ResourceListResult<HorizonDbParameterGroupConnectionProperties>>
  >;

  @doc("Lists parameter groups filtered by version number.")
  @get
  @list
  @action("versions")
  listVersions is ArmResourceActionSync<
    HorizonDbParameterGroup,
    void,
    ArmResponse<Azure.ResourceManager.ResourceListResult<HorizonDbParameterGroup>>,
    Parameters = {
      @doc("The version number to filter by.")
      @query
      version?: int32;
    }
  >;
}
