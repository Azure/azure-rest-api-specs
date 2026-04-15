import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace ProvisioningServiceClient;

/**
 * Enrollment status.
 */
union EnrollmentStatus {
  string,

  /**
   * unassigned
   */
  unassigned: "unassigned",

  /**
   * assigning
   */
  assigning: "assigning",

  /**
   * assigned
   */
  assigned: "assigned",

  /**
   * failed
   */
  failed: "failed",

  /**
   * disabled
   */
  disabled: "disabled",
}

/**
 * Substatus for 'Assigned' devices. Possible values include -
 * 'initialAssignment': Device has been assigned to an IoT hub for the first time,
 * 'deviceDataMigrated': Device has been assigned to a different IoT hub and its
 * device data was migrated from the previously assigned IoT hub. Device data was
 * removed from the previously assigned IoT hub, 'deviceDataReset':  Device has
 * been assigned to a different IoT hub and its device data was populated from the
 * initial state stored in the enrollment. Device data was removed from the
 * previously assigned IoT hub, 'reprovisionedToInitialAssignment': Device has
 * been re-provisioned to a previously assigned IoT hub.
 */
union AssignedDeviceSubstatus {
  string,

  /**
   * initialAssignment
   */
  initialAssignment: "initialAssignment",

  /**
   * deviceDataMigrated
   */
  deviceDataMigrated: "deviceDataMigrated",

  /**
   * deviceDataReset
   */
  deviceDataReset: "deviceDataReset",

  /**
   * reprovisionedToInitialAssignment
   */
  reprovisionedToInitialAssignment: "reprovisionedToInitialAssignment",
}

/**
 * Attestation Type.
 */
union AttestationType {
  string,

  /**
   * none
   */
  none: "none",

  /**
   * tpm
   */
  tpm: "tpm",

  /**
   * x509
   */
  x509: "x509",

  /**
   * symmetricKey
   */
  symmetricKey: "symmetricKey",
}

/**
 * The provisioning status.
 */
union ProvisioningStatus {
  string,

  /**
   * enabled
   */
  enabled: "enabled",

  /**
   * disabled
   */
  disabled: "disabled",
}

/**
 * The allocation policy of this resource. This policy overrides the tenant level
 * allocation policy for this individual enrollment or enrollment group. Possible
 * values include 'hashed': Linked IoT hubs are equally likely to have devices
 * provisioned to them, 'geoLatency':  Devices are provisioned to an IoT hub with
 * the lowest latency to the device.If multiple linked IoT hubs would provide the
 * same lowest latency, the provisioning service hashes devices across those hubs,
 * 'static' : Specification of the desired IoT hub in the enrollment list takes
 * priority over the service-level allocation policy, 'custom': Devices are
 * provisioned to an IoT hub based on your own custom logic. The provisioning
 * service passes information about the device to the logic, and the logic returns
 * the desired IoT hub as well as the desired initial configuration. We recommend
 * using Azure Functions to host your logic.
 */
union AllocationPolicy {
  string,

  /**
   * hashed
   */
  hashed: "hashed",

  /**
   * geoLatency
   */
  geoLatency: "geoLatency",

  /**
   * static
   */
  static: "static",

  /**
   * custom
   */
  custom: "custom",
}

/**
 * Operation mode.
 */
union BulkEnrollmentMode {
  string,

  /**
   * create
   */
  create: "create",

  /**
   * update
   */
  update: "update",

  /**
   * updateIfMatchETag
   */
  updateIfMatchETag: "updateIfMatchETag",

  /**
   * delete
   */
  delete: "delete",
}

/**
 * The device enrollment record.
 */
