// TypeSpec fixture: Secret and type violations
// Seeded violations:
//   - Missing @secret on connectionString property (SEC-SECRET-DETECT)
//   - Missing @secret on adminPassword property (SEC-SECRET-DETECT)
//   - #suppress directive silencing secret-prop lint rule instead of applying @secret
//   - Using string for datetime property instead of utcDateTime
//   - Using string for a numeric property (diskSizeGB) (TSP-NUMERIC-TYPE)
//   - Missing doc comments on multiple properties
//   - Using plain string for ARM resource ID instead of armResourceIdentifier (TSP-ARM-RESOURCE-ID)

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
  title: "Database Service",
})
@versioned(Versions)
namespace Microsoft.DatabaseService;

/** API versions */
enum Versions {
  /** 2025-01-01 version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  v2025_01_01: "2025-01-01",
}

@segment("databases")
model Database is TrackedResource<DatabaseProperties> {
  @key("databaseName")
  @pattern("^[a-zA-Z0-9-]{3,64}$")
  name: string;
}

/** Properties of a database resource. */
model DatabaseProperties {
  /** The display name of the database. */
  displayName?: string;

  /** The provisioning state of the resource. */
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;

  // Violation: missing @secret on connectionString (SEC-SECRET-DETECT, name match)
  /** The connection string for the database. */
  connectionString?: string;

  // Violation: missing @secret on adminPassword (SEC-SECRET-DETECT, name match)
  adminPassword?: string;

  // Violation: #suppress silencing secret-prop instead of applying @secret
  #suppress "@azure-tools/typespec-azure-core/secret-prop" "Will fix later"
  primaryKey?: string;

  // Violation: using string instead of utcDateTime for timestamp
  /** The time when the database was created. */
  createdAt?: string;

  // Violation: using string for numeric value (TSP-NUMERIC-TYPE)
  /** The disk size in gigabytes. */
  diskSizeGB?: string;

  // Violation: using plain string for ARM resource ID (TSP-ARM-RESOURCE-ID)
  storageAccountId?: string;

  // Violation: missing doc comment
  backupRetentionDays?: int32;
}

@armResourceOperations
interface Databases {
  get is ArmResourceRead<Database>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Database>;
  update is ArmResourcePatchAsync<Database, DatabaseProperties>;
  delete is ArmResourceDeleteAsync<Database>;
  listByResourceGroup is ArmResourceListByParent<Database>;
  listBySubscription is ArmListBySubscription<Database>;
}

interface Operations extends Azure.ResourceManager.Operations {}
