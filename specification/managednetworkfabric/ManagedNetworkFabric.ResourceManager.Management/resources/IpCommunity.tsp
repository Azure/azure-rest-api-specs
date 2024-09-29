import "../models/common.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;

using TypeSpec.Http;

namespace Microsoft.ManagedNetworkFabric;
/**
 * The IP Community resource definition.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" ""
@includeInapplicableMetadataInPayload(false)
model IpCommunity extends Azure.ResourceManager.Foundations.TrackedResource {
  /**
   * Name of the IP Community.
   */
  @pattern("^[a-zA-Z]{1}[a-zA-Z0-9-_]{2,127}$")
  @path
  @key("ipCommunityName")
  @segment("ipCommunities")
  @visibility("read")
  name: string;

  /** The IP Community Properties */
  properties: IpCommunityProperties;
}

@armResourceOperations
interface IpCommunities {
  /**
   * Implements an IP Community GET method.
   */
  get is ArmResourceRead<IpCommunity>;

  /**
   * Implements an IP Community PUT method.
   */
  create is ArmResourceCreateOrReplaceAsync<IpCommunity>;

  /**
   * API to update certain properties of the IP Community resource.
   */
  @parameterVisibility
  update is ArmCustomPatchAsync<IpCommunity, IpCommunityPatch>;

  /**
   * Implements IP Community DELETE method.
   */
  delete is ArmResourceDeleteWithoutOkAsync<IpCommunity>;

  /**
   * Implements IP Communities list by resource group GET method.
   */
  listByResourceGroup is ArmResourceListByParent<IpCommunity>;

  /**
   * Implements IP Communities list by subscription GET method.
   */
  listBySubscription is ArmListBySubscription<IpCommunity>;
}

@@doc(IpCommunities.create::parameters.resource, "Request payload.");
@@doc(IpCommunities.update::parameters.properties,
  "IP Community properties to update."
);
