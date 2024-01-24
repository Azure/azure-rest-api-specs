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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Profile)
@Azure.ResourceManager.Private.armResourceInternal(RuleSetProperties)
@includeInapplicableMetadataInPayload(false)
model FrontDoorRuleSet extends ProxyResource {
  /**
   * Name of the rule set under the profile which is unique globally.
   */
  @path
  @key("ruleSetName")
  @segment("ruleSets")
  name: string;

  /**
   * The JSON object that contains the properties of the Rule Set to create.
   */
  @extension("x-ms-client-flatten", true)
  properties?: RuleSetProperties;
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
