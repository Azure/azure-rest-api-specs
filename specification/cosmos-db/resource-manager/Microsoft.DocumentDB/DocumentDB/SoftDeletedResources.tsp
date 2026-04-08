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

@added(Versions.v2026_04_01_preview)
/**
 * The kind of soft delete action to perform.
 */
union SoftDeleteActionKind {
  string,

  /** Restores the soft-deleted resource to active/online state. */
  RestoreSoftDeletedResource: "RestoreSoftDeletedResource",

  /** Permanently deletes the soft-deleted resource. */
  PermanentDeleteResource: "PermanentDeleteResource",
}

@added(Versions.v2026_04_01_preview)
/**
 * Metadata about the soft deletion of a resource.
 */
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

@added(Versions.v2026_04_01_preview)
/**
 * The database account resource information for a soft-deleted account.
 */
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

@added(Versions.v2026_04_01_preview)
/**
 * The properties of a soft-deleted database account.
 */
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

@added(Versions.v2026_04_01_preview)
/**
 * A Azure Cosmos DB soft-deleted database account.
 */
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
  location?: string;
}

@added(Versions.v2026_04_01_preview)
/**
 * The List operation response, that contains the soft-deleted database accounts and their properties.
 */
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

@added(Versions.v2026_04_01_preview)
/**
 * Cosmos DB SQL database resource object
 */
model SoftDeletedSqlDatabaseResource {
  /**
   * Name of the Cosmos DB SQL database
   */
  id: string;

  /**
   * A system generated property. A unique identifier.
   */
  @visibility(Lifecycle.Read)
  #suppress "@azure-tools/typespec-azure-core/casing-style" "_rid is a backend property"
  _rid?: string;
}

@added(Versions.v2026_04_01_preview)
/**
 * The properties of a soft-deleted SQL database.
 */
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

@added(Versions.v2026_04_01_preview)
/**
 * An Azure Cosmos DB soft-deleted SQL database.
 */
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
  location?: string;
}

@added(Versions.v2026_04_01_preview)
/**
 * The List operation response, that contains the soft-deleted SQL databases and their properties.
 */
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

@added(Versions.v2026_04_01_preview)
/**
 * Cosmos DB SQL container resource object
 */
model SoftDeletedSqlContainerResource {
  /**
   * Name of the Cosmos DB SQL container
   */
  id: string;

  /**
   * A system generated property. A unique identifier.
   */
  @visibility(Lifecycle.Read)
  #suppress "@azure-tools/typespec-azure-core/casing-style" "_rid is a backend property"
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

@added(Versions.v2026_04_01_preview)
/**
 * The properties of a soft-deleted SQL container.
 */
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

@added(Versions.v2026_04_01_preview)
/**
 * An Azure Cosmos DB soft-deleted SQL container.
 */
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
  location?: string;
}

@added(Versions.v2026_04_01_preview)
/**
 * The List operation response, that contains the soft-deleted SQL containers and their properties.
 */
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

