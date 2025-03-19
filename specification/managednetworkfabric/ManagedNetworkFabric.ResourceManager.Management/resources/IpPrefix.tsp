import "../models/common.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;

using TypeSpec.Http;

namespace Microsoft.ManagedNetworkFabric;
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" ""
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "Unsupported common type"
@doc("The IP Prefix resource definition.")
@Http.Private.includeInapplicableMetadataInPayload(false)
model IpPrefix extends Azure.ResourceManager.Foundations.TrackedResource {
  @doc("Name of the IP Prefix.")
  @pattern("^[a-zA-Z]{1}[a-zA-Z0-9-_]{2,127}$")
  @path
  @key("ipPrefixName")
  @segment("ipPrefixes")
  @visibility(Lifecycle.Read)
  name: string;

  /** The IP Prefix properties */
  properties: IpPrefixProperties;
}

@armResourceOperations
interface IpPrefixes {
  @doc("Implements IP Prefix GET method.")
  get is ArmResourceRead<IpPrefix>;

  @doc("Implements IP Prefix PUT method.")
  create is ArmResourceCreateOrReplaceAsync<IpPrefix>;

  @doc("API to update certain properties of the IP Prefix resource.")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<IpPrefix, IpPrefixPatch>;

  @doc("Implements IP Prefix DELETE method.")
  delete is ArmResourceDeleteWithoutOkAsync<IpPrefix>;

  @doc("Implements IpPrefixes list by resource group GET method.")
  listByResourceGroup is ArmResourceListByParent<IpPrefix>;

  @doc("Implements IpPrefixes list by subscription GET method.")
  listBySubscription is ArmListBySubscription<IpPrefix>;
}

@@doc(IpPrefixes.create::parameters.resource, "Request payload.");
@@doc(IpPrefixes.update::parameters.properties,
  "IP Prefix properties to update."
);
