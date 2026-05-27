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
// DeviceAuthenticationProfiles operation models
// ──────────────────────────────────────────────

/**
 * Response body for the getKeys action. Includes the standard `ETag`
 * response header so clients can issue conditional follow-up requests
 * via `If-None-Match` and avoid unnecessary key materialization on the
 * server when the underlying device authentication profile has not
 * changed.
 */
model GetDeviceAuthenticationProfileKeysResponse {
  ...Azure.Core.EtagResponseEnvelope;

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
   * Retrieve the plaintext symmetric keys of a device authentication
   * profile. Only valid when the profile's authentication type is
   * SymmetricKey; profiles of any other type return 400 with the
   * InvalidAuthenticationType error code.
   *
   * Supports the standard conditional request headers
   * (`If-Match`, `If-None-Match`, `If-Modified-Since`,
   * `If-Unmodified-Since`). Clients can pass `If-None-Match` with the
   * previously-observed profile ETag to receive 304 Not Modified when
   * the underlying profile has not changed.
   */
  getKeys is ResourceOperations.ResourceAction<
    DeviceAuthenticationProfile,
    Azure.Core.ConditionalRequestHeaders,
    GetDeviceAuthenticationProfileKeysResponse
  >;
}
