import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";

using Azure.ResourceManager;
using TypeSpec.Http;

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
  get is ArmResourceRead<
    AssessmentResult,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * Create or Overwrite Azure Advisor assessment resource.
   */
  put is ArmResourceCreateOrReplaceSync<
    AssessmentResult,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * Delete a existing Azure Advisor assessment.
   */
  delete is ArmResourceDeleteSync<
    AssessmentResult,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * Get list of Azure Advisor assessment.
   */
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
