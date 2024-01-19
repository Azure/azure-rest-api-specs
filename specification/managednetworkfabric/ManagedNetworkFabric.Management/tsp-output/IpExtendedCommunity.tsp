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

namespace Microsoft.ManagedNetworkFabric;
@doc("The IP Extended Community resource definition.")
model IpExtendedCommunity is TrackedResource<IpExtendedCommunityProperties> {
  @doc("Name of the IP Extended Community.")
  @path
  @key("ipExtendedCommunityName")
  @segment("ipExtendedCommunities")
  name: string;
}

@armResourceOperations
interface IpExtendedCommunities {
  @doc("Implements IP Extended Community GET method.")
  get is ArmResourceRead<IpExtendedCommunity>;

  @doc("Implements IP Extended Community PUT method.")
  create is ArmResourceCreateOrUpdateAsync<
    IpExtendedCommunity,
    BaseParameters<IpExtendedCommunity>,
    ArmAsyncOperationHeader
  >;

  @doc("API to update certain properties of the IP Extended Community resource.")
  update is ArmCustomPatchAsync<
    IpExtendedCommunity,
    IpExtendedCommunityPatch,
    BaseParameters<IpExtendedCommunity>,
    ArmLroLocationHeader
  >;

  @doc("Implements IP Extended Community DELETE method.")
  delete is ArmResourceDeleteWithoutOkAsync<
    IpExtendedCommunity,
    BaseParameters<IpExtendedCommunity>,
    ArmLroLocationHeader
  >;

  @doc("Implements IpExtendedCommunities list by resource group GET method.")
  listByResourceGroup is ArmResourceListByParent<IpExtendedCommunity>;

  @doc("Implements IpExtendedCommunities list by subscription GET method.")
  listBySubscription is ArmListBySubscription<IpExtendedCommunity>;
}

@@projectedName(IpExtendedCommunities.create::parameters.resource,
  "json",
  "body"
);
@@extension(IpExtendedCommunities.create::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(IpExtendedCommunities.create::parameters.resource, "Request payload.");
@@projectedName(IpExtendedCommunities.update::parameters.properties,
  "json",
  "body"
);
@@extension(IpExtendedCommunities.update::parameters.properties,
  "x-ms-client-name",
  "body"
);
@@doc(IpExtendedCommunities.update::parameters.properties,
  "IP Extended Community properties to update."
);
