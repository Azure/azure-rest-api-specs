import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "../Common/main.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Common;

namespace Microsoft.Security;
/**
 * Security sub-assessment on a resource
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-base-parameter" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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

alias SecuritySubAssessmentOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;

    /**
     * The scope of the sub-assessment.
     */
    @path(#{ allowReserved: true })
    @key
    scope: string;

    /**
     * The provider namespace.
     */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.Security";
  },
  {
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
     * The security assessment key - unique key for the assessment type
     */
    @path
    @segment("assessments")
    @key
    assessmentName: string;

    /**
     * The Sub-Assessment Key - Unique key for the sub-assessment type
     */
    @path
    @segment("subAssessments")
    @key
    subAssessmentName: string;
  }
>;

@armResourceOperations(#{ omitTags: true })
interface SecuritySubAssessments {
  /**
   * Get a security sub-assessment on your scanned resource
   */
  @tag("SubAssessments")
  get is SecuritySubAssessmentOps.Read<
    SecuritySubAssessment,
    ErrorType = CloudError
  >;

  /**
   * Get security sub-assessments on all your scanned resources inside a scope
   */
  @tag("SubAssessments")
  list is SecuritySubAssessmentOps.List<
    SecuritySubAssessment,
    Response = ArmResponse<SecuritySubAssessmentList>,
    ErrorType = CloudError
  >;
}

@@doc(SecuritySubAssessment.name,
  "The Sub-Assessment Key - Unique key for the sub-assessment type"
);
@@doc(SecuritySubAssessment.properties,
  "Describes properties of an sub-assessment."
);


