import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Factory.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DataFactory;
@doc("Global parameters resource type.")
@parentResource(Factory)
model GlobalParameterResource is ProxyResource<Record<unknown>> {
  @doc("The global parameter name.")
  @maxLength(260)
  @minLength(1)
  @pattern("^[A-Za-z0-9_][^<>*#.%&:\\\\+?/]*$")
  @key("globalParameterName")
  @segment("globalParameters")
  name: string;
}

@armResourceOperations
interface GlobalParameters {
  @doc("Gets a Global parameter")
  get is ArmResourceRead<GlobalParameterResource>;
  @doc("Creates or updates a Global parameter")
  createOrUpdate is ArmResourceCreateOrReplaceSync<GlobalParameterResource>;
  @doc("Deletes a Global parameter")
  delete is ArmResourceDeleteSync<GlobalParameterResource>;
  @doc("Lists Global parameters")
  listByFactory is ArmResourceListByParent<GlobalParameterResource>;
}
