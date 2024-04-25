import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";

import "../models/RadioAccessNetworkModels.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MobileNetwork;

@doc("Radio access network resource.")
@resource("radioAccessNetworks")
model RadioAccessNetwork is TrackedResource<RadioAccessNetworkProperties> {
  @doc("The name of the radio access network.")
  @maxLength(64)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]*$")
  @path
  @key("radioAccessNetworkName")
  @segment("radioAccessNetworks")
  @visibility("read")
  name: string;
}

@armResourceOperations
interface RadioAccessNetworks {
  @doc("Gets information about the specified radio access network.")
  get is ArmResourceRead<RadioAccessNetwork>;

  @doc("Creates or updates a radio access network.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<RadioAccessNetwork>;

  @doc("Updates a radio access network.")
  @parameterVisibility("read")
  update is ArmCustomPatchSync<RadioAccessNetwork, TagsObject>;

  @doc("Deletes the specified radio access network.")
  delete is ArmResourceDeleteWithoutOkAsync<RadioAccessNetwork>;

  @doc("Gets all the radio access networks in a resource group.")
  listByResourceGroup is ArmResourceListByParent<RadioAccessNetwork>;

  @doc("Gets all the radio access networks in a subscription.")
  listBySubscription is ArmListBySubscription<RadioAccessNetwork>;
}

@@doc(RadioAccessNetworks.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update radio access network operation."
);
@@doc(RadioAccessNetworks.update::parameters.properties,
  "Parameters supplied to update radio access network tags."
);
