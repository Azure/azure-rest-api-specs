import "../models/common.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;

using TypeSpec.Http;

namespace Microsoft.ManagedNetworkFabric;
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" ""
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "Unsupported common type"
@doc("The IP Community resource definition.")
@Http.Private.includeInapplicableMetadataInPayload(false)
model IpCommunity extends Azure.ResourceManager.Foundations.TrackedResource {
  @doc("Name of the IP Community.")
  @pattern("^[a-zA-Z]{1}[a-zA-Z0-9-_]{2,127}$")
  @path
  @key("ipCommunityName")
  @segment("ipCommunities")
  @visibility(Lifecycle.Read)
  name: string;

  /** The IP Community Properties */
  properties: IpCommunityProperties;
}

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
  listByResourceGroup is ArmResourceListByParent<IpCommunity>;

  @doc("Implements IP Communities list by subscription GET method.")
  listBySubscription is ArmListBySubscription<IpCommunity>;
}

@@doc(IpCommunities.create::parameters.resource, "Request payload.");
@@doc(IpCommunities.update::parameters.properties,
  "IP Community properties to update."
);
