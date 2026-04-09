import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.DocumentDB;

// ──────────────────────────────────────────────
//  Soft-Delete Models
// ──────────────────────────────────────────────

/**
 * The kind of soft delete action to perform.
 */
@added(Versions.v2026_04_01_preview)
union SoftDeleteActionKind {
  string,

  /** Restores the soft-deleted resource to active/online state. */
  RestoreSoftDeletedResource: "RestoreSoftDeletedResource",

  /** Permanently deletes the soft-deleted resource. */
  PermanentDeleteResource: "PermanentDeleteResource",
}

/**
 * Metadata about the soft deletion of a resource.
 */
@added(Versions.v2026_04_01_preview)
model SoftDeletionMetadata {
  /**
   * Indicates whether the resource is soft deleted.
   */
  isSoftDeleted?: boolean;

  /**
   * The timestamp when the soft deletion started.
   */
  softDeletionStartTimestamp?: int64;

  /**
   * The timestamp when the soft-deleted resource will expire and be permanently deleted.
   */
  softDeletionResourceExpirationTimestamp?: int64;
}

/**
 * The database account resource information for a soft-deleted account.
 */
@added(Versions.v2026_04_01_preview)
model SoftDeletedDatabaseAccountResource {
  /**
   * An array that contains all of the locations enabled for the Cosmos DB account.
   */
  @identifiers(#[])
  locations?: Location[];

  /**
   * An array that contains the write location(s) for the Cosmos DB account.
   */
  @identifiers(#[])
  writeLocations?: Location[];

  /**
   * An array that contains the read locations enabled for the Cosmos DB account.
   */
  @identifiers(#[])
  readLocations?: Location[];
}

/**
 * The properties of a soft-deleted database account.
 */
@added(Versions.v2026_04_01_preview)
model SoftDeletedDatabaseAccountProperties {
  /**
   * The name of the database account.
   */
  accountName?: string;

  /**
   * Metadata related to the soft deletion of the database account.
   */
  softDeletionMetadata?: SoftDeletionMetadata;

  /**
   * The soft delete configuration for the database account.
   */
  softDeleteConfiguration?: SoftDeleteConfiguration;

  /**
   * A subset of properties of the underlying database account resource.
   */
  resource?: SoftDeletedDatabaseAccountResource;
}

/**
 * A Azure Cosmos DB soft-deleted database account.
 */
@added(Versions.v2026_04_01_preview)
model SoftDeletedDatabaseAccountGetResult {
  /**
   * The properties of a soft-deleted database account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "x-ms-client-flatten is required for swagger compatibility"
  @extension("x-ms-client-flatten", true)
  properties?: SoftDeletedDatabaseAccountProperties;

  /**
   * The unique resource identifier of the ARM resource.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The name of the ARM resource.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The type of Azure resource.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * The location of the resource group to which the resource belongs.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "x-ms-mutability is required for ARM location property"
  @extension("x-ms-mutability", #["read", "create"])
  location?: string;
}

/**
 * The List operation response, that contains the soft-deleted database accounts and their properties.
 */
@added(Versions.v2026_04_01_preview)
model SoftDeletedDatabaseAccountsListResult {
  /**
   * List of soft-deleted database accounts and their properties.
   */
  @visibility(Lifecycle.Read)
  value?: SoftDeletedDatabaseAccountGetResult[];

  /**
   * The URL to get the next set of results.
   */
  nextLink?: string;
}

/**
 * Cosmos DB SQL database resource object
 */
@added(Versions.v2026_04_01_preview)
model SoftDeletedSqlDatabaseResource {
  /**
   * Name of the Cosmos DB SQL database
   */
  id: string;

  /**
   * A system generated property. A unique identifier.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "_rid is a backend property"
  @visibility(Lifecycle.Read)
  _rid?: string;
}

/**
 * The properties of a soft-deleted SQL database.
 */
@added(Versions.v2026_04_01_preview)
model SoftDeletedSqlDatabaseProperties {
  /**
   * Metadata related to the soft deletion of the SQL database.
   */
  softDeletionMetadata?: SoftDeletionMetadata;

  /**
   * The resource information for the soft-deleted SQL database.
   */
  resource?: SoftDeletedSqlDatabaseResource;
}

/**
 * An Azure Cosmos DB soft-deleted SQL database.
 */
@added(Versions.v2026_04_01_preview)
model SoftDeletedSqlDatabaseGetResult {
  /**
   * The properties of a soft-deleted SQL database.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "x-ms-client-flatten is required for swagger compatibility"
  @extension("x-ms-client-flatten", true)
  properties?: SoftDeletedSqlDatabaseProperties;

  /**
   * The unique resource identifier of the ARM resource.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The name of the ARM resource.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The type of Azure resource.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * The location of the resource group to which the resource belongs.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "x-ms-mutability is required for ARM location property"
  @extension("x-ms-mutability", #["read", "create"])
  location?: string;
}

/**
 * The List operation response, that contains the soft-deleted SQL databases and their properties.
 */
@added(Versions.v2026_04_01_preview)
model SoftDeletedSqlDatabasesListResult {
  /**
   * List of soft-deleted SQL databases and their properties.
   */
  @visibility(Lifecycle.Read)
  value?: SoftDeletedSqlDatabaseGetResult[];

  /**
   * The URL to get the next set of results.
   */
  nextLink?: string;
}

/**
 * Cosmos DB SQL container resource object
 */
@added(Versions.v2026_04_01_preview)
model SoftDeletedSqlContainerResource {
  /**
   * Name of the Cosmos DB SQL container
   */
  id: string;

  /**
   * A system generated property. A unique identifier.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "_rid is a backend property"
  @visibility(Lifecycle.Read)
  _rid?: string;

  /**
   * The configuration of the partition key to be used for partitioning data into multiple partitions
   */
  partitionKey?: ContainerPartitionKey;

  /**
   * Default time to live
   */
  defaultTtl?: int32;
}

/**
 * The properties of a soft-deleted SQL container.
 */
@added(Versions.v2026_04_01_preview)
model SoftDeletedSqlContainerProperties {
  /**
   * Metadata related to the soft deletion of the SQL container.
   */
  softDeletionMetadata?: SoftDeletionMetadata;

  /**
   * The resource information for the soft-deleted SQL container.
   */
  resource?: SoftDeletedSqlContainerResource;
}

/**
 * An Azure Cosmos DB soft-deleted SQL container.
 */
@added(Versions.v2026_04_01_preview)
model SoftDeletedSqlContainerGetResult {
  /**
   * The properties of a soft-deleted SQL container.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "x-ms-client-flatten is required for swagger compatibility"
  @extension("x-ms-client-flatten", true)
  properties?: SoftDeletedSqlContainerProperties;

  /**
   * The unique resource identifier of the ARM resource.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The name of the ARM resource.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The type of Azure resource.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * The location of the resource group to which the resource belongs.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "x-ms-mutability is required for ARM location property"
  @extension("x-ms-mutability", #["read", "create"])
  location?: string;
}

/**
 * The List operation response, that contains the soft-deleted SQL containers and their properties.
 */
@added(Versions.v2026_04_01_preview)
model SoftDeletedSqlContainersListResult {
  /**
   * List of soft-deleted SQL containers and their properties.
   */
  @visibility(Lifecycle.Read)
  value?: SoftDeletedSqlContainerGetResult[];

  /**
   * The URL to get the next set of results.
   */
  nextLink?: string;
}

// ──────────────────────────────────────────────
//  Soft-Deleted Database Account Operations
// ──────────────────────────────────────────────

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "Custom routes for soft-deleted resources"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom routes for soft-deleted resources"
@added(Versions.v2026_04_01_preview)
interface SoftDeletedDatabaseAccounts {
  /**
   * Retrieves the properties of a soft-deleted Azure Cosmos DB database account by location and accountName. This call requires 'Microsoft.DocumentDB/locations/softDeletedDatabaseAccounts/read' permission.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DocumentDB/locations/{location}/softDeletedDatabaseAccounts/{accountName}")
  @get
  get(
    ...Azure.ResourceManager.ApiVersionParameter,
    ...Azure.ResourceManager.SubscriptionIdParameter,
    ...Azure.ResourceManager.ResourceGroupParameter,
    ...Azure.ResourceManager.LocationParameter,

    /**
     * Cosmos DB database account name.
     */
    @maxLength(50)
    @minLength(3)
    @pattern("^[a-z0-9]+(-[a-z0-9]+)*")
    @path
    accountName: string,
  ): ArmResponse<SoftDeletedDatabaseAccountGetResult> | Azure.ResourceManager.CommonTypes.ErrorResponse;

  /**
   * Lists all the soft-deleted Azure Cosmos DB database accounts available under the subscription and in a region. This call requires 'Microsoft.DocumentDB/locations/softDeletedDatabaseAccounts/read' permission.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "Custom operation for soft-deleted resources"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "x-ms-pageable is required for ARM list operations"
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.DocumentDB/locations/{location}/softDeletedDatabaseAccounts")
  @get
  @extension("x-ms-pageable", #{ nextLinkName: "nextLink" })
  listByLocation(
    ...Azure.ResourceManager.ApiVersionParameter,
    ...Azure.ResourceManager.SubscriptionIdParameter,
    ...Azure.ResourceManager.LocationParameter,
  ): ArmResponse<SoftDeletedDatabaseAccountsListResult> | Azure.ResourceManager.CommonTypes.ErrorResponse;

  /**
   * Lists all the soft-deleted Azure Cosmos DB database accounts available under the given resource group and in a region. This call requires 'Microsoft.DocumentDB/locations/softDeletedDatabaseAccounts/read' permission.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "x-ms-pageable is required for ARM list operations"
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DocumentDB/locations/{location}/softDeletedDatabaseAccounts")
  @get
  @extension("x-ms-pageable", #{ nextLinkName: "nextLink" })
  listByResourceGroupAndLocation(
    ...Azure.ResourceManager.SubscriptionIdParameter,
    ...Azure.ResourceManager.ResourceGroupParameter,
    ...Azure.ResourceManager.LocationParameter,
    ...Azure.ResourceManager.ApiVersionParameter,
  ): ArmResponse<SoftDeletedDatabaseAccountsListResult> | Azure.ResourceManager.CommonTypes.ErrorResponse;

  /**
   * Restores a soft-deleted Azure Cosmos DB database account.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DocumentDB/locations/{location}/softDeletedDatabaseAccounts/{accountName}?softDeleteActionKind=RestoreSoftDeletedResource")
  @delete
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Explicit operationId needed for separate Restore/Purge SDK methods"
  @operationId("SoftDeletedDatabaseAccounts_Restore")
  restore(
    ...Azure.ResourceManager.SubscriptionIdParameter,
    ...Azure.ResourceManager.ResourceGroupParameter,
    ...Azure.ResourceManager.LocationParameter,

    /**
     * Cosmos DB database account name.
     */
    @maxLength(50)
    @minLength(3)
    @pattern("^[a-z0-9]+(-[a-z0-9]+)*")
    @path
    accountName: string,

    ...Azure.ResourceManager.ApiVersionParameter,

    /**
     * The kind of soft delete action to perform.
     */
    @query("softDeleteActionKind")
    softDeleteActionKind?: SoftDeleteActionKind,
  ): ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse | Azure.ResourceManager.CommonTypes.ErrorResponse;

  /**
   * Permanently deletes (purges) a soft-deleted Azure Cosmos DB database account.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DocumentDB/locations/{location}/softDeletedDatabaseAccounts/{accountName}?softDeleteActionKind=PermanentDeleteResource")
  @delete
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Explicit operationId needed for separate Restore/Purge SDK methods"
  @operationId("SoftDeletedDatabaseAccounts_Purge")
  purge(
    ...Azure.ResourceManager.SubscriptionIdParameter,
    ...Azure.ResourceManager.ResourceGroupParameter,
    ...Azure.ResourceManager.LocationParameter,

    /**
     * Cosmos DB database account name.
     */
    @maxLength(50)
    @minLength(3)
    @pattern("^[a-z0-9]+(-[a-z0-9]+)*")
    @path
    accountName: string,

    ...Azure.ResourceManager.ApiVersionParameter,

    /**
     * The kind of soft delete action to perform.
     */
    @query("softDeleteActionKind")
    softDeleteActionKind?: SoftDeleteActionKind,
  ): ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse | Azure.ResourceManager.CommonTypes.ErrorResponse;
}

// ──────────────────────────────────────────────
//  Soft-Deleted SQL Database Operations
// ──────────────────────────────────────────────

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "Custom routes for soft-deleted resources"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom routes for soft-deleted resources"
@added(Versions.v2026_04_01_preview)
interface SoftDeletedSqlDatabases {
  /**
   * Retrieves the properties of a soft-deleted Azure Cosmos DB SQL database. This call requires 'Microsoft.DocumentDB/locations/softDeletedDatabaseAccounts/softDeletedSqlDatabases/read' permission.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DocumentDB/locations/{location}/softDeletedDatabaseAccounts/{accountName}/softDeletedSqlDatabases/{databaseName}")
  @get
  get(
    ...Azure.ResourceManager.ApiVersionParameter,
    ...Azure.ResourceManager.SubscriptionIdParameter,
    ...Azure.ResourceManager.ResourceGroupParameter,
    ...Azure.ResourceManager.LocationParameter,

    /**
     * Cosmos DB database account name.
     */
    @maxLength(50)
    @minLength(3)
    @pattern("^[a-z0-9]+(-[a-z0-9]+)*")
    @path
    accountName: string,

    /**
     * Cosmos DB SQL database name.
     */
    @maxLength(255)
    @minLength(1)
    @pattern("^[^/\\\\#?]+$")
    @path
    databaseName: string,
  ): ArmResponse<SoftDeletedSqlDatabaseGetResult> | Azure.ResourceManager.CommonTypes.ErrorResponse;

  /**
   * Lists all the soft-deleted Azure Cosmos DB SQL databases under a soft-deleted database account. This call requires 'Microsoft.DocumentDB/locations/softDeletedDatabaseAccounts/softDeletedSqlDatabases/read' permission.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "x-ms-pageable is required for ARM list operations"
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DocumentDB/locations/{location}/softDeletedDatabaseAccounts/{accountName}/softDeletedSqlDatabases")
  @get
  @extension("x-ms-pageable", #{ nextLinkName: "nextLink" })
  list(
    ...Azure.ResourceManager.ApiVersionParameter,
    ...Azure.ResourceManager.SubscriptionIdParameter,
    ...Azure.ResourceManager.ResourceGroupParameter,
    ...Azure.ResourceManager.LocationParameter,

    /**
     * Cosmos DB database account name.
     */
    @maxLength(50)
    @minLength(3)
    @pattern("^[a-z0-9]+(-[a-z0-9]+)*")
    @path
    accountName: string,
  ): ArmResponse<SoftDeletedSqlDatabasesListResult> | Azure.ResourceManager.CommonTypes.ErrorResponse;

  /**
   * Restores a soft-deleted Azure Cosmos DB SQL database.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DocumentDB/locations/{location}/softDeletedDatabaseAccounts/{accountName}/softDeletedSqlDatabases/{databaseName}?softDeleteActionKind=RestoreSoftDeletedResource")
  @delete
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Explicit operationId needed for separate Restore/Purge SDK methods"
  @operationId("SoftDeletedSqlDatabases_Restore")
  restore(
    ...Azure.ResourceManager.SubscriptionIdParameter,
    ...Azure.ResourceManager.ResourceGroupParameter,
    ...Azure.ResourceManager.LocationParameter,

    /**
     * Cosmos DB database account name.
     */
    @maxLength(50)
    @minLength(3)
    @pattern("^[a-z0-9]+(-[a-z0-9]+)*")
    @path
    accountName: string,

    /**
     * Cosmos DB SQL database name.
     */
    @maxLength(255)
    @minLength(1)
    @pattern("^[^/\\\\#?]+$")
    @path
    databaseName: string,

    ...Azure.ResourceManager.ApiVersionParameter,

    /**
     * The kind of soft delete action to perform.
     */
    @query("softDeleteActionKind")
    softDeleteActionKind?: SoftDeleteActionKind,
  ): ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse | Azure.ResourceManager.CommonTypes.ErrorResponse;

  /**
   * Permanently deletes a soft-deleted Azure Cosmos DB SQL database.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DocumentDB/locations/{location}/softDeletedDatabaseAccounts/{accountName}/softDeletedSqlDatabases/{databaseName}?softDeleteActionKind=PermanentDeleteResource")
  @delete
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Explicit operationId needed for separate Restore/Purge SDK methods"
  @operationId("SoftDeletedSqlDatabases_Purge")
  purge(
    ...Azure.ResourceManager.SubscriptionIdParameter,
    ...Azure.ResourceManager.ResourceGroupParameter,
    ...Azure.ResourceManager.LocationParameter,

    /**
     * Cosmos DB database account name.
     */
    @maxLength(50)
    @minLength(3)
    @pattern("^[a-z0-9]+(-[a-z0-9]+)*")
    @path
    accountName: string,

    /**
     * Cosmos DB SQL database name.
     */
    @maxLength(255)
    @minLength(1)
    @pattern("^[^/\\\\#?]+$")
    @path
    databaseName: string,

    ...Azure.ResourceManager.ApiVersionParameter,

    /**
     * The kind of soft delete action to perform.
     */
    @query("softDeleteActionKind")
    softDeleteActionKind?: SoftDeleteActionKind,
  ): ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse | Azure.ResourceManager.CommonTypes.ErrorResponse;
}

