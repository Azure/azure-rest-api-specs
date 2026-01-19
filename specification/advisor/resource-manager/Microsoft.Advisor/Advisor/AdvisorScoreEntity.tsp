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
    NamePattern = ""
  >;
}

@armResourceOperations
interface AdvisorScoreEntities {
  /**
   * Gets the advisor score.
   */
  #suppress "@azure-tools/typespec-azure-core/response-schema-problem" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  get is ArmResourceRead<
    AdvisorScoreEntity,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Error = ArmDefaultErrorResponse
  >;

  /**
   * Gets the list of advisor scores.
   */
  #suppress "@azure-tools/typespec-azure-core/response-schema-problem" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  list is ArmResourceListByParent<
    AdvisorScoreEntity,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Response = ArmResponse<AdvisorScoreResponse>,
    Error = ArmDefaultErrorResponse
  >;
}

@@doc(AdvisorScoreEntity.name, "The scope of Advisor score entity.");
@@doc(AdvisorScoreEntity.properties, "The Advisor score data.");
