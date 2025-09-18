import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./RuleSet.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Cdn;
/**
 * Friendly Rules name mapping to the any Rules or secret related information.
 */
@parentResource(RuleSet)
model Rule is Azure.ResourceManager.ProxyResource<RuleProperties> {
  ...ResourceNameParameter<
    Resource = Rule,
    KeyName = "ruleName",
    SegmentName = "rules",
    NamePattern = ""
  >;
}

@armResourceOperations
interface Rules {
  /**
   * Gets an existing delivery rule within a rule set.
   */
  get is ArmResourceRead<Rule>;

  /**
   * Creates a new delivery rule within the specified rule set.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  create is ArmResourceCreateOrReplaceAsync<
    Rule,
    Response = ArmResourceUpdatedResponse<Rule> | ArmResourceCreatedResponse<Rule> | (ArmAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader<FinalResult = Rule> &
      ArmLroLocationHeader<FinalResult = Rule>> & {
      @bodyRoot
      _: Rule;
    })
  >;

  /**
   * Updates an existing delivery rule within a rule set.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    Rule,
    PatchModel = RuleUpdateParameters,
    Response = ArmResponse<Rule> | (ArmAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader<FinalResult = Rule> &
      ArmLroLocationHeader<FinalResult = Rule>> & {
      @bodyRoot
      _: Rule;
    })
  >;

  /**
   * Deletes an existing delivery rule within a rule set.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  delete is ArmResourceDeleteWithoutOkAsync<
    Rule,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse
  >;

  /**
   * Lists all of the existing delivery rules within a rule set.
   */
  @list
  listByRuleSet is ArmResourceListByParent<Rule>;
}

@@doc(Rule.name,
  "Name of the delivery rule which is unique within the endpoint."
);
@@doc(Rule.properties,
  "The JSON object that contains the properties of the Rules to create."
);
@@doc(Rules.create::parameters.resource, "The delivery rule properties.");
@@doc(Rules.update::parameters.properties, "Delivery rule properties");
