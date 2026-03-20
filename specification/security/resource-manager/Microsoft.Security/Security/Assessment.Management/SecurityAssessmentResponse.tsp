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

@armResourceOperations
interface SecurityAssessmentResponses {
  /**
   * Get a security assessment on your scanned resource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Assessments_Get")
  get is Extension.Read<
    Extension.ScopeParameter,
    SecurityAssessmentResponse,
    Parameters = {
      /**
       * OData expand. Optional.
       */
      @query("$expand")
      $expand?: ExpandEnum;
    }
  >;

  /**
   * Create a security assessment on your resource. An assessment metadata that describes this assessment must be predefined with the same name before inserting the assessment result
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Assessments_CreateOrUpdate")
  createOrUpdate is Azure.ResourceManager.Legacy.Extension.CreateOrReplaceSync<
    Extension.ScopeParameter,
    SecurityAssessmentResponse,
    Request = SecurityAssessment
  >;

  /**
   * Delete a security assessment on your resource. An assessment metadata that describes this assessment must be predefined with the same name before inserting the assessment result
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Assessments_Delete")
  delete is Extension.DeleteSync<
    Extension.ScopeParameter,
    SecurityAssessmentResponse
  >;

  /**
   * Get security assessments on all your scanned resources inside a scope
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Assessments_List")
  list is Extension.ListByTarget<
    Extension.ScopeParameter,
    SecurityAssessmentResponse,
    Parameters = {
      /**
       * Scope of the query, can be subscription (/subscriptions/0b06d9ea-afe6-4779-bd59-30e5c2d9d13f) or management group (/providers/Microsoft.Management/managementGroups/mgName).
       */
      @path
      scope: string;
    },
    Response = ArmResponse<SecurityAssessmentList>
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
