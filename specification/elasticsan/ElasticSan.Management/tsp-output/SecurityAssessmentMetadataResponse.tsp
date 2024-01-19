import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Security;
@doc("Security assessment metadata response")
@tenantResource
model SecurityAssessmentMetadataResponse
  is ProxyResource<SecurityAssessmentMetadataPropertiesResponse> {
  @doc("The Assessment Key - Unique key for the assessment type")
  @path
  @key("assessmentMetadataName")
  @segment("assessmentMetadata")
  name: string;
}

@armResourceOperations
interface SecurityAssessmentMetadataResponses {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get metadata information on an assessment type")
  @operationId("AssessmentsMetadata_Get")
  get is ArmResourceRead<SecurityAssessmentMetadataResponse>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get metadata information on all assessment types")
  @operationId("AssessmentsMetadata_List")
  list is ArmResourceListByParent<SecurityAssessmentMetadataResponse>;
}
