// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.OpenAPI;

namespace Microsoft.Quantum;

@armResourceOperations
interface Offerings {
  /**
   * Returns the list of all provider offerings available for the given location.
   */
  @autoRoute
  @get
  @action("offerings")
  list is ArmProviderActionSync<
    Response = OfferingsListResult,
    Scope = SubscriptionActionScope,
    Parameters = {
      /**
       * Location.
       */
      @path
      @segment("locations")
      locationName: string;
    }
  >;
}
