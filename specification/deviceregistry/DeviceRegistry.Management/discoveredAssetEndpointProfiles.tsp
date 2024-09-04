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

@doc("Discovered Asset Endpoint Profile definition.")
@added(Versions.v2024_09_01_preview)
model DiscoveredAssetEndpointProfile
  is TrackedResource<DiscoveredAssetEndpointProfileProperties> {
  @doc("Discovered Asset Endpoint Profile name parameter.")
  @key("discoveredAssetEndpointProfileName")
  @segment("discoveredAssetEndpointProfiles")
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

@doc("Defines the Discovered Asset Endpoint Profile properties.")
@added(Versions.v2024_09_01_preview)
model DiscoveredAssetEndpointProfileProperties {
  @doc("The local valid URI specifying the network address/DNS name of a southbound device. The scheme part of the targetAddress URI specifies the type of the device. The additionalConfiguration field holds further connector type specific configuration.")
  targetAddress: url;

  @doc("Stringified JSON that contains connectivity type specific further configuration (e.g. OPC UA, Modbus, ONVIF).")
  additionalConfiguration?: string;

  @doc("List of supported authentication methods supported by the target server.")
  @extension("x-ms-identifiers", [])
  supportedAuthenticationMethods?: AuthenticationMethod[];

  @doc("Defines the configuration for the connector type that is being used with the endpoint profile.")
  endpointProfileType: string;

  @doc("Identifier used to detect changes in the asset endpoint profile.")
  discoveryId: string;

  @doc("An integer that is incremented each time the resource is modified.")
  version: int64;

  @doc("Provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

// The updateable properties of the Discovered Asset Endpoint Profile.
// This is a workaround to fix the patch payload that otherwise will expose the 'location' field (not present in patch),
// since otherwise it extends the ARM TrackedResource type.
alias DiscoveredAssetEndpointProfilePropertiesUpdate = {
  ...OptionalProperties<UpdateableProperties<DiscoveredAssetEndpointProfileProperties>>;
};

@armResourceOperations
@added(Versions.v2024_09_01_preview)
interface DiscoveredAssetEndpointProfiles {
  get is ArmResourceRead<DiscoveredAssetEndpointProfile>;
  createOrReplace is ArmResourceCreateOrReplaceAsync<DiscoveredAssetEndpointProfile>;
  // Using 'ArmCustomPatchAsync' instead of 'ArmResourcePatchAsync' to define the correct patch payload for the resource.
  // This is a workaround to fix the patch payload that otherwise will expose the 'location' field (not present in patch),
  // since otherwise it extends the ARM TrackedResource type.
  update is ArmCustomPatchAsync<
    DiscoveredAssetEndpointProfile,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      DiscoveredAssetEndpointProfile,
      DiscoveredAssetEndpointProfilePropertiesUpdate
    >
  >;
  delete is ArmResourceDeleteWithoutOkAsync<DiscoveredAssetEndpointProfile>;
  listByResourceGroup is ArmResourceListByParent<DiscoveredAssetEndpointProfile>;
  listBySubscription is ArmListBySubscription<DiscoveredAssetEndpointProfile>;
}
