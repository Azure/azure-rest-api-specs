import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.SecurityCenter;
@doc("Security assessment on a resource - response format")
model SecurityAssessment
  is ExtensionResource<SecurityAssessmentPropertiesResponse> {
  @doc("The Assessment Key - Unique key for the assessment type")
  @path
  @key("assessmentName")
  @segment("assessments")
  name: string;
}

@armResourceOperations
interface SecurityAssessments {
  @doc("Get a security assessment on your scanned resource")
  get is ArmResourceRead<
    SecurityAssessment,
    {
      ...BaseParameters<SecurityAssessment>;

      @doc("OData expand. Optional.")
      @query("$expand")
      $expand?: ExpandEnum;
    }
  >;
  @doc("Create a security assessment on your resource. An assessment metadata that describes this assessment must be predefined with the same name before inserting the assessment result")
  createOrUpdate is ArmResourceCreateOrReplaceSync<SecurityAssessment>;
  @doc("Delete a security assessment on your resource. An assessment metadata that describes this assessment must be predefined with the same name before inserting the assessment result")
  delete is ArmResourceDeleteSync<SecurityAssessment>;
}
