import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./DataFactory.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DataFactory;
@doc("Global parameters resource type.")
@parentResource(DataFactory)
model DataFactoryGlobalParameter is ProxyResource<Record<unknown>> {
  @doc("The global parameter name.")
  @maxLength(260)
  @minLength(1)
  @pattern("^[A-Za-z0-9_][^<>*#.%&:\\\\+?/]*$")
  @path
  @key("globalParameterName")
  @segment("globalParameters")
  name: string;
}

@armResourceOperations
interface DataFactoryGlobalParameters {
  @doc("Gets a Global parameter")
  get is ArmResourceRead<DataFactoryGlobalParameter>;
  @doc("Creates or updates a Global parameter")
  createOrUpdate is ArmResourceCreateOrReplaceSync<DataFactoryGlobalParameter>;
  @doc("Deletes a Global parameter")
  delete is ArmResourceDeleteSync<DataFactoryGlobalParameter>;
  @doc("Lists Global parameters")
  listByFactory is ArmResourceListByParent<DataFactoryGlobalParameter>;
}
