import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./PacketCoreDataPlane.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MobileNetwork;
/**
 * Attached data network resource. Must be created in the same location as its parent packet core data plane.
 */
@parentResource(PacketCoreDataPlane)
model AttachedDataNetwork
  is TrackedResource<AttachedDataNetworkPropertiesFormat> {
  /**
   * The name of the attached data network.
   */
  @maxLength(64)
  @pattern("^[a-zA-Z0-9]([a-zA-Z0-9-]*[a-zA-Z0-9])*(\\.[a-zA-Z0-9]([a-zA-Z0-9-]*[a-zA-Z0-9])*)*$")
  @path
  @key("attachedDataNetworkName")
  @segment("attachedDataNetworks")
  name: string;
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
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    AttachedDataNetwork,
    BaseParameters<AttachedDataNetwork>,
    ArmAsyncOperationHeader
  >;

  /**
   * Updates an attached data network tags.
   */
  @parameterVisibility("read")
  updateTags is ArmCustomPatchSync<AttachedDataNetwork, TagsObject>;

  /**
   * Deletes the specified attached data network.
   */
  delete is ArmResourceDeleteAsync<
    AttachedDataNetwork,
    BaseParameters<AttachedDataNetwork>,
    ArmLroLocationHeader
  >;

  /**
   * Gets all the attached data networks associated with a packet core data plane.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AttachedDataNetworks_ListByPacketCoreDataPlane")
  listByPacketCoreDataPlane is ArmResourceListByParent<AttachedDataNetwork>;
}

@@projectedName(AttachedDataNetworks.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(AttachedDataNetworks.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(AttachedDataNetworks.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update attached data network operation."
);
@@projectedName(AttachedDataNetworks.updateTags::parameters.properties,
  "json",
  "parameters"
);
@@extension(AttachedDataNetworks.updateTags::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(AttachedDataNetworks.updateTags::parameters.properties,
  "Parameters supplied to update attached data network tags."
);
