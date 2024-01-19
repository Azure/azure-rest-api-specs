import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.DataLakeAnalytics;

interface LocationsOperations {
  @doc("Gets subscription-level properties and limits for Data Lake Analytics specified by resource location.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.DataLakeAnalytics/locations/{location}/capability")
  @get
  getCapability is Azure.Core.Foundations.Operation<
    {
      @doc("Get subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;

      @doc("The resource location without whitespace.")
      @path
      location: string;
    },
    CapabilityInformation | void
  >;
}
