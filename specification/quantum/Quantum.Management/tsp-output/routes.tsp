import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Azure.ResourceManager.Quantum;

interface OfferingsOperations {
  @doc("Returns the list of all provider offerings available for the given location.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Quantum/locations/{locationName}/offerings")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("Location.")
      @path
      locationName: string;
    },
    OfferingsListResult
  >;
}

interface WorkspaceOperations {
  @doc("Check the availability of the resource name.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Quantum/locations/{locationName}/checkNameAvailability")
  @post
  CheckNameAvailability is Azure.Core.Foundations.Operation<
    {
      @doc("The Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("Location.")
      @path
      locationName: string;

      @doc("The name and type of the resource.")
      @body
      checkNameAvailabilityParameters: CheckNameAvailabilityParameters;
    },
    CheckNameAvailabilityResult
  >;
}
