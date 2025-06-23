import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Advisor;
/**
 * The details of Advisor score for a single category.
 */
@subscriptionResource
model AdvisorScoreEntity
  is Azure.ResourceManager.ProxyResource<AdvisorScoreEntityProperties> {
  ...ResourceNameParameter<
    Resource = AdvisorScoreEntity,
    KeyName = "name",
    SegmentName = "advisorScore",
    NamePattern = "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  >;
}

@armResourceOperations
interface AdvisorScoreEntities {
  /**
   * Gets score for a subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/response-schema-problem" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("AdvisorScore_Get")
  get is ArmResourceRead<
    AdvisorScoreEntity,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Error = ArmDefaultErrorResponse
  >;

  /**
   * Gets advisor scores for a subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/response-schema-problem" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("AdvisorScore_List")
  list is ArmResourceListByParent<
    AdvisorScoreEntity,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Response = ArmResponse<AdvisorScoreResponse>,
    Error = ArmDefaultErrorResponse
  >;
}

@@doc(AdvisorScoreEntity.name, "The scope of Advisor score entity.");
@@doc(AdvisorScoreEntity.properties, "The Advisor score data.");
