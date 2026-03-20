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
 * Security assessment metadata response
 */
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

@armResourceOperations
interface SecurityAssessmentMetadataResponses {
  /**
   * Get metadata information on an assessment type
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AssessmentsMetadata_Get")
  get is SecurityAssessmentMetadataResponseOps.Read<SecurityAssessmentMetadataResponse>;

  /**
   * Get metadata information on all assessment types
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AssessmentsMetadata_List")
  list is SecurityAssessmentMetadataResponseOps.List<
    SecurityAssessmentMetadataResponse,
    Response = ArmResponse<SecurityAssessmentMetadataResponseList>
  >;
}
alias AssessmentsMetadatumOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;

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

@armResourceOperations
interface AssessmentsMetadata {
  /**
   * Get metadata information on an assessment type in a specific subscription
   */
  getInSubscription is AssessmentsMetadatumOps.Read<SecurityAssessmentMetadataResponse>;

  /**
   * Create metadata information on an assessment type in a specific subscription
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  createInSubscription is AssessmentsMetadatumOps.CreateOrUpdateSync<
    SecurityAssessmentMetadataResponse,
    Response = ArmResourceUpdatedResponse<SecurityAssessmentMetadataResponse>
  >;

  /**
   * Delete metadata information on an assessment type in a specific subscription, will cause the deletion of all the assessments of that type in that subscription
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  deleteInSubscription is AssessmentsMetadatumOps.DeleteSync<
    SecurityAssessmentMetadataResponse,
    Response = ArmDeletedResponse
  >;

  /**
   * Get metadata information on all assessment types in a specific subscription
   */
  listBySubscription is AssessmentsMetadatumOps.List<
    SecurityAssessmentMetadataResponse,
    Response = ArmResponse<SecurityAssessmentMetadataResponseList>
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
