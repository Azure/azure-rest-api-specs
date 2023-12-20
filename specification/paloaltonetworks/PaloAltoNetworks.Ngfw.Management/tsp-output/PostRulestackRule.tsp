import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./GlobalRulestack.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.PaloAltoNetworks.Ngfw;
@doc("PostRulestack rule list")
@parentResource(GlobalRulestack)
model PostRulestackRule is ProxyResource<RuleEntry> {
  @doc("Post Rule priority")
  @path
  @key("priority")
  @segment("postRules")
  name: string;
}

@armResourceOperations
interface PostRulestackRules {
  @doc("Get a PostRulesResource")
  get is ArmResourceRead<PostRulestackRule>;
  @doc("Create a PostRulesResource")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<PostRulestackRule>;
  @doc("Delete a PostRulesResource")
  delete is ArmResourceDeleteAsync<PostRulestackRule>;
  @doc("List PostRulesResource resources by Tenant")
  list is ArmResourceListByParent<PostRulestackRule>;
  @doc("Get counters")
  getCounters is ArmResourceActionSync<
    PostRulestackRule,
    void,
    RuleCounter,
    {
      ...BaseParameters<PostRulestackRule>;

      @query("firewallName")
      firewallName?: string;
    }
  >;
  @doc("Refresh counters")
  refreshCounters is ArmResourceActionNoContentSync<
    PostRulestackRule,
    void,
    {
      ...BaseParameters<PostRulestackRule>;

      @query("firewallName")
      firewallName?: string;
    }
  >;
  @doc("Reset counters")
  resetCounters is ArmResourceActionSync<
    PostRulestackRule,
    void,
    RuleCounterReset,
    {
      ...BaseParameters<PostRulestackRule>;

      @query("firewallName")
      firewallName?: string;
    }
  >;
}
