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
@doc("Describes a forwarding rule within a DNS forwarding ruleset.")
@parentResource(DnsForwardingRuleset)
model ForwardingRule is ProxyResource<ForwardingRuleProperties> {
  @doc("The name of the forwarding rule.")
  @path
  @key("forwardingRuleName")
  @segment("forwardingRules")
  name: string;
}

@armResourceOperations
interface ForwardingRules {
  @doc("Gets properties of a forwarding rule in a DNS forwarding ruleset.")
  get is ArmResourceRead<ForwardingRule>;
  @doc("Creates or updates a forwarding rule in a DNS forwarding ruleset.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    ForwardingRule,
    {
      ...BaseParameters<ForwardingRule>;

      @doc("ETag of the resource. Omit this value to always overwrite the current resource. Specify the last-seen ETag value to prevent accidentally overwriting any concurrent changes.")
      @header
      IfMatch?: string;

      @doc("Set to '*' to allow a new resource to be created, but to prevent updating an existing resource. Other values will be ignored.")
      @header
      IfNoneMatch?: string;
    }
  >;
  @doc("Updates a forwarding rule in a DNS forwarding ruleset.")
  update is ArmResourcePatchSync<
    ForwardingRule,
    ForwardingRuleProperties,
    {
      ...BaseParameters<ForwardingRule>;

      @doc("ETag of the resource. Omit this value to always overwrite the current resource. Specify the last-seen ETag value to prevent accidentally overwriting any concurrent changes.")
      @header
      IfMatch?: string;
    }
  >;
  @doc("Deletes a forwarding rule in a DNS forwarding ruleset. WARNING: This operation cannot be undone.")
  delete is ArmResourceDeleteSync<
    ForwardingRule,
    {
      ...BaseParameters<ForwardingRule>;

      @doc("ETag of the resource. Omit this value to always overwrite the current resource. Specify the last-seen ETag value to prevent accidentally overwriting any concurrent changes.")
      @header
      IfMatch?: string;
    }
  >;
  @doc("Lists forwarding rules in a DNS forwarding ruleset.")
  list is ArmResourceListByParent<
    ForwardingRule,
    {
      ...BaseParameters<ForwardingRule>;

      @doc("The maximum number of results to return. If not specified, returns up to 100 results.")
      @query("$top")
      $top?: int32;
    }
  >;
}
