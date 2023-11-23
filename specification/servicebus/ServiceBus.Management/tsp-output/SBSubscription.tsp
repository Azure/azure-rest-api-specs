import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./SBTopic.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.ServiceBus;
@doc("Description of subscription resource.")
@parentResource(SBTopic)
model SBSubscription is ProxyResource<SBSubscriptionProperties> {
  @doc("Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
  @path
  @key("subscriptionId")
  @segment("subscriptions")
  name: string;
}

@armResourceOperations
interface SBSubscriptions {
  @doc("Returns a subscription description for the specified topic.")
  get is ArmResourceRead<SBSubscription>;
  @doc("Creates a topic subscription.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<SBSubscription>;
  @doc("Deletes a subscription from the specified topic.")
  delete is ArmResourceDeleteSync<SBSubscription>;
  @doc("List all the subscriptions under a specified topic.")
  listByTopic is ArmResourceListByParent<
    SBSubscription,
    {
      ...BaseParameters<SBSubscription>;

      @doc("Skip is only used if a previous operation returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skip parameter that specifies a starting point to use for subsequent calls.")
      @query("$skip")
      $skip?: int32;

      @doc("May be used to limit the number of results to the most recent N usageDetails.")
      @query("$top")
      $top?: int32;
    }
  >;
}
