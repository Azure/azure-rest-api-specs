import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace Azure.ResourceManager.AppConfiguration;

@doc("Checks whether the configuration store name is available for use.")
@route("/subscriptions/{subscriptionId}/providers/Microsoft.AppConfiguration/checkNameAvailability")
@post
op CheckAppConfigurationNameAvailability is Azure.Core.Foundations.Operation<
  {
    @doc("The Microsoft Azure subscription ID.")
    @path
    subscriptionId: string;

    @doc("The object containing information for the availability request.")
    @body
    checkNameAvailabilityParameters: CheckNameAvailabilityParameters;
  },
  NameAvailabilityStatus
>;

interface OperationsOperations {
  @doc("Checks whether the configuration store name is available for use.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.AppConfiguration/locations/{location}/checkNameAvailability")
  @post
  RegionalCheckNameAvailability is Azure.Core.Foundations.Operation<
    {
      @doc("The Microsoft Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("The location in which uniqueness will be verified.")
      @path
      location: string;

      @doc("The object containing information for the availability request.")
      @body
      checkNameAvailabilityParameters: CheckNameAvailabilityParameters;
    },
    NameAvailabilityStatus
  >;
}
