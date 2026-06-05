// TypeSpec fixture: x-ms-azure-resource violations (TSP-EXT-AZURE-RESOURCE)
// Seeded violations:
//   - Model with @extension("x-ms-azure-resource", true) instead of extending TrackedResource (FORBIDDEN)
//   - Model with @extension("x-ms-azure-resource", true) instead of extending ProxyResource (FORBIDDEN)
// Compliant patterns (positive controls -- should NOT be flagged):
//   - Model extending TrackedResource<Properties> (emitter adds x-ms-azure-resource: true automatically)
//   - Model extending ProxyResource<Properties> (emitter adds x-ms-azure-resource: true automatically)

import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@armProviderNamespace
@service({
  title: "Hybrid Service",
})
@versioned(Versions)
namespace Microsoft.HybridService;

/** API versions */
enum Versions {
  /** 2025-01-01 version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  v2025_01_01: "2025-01-01",
}

// Violation #1: @extension("x-ms-azure-resource", true) on a custom model is FORBIDDEN.
// Correct fix: extend TrackedResource<ClusterProperties> instead.
// The emitter automatically adds x-ms-azure-resource: true to ARM resource base types.
/** A cluster resource (violation: uses @extension instead of ARM base type). */
@segment("clusters")
@extension("x-ms-azure-resource", true)
model ClusterViolation {
  @key("clusterName")
  @pattern("^[a-zA-Z0-9-]{3,64}$")
  name: string;

  /** The resource location. */
  location: string;

  /** The resource tags. */
  tags?: Record<string>;

  /** Resource properties. */
  properties?: ClusterProperties;
}

// Violation #2: @extension("x-ms-azure-resource", true) on a proxy resource model is FORBIDDEN.
// Correct fix: extend ProxyResource<SubnetProperties> instead.
/** A subnet (proxy resource) -- violation: uses @extension instead of ARM base type. */
@segment("subnets")
@extension("x-ms-azure-resource", true)
model SubnetViolation {
  @key("subnetName")
  @pattern("^[a-zA-Z0-9-]{1,80}$")
  name: string;

  /** The parent cluster name. */
  clusterName: string;

  /** Subnet properties. */
  properties?: SubnetProperties;
}

/** Properties of a cluster. */
model ClusterProperties {
  /** The cluster tier. */
  tier?: string;

  /** The provisioning state. */
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;
}

/** Properties of a subnet. */
model SubnetProperties {
  /** The address prefix. */
  addressPrefix?: string;

  /** The provisioning state. */
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;
}

// ---- Positive controls ----

@segment("managedClusters")
model ManagedCluster is TrackedResource<ManagedClusterProperties> {
  // Positive control #1: extending TrackedResource is correct -- should NOT be flagged.
  @key("managedClusterName")
  @pattern("^[a-zA-Z0-9-]{3,64}$")
  name: string;
}

/** Properties of a managed cluster. */
model ManagedClusterProperties {
  /** The cluster tier. */
  tier?: string;

  /** The provisioning state. */
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;
}

@segment("subnets")
model ManagedSubnet is ProxyResource<ManagedSubnetProperties> {
  // Positive control #2: extending ProxyResource is correct -- should NOT be flagged.
  @key("subnetName")
  @pattern("^[a-zA-Z0-9-]{1,80}$")
  name: string;
}

/** Properties of a managed subnet. */
model ManagedSubnetProperties {
  /** The address prefix. */
  addressPrefix?: string;

  /** The provisioning state. */
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;
}

@armResourceOperations
interface ManagedClusters {
  get is ArmResourceRead<ManagedCluster>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ManagedCluster>;
  update is ArmResourcePatchAsync<ManagedCluster, ManagedClusterProperties>;
  delete is ArmResourceDeleteAsync<ManagedCluster>;
  listByResourceGroup is ArmResourceListByParent<ManagedCluster>;
  listBySubscription is ArmListBySubscription<ManagedCluster>;
}

interface Operations extends Azure.ResourceManager.Operations {}
