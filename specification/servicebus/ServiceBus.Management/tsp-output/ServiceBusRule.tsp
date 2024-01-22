import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ServiceBusSubscription.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ServiceBus;
/**
 * Description of Rule Resource.
 */
@parentResource(ServiceBusSubscription)
model ServiceBusRule is ProxyResource<Ruleproperties> {
  /**
   * The rule name.
   */
  @maxLength(50)
  @minLength(1)
  @path
  @key("ruleName")
  @segment("rules")
  name: string;
}

@armResourceOperations
interface ServiceBusRules {
  /**
   * Retrieves the description for the specified rule.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Rules_Get")
  get is ArmResourceRead<ServiceBusRule>;

  /**
   * Creates a new rule and updates an existing rule
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Rules_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<ServiceBusRule>;

  /**
   * Deletes an existing rule.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Rules_Delete")
  delete is ArmResourceDeleteSync<ServiceBusRule>;

  /**
   * List all the rules within given topic-subscription
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Rules_ListBySubscriptions")
  listBySubscriptions is ArmResourceListByParent<
    ServiceBusRule,
    {
      ...BaseParameters<ServiceBusRule>;

      /**
       * Skip is only used if a previous operation returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skip parameter that specifies a starting point to use for subsequent calls.
       */
      @maxValue(1000)
      @query("$skip")
      $skip?: int32;

      /**
       * May be used to limit the number of results to the most recent N usageDetails.
       */
      @maxValue(1000)
      @minValue(1)
      @query("$top")
      $top?: int32;
    }
  >;
}

@@projectedName(ServiceBusRules.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(ServiceBusRules.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(ServiceBusRules.createOrUpdate::parameters.resource,
  "Parameters supplied to create a rule."
);
