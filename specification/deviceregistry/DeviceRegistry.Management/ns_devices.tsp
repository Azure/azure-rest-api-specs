import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./common/provisioningState.tsp";
import "./common/deviceProperties.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.DeviceRegistry;

@added(Versions.v2024_10_01_preview)
@parentResource(Namespace)
@doc("Device definition.")
model NamespaceDevice is TrackedResource<NamespaceDeviceProperties> {
  @doc("The name of the device.")
  @key("deviceName")
  @segment("devices")
  @pattern("^[0-9a-zA-Z][a-zA-Z0-9-]*$")
  @path
  @minLength(3)
  @maxLength(63)
  name: string;

  // etag not included in TrackedResource
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @doc("Resource Tag.")
  @visibility(Lifecycle.Read)
  etag?: string;

  // Extended location is not included in TrackedResource yet
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @doc("The extended location.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @added(Versions.v2025_07_01_preview)
  extendedLocation?: ExtendedLocation;
}

alias NamespaceDevicePropertiesUpdate = {
  ...OptionalProperties<UpdateableProperties<OmitProperties<
    NamespaceDeviceProperties,
    "enabled"
  >>>;

  @added(Versions.v2024_10_01_preview)
  @doc("Indicates if the resource and identity are enabled or not. A disabled device cannot authenticate with Microsoft Entra ID.")
  enabled?: boolean;
};

@added(Versions.v2024_10_01_preview)
@armResourceOperations
interface NamespaceDevices {
  get is ArmResourceRead<NamespaceDevice>;
  createOrReplace is ArmResourceCreateOrReplaceAsync<NamespaceDevice>;
  update is ArmCustomPatchAsync<
    NamespaceDevice,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      NamespaceDevice,
      NamespaceDevicePropertiesUpdate
    >
  >;
  delete is ArmResourceDeleteWithoutOkAsync<NamespaceDevice>;
  listByResourceGroup is ArmResourceListByParent<NamespaceDevice>;
  @removed(Versions.v2025_07_01_preview)
  listBySubscription is ArmListBySubscription<NamespaceDevice>;
}
