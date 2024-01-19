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
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get a PostRulesResource")
  @operationId("PostRules_Get")
  get is ArmResourceRead<PostRulesResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create a PostRulesResource")
  @operationId("PostRules_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    PostRulesResource,
    BaseParameters<PostRulesResource>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete a PostRulesResource")
  @operationId("PostRules_Delete")
  delete is ArmResourceDeleteAsync<
    PostRulesResource,
    BaseParameters<PostRulesResource>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List PostRulesResource resources by Tenant")
  @operationId("PostRules_List")
  list is ArmResourceListByParent<PostRulesResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get counters")
  @operationId("PostRules_getCounters")
  getCounters is ArmResourceActionSync<
    PostRulesResource,
    void,
    RuleCounter,
    {
      ...BaseParameters<PostRulesResource>;

      @query("firewallName")
      firewallName?: string;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Refresh counters")
  @operationId("PostRules_refreshCounters")
  refreshCounters is ArmResourceActionNoContentSync<
    PostRulesResource,
    void,
    {
      ...BaseParameters<PostRulesResource>;

      @query("firewallName")
      firewallName?: string;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Reset counters")
  @operationId("PostRules_resetCounters")
  resetCounters is ArmResourceActionSync<
    PostRulesResource,
    void,
    RuleCounterReset,
    {
      ...BaseParameters<PostRulesResource>;

      @query("firewallName")
      firewallName?: string;
    }
  >;
}
