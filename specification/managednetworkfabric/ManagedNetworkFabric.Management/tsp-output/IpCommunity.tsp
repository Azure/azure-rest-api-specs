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
@doc("The IP Community resource definition.")
model IpCommunity is TrackedResource<IpCommunityProperties> {
  @doc("Name of the IP Community.")
  @path
  @key("ipCommunityName")
  @segment("ipCommunities")
  name: string;
}

@armResourceOperations
interface IpCommunities {
  @doc("Implements an IP Community GET method.")
  get is ArmResourceRead<IpCommunity>;

  @doc("Implements an IP Community PUT method.")
  create is ArmResourceCreateOrUpdateAsync<
    IpCommunity,
    BaseParameters<IpCommunity>,
    ArmAsyncOperationHeader
  >;

  @doc("API to update certain properties of the IP Community resource.")
  update is ArmCustomPatchAsync<
    IpCommunity,
    IpCommunityPatch,
    BaseParameters<IpCommunity>,
    ArmLroLocationHeader
  >;

  @doc("Implements IP Community DELETE method.")
  delete is ArmResourceDeleteWithoutOkAsync<
    IpCommunity,
    BaseParameters<IpCommunity>,
    ArmLroLocationHeader
  >;

  @doc("Implements IP Communities list by resource group GET method.")
  listByResourceGroup is ArmResourceListByParent<IpCommunity>;

  @doc("Implements IP Communities list by subscription GET method.")
  listBySubscription is ArmListBySubscription<IpCommunity>;
}

@@projectedName(IpCommunities.create::parameters.resource, "json", "body");
@@extension(IpCommunities.create::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(IpCommunities.create::parameters.resource, "Request payload.");
@@projectedName(IpCommunities.update::parameters.properties, "json", "body");
@@extension(IpCommunities.update::parameters.properties,
  "x-ms-client-name",
  "body"
);
@@doc(IpCommunities.update::parameters.properties,
  "IP Community properties to update."
);