model IndividualEnrollment {
  /**
   * This id is used to uniquely identify a device registration of an enrollment.
   * A case-insensitive string (up to 128 characters long) of alphanumeric
   * characters plus certain special characters : . _ -. No special characters
   * allowed at start or end.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Version-scoped property using remove/rename/add pattern for version-specific constraints"
  @removed(Versions.v2025_07_01_preview)
  @renamedFrom(Versions.v2025_07_01_preview, "registrationId")
  registrationId_v2021_10_01: string;

  /**
   * This id is used to uniquely identify a device registration of an enrollment.
   * A case-insensitive string (up to 128 characters long) of alphanumeric
   * characters plus certain special characters : . _ -. No special characters
   * allowed at start or end.
   */
  @added(Versions.v2025_07_01_preview)
  @minLength(1)
  registrationId: string;

  /**
   * Desired IoT Hub device ID (optional).
   */
  deviceId?: string;

  /**
   * Linked Azure Device Registry credential policy name (optional).
   */
  @added(Versions.v2025_07_01_preview)
  credentialPolicyName?: string;

  /**
   * Current registration status.
   */
  @visibility(Lifecycle.Read)
  registrationState?: DeviceRegistrationState;

  /**
   * Optional Device Information.
   */
  optionalDeviceInformation?: TwinCollection;

  /**
   * Attestation method used by the device.
   */
  attestation: AttestationMechanism;

  /**
   * Capabilities of the device.
   */
  capabilities?: DeviceCapabilities;

  /**
   * The Iot Hub host name.
   */
  iotHubHostName?: string;

  /**
   * Initial device twin.
   */
  initialTwin?: InitialTwin;

  /**
   * The entity tag associated with the resource.
   */
  etag?: string;

  /**
   * The provisioning status.
   */
  provisioningStatus?: ProvisioningStatus = ProvisioningStatus.enabled;

  /**
   * The behavior when a device is re-provisioned to an IoT hub.
   */
  reprovisionPolicy?: ReprovisionPolicy;

  /**
   * The DateTime this resource was created.
   */
  @visibility(Lifecycle.Read)
  createdDateTimeUtc?: utcDateTime;

  /**
   * The DateTime this resource was last updated.
   */
  @visibility(Lifecycle.Read)
  lastUpdatedDateTimeUtc?: utcDateTime;

  /**
   * The allocation policy of this resource. This policy overrides the tenant level
   * allocation policy for this individual enrollment or enrollment group. Possible
   * values include 'hashed': Linked IoT hubs are equally likely to have devices
   * provisioned to them, 'geoLatency':  Devices are provisioned to an IoT hub with
   * the lowest latency to the device.If multiple linked IoT hubs would provide the
   * same lowest latency, the provisioning service hashes devices across those hubs,
   * 'static' : Specification of the desired IoT hub in the enrollment list takes
   * priority over the service-level allocation policy, 'custom': Devices are
   * provisioned to an IoT hub based on your own custom logic. The provisioning
   * service passes information about the device to the logic, and the logic returns
   * the desired IoT hub as well as the desired initial configuration. We recommend
   * using Azure Functions to host your logic.
   */
  allocationPolicy?: AllocationPolicy;

  /**
   * The list of IoT Hub hostnames the device(s) in this resource can be allocated
   * to. Must be a subset of tenant level list of IoT hubs.
   */
  iotHubs?: string[];

  /**
   * This tells DPS which webhook to call when using custom allocation.
   */
  customAllocationDefinition?: CustomAllocationDefinition;
}

/**
 * Device registration state.
 */
