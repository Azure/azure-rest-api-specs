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

  /** Certificate authority authentication.
      TODO: Change to "X509Certificate" */
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
// Shared action parameters
// ──────────────────────────────────────────────

/**
 * Shared parameter model carrying the optional client-supplied
 * `Operation-Id` request header used by the `:issueCert` and
 * `:revokeCerts` long-running actions. If omitted, the service
 * generates a GUID.
 */
model OperationIdHeaderParameter {
  /**
   * Optional client-supplied identifier for the operation's status monitor.
   * If omitted, the service generates a GUID.
   */
  @header("Operation-Id")
  operationId?: string;
}

// ──────────────────────────────────────────────
// Certificate issuance action models
// ──────────────────────────────────────────────

/** Certificate issuance request. */
model CertificateIssuanceRequest {
  /**
   * Base64-encoded DER certificate signing request (CSR) without PEM
   * headers and footers. Format of the CSR is in PKCS 10. The CN field of
   * the CSR must be set to the device's external device id (registrationId).
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
// DeviceAuthenticationProfiles operation models
// ──────────────────────────────────────────────

/**
 * Response body for the getKeys action.
 */
model GetDeviceAuthenticationProfileKeysResponse {
  /** Plaintext symmetric keys for the device authentication profile. */
  symmetricKey: SymmetricKeyCredentials;
}

// ──────────────────────────────────────────────
// DeviceAuthenticationProfiles interface
// ──────────────────────────────────────────────

/** CRUD operations on device authentication profiles. */
@tag("Device Authentication Profiles")
interface DeviceAuthenticationProfiles {
  /** Create or replace a device authentication profile. */
  @added(Versions.v2026_11_02_preview) // Private Preview (Internal) at Ignite
  createOrReplace is ResourceOperations.ResourceCreateOrReplace<DeviceAuthenticationProfile>;

  /** Get a device authentication profile. */
  get is ResourceOperations.ResourceRead<DeviceAuthenticationProfile>;

  /** Update a device authentication profile. */
  @added(Versions.v2026_11_02_preview) // Private Preview (Internal) at Ignite
  update is ResourceOperations.ResourceCreateOrUpdate<DeviceAuthenticationProfile>;

  /** Delete a device authentication profile. */
  @added(Versions.v2026_11_02_preview) // Private Preview (Internal) at Ignite
  delete is ResourceOperations.ResourceDelete<DeviceAuthenticationProfile>;

  /** List authentication profiles for a device. */
  list is ResourceOperations.ResourceList<DeviceAuthenticationProfile>;

  /**
   * Retrieve the plaintext symmetric keys of a device authentication
   * profile. Only valid when the profile's authentication type is
   * SymmetricKey; profiles of any other type return 400 with the
   * InvalidAuthenticationType error code.
   */
  getKeys is ResourceOperations.ResourceAction<
    DeviceAuthenticationProfile,
    {},
    GetDeviceAuthenticationProfileKeysResponse
  >;

  /**
   * Issue an operational X.509 certificate for the device. The certificate is
   * signed using the certificate authority policy bound to this authentication
   * profile. Applies to Microsoft-managed X.509 authentication profiles. The
   * issued certificate chain is delivered by the GET on the corresponding
   * `issueCertResults` status monitor endpoint.
   */
  @added(Versions.v2026_11_02_preview) // Private Preview (Internal) at Ignite
  @pollingOperation(IssueCertResults.get)
  issueCert is ResourceOperations.LongRunningResourceAction<
    DeviceAuthenticationProfile,
    CertificateIssuanceRequest & OperationIdHeaderParameter,
    {}
  >;

  /**
   * Revoke certificates issued for the device authentication profile. Applies to
   * Microsoft-managed X.509 certificates: invalidates outstanding certificates
   * via the PKI revocation list. The authentication profile itself is preserved.
   * Status is polled via the dedicated GET on the corresponding
   * `revokeCertsResults` status monitor endpoint.
   */
  @pollingOperation(RevokeCertsResults.get)
  revokeCerts is ResourceOperations.LongRunningResourceAction<
    DeviceAuthenticationProfile,
    OperationIdHeaderParameter,
    {}
  >;
}

/** Polling operations for the long-running `:issueCert` action. */
@tag("Device Authentication Profiles")
interface IssueCertResults {
  /** Get the status of a long-running `:issueCert` operation. */
  @added(Versions.v2026_11_02_preview) // Private Preview (Internal) at Ignite
  get is ResourceOperations.ResourceRead<IssueCertResult>;
}

/** Polling operations for the long-running `:revokeCerts` action. */
@tag("Device Authentication Profiles")
interface RevokeCertsResults {
  /** Get the status of a long-running `:revokeCerts` operation. */
  get is ResourceOperations.ResourceRead<RevokeCertsResult>;
}
