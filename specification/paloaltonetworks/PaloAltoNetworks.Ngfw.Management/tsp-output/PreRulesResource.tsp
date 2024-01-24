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
 * PreRulestack rule list
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(GlobalRulestackResource)
@Azure.ResourceManager.Private.armResourceInternal(RuleEntry)
@includeInapplicableMetadataInPayload(false)
model PreRulesResource extends ProxyResourceBase {
  /**
   * Pre Rule priority
   */
  @path
  @key("priority")
  @segment("preRules")
  name: string;

  /**
   * The resource-specific properties for this resource.
   */
  @extension("x-ms-client-flatten", true)
  @visibility("read,create")
  properties: RuleEntry;
}

@armResourceOperations
interface PreRulesResources {
  /**
   * Get a PreRulesResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PreRules_Get")
  get is ArmResourceRead<PreRulesResource>;

  /**
   * Create a PreRulesResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PreRules_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    PreRulesResource,
    BaseParameters<PreRulesResource>,
    ArmAsyncOperationHeader
  >;

  /**
   * Delete a PreRulesResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PreRules_Delete")
  delete is ArmResourceDeleteAsync<
    PreRulesResource,
    BaseParameters<PreRulesResource>,
    ArmAsyncOperationHeader
  >;

  /**
   * List PreRulesResource resources by Tenant
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PreRules_List")
  list is ArmResourceListByParent<PreRulesResource>;

  /**
   * Get counters
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
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

  /**
   * Refresh counters
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
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

  /**
   * Reset counters
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
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
