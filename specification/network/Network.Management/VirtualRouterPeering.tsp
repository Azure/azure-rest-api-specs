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
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
@parentResource(VirtualRouter)
@Http.Private.includeInapplicableMetadataInPayload(false)
model VirtualRouterPeering extends SubResourceModel {
  properties?: VirtualRouterPeeringProperties;

  /**
   * The name of the resource that is unique within a resource group. This name can be used to access the resource.
   */
  @visibility(Lifecycle.Read)
  @path
  @key("peeringName")
  @segment("peerings")
  name: string;

  /**
   * A unique read-only string that changes whenever the resource is updated.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;
}

@armResourceOperations
interface VirtualRouterPeerings {
  /**
   * Gets the specified Virtual Router Peering.
   */
  get is ArmResourceRead<VirtualRouterPeering, Error = Error>;

  /**
   * Creates or updates the specified Virtual Router Peering.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    VirtualRouterPeering,
    Error = Error
  >;

  /**
   * Deletes the specified peering from a Virtual Router.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    VirtualRouterPeering,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = Error
  >;

  /**
   * Lists all Virtual Router Peerings in a Virtual Router resource.
   */
  list is ArmResourceListByParent<VirtualRouterPeering, Error = Error>;
}

@@doc(VirtualRouterPeering.name,
  "The name of the resource that is unique within a resource group. This name can be used to access the resource."
);
@@doc(VirtualRouterPeering.properties,
  "The properties of the Virtual Router Peering."
);
@@doc(VirtualRouterPeerings.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update Virtual Router Peering operation."
);
