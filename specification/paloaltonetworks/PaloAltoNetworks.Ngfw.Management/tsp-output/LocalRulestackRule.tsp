import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./LocalRulestack.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.PaloAltoNetworks.Ngfw;
@doc("LocalRulestack rule list")
@parentResource(LocalRulestack)
model LocalRulestackRule is ProxyResource<RuleEntry> {
  @doc("Local Rule priority")
  @path
  @key("priority")
  @segment("localRules")
  name: string;
}

@armResourceOperations
interface LocalRulestackRules {
  @doc("Get a LocalRulesResource")
  get is ArmResourceRead<LocalRulestackRule>;
  @doc("Create a LocalRulesResource")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<LocalRulestackRule>;
  @doc("Delete a LocalRulesResource")
  delete is ArmResourceDeleteAsync<LocalRulestackRule>;
  @doc("List LocalRulesResource resources by LocalRulestacks")
  listByLocalRulestacks is ArmResourceListByParent<LocalRulestackRule>;
  @doc("Get counters")
  getCounters is ArmResourceActionSync<
    LocalRulestackRule,
    void,
    RuleCounter,
    {
      ...BaseParameters<LocalRulestackRule>;

      @query("firewallName")
      firewallName?: string;
    }
  >;
  @doc("Refresh counters")
  refreshCounters is ArmResourceActionNoContentSync<
    LocalRulestackRule,
    void,
    {
      ...BaseParameters<LocalRulestackRule>;

      @query("firewallName")
      firewallName?: string;
    }
  >;
  @doc("Reset counters")
  resetCounters is ArmResourceActionSync<
    LocalRulestackRule,
    void,
    RuleCounterReset,
    {
      ...BaseParameters<LocalRulestackRule>;

      @query("firewallName")
      firewallName?: string;
    }
  >;
}
