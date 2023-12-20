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
@doc("PreRulestack rule list")
@parentResource(GlobalRulestack)
model PreRulestackRule is ProxyResource<RuleEntry> {
  @doc("Pre Rule priority")
  @path
  @key("priority")
  @segment("preRules")
  name: string;
}

@armResourceOperations
interface PreRulestackRules {
  @doc("Get a PreRulesResource")
  get is ArmResourceRead<PreRulestackRule>;
  @doc("Create a PreRulesResource")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<PreRulestackRule>;
  @doc("Delete a PreRulesResource")
  delete is ArmResourceDeleteAsync<PreRulestackRule>;
  @doc("List PreRulesResource resources by Tenant")
  list is ArmResourceListByParent<PreRulestackRule>;
  @doc("Get counters")
  getCounters is ArmResourceActionSync<
    PreRulestackRule,
    void,
    RuleCounter,
    {
      ...BaseParameters<PreRulestackRule>;

      @query("firewallName")
      firewallName?: string;
    }
  >;
  @doc("Refresh counters")
  refreshCounters is ArmResourceActionNoContentSync<
    PreRulestackRule,
    void,
    {
      ...BaseParameters<PreRulestackRule>;

      @query("firewallName")
      firewallName?: string;
    }
  >;
  @doc("Reset counters")
  resetCounters is ArmResourceActionSync<
    PreRulestackRule,
    void,
    RuleCounterReset,
    {
      ...BaseParameters<PreRulestackRule>;

      @query("firewallName")
      firewallName?: string;
    }
  >;
}
