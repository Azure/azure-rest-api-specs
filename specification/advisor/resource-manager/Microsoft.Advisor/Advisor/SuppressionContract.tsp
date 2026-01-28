import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ResourceRecommendationBase.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;

namespace Microsoft.Advisor;
/**
 * The details of the snoozed or dismissed rule; for example, the duration, name, and GUID associated with the rule.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-base-parameter" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@extensionResource
@parentResource(ResourceRecommendationBase)
model SuppressionContract
  is Azure.ResourceManager.ExtensionResource<SuppressionProperties> {
  ...ResourceNameParameter<
    Resource = SuppressionContract,
    KeyName = "name",
    SegmentName = "suppressions",
    NamePattern = ""
  >;
}

@armResourceOperations
interface SuppressionContracts {
  /**
   * Obtains the details of a suppression.
   */
  #suppress "@azure-tools/typespec-azure-core/response-schema-problem" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  get is ArmResourceRead<
    SuppressionContract,
    BaseParameters = Azure.ResourceManager.Foundations.ExtensionBaseParameters,
    Error = ArmDefaultErrorResponse | ArmNotFoundResponse,
    Response = ArmResponse<SuppressionContract>
  >;

  /**
   * Enables the snoozed or dismissed attribute of a recommendation. The snoozed or dismissed attribute is referred to as a suppression. Use this API to create or update the snoozed or dismissed status of a recommendation.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/response-schema-problem" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  create is ArmResourceCreateOrReplaceSync<
    SuppressionContract,
    BaseParameters = Azure.ResourceManager.Foundations.ExtensionBaseParameters,
    Error = ArmDefaultErrorResponse | ArmNotFoundResponse,
    Response = ArmResponse<SuppressionContract>
  >;

  /**
   * Enables the activation of a snoozed or dismissed recommendation. The snoozed or dismissed attribute of a recommendation is referred to as a suppression.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteSync<
    SuppressionContract,
    BaseParameters = Azure.ResourceManager.Foundations.ExtensionBaseParameters,
    Response = ArmDeletedNoContentResponse,
    Error = ArmDefaultErrorResponse
  >;
}

@@doc(SuppressionContract.name, "The name of the suppression.");
@@doc(SuppressionContract.properties, "The properties of the suppression.");
@@doc(SuppressionContracts.create::parameters.resource,
  "The snoozed or dismissed attribute; for example, the snooze duration."
);
