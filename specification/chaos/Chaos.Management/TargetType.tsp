import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.Chaos;
@doc("Model that represents a Target Type resource.")
@locationResource
model TargetType is ProxyResource<TargetTypeProperties> {
  @doc("String that represents a Target Type resource name.")
  @pattern("^[a-zA-Z0-9_\\-\\.]+$")
  @path
  @key("targetTypeName")
  @segment("targetTypes")
  name: string;
}

@armResourceOperations
interface TargetTypes {
  @doc("Get a Target Type resources for given location.")
  get is ArmResourceRead<TargetType>;
  @doc("Get a list of Target Type resources for given location.")
  list is ArmResourceListByParent<
    TargetType,
    {
      ...BaseParameters<TargetType>;

      @doc("String that sets the continuation token.")
      @query("continuationToken")
      continuationToken?: string;
    }
  >;
}
