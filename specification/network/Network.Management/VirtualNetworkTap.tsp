import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * Virtual Network Tap resource.
 */
model VirtualNetworkTap
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<VirtualNetworkTapPropertiesFormat> {
  ...ResourceNameParameter<
    Resource = VirtualNetworkTap,
    KeyName = "tapName",
    SegmentName = "virtualNetworkTaps",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
}

@armResourceOperations
interface VirtualNetworkTaps {
  /**
   * Gets information about the specified virtual network tap.
   */
  get is ArmResourceRead<VirtualNetworkTap, Error = CloudError>;

  /**
   * Creates or updates a Virtual Network Tap.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    VirtualNetworkTap,
    Error = CloudError
  >;

  /**
   * Updates an VirtualNetworkTap tags.
   */
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchSync<
    VirtualNetworkTap,
    PatchModel = TagsObject,
    Error = CloudError
  >;

  /**
   * Deletes the specified virtual network tap.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    VirtualNetworkTap,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Gets all the VirtualNetworkTaps in a subscription.
   */
  listByResourceGroup is ArmResourceListByParent<
    VirtualNetworkTap,
    Error = CloudError
  >;

  /**
   * Gets all the VirtualNetworkTaps in a subscription.
   */
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
