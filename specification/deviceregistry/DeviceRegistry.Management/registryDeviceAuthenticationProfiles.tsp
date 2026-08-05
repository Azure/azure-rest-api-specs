import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./registryDevices.tsp";
import "../common/deviceAuthenticationProfileTypes.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.DeviceRegistry;

// ──────────────────────────────────────────────
// Device authentication profile resource (control-plane proxy resource)
// Shared types are defined in
// specification/deviceregistry/common/deviceAuthenticationProfileTypes.tsp.
// ──────────────────────────────────────────────

@added(Versions.v2026_11_02_preview)
@parentResource(RegistryDevice)
@doc("""
  A device authentication profile resource defines how a device authenticates to cloud services such
  as IoT Hub and Device Update. Supported authentication types include symmetric key and X.509 certificate
  authentication.
  """)
model RegistryDeviceAuthenticationProfile
  is ProxyResource<AuthenticationProfileProperties> {
  @doc("The name of the device authentication profile.")
  @key("authenticationProfileName")
  @segment("authenticationProfiles")
  @pattern("^[0-9a-zA-Z][a-zA-Z0-9-]*$")
  @path
  @minLength(3)
  @maxLength(63)
  name: string;
}

@@added(AuthenticationProfileProperties, Versions.v2026_11_02_preview);
@@added(AuthenticationType, Versions.v2026_11_02_preview);
@@added(
  SymmetricKeyAuthenticationProfileProperties,
  Versions.v2026_11_02_preview
);
@@added(
  CertificateAuthorityAuthenticationProfileProperties,
  Versions.v2026_11_02_preview
);
@@added(SelfSignedX509CertificateAuthenticationProfileProperties, Versions.v2026_11_02_preview);
@@added(SymmetricKeyCredentials, Versions.v2026_11_02_preview);
@@added(SelfSignedThumbprints, Versions.v2026_11_02_preview);
@@added(CertificateAuthorityCredentials, Versions.v2026_11_02_preview);

// ──────────────────────────────────────────────
// RegistryDeviceAuthenticationProfiles operation models
// ──────────────────────────────────────────────

@added(Versions.v2026_11_02_preview)
@doc("Response body for the getKeys action.")
model GetDeviceAuthenticationProfileKeysResponse {
  @doc("Plaintext symmetric keys for the device authentication profile.")
  symmetricKey: SymmetricKeyCredentials;
}

@added(Versions.v2026_11_02_preview)
@armResourceOperations
interface RegistryDeviceAuthenticationProfiles {
  get is ArmResourceRead<RegistryDeviceAuthenticationProfile>;
  listByDevice is ArmResourceListByParent<RegistryDeviceAuthenticationProfile>;

  @doc("""
    Retrieve the plaintext symmetric keys of a device authentication profile. Only valid when the
    profile's authentication type is SymmetricKey; profiles of any other type return 400 with the
    InvalidAuthenticationType error code.
    """)
  getKeys is ArmResourceActionSync<
    RegistryDeviceAuthenticationProfile,
    void,
    GetDeviceAuthenticationProfileKeysResponse
  >;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "The final response has no content, so 204 is returned."
  @doc("""
    Revoke certificates issued for the device authentication profile. Applies to Microsoft-managed
    X.509 certificates: invalidates outstanding certificates via the PKI revocation list. The
    authentication profile itself is preserved.
    """)
  revokeCertificates is ArmResourceActionNoContentAsync<
    RegistryDeviceAuthenticationProfile,
    void
  >;
}
