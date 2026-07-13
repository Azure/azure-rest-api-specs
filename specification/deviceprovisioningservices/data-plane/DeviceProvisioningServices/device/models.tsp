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

  /**
   * Attestation via TPM. Present only for TPM-attested devices, mirroring the
   * Register (DeviceRegistration) request; X.509 and symmetric-key attestation are
   * carried at the transport layer (TLS client certificate / SAS token) and are not
   * part of the request body. Auth is enforced per action, so this parity affordance
   * is present on every device-facing request.
   */
  tpm?: TpmAttestation;

  /** The update the device attempted to install, if any. */
  installedUpdateId?: UpdateId | null;

  /** The terminal result of the installation. */
  lastInstallResult: LastInstallResult;
}

/**
 * Terminal outcome of an update attempt or step. Mirrors the ADU `Outcome` enum;
 * modeled as an extensible union so ADU can add outcomes without a breaking change.
 */
@added(Versions.v2026_11_15_preview)
union Outcome {
  string,

  /** The attempt succeeded. */
  Succeeded: "SUCCEEDED",

  /** The attempt failed. */
  Failed: "FAILED",

  /** The attempt was canceled. */
  Canceled: "CANCELED",

  /** The attempt was skipped. */
  Skipped: "SKIPPED",
}

/**
 * Best-effort attestation of which subsystem produced a failure. Advisory only.
 * Mirrors the ADU `FailureOrigin` enum; extensible union for forward-compat.
 */
@added(Versions.v2026_11_15_preview)
union FailureOrigin {
  string,

  /** No failure, or origin not applicable. */
  NotApplicable: "NOT_APPLICABLE",

  /** The ADU cloud service. */
  AduCloudService: "ADU_CLOUD_SERVICE",

  /** An ADU-managed resource. */
  AduManagedResource: "ADU_MANAGED_RESOURCE",

  /** The device agent core. */
  AgentCore: "AGENT_CORE",

  /** An agent extension. */
  AgentExtension: "AGENT_EXTENSION",

  /** An agent dependency. */
  AgentDependency: "AGENT_DEPENDENCY",

  /** The device itself. */
  Device: "DEVICE",

  /** Some other origin. */
  Other: "OTHER",
}

/**
 * Per-step terminal result. Mirrors the ADU `StepResult` model.
 */
@added(Versions.v2026_11_15_preview)
model StepResult {
  /** Terminal outcome of this step. */
  outcome: Outcome;

  /** Which subsystem produced a failure. Advisory only. */
  failureOrigin: FailureOrigin;

  /** A positive value indicates success; a non-positive value indicates failure. Diagnostic only. */
  resultCode: int64;

  /** Comma-separated unsigned hexadecimal int32 codes for diagnostic correlation. Opaque to the service. */
  @maxLength(1024)
  extendedResultCodes: string;

  /** Human-readable diagnostic detail. Not parsed programmatically. */
  @maxLength(1024)
  resultDetails?: string;
}

/**
 * Terminal install result. Mirrors the ADU `InstallResult` model: the top-level
 * step fields (spread from `StepResult`) plus an optional per-step breakdown.
 */
@added(Versions.v2026_11_15_preview)
model LastInstallResult {
  ...StepResult;

  /**
   * Per-step outcomes, keyed `step_0`, `step_1`, …. May be omitted on success;
   * should be present on failure. Typed per the ADU contract (values are `StepResult`).
   */
  stepResults?: Record<StepResult>;
}

/**
 * Result of a reportDeviceUpdateStatus call. Empty in this preview; fields may be
 * added later.
 */
@added(Versions.v2026_11_15_preview)
model ReportDeviceUpdateStatusResult {}
