import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.DataFactory;

interface ExposureControlOperations {
  @doc("Get exposure control feature for specific location.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.DataFactory/locations/{locationId}/getFeatureValue")
  @post
  getFeatureValue is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The location identifier.")
      @path
      locationId: string;

      @doc("The exposure control request.")
      @body
      exposureControlRequest: ExposureControlRequest;
    },
    ExposureControlResponse
  >;
}