// ──────────────────────────────────────────────
//  Soft-Deleted SQL Container Operations
// ──────────────────────────────────────────────

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "Custom routes for soft-deleted resources"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom routes for soft-deleted resources"
@added(Versions.v2026_04_01_preview)
interface SoftDeletedSqlContainers {
  /**
   * Retrieves the properties of a soft-deleted Azure Cosmos DB SQL container. This call requires 'Microsoft.DocumentDB/locations/softDeletedDatabaseAccounts/softDeletedSqlDatabases/softDeletedSqlContainers/read' permission.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DocumentDB/locations/{location}/softDeletedDatabaseAccounts/{accountName}/softDeletedSqlDatabases/{databaseName}/softDeletedSqlContainers/{containerName}")
  @get
  get(
    ...Azure.ResourceManager.ApiVersionParameter,
    ...Azure.ResourceManager.SubscriptionIdParameter,
    ...Azure.ResourceManager.ResourceGroupParameter,
    ...Azure.ResourceManager.LocationParameter,

    /**
     * Cosmos DB database account name.
     */
    @maxLength(50)
    @minLength(3)
    @pattern("^[a-z0-9]+(-[a-z0-9]+)*")
    @path
    accountName: string,

    /**
     * Cosmos DB SQL database name.
     */
    @maxLength(255)
    @minLength(1)
    @pattern("^[^/\\\\#?]+$")
    @path
    databaseName: string,

