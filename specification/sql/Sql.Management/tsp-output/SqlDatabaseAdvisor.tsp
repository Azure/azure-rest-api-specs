import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./SqlDatabase.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Sql;
@doc("Database, Server or Elastic Pool Advisor.")
@parentResource(SqlDatabase)
model SqlDatabaseAdvisor is ProxyResource<AdvisorProperties> {
  @doc("The name of the Database Advisor.")
  @path
  @key("advisorName")
  @segment("advisors")
  name: string;

  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface SqlDatabaseAdvisors {
  @doc("Gets a database advisor.")
  get is ArmResourceRead<SqlDatabaseAdvisor>;
  @doc("Updates a database advisor.")
  update is ArmResourcePatchSync<SqlDatabaseAdvisor, AdvisorProperties>;
  @doc("Gets a list of database advisors.")
  listByDatabase is ArmResourceListByParent<
    SqlDatabaseAdvisor,
    {
      ...BaseParameters<SqlDatabaseAdvisor>;

      @doc("The child resources to include in the response.")
      @query("$expand")
      $expand?: string;
    }
  >;
}
