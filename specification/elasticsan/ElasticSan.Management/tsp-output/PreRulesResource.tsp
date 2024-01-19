import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./GlobalRulestackResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace PaloAltoNetworks.Cloudngfw;
@doc("PreRulestack rule list")
@parentResource(GlobalRulestackResource)
model PreRulesResource is ProxyResource<RuleEntry> {
  @doc("Pre Rule priority")
  @path
  @key("priority")
  @segment("preRules")
  name: string;
}

@armResourceOperations
interface PreRulesResources {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get a PreRulesResource")
  @operationId("PreRules_Get")
  get is ArmResourceRead<PreRulesResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create a PreRulesResource")
  @operationId("PreRules_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    PreRulesResource,
    BaseParameters<PreRulesResource>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete a PreRulesResource")
  @operationId("PreRules_Delete")
  delete is ArmResourceDeleteAsync<
    PreRulesResource,
    BaseParameters<PreRulesResource>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List PreRulesResource resources by Tenant")
  @operationId("PreRules_List")
  list is ArmResourceListByParent<PreRulesResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get counters")
  @operationId("PreRules_getCounters")
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

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Refresh counters")
  @operationId("PreRules_refreshCounters")
  refreshCounters is ArmResourceActionNoContentSync<
    PreRulesResource,
    void,
    {
      ...BaseParameters<PreRulesResource>;

      @query("firewallName")
      firewallName?: string;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Reset counters")
  @operationId("PreRules_resetCounters")
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
