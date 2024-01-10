import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Cluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.Kusto;
// FIXME: Database has no properties property
@doc("Class representing a Kusto database.")
@parentResource(Cluster)
model Database is ProxyResource<{}> {
  @doc("The name of the database in the Kusto cluster.")
  @pattern("^.*$")
  @key("databaseName")
  @segment("databases")
  name: string;

  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface Databases {
  @doc("Returns a database.")
  get is ArmResourceRead<Database>;

  @doc("Creates or updates a database.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    Database,
    {
      ...BaseParameters<Database>;

      @doc("By default, any user who run operation on a database become an Admin on it. This property allows the caller to exclude the caller from Admins list.")
      @query("callerRole")
      callerRole?: CallerRole = CallerRole.Admin;
    }
  >;

  @doc("Updates a database.")
  update is ArmCustomPatchAsync<
    Database,
    Database,
    {
      ...BaseParameters<Database>;

      @doc("By default, any user who run operation on a database become an Admin on it. This property allows the caller to exclude the caller from Admins list.")
      @query("callerRole")
      callerRole?: CallerRole = CallerRole.Admin;
    }
  >;

  @doc("Deletes the database with the given name.")
  delete is ArmResourceDeleteAsync<Database>;

  @doc("Returns the list of databases of the given Kusto cluster.")
  listByCluster is ArmResourceListByParent<
    Database,
    {
      ...BaseParameters<Database>;

      @doc("limit the number of results")
      @maxValue(1000)
      @minValue(5)
      @query("$top")
      $top?: int32;

      @doc("Skiptoken is only used if a previous operation returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skiptoken parameter that specifies a starting point to use for subsequent calls.")
      @query("$skiptoken")
      $skiptoken?: string;
    }
  >;

  @doc("Returns a list of database principals of the given Kusto cluster and database.")
  listPrincipals is ArmResourceActionSync<
    Database,
    void,
    DatabasePrincipalListResult
  >;

  @doc("Add Database principals permissions.")
  addPrincipals is ArmResourceActionSync<
    Database,
    DatabasePrincipalListRequest,
    DatabasePrincipalListResult
  >;

  @doc("Remove Database principals permissions.")
  removePrincipals is ArmResourceActionSync<
    Database,
    DatabasePrincipalListRequest,
    DatabasePrincipalListResult
  >;
}

@armResourceOperations
@projectedName("client", "Database")
interface Databases_Database {
  @doc("Generates an invitation token that allows attaching a follower database to this database.")
  inviteFollower is ArmResourceActionSync<
    Database,
    DatabaseInviteFollowerRequest,
    DatabaseInviteFollowerResult
  >;
}

@armResourceOperations
@projectedName("client", "DatabasePrincipalAssignments")
interface Databases_DatabasePrincipalAssignments {
  @doc("Checks that the database principal assignment is valid and is not already in use.")
  checkNameAvailability is ArmResourceActionSync<
    Database,
    DatabasePrincipalAssignmentCheckNameRequest,
    CheckNameResult
  >;
}

@armResourceOperations
@projectedName("client", "Scripts")
interface Databases_Scripts {
  @doc("Checks that the script name is valid and is not already in use.")
  checkNameAvailability is ArmResourceActionSync<
    Database,
    ScriptCheckNameRequest,
    CheckNameResult
  >;
}

@armResourceOperations
@projectedName("client", "DataConnections")
interface Databases_DataConnections {
  @doc("Checks that the data connection parameters are valid.")
  dataConnectionValidation is ArmResourceActionAsync<
    Database,
    DataConnectionValidation,
    DataConnectionValidationListResult
  >;

  @doc("Checks that the data connection name is valid and is not already in use.")
  checkNameAvailability is ArmResourceActionSync<
    Database,
    DataConnectionCheckNameRequest,
    CheckNameResult
  >;
}
