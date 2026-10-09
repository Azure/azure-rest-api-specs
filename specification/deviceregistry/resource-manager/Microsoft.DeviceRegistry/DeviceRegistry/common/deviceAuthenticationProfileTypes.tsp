import "@azure-tools/typespec-azure-core";

namespace Microsoft.DeviceRegistry;

// ──────────────────────────────────────────────
// Shared device authentication profile types
// Shared across data-plane (DeviceRegistry.DataPlane) and
// control-plane (DeviceRegistry.Management).
// ──────────────────────────────────────────────

/** Authentication information for the device. */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Shared read-only projection: a device authentication profile has no provisioning lifecycle of its own; the control-plane only exposes read (GET/LIST)."
@discriminator("authenticationType")
model AuthenticationProfileProperties {
  /** The authentication type. */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  authenticationType: AuthenticationType;
}

/** The authentication type for IoT Hub. */
union AuthenticationType {
  string,

  /** Symmetric key authentication. */
  SymmetricKey: "SymmetricKey",

  /** Certificate authority signed X.509 certificate authentication. */
  CertificateAuthoritySignedX509Certificate: "CertificateAuthoritySignedX509Certificate",

  /** Self-signed X.509 certificate authentication. */
  SelfSignedX509Certificate: "SelfSignedX509Certificate",
}

/** Authentication information for the device. */
model SymmetricKeyAuthenticationProfileProperties
  extends AuthenticationProfileProperties {
  /** The authentication type. */
  authenticationType: AuthenticationType.SymmetricKey;

  /** Symmetric key details. Required when type is SymmetricKey. */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  symmetricKey: SymmetricKeyCredentials;
}

/** Authentication information for the device. */
model CertificateAuthorityAuthenticationProfileProperties
  extends AuthenticationProfileProperties {
  /** The authentication type. */
  authenticationType: AuthenticationType.CertificateAuthoritySignedX509Certificate;

  /** Certificate authority credentials. Required when type is CertificateAuthority. */
  certificateAuthority: CertificateAuthorityCredentials;
}

/** Authentication information for the device. */
model SelfSignedX509CertificateAuthenticationProfileProperties
  extends AuthenticationProfileProperties {
  /** The authentication type. */
  authenticationType: AuthenticationType.SelfSignedX509Certificate;

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
  certificatePolicyResourceId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.DeviceRegistry/namespaces/certificateAuthorities/certificatePolicies";
    }
  ]>;
}