model DeviceRegistrationState {
  /**
   * This id is used to uniquely identify a device registration of an enrollment.
   * A case-insensitive string (up to 128 characters long) of alphanumeric
   * characters plus certain special characters : . _ -. No special characters
   * allowed at start or end.
   */
  @visibility(Lifecycle.Read)
  registrationId?: string;

  /**
   * Registration create date time (in UTC).
   */
  @visibility(Lifecycle.Read)
  createdDateTimeUtc?: utcDateTime;

  /**
   * Assigned Azure IoT Hub.
   */
  @visibility(Lifecycle.Read)
  assignedHub?: string;

  /**
   * Device ID.
   */
  @visibility(Lifecycle.Read)
  deviceId?: string;

  /**
   * Enrollment status.
   */
  @visibility(Lifecycle.Read)
  status?: EnrollmentStatus;

  /**
   * Substatus for 'Assigned' devices. Possible values include -
   * 'initialAssignment': Device has been assigned to an IoT hub for the first time,
   * 'deviceDataMigrated': Device has been assigned to a different IoT hub and its
   * device data was migrated from the previously assigned IoT hub. Device data was
   * removed from the previously assigned IoT hub, 'deviceDataReset':  Device has
   * been assigned to a different IoT hub and its device data was populated from the
   * initial state stored in the enrollment. Device data was removed from the
   * previously assigned IoT hub, 'reprovisionedToInitialAssignment': Device has
   * been re-provisioned to a previously assigned IoT hub.
   */
  @visibility(Lifecycle.Read)
  substatus?: AssignedDeviceSubstatus;

  /**
   * Error code.
   */
  @visibility(Lifecycle.Read)
  errorCode?: int32;

  /**
   * Error message.
   */
  @visibility(Lifecycle.Read)
  errorMessage?: string;

  /**
   * Last updated date time (in UTC).
   */
  @visibility(Lifecycle.Read)
  lastUpdatedDateTimeUtc?: utcDateTime;

  /**
   * The entity tag associated with the resource.
   */
  @visibility(Lifecycle.Read)
  etag?: string;

  /**
   * Custom allocation payload returned from the webhook to the device.
   */
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "payload is an open JSON object per API contract"
  @visibility(Lifecycle.Read)
  payload?: Record<unknown>;
}

/**
 * Represents a collection of properties within a Twin
 */
model TwinCollection {
  ...Record<{}>;

  /**
   * Version of the TwinCollection
   */
  version?: int32;

  /**
   * Number of properties in the TwinCollection
   */
  count?: int32;

  /**
   * Metadata for the TwinCollection
   */
  metadata?: Metadata;
}

/**
 * Metadata for the TwinCollection
 */
model Metadata {
  /**
   * Last time the TwinCollection was updated
   */
  lastUpdated?: utcDateTime;

  /**
   * This is null for reported properties metadata and is not null for desired
   * properties metadata.
   */
  lastUpdatedVersion?: int32;
}

/**
 * Attestation mechanism for individualEnrollment as well as enrollmentGroup.
 */
model AttestationMechanism {
  /**
   * Attestation Type.
   */
  type: AttestationType;

  /**
   * TPM attestation method.
   */
  tpm?: TpmAttestation;

  /**
   * X509 attestation method.
   */
  x509?: X509Attestation;

  /**
   * Symmetric Key attestation method.
   */
  symmetricKey?: SymmetricKeyAttestation;
}

/**
 * Attestation via TPM.
 */
model TpmAttestation {
  /** TPM endorsement key. */
  endorsementKey: string;

  /** TPM storage root key. */
  storageRootKey?: string;
}

/**
 * Attestation via X509.
 */
model X509Attestation {
  /**
   * Primary and secondary certificates
   */
  clientCertificates?: X509Certificates;

  /**
   * Primary and secondary certificates
   */
  signingCertificates?: X509Certificates;

  /**
   * Primary and secondary CA references.
   */
  caReferences?: X509CAReferences;
}

/**
 * Primary and secondary certificates
 */
model X509Certificates {
  /**
   * Certificate and Certificate info
   */
  primary?: X509CertificateWithInfo;

  /**
   * Certificate and Certificate info
   */
  secondary?: X509CertificateWithInfo;
}

/**
 * Certificate and Certificate info
 */
model X509CertificateWithInfo {
  /** PEM-formatted certificate string. */
  certificate?: string;

  /**
   * X509 certificate info.
   */
  info?: X509CertificateInfo;
}

