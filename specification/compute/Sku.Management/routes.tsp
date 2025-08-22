// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

namespace Microsoft.Compute;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface ResourceSkus {
  /**
   * Gets the list of Microsoft.Compute SKUs available for your Subscription.
   */
  @get
  @action("skus")
  @autoRoute
  list is ArmProviderActionSync<
    Response = ResourceSkusResult,
    Scope = SubscriptionActionScope,
    Parameters = {
      /**
       * The filter to apply on the operation. Only **location** filter is supported currently.
       */
      @query("$filter")
      $filter?: string;

      ...IncludeExtendedLocationsParameter;
    }
  >;
}

/** Query Parameter to indicating whether to include extended locations */
model IncludeExtendedLocationsParameter {
  /**
   * To Include Extended Locations information or not in the response.
   */
  @query("includeExtendedLocations")
  includeExtendedLocations?: string;
}
