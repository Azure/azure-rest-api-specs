import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./FluidRelayServer.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.FluidRelay;
/**
 * A FluidRelay Container.
 */
@parentResource(FluidRelayServer)
model FluidRelayContainer
  is Azure.ResourceManager.ProxyResource<FluidRelayContainerProperties> {
  ...ResourceNameParameter<
    Resource = FluidRelayContainer,
    KeyName = "fluidRelayContainerName",
    SegmentName = "fluidRelayContainers",
    NamePattern = ""
  >;
}

@armResourceOperations
interface FluidRelayContainers {
  /**
   * Get a Fluid Relay container.
   */
  get is ArmResourceRead<FluidRelayContainer>;

  /**
   * Delete a Fluid Relay container.
   */
  delete is ArmResourceDeleteSync<FluidRelayContainer>;

  /**
   * List all Fluid Relay containers which are children of a given Fluid Relay server.
   */
  listByFluidRelayServers is ArmResourceListByParent<
    FluidRelayContainer,
    Response = ArmResponse<FluidRelayContainerList>
  >;
}

@@doc(FluidRelayContainer.name, "The Fluid Relay container resource name.");
@@doc(FluidRelayContainer.properties,
  "The resource-specific properties for this resource."
);
