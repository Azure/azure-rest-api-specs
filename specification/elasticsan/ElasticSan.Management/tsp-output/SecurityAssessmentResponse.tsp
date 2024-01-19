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
@doc("Security assessment on a resource - response format")
model SecurityAssessmentResponse
  is ExtensionResource<SecurityAssessmentPropertiesResponse> {
  @doc("The Assessment Key - Unique key for the assessment type")
  @path
  @key("assessmentName")
  @segment("assessments")
  name: string;
}

@armResourceOperations
interface SecurityAssessmentResponses {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get a security assessment on your scanned resource")
  @operationId("Assessments_Get")
  get is ArmResourceRead<
    SecurityAssessmentResponse,
    {
      ...BaseParameters<SecurityAssessmentResponse>;

      @doc("OData expand. Optional.")
      @query("$expand")
      $expand?: ExpandEnum;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create a security assessment on your resource. An assessment metadata that describes this assessment must be predefined with the same name before inserting the assessment result")
  @operationId("Assessments_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<SecurityAssessmentResponse>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete a security assessment on your resource. An assessment metadata that describes this assessment must be predefined with the same name before inserting the assessment result")
  @operationId("Assessments_Delete")
  delete is ArmResourceDeleteSync<SecurityAssessmentResponse>;
}

@@projectedName(SecurityAssessmentResponses.createOrUpdate::parameters.resource,
  "json",
  "assessment"
);
@@extension(SecurityAssessmentResponses.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "assessment"
);
@@doc(SecurityAssessmentResponses.createOrUpdate::parameters.resource,
  "Calculated assessment on a pre-defined assessment metadata"
);
