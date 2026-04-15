import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace ProvisioningServiceClient;

interface IndividualEnrollmentOperationGroup {
  /**
   * Get a device enrollment record.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Migration from Swagger: preserving operationId for compatibility"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Migration from Swagger: operation name preserved for compatibility"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Migration from Swagger: using Foundations.Operation for compatibility"
  @summary("Get a device enrollment record.")
  @operationId("IndividualEnrollment_Get")
  @route("/enrollments/{id}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * This id is used to uniquely identify a device registration of an enrollment. A
       * case-insensitive string (up to 128 characters long) of alphanumeric characters
       * plus certain special characters : . _ -. No special characters allowed at start
       * or end.
       */
      @path
      id: string;
    },
    IndividualEnrollment,
    {},
    ProvisioningServiceErrorDetails
  >;

  /**
   * Create or update a device enrollment record.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Migration from Swagger: preserving operationId for compatibility"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Migration from Swagger: operation name preserved for compatibility"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Migration from Swagger: using Foundations.Operation for compatibility"
  @summary("Create or update a device enrollment record.")
  @operationId("IndividualEnrollment_CreateOrUpdate")
  @route("/enrollments/{id}")
  @put
  createOrUpdate is Azure.Core.Foundations.Operation<
    {
      /**
       * This id is used to uniquely identify a device registration of an enrollment. A
       * case-insensitive string (up to 128 characters long) of alphanumeric characters
       * plus certain special characters : . _ -. No special characters allowed at start
       * or end.
       */
      @path
      id: string;

      /**
       * The ETag of the enrollment record.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Migration from Swagger: HTTP header name is a standard HTTP header"
      @header
      `If-Match`?: string;

      /**
       * The device enrollment record.
       */
      @bodyRoot
      body: IndividualEnrollment;
    },
    IndividualEnrollment,
    {},
    ProvisioningServiceErrorDetails
  >;

  /**
   * Delete a device enrollment record.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Migration from Swagger: preserving operationId for compatibility"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Migration from Swagger: operation name preserved for compatibility"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Migration from Swagger: using Foundations.Operation for compatibility"
  @summary("Delete a device enrollment record.")
  @operationId("IndividualEnrollment_Delete")
  @route("/enrollments/{id}")
  @delete
  delete is Azure.Core.Foundations.Operation<
    {
      /**
       * This id is used to uniquely identify a device registration of an enrollment. A
       * case-insensitive string (up to 128 characters long) of alphanumeric characters
       * plus certain special characters : . _ -. No special characters allowed at start
       * or end.
       */
      @path
      id: string;

      /**
       * The ETag of the enrollment record.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Migration from Swagger: HTTP header name is a standard HTTP header"
      @header
      `If-Match`?: string;
    },
    void,
    {},
    ProvisioningServiceErrorDetails
  >;

  /**
   * Query the device enrollment records.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Migration from Swagger: preserving operationId for compatibility"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Migration from Swagger: operation name preserved for compatibility"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Migration from Swagger: using Foundations.Operation for compatibility"
  @summary("Query the device enrollment records.")
  @operationId("IndividualEnrollment_Query")
  @route("/enrollments/query")
  @post
  query is Azure.Core.Foundations.Operation<
    {
      /**
       * Page size
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Migration from Swagger: x-ms-max-item-count is a standard Azure header"
      @header
      `x-ms-max-item-count`?: int32;

      /**
       * Continuation token
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Migration from Swagger: x-ms-continuation is a standard Azure header"
      @header
      `x-ms-continuation`?: string;

      /**
       * The query specification.
       */
      @bodyRoot
      body: QuerySpecification;
    },
    QueryResponse<IndividualEnrollment>,
    {},
    ProvisioningServiceErrorDetails
  >;

  /**
   * Get the attestation mechanism in the device enrollment record.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Migration from Swagger: preserving operationId for compatibility"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Migration from Swagger: operation name preserved for compatibility"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Migration from Swagger: using Foundations.Operation for compatibility"
  @summary("Get the attestation mechanism in the device enrollment record.")
  @operationId("IndividualEnrollment_GetAttestationMechanism")
  @route("/enrollments/{id}/attestationmechanism")
  @post
  getAttestationMechanism is Azure.Core.Foundations.Operation<
    {
      /**
       * This id is used to uniquely identify a device registration of an enrollment. A
       * case-insensitive string (up to 128 characters long) of alphanumeric characters
       * plus certain special characters : . _ -. No special characters allowed at start
       * or end.
       */
      @path
      id: string;
    },
    AttestationMechanism,
    {},
    ProvisioningServiceErrorDetails
  >;

  /**
   * Bulk device enrollment operation with maximum of 10 enrollments.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Migration from Swagger: preserving operationId for compatibility"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Migration from Swagger: operation name preserved for compatibility"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Migration from Swagger: using Foundations.Operation for compatibility"
  @summary("Bulk device enrollment operation with maximum of 10 enrollments.")
  @operationId("IndividualEnrollment_RunBulkOperation")
  @route("/enrollments")
  @post
  runBulkOperation is Azure.Core.Foundations.Operation<
    {
      /** The bulk enrollment operation. */
      @bodyRoot body: BulkEnrollmentOperation;
    },
    BulkEnrollmentOperationResult,
    {},
    ProvisioningServiceErrorDetails
  >;
}

