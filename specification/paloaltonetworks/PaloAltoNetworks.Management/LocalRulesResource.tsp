import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./LocalRulestackResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace PaloAltoNetworks.Cloudngfw;
/**
 * LocalRulestack rule list
 */
@parentResource(LocalRulestackResource)
model LocalRulesResource
  is Azure.ResourceManager.ProxyResource<RuleEntry, false> {
  ...ResourceNameParameter<
    Resource = LocalRulesResource,
    KeyName = "priority",
    SegmentName = "localRules",
    NamePattern = ""
  >;
}

@armResourceOperations
interface LocalRulesResources {
  /**
   * Get a LocalRulesResource
   */
  get is ArmResourceRead<LocalRulesResource>;

  /**
   * Create a LocalRulesResource
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<LocalRulesResource>;

  /**
   * Delete a LocalRulesResource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    LocalRulesResource,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader> | ArmNoContentResponse
  >;

  /**
   * List LocalRulesResource resources by LocalRulestacks
   */
  listByLocalRulestacks is ArmResourceListByParent<LocalRulesResource>;

  /**
   * Get counters
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("LocalRules_getCounters")
  getCounters is ArmResourceActionSync<
    LocalRulesResource,
    void,
    ArmResponse<RuleCounter>,
    Parameters = {
      #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @query("firewallName")
      firewallName?: string;
    }
  >;

  /**
   * Refresh counters
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("LocalRules_refreshCounters")
  refreshCounters is ArmResourceActionSync<
    LocalRulesResource,
    void,
    NoContentResponse,
    Parameters = {
      #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @query("firewallName")
      firewallName?: string;
    }
  >;

  /**
   * Reset counters
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("LocalRules_resetCounters")
  resetCounters is ArmResourceActionSync<
    LocalRulesResource,
    void,
    ArmResponse<RuleCounterReset>,
    Parameters = {
      #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @query("firewallName")
      firewallName?: string;
    }
  >;
}

@@doc(LocalRulesResource.name, "Local Rule priority");
@@doc(LocalRulesResource.properties,
  "The resource-specific properties for this resource."
);
