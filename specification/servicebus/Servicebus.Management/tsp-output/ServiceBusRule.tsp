import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ServiceBusSubscription.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.ServiceBus;
@doc("Description of Rule Resource.")
@parentResource(ServiceBusSubscription)
model ServiceBusRule is ProxyResource<Ruleproperties> {
  @doc("The rule name.")
  @maxLength(50)
  @minLength(1)
  @key("ruleName")
  @segment("rules")
  name: string;
}

@armResourceOperations
interface Rules {
  // @doc("Retrieves the description for the specified rule.")
  // get is ArmResourceRead<ServiceBusRule>;
  // @doc("Creates a new rule and updates an existing rule")
  // createOrUpdate is ArmResourceCreateOrReplaceSync<ServiceBusRule>;
  // @doc("Deletes an existing rule.")
  // delete is ArmResourceDeleteSync<ServiceBusRule>;
  @doc("List all the rules within given topic-subscription")
  listBySubscriptions is ArmResourceListByParent<
    ServiceBusRule,
    {
      ...BaseParameters<ServiceBusRule>;

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