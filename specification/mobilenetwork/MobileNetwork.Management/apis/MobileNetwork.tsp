import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";

import "../models/MobileNetworkModels.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MobileNetwork;

@doc("Mobile network resource.")
@resource("mobileNetworks")
model MobileNetwork is TrackedResource<MobileNetworkPropertiesFormat> {
  @doc("The name of the mobile network.")
  @maxLength(64)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]*$")
  @path
  @key("mobileNetworkName")
  @segment("mobileNetworks")
  @visibility("read")
  name: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  @doc("The identity used to retrieve any private keys used for SUPI concealment from Azure key vault.")
  identity?: ManagedServiceIdentity;
}

@armResourceOperations
interface MobileNetworks {
  @doc("Gets information about the specified mobile network.")
  get is ArmResourceRead<MobileNetwork>;

  @doc("Creates or updates a mobile network.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<MobileNetwork>;

  @doc("Updates mobile network tags and managed identity.")
  @parameterVisibility("read")
  updateTags is ArmCustomPatchSync<MobileNetwork, IdentityAndTagsObject>;

  @doc("Deletes the specified mobile network.")
  delete is ArmResourceDeleteWithoutOkAsync<MobileNetwork>;

  @doc("Lists all the mobile networks in a resource group.")
  listByResourceGroup is ArmResourceListByParent<MobileNetwork>;

  @doc("Lists all the mobile networks in a subscription.")
  listBySubscription is ArmListBySubscription<MobileNetwork>;

  @doc("Gets all the SIM groups assigned to a mobile network.")
  listSimGroups is ArmResourceActionSync<
    MobileNetwork,
    void,
    ResourceListResult<SimGroup>
  >;
}

@@doc(MobileNetworks.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update mobile network operation."
);
@@doc(MobileNetworks.updateTags::parameters.properties,
  "Parameters supplied to update mobile network tags and/or identity."
);
