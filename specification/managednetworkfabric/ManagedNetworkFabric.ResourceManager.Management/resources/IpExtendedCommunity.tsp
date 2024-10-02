import "../models/common.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;

using TypeSpec.Http;

namespace Microsoft.ManagedNetworkFabric;
/**
 * The IP Extended Community resource definition.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" ""
@includeInapplicableMetadataInPayload(false)
model IpExtendedCommunity
  extends Azure.ResourceManager.Foundations.TrackedResource {
  /**
   * Name of the IP Extended Community.
   */
  @pattern("^[a-zA-Z]{1}[a-zA-Z0-9-_]{2,127}$")
  @path
  @key("ipExtendedCommunityName")
  @segment("ipExtendedCommunities")
  @visibility("read")
  name: string;

  /** The IpExtendedCommunity properties */
  properties: IpExtendedCommunityProperties;
}

@armResourceOperations
interface IpExtendedCommunities {
  /**
   * Implements IP Extended Community GET method.
   */
  get is ArmResourceRead<IpExtendedCommunity>;

  /**
   * Implements IP Extended Community PUT method.
   */
  create is ArmResourceCreateOrReplaceAsync<IpExtendedCommunity>;

  /**
   * API to update certain properties of the IP Extended Community resource.
   */
  @parameterVisibility
  update is ArmCustomPatchAsync<IpExtendedCommunity, IpExtendedCommunityPatch>;

  /**
   * Implements IP Extended Community DELETE method.
   */
  delete is ArmResourceDeleteWithoutOkAsync<IpExtendedCommunity>;

  /**
   * Implements IpExtendedCommunities list by resource group GET method.
   */
  listByResourceGroup is ArmResourceListByParent<IpExtendedCommunity>;

  /**
   * Implements IpExtendedCommunities list by subscription GET method.
   */
  listBySubscription is ArmListBySubscription<IpExtendedCommunity>;
}

@@doc(IpExtendedCommunities.create::parameters.resource, "Request payload.");
@@doc(IpExtendedCommunities.update::parameters.properties,
  "IP Extended Community properties to update."
);
