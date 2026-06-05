// TypeSpec fixture: x-ms-enum violations (TSP-EXT-ENUM)
// Seeded violations:
//   - @extension("x-ms-enum", { name: "ProvisioningState", modelAsString: true }) on a union (FORBIDDEN -- emitter derives this automatically)
//   - @extension("x-ms-enum", { name: "TierType", modelAsString: false }) on a union (FORBIDDEN -- use union without @extension)
//   - TypeSpec enum (not union) used for an extensible value set (anti-pattern -- use union with string base)
// Compliant patterns (positive controls -- should NOT be flagged):
//   - TypeSpec union with string base (emitter derives x-ms-enum automatically)

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
  title: "Cache Service",
})
@versioned(Versions)
namespace Microsoft.CacheService;

/** API versions */
enum Versions {
  /** 2025-01-01 version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  v2025_01_01: "2025-01-01",
}

// Violation #1: @extension("x-ms-enum", ...) on a union is FORBIDDEN.
// The Azure TypeSpec emitter automatically derives x-ms-enum from union types.
// Remove the @extension call entirely.
/** The provisioning state of the cache resource. */
@extension("x-ms-enum", #{ name: "ProvisioningState", modelAsString: true })
union ProvisioningStateType {
  string,

  /** Succeeded */
  Succeeded: "Succeeded",

  /** Failed */
  Failed: "Failed",

  /** Canceled */
  Canceled: "Canceled",
}

// Violation #2: @extension("x-ms-enum", ...) with modelAsString: false is FORBIDDEN.
// The emitter derives this from the union definition; @extension overrides are not allowed.
/** The cache tier. */
@extension("x-ms-enum", #{ name: "TierType", modelAsString: false })
union TierTypeViolation {
  string,

  /** Basic tier */
  Basic: "Basic",

  /** Standard tier */
  Standard: "Standard",

  /** Premium tier */
  Premium: "Premium",
}

// Positive control #1: plain union with string base is correct -- should NOT be flagged.
// The emitter produces x-ms-enum automatically with modelAsString: true.
/** The replication mode. */
union ReplicationMode {
  string,

  /** Active-Active replication. */
  ActiveActive: "ActiveActive",

  /** Active-Passive replication. */
  ActivePassive: "ActivePassive",
}

@segment("caches")
model Cache is TrackedResource<CacheProperties> {
  @key("cacheName")
  @pattern("^[a-zA-Z0-9-]{3,64}$")
  name: string;
}

/** Properties of a cache resource. */
model CacheProperties {
  /** The provisioning state. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningStateType;

  /** The cache tier. */
  tier?: TierTypeViolation;

  // Positive control #2: union type without @extension is correct -- should NOT be flagged.
  /** The replication mode. */
  replicationMode?: ReplicationMode;
}

@armResourceOperations
interface Caches {
  get is ArmResourceRead<Cache>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Cache>;
  update is ArmResourcePatchAsync<Cache, CacheProperties>;
  delete is ArmResourceDeleteAsync<Cache>;
  listByResourceGroup is ArmResourceListByParent<Cache>;
  listBySubscription is ArmListBySubscription<Cache>;
}

interface Operations extends Azure.ResourceManager.Operations {}
