import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./VirtualRouter.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * Virtual Router Peering resource.
 */
@parentResource(VirtualRouter)
model VirtualRouterPeering
  is Azure.ResourceManager.ProxyResource<VirtualRouterPeeringProperties> {
  ...ResourceNameParameter<
    Resource = VirtualRouterPeering,
    KeyName = "peeringName",
    SegmentName = "peerings",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
}

@armResourceOperations
interface VirtualRouterPeerings {
  /**
   * Gets the specified Virtual Router Peering.
   */
  get is ArmResourceRead<VirtualRouterPeering>;

  /**
   * Creates or updates the specified Virtual Router Peering.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<VirtualRouterPeering>;

  /**
   * Deletes the specified peering from a Virtual Router.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    VirtualRouterPeering,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Lists all Virtual Router Peerings in a Virtual Router resource.
   */
  list is ArmResourceListByParent<VirtualRouterPeering>;
}

@@doc(VirtualRouterPeering.name, "The name of the Virtual Router Peering.");
@@doc(VirtualRouterPeering.properties,
  "The properties of the Virtual Router Peering."
);
@@doc(VirtualRouterPeerings.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update Virtual Router Peering operation."
);
