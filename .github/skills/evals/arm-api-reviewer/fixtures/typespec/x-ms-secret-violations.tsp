// TypeSpec fixture: x-ms-secret violations (TSP-EXT-SECRET)
// Seeded violations:
//   - @extension("x-ms-secret", true) on a password property (FORBIDDEN -- use @secret)
//   - @extension("x-ms-secret", true) on a connectionString property (FORBIDDEN -- use @secret)
//   - #suppress of secret-prop instead of applying @secret (TSP-4.1 + TSP-EXT-SECRET)
// Compliant patterns (positive controls -- should NOT be flagged):
//   - @secret on a password property
//   - @secret on a connectionString property

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

@segment("databaseServers")
model DatabaseServer is TrackedResource<DatabaseServerProperties> {
  @key("serverName")
  @pattern("^[a-zA-Z0-9-]{3,63}$")
  name: string;
}

/** Properties of a database server. */
model DatabaseServerProperties {
  /** The administrator login name. */
  administratorLogin?: string;

  // Violation #1: @extension("x-ms-secret", true) is FORBIDDEN.
  // Correct fix: use @secret instead.
  /** The administrator login password. */
  @extension("x-ms-secret", true)
  administratorLoginPassword?: string;

  // Violation #2: @extension("x-ms-secret", true) on connectionString is FORBIDDEN.
  // Correct fix: use @secret instead.
  /** The primary connection string for the server. */
  @extension("x-ms-secret", true)
  primaryConnectionString?: string;

  // Violation #3: #suppress of secret-prop instead of applying @secret (TSP-4.1 / TSP-EXT-SECRET).
  // The rule fires because the property IS a secret and needs @secret.
  // Suppressing the rule is the wrong fix -- remove the suppress and add @secret.
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "Connection string is not a secret in our context"
  /** The secondary connection string. */
  secondaryConnectionString?: string;

  /** The server version. */
  version?: string;

  /** The provisioning state. */
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;

  // Positive control #1: @secret is correct -- should NOT be flagged.
  /** The replication key. Server-managed secret property. */
  @secret
  replicationKey?: string;

  // Positive control #2: @secret on a connection string is correct -- should NOT be flagged.
  /** The monitoring connection string (write-only, returned only via listKeys). */
  @secret
  monitoringConnectionString?: string;
}

@armResourceOperations
interface DatabaseServers {
  get is ArmResourceRead<DatabaseServer>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<DatabaseServer>;
  update is ArmResourcePatchAsync<DatabaseServer, DatabaseServerProperties>;
  delete is ArmResourceDeleteAsync<DatabaseServer>;
  listByResourceGroup is ArmResourceListByParent<DatabaseServer>;
  listBySubscription is ArmListBySubscription<DatabaseServer>;
}

interface Operations extends Azure.ResourceManager.Operations {}
