import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./FrontDoorRuleSet.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Cdn;
/**
 * Friendly Rules name mapping to the any Rules or secret related information.
 */
@parentResource(FrontDoorRuleSet)
model FrontDoorRule is ProxyResource<RuleProperties> {
  /**
   * Name of the delivery rule which is unique within the endpoint.
   */
  @path
  @key("ruleName")
  @segment("rules")
  name: string;
}

@armResourceOperations
interface FrontDoorRules {
  /**
   * Gets an existing delivery rule within a rule set.
   */
  get is ArmResourceRead<FrontDoorRule>;

  /**
   * Creates a new delivery rule within the specified rule set.
   */
  create is ArmResourceCreateOrReplaceAsync<
    FrontDoorRule,
    BaseParameters<FrontDoorRule>,
    ArmAsyncOperationHeader
  >;

  /**
   * Updates an existing delivery rule within a rule set.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<
    FrontDoorRule,
    RuleUpdateParameters,
    BaseParameters<FrontDoorRule>,
    ArmAsyncOperationHeader
  >;

  /**
   * Deletes an existing delivery rule within a rule set.
   */
  delete is ArmResourceDeleteAsync<
    FrontDoorRule,
    BaseParameters<FrontDoorRule>,
    ArmAsyncOperationHeader
  >;

  /**
   * Lists all of the existing delivery rules within a rule set.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("FrontDoorRules_ListByRuleSet")
  listByRuleSet is ArmResourceListByParent<FrontDoorRule>;
}

@@projectedName(FrontDoorRules.create::parameters.resource, "json", "rule");
@@extension(FrontDoorRules.create::parameters.resource,
  "x-ms-client-name",
  "rule"
);
@@doc(FrontDoorRules.create::parameters.resource,
  "The delivery rule properties."
);
@@projectedName(FrontDoorRules.update::parameters.properties,
  "json",
  "ruleUpdateProperties"
);
@@extension(FrontDoorRules.update::parameters.properties,
  "x-ms-client-name",
  "ruleUpdateProperties"
);
@@doc(FrontDoorRules.update::parameters.properties, "Delivery rule properties");
