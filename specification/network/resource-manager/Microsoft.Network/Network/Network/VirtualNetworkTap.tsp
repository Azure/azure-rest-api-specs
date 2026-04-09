import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "../Common/VirtualNetworkTap.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Common;

namespace Microsoft.Network;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkGateway)
@armResourceOperations(#{ omitTags: true })
interface VirtualNetworkTaps {
  @tag("VirtualNetworkTap")
  get is ArmResourceRead<VirtualNetworkTap, Error = CloudError>;

  @tag("VirtualNetworkTap")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    VirtualNetworkTap,
    Error = CloudError
  >;

  @tag("VirtualNetworkTap")
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchSync<
    VirtualNetworkTap,
    PatchModel = TagsObject,
    Error = CloudError
  >;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("VirtualNetworkTap")
  delete is ArmResourceDeleteWithoutOkAsync<
    VirtualNetworkTap,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Gets all the VirtualNetworkTaps in a subscription.
   */
  @tag("VirtualNetworkTaps")
  listByResourceGroup is ArmResourceListByParent<
    VirtualNetworkTap,
    Error = CloudError
  >;

  /**
   * Gets all the VirtualNetworkTaps in a subscription.
   */
  @tag("VirtualNetworkTaps")
  listAll is ArmListBySubscription<VirtualNetworkTap, Error = CloudError>;
}

@@doc(VirtualNetworkTap.name, "The name of virtual network tap.");
@@doc(VirtualNetworkTap.properties, "Virtual Network Tap Properties.");
@@doc(VirtualNetworkTaps.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update virtual network tap operation."
);
@@doc(VirtualNetworkTaps.updateTags::parameters.properties,
  "Parameters supplied to update VirtualNetworkTap tags."
);