    /**
     * Cosmos DB SQL container name.
     */
    @maxLength(255)
    @minLength(1)
    @pattern("^[^/\\\\#?]+$")
    @path
    containerName: string,
  ): ArmResponse<SoftDeletedSqlContainerGetResult> | Azure.ResourceManager.CommonTypes.ErrorResponse;

  /**
   * Lists all the soft-deleted Azure Cosmos DB SQL containers under a soft-deleted SQL database. This call requires 'Microsoft.DocumentDB/locations/softDeletedDatabaseAccounts/softDeletedSqlDatabases/softDeletedSqlContainers/read' permission.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "x-ms-pageable is required for ARM list operations"
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DocumentDB/locations/{location}/softDeletedDatabaseAccounts/{accountName}/softDeletedSqlDatabases/{databaseName}/softDeletedSqlContainers")
  @get
  @extension("x-ms-pageable", #{ nextLinkName: "nextLink" })
  list(
    ...Azure.ResourceManager.ApiVersionParameter,
    ...Azure.ResourceManager.SubscriptionIdParameter,
    ...Azure.ResourceManager.ResourceGroupParameter,
    ...Azure.ResourceManager.LocationParameter,

    /**
     * Cosmos DB database account name.
     */
    @maxLength(50)
    @minLength(3)
    @pattern("^[a-z0-9]+(-[a-z0-9]+)*")
    @path
    accountName: string,

    /**
     * Cosmos DB SQL database name.
     */
    @maxLength(255)
    @minLength(1)
    @pattern("^[^/\\\\#?]+$")
    @path
    databaseName: string,
  ): ArmResponse<SoftDeletedSqlContainersListResult> | Azure.ResourceManager.CommonTypes.ErrorResponse;

  /**
   * Restores a soft-deleted Azure Cosmos DB SQL container to active state.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DocumentDB/locations/{location}/softDeletedDatabaseAccounts/{accountName}/softDeletedSqlDatabases/{databaseName}/softDeletedSqlContainers/{containerName}?softDeleteActionKind=RestoreSoftDeletedResource")
  @delete
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Explicit operationId needed for separate Restore/Purge SDK methods"
  @operationId("SoftDeletedSqlContainers_Restore")
  restore(
    ...Azure.ResourceManager.SubscriptionIdParameter,
    ...Azure.ResourceManager.ResourceGroupParameter,
    ...Azure.ResourceManager.LocationParameter,

    /**
     * Cosmos DB database account name.
     */
    @maxLength(50)
    @minLength(3)
    @pattern("^[a-z0-9]+(-[a-z0-9]+)*")
    @path
    accountName: string,

    /**
     * Cosmos DB SQL database name.
     */
    @maxLength(255)
    @minLength(1)
    @pattern("^[^/\\\\#?]+$")
    @path
    databaseName: string,

    /**
     * Cosmos DB SQL container name.
     */
    @maxLength(255)
    @minLength(1)
    @pattern("^[^/\\\\#?]+$")
    @path
    containerName: string,

    ...Azure.ResourceManager.ApiVersionParameter,

    /**
     * The kind of soft delete action to perform.
     */
    @query("softDeleteActionKind")
    softDeleteActionKind?: SoftDeleteActionKind,
  ): ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse | Azure.ResourceManager.CommonTypes.ErrorResponse;

  /**
   * Permanently deletes a soft-deleted Azure Cosmos DB SQL container.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DocumentDB/locations/{location}/softDeletedDatabaseAccounts/{accountName}/softDeletedSqlDatabases/{databaseName}/softDeletedSqlContainers/{containerName}?softDeleteActionKind=PermanentDeleteResource")
  @delete
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Explicit operationId needed for separate Restore/Purge SDK methods"
  @operationId("SoftDeletedSqlContainers_Purge")
  purge(
    ...Azure.ResourceManager.SubscriptionIdParameter,
    ...Azure.ResourceManager.ResourceGroupParameter,
    ...Azure.ResourceManager.LocationParameter,

    /**
     * Cosmos DB database account name.
     */
    @maxLength(50)
    @minLength(3)
    @pattern("^[a-z0-9]+(-[a-z0-9]+)*")
    @path
    accountName: string,

    /**
     * Cosmos DB SQL database name.
     */
    @maxLength(255)
    @minLength(1)
    @pattern("^[^/\\\\#?]+$")
    @path
    databaseName: string,

    /**
     * Cosmos DB SQL container name.
     */
    @maxLength(255)
    @minLength(1)
    @pattern("^[^/\\\\#?]+$")
    @path
    containerName: string,

    ...Azure.ResourceManager.ApiVersionParameter,

    /**
     * The kind of soft delete action to perform.
     */
    @query("softDeleteActionKind")
    softDeleteActionKind?: SoftDeleteActionKind,
  ): ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse | Azure.ResourceManager.CommonTypes.ErrorResponse;
}
