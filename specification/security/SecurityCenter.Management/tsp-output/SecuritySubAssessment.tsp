import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./SecurityAssessmentResponse.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.SecurityCenter;
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
interface SubAssessments {
  @doc("Get a security sub-assessment on your scanned resource")
  get is ArmResourceRead<SecuritySubAssessment>;
  @doc("Get security sub-assessments on all your scanned resources inside a scope")
  list is ArmResourceListByParent<SecuritySubAssessment>;
}