/**
 * X509 certificate info.
 */
model X509CertificateInfo {
  /** Subject name of the certificate. */
  subjectName: string;

  /** SHA-1 thumbprint of the certificate. */
  sha1Thumbprint: string;

  /** SHA-256 thumbprint of the certificate. */
  sha256Thumbprint: string;

  /** Issuer name of the certificate. */
  issuerName: string;

  /** Certificate validity start (UTC). */
  notBeforeUtc: utcDateTime;

  /** Certificate validity end (UTC). */
  notAfterUtc: utcDateTime;

  /** Serial number of the certificate. */
  serialNumber: string;

  /** Version of the certificate. */
  version: int32;
}

/**
 * Primary and secondary CA references.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Migration from Swagger: X509CA is an established acronym"
model X509CAReferences {
  /** Primary CA reference. */
  primary?: string;

  /** Secondary CA reference. */
  secondary?: string;
}

/**
 * Attestation via SymmetricKey.
 */
model SymmetricKeyAttestation {
  /**
   * Primary symmetric key.
   */
  primaryKey?: string;

  /**
   * Secondary symmetric key.
   */
  secondaryKey?: string;
}

/**
 * Device capabilities.
 */
model DeviceCapabilities {
  /**
   * If set to true, this device is an IoTEdge device.
   */
  iotEdge: boolean = false;
}

/**
 * Initial device twin. Contains a subset of the properties of Twin.
 */
model InitialTwin {
  /**
   * Twin tags.
   */
  tags?: TwinCollection;

  /**
   * Twin desired properties.
   */
  properties?: InitialTwinProperties;
}

/**
 * Represents the initial properties that will be set on the device twin.
 */
model InitialTwinProperties {
  /**
   * Gets and sets the InitialTwin desired properties.
   */
  desired?: TwinCollection;
}

/**
 * The behavior of the service when a device is re-provisioned to an IoT hub.
 */
model ReprovisionPolicy {
  /**
   * When set to true (default), the Device Provisioning Service will evaluate the
   * device's IoT Hub assignment and update it if necessary for any provisioning
   * requests beyond the first from a given device. If set to false, the device will
   * stay assigned to its current IoT hub.
   */
  updateHubAssignment: boolean = true;

  /**
   * When set to true (default), the Device Provisioning Service will migrate the
   * device's data (twin, device capabilities, and device ID) from one IoT hub to
   * another during an IoT hub assignment update. If set to false, the Device
   * Provisioning Service will reset the device's data to the initial desired
   * configuration stored in the corresponding enrollment list.
   */
  migrateDeviceData: boolean = true;
}

/**
 * This tells DPS which webhook to call when using custom allocation.
 */
model CustomAllocationDefinition {
  /**
   * The webhook URL used for allocation requests.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Version-scoped property using remove/rename/add pattern for version-specific constraints"
  @removed(Versions.v2025_07_01_preview)
  @renamedFrom(Versions.v2025_07_01_preview, "webhookUrl")
  webhookUrl_v2021_10_01: string;

  /**
   * The webhook URL used for allocation requests.
   */
  @added(Versions.v2025_07_01_preview)
  @minLength(1)
  webhookUrl: string;

  /**
   * The API version of the provisioning service types (such as
   * IndividualEnrollment) sent in the custom allocation request. Minimum supported
   * version: "2018-09-01-preview".
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Version-scoped property using remove/rename/add pattern for version-specific constraints"
  @removed(Versions.v2025_07_01_preview)
  @renamedFrom(Versions.v2025_07_01_preview, "apiVersion")
  apiVersion_v2021_10_01: string;

  /**
   * The API version of the provisioning service types (such as
   * IndividualEnrollment) sent in the custom allocation request. Minimum supported
   * version: "2018-09-01-preview".
   */
  @added(Versions.v2025_07_01_preview)
  @minLength(1)
  apiVersion: string;
}

