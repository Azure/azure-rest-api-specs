import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./LabDetails.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Education;
/**
 * Student details.
 */
@parentResource(LabDetails)
model StudentDetails is Azure.ResourceManager.ProxyResource<StudentProperties> {
  ...ResourceNameParameter<
    Resource = StudentDetails,
    KeyName = "studentAlias",
    SegmentName = "students",
    NamePattern = ""
  >;
}

@armResourceOperations
interface Students {
  /**
   * Get the details for a specific student in the specified lab by student alias
   */
  get is ArmResourceRead<StudentDetails>;

  /**
   * Create and add a new student to the specified lab or update the details of an existing student in a lab. Note the student must have a valid tenant to accept the lab after they have been added to lab.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<StudentDetails>;

  /**
   * Delete the specified student based on the student alias.
   */
  delete is ArmResourceDeleteSync<StudentDetails>;

  /**
   * Get a list of details about students that are associated with the specified lab.
   */
  list is ArmResourceListByParent<
    StudentDetails,
    Parameters = {
      /**
       * May be used to show deleted items.
       */
      @query("includeDeleted")
      includeDeleted?: boolean;
    }
  >;
}

@@doc(StudentDetails.name, "Student alias.");
@@doc(StudentDetails.properties, "Get student response properties.");
@@doc(Students.createOrUpdate::parameters.resource,
  "Request parameters that are provided to update student properties."
);
