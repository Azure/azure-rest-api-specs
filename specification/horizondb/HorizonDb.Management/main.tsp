import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

/**
 * Azure Resource Provider API for managing HorizonDb clusters, pools, replicas, and firewall rules
 */
@armProviderNamespace
@service(#{ title: "Microsoft HorizonDb Management API" })
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
namespace Microsoft.HorizonDb;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2026-01-20-preview API version.
   */
  v2026_01_20_preview: "2026-01-20-preview",
}

interface Operations extends Azure.ResourceManager.Operations {}

model HorizonDbCluster
  is Azure.ResourceManager.TrackedResource<HorizonDbClusterProperties> {
  @doc("The name of the HorizonDb cluster")
  @pattern("^[a-zA-Z0-9][-a-zA-Z0-9]*[a-zA-Z0-9]$")
  @minLength(1)
  @maxLength(63)
  @key("clusterName")
  @path
  @segment("clusters")
  name: string;
}

@parentResource(HorizonDbCluster)
model HorizonDbPool
  is Azure.ResourceManager.ProxyResource<HorizonDbPoolProperties> {
  @doc("The name of the HorizonDb pool")
  @pattern("^[a-zA-Z0-9][-a-zA-Z0-9]*[a-zA-Z0-9]$")
  @minLength(1)
  @maxLength(63)
  @key("poolName")
  @path
  @segment("pools")
  name: string;
}

@parentResource(HorizonDbPool)
model HorizonDbReplica
  is Azure.ResourceManager.ProxyResource<HorizonDbReplicaProperties> {
  @doc("The name of the HorizonDb replica")
  @pattern("^[a-zA-Z0-9][-a-zA-Z0-9]*[a-zA-Z0-9]$")
  @minLength(1)
  @maxLength(63)
  @key("replicaName")
  @path
  @segment("replicas")
  name: string;
}

@parentResource(HorizonDbPool)
model HorizonDbFirewallRule
  is Azure.ResourceManager.ProxyResource<HorizonDbFirewallRuleProperties> {
  @doc("The name of the HorizonDb firewall rule")
  @pattern("^[a-zA-Z0-9][-a-zA-Z0-9]*[a-zA-Z0-9]$")
  @minLength(1)
  @maxLength(128)
  @key("firewallRuleName")
  @path
  @segment("firewallRules")
  name: string;
}

@armResourceOperations
interface HorizonDbClusters {
  @doc("Gets information about a HorizonDb cluster")
  get is ArmResourceRead<HorizonDbCluster>;

  @doc("Creates a new HorizonDb cluster or updates an existing cluster")
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<HorizonDbCluster>;

  @doc("Updates an existing HorizonDb cluster (e.g., tags, vCores, replica count)")
  update is ArmCustomPatchAsync<
    HorizonDbCluster,
    HorizonDbClusterForPatchUpdate
  >;

  @doc("Deletes a HorizonDb cluster")
  delete is ArmResourceDeleteWithoutOkAsync<HorizonDbCluster>;

  @doc("Lists all HorizonDb clusters in a resource group")
  listByResourceGroup is ArmResourceListByParent<HorizonDbCluster>;

  @doc("Lists all HorizonDb clusters in a subscription")
  listBySubscription is ArmListBySubscription<HorizonDbCluster>;
}

@armResourceOperations
interface HorizonDbPools {
  @doc("Gets information about a HorizonDb pool")
  get is ArmResourceRead<HorizonDbPool>;

  @doc("Lists all HorizonDb pools in a cluster")
  list is ArmResourceListByParent<HorizonDbPool>;
}

@armResourceOperations
interface HorizonDbReplicas {
  @doc("Gets information about a HorizonDb replica")
  get is ArmResourceRead<HorizonDbReplica>;

  @doc("Lists all HorizonDb replicas in a pool")
  list is ArmResourceListByParent<HorizonDbReplica>;

  @doc("Creates a new HorizonDb replica or updates an existing replica")
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<HorizonDbReplica>;

  @doc("Updates an existing HorizonDb replica (e.g., role)")
  update is ArmCustomPatchAsync<
    HorizonDbReplica,
    HorizonDbReplicaForPatchUpdate
  >;

  @doc("Deletes a HorizonDb replica")
  delete is ArmResourceDeleteWithoutOkAsync<HorizonDbReplica>;
}

@armResourceOperations
interface HorizonDbFirewallRules {
  @doc("Gets information about a HorizonDb firewall rule")
  get is ArmResourceRead<HorizonDbFirewallRule>;

  @doc("Lists all HorizonDb firewall rules in a pool")
  list is ArmResourceListByParent<HorizonDbFirewallRule>;

  @doc("Creates a new HorizonDb firewall rule or updates an existing rule")
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<HorizonDbFirewallRule>;

  @doc("Updates an existing HorizonDb firewall rule (e.g., IP ranges)")
  update is ArmCustomPatchAsync<
    HorizonDbFirewallRule,
    HorizonDbFirewallRuleForPatchUpdate
  >;

  @doc("Deletes a HorizonDb firewall rule")
  delete is ArmResourceDeleteWithoutOkAsync<HorizonDbFirewallRule>;
}
