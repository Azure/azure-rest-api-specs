import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./common/extendedLocation.tsp";
import "./common/provisioningState.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.DeviceRegistry;

@doc("Asset Endpoint Profile definition.")
model AssetEndpointProfile is TrackedResource<AssetEndpointProfileProperties> {
  @doc("Asset Endpoint Profile name parameter.")
  @key("assetEndpointProfileName")
  @segment("assetEndpointProfiles")
  @pattern("^[a-z0-9][a-z0-9-]*[a-z0-9]$")
  @path
  @minLength(3)
  @maxLength(63)
  name: string;

  // Extended location is not included in TrackedResource yet
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @doc("The extended location.")
  @visibility("read", "create")
  extendedLocation: ExtendedLocation;
}

@doc("Defines the Asset Endpoint Profile properties.")
model AssetEndpointProfileProperties {
  @doc("Globally unique, immutable, non-reusable id.")
  @visibility("read")
  uuid?: string;

  @doc("The local valid URI specifying the network address/DNS name of a southbound device. The scheme part of the targetAddress URI specifies the type of the device. The additionalConfiguration field holds further connector type specific configuration.")
  targetAddress: url;

  @doc("Defines the client authentication mechanism to the server.")
  userAuthentication?: UserAuthentication;

  @doc("Defines the authentication mechanism for the southbound connector connecting to the shop floor/OT device.")
  transportAuthentication?: TransportAuthentication;

  @doc("Contains connectivity type specific further configuration (e.g. OPC UA, Modbus, ONVIF).")
  additionalConfiguration?: string;

  @doc("Provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("Definition of the client authentication mechanism to the server.")
model UserAuthentication {
  @doc("Defines the mode to authenticate the user of the client at the server.")
  // Default mode is Certificate
  mode: UserAuthenticationMode = UserAuthenticationMode.Certificate;

  @doc("Defines the username and password references when UsernamePassword user authentication mode is selected.")
  usernamePasswordCredentials?: UsernamePasswordCredentials;

  @doc("Defines the certificate reference when Certificate user authentication mode is selected.")
  x509Credentials?: X509Credentials;
}

@doc("The mode to authenticate the user of the client at the server.")
union UserAuthenticationMode {
  string,

  @doc("The user authentication mode is anonymous.")
  Anonymous: "Anonymous",

  @doc("The user authentication mode is an x509 certificate.")
  Certificate: "Certificate",

  @doc("The user authentication mode is a username and password.")
  UsernamePassword: "UsernamePassword",
}

@doc("The credentials for authentication mode UsernamePassword.")
model UsernamePasswordCredentials {
  @doc("A reference to secret containing the username.")
  usernameReference: string;

  @doc("A reference to secret containing the password.")
  passwordReference: string;
}

@doc("The x509 certificate for authentication mode Certificate.")
model X509Credentials {
  @doc("A reference to secret containing the certificate and private key (e.g. stored as .der/.pem or .der/.pfx).")
  certificateReference: string;
}

@doc("Definition of the authentication mechanism for the southbound connector.")
model TransportAuthentication {
  @doc("Defines a reference to a secret which contains all certificates and private keys that can be used by the southbound connector connecting to the shop floor/OT device. The accepted extensions are .der for certificates and .pfx/.pem for private keys.")
  @extension("x-ms-identifiers", [])
  ownCertificates: OwnCertificate[];
}

@doc("Certificate or private key that can be used by the southbound connector connecting to the shop floor/OT device. The accepted extensions are .der for certificates and .pfx/.pem for private keys.")
model OwnCertificate {
  @doc("Certificate thumbprint.")
  certThumbprint?: string;

  @doc("Secret Reference name (cert and private key).")
  certSecretReference?: string;

  @doc("Secret Reference Name (Pfx or Pem password).")
  certPasswordReference?: string;
}

@armResourceOperations
interface AssetEndpointProfiles {
  get is ArmResourceRead<AssetEndpointProfile>;

  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrReplace is ArmResourceCreateOrReplaceAsync<
    AssetEndpointProfile,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;

  update is ArmCustomPatchAsync<
    AssetEndpointProfile,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      AssetEndpointProfile,
      AssetEndpointProfileProperties
    >
  >;

  delete is ArmResourceDeleteWithoutOkAsync<AssetEndpointProfile>;

  listByResourceGroup is ArmResourceListByParent<AssetEndpointProfile>;

  listBySubscription is ArmListBySubscription<AssetEndpointProfile>;
}
