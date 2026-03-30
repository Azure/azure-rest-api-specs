import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace ProvisioningDeviceClient;

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
 * 200 OK response for LRO operations returning RegistrationOperationStatus.
 */
model RegistrationOperationStatus200 {
  @statusCode _: 200;
  @body body: RegistrationOperationStatus;
}

/**
 * 202 Accepted response for LRO operations returning RegistrationOperationStatus.
 */
model RegistrationOperationStatus202 {
  @statusCode _: 202;

  /** The retry interval in seconds. */
  @header("retry-after")
  retryAfter?: int32;

  /** The location of the resource. */
  @header("Location")
  location?: string;

  @body body: RegistrationOperationStatus;
}

/**
 * Registration operation status.
 */
model RegistrationOperationStatus {
  /**
   * Operation ID.
   */
  @minLength(1)
  operationId: string;

  /**
   * Device enrollment status.
   */
  status?: EnrollmentStatus;

  /**
   * Device registration result.
   */
  registrationState?: DeviceRegistrationResult;
}

/**
 * Device registration result.
 */
model DeviceRegistrationResult {
  /**
   * TPM registration result.
   */
  tpm?: TpmRegistrationResult;

  /**
   * X509 registration result.
   */
  x509?: X509RegistrationResult;

  /**
   * Registration result returned when using SymmetricKey attestation.
   */
  symmetricKey?: SymmetricKeyRegistrationResult;

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
   * Any object
   */
  @visibility(Lifecycle.Read)
  payload?: Record<unknown>;

  /**
   * An array containing the full certificate chain for the issued certificate.
   * The first element is the issued leaf certificate, followed by any intermediate
   * certification authorities (ICAs), and ending with the root certification authority (CA).
   * Each certificate in the array is the issuer of the previous certificate.
   * This property is not included in responses for the
   * RuntimeRegistration_DeviceRegistrationStatusLookup operation.
   */
  @added(Versions.v2025_07_01_preview)
  @visibility(Lifecycle.Read)
  issuedCertificateChain?: bytes[];
}

/**
 * TPM registration result.
 */
model TpmRegistrationResult {
  /**
   * Encrypted authentication key.
   */
  authenticationKey?: string;
}

/**
 * X509 registration result.
 */
model X509RegistrationResult {
  /**
   * X509 certificate info.
   */
  certificateInfo?: X509CertificateInfo;

  enrollmentGroupId?: string;

  /**
   * X509 certificate info.
   */
  signingCertificateInfo?: X509CertificateInfo;
}

/**
 * X509 certificate info.
 */
model X509CertificateInfo {
  subjectName: string;
  sha1Thumbprint: string;
  sha256Thumbprint: string;
  issuerName: string;

  notBeforeUtc: utcDateTime;

  notAfterUtc: utcDateTime;

  serialNumber: string;
  version: int32;
}

/**
 * Registration result returned when using SymmetricKey attestation.
 */
model SymmetricKeyRegistrationResult {
  enrollmentGroupId?: string;
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

  errorCode?: int32;
  trackingId?: string;
  message?: string;

  /**
   * Dictionary of <string>
   */
  info?: Record<string>;

  timestampUtc?: utcDateTime;
}

/**
 * Device registration.
 */
model DeviceRegistration {
  /**
   * The registration ID is a case-insensitive string (up to 128 characters long) of
   * alphanumeric characters plus certain special characters : . _ -. No special
   * characters allowed at start or end.
   */
  registrationId?: string;

  /**
   * Attestation via TPM.
   */
  tpm?: TpmAttestation;

  /**
   * A Base64-encoded DER certificate signing request (CSR) in PKCS #10 format,
   * excluding PEM headers and footers. The Common Name (CN) must match the device
   * registrationId. Including this field in the
   * RuntimeRegistration_DeviceRegistrationStatusLookup operation will result in
   * a bad request.
   */
  @added(Versions.v2025_07_01_preview)
  csr?: string;

  /**
   * Any object
   */
  payload?: Record<unknown>;
}

/**
 * Attestation via TPM.
 */
model TpmAttestation {
  endorsementKey: string;
  storageRootKey?: string;
}
