import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./DnsForwardingRuleset.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.Network;
@doc("Describes a virtual network link.")
@parentResource(DnsForwardingRuleset)
model VirtualNetworkLink is ProxyResource<VirtualNetworkLinkProperties> {
  @doc("The name of the virtual network link.")
  @path
  @key("virtualNetworkLinkName")
  @segment("virtualNetworkLinks")
  name: string;
}

@armResourceOperations
interface VirtualNetworkLinks {
  @doc("Gets properties of a virtual network link to a DNS forwarding ruleset.")
  get is ArmResourceRead<VirtualNetworkLink>;
  @doc("Creates or updates a virtual network link to a DNS forwarding ruleset.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    VirtualNetworkLink,
    {
      ...BaseParameters<VirtualNetworkLink>;

      @doc("ETag of the resource. Omit this value to always overwrite the current resource. Specify the last-seen ETag value to prevent accidentally overwriting any concurrent changes.")
      @header
      IfMatch?: string;

      @doc("Set to '*' to allow a new resource to be created, but to prevent updating an existing resource. Other values will be ignored.")
      @header
      IfNoneMatch?: string;
    }
  >;
  @doc("Updates a virtual network link to a DNS forwarding ruleset.")
  update is ArmResourcePatchAsync<
    VirtualNetworkLink,
    VirtualNetworkLinkProperties,
    {
      ...BaseParameters<VirtualNetworkLink>;

      @doc("ETag of the resource. Omit this value to always overwrite the current resource. Specify the last-seen ETag value to prevent accidentally overwriting any concurrent changes.")
      @header
      IfMatch?: string;
    }
  >;
  @doc("Deletes a virtual network link to a DNS forwarding ruleset. WARNING: This operation cannot be undone.")
  delete is ArmResourceDeleteAsync<
    VirtualNetworkLink,
    {
      ...BaseParameters<VirtualNetworkLink>;

      @doc("ETag of the resource. Omit this value to always overwrite the current resource. Specify the last-seen ETag value to prevent accidentally overwriting any concurrent changes.")
      @header
      IfMatch?: string;
    }
  >;
  @doc("Lists virtual network links to a DNS forwarding ruleset.")
  list is ArmResourceListByParent<
    VirtualNetworkLink,
    {
      ...BaseParameters<VirtualNetworkLink>;

      @doc("The maximum number of results to return. If not specified, returns up to 100 results.")
      @query("$top")
      $top?: int32;
    }
  >;
}
