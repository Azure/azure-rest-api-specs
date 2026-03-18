import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./AccessReviewInstance.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Authorization;
/**
 * Access Review.
 */
@tenantResource
@parentResource(AccessReviewInstance)
model AccessReviewDecision
  is Azure.ResourceManager.ProxyResource<AccessReviewDecisionProperties> {
  ...ResourceNameParameter<
    Resource = AccessReviewDecision,
    KeyName = "decisionId",
    SegmentName = "decisions",
    NamePattern = ""
  >;
}

@armResourceOperations
interface AccessReviewDecisions {
  /**
   * Get my single access review instance decision.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AccessReviewInstanceMyDecisions_GetById")
  getById is ArmResourceRead<
    AccessReviewDecision,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;

  /**
   * Record a decision.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AccessReviewInstanceMyDecisions_Patch")
  @patch(#{ implicitOptionality: false })
  patch is ArmCustomPatchSync<
    AccessReviewDecision,
    PatchModel = AccessReviewDecisionProperties,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;

  /**
   * Get my access review instance decisions.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AccessReviewInstanceMyDecisions_List")
  list is ArmResourceListByParent<
    AccessReviewDecision,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Parameters = {
      /**
       * The filter to apply on the operation. Other than standard filters, one custom filter option is supported : 'assignedToMeToReview()'. When one specified $filter=assignedToMeToReview(), only items that are assigned to the calling user to review are returned
       */
      @query("$filter")
      $filter?: string;
    }
  >;
}

@@doc(AccessReviewDecision.name, "The id of the decision record.");
@@doc(AccessReviewDecision.properties, "Access Review Decision properties.");
@@doc(AccessReviewDecisions.patch::parameters.properties,
  "Access review decision properties to patch."
);
