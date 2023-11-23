import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace Microsoft.SignalRService;

interface UsagesOperations {
  @doc("List resource usage quotas by location.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.SignalRService/locations/{location}/usages")
  @get
  List is Azure.Core.Foundations.Operation<
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
