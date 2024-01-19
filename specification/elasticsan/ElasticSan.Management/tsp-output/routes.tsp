import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.SignalRService;

interface UsagesOperations {
  @doc("List resource usage quotas by location.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.SignalRService/locations/{location}/usages")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      @doc("the location like \"eastus\"")
      @path
      location: string;

      @doc("Gets subscription Id which uniquely identify the Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;
    },
    SignalRUsageList
  >;
}