@added(Versions.v2026_04_01_preview)
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "Custom routes for soft-deleted resources"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom routes for soft-deleted resources"
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

    /**
     * Cosmos DB region, with spaces between words and each word capitalized.
     */
    @path
    location: string,

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
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.DocumentDB/locations/{location}/softDeletedDatabaseAccounts")
  @get
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "x-ms-pageable is required for ARM list operations"
  @extension("x-ms-pageable", #{nextLinkName: "nextLink"})
  listByLocation(
    ...Azure.ResourceManager.ApiVersionParameter,
    ...Azure.ResourceManager.SubscriptionIdParameter,

    /**
     * Cosmos DB region, with spaces between words and each word capitalized.
     */
    @path
    location: string,
  ): ArmResponse<SoftDeletedDatabaseAccountsListResult> | Azure.ResourceManager.CommonTypes.ErrorResponse;

  /**
   * Lists all the soft-deleted Azure Cosmos DB database accounts available under the given resource group and in a region. This call requires 'Microsoft.DocumentDB/locations/softDeletedDatabaseAccounts/read' permission.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DocumentDB/locations/{location}/softDeletedDatabaseAccounts")
  @get
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "x-ms-pageable is required for ARM list operations"
  @extension("x-ms-pageable", #{nextLinkName: "nextLink"})
  listByResourceGroupAndLocation(
    ...Azure.ResourceManager.SubscriptionIdParameter,
    ...Azure.ResourceManager.ResourceGroupParameter,

    /**
     * Cosmos DB region, with spaces between words and each word capitalized.
     */
    @path
    location: string,

    ...Azure.ResourceManager.ApiVersionParameter,
  ): ArmResponse<SoftDeletedDatabaseAccountsListResult> | Azure.ResourceManager.CommonTypes.ErrorResponse;

  /**
   * Performs a soft delete action (restore or permanently delete) on a soft-deleted Azure Cosmos DB database account.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DocumentDB/locations/{location}/softDeletedDatabaseAccounts/{accountName}")
  @delete
  delete(
    ...Azure.ResourceManager.SubscriptionIdParameter,
    ...Azure.ResourceManager.ResourceGroupParameter,

    /**
     * Cosmos DB region, with spaces between words and each word capitalized.
     */
    @path
    location: string,

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

@added(Versions.v2026_04_01_preview)
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "Custom routes for soft-deleted resources"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom routes for soft-deleted resources"
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

    /**
     * Cosmos DB region, with spaces between words and each word capitalized.
     */
    @path
    location: string,

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
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DocumentDB/locations/{location}/softDeletedDatabaseAccounts/{accountName}/softDeletedSqlDatabases")
  @get
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "x-ms-pageable is required for ARM list operations"
  @extension("x-ms-pageable", #{nextLinkName: "nextLink"})
  list(
    ...Azure.ResourceManager.ApiVersionParameter,
    ...Azure.ResourceManager.SubscriptionIdParameter,
    ...Azure.ResourceManager.ResourceGroupParameter,

    /**
     * Cosmos DB region, with spaces between words and each word capitalized.
     */
    @path
    location: string,

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
   * Performs a soft delete action (restore or permanently delete) on a soft-deleted Azure Cosmos DB SQL database.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DocumentDB/locations/{location}/softDeletedDatabaseAccounts/{accountName}/softDeletedSqlDatabases/{databaseName}")
  @delete
  delete(
    ...Azure.ResourceManager.SubscriptionIdParameter,
    ...Azure.ResourceManager.ResourceGroupParameter,

    /**
     * Cosmos DB region, with spaces between words and each word capitalized.
     */
    @path
    location: string,

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

@added(Versions.v2026_04_01_preview)
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "Custom routes for soft-deleted resources"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom routes for soft-deleted resources"
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

    /**
     * Cosmos DB region, with spaces between words and each word capitalized.
     */
    @path
    location: string,

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
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DocumentDB/locations/{location}/softDeletedDatabaseAccounts/{accountName}/softDeletedSqlDatabases/{databaseName}/softDeletedSqlContainers")
  @get
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "x-ms-pageable is required for ARM list operations"
  @extension("x-ms-pageable", #{nextLinkName: "nextLink"})
  list(
    ...Azure.ResourceManager.ApiVersionParameter,
    ...Azure.ResourceManager.SubscriptionIdParameter,
    ...Azure.ResourceManager.ResourceGroupParameter,

    /**
     * Cosmos DB region, with spaces between words and each word capitalized.
     */
    @path
    location: string,

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
   * Performs a soft delete action (restore or permanently delete) on a soft-deleted Azure Cosmos DB SQL container.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DocumentDB/locations/{location}/softDeletedDatabaseAccounts/{accountName}/softDeletedSqlDatabases/{databaseName}/softDeletedSqlContainers/{containerName}")
  @delete
  delete(
    ...Azure.ResourceManager.SubscriptionIdParameter,
    ...Azure.ResourceManager.ResourceGroupParameter,

    /**
     * Cosmos DB region, with spaces between words and each word capitalized.
     */
    @path
    location: string,

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
