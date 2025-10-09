import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./common/provisioningState.tsp";
import "./properties/ns_deviceProperties.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.DeviceRegistry;

@added(Versions.v2025_07_01_preview)
@parentResource(Namespace)
@doc("Device definition.")
model NamespaceDevice is TrackedResource<NamespaceDeviceProperties> {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-name-pattern" "existing api spec"
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
  extendedLocation?: ExtendedLocation;
}

alias NamespaceDevicePropertiesUpdate = {
  ...OptionalProperties<UpdateableProperties<OmitProperties<
    NamespaceDeviceProperties,
    "enabled"
  >>>;

  @added(Versions.v2025_07_01_preview)
  @doc("Indicates if the resource and identity are enabled or not. A disabled device cannot authenticate with Microsoft Entra ID.")
  enabled?: boolean;
};

@added(Versions.v2025_07_01_preview)
@armResourceOperations
interface NamespaceDevices {
  get is ArmResourceRead<NamespaceDevice>;
  createOrReplace is ArmResourceCreateOrReplaceAsync<NamespaceDevice>;
  // Using 'ArmCustomPatchAsync' instead of 'ArmResourcePatchAsync' to define the correct patch payload for the resource.
  // This is a workaround to fix the patch payload that otherwise will expose the 'location' field (not present in patch),
  // since otherwise it extends the ARM TrackedResource type.
  update is ArmCustomPatchAsync<
    NamespaceDevice,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      NamespaceDevice,
      NamespaceDevicePropertiesUpdate
    >
  >;
  delete is ArmResourceDeleteWithoutOkAsync<NamespaceDevice>;
  listByResourceGroup is ArmResourceListByParent<NamespaceDevice>;
}
