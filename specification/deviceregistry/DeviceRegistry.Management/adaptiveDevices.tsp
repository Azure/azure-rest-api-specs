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
@doc("New device definition.")
model NamespaceAdaptiveDevice
  is TrackedResource<NamespaceAdaptiveDeviceProperties> {
  @doc("The name of the new device.")
  @key("adaptiveDeviceName")
  @segment("adaptiveDevices")
  @pattern("^[0-9a-zA-Z][a-zA-Z0-9-]*$")
  @path
  @minLength(3)
  @maxLength(63)
  name: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @doc("Resource Tag.")
  @visibility(Lifecycle.Read)
  etag?: string;
}

@added(Versions.v2026_11_01_preview)
@doc("Defines the new device properties.")
model NamespaceAdaptiveDeviceProperties {
  ...DevicePropertiesBase;

  @doc("Provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@@added(DeviceEnabledStatus, Versions.v2026_11_01_preview);
@@added(DevicePropertiesBase, Versions.v2026_11_01_preview);

@added(Versions.v2026_11_01_preview)
@armResourceOperations
interface NamespaceAdaptiveDevices {
  get is ArmResourceRead<NamespaceAdaptiveDevice>;
  createOrReplace is ArmResourceCreateOrReplaceSync<NamespaceAdaptiveDevice>;
  update is ArmResourcePatchSync<
    NamespaceAdaptiveDevice,
    NamespaceAdaptiveDeviceProperties
  >;
  delete is ArmResourceDeleteWithoutOkAsync<NamespaceAdaptiveDevice>;
  listByResourceGroup is ArmResourceListByParent<NamespaceAdaptiveDevice>;
}
