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
/**
 * LocalRulestack rule list
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(LocalRulestackResource)
@Azure.ResourceManager.Private.armResourceInternal(RuleEntry)
@includeInapplicableMetadataInPayload(false)
model LocalRulesResource extends ProxyResourceBase {
  /**
   * Local Rule priority
   */
  @path
  @key("priority")
  @segment("localRules")
  name: string;

  /**
   * The resource-specific properties for this resource.
   */
  @extension("x-ms-client-flatten", true)
  @visibility("read,create")
  properties: RuleEntry;
}

@armResourceOperations
interface LocalRulesResources {
  /**
   * Get a LocalRulesResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("LocalRules_Get")
  get is ArmResourceRead<LocalRulesResource>;

  /**
   * Create a LocalRulesResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("LocalRules_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    LocalRulesResource,
    BaseParameters<LocalRulesResource>,
    ArmAsyncOperationHeader
  >;

  /**
   * Delete a LocalRulesResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("LocalRules_Delete")
  delete is ArmResourceDeleteAsync<
    LocalRulesResource,
    BaseParameters<LocalRulesResource>,
    ArmAsyncOperationHeader
  >;

  /**
   * List LocalRulesResource resources by LocalRulestacks
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("LocalRules_ListByLocalRulestacks")
  listByLocalRulestacks is ArmResourceListByParent<LocalRulesResource>;

  /**
   * Get counters
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
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

  /**
   * Refresh counters
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
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

  /**
   * Reset counters
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
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
