import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ServiceBusNamespace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.ServiceBus;
@doc("Description of topic resource.")
@parentResource(ServiceBusNamespace)
model ServiceBusTopic is ProxyResource<SBTopicProperties> {
  @doc("The topic name.")
  @minLength(1)
  @key("topicName")
  @segment("topics")
  name: string;
}

@armResourceOperations
interface Topics {
  // @doc("Returns a description for the specified topic.")
  // get is ArmResourceRead<ServiceBusTopic>;
  // @doc("Creates a topic in the specified namespace.")
  // createOrUpdate is ArmResourceCreateOrReplaceSync<ServiceBusTopic>;
  // @doc("Deletes a topic from the specified namespace and resource group.")
  // delete is ArmResourceDeleteSync<ServiceBusTopic>;
  @doc("Gets all the topics in a namespace.")
  listByNamespace is ArmResourceListByParent<
    ServiceBusTopic,
    {
      ...BaseParameters<ServiceBusTopic>;

      @doc("Skip is only used if a previous operation returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skip parameter that specifies a starting point to use for subsequent calls.")
      @maxValue(1000)
      @query("$skip")
      $skip?: int32;

      @doc("May be used to limit the number of results to the most recent N usageDetails.")
      @maxValue(1000)
      @minValue(1)
      @query("$top")
      $top?: int32;
    }
  >;
}