import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./FluidRelayServer.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.FluidRelay;
/**
 * A FluidRelay Container.
 */
@parentResource(FluidRelayServer)
model FluidRelayContainer is ProxyResource<FluidRelayContainerProperties> {
  /**
   * The Fluid Relay container resource name.
   */
  @path
  @key("fluidRelayContainerName")
  @segment("fluidRelayContainers")
  name: string;
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
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("FluidRelayContainers_ListByFluidRelayServers")
  listByFluidRelayServers is ArmResourceListByParent<FluidRelayContainer>;
}
