import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./LocalRulestackResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.PaloAltoNetworks.Ngfw;
@doc("LocalRulestack rule list")
@parentResource(LocalRulestackResource)
model LocalRulesResource is ProxyResource<RuleEntry> {
  @doc("Local Rule priority")
  @path
  @key("priority")
  @segment("localRules")
  name: string;
}

@armResourceOperations
interface LocalRules {
  @doc("Get a LocalRulesResource")
  get is ArmResourceRead<LocalRulesResource>;
  @doc("Create a LocalRulesResource")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<LocalRulesResource>;
  @doc("Delete a LocalRulesResource")
  delete is ArmResourceDeleteAsync<LocalRulesResource>;
  @doc("List LocalRulesResource resources by LocalRulestacks")
  listByLocalRulestacks is ArmResourceListByParent<LocalRulesResource>;
  @doc("Get counters")
  getCounters is ArmResourceActionSync<
    LocalRulesResource,
    void,
    RuleCounter,
    {
      ...BaseParameters<LocalRulesResource>;

      @query("firewallName")
      firewallName?: string;
    }
  >;
  @doc("Refresh counters")
  refreshCounters is ArmResourceActionNoContentSync<
    LocalRulesResource,
    void,
    {
      ...BaseParameters<LocalRulesResource>;

      @query("firewallName")
      firewallName?: string;
    }
  >;
  @doc("Reset counters")
  resetCounters is ArmResourceActionSync<
    LocalRulesResource,
    void,
    RuleCounterReset,
    {
      ...BaseParameters<LocalRulesResource>;

      @query("firewallName")
      firewallName?: string;
    }
  >;
}
