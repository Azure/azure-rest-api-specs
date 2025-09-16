import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./PacketCoreDataPlane.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MobileNetwork;
/**
 * Attached data network resource. Must be created in the same location as its parent packet core data plane.
 */
@parentResource(PacketCoreDataPlane)
model AttachedDataNetwork
  is Azure.ResourceManager.TrackedResource<
    AttachedDataNetworkPropertiesFormat,
    false
  > {
  ...ResourceNameParameter<
    Resource = AttachedDataNetwork,
    KeyName = "attachedDataNetworkName",
    SegmentName = "attachedDataNetworks",
    NamePattern = "^[a-zA-Z0-9]([a-zA-Z0-9-]*[a-zA-Z0-9])*(\\.[a-zA-Z0-9]([a-zA-Z0-9-]*[a-zA-Z0-9])*)*$"
  >;
}

@armResourceOperations
interface AttachedDataNetworks {
  /**
   * Gets information about the specified attached data network.
   */
  get is ArmResourceRead<AttachedDataNetwork>;

  /**
   * Creates or updates an attached data network. Must be created in the same location as its parent packet core data plane.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<AttachedDataNetwork>;

  /**
   * Updates an attached data network tags.
   */
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchSync<
    AttachedDataNetwork,
    PatchModel = TagsObject
  >;

  /**
   * Deletes the specified attached data network.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    AttachedDataNetwork,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Gets all the attached data networks associated with a packet core data plane.
   */
  listByPacketCoreDataPlane is ArmResourceListByParent<AttachedDataNetwork>;
}

@@maxLength(AttachedDataNetwork.name, 64);
@@doc(AttachedDataNetwork.name, "The name of the attached data network.");
@@doc(AttachedDataNetwork.properties, "Attached data network properties.");
@@doc(AttachedDataNetworks.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update attached data network operation."
);
@@doc(AttachedDataNetworks.updateTags::parameters.properties,
  "Parameters supplied to update attached data network tags."
);
