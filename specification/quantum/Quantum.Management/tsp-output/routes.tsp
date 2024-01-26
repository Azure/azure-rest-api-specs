import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.Quantum;

interface OfferingsOperations {
  /**
   * Returns the list of all provider offerings available for the given location.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Quantum/locations/{locationName}/offerings")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      /**
       * The Azure subscription ID.
       */
      @path
      subscriptionId: string;

      /**
       * Location.
       */
      @path
      locationName: string;
    },
    OfferingsListResult
  >;
}

interface WorkspaceOperations {
  /**
   * Check the availability of the resource name.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Quantum/locations/{locationName}/checkNameAvailability")
  @post
  checkNameAvailability is Azure.Core.Foundations.Operation<
    {
      /**
       * The Azure subscription ID.
       */
      @path
      subscriptionId: string;

      /**
       * Location.
       */
      @path
      locationName: string;

      /**
       * The name and type of the resource.
       */
      @body
      checkNameAvailabilityParameters: CheckNameAvailabilityParameters;
    },
    CheckNameAvailabilityResult
  >;
}
