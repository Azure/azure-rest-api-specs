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

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserve the existing invoice-section Student paths for backward compatibility."
alias InvoiceSectionStudentOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;

    /** The billing provider namespace. */
    @path
    @segment("providers")
    @key
    billingProviderNamespace: "Microsoft.Billing";

    /** The name of the billing account. */
    @path
    @segment("billingAccounts")
    @key
    billingAccountName: string;

    /** The name of the billing profile. */
    @path
    @segment("billingProfiles")
    @key
    billingProfileName: string;

    /** The name of the invoice section. */
    @path
    @segment("invoiceSections")
    @key
    invoiceSectionName: string;

    ...Legacy.Provider;

    /** The lab name. */
    @path
    @segment("labs")
    @key
    lab: "default";
  },
  {},
  {
    /** The student alias. */
    @path
    @segment("students")
    @key
    studentAlias: string;
  }
>;

@armResourceOperations
interface Students {
  /**
   * Get the details for a specific student in the specified lab by student alias
   */
  get is InvoiceSectionStudentOps.Read<
    StudentDetails,
    ErrorType = DefaultErrorResponse
  >;

  /**
   * Create and add a new student to the specified lab or update the details of an existing student in a lab. Note the student must have a valid tenant to accept the lab after they have been added to lab.
   */
  createOrUpdate is InvoiceSectionStudentOps.CreateOrUpdateSync<
    StudentDetails,
    ErrorType = DefaultErrorResponse
  >;

  /**
   * Delete the specified student based on the student alias.
   */
  delete is InvoiceSectionStudentOps.DeleteSync<
    StudentDetails,
    ErrorType = DeleteErrorResponse
  >;

  /**
   * Get a list of details about students that are associated with the specified lab.
   */
  list is InvoiceSectionStudentOps.List<
    StudentDetails,
    Parameters = {
      /**
       * May be used to show deleted items.
       */
      @query("includeDeleted")
      includeDeleted?: boolean;
    },
    Response = ArmResponse<StudentListResult>,
    ErrorType = DefaultErrorResponse
  >;
}

@@doc(StudentDetails.name, "Student alias.");
@@doc(StudentDetails.properties, "Get student response properties.");
@@doc(Students.createOrUpdate::parameters.resource,
  "Request parameters that are provided to update student properties."
);
