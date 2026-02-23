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
  /**
   * The name of the HorizonDb cluster
   */
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
  /**
   * The name of the HorizonDb pool
   */
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
  /**
   * The name of the HorizonDb replica
   */
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
  /**
   * The name of the HorizonDb firewall rule
   */
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
  get is ArmResourceRead<HorizonDbCluster>;
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<HorizonDbCluster>;
  update is ArmCustomPatchAsync<HorizonDbCluster, HorizonDbClusterForUpdate>;
  delete is ArmResourceDeleteWithoutOkAsync<HorizonDbCluster>;
  listByResourceGroup is ArmResourceListByParent<HorizonDbCluster>;
  listBySubscription is ArmListBySubscription<HorizonDbCluster>;
}

@armResourceOperations
interface HorizonDbPools {
  @doc("Gets information about a HorizonDb pool")
  get is ArmResourceRead<HorizonDbPool>;

  @doc("Lists all HorizonDb pools in a cluster")
  list is ArmResourceListByParent<HorizonDbPool>;

  @doc("Creates a new HorizonDb pool or updates an existing pool")
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<HorizonDbPool>;

  @doc("Updates an existing HorizonDb pool (e.g., replica count)")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<HorizonDbPool, HorizonDbPoolForUpdate>;

  @doc("Deletes a HorizonDb pool")
  delete is ArmResourceDeleteWithoutOkAsync<HorizonDbPool>;
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
  update is ArmCustomPatchAsync<HorizonDbReplica, HorizonDbReplicaForUpdate>;

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

  @doc("Deletes a HorizonDb firewall rule")
  delete is ArmResourceDeleteWithoutOkAsync<HorizonDbFirewallRule>;
}
