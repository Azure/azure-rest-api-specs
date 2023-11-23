import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.Network;
@doc("Describes a DNS forwarding ruleset.")
model DnsForwardingRuleset is TrackedResource<DnsForwardingRulesetProperties> {
  @doc("The name of the DNS forwarding ruleset.")
  @path
  @key("dnsForwardingRulesetName")
  @segment("dnsForwardingRulesets")
  name: string;
}

@armResourceOperations
interface DnsForwardingRulesets {
  @doc("Gets a DNS forwarding ruleset properties.")
  get is ArmResourceRead<DnsForwardingRuleset>;
  @doc("Creates or updates a DNS forwarding ruleset.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    DnsForwardingRuleset,
    {
      ...BaseParameters<DnsForwardingRuleset>;

      @doc("ETag of the resource. Omit this value to always overwrite the current resource. Specify the last-seen ETag value to prevent accidentally overwriting any concurrent changes.")
      @header
      IfMatch?: string;

      @doc("Set to '*' to allow a new resource to be created, but to prevent updating an existing resource. Other values will be ignored.")
      @header
      IfNoneMatch?: string;
    }
  >;
  @doc("Updates a DNS forwarding ruleset.")
  update is ArmTagsPatchAsync<
    DnsForwardingRuleset,
    {
      ...BaseParameters<DnsForwardingRuleset>;

      @doc("ETag of the resource. Omit this value to always overwrite the current resource. Specify the last-seen ETag value to prevent accidentally overwriting any concurrent changes.")
      @header
      IfMatch?: string;
    }
  >;
  @doc("Deletes a DNS forwarding ruleset. WARNING: This operation cannot be undone. All forwarding rules within the ruleset will be deleted.")
  delete is ArmResourceDeleteAsync<
    DnsForwardingRuleset,
    {
      ...BaseParameters<DnsForwardingRuleset>;

      @doc("ETag of the resource. Omit this value to always overwrite the current resource. Specify the last-seen ETag value to prevent accidentally overwriting any concurrent changes.")
      @header
      IfMatch?: string;
    }
  >;
  @doc("Lists DNS forwarding rulesets within a resource group.")
  listByResourceGroup is ArmResourceListByParent<
    DnsForwardingRuleset,
    {
      ...BaseParameters<DnsForwardingRuleset>;

      @doc("The maximum number of results to return. If not specified, returns up to 100 results.")
      @query("$top")
      $top?: int32;
    }
  >;
  @doc("Lists DNS forwarding rulesets in all resource groups of a subscription.")
  list is ArmListBySubscription<DnsForwardingRuleset>;
}
