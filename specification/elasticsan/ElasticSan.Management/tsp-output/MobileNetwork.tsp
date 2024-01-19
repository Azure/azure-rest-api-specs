import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MobileNetwork;
@doc("Mobile network resource.")
model MobileNetwork is TrackedResource<MobileNetworkPropertiesFormat> {
  @doc("The name of the mobile network.")
  @maxLength(64)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]*$")
  @path
  @key("mobileNetworkName")
  @segment("mobileNetworks")
  name: string;
}

@armResourceOperations
interface MobileNetworks {
  @doc("Gets information about the specified mobile network.")
  get is ArmResourceRead<MobileNetwork>;

  @doc("Creates or updates a mobile network.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    MobileNetwork,
    BaseParameters<MobileNetwork>,
    ArmAsyncOperationHeader
  >;

  @doc("Updates mobile network tags.")
  updateTags is ArmCustomPatchSync<MobileNetwork, TagsObject>;

  @doc("Deletes the specified mobile network.")
  delete is ArmResourceDeleteAsync<
    MobileNetwork,
    BaseParameters<MobileNetwork>,
    ArmLroLocationHeader
  >;

  @doc("Lists all the mobile networks in a resource group.")
  listByResourceGroup is ArmResourceListByParent<MobileNetwork>;

  @doc("Lists all the mobile networks in a subscription.")
  listBySubscription is ArmListBySubscription<MobileNetwork>;
}

@@projectedName(MobileNetworks.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(MobileNetworks.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(MobileNetworks.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update mobile network operation."
);
@@projectedName(MobileNetworks.updateTags::parameters.properties,
  "json",
  "parameters"
);
@@extension(MobileNetworks.updateTags::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(MobileNetworks.updateTags::parameters.properties,
  "Parameters supplied to update mobile network tags."
);
