import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Cluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Kusto;
// FIXME: Database has no properties property
/**
 * Class representing a Kusto database.
 */
@parentResource(Cluster)
model Database is ProxyResource<{}> {
  /**
   * The name of the database in the Kusto cluster.
   */
  @pattern("^.*$")
  @path
  @key("databaseName")
  @segment("databases")
  name: string;

  /**
   * Kind of the database
   */
  kind: Kind;
}

@armResourceOperations
interface Databases {
  /**
   * Returns a database.
   */
  get is ArmResourceRead<Database>;

  /**
   * Creates or updates a database.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Database,
    {
      ...BaseParameters<Database>;

      /**
       * By default, any user who run operation on a database become an Admin on it. This property allows the caller to exclude the caller from Admins list.
       */
      @query("callerRole")
      callerRole?: CallerRole = CallerRole.Admin;
    }
  >;

  /**
   * Updates a database.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<
    Database,
    Database,
    {
      ...BaseParameters<Database>;

      /**
       * By default, any user who run operation on a database become an Admin on it. This property allows the caller to exclude the caller from Admins list.
       */
      @query("callerRole")
      callerRole?: CallerRole = CallerRole.Admin;
    }
  >;

  /**
   * Deletes the database with the given name.
   */
  delete is ArmResourceDeleteAsync<Database>;

  /**
   * Returns the list of databases of the given Kusto cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Databases_ListByCluster")
  listByCluster is ArmResourceListByParent<
    Database,
    {
      ...BaseParameters<Database>;

      /**
       * limit the number of results
       */
      @maxValue(1000)
      @minValue(5)
      @query("$top")
      $top?: int32;

      /**
       * Skiptoken is only used if a previous operation returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skiptoken parameter that specifies a starting point to use for subsequent calls.
       */
      @query("$skiptoken")
      $skiptoken?: string;
    }
  >;

  /**
   * Returns a list of database principals of the given Kusto cluster and database.
   */
  listPrincipals is ArmResourceActionSync<
    Database,
    void,
    DatabasePrincipalListResult
  >;

  /**
   * Add Database principals permissions.
   */
  addPrincipals is ArmResourceActionSync<
    Database,
    DatabasePrincipalListRequest,
    DatabasePrincipalListResult
  >;

  /**
   * Remove Database principals permissions.
   */
  removePrincipals is ArmResourceActionSync<
    Database,
    DatabasePrincipalListRequest,
    DatabasePrincipalListResult
  >;

  /**
   * Generates an invitation token that allows attaching a follower database to this database.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Database_InviteFollower")
  inviteFollower is ArmResourceActionSync<
    Database,
    DatabaseInviteFollowerRequest,
    DatabaseInviteFollowerResult
  >;

  /**
   * Checks that the database principal assignment is valid and is not already in use.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DatabasePrincipalAssignments_CheckNameAvailability")
  checkNameAvailability is ArmResourceActionSync<
    Database,
    DatabasePrincipalAssignmentCheckNameRequest,
    CheckNameResult
  >;

  /**
   * Checks that the script name is valid and is not already in use.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Scripts_CheckNameAvailability")
  checkNameAvailability is ArmResourceActionSync<
    Database,
    ScriptCheckNameRequest,
    CheckNameResult
  >;

  /**
   * Checks that the data connection parameters are valid.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DataConnections_dataConnectionValidation")
  dataConnectionValidation is ArmResourceActionAsync<
    Database,
    DataConnectionValidation,
    DataConnectionValidationListResult
  >;

  /**
   * Checks that the data connection name is valid and is not already in use.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DataConnections_CheckNameAvailability")
  checkNameAvailability is ArmResourceActionSync<
    Database,
    DataConnectionCheckNameRequest,
    CheckNameResult
  >;
}

@@projectedName(Databases.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(Databases.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(Databases.createOrUpdate::parameters.resource,
  "The database parameters supplied to the CreateOrUpdate operation."
);
@@projectedName(Databases.update::parameters.properties, "json", "parameters");
@@extension(Databases.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(Databases.update::parameters.properties,
  "The database parameters supplied to the Update operation."
);
@@projectedName(Databases.addPrincipals::parameters.body,
  "json",
  "databasePrincipalsToAdd"
);
@@extension(Databases.addPrincipals::parameters.body,
  "x-ms-client-name",
  "databasePrincipalsToAdd"
);
@@doc(Databases.addPrincipals::parameters.body,
  "List of database principals to add."
);
@@projectedName(Databases.removePrincipals::parameters.body,
  "json",
  "databasePrincipalsToRemove"
);
@@extension(Databases.removePrincipals::parameters.body,
  "x-ms-client-name",
  "databasePrincipalsToRemove"
);
@@doc(Databases.removePrincipals::parameters.body,
  "List of database principals to remove."
);
@@projectedName(Databases.inviteFollower::parameters.body,
  "json",
  "parameters"
);
@@extension(Databases.inviteFollower::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@doc(Databases.inviteFollower::parameters.body,
  "The follower invitation request parameters."
);
@@projectedName(Databases.checkNameAvailability::parameters.body,
  "json",
  "principalAssignmentName"
);
@@extension(Databases.checkNameAvailability::parameters.body,
  "x-ms-client-name",
  "principalAssignmentName"
);
@@doc(Databases.checkNameAvailability::parameters.body,
  "The name of the resource."
);
@@projectedName(Databases.checkNameAvailability::parameters.body,
  "json",
  "scriptName"
);
@@extension(Databases.checkNameAvailability::parameters.body,
  "x-ms-client-name",
  "scriptName"
);
@@doc(Databases.checkNameAvailability::parameters.body,
  "The name of the script."
);
@@projectedName(Databases.dataConnectionValidation::parameters.body,
  "json",
  "parameters"
);
@@extension(Databases.dataConnectionValidation::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@doc(Databases.dataConnectionValidation::parameters.body,
  "The data connection parameters supplied to the CreateOrUpdate operation."
);
@@projectedName(Databases.checkNameAvailability::parameters.body,
  "json",
  "dataConnectionName"
);
@@extension(Databases.checkNameAvailability::parameters.body,
  "x-ms-client-name",
  "dataConnectionName"
);
@@doc(Databases.checkNameAvailability::parameters.body,
  "The name of the data connection."
);
