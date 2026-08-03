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
/**
 * Friendly RuleSet name mapping to the any RuleSet or secret related information.
 */
@parentResource(Profile)
model FrontDoorRuleSet is ProxyResource<RuleSetProperties> {
  /**
   * Name of the rule set under the profile which is unique globally.
   */
  @path
  @key("ruleSetName")
  @segment("ruleSets")
  name: string;
}

@armResourceOperations
interface FrontDoorRuleSets {
  /**
   * Gets an existing AzureFrontDoor rule set with the specified rule set name under the specified subscription, resource group and profile.
   */
  get is ArmResourceRead<FrontDoorRuleSet>;

  /**
   * Creates a new rule set within the specified profile.
   */
  create is ArmResourceCreateOrReplaceSync<FrontDoorRuleSet>;

  /**
   * Deletes an existing AzureFrontDoor rule set with the specified rule set name under the specified subscription, resource group and profile.
   */
  delete is ArmResourceDeleteAsync<
    FrontDoorRuleSet,
    BaseParameters<FrontDoorRuleSet>,
    ArmAsyncOperationHeader
  >;

  /**
   * Lists existing AzureFrontDoor rule sets within a profile.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("FrontDoorRuleSets_ListByProfile")
  listByProfile is ArmResourceListByParent<FrontDoorRuleSet>;

  /**
   * Checks the quota and actual usage of the given AzureFrontDoor rule set under the given CDN profile.
   */
  listResourceUsage is ArmResourceActionSync<
    FrontDoorRuleSet,
    void,
    UsagesListResult
  >;
}
