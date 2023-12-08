import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./KustoCluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Kusto;
// FIXME: KustoDatabase has no properties property
@doc("Class representing a Kusto database.")
@parentResource(KustoCluster)
model KustoDatabase is ProxyResource<{}> {
  @doc("The name of the database in the Kusto cluster.")
  @pattern("^.*$")
  @path
  @key("databaseName")
  @segment("databases")
  name: string;

  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface KustoDatabases {
  @doc("Returns a database.")
  get is ArmResourceRead<KustoDatabase>;
  @doc("Creates or updates a database.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    KustoDatabase,
    {
      ...BaseParameters<KustoDatabase>;

      @doc("By default, any user who run operation on a database become an Admin on it. This property allows the caller to exclude the caller from Admins list.")
      @query("callerRole")
      callerRole?: CallerRole;
    }
  >;
  // FIXME: (ArmResourcePatch): ArmResourcePatchSync/ArmResourcePatchAsync should have a body parameter with either properties property or tag property
  @doc("Updates a database.")
  update is ArmCustomPatchAsync<
    KustoDatabase,
    KustoDatabase,
    {
      ...BaseParameters<KustoDatabase>;

      @doc("By default, any user who run operation on a database become an Admin on it. This property allows the caller to exclude the caller from Admins list.")
      @query("callerRole")
      callerRole?: CallerRole;
    }
  >;
  @doc("Deletes the database with the given name.")
  delete is ArmResourceDeleteAsync<KustoDatabase>;
  @doc("Returns the list of databases of the given Kusto cluster.")
  listByCluster is ArmResourceListByParent<
    KustoDatabase,
    {
      ...BaseParameters<KustoDatabase>;

      @doc("limit the number of results")
      @query("$top")
      $top?: int32;

      @doc("Skiptoken is only used if a previous operation returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skiptoken parameter that specifies a starting point to use for subsequent calls.")
      @query("$skiptoken")
      $skiptoken?: string;
    }
  >;
  @doc("Returns a list of database principals of the given Kusto cluster and database.")
  listPrincipals is ArmResourceActionSync<
    KustoDatabase,
    {},
    DatabasePrincipalListResult
  >;
  @doc("Add Database principals permissions.")
  addPrincipals is ArmResourceActionSync<
    KustoDatabase,
    DatabasePrincipalListRequest,
    DatabasePrincipalListResult
  >;
  @doc("Remove Database principals permissions.")
  removePrincipals is ArmResourceActionSync<
    KustoDatabase,
    DatabasePrincipalListRequest,
    DatabasePrincipalListResult
  >;
  @doc("Generates an invitation token that allows attaching a follower database to this database.")
  inviteFollower is ArmResourceActionSync<
    KustoDatabase,
    DatabaseInviteFollowerRequest,
    DatabaseInviteFollowerResult
  >;
  @doc("Checks that the database principal assignment is valid and is not already in use.")
  checkNameAvailability is ArmResourceActionSync<
    KustoDatabase,
    DatabasePrincipalAssignmentCheckNameRequest,
    CheckNameResult
  >;
  @doc("Checks that the script name is valid and is not already in use.")
  checkNameAvailability is ArmResourceActionSync<
    KustoDatabase,
    ScriptCheckNameRequest,
    CheckNameResult
  >;
  @doc("Checks that the data connection parameters are valid.")
  dataConnectionValidation is ArmResourceActionAsync<
    KustoDatabase,
    DataConnectionValidation,
    DataConnectionValidationListResult
  >;
  @doc("Checks that the data connection name is valid and is not already in use.")
  checkNameAvailability is ArmResourceActionSync<
    KustoDatabase,
    DataConnectionCheckNameRequest,
    CheckNameResult
  >;
}
