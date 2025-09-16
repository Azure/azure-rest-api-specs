import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./MobileNetwork.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MobileNetwork;
/**
 * Data network resource. Must be created in the same location as its parent mobile network.
 */
@parentResource(MobileNetwork)
model DataNetwork
  is Azure.ResourceManager.TrackedResource<DataNetworkPropertiesFormat> {
  ...ResourceNameParameter<
    Resource = DataNetwork,
    KeyName = "dataNetworkName",
    SegmentName = "dataNetworks",
    NamePattern = "^[a-zA-Z0-9]([a-zA-Z0-9-]*[a-zA-Z0-9])*(\\.[a-zA-Z0-9]([a-zA-Z0-9-]*[a-zA-Z0-9])*)*$"
  >;
}

@armResourceOperations
interface DataNetworks {
  /**
   * Gets information about the specified data network.
   */
  get is ArmResourceRead<DataNetwork>;

  /**
   * Creates or updates a data network. Must be created in the same location as its parent mobile network.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<DataNetwork>;

  /**
   * Updates data network tags.
   */
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchSync<DataNetwork, PatchModel = TagsObject>;

  /**
   * Deletes the specified data network.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    DataNetwork,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Lists all data networks in the mobile network.
   */
  listByMobileNetwork is ArmResourceListByParent<DataNetwork>;
}

@@maxLength(DataNetwork.name, 64);
@@doc(DataNetwork.name, "The name of the data network.");
@@doc(DataNetwork.properties, "Data network properties.");
@@doc(DataNetworks.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update data network operation."
);
@@doc(DataNetworks.updateTags::parameters.properties,
  "Parameters supplied to update data network tags."
);
