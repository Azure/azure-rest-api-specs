import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./FrontDoorRuleSet.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Cdn;
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
  create is ArmResourceCreateOrUpdateAsync<FrontDoorRule>;
  @doc("Updates an existing delivery rule within a rule set.")
  update is ArmResourcePatchAsync<FrontDoorRule, RuleProperties>;
  @doc("Deletes an existing delivery rule within a rule set.")
  delete is ArmResourceDeleteAsync<FrontDoorRule>;
  @doc("Lists all of the existing delivery rules within a rule set.")
  listByRuleSet is ArmResourceListByParent<FrontDoorRule>;
}
