import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";

using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Versioning;

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
@added(Versions.v2025_05_01_preview)
@removed(Versions.v2026_02_01)
interface AssessmentResults {
  /**
   * Get an existing Azure Advisor assessment.
   */
  get is ArmResourceRead<
    AssessmentResult,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * Create or Overwrite Azure Advisor assessment.
   */
  put is ArmResourceCreateOrReplaceSync<
    AssessmentResult,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * Delete an existing Azure Advisor assessment.
   */
  delete is ArmResourceDeleteSync<
    AssessmentResult,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * Get list of Azure Advisor assessments.
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