interface EnrollmentGroupOperationGroup {
  /**
   * Get a device enrollment group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Migration from Swagger: preserving operationId for compatibility"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Migration from Swagger: operation name preserved for compatibility"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Migration from Swagger: using Foundations.Operation for compatibility"
  @summary("Get a device enrollment group.")
  @operationId("EnrollmentGroup_Get")
  @route("/enrollmentGroups/{id}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * Enrollment group ID.
       */
      @path
      id: string;
    },
    EnrollmentGroup,
    {},
    ProvisioningServiceErrorDetails
  >;

  /**
   * Create or update a device enrollment group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Migration from Swagger: preserving operationId for compatibility"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Migration from Swagger: operation name preserved for compatibility"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Migration from Swagger: using Foundations.Operation for compatibility"
  @summary("Create or update a device enrollment group.")
  @operationId("EnrollmentGroup_CreateOrUpdate")
  @route("/enrollmentGroups/{id}")
  @put
  createOrUpdate is Azure.Core.Foundations.Operation<
    {
      /**
       * Enrollment group ID.
       */
      @path
      id: string;

      /**
       * The ETag of the enrollment record.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Migration from Swagger: HTTP header name is a standard HTTP header"
      @header
      `If-Match`?: string;

      /**
       * The device enrollment group.
       */
      @bodyRoot
      body: EnrollmentGroup;
    },
    EnrollmentGroup,
    {},
    ProvisioningServiceErrorDetails
  >;

  /**
   * Delete a device enrollment group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Migration from Swagger: preserving operationId for compatibility"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Migration from Swagger: operation name preserved for compatibility"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Migration from Swagger: using Foundations.Operation for compatibility"
  @summary("Delete a device enrollment group.")
  @operationId("EnrollmentGroup_Delete")
  @route("/enrollmentGroups/{id}")
  @delete
  delete is Azure.Core.Foundations.Operation<
    {
      /**
       * Enrollment group ID.
       */
      @path
      id: string;

      /**
       * The ETag of the enrollment group record.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Migration from Swagger: HTTP header name is a standard HTTP header"
      @header
      `If-Match`?: string;
    },
    void,
    {},
    ProvisioningServiceErrorDetails
  >;

  /**
   * Query the device enrollment groups.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Migration from Swagger: preserving operationId for compatibility"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Migration from Swagger: operation name preserved for compatibility"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Migration from Swagger: using Foundations.Operation for compatibility"
  @summary("Query the device enrollment groups.")
  @operationId("EnrollmentGroup_Query")
  @route("/enrollmentGroups/query")
  @post
  query is Azure.Core.Foundations.Operation<
    {
      /**
       * Page size
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Migration from Swagger: x-ms-max-item-count is a standard Azure header"
      @header
      `x-ms-max-item-count`?: int32;

      /**
       * Continuation token
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Migration from Swagger: x-ms-continuation is a standard Azure header"
      @header
      `x-ms-continuation`?: string;

      /**
       * The query specification.
       */
      @bodyRoot
      body: QuerySpecification;
    },
    QueryResponse<EnrollmentGroup>,
    {},
    ProvisioningServiceErrorDetails
  >;

  /**
   * Get the attestation mechanism in the device enrollment group record.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Migration from Swagger: preserving operationId for compatibility"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Migration from Swagger: operation name preserved for compatibility"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Migration from Swagger: using Foundations.Operation for compatibility"
  @summary("Get the attestation mechanism in the device enrollment group record.")
  @operationId("EnrollmentGroup_GetAttestationMechanism")
  @route("/enrollmentGroups/{id}/attestationmechanism")
  @post
  getAttestationMechanism is Azure.Core.Foundations.Operation<
    {
      /**
       * Enrollment group ID
       */
      @path
      id: string;
    },
    AttestationMechanism,
    {},
    ProvisioningServiceErrorDetails
  >;

  /**
   * Bulk device enrollment group operation with maximum of 10 groups.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Migration from Swagger: preserving operationId for compatibility"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Migration from Swagger: operation name preserved for compatibility"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Migration from Swagger: using Foundations.Operation for compatibility"
  @summary("Bulk device enrollment group operation with maximum of 10 groups.")
  @operationId("EnrollmentGroup_RunBulkOperation")
  @route("/enrollmentGroups")
  @post
  runBulkOperation is Azure.Core.Foundations.Operation<
    {
      /** The bulk enrollment group operation. */
      @bodyRoot body: BulkEnrollmentGroupOperation;
    },
    BulkEnrollmentGroupOperationResult,
    {},
    ProvisioningServiceErrorDetails
  >;
}

