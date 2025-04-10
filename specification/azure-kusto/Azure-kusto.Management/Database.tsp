import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Cluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Kusto;
// FIXME: Database has no properties property
/**
 * Class representing a Kusto database.
 */
@parentResource(Cluster)
model Database is Azure.ResourceManager.ProxyResource<{}> {
  ...ResourceNameParameter<
    Resource = Database,
    KeyName = "databaseName",
    SegmentName = "databases",
    NamePattern = "^.*$"
  >;

  /**
   * Resource location.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  location?: string;

  /**
   * Kind of the database
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Database,
    Parameters = {
      /**
       * By default, any user who run operation on a database become an Admin on it. This property allows the caller to exclude the caller from Admins list.
       */
      @query("callerRole")
      callerRole?: CallerRole = CallerRole.Admin;
    },
    Response = ArmResourceUpdatedResponse<Database> | ArmResourceCreatedResponse<
      Database,
      ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
    > | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: Database;
    })
  >;

  /**
   * Updates a database.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    Database,
    PatchModel = Database,
    Parameters = {
      /**
       * By default, any user who run operation on a database become an Admin on it. This property allows the caller to exclude the caller from Admins list.
       */
      @query("callerRole")
      callerRole?: CallerRole = CallerRole.Admin;
    },
    Response = ArmResponse<Database> | ArmResourceCreatedResponse<Database> | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: Database;
    })
  >;

  /**
   * Deletes the database with the given name.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    Database,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Returns the list of databases of the given Kusto cluster.
   */
  listByCluster is ArmResourceListByParent<
    Database,
    Parameters = {
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
    ArmResponse<DatabasePrincipalListResult>
  >;

  /**
   * Add Database principals permissions.
   */
  addPrincipals is ArmResourceActionSync<
    Database,
    DatabasePrincipalListRequest,
    ArmResponse<DatabasePrincipalListResult>
  >;

  /**
   * Remove Database principals permissions.
   */
  removePrincipals is ArmResourceActionSync<
    Database,
    DatabasePrincipalListRequest,
    ArmResponse<DatabasePrincipalListResult>
  >;

  /**
   * Generates an invitation token that allows attaching a follower database to this database.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Database_InviteFollower")
  inviteFollower is ArmResourceActionSync<
    Database,
    DatabaseInviteFollowerRequest,
    ArmResponse<DatabaseInviteFollowerResult>
  >;

  /**
   * Checks that the database principal assignment is valid and is not already in use.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("checkPrincipalAssignmentNameAvailability")
  @operationId("DatabasePrincipalAssignments_CheckNameAvailability")
  checkNameAvailability is ArmResourceActionSync<
    Database,
    DatabasePrincipalAssignmentCheckNameRequest,
    ArmResponse<CheckNameResult>
  >;

  /**
   * Checks that the script name is valid and is not already in use.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Scripts_CheckNameAvailability")
  scriptsCheckNameAvailability is ArmResourceActionSync<
    Database,
    ScriptCheckNameRequest,
    ArmResponse<CheckNameResult>
  >;

  /**
   * Checks that the data connection parameters are valid.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DataConnections_dataConnectionValidation")
  dataConnectionValidation is ArmResourceActionAsync<
    Database,
    DataConnectionValidation,
    ArmResponse<DataConnectionValidationListResult>
  >;

  /**
   * Checks that the data connection name is valid and is not already in use.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("checkNameAvailability")
  @operationId("DataConnections_CheckNameAvailability")
  dataConnectionsCheckNameAvailability is ArmResourceActionSync<
    Database,
    DataConnectionCheckNameRequest,
    ArmResponse<CheckNameResult>
  >;
}

@@doc(Database.name, "The name of the database in the Kusto cluster.");
@@doc(Databases.createOrUpdate::parameters.resource,
  "The database parameters supplied to the CreateOrUpdate operation."
);
@@doc(Databases.update::parameters.properties,
  "The database parameters supplied to the Update operation."
);
@@doc(Databases.addPrincipals::parameters.body,
  "List of database principals to add."
);
@@doc(Databases.removePrincipals::parameters.body,
  "List of database principals to remove."
);
@@doc(Databases.inviteFollower::parameters.body,
  "The follower invitation request parameters."
);
@@doc(Databases.checkNameAvailability::parameters.body,
  "The name of the resource."
);
@@doc(Databases.scriptsCheckNameAvailability::parameters.body,
  "The name of the script."
);
@@doc(Databases.dataConnectionValidation::parameters.body,
  "The data connection parameters supplied to the CreateOrUpdate operation."
);
@@doc(Databases.dataConnectionsCheckNameAvailability::parameters.body,
  "The name of the data connection."
);
