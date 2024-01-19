import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./LocalRulestackResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace PaloAltoNetworks.Cloudngfw;
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
interface LocalRulesResources {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get a LocalRulesResource")
  @operationId("LocalRules_Get")
  get is ArmResourceRead<LocalRulesResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create a LocalRulesResource")
  @operationId("LocalRules_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    LocalRulesResource,
    BaseParameters<LocalRulesResource>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete a LocalRulesResource")
  @operationId("LocalRules_Delete")
  delete is ArmResourceDeleteAsync<
    LocalRulesResource,
    BaseParameters<LocalRulesResource>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List LocalRulesResource resources by LocalRulestacks")
  @operationId("LocalRules_ListByLocalRulestacks")
  listByLocalRulestacks is ArmResourceListByParent<LocalRulesResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get counters")
  @operationId("LocalRules_getCounters")
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

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Refresh counters")
  @operationId("LocalRules_refreshCounters")
  refreshCounters is ArmResourceActionNoContentSync<
    LocalRulesResource,
    void,
    {
      ...BaseParameters<LocalRulesResource>;

      @query("firewallName")
      firewallName?: string;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Reset counters")
  @operationId("LocalRules_resetCounters")
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
