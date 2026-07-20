// TypeSpec fixture: x-ms-mutability violations (TSP-EXT-MUTABILITY)
// Seeded violations:
//   - @extension("x-ms-mutability", ["create", "read"]) on immutable property (FORBIDDEN -- use @visibility(Lifecycle.Create, Lifecycle.Read))
//   - @extension("x-ms-mutability", ["read"]) on read-only property (FORBIDDEN -- use @visibility(Lifecycle.Read))
//   - @extension("x-ms-mutability", ["create", "update", "read"]) unnecessarily explicit (FORBIDDEN -- omit decorator; this is the default)
// Compliant patterns (positive controls -- should NOT be flagged):
//   - @visibility(Lifecycle.Create, Lifecycle.Read) on immutable property
//   - @visibility(Lifecycle.Read) on read-only property
//   - No visibility decorator (default: create + update + read)

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
  title: "Storage Service",
})
@versioned(Versions)
namespace Microsoft.StorageService;

/** API versions */
enum Versions {
  /** 2025-01-01 version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  v2025_01_01: "2025-01-01",
}

@segment("storageAccounts")
model StorageAccount is TrackedResource<StorageAccountProperties> {
  @key("accountName")
  @pattern("^[a-z0-9]{3,24}$")
  name: string;
}

/** Properties of a storage account. */
model StorageAccountProperties {
  // Violation #1: @extension("x-ms-mutability", ["create", "read"]) is FORBIDDEN.
  // Correct fix: @visibility(Lifecycle.Create, Lifecycle.Read)
  /** The region where the storage account was created. */
  @extension("x-ms-mutability", ["create", "read"])
  location?: string;

  // Violation #2: @extension("x-ms-mutability", ["read"]) is FORBIDDEN.
  // Correct fix: @visibility(Lifecycle.Read)
  /** The provisioning state of the account. */
  @extension("x-ms-mutability", ["read"])
  provisioningState?: ResourceProvisioningState;

  // Violation #3: @extension("x-ms-mutability", ["create", "update", "read"]) is FORBIDDEN.
  // This is the default visibility; using @extension is still forbidden.
  // Correct fix: remove the decorator entirely (default covers all three).
  /** The display name of the storage account. */
  @extension("x-ms-mutability", ["create", "update", "read"])
  displayName?: string;

  // Positive control #1: @visibility(Lifecycle.Create, Lifecycle.Read) is correct -- should NOT be flagged.
  /** The encryption key source. Immutable after creation. */
  @visibility(Lifecycle.Create, Lifecycle.Read)
  encryptionKeySource?: string;

  // Positive control #2: @visibility(Lifecycle.Read) is correct -- should NOT be flagged.
  /** The creation timestamp. Server-computed, read-only. */
  @visibility(Lifecycle.Read)
  createdAt?: utcDateTime;

  // Positive control #3: no visibility decorator (default) is correct -- should NOT be flagged.
  /** The account tier. Writable after creation. */
  tier?: string;
}

@armResourceOperations
interface StorageAccounts {
  get is ArmResourceRead<StorageAccount>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<StorageAccount>;
  update is ArmResourcePatchAsync<StorageAccount, StorageAccountProperties>;
  delete is ArmResourceDeleteAsync<StorageAccount>;
  listByResourceGroup is ArmResourceListByParent<StorageAccount>;
  listBySubscription is ArmListBySubscription<StorageAccount>;
}

interface Operations extends Azure.ResourceManager.Operations {}
