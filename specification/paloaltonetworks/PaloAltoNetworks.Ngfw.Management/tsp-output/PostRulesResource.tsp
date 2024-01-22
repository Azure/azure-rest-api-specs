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
/**
 * PostRulestack rule list
 */
@parentResource(GlobalRulestackResource)
model PostRulesResource is ProxyResource<RuleEntry> {
  /**
   * Post Rule priority
   */
  @path
  @key("priority")
  @segment("postRules")
  name: string;
}

@armResourceOperations
interface PostRulesResources {
  /**
   * Get a PostRulesResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PostRules_Get")
  get is ArmResourceRead<PostRulesResource>;

  /**
   * Create a PostRulesResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PostRules_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    PostRulesResource,
    BaseParameters<PostRulesResource>,
    ArmAsyncOperationHeader
  >;

  /**
   * Delete a PostRulesResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PostRules_Delete")
  delete is ArmResourceDeleteAsync<
    PostRulesResource,
    BaseParameters<PostRulesResource>,
    ArmAsyncOperationHeader
  >;

  /**
   * List PostRulesResource resources by Tenant
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PostRules_List")
  list is ArmResourceListByParent<PostRulesResource>;

  /**
   * Get counters
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
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

  /**
   * Refresh counters
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
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

  /**
   * Reset counters
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
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
