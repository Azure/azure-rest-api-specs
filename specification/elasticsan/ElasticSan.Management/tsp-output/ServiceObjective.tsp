import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Server.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
@doc("Represents a database service objective.")
@parentResource(Server)
model ServiceObjective is ProxyResource<ServiceObjectiveProperties> {
  @doc("The name of the service objective to retrieve.")
  @path
  @key("serviceObjectiveName")
  @segment("serviceObjectives")
  name: string;
}

@armResourceOperations
interface ServiceObjectives {
  @doc("Gets a database service objective.")
  get is ArmResourceRead<ServiceObjective>;

  @doc("Returns database service objectives.")
  listByServer is ArmResourceListByParent<ServiceObjective>;
}