/**
 * Contains the properties of an error returned by the Azure IoT Hub Provisioning
 * Service.
 */
@error
model ProvisioningServiceErrorDetails {
  @header("x-ms-error-code")
  @doc("The error code for specific error that occurred.")
  xMsErrorCode?: string;

  /** Error code for the operation. */
  errorCode?: int32;

  /** Tracking ID for the error. */
  trackingId?: string;

  /** Human-readable error message. */
  message?: string;

  /**
   * Dictionary of <string>
   */
  info?: Record<string>;

  /** UTC timestamp of the error. */
  timestampUtc?: utcDateTime;
}

/**
 * Response model for query operations that includes pagination headers.
 */
model QueryResponse<T extends {}> {
  @statusCode _: 200;

  @header("x-ms-continuation")
  @doc("The continuation token for getting the next page of results.")
  xMsContinuation?: string;

  @header("x-ms-max-item-count")
  @doc("The maximum number of items returned in a page.")
  xMsMaxItemCount?: int64;

  @header("x-ms-item-type")
  @doc("The list of values returned from the query.")
  xMsItemType?: string;

  @body body: T[];
}

/**
 * Enrollment group record.
 */
model EnrollmentGroup {
  /**
   * Enrollment Group ID.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Version-scoped property using remove/rename/add pattern for version-specific constraints"
  @removed(Versions.v2025_07_01_preview)
  @renamedFrom(Versions.v2025_07_01_preview, "enrollmentGroupId")
  enrollmentGroupId_v2021_10_01: string;

  /**
   * Enrollment Group ID.
   */
  @added(Versions.v2025_07_01_preview)
  @minLength(1)
  enrollmentGroupId: string;

  /**
   * Attestation method used by the device.
   */
  attestation: AttestationMechanism;

  /**
   * Capabilities of the device.
   */
  capabilities?: DeviceCapabilities;

  /**
   * The Iot Hub host name.
   */
  iotHubHostName?: string;

  /**
   * Linked Azure Device Registry credential policy name (optional).
   */
  @added(Versions.v2025_07_01_preview)
  credentialPolicyName?: string;

  /**
   * Initial device twin.
   */
  initialTwin?: InitialTwin;

  /**
   * The entity tag associated with the resource.
   */
  etag?: string;

  /**
   * The provisioning status.
   */
  provisioningStatus?: ProvisioningStatus = ProvisioningStatus.enabled;

  /**
   * The behavior when a device is re-provisioned to an IoT hub.
   */
  reprovisionPolicy?: ReprovisionPolicy;

  /**
   * The DateTime this resource was created.
   */
  @visibility(Lifecycle.Read)
  createdDateTimeUtc?: utcDateTime;

  /**
   * The DateTime this resource was last updated.
   */
  @visibility(Lifecycle.Read)
  lastUpdatedDateTimeUtc?: utcDateTime;

  /**
   * The allocation policy of this resource. This policy overrides the tenant level
   * allocation policy for this individual enrollment or enrollment group. Possible
   * values include 'hashed': Linked IoT hubs are equally likely to have devices
   * provisioned to them, 'geoLatency':  Devices are provisioned to an IoT hub with
   * the lowest latency to the device.If multiple linked IoT hubs would provide the
   * same lowest latency, the provisioning service hashes devices across those hubs,
   * 'static' : Specification of the desired IoT hub in the enrollment list takes
   * priority over the service-level allocation policy, 'custom': Devices are
   * provisioned to an IoT hub based on your own custom logic. The provisioning
   * service passes information about the device to the logic, and the logic returns
   * the desired IoT hub as well as the desired initial configuration. We recommend
   * using Azure Functions to host your logic.
   */
  allocationPolicy?: AllocationPolicy;

  /**
   * The list of IoT Hub hostnames the device(s) in this resource can be allocated
   * to. Must be a subset of tenant level list of IoT hubs.
   */
  iotHubs?: string[];

  /**
   * This tells DPS which webhook to call when using custom allocation.
   */
  customAllocationDefinition?: CustomAllocationDefinition;
}

