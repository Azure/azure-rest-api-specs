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
}
