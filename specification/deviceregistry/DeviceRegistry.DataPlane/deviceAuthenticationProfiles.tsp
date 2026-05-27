import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-core";
import "./devices.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using TypeSpec.OpenAPI;
using Azure.Core;

namespace Microsoft.DeviceRegistry;

// ──────────────────────────────────────────────
// Device authentication resource
// ──────────────────────────────────────────────

/** A device authentication resource. */
@resource("authenticationProfiles")
@parentResource(Device)
model DeviceAuthenticationProfile {
  ...DataPlaneResourceBase;

  /** Authentication information for the device. */
  properties?: AuthenticationProfileProperties;
}

@@key(DeviceAuthenticationProfile.name, "authenticationProfileName");

/** Authentication information for the device. */
@discriminator("type")
model AuthenticationProfileProperties {
  /** The authentication type. */
  type: AuthenticationType;
}

/** The authentication type for IoT Hub. */
union AuthenticationType {
  string,

  /** Symmetric key authentication. */
  SymmetricKey: "SymmetricKey",

  /** Certificate authority authentication. */
  CertificateAuthority: "CertificateAuthority",

  /** Self-signed X.509 certificate authentication. */
  SelfSignedX509Certificate: "SelfSignedX509Certificate",
}

/** Authentication information for the device. */
model SymmetricKeyAuthenticationProfileProperties
  extends AuthenticationProfileProperties {
  /** The authentication type. */
  type: AuthenticationType.SymmetricKey;

  /** Symmetric key details. Required when type is SymmetricKey. */
  symmetricKey: SymmetricKeyCredentials;
}

/** Authentication information for the device. */
model CertificateAuthorityAuthenticationProfileProperties
  extends AuthenticationProfileProperties {
  /** The authentication type. */
  type: AuthenticationType.CertificateAuthority;

  /** Certificate authority credentials. Required when type is CertificateAuthority. */
  certificateAuthority: CertificateAuthorityCredentials;
}

/** Authentication information for the device. */
model SelfSignedX509CertificateAuthenticationProfileProperties
  extends AuthenticationProfileProperties {
  /** The authentication type. */
  type: AuthenticationType.SelfSignedX509Certificate;

  /** Self-signed X.509 thumbprints. Required when type is SelfSignedX509Certificate. */
  selfSignedThumbprints: SelfSignedThumbprints;
}

/** Symmetric key authentication details. */
model SymmetricKeyCredentials {
  /** The primary symmetric key. */
  @secret
  primaryKey: string;

  /** The secondary symmetric key. */
  @secret
  secondaryKey: string;
}

/** Self-signed X.509 certificate thumbprints for device authentication. */
model SelfSignedThumbprints {
  /** Primary certificate thumbprint. */
  primaryThumbprint: string;

  /** Secondary certificate thumbprint. */
  secondaryThumbprint: string;
}

/** Certificate authority credentials for device provisioning. */
model CertificateAuthorityCredentials {
  /** ADR certificate policy resource ID. */
  adrCertificatePolicyResourceId: string;
}

// ──────────────────────────────────────────────
// Revoke cert action models
// ──────────────────────────────────────────────

/** Request payload for the `:revokeCerts` action. */
model RevokeCertsRequest {}

// ──────────────────────────────────────────────
// Certificate issuance action models
// ──────────────────────────────────────────────

/** Certificate issuance request. */
model CertificateIssuanceRequest {
  /**
   * Base64-encoded DER certificate signing request (CSR) without PEM
   * headers and footers. Format of the CSR is in PKCS 10. The CN field of
   * the CSR must be set to the device name.
   */
  csr: bytes;
}

/**
 * The full chain of the issued certificate, including any intermediate
 * certification authorities (ICAs) and the root certification authority
 * (CA). The first certificate in the list is the issued leaf certificate.
 * Each subsequent certificate is the issuer of the previous.
 */
model IssuedCertificateChain is bytes[];

/** Certificate issuance result. */
model CertificateIssuanceResult {
  /** The full chain of the issued certificate. */
  @visibility(Lifecycle.Read)
  issuedCertificateChain: IssuedCertificateChain;
}

// ──────────────────────────────────────────────
// Issue-cert status monitor endpoint
// ──────────────────────────────────────────────

/** Status monitor for the long-running `:issueCert` action on a device authentication profile. */
@parentResource(DeviceAuthenticationProfile)
@resource("issueCertResults")
model IssueCertResult {
  /** The unique ID of the operation. */
  @key("operationId")
  @visibility(Lifecycle.Read)
  id: string;

  /** The status of the operation. */
  @Azure.Core.lroStatus
  @visibility(Lifecycle.Read)
  status: Azure.Core.Foundations.OperationState;

  /** Error object that describes the error when status is "Failed". */
  @visibility(Lifecycle.Read)
  error?: Azure.Core.Foundations.Error;

  /** The result of the certificate issuance, available once `status` is `Succeeded`. */
  @visibility(Lifecycle.Read)
  result?: CertificateIssuanceResult;
}

/**
 * 202 Accepted response shape for long-running operations on device authentication
 * profiles (`:issueCert`, `:revokeCerts`). Carries only operation state; any
 * operation payload (e.g. the issued certificate chain) is delivered by the
 * dedicated polling GET on the corresponding `*Results` status monitor endpoint.
 */
