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
@doc("A FluidRelay Container.")
@parentResource(FluidRelayServer)
model FluidRelayContainer is ProxyResource<FluidRelayContainerProperties> {
  @doc("The Fluid Relay container resource name.")
  @path
  @key("fluidRelayContainerName")
  @segment("fluidRelayContainers")
  name: string;
}

@armResourceOperations
interface FluidRelayContainers {
  @doc("Get a Fluid Relay container.")
  get is ArmResourceRead<FluidRelayContainer>;

  @doc("Delete a Fluid Relay container.")
  delete is ArmResourceDeleteSync<FluidRelayContainer>;

  @doc("List all Fluid Relay containers which are children of a given Fluid Relay server.")
  listByFluidRelayServers is ArmResourceListByParent<FluidRelayContainer>;
}
