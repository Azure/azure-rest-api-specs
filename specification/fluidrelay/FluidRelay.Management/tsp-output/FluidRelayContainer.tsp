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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(FluidRelayServer)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(
  FluidRelayContainerProperties
)
model FluidRelayContainer extends ProxyResourceBase {
  /**
   * The Fluid Relay container resource name.
   */
  @path
  @key("fluidRelayContainerName")
  @segment("fluidRelayContainers")
  @visibility("read")
  name: string;

  /**
   * The resource-specific properties for this resource.
   */
  @extension("x-ms-client-flatten", true)
  properties?: FluidRelayContainerProperties;
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
