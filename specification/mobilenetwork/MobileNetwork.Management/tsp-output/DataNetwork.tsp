import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./MobileNetwork.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MobileNetwork;
/**
 * Data network resource. Must be created in the same location as its parent mobile network.
 */
@parentResource(MobileNetwork)
model DataNetwork is TrackedResource<DataNetworkPropertiesFormat> {
  /**
   * The name of the data network.
   */
  @maxLength(64)
  @pattern("^[a-zA-Z0-9]([a-zA-Z0-9-]*[a-zA-Z0-9])*(\\.[a-zA-Z0-9]([a-zA-Z0-9-]*[a-zA-Z0-9])*)*$")
  @path
  @key("dataNetworkName")
  @segment("dataNetworks")
  name: string;
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
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    DataNetwork,
    BaseParameters<DataNetwork>,
    ArmAsyncOperationHeader
  >;

  /**
   * Updates data network tags.
   */
  @parameterVisibility("read")
  updateTags is ArmCustomPatchSync<DataNetwork, TagsObject>;

  /**
   * Deletes the specified data network.
   */
  delete is ArmResourceDeleteAsync<
    DataNetwork,
    BaseParameters<DataNetwork>,
    ArmLroLocationHeader
  >;

  /**
   * Lists all data networks in the mobile network.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DataNetworks_ListByMobileNetwork")
  listByMobileNetwork is ArmResourceListByParent<DataNetwork>;
}

@@projectedName(DataNetworks.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(DataNetworks.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(DataNetworks.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update data network operation."
);
@@projectedName(DataNetworks.updateTags::parameters.properties,
  "json",
  "parameters"
);
@@extension(DataNetworks.updateTags::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(DataNetworks.updateTags::parameters.properties,
  "Parameters supplied to update data network tags."
);
