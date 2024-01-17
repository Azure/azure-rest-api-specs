import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.ElasticSan;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "No resource operation"
interface Skus {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "No resource operation"
  @summary("List all the available Skus in the region and information related to them")
  @doc("List all the available Skus in the region and information related to them")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ElasticSan/skus")
  @get
  list(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,

    #suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
    @doc("Specify $filter='location eq <location>' to filter on location.")
    @query("$filter")
    $filter?: string,
  ): ArmResponse<SkuInformationList> | ErrorResponse;
}
