import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.Security;
@doc("Security assessment on a resource - response format")
model SecurityAssessmentResponse
  is ExtensionResource<SecurityAssessmentPropertiesResponse> {
  @doc("The Assessment Key - Unique key for the assessment type")
  @key("assessmentName")
  @segment("assessments")
  name: string;
}

@armResourceOperations
@projectedName("client", "Assessments")
interface SecurityAssessmentResponses_Assessments {
  @doc("Get a security assessment on your scanned resource")
  get is ArmResourceRead<
    SecurityAssessmentResponse,
    {
      ...BaseParameters<SecurityAssessmentResponse>;

      @doc("OData expand. Optional.")
      @query("$expand")
      $expand?: ExpandEnum;
    }
  >;

  @doc("Create a security assessment on your resource. An assessment metadata that describes this assessment must be predefined with the same name before inserting the assessment result")
  createOrUpdate is ArmResourceCreateOrReplaceSync<SecurityAssessmentResponse>;

  @doc("Delete a security assessment on your resource. An assessment metadata that describes this assessment must be predefined with the same name before inserting the assessment result")
  delete is ArmResourceDeleteSync<SecurityAssessmentResponse>;
}
