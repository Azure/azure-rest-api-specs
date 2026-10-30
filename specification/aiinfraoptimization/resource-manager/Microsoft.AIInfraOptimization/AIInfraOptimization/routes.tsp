import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;

namespace Microsoft.AIInfraOptimization;

/** Virtual machine SKU recommendation actions. */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "These are provider-level actions that are not tied to a specific ARM resource."
@tag("Recommendations")
interface Recommendations {
  /** Recommends Azure virtual machine sizes for an AI workload in the specified subscription and azure location. */
  @autoRoute
  @action("recommendVmSku")
  recommendVmSku is ArmProviderActionSync<
    Request = RecommendVmSkuRequest,
    Response = RecommendVmSkuResponse,
    Scope = SubscriptionActionScope,
    Parameters = LocationResourceParameter
  >;
}
