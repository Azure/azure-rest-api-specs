import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Security;
@doc("The resource whose properties describes the Adaptive Network Hardening settings for some Azure resource")
model AdaptiveNetworkHardening
  is ProxyResource<AdaptiveNetworkHardeningProperties> {
  @doc("The name of the Adaptive Network Hardening resource.")
  @path
  @key("adaptiveNetworkHardeningResourceName")
  @segment("adaptiveNetworkHardenings")
  name: string;
}

@armResourceOperations
interface AdaptiveNetworkHardenings {
  @doc("Gets a single Adaptive Network Hardening resource")
  get is ArmResourceRead<AdaptiveNetworkHardening>;

  @doc("Gets a list of Adaptive Network Hardenings resources in scope of an extended resource.")
  listByExtendedResource is ArmResourceListByParent<AdaptiveNetworkHardening>;

  @doc("Enforces the given rules on the NSG(s) listed in the request")
  enforce is ArmResourceActionAsync<
    AdaptiveNetworkHardening,
    AdaptiveNetworkHardeningEnforceRequest,
    void,
    {
      ...BaseParameters<AdaptiveNetworkHardening>;

      @doc("Enforces the given rules on the NSG(s) listed in the request")
      @path
      adaptiveNetworkHardeningEnforceAction: "enforce";
    }
  >;
}

@@doc(AdaptiveNetworkHardenings.enforce::parameters.body, "");
