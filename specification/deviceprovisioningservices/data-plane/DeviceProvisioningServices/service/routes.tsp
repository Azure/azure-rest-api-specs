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
      @header
      `If-Match`?: string;

      /**
       * The device enrollment record.
       */
      @bodyRoot
      enrollment: IndividualEnrollment;
    },
    IndividualEnrollment,
    {},
    ProvisioningServiceErrorDetails
  >;

  /**
   * Delete a device enrollment record.
   */
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
  @summary("Query the device enrollment records.")
  @operationId("IndividualEnrollment_Query")
  @route("/enrollments/query")
  @post
  query is Azure.Core.Foundations.Operation<
    {
      /**
       * Page size
       */
      @header
      `x-ms-max-item-count`?: int32;

      /**
       * Continuation token
       */
      @header
      `x-ms-continuation`?: string;

      /**
       * The query specification.
       */
      @bodyRoot
      querySpecification: QuerySpecification;
    },
    QueryResponse<IndividualEnrollment>,
    {},
    ProvisioningServiceErrorDetails
  >;

  /**
   * Get the attestation mechanism in the device enrollment record.
   */
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
  @summary("Bulk device enrollment operation with maximum of 10 enrollments.")
  @operationId("IndividualEnrollment_RunBulkOperation")
  @route("/enrollments")
  @post
  runBulkOperation is Azure.Core.Foundations.Operation<
    {
      @bodyRoot bulkOperation: BulkEnrollmentOperation;
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
      @header
      `If-Match`?: string;

      /**
       * The device enrollment group.
       */
      @bodyRoot
      enrollmentGroup: EnrollmentGroup;
    },
    EnrollmentGroup,
    {},
    ProvisioningServiceErrorDetails
  >;

  /**
   * Delete a device enrollment group.
   */
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
  @summary("Query the device enrollment groups.")
  @operationId("EnrollmentGroup_Query")
  @route("/enrollmentGroups/query")
  @post
  query is Azure.Core.Foundations.Operation<
    {
      /**
       * Page size
       */
      @header
      `x-ms-max-item-count`?: int32;

      /**
       * Continuation token
       */
      @header
      `x-ms-continuation`?: string;

      /**
       * The query specification.
       */
      @bodyRoot
      querySpecification: QuerySpecification;
    },
    QueryResponse<EnrollmentGroup>,
    {},
    ProvisioningServiceErrorDetails
  >;

  /**
   * Get the attestation mechanism in the device enrollment group record.
   */
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
  @summary("Bulk device enrollment group operation with maximum of 10 groups.")
  @operationId("EnrollmentGroup_RunBulkOperation")
  @route("/enrollmentGroups")
  @post
  runBulkOperation is Azure.Core.Foundations.Operation<
    {
      @bodyRoot bulkOperation: BulkEnrollmentGroupOperation;
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
      @header
      `x-ms-max-item-count`?: int32;

      /**
       * continuation token
       */
      @header
      `x-ms-continuation`?: string;
    },
    QueryResponse<DeviceRegistrationState>,
    {},
    ProvisioningServiceErrorDetails
  >;
}
