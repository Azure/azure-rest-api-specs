import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./common/extendedLocation.tsp";
import "./common/provisioningState.tsp";
import "./common/authenticationMethod.tsp";

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

  @doc("Defines the configuration for the connector type that is being used with the endpoint profile.")
  @added(Versions.v2024_09_01_preview)
  endpointProfileType: string;

  @doc("Defines the client authentication mechanism to the server.")
  @removed(Versions.v2024_09_01_preview)
  userAuthentication?: Authentication;

  @doc("Defines the client authentication mechanism to the server.")
  @added(Versions.v2024_09_01_preview)
  authentication?: Authentication;

  @doc("Defines the authentication mechanism for the southbound connector connecting to the shop floor/OT device.")
  @removed(Versions.v2024_09_01_preview)
  transportAuthentication?: TransportAuthentication;

  @doc("Stringified JSON that contains connectivity type specific further configuration (e.g. OPC UA, Modbus, ONVIF).")
  additionalConfiguration?: string;

  @doc("Reference to a discovered asset endpoint profile. Populated only if the asset endpoint profile has been created from discovery flow. Discovered asset endpoint profile name must be provided.")
  @visibility("read", "create")
  @added(Versions.v2024_09_01_preview)
  discoveredAssetEndpointProfileRef?: string;

  @doc("Read only object to reflect changes that have occurred on the Edge. Similar to Kubernetes status property for custom resources.")
  @visibility("read")
  @added(Versions.v2024_09_01_preview)
  status?: AssetEndpointProfileStatus;

  @doc("Provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("Definition of the client authentication mechanism to the server.")
@renamedFrom(Versions.v2024_09_01_preview, "UserAuthentication")
model Authentication {
  @doc("Defines the method to authenticate the user of the client at the server.")
  @renamedFrom(Versions.v2024_09_01_preview, "mode")
  // Default mode is Certificate
  method: AuthenticationMethod = AuthenticationMethod.Certificate;

  @doc("Defines the username and password references when UsernamePassword user authentication mode is selected.")
  usernamePasswordCredentials?: UsernamePasswordCredentials;

  @doc("Defines the certificate reference when Certificate user authentication mode is selected.")
  x509Credentials?: X509Credentials;
}

@doc("The credentials for authentication mode UsernamePassword.")
model UsernamePasswordCredentials {
  @doc("A reference to secret containing the username.")
  @removed(Versions.v2024_09_01_preview)
  usernameReference: string;

  @doc("The name of the secret containing the username.")
  @added(Versions.v2024_09_01_preview)
  usernameSecretName: string;

  @doc("A reference to secret containing the password.")
  @removed(Versions.v2024_09_01_preview)
  passwordReference: string;

  @doc("The name of the secret containing the password.")
  @added(Versions.v2024_09_01_preview)
  passwordSecretName: string;
}

@doc("The x509 certificate for authentication mode Certificate.")
model X509Credentials {
  @doc("A reference to secret containing the certificate and private key (e.g. stored as .der/.pem or .der/.pfx).")
  @removed(Versions.v2024_09_01_preview)
  certificateReference: string;

  @doc("The name of the secret containing the certificate and private key (e.g. stored as .der/.pem or .der/.pfx).")
  @added(Versions.v2024_09_01_preview)
  certificateSecretName: string;
}

@doc("Definition of the authentication mechanism for the southbound connector.")
@removed(Versions.v2024_09_01_preview)
model TransportAuthentication {
  @doc("Defines a reference to a secret which contains all certificates and private keys that can be used by the southbound connector connecting to the shop floor/OT device. The accepted extensions are .der for certificates and .pfx/.pem for private keys.")
  @extension("x-ms-identifiers", [])
  @removed(Versions.v2024_09_01_preview)
  ownCertificates: OwnCertificate[];
}

@doc("Certificate or private key that can be used by the southbound connector connecting to the shop floor/OT device. The accepted extensions are .der for certificates and .pfx/.pem for private keys.")
@removed(Versions.v2024_09_01_preview)
model OwnCertificate {
  @doc("Certificate thumbprint.")
  certThumbprint?: string;

  @doc("Secret Reference name (cert and private key).")
  certSecretReference?: string;

  @doc("Secret Reference Name (Pfx or Pem password).")
  certPasswordReference?: string;
}

@doc("Defines the asset endpoint profile status properties.")
@added(Versions.v2024_09_01_preview)
model AssetEndpointProfileStatus {
  @doc("Array object to transfer and persist errors that originate from the Edge.")
  @visibility("read")
  @extension("x-ms-identifiers", [])
  errors?: AssetEndpointProfileStatusError[];
}

@doc("Defines the asset endpoint profile status error properties.")
@added(Versions.v2024_09_01_preview)
model AssetEndpointProfileStatusError {
  @doc("Error code for classification of errors (ex: 400, 404, 500, etc.).")
  @visibility("read")
  code?: int32;

  @doc("Human readable helpful error message to provide additional context for error (ex: “targetAddress 'foo' is not a valid url”).")
  @visibility("read")
  message?: string;
}

// The updateable properties of the Asset Endpoint Profile.
// This is a workaround to fix the patch payload that otherwise will expose the 'location' field (not present in patch),
// since otherwise it extends the ARM TrackedResource type.
alias AssetEndpointProfilePropertiesUpdate = {
  ...OptionalProperties<UpdateableProperties<AssetEndpointProfileProperties>>;
};

@armResourceOperations
interface AssetEndpointProfiles {
  get is ArmResourceRead<AssetEndpointProfile>;
  createOrReplace is ArmResourceCreateOrReplaceAsync<AssetEndpointProfile>;
  // Using 'ArmCustomPatchAsync' instead of 'ArmResourcePatchAsync' to define the correct patch payload for the resource.
  // This is a workaround to fix the patch payload that otherwise will expose the 'location' field (not present in patch),
  // since otherwise it extends the ARM TrackedResource type.
  update is ArmCustomPatchAsync<
    AssetEndpointProfile,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      AssetEndpointProfile,
      AssetEndpointProfilePropertiesUpdate
    >
  >;
  delete is ArmResourceDeleteWithoutOkAsync<AssetEndpointProfile>;
  listByResourceGroup is ArmResourceListByParent<AssetEndpointProfile>;
  listBySubscription is ArmListBySubscription<AssetEndpointProfile>;
}
