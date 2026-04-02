import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Security;
/**
 * Security assessment on a resource - response format
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-base-parameter" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@extensionResource
model SecurityAssessmentResponse
  is Azure.ResourceManager.ExtensionResource<SecurityAssessmentPropertiesResponse> {
  ...ResourceNameParameter<
    Resource = SecurityAssessmentResponse,
    KeyName = "assessmentName",
    SegmentName = "assessments",
    NamePattern = ""
  >;
}

model SecurityAssessmentResponsesScopeParameter
  is Azure.ResourceManager.Extension.ScopeParameter;

@armResourceOperations(#{ omitTags: true })
interface SecurityAssessmentResponses {
  /**
   * Get a security assessment on your scanned resource
   */
  @tag("Assessments")
  get is Azure.ResourceManager.Extension.Read<
    SecurityAssessmentResponsesScopeParameter,
    SecurityAssessmentResponse,
    Parameters = {
      /**
       * OData expand. Optional.
       */
      @query("$expand")
      $expand?: ExpandEnum;
    },
    Error = CloudError
  >;

  /**
   * Create a security assessment on your resource. An assessment metadata that describes this assessment must be predefined with the same name before inserting the assessment result
   */
  @tag("Assessments")
  createOrUpdate is Azure.ResourceManager.Legacy.Extension.CreateOrReplaceSync<
    SecurityAssessmentResponsesScopeParameter,
    SecurityAssessmentResponse,
    Request = SecurityAssessment,
    Error = CloudError
  >;

  /**
   * Delete a security assessment on your resource. An assessment metadata that describes this assessment must be predefined with the same name before inserting the assessment result
   */
  @tag("Assessments")
  delete is Azure.ResourceManager.Extension.DeleteSync<
    SecurityAssessmentResponsesScopeParameter,
    SecurityAssessmentResponse,
    Error = CloudError
  >;

  /**
   * Get security assessments on all your scanned resources inside a scope
   */
  @tag("Assessments")
  list is Azure.ResourceManager.Extension.ListByTarget<
    Azure.ResourceManager.Extension.ScopeParameter,
    SecurityAssessmentResponse,
    Response = ArmResponse<SecurityAssessmentList>,
    Error = CloudError
  >;
}

@@doc(SecurityAssessmentResponse.name,
  "The Assessment Key - Unique key for the assessment type"
);
@@doc(SecurityAssessmentResponse.properties,
  "Describes properties of an assessment."
);
@@doc(SecurityAssessmentResponses.createOrUpdate::parameters.resource,
  "Calculated assessment on a pre-defined assessment metadata"
);
@@key(SecurityAssessmentResponsesScopeParameter.scope, "resourceId");
