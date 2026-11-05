import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.IoTOperations;

/** An Edge Registry service resource. */
@added(Versions.`2026-12-01-preview`)
@parentResource(InstanceResource)
model EdgeRegistryResource is ProxyResource<EdgeRegistryProperties> {
  /** The name of the Edge Registry resource. */
  @pattern("^[a-z0-9][a-z0-9-]*[a-z0-9]$")
  @key("edgeRegistryName")
  @path
  @minLength(3)
  @maxLength(63)
  @segment("edgeRegistries")
  name: string;

  /** The edge location of the resource. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "This Arc-hosted resource supports and advertises only the CustomLocation extended-location type. The standard ExtendedLocationProperty also advertises EdgeZone, which this service does not support. The custom model retains string extensibility for forward compatibility."
  @visibility(Lifecycle.Read, Lifecycle.Create)
  extendedLocation?: ExtendedLocation;
}

/** The properties of the Edge Registry resource. */
@added(Versions.`2026-12-01-preview`)
model EdgeRegistryProperties {
  /** The status of the last resource provisioning operation. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /** The runtime status of the Edge Registry service. */
  @visibility(Lifecycle.Read)
  status?: EdgeRegistryStatus;
}

/** The runtime status of the Edge Registry service. */
@added(Versions.`2026-12-01-preview`)
model EdgeRegistryStatus {
  /** The health state of the Edge Registry service. */
  @visibility(Lifecycle.Read)
  healthState?: ResourceHealthStatus;
}
