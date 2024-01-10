import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.Security;
@doc("Security assessment metadata response")
@tenantResource
model SecurityAssessmentMetadataResponse
  is ProxyResource<SecurityAssessmentMetadataPropertiesResponse> {
  @doc("The Assessment Key - Unique key for the assessment type")
  @key("assessmentMetadataName")
  @segment("assessmentMetadata")
  name: string;
}

@armResourceOperations
@projectedName("client", "AssessmentsMetadata")
interface SecurityAssessmentMetadataResponses_AssessmentsMetadata {
  @doc("Get metadata information on an assessment type")
  get is ArmResourceRead<SecurityAssessmentMetadataResponse>;

  @doc("Get metadata information on all assessment types")
  list is ArmResourceListByParent<SecurityAssessmentMetadataResponse>;
}