model OperationAcceptedResponse {
  /** The unique ID of the operation. */
  id: string;

  /** The status of the operation. */
  @Azure.Core.lroStatus
  status: Azure.Core.Foundations.OperationState;

  /** Error object that describes the error when status is "Failed". */
  error?: Azure.Core.Foundations.Error;
}

// ──────────────────────────────────────────────
// Revoke-cert status monitor endpoint
// ──────────────────────────────────────────────

/**
 * Status monitor for the long-running `:revokeCerts` action on a device authentication
 * profile. The operation has no payload to return on success; `status` carries the
 * outcome and `error` carries failure details.
 */
@parentResource(DeviceAuthenticationProfile)
@resource("revokeCertsResults")
model RevokeCertsResult {
  /** The unique ID of the operation. */
  @key("operationId")
  @visibility(Lifecycle.Read)
  id: string;

  /** The status of the operation. */
  @Azure.Core.lroStatus
  @visibility(Lifecycle.Read)
  status: Azure.Core.Foundations.OperationState;

  /** Error object that describes the error when status is "Failed". */
  @visibility(Lifecycle.Read)
  error?: Azure.Core.Foundations.Error;
}

// ──────────────────────────────────────────────
// DeviceAuthenticationProfiles interface
// ──────────────────────────────────────────────

/** CRUD operations on device authentication profiles. */
@tag("Device Authentication Profiles")
interface DeviceAuthenticationProfiles {
  /** Create or replace a device authentication profile. */
  createOrReplace is ResourceOperations.ResourceCreateOrReplace<DeviceAuthenticationProfile>;

  /** Get a device authentication profile. */
  get is ResourceOperations.ResourceRead<DeviceAuthenticationProfile>;

  /** Update a device authentication profile. */
  update is ResourceOperations.ResourceCreateOrUpdate<DeviceAuthenticationProfile>;

  /** Delete a device authentication profile. */
  delete is ResourceOperations.ResourceDelete<DeviceAuthenticationProfile>;

  /** List authentication profiles for a device. */
  list is ResourceOperations.ResourceList<DeviceAuthenticationProfile>;

  /**
   * Issue an operational X.509 certificate for the device. The certificate is
   * signed using the certificate authority policy bound to this authentication
   * profile. Applies to Microsoft-managed X.509 authentication profiles. The
   * issued certificate chain is delivered by the GET on the corresponding
   * `issueCertResults` status monitor endpoint, not on this 202 response.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom LRO: 202 Accepted response intentionally omits 'result'. The issued certificate chain is delivered by the dedicated GET issueCertResults polling endpoint."
  @route("/namespaces/{namespaceUuid}/devices/{deviceName}/authenticationProfiles/{authenticationProfileName}:issueCert")
  @post
  @pollingOperation(IssueCertResults.get)
  issueCert(
    ...Azure.Core.Foundations.ApiVersionParameter,

    /** The unique identifier of the namespace. */
    @path namespaceUuid: string,

    /** The name of the device. */
    @path deviceName: string,

    /** The name of the authentication profile. */
    @path authenticationProfileName: string,

    /** Certificate issuance request. */
    @body body: CertificateIssuanceRequest,
  ): {
    @statusCode statusCode: 202;

    /** The location for monitoring the operation state. */
    @header("Operation-Location") operationLocation: url;

    ...OperationAcceptedResponse;
  } | Azure.Core.Foundations.ErrorResponse;

  /**
   * Revoke certificates issued for the device authentication profile. Applies to
   * Microsoft-managed X.509 certificates: invalidates outstanding certificates
   * via the PKI revocation list. The authentication profile itself is preserved.
   * The 202 carries only operation state; status is polled via the dedicated GET
   * on the corresponding `revokeCertsResults` status monitor endpoint.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom LRO: 202 Accepted response carries no payload. Operation state is polled via the dedicated GET revokeCertsResults status monitor endpoint."
  @route("/namespaces/{namespaceUuid}/devices/{deviceName}/authenticationProfiles/{authenticationProfileName}:revokeCerts")
  @post
  @pollingOperation(RevokeCertsResults.get)
  revokeCerts(
    ...Azure.Core.Foundations.ApiVersionParameter,

    /** The unique identifier of the namespace. */
    @path namespaceUuid: string,

    /** The name of the device. */
    @path deviceName: string,

    /** The name of the authentication profile. */
    @path authenticationProfileName: string,

    /** Revoke certificates request body. Currently has no required fields; reserved for future. */
    @body body?: RevokeCertsRequest,
  ): {
    @statusCode statusCode: 202;

    /** The location for monitoring the operation state. */
    @header("Operation-Location") operationLocation: url;

    ...OperationAcceptedResponse;
  } | Azure.Core.Foundations.ErrorResponse;
}

/** Polling operations for the long-running `:issueCert` action. */
@tag("Device Authentication Profiles")
interface IssueCertResults {
  /** Get the status of a long-running `:issueCert` operation. */
  get is ResourceOperations.ResourceRead<IssueCertResult>;
}

/** Polling operations for the long-running `:revokeCerts` action. */
@tag("Device Authentication Profiles")
interface RevokeCertsResults {
  /** Get the status of a long-running `:revokeCerts` operation. */
  get is ResourceOperations.ResourceRead<RevokeCertsResult>;
}
