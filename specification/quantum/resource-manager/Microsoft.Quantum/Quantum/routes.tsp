// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Versioning;

namespace Microsoft.Quantum;

/** Name of an Azure location. */
@minLength(1)
@maxLength(90)
@pattern("[a-z][a-z0-9]+")
scalar AzureLocationParameter extends azureLocation;

@armResourceOperations
interface Offerings {
  /**
   * Returns the list of all provider offerings available for the given location.
   */
  @autoRoute
  @get
  @list
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
      @typeChangedFrom(Versions.v2025_01_01_preview, string)
      locationName: AzureLocationParameter;

      /**
       * The filter to apply to the operation. Example: '$filter=kind eq 'v1'
       */
      @added(Versions.v2025_11_01_preview)
      @query("filter")
      filter?: string;
    }
  >;
}
