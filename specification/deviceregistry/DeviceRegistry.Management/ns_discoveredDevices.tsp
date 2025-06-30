import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./common/extendedLocation.tsp";
import "./common/provisioningState.tsp";
import "./common/authenticationMethod.tsp";
import "./common/ns_discoveredDeviceProperties.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.DeviceRegistry;

@doc("Discovered device definition.")
@parentResource(Namespace)
@added(Versions.v2025_07_01_preview)
model NamespaceDiscoveredDevice
  is TrackedResource<NamespaceDiscoveredDeviceProperties> {
  @doc("The name of the discovered device.")
  @key("discoveredDeviceName")
  @segment("discoveredDevices")
  @pattern("^[a-z0-9][a-z0-9-]*[a-z0-9]$")
  @path
  @minLength(3)
  @maxLength(63)
  name: string;

  // Extended location is not included in TrackedResource yet
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @doc("The extended location.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  extendedLocation: ExtendedLocation;
}

@armResourceOperations
@added(Versions.v2025_07_01_preview)
interface NamespaceDiscoveredDevices {
  get is ArmResourceRead<NamespaceDiscoveredDevice>;
  createOrReplace is ArmResourceCreateOrReplaceAsync<NamespaceDiscoveredDevice>;
  update is ArmCustomPatchAsync<
    NamespaceDiscoveredDevice,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      NamespaceDiscoveredDevice,
      NamespaceDiscoveredDeviceProperties
    >
  >;
  delete is ArmResourceDeleteWithoutOkAsync<NamespaceDiscoveredDevice>;
  listByResourceGroup is ArmResourceListByParent<NamespaceDiscoveredDevice>;
  @removed(Versions.v2025_07_01_preview)
  listBySubscription is ArmListBySubscription<NamespaceDiscoveredDevice>;
}
