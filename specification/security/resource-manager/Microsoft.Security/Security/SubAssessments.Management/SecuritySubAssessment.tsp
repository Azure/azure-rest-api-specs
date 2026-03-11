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
 * Security sub-assessment on a resource
 */
@extensionResource
model SecuritySubAssessment
  is Azure.ResourceManager.ExtensionResource<SecuritySubAssessmentProperties> {
  ...ResourceNameParameter<
    Resource = SecuritySubAssessment,
    KeyName = "subAssessmentName",
    SegmentName = "subAssessments",
    NamePattern = ""
  >;
}

alias SecuritySubAssessmentLegacyOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...Extension.ScopeParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /**
     * The security assessment key - unique key for the assessment type
     */
    @path
    @segment("assessments")
    @key
    assessmentName: string;
  },
  {
    /**
     * The Sub-Assessment Key - Unique key for the sub-assessment type
     */
    @path
    @segment("subAssessments")
    @key
    subAssessmentName: string;
  }
>;

@armResourceOperations
interface SecuritySubAssessments {
  /**
   * Get a security sub-assessment on your scanned resource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SubAssessments_Get")
  get is SecuritySubAssessmentLegacyOps.Read<SecuritySubAssessment>;

  /**
   * Get security sub-assessments on all your scanned resources inside a scope
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SubAssessments_List")
  list is SecuritySubAssessmentLegacyOps.List<SecuritySubAssessment>;
}

@@doc(SecuritySubAssessment.name,
  "The Sub-Assessment Key - Unique key for the sub-assessment type"
);
@@doc(SecuritySubAssessment.properties,
  "Describes properties of an sub-assessment."
);
