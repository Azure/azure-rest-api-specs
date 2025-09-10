import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using OpenAPI;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.DeviceOnboarding;
// ------------------------------------------------------------------
// Section 2: Discovery Service
// ------------------------------------------------------------------
@doc("A discovery resource.")
@added(Versions.v2024_12_01_preview)
@removed(Versions.v2025_05_01_preview)
model DiscoveryService
  is Azure.ResourceManager.TrackedResource<DiscoveryServiceProperties> {
  @doc("The name of the Discovery Resource.")
  @maxLength(64)
  @pattern("^[a-zA-Z0-9-]{3,63}[a-zA-Z0-9]$")
  @key("discoveryServiceName")
  @segment("discoveryServices")
  @path
  name: string;
}

@doc("Details of the Discovery Service.")
@added(Versions.v2024_12_01_preview)
@removed(Versions.v2025_05_01_preview)
model DiscoveryServiceProperties {
  @visibility(Lifecycle.Read)
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;

  @visibility(Lifecycle.Read)
  @doc("The discovery service rendezvous endpoints.")
  endpoints?: RendezvousEndpoints;
}

@doc("Rendezvous device endpoints.")
@added(Versions.v2024_12_01_preview)
@removed(Versions.v2025_05_01_preview)
model RendezvousEndpoints {
  @doc("The device endpoint for discovery")
  @visibility(Lifecycle.Read)
  deviceEndpoint?: RendezvousEndpoint;
}

@doc("Rendezvous endpoint model.")
@added(Versions.v2024_12_01_preview)
@removed(Versions.v2025_05_01_preview)
model RendezvousEndpoint {
  @doc("Hostname of the Rendezvous Endpoint.")
  @visibility(Lifecycle.Read)
  hostName?: string;
}

@armResourceOperations
@added(Versions.v2024_12_01_preview)
@removed(Versions.v2025_05_01_preview)
interface DiscoveryServices {
  get is ArmResourceRead<DiscoveryService>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<DiscoveryService>;
  delete is ArmResourceDeleteWithoutOkAsync<DiscoveryService>;
  update is ArmResourcePatchAsync<DiscoveryService, DiscoveryServiceProperties>;
  listByResourceGroup is ArmResourceListByParent<DiscoveryService>;
  listBySubscription is ArmListBySubscription<DiscoveryService>;
}
