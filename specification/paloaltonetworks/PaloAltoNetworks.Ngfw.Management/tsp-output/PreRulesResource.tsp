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
@doc("PreRulestack rule list")
@parentResource(GlobalRulestackResource)
model PreRulesResource is ProxyResource<RuleEntry> {
  @doc("Pre Rule priority")
  @key("priority")
  @segment("preRules")
  name: string;
}

@armResourceOperations
@projectedName("client", "PreRules")
interface PreRulesResources_PreRules {
  @doc("Get a PreRulesResource")
  get is ArmResourceRead<PreRulesResource>;

  @doc("Create a PreRulesResource")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<PreRulesResource>;

  @doc("Delete a PreRulesResource")
  delete is ArmResourceDeleteAsync<PreRulesResource>;

  @doc("List PreRulesResource resources by Tenant")
  list is ArmResourceListByParent<PreRulesResource>;

  @doc("Get counters")
  getCounters is ArmResourceActionSync<
    PreRulesResource,
    void,
    RuleCounter,
    {
      ...BaseParameters<PreRulesResource>;

      @query("firewallName")
      firewallName?: string;
    }
  >;

  @doc("Refresh counters")
  refreshCounters is ArmResourceActionNoContentSync<
    PreRulesResource,
    void,
    {
      ...BaseParameters<PreRulesResource>;

      @query("firewallName")
      firewallName?: string;
    }
  >;

  @doc("Reset counters")
  resetCounters is ArmResourceActionSync<
    PreRulesResource,
    void,
    RuleCounterReset,
    {
      ...BaseParameters<PreRulesResource>;

      @query("firewallName")
      firewallName?: string;
    }
  >;
}
