import "../models/common.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;

using TypeSpec.Http;

namespace Microsoft.ManagedNetworkFabric;
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" ""
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "Unsupported common type"
@doc("The IP Extended Community resource definition.")
@Http.Private.includeInapplicableMetadataInPayload(false)
model IpExtendedCommunity
  extends Azure.ResourceManager.Foundations.TrackedResource {
  @doc("Name of the IP Extended Community.")
  @pattern("^[a-zA-Z]{1}[a-zA-Z0-9-_]{2,127}$")
  @path
  @key("ipExtendedCommunityName")
  @segment("ipExtendedCommunities")
  @visibility(Lifecycle.Read)
  name: string;

  /** The IpExtendedCommunity properties */
  properties: IpExtendedCommunityProperties;
}

@armResourceOperations
interface IpExtendedCommunities {
  @doc("Implements IP Extended Community GET method.")
  get is ArmResourceRead<IpExtendedCommunity>;

  @doc("Implements IP Extended Community PUT method.")
  create is ArmResourceCreateOrReplaceAsync<IpExtendedCommunity>;

  @doc("API to update certain properties of the IP Extended Community resource.")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<IpExtendedCommunity, IpExtendedCommunityPatch>;

  @doc("Implements IP Extended Community DELETE method.")
  delete is ArmResourceDeleteWithoutOkAsync<IpExtendedCommunity>;

  @doc("Implements IpExtendedCommunities list by resource group GET method.")
  listByResourceGroup is ArmResourceListByParent<IpExtendedCommunity>;

  @doc("Implements IpExtendedCommunities list by subscription GET method.")
  listBySubscription is ArmListBySubscription<IpExtendedCommunity>;
}

@@doc(IpExtendedCommunities.create::parameters.resource, "Request payload.");
@@doc(IpExtendedCommunities.update::parameters.properties,
  "IP Extended Community properties to update."
);
