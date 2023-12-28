import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Database.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Sql;
@doc("Database, Server or Elastic Pool Advisor.")
@parentResource(Database)
model Advisor is ProxyResource<AdvisorProperties> {
  @doc("The name of the Database Advisor.")
  @key("advisorName")
  @segment("advisors")
  name: string;

  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface DatabaseAdvisors {
  @doc("Gets a database advisor.")
  get is ArmResourceRead<Advisor>;
  @doc("Updates a database advisor.")
  update is ArmCustomPatchSync<Advisor, Advisor>;
  @doc("Gets a list of database advisors.")
  listByDatabase is ArmResourceListByParent<
    Advisor,
    {
      ...BaseParameters<Advisor>;

      @doc("The child resources to include in the response.")
      @query("$expand")
      $expand?: string;
    }
  >;
}
