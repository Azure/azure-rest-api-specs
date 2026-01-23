import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Profile.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Cdn;
/**
 * Friendly RuleSet name mapping to the any RuleSet or secret related information.
 */
@parentResource(Profile)
model RuleSet is Azure.ResourceManager.ProxyResource<RuleSetProperties> {
  ...ResourceNameParameter<
    Resource = RuleSet,
    KeyName = "ruleSetName",
    SegmentName = "ruleSets",
    NamePattern = ""
  >;
}

@armResourceOperations
interface RuleSets {
  /**
   * Gets an existing AzureFrontDoor rule set with the specified rule set name under the specified subscription, resource group and profile.
   */
  get is ArmResourceRead<RuleSet>;

  // FIXME: (ArmResourceCreateOrReplace): ArmResourceCreateOrReplaceAsync/ArmResourceCreateOrReplaceSync should have a body parameter.
  /**
   * Creates a new rule set within the specified profile.
   */
  // create is ArmResourceCreateOrReplaceSync<RuleSet>;
  @put
  create is Azure.ResourceManager.Legacy.CustomPatchAsync<
    RuleSet,
    PatchModel = void,
    Response = ArmResponse<RuleSet> | ArmCreatedResponse<RuleSet>
  >;

  /**
   * Deletes an existing AzureFrontDoor rule set with the specified rule set name under the specified subscription, resource group and profile.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  delete is ArmResourceDeleteWithoutOkAsync<
    RuleSet,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<ArmAsyncOperationHeader &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse
  >;

  /**
   * Lists existing AzureFrontDoor rule sets within a profile.
   */
  @list
  listByProfile is ArmResourceListByParent<RuleSet>;

  /**
   * Checks the quota and actual usage of endpoints under the given Azure Front Door profile.
   */
  @action("usages")
  @list
  listResourceUsage is ArmResourceActionSync<
    RuleSet,
    void,
    ArmResponse<UsagesListResult>
  >;
}

@@doc(RuleSet.name,
  "Name of the rule set under the profile which is unique globally."
);
@@doc(RuleSet.properties,
  "The JSON object that contains the properties of the Rule Set to create."
);
