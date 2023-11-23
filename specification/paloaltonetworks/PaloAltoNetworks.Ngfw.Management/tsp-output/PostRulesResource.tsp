import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./GlobalRulestackResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace PaloAltoNetworks.Cloudngfw;
@doc("PostRulestack rule list")
@parentResource(GlobalRulestackResource)
model PostRulesResource is ProxyResource<RuleEntry> {
  @doc("Post Rule priority")
  @path
  @key("priority")
  @segment("postRules")
  name: string;
}

@armResourceOperations
interface PostRulesResources {
  @doc("Get a PostRulesResource")
  get is ArmResourceRead<PostRulesResource>;
  @doc("Create a PostRulesResource")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<PostRulesResource>;
  @doc("Delete a PostRulesResource")
  delete is ArmResourceDeleteAsync<PostRulesResource>;
  @doc("List PostRulesResource resources by Tenant")
  list is ArmResourceListByParent<PostRulesResource>;
  @doc("Get counters")
  getCounters is ArmResourceActionSync<
    PostRulesResource,
    {},
    RuleCounter,
    {
      ...BaseParameters<PostRulesResource>;

      @query("firewallName")
      firewallName?: string;
    }
  >;
  @doc("Refresh counters")
  refreshCounters is ArmResourceActionNoContentSync<
    PostRulesResource,
    {},
    {
      ...BaseParameters<PostRulesResource>;

      @query("firewallName")
      firewallName?: string;
    }
  >;
  @doc("Reset counters")
  resetCounters is ArmResourceActionSync<
    PostRulesResource,
    {},
    RuleCounterReset,
    {
      ...BaseParameters<PostRulesResource>;

      @query("firewallName")
      firewallName?: string;
    }
  >;
}
