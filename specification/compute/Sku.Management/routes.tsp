// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.Compute;

interface ResourceSkusOperations {
  /**
   * Gets the list of Microsoft.Compute SKUs available for your Subscription.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Compute/skus")
  @get
  list(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,

    /**
     * The filter to apply on the operation. Only **location** filter is supported currently.
     */
    @query("$filter")
    $filter?: string,

    /**
     * To Include Extended Locations information or not in the response.
     */
    @query("includeExtendedLocations")
    includeExtendedLocations?: string,
  ): ArmResponse<ResourceSkusResult> | ErrorResponse;
}
