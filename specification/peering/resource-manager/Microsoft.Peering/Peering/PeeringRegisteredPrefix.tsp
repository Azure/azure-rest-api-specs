import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Peering.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.Peering;
/**
 * The customer's prefix that is registered by the peering service provider.
 */
@parentResource(Peering)
model PeeringRegisteredPrefix
  is Azure.ResourceManager.ProxyResource<PeeringRegisteredPrefixProperties> {
  ...ResourceNameParameter<
    Resource = PeeringRegisteredPrefix,
    KeyName = "registeredPrefixName",
    SegmentName = "registeredPrefixes",
    NamePattern = "[A-Za-z0-9_.-]{1,63}"
  >;
}

@armResourceOperations
interface PeeringRegisteredPrefixes {
  /**
   * Gets an existing registered prefix with the specified name under the given subscription, resource group and peering.
   */
  get is ArmResourceRead<PeeringRegisteredPrefix>;

  /**
   * Creates a new registered prefix with the specified name under the given subscription, resource group and peering.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<PeeringRegisteredPrefix>;

  /**
   * Deletes an existing registered prefix with the specified name under the given subscription, resource group and peering.
   */
  delete is ArmResourceDeleteSync<PeeringRegisteredPrefix>;

  /**
   * Lists all registered prefixes under the given subscription, resource group and peering.
   */
  listByPeering is ArmResourceListByParent<PeeringRegisteredPrefix>;

  /**
   * Validates an existing registered prefix with the specified name under the given subscription, resource group and peering.
   */
  validate is ArmResourceActionSync<
    PeeringRegisteredPrefix,
    void,
    ArmResponse<PeeringRegisteredPrefix>
  >;
}

@@doc(PeeringRegisteredPrefix.name, "The name of the registered prefix.");
@@doc(PeeringRegisteredPrefix.properties,
  "The properties that define a registered prefix."
);
@@doc(PeeringRegisteredPrefixes.createOrUpdate::parameters.resource,
  "The properties needed to create a registered prefix."
);
