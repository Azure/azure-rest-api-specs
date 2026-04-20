import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Education;
/**
 * Student lab details.
 */
@tenantResource
model StudentLabDetails
  is Azure.ResourceManager.ProxyResource<StudentLabProperties> {
  ...ResourceNameParameter<
    Resource = StudentLabDetails,
    KeyName = "studentLabName",
    SegmentName = "studentLabs",
    NamePattern = ""
  >;
}

@armResourceOperations
interface StudentLabs {
  /**
   * Get the details for a specified lab associated with the student lab.
   */
  get is ArmResourceRead<
    StudentLabDetails,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;

  /**
   * Get a list of all labs associated with the caller of the API.
   */
  listAll is ArmResourceListByParent<
    StudentLabDetails,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;
}

@@doc(StudentLabDetails.name, "The ID that uniquely identifies a student lab.");
@@doc(StudentLabDetails.properties, "Student lab properties.");
