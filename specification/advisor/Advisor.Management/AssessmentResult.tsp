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
 * The Advisor assessment result data structure.
 */
@subscriptionResource
model AssessmentResult
  is Azure.ResourceManager.ProxyResource<AssessmentResultProperties> {
  ...ResourceNameParameter<
    Resource = AssessmentResult,
    KeyName = "assessmentName",
    SegmentName = "assessments",
    NamePattern = "^[-0-9a-zA-Z_]{1,63}$"
  >;
}

@armResourceOperations
interface AssessmentResults {
  /**
   * Get a existing Azure Advisor assessment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Assessments_Get")
  get is ArmResourceRead<
    AssessmentResult,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * Create or Overwrite Azure Advisor assessment resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Assessments_Put")
  put is ArmResourceCreateOrReplaceSync<
    AssessmentResult,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * Delete a existing Azure Advisor assessment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Assessments_Delete")
  delete is ArmResourceDeleteSync<
    AssessmentResult,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * Get list of Azure Advisor assessment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Assessments_List")
  list is ArmResourceListByParent<
    AssessmentResult,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Parameters = {
      /**
       * Limit the result to the specified number of rows.
       */
      @query("$top")
      $top?: string;

      /**
       * The page-continuation token to use with a paged version of this API.
       */
      @query("$skiptoken")
      $skiptoken?: string;
    },
    Response = ArmResponse<AssessmentListResult>
  >;
}

@@doc(AssessmentResult.name, "Advisor assessment name.");
@@doc(AssessmentResult.properties,
  "The Advisor assessment result properties structure."
);
@@doc(AssessmentResults.put::parameters.resource,
  "The Azure Advisor assessment data structure."
);