interface DeviceRegistrationStateOperationGroup {
  /**
   * Gets the device registration state.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Migration from Swagger: preserving operationId for compatibility"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Migration from Swagger: operation name preserved for compatibility"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Migration from Swagger: using Foundations.Operation for compatibility"
  @summary("Gets the device registration state.")
  @operationId("DeviceRegistrationState_Get")
  @route("/registrations/{id}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * Registration ID.
       */
      @path
      id: string;
    },
    DeviceRegistrationState,
    {},
    ProvisioningServiceErrorDetails
  >;

  /**
   * Deletes the device registration
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Migration from Swagger: preserving operationId for compatibility"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Migration from Swagger: operation name preserved for compatibility"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Migration from Swagger: using Foundations.Operation for compatibility"
  @summary("Deletes the device registration")
  @operationId("DeviceRegistrationState_Delete")
  @route("/registrations/{id}")
  @delete
  delete is Azure.Core.Foundations.Operation<
    {
      /**
       * Registration ID.
       */
      @path
      id: string;

      /**
       * The ETag of the registration status record.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Migration from Swagger: HTTP header name is a standard HTTP header"
      @header
      `If-Match`?: string;
    },
    void,
    {},
    ProvisioningServiceErrorDetails
  >;

  /**
   * Gets the registration state of devices in this enrollmentGroup.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Migration from Swagger: preserving operationId for compatibility"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Migration from Swagger: operation name preserved for compatibility"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Migration from Swagger: using Foundations.Operation for compatibility"
  @summary("Gets the registration state of devices in this enrollmentGroup.")
  @operationId("DeviceRegistrationState_Query")
  @route("/registrations/{id}/query")
  @post
  query is Azure.Core.Foundations.Operation<
    {
      /**
       * Enrollment group ID.
       */
      @path
      id: string;

      /**
       * pageSize
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Migration from Swagger: x-ms-max-item-count is a standard Azure header"
      @header
      `x-ms-max-item-count`?: int32;

      /**
       * continuation token
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Migration from Swagger: x-ms-continuation is a standard Azure header"
      @header
      `x-ms-continuation`?: string;
    },
    QueryResponse<DeviceRegistrationState>,
    {},
    ProvisioningServiceErrorDetails
  >;
}
