import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./LocationGetResult.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DocumentDB;
/**
 * A Azure Cosmos DB restorable database account.
 */
@subscriptionResource
@parentResource(LocationGetResult)
model RestorableDatabaseAccountGetResult
  is Azure.ResourceManager.ProxyResource<RestorableDatabaseAccountProperties> {
  ...ResourceNameParameter<
    Resource = RestorableDatabaseAccountGetResult,
    KeyName = "instanceId",
    SegmentName = "restorableDatabaseAccounts",
    NamePattern = ""
  >;

  /**
   * The location of the resource group to which the resource belongs.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  location?: string;
}

@armResourceOperations
interface RestorableDatabaseAccountGetResults {
  /**
   * Retrieves the properties of an existing Azure Cosmos DB restorable database account.  This call requires 'Microsoft.DocumentDB/locations/restorableDatabaseAccounts/read/*' permission.
   */
  getByLocation is ArmResourceRead<
    RestorableDatabaseAccountGetResult,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Error = CloudError
  >;

  /**
   * Lists all the restorable Azure Cosmos DB database accounts available under the subscription and in a region.  This call requires 'Microsoft.DocumentDB/locations/restorableDatabaseAccounts/read' permission.
   */
  @list
  listByLocation is ArmResourceListByParent<
    RestorableDatabaseAccountGetResult,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Response = ArmResponse<RestorableDatabaseAccountsListResult>,
    Error = CloudError
  >;

  /**
   * Show the event feed of all mutations done on all the Azure Cosmos DB SQL databases under the restorable account.  This helps in scenario where database was accidentally deleted to get the deletion time.  This API requires 'Microsoft.DocumentDB/locations/restorableDatabaseAccounts/.../read' permission
   */
  @list
  @get
  @action("restorableSqlDatabases")
  list is ArmResourceActionSync<
    RestorableDatabaseAccountGetResult,
    void,
    ArmResponse<RestorableSqlDatabasesListResult>,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Error = CloudError
  >;

  /**
   * Show the event feed of all mutations done on all the Azure Cosmos DB SQL containers under a specific database.  This helps in scenario where container was accidentally deleted.  This API requires 'Microsoft.DocumentDB/locations/restorableDatabaseAccounts/.../read' permission
   */
  @list
  @get
  @action("restorableSqlContainers")
  restorableSqlContainersList is ArmResourceActionSync<
    RestorableDatabaseAccountGetResult,
    void,
    ArmResponse<RestorableSqlContainersListResult>,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Parameters = {
      /**
       * The resource ID of the SQL database.
       */
      @query("restorableSqlDatabaseRid")
      restorableSqlDatabaseRid?: string;

      /**
       * Restorable Sql containers event feed start time.
       */
      @query("startTime")
      startTime?: string;

      /**
       * Restorable Sql containers event feed end time.
       */
      @query("endTime")
      endTime?: string;
    },
    Error = CloudError
  >;

  /**
   * Return a list of database and container combo that exist on the account at the given timestamp and location. This helps in scenarios to validate what resources exist at given timestamp and location. This API requires 'Microsoft.DocumentDB/locations/restorableDatabaseAccounts/.../read' permission.
   */
  @list
  @get
  @action("restorableSqlResources")
  restorableSqlResourcesList is ArmResourceActionSync<
    RestorableDatabaseAccountGetResult,
    void,
    ArmResponse<RestorableSqlResourcesListResult>,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Parameters = {
      /**
       * The location where the restorable resources are located.
       */
      @query("restoreLocation")
      restoreLocation?: string;

      /**
       * The timestamp when the restorable resources existed.
       */
      @query("restoreTimestampInUtc")
      restoreTimestampInUtc?: string;
    },
    Error = CloudError
  >;

  /**
   * Show the event feed of all mutations done on all the Azure Cosmos DB MongoDB databases under the restorable account.  This helps in scenario where database was accidentally deleted to get the deletion time.  This API requires  'Microsoft.DocumentDB/locations/restorableDatabaseAccounts/.../read' permission
   */
  @list
  @get
  @action("restorableMongodbDatabases")
  restorableMongodbDatabasesList is ArmResourceActionSync<
    RestorableDatabaseAccountGetResult,
    void,
    ArmResponse<RestorableMongodbDatabasesListResult>,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Error = CloudError
  >;

  /**
   * Show the event feed of all mutations done on all the Azure Cosmos DB MongoDB collections under a specific database.  This helps in scenario where container was accidentally deleted.  This API requires 'Microsoft.DocumentDB/locations/restorableDatabaseAccounts/.../read' permission
   */
  @list
  @get
  @action("restorableMongodbCollections")
  restorableMongodbCollectionsList is ArmResourceActionSync<
    RestorableDatabaseAccountGetResult,
    void,
    ArmResponse<RestorableMongodbCollectionsListResult>,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Parameters = {
      /**
       * The resource ID of the MongoDB database.
       */
      @query("restorableMongodbDatabaseRid")
      restorableMongodbDatabaseRid?: string;

      /**
       * Restorable MongoDB collections event feed start time.
       */
      @query("startTime")
      startTime?: string;

      /**
       * Restorable MongoDB collections event feed end time.
       */
      @query("endTime")
      endTime?: string;
    },
    Error = CloudError
  >;

  /**
   * Return a list of database and collection combo that exist on the account at the given timestamp and location. This helps in scenarios to validate what resources exist at given timestamp and location. This API requires 'Microsoft.DocumentDB/locations/restorableDatabaseAccounts/.../read' permission.
   */
  @list
  @get
  @action("restorableMongodbResources")
  restorableMongodbResourcesList is ArmResourceActionSync<
    RestorableDatabaseAccountGetResult,
    void,
    ArmResponse<RestorableMongodbResourcesListResult>,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Parameters = {
      /**
       * The location where the restorable resources are located.
       */
      @query("restoreLocation")
      restoreLocation?: string;

      /**
       * The timestamp when the restorable resources existed.
       */
      @query("restoreTimestampInUtc")
      restoreTimestampInUtc?: string;
    },
    Error = CloudError
  >;

  /**
   * Show the event feed of all mutations done on all the Azure Cosmos DB Gremlin databases under the restorable account. This helps in scenario where database was accidentally deleted to get the deletion time. This API requires 'Microsoft.DocumentDB/locations/restorableDatabaseAccounts/.../read' permission
   */
  @list
  @get
  @action("restorableGremlinDatabases")
  restorableGremlinDatabasesList is ArmResourceActionSync<
    RestorableDatabaseAccountGetResult,
    void,
    ArmResponse<RestorableGremlinDatabasesListResult>,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Error = CloudError
  >;

  /**
   * Show the event feed of all mutations done on all the Azure Cosmos DB Gremlin graphs under a specific database. This helps in scenario where container was accidentally deleted. This API requires 'Microsoft.DocumentDB/locations/restorableDatabaseAccounts/.../read' permission
   */
  @list
  @get
  @action("restorableGraphs")
  restorableGremlinGraphsList is ArmResourceActionSync<
    RestorableDatabaseAccountGetResult,
    void,
    ArmResponse<RestorableGremlinGraphsListResult>,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Parameters = {
      /**
       * The resource ID of the Gremlin database.
       */
      @query("restorableGremlinDatabaseRid")
      restorableGremlinDatabaseRid?: string;

      /**
       * Restorable Gremlin graphs event feed start time.
       */
      @query("startTime")
      startTime?: string;

      /**
       * Restorable Gremlin graphs event feed end time.
       */
      @query("endTime")
      endTime?: string;
    },
    Error = CloudError
  >;

  /**
   * Return a list of gremlin database and graphs combo that exist on the account at the given timestamp and location. This helps in scenarios to validate what resources exist at given timestamp and location. This API requires 'Microsoft.DocumentDB/locations/restorableDatabaseAccounts/.../read' permission.
   */
  @list
  @get
  @action("restorableGremlinResources")
  restorableGremlinResourcesList is ArmResourceActionSync<
    RestorableDatabaseAccountGetResult,
    void,
    ArmResponse<RestorableGremlinResourcesListResult>,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Parameters = {
      /**
       * The location where the restorable resources are located.
       */
      @query("restoreLocation")
      restoreLocation?: string;

      /**
       * The timestamp when the restorable resources existed.
       */
      @query("restoreTimestampInUtc")
      restoreTimestampInUtc?: string;
    },
    Error = CloudError
  >;

  /**
   * Show the event feed of all mutations done on all the Azure Cosmos DB Tables. This helps in scenario where table was accidentally deleted. This API requires 'Microsoft.DocumentDB/locations/restorableDatabaseAccounts/.../read' permission
   */
  @list
  @get
  @action("restorableTables")
  restorableTablesList is ArmResourceActionSync<
    RestorableDatabaseAccountGetResult,
    void,
    ArmResponse<RestorableTablesListResult>,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Parameters = {
      /**
       * Restorable Tables event feed start time.
       */
      @query("startTime")
      startTime?: string;

      /**
       * Restorable Tables event feed end time.
       */
      @query("endTime")
      endTime?: string;
    },
    Error = CloudError
  >;

  /**
   * Return a list of tables that exist on the account at the given timestamp and location. This helps in scenarios to validate what resources exist at given timestamp and location. This API requires 'Microsoft.DocumentDB/locations/restorableDatabaseAccounts/.../read' permission.
   */
  @list
  @get
  @action("restorableTableResources")
  restorableTableResourcesList is ArmResourceActionSync<
    RestorableDatabaseAccountGetResult,
    void,
    ArmResponse<RestorableTableResourcesListResult>,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Parameters = {
      /**
       * The location where the restorable resources are located.
       */
      @query("restoreLocation")
      restoreLocation?: string;

      /**
       * The timestamp when the restorable resources existed.
       */
      @query("restoreTimestampInUtc")
      restoreTimestampInUtc?: string;
    },
    Error = CloudError
  >;
}

@@doc(RestorableDatabaseAccountGetResult.name,
  "The instanceId GUID of a restorable database account."
);
@@doc(RestorableDatabaseAccountGetResult.properties,
  "The properties of a restorable database account."
);
