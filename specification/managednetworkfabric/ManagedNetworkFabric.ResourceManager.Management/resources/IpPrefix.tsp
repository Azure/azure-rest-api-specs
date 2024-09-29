import "../models/common.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;

using TypeSpec.Http;

namespace Microsoft.ManagedNetworkFabric;
/**
 * The IP Prefix resource definition.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" ""
@includeInapplicableMetadataInPayload(false)
model IpPrefix extends Azure.ResourceManager.Foundations.TrackedResource {
  /**
   * Name of the IP Prefix.
   */
  @pattern("^[a-zA-Z]{1}[a-zA-Z0-9-_]{2,127}$")
  @path
  @key("ipPrefixName")
  @segment("ipPrefixes")
  @visibility("read")
  name: string;

  /** The IP Prefix properties */
  properties: IpPrefixProperties;
}

@armResourceOperations
interface IpPrefixes {
  /**
   * Implements IP Prefix GET method.
   */
  get is ArmResourceRead<IpPrefix>;

  /**
   * Implements IP Prefix PUT method.
   */
  create is ArmResourceCreateOrReplaceAsync<IpPrefix>;

  /**
   * API to update certain properties of the IP Prefix resource.
   */
  @parameterVisibility
  update is ArmCustomPatchAsync<IpPrefix, IpPrefixPatch>;

  /**
   * Implements IP Prefix DELETE method.
   */
  delete is ArmResourceDeleteWithoutOkAsync<IpPrefix>;

  /**
   * Implements IpPrefixes list by resource group GET method.
   */
  listByResourceGroup is ArmResourceListByParent<IpPrefix>;

  /**
   * Implements IpPrefixes list by subscription GET method.
   */
  listBySubscription is ArmListBySubscription<IpPrefix>;
}

@@doc(IpPrefixes.create::parameters.resource, "Request payload.");
@@doc(IpPrefixes.update::parameters.properties,
  "IP Prefix properties to update."
);
