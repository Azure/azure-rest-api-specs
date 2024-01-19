import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Profile.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Cdn;
@doc("Friendly RuleSet name mapping to the any RuleSet or secret related information.")
@parentResource(Profile)
model FrontDoorRuleSet is ProxyResource<RuleSetProperties> {
  @doc("Name of the rule set under the profile which is unique globally.")
  @path
  @key("ruleSetName")
  @segment("ruleSets")
  name: string;
}

@armResourceOperations
interface FrontDoorRuleSets {
  @doc("Gets an existing AzureFrontDoor rule set with the specified rule set name under the specified subscription, resource group and profile.")
  get is ArmResourceRead<FrontDoorRuleSet>;

  @doc("Creates a new rule set within the specified profile.")
  create is ArmResourceCreateOrReplaceSync<FrontDoorRuleSet>;

  @doc("Deletes an existing AzureFrontDoor rule set with the specified rule set name under the specified subscription, resource group and profile.")
  delete is ArmResourceDeleteAsync<
    FrontDoorRuleSet,
    BaseParameters<FrontDoorRuleSet>,
    ArmAsyncOperationHeader
  >;

  @doc("Lists existing AzureFrontDoor rule sets within a profile.")
  listByProfile is ArmResourceListByParent<FrontDoorRuleSet>;

  @doc("Checks the quota and actual usage of the given AzureFrontDoor rule set under the given CDN profile.")
  listResourceUsage is ArmResourceActionSync<
    FrontDoorRuleSet,
    void,
    UsagesListResult
  >;
}
