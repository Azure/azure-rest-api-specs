import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.FluidRelay;
@doc("A FluidRelay Server.")
model FluidRelayServer is TrackedResource<FluidRelayServerProperties> {
  @doc("The Fluid Relay server resource name.")
  @path
  @key("fluidRelayServerName")
  @segment("fluidRelayServers")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface FluidRelayServers {
  @doc("Get a Fluid Relay server.")
  get is ArmResourceRead<FluidRelayServer>;

  @doc("Create or Update a Fluid Relay server.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<FluidRelayServer>;

  @doc("Update a Fluid Relay server.")
  update is ArmCustomPatchSync<FluidRelayServer, FluidRelayServerUpdate>;

  @doc("Delete a Fluid Relay server.")
  delete is ArmResourceDeleteSync<FluidRelayServer>;

  @doc("List all Fluid Relay servers in a resource group.")
  listByResourceGroup is ArmResourceListByParent<FluidRelayServer>;

  @doc("List all Fluid Relay servers in a subscription.")
  listBySubscription is ArmListBySubscription<FluidRelayServer>;

  @doc("Regenerate the primary or secondary key for this server.")
  regenerateKey is ArmResourceActionSync<
    FluidRelayServer,
    RegenerateKeyRequest,
    FluidRelayServerKeys
  >;

  @doc("Get primary and secondary key for this server.")
  listKeys is ArmResourceActionSync<
    FluidRelayServer,
    void,
    FluidRelayServerKeys
  >;
}

@@doc(FluidRelayServers.createOrUpdate::parameters.resource,
  "The details of the Fluid Relay server resource."
);
@@projectedName(FluidRelayServers.update::parameters.properties,
  "json",
  "resource"
);
@@extension(FluidRelayServers.update::parameters.properties,
  "x-ms-client-name",
  "resource"
);
@@doc(FluidRelayServers.update::parameters.properties,
  "The details of the Fluid Relay server resource included in update calls."
);
@@projectedName(FluidRelayServers.regenerateKey::parameters.body,
  "json",
  "parameters"
);
@@extension(FluidRelayServers.regenerateKey::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@doc(FluidRelayServers.regenerateKey::parameters.body,
  "The details of which keys to generate."
);