/** Query specification for enrollment queries. */
model QuerySpecification {
  /** OData query string. */
  query: string;
}

/**
 * Bulk enrollment operation.
 */
model BulkEnrollmentOperation {
  /**
   * Enrollment items
   */
  enrollments: IndividualEnrollment[];

  /**
   * Operation mode.
   */
  mode: BulkEnrollmentMode;
}

/**
 * Results of a bulk enrollment operation
 */
model BulkEnrollmentOperationResult {
  /**
   * Registration errors
   */
  errors?: BulkEnrollmentOperationError[];

  /**
   * Indicates if the operation was successful in its entirety.
   */
  isSuccessful: boolean;
}

/**
 * Bulk enrollment operation error
 */
model BulkEnrollmentOperationError {
  /**
   * This id is used to uniquely identify a device registration of an enrollment.
   * A case-insensitive string (up to 128 characters long) of alphanumeric
   * characters plus certain special characters : . _ -. No special characters
   * allowed at start or end.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Version-scoped property using remove/rename/add pattern for version-specific constraints"
  @removed(Versions.v2025_07_01_preview)
  @renamedFrom(Versions.v2025_07_01_preview, "registrationId")
  registrationId_v2021_10_01: string;

  /**
   * This id is used to uniquely identify a device registration of an enrollment.
   * A case-insensitive string (up to 128 characters long) of alphanumeric
   * characters plus certain special characters : . _ -. No special characters
   * allowed at start or end.
   */
  @added(Versions.v2025_07_01_preview)
  @minLength(1)
  registrationId: string;

  /**
   * Error code
   */
  errorCode: int32;

  /**
   * Error status.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Version-scoped property using remove/rename/add pattern for version-specific constraints"
  @removed(Versions.v2025_07_01_preview)
  @renamedFrom(Versions.v2025_07_01_preview, "errorStatus")
  errorStatus_v2021_10_01: string;

  /**
   * Error status.
   */
  @added(Versions.v2025_07_01_preview)
  @minLength(1)
  errorStatus: string;
}

/**
 * Bulk enrollment operation.
 */
model BulkEnrollmentGroupOperation {
  /**
   * Enrollment items
   */
  enrollmentGroups: EnrollmentGroup[];

  /**
   * Operation mode.
   */
  mode: BulkEnrollmentMode;
}

/**
 * Results of a bulk enrollment group operation.
 */
model BulkEnrollmentGroupOperationResult {
  /**
   * Registration errors
   */
  errors?: BulkEnrollmentGroupOperationError[];

  /**
   * Indicates if the operation was successful in its entirety.
   */
  isSuccessful: boolean;
}

/**
 * Bulk enrollment operation error.
 */
model BulkEnrollmentGroupOperationError {
  /**
   * Enrollment group id.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Version-scoped property using remove/rename/add pattern for version-specific constraints"
  @removed(Versions.v2025_07_01_preview)
  @renamedFrom(Versions.v2025_07_01_preview, "enrollmentGroupId")
  enrollmentGroupId_v2021_10_01: string;

  /**
   * Enrollment group id.
   */
  @added(Versions.v2025_07_01_preview)
  @minLength(1)
  enrollmentGroupId: string;

  /**
   * Error code
   */
  errorCode: int32;

  /**
   * Error status.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Version-scoped property using remove/rename/add pattern for version-specific constraints"
  @removed(Versions.v2025_07_01_preview)
  @renamedFrom(Versions.v2025_07_01_preview, "errorStatus")
  errorStatus_v2021_10_01: string;

  /**
   * Error status.
   */
  @added(Versions.v2025_07_01_preview)
  @minLength(1)
  errorStatus: string;
}
