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
 * The customer's ASN that is registered by the peering service provider.
 */
@parentResource(Peering)
model PeeringRegisteredAsn
  is Azure.ResourceManager.ProxyResource<PeeringRegisteredAsnProperties> {
  ...ResourceNameParameter<
    Resource = PeeringRegisteredAsn,
    KeyName = "registeredAsnName",
    SegmentName = "registeredAsns",
    NamePattern = "[A-Za-z0-9_.-]{1,63}"
  >;
}

@armResourceOperations
interface PeeringRegisteredAsns {
  /**
   * Gets an existing registered ASN with the specified name under the given subscription, resource group and peering.
   */
  get is ArmResourceRead<PeeringRegisteredAsn>;

  /**
   * Creates a new registered ASN with the specified name under the given subscription, resource group and peering.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<PeeringRegisteredAsn>;

  /**
   * Deletes an existing registered ASN with the specified name under the given subscription, resource group and peering.
   */
  delete is ArmResourceDeleteSync<PeeringRegisteredAsn>;

  /**
   * Lists all registered ASNs under the given subscription, resource group and peering.
   */
  listByPeering is ArmResourceListByParent<PeeringRegisteredAsn>;
}

@@doc(PeeringRegisteredAsn.name, "The name of the registered ASN.");
@@doc(PeeringRegisteredAsn.properties,
  "The properties that define a registered ASN."
);
@@doc(PeeringRegisteredAsns.createOrUpdate::parameters.resource,
  "The properties needed to create a registered ASN."
);
