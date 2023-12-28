import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Site.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.AppService;
@doc("Function information.")
@parentResource(Site)
model FunctionEnvelope is ProxyResource<FunctionEnvelopeProperties> {
  @doc("Function name.")
  @key("functionName")
  @segment("functions")
  name: string;
}

@armResourceOperations
interface WebApps {
  @doc("Description for Get function information by its ID for web site, or a deployment slot.")
  getFunction is ArmResourceRead<FunctionEnvelope>;
  @doc("Description for Create function for web site, or a deployment slot.")
  createFunction is ArmResourceCreateOrUpdateAsync<FunctionEnvelope>;
  @doc("Description for Delete a function for web site, or a deployment slot.")
  deleteFunction is ArmResourceDeleteSync<FunctionEnvelope>;
  @doc("Description for List the functions for a web site, or a deployment slot.")
  listFunctions is ArmResourceListByParent<FunctionEnvelope>;
  @doc("Description for Get function keys for a function in a web site, or a deployment slot.")
  listFunctionKeys is ArmResourceActionSync<
    FunctionEnvelope,
    void,
    StringDictionary
  >;
  @doc("Description for Get function secrets for a function in a web site, or a deployment slot.")
  listFunctionSecrets is ArmResourceActionSync<
    FunctionEnvelope,
    void,
    FunctionSecrets
  >;
}
