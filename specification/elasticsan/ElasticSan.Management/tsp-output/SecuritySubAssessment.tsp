import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./SecurityAssessmentResponse.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Security;
@doc("Security sub-assessment on a resource")
@parentResource(SecurityAssessmentResponse)
model SecuritySubAssessment is ProxyResource<SecuritySubAssessmentProperties> {
  @doc("The Sub-Assessment Key - Unique key for the sub-assessment type")
  @path
  @key("subAssessmentName")
  @segment("subAssessments")
  name: string;
}

@armResourceOperations
interface SecuritySubAssessments {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get a security sub-assessment on your scanned resource")
  @operationId("SubAssessments_Get")
  get is ArmResourceRead<SecuritySubAssessment>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get security sub-assessments on all your scanned resources inside a scope")
  @operationId("SubAssessments_List")
  list is ArmResourceListByParent<SecuritySubAssessment>;
}
