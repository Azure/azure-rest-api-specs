import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.DataLakeStore;

interface LocationsOperations {
  /**
   * Gets subscription-level properties and limits for Data Lake Store specified by resource location.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.DataLakeStore/locations/{location}/capability")
  @get
  getCapability is Azure.Core.Foundations.Operation<
    {
      /**
       * Gets subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;

      /**
       * The resource location without whitespace.
       */
      @path
      location: string;
    },
    CapabilityInformation | void
  >;

  /**
   * Gets the current usage count and the limit for the resources of the location under the subscription.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.DataLakeStore/locations/{location}/usages")
  @get
  getUsage is Azure.Core.Foundations.Operation<
    {
      /**
       * Gets subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;

      /**
       * The resource location without whitespace.
       */
      @path
      location: string;
    },
    UsageListResult
  >;
}
