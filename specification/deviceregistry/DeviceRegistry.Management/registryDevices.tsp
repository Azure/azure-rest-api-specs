import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./common/provisioningState.tsp";
import "./common/status.tsp";
import "../common/deviceTypes.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.Core;

namespace Microsoft.DeviceRegistry;

@added(Versions.v2026_11_01_preview)
@parentResource(Namespace)
@doc("A Registry Device resource is a tracked resource with a provisioning lifecycle. The different capabilities of the device are defined through child Device Capability resources.")
model RegistryDevice is TrackedResource<RegistryDeviceProperties> {
  @doc("The name of the new device.")
  @key("registryDeviceName")
  @segment("registryDevices")
  @pattern("^[0-9a-zA-Z][a-zA-Z0-9-]*$")
  @path
  @minLength(3)
  @maxLength(63)
  name: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @doc("Resource etag.")
  @visibility(Lifecycle.Read)
  etag?: string;
}

@added(Versions.v2026_11_01_preview)
@doc("The properties of a registry device.")
model RegistryDeviceProperties {
  ...RegistryDevicePropertiesBase;

  @doc("Provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@@added(RegistryDevicePropertiesBase, Versions.v2026_11_01_preview);
@@added(RegistryDeviceEnablementState, Versions.v2026_11_01_preview);

@added(Versions.v2026_11_01_preview)
@armResourceOperations
interface RegistryDevices {
  get is ArmResourceRead<RegistryDevice>;
  createOrReplace is ArmResourceCreateOrReplaceAsync<RegistryDevice>;
  // Using 'ArmCustomPatchAsync' instead of 'ArmResourcePatchAsync' to define the correct patch payload for the resource.
  // This is a workaround to fix the patch payload that otherwise will expose the 'location' field (not present in patch),
  // since otherwise it extends the ARM TrackedResource type.
  update is ArmCustomPatchAsync<
    RegistryDevice,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      RegistryDevice,
      RegistryDeviceProperties
    >
  >;
  delete is ArmResourceDeleteWithoutOkAsync<RegistryDevice>;
  listByNamespace is ArmResourceListByParent<RegistryDevice>;
}
