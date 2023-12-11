import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./WebSite.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.AppService;
@doc("Function information.")
@parentResource(WebSite)
model SiteFunction is ProxyResource<FunctionEnvelopeProperties> {
  @doc("Function name.")
  @path
  @key("functionName")
  @segment("functions")
  name: string;
}

@armResourceOperations
interface SiteFunctions {
  @doc("Description for Get function information by its ID for web site, or a deployment slot.")
  getFunction is ArmResourceRead<SiteFunction>;
  @doc("Description for Create function for web site, or a deployment slot.")
  createFunction is ArmResourceCreateOrUpdateAsync<SiteFunction>;
  @doc("Description for Delete a function for web site, or a deployment slot.")
  deleteFunction is ArmResourceDeleteSync<SiteFunction>;
  @doc("Description for List the functions for a web site, or a deployment slot.")
  listFunctions is ArmResourceListByParent<SiteFunction>;
  @doc("Description for Get function keys for a function in a web site, or a deployment slot.")
  listFunctionKeys is ArmResourceActionSync<SiteFunction, {}, StringDictionary>;
  @doc("Description for Get function secrets for a function in a web site, or a deployment slot.")
  listFunctionSecrets is ArmResourceActionSync<
    SiteFunction,
    {},
    FunctionSecrets
  >;
}
