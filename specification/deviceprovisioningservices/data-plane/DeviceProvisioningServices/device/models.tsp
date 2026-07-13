import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";

using Azure.Core;
using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace ProvisioningDeviceClient;

/**
 * Enrollment status.
 */
@lroStatus
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
  @lroSucceeded
  assigned: "assigned",

  /**
   * failed
   */
  @lroFailed
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
  @lroStatus
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
  @lroStatus
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
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "payload is an open JSON object per API contract"
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

  /** Enrollment group ID. */
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
  /** Certificate subject name. */
  subjectName: string;

  /** SHA-1 thumbprint of the certificate. */
  sha1Thumbprint: string;

  /** SHA-256 thumbprint of the certificate. */
  sha256Thumbprint: string;

  /** Certificate issuer name. */
  issuerName: string;

  /** Certificate validity start date (UTC). */
  notBeforeUtc: utcDateTime;

  /** Certificate expiry date (UTC). */
  notAfterUtc: utcDateTime;

  /** Certificate serial number. */
  serialNumber: string;

  /** Certificate version. */
  version: int32;
}

/**
 * Registration result returned when using SymmetricKey attestation.
 */
model SymmetricKeyRegistrationResult {
  /** Enrollment group ID. */
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

  /** Numeric error code. */
  errorCode?: int32;

  /** Error tracking ID. */
  trackingId?: string;

  /** Error message. */
  message?: string;

  /**
   * Dictionary of <string>
   */
  info?: Record<string>;

  /** Error timestamp (UTC). */
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
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "payload is an open JSON object per API contract"
  payload?: Record<unknown>;
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

// =============================================================================
//  ADU device-facing update integration (first-time / onboarding update)
//  Added in 2026-11-15-preview. DRAFT — mirrors the ADU device contract
//  (onboarding-api.tsp / onboarding-api-design.md). DPS is a thin pass-through
//  to ADR (which forwards to ADU) and does not parse the update manifest.
// =============================================================================

/**
 * Request body for a device update check (both the regular/operational and the
 * onboarding/bootstrap fetch operations share this shape).
 */
@added(Versions.v2026_11_15_preview)
model UpdateCheckRequest {
  /** Information describing the ADU agent making the request. */
  agentInfo: AgentInfo;

  /**
   * Attestation via TPM. Present only for TPM-attested devices, mirroring the
   * Register (DeviceRegistration) request; X.509 and symmetric-key attestation are
   * carried at the transport layer (TLS client certificate / SAS token) and are not
   * part of the request body, exactly as in Register.
   */
  tpm?: TpmAttestation;

  /** The update currently installed on the device, if any. */
  installedUpdateId?: UpdateId | null;

  /**
   * ETag of the last agentInfo the service observed, used by the service to skip
   * redundant processing. Optional.
   */
  agentInfoETag?: string;

  /**
   * ETag of the serviceConfiguration the device currently holds, used by the
   * service to omit unchanged configuration. Optional.
   */
  serviceConfigETag?: string;
}

/**
 * Information describing the ADU agent and the device it runs on, used to match
 * the device to an applicable update.
 */
@added(Versions.v2026_11_15_preview)
model AgentInfo {
  /** Version of the ADU agent SDK on the device. */
  agentSdkVersion: string;

  /** ADU agent profile identifier. */
  agentProfile: int32;

  /** Device compatibility properties (for example manufacturer and model). */
  compatibilityProperties: Record<string>;
}

/**
 * Identifies a specific update by provider, name, and version.
 */
@added(Versions.v2026_11_15_preview)
model UpdateId {
  /** Update provider. */
  provider: string;

  /** Update name. */
  name: string;

  /** Update version. */
  version: string;
}

/**
 * Response body for a device update check. When an update applies, updateMetadata
 * is present; "no update available" is signaled by omitting updateMetadata.
 */
@added(Versions.v2026_11_15_preview)
model UpdateCheckResponse {
  /** Device service configuration returned on every response. */
  serviceConfiguration: ServiceConfiguration;

  /** ETag of the returned serviceConfiguration. */
  serviceConfigETag?: string;

  /** ETag the device should echo on its next request in agentInfoETag. */
  agentInfoETag?: string;

  /** Present only when an update applies to the device; omitted otherwise. */
  updateMetadata?: UpdateMetadata;
}

/**
 * Device service configuration returned by an update check.
 */
@added(Versions.v2026_11_15_preview)
model ServiceConfiguration {
  /** URL from which the device fetches ADU root keys for signature validation. */
  rootKeyDownloadUrl?: url;
}

/**
 * Metadata describing an available update. The manifest is opaque to DPS.
 */
@added(Versions.v2026_11_15_preview)
model UpdateMetadata {
  /** Opaque deployment identifier; echoed by the device on reportDeviceUpdateStatus. */
  workflowId: string;

  /** Opaque update manifest string. DPS does not parse this value. */
  updateManifest: string;

  /** JWS signature over the update manifest. */
  updateManifestSignature: string;

  /** URLs of the payload files that make up the update. */
  fileUrls: url[];
}

/**
 * Request body reporting the terminal result of an update installation.
 */
@added(Versions.v2026_11_15_preview)
model ReportStatusRequest {
  /** Opaque deployment identifier from updateMetadata; the idempotency and routing key. */
  workflowId: string;

  /** The update the device attempted to install, if any. */
  installedUpdateId?: UpdateId | null;

  /** The terminal result of the installation. */
  lastInstallResult: LastInstallResult;
}

/**
 * Terminal outcome of an update installation.
 */
@added(Versions.v2026_11_15_preview)
union InstallOutcome {
  string,

  /** The installation succeeded. */
  Success: "Success",

  /** The installation failed. */
  Failure: "Failure",

  /** The installation is still in progress. */
  InProgress: "InProgress",
}

/**
 * Details of the terminal result of an update installation.
 */
@added(Versions.v2026_11_15_preview)
model LastInstallResult {
  /** Terminal outcome of the installation. */
  outcome: InstallOutcome;

  /** Where the failure originated, when the outcome is a failure. */
  failureOrigin?: string;

  /** Numeric result code; positive values indicate success. */
  resultCode: int64;

  /** Colon-delimited extended result codes. Optional. */
  extendedResultCodes?: string;

  /** Human-readable result details. Optional. */
  resultDetails?: string | null;

  /**
   * Per-step installation results. Open JSON object defined by the ADU agent.
   */
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "per-step results are an open JSON object per the ADU contract"
  stepResults?: Record<unknown>;
}

/**
 * Result of a reportDeviceUpdateStatus call. Empty in this preview; fields may be
 * added later.
 */
@added(Versions.v2026_11_15_preview)
model ReportDeviceUpdateStatusResult {}
