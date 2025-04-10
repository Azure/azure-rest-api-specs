import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.FluidRelay;
/**
 * A FluidRelay Server.
 */
@subscriptionResource
model FluidRelayServer
  is Azure.ResourceManager.TrackedResource<FluidRelayServerProperties> {
  ...ResourceNameParameter<
    Resource = FluidRelayServer,
    KeyName = "fluidRelayServerName",
    SegmentName = "fluidRelayServers",
    NamePattern = ""
  >;

  /**
   * The type of identity used for the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  identity?: Identity;
}

@armResourceOperations
interface FluidRelayServers {
  /**
   * Get a Fluid Relay server.
   */
  get is ArmResourceRead<
    FluidRelayServer,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * Create or Update a Fluid Relay server.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    FluidRelayServer,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Response = ArmResourceUpdatedResponse<FluidRelayServer>
  >;

  /**
   * Update a Fluid Relay server.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    FluidRelayServer,
    PatchModel = FluidRelayServerUpdate,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * Delete a Fluid Relay server.
   */
  delete is ArmResourceDeleteSync<
    FluidRelayServer,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * List all Fluid Relay servers in a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    FluidRelayServer,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Response = ArmResponse<FluidRelayServerList>
  >;

  /**
   * List all Fluid Relay servers in a subscription.
   */
  listBySubscription is ArmListBySubscription<
    FluidRelayServer,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Response = ArmResponse<FluidRelayServerList>
  >;

  /**
   * Regenerate the primary or secondary key for this server.
   */
  regenerateKey is ArmResourceActionSync<
    FluidRelayServer,
    RegenerateKeyRequest,
    ArmResponse<FluidRelayServerKeys>,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * Get primary and secondary key for this server.
   */
  listKeys is ArmResourceActionSync<
    FluidRelayServer,
    void,
    ArmResponse<FluidRelayServerKeys>,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;
}

@@doc(FluidRelayServer.name, "The Fluid Relay server resource name.");
@@doc(FluidRelayServer.properties,
  "The resource-specific properties for this resource."
);
@@doc(FluidRelayServers.createOrUpdate::parameters.resource,
  "The details of the Fluid Relay server resource."
);
@@doc(FluidRelayServers.update::parameters.properties,
  "The details of the Fluid Relay server resource included in update calls."
);
@@doc(FluidRelayServers.regenerateKey::parameters.body,
  "The details of which keys to generate."
);
