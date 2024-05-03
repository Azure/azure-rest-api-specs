import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";

import "../models/DataNetworkModels.tsp";
import "./MobileNetwork.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MobileNetwork;

@doc("Data network resource. Must be created in the same location as its parent mobile network.")
@resource("dataNetworks")
@parentResource(MobileNetwork)
model DataNetwork is TrackedResource<DataNetworkPropertiesFormat> {
  @doc("The name of the data network.")
  @maxLength(64)
  @pattern("^[a-zA-Z0-9]([a-zA-Z0-9-]*[a-zA-Z0-9])*(\\.[a-zA-Z0-9]([a-zA-Z0-9-]*[a-zA-Z0-9])*)*$")
  @path
  @key("dataNetworkName")
  @segment("dataNetworks")
  @visibility("read")
  name: string;
}

@armResourceOperations
interface DataNetworks {
  @doc("Gets information about the specified data network.")
  get is ArmResourceRead<DataNetwork>;

  @doc("Creates or updates a data network. Must be created in the same location as its parent mobile network.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<DataNetwork>;

  @doc("Updates data network tags.")
  @parameterVisibility("read")
  updateTags is ArmCustomPatchSync<DataNetwork, TagsObject>;

  @doc("Deletes the specified data network.")
  delete is ArmResourceDeleteWithoutOkAsync<DataNetwork>;

  @doc("Lists all data networks in the mobile network.")
  listByMobileNetwork is ArmResourceListByParent<DataNetwork>;
}

@@doc(DataNetworks.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update data network operation."
);
@@doc(DataNetworks.updateTags::parameters.properties,
  "Parameters supplied to update data network tags."
);
