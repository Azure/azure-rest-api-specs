import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./TargetType.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Chaos;
@doc("Model that represents a Capability Type resource.")
@parentResource(TargetType)
model CapabilityType is ProxyResource<CapabilityTypeProperties> {
  @doc("String that represents a Capability Type resource name.")
  @pattern("^[a-zA-Z0-9\\-\\.]+-\\d\\.\\d$")
  @path
  @key("capabilityTypeName")
  @segment("capabilityTypes")
  name: string;
}

@armResourceOperations
interface CapabilityTypes {
  @doc("Get a Capability Type resource for given Target Type and location.")
  get is ArmResourceRead<CapabilityType>;

  @doc("Get a list of Capability Type resources for given Target Type and location.")
  list is ArmResourceListByParent<
    CapabilityType,
    {
      ...BaseParameters<CapabilityType>;

      @doc("String that sets the continuation token.")
      @query("continuationToken")
      continuationToken?: string;
    }
  >;
}
