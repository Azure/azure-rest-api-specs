import "../models/common.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Microsoft.ManagedNetworkFabric;
@doc("The IP Community resource definition.")
model IpCommunity
  is Azure.ResourceManager.TrackedResource<IpCommunityProperties, false> {
  @doc("Name of the IP Community.")
  @pattern("^[a-zA-Z]{1}[a-zA-Z0-9-_]{2,127}$")
  @path
  @key("ipCommunityName")
  @segment("ipCommunities")
  @visibility(Lifecycle.Read)
  name: string;
}

@@doc(IpCommunity.properties, "The IP Community Properties");

@armResourceOperations
interface IpCommunities {
  @doc("Implements an IP Community GET method.")
  get is ArmResourceRead<IpCommunity>;

  @doc("Implements an IP Community PUT method.")
  create is ArmResourceCreateOrReplaceAsync<IpCommunity>;

  @doc("API to update certain properties of the IP Community resource.")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<IpCommunity, IpCommunityPatch>;

  @doc("Implements IP Community DELETE method.")
  delete is ArmResourceDeleteWithoutOkAsync<IpCommunity>;

  @doc("Implements IP Communities list by resource group GET method.")
  listByResourceGroup is ArmResourceListByParent<
    IpCommunity,
    Response = IpCommunitiesListResult
  >;

  @doc("Implements IP Communities list by subscription GET method.")
  listBySubscription is ArmListBySubscription<
    IpCommunity,
    Response = IpCommunitiesListResult
  >;
}

@@doc(IpCommunities.create::parameters.resource, "Request payload.");
@@doc(
  IpCommunities.update::parameters.properties,
  "IP Community properties to update."
);
