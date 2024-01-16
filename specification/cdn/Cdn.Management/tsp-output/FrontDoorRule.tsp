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
@doc("Friendly Rules name mapping to the any Rules or secret related information.")
@parentResource(FrontDoorRuleSet)
model FrontDoorRule is ProxyResource<RuleProperties> {
  @doc("Name of the delivery rule which is unique within the endpoint.")
  @path
  @key("ruleName")
  @segment("rules")
  name: string;
}

@armResourceOperations
interface FrontDoorRules {
  @doc("Gets an existing delivery rule within a rule set.")
  get is ArmResourceRead<FrontDoorRule>;

  @doc("Creates a new delivery rule within the specified rule set.")
  create is ArmResourceCreateOrUpdateAsync<
    FrontDoorRule,
    BaseParameters<FrontDoorRule>,
    ArmAsyncOperationHeader
  >;

  @doc("Updates an existing delivery rule within a rule set.")
  update is ArmCustomPatchAsync<
    FrontDoorRule,
    RuleUpdateParameters,
    BaseParameters<FrontDoorRule>,
    ArmAsyncOperationHeader
  >;

  @doc("Deletes an existing delivery rule within a rule set.")
  delete is ArmResourceDeleteAsync<
    FrontDoorRule,
    BaseParameters<FrontDoorRule>,
    ArmAsyncOperationHeader
  >;

  @doc("Lists all of the existing delivery rules within a rule set.")
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
