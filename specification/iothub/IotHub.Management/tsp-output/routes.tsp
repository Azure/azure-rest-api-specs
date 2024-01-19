import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.Devices;

interface ResourceProviderCommonOperations {
  @summary("Get the number of iot hubs in the subscription")
  @doc("Get the number of free and paid iot hubs in the subscription")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Devices/usages")
  @get
  getSubscriptionQuota is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;
    },
    UserSubscriptionQuotaListResult
  >;
}
