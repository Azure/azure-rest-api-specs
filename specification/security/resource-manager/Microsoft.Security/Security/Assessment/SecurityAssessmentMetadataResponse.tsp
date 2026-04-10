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
 * Security assessment metadata response
 */
#suppress "@azure-tools/typespec-azure-resource-manager/improper-subscription-list-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@tenantResource
model SecurityAssessmentMetadataResponse
  is Azure.ResourceManager.ProxyResource<SecurityAssessmentMetadataPropertiesResponse> {
  ...ResourceNameParameter<
    Resource = SecurityAssessmentMetadataResponse,
    KeyName = "assessmentMetadataName",
    SegmentName = "assessmentMetadata",
    NamePattern = ""
  >;
}

alias SecurityAssessmentMetadataResponseOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.Security";
  },
  {},
  {
    /** The Assessment Key - Unique key for the assessment type */
    @path
    @segment("assessmentMetadata")
    @key
    assessmentMetadataName: string;
  }
>;

@armResourceOperations(#{ omitTags: true })
interface SecurityAssessmentMetadataResponses {
  /**
   * Get metadata information on an assessment type
   */
  @tag("Assessments Metadata")
  get is SecurityAssessmentMetadataResponseOps.Read<
    SecurityAssessmentMetadataResponse,
    ErrorType = CloudError
  >;

  /**
   * Get metadata information on all assessment types
   */
  @tag("Assessments Metadata")
  list is SecurityAssessmentMetadataResponseOps.List<
    SecurityAssessmentMetadataResponse,
    Response = ArmResponse<SecurityAssessmentMetadataResponseList>,
    ErrorType = CloudError
  >;
}
alias AssessmentsMetadatumOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.Security";
  },
  {
    /** The Assessment Key - Unique key for the assessment type */
    @path
    @segment("assessmentMetadata")
    @key
    assessmentMetadataName: string;
  },
  {}
>;

@armResourceOperations(#{ omitTags: true })
interface AssessmentsMetadata {
  /**
   * Get metadata information on an assessment type in a specific subscription
   */
  @tag("Assessments Metadata")
  getInSubscription is AssessmentsMetadatumOps.Read<
    SecurityAssessmentMetadataResponse,
    OverrideErrorType = CloudError
  >;

  /**
   * Create metadata information on an assessment type in a specific subscription
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("Assessments Metadata")
  createInSubscription is AssessmentsMetadatumOps.CreateOrUpdateSync<
    SecurityAssessmentMetadataResponse,
    Response = ArmResourceUpdatedResponse<SecurityAssessmentMetadataResponse>,
    OverrideErrorType = CloudError
  >;

  /**
   * Delete metadata information on an assessment type in a specific subscription, will cause the deletion of all the assessments of that type in that subscription
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("Assessments Metadata")
  deleteInSubscription is AssessmentsMetadatumOps.DeleteSync<
    SecurityAssessmentMetadataResponse,
    Response = ArmDeletedResponse,
    OverrideErrorType = CloudError
  >;

  /**
   * Get metadata information on all assessment types in a specific subscription
   */
  @tag("Assessments Metadata")
  listBySubscription is AssessmentsMetadatumOps.List<
    SecurityAssessmentMetadataResponse,
    Response = ArmResponse<SecurityAssessmentMetadataResponseList>,
    OverrideErrorType = CloudError
  >;
}

@@doc(SecurityAssessmentMetadataResponse.name,
  "The Assessment Key - Unique key for the assessment type"
);
@@doc(SecurityAssessmentMetadataResponse.properties,
  "Describes properties of an assessment metadata response."
);
@@doc(AssessmentsMetadata.createInSubscription::parameters.resource,
  "AssessmentMetadata object"
);


