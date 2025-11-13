import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./GlobalRulestackResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace PaloAltoNetworks.Cloudngfw;
/**
 * PreRulestack rule list
 */
@parentResource(GlobalRulestackResource)
model PreRulesResource
  is Azure.ResourceManager.ProxyResource<RuleEntry, false> {
  ...ResourceNameParameter<
    Resource = PreRulesResource,
    KeyName = "priority",
    SegmentName = "preRules",
    NamePattern = ""
  >;
}

@armResourceOperations
interface PreRulesResources {
  /**
   * Get a PreRulesResource
   */
  get is ArmResourceRead<PreRulesResource>;

  /**
   * Create a PreRulesResource
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<PreRulesResource>;

  /**
   * Delete a PreRulesResource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    PreRulesResource,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader> | ArmNoContentResponse
  >;

  /**
   * List PreRulesResource resources by Tenant
   */
  list is ArmResourceListByParent<PreRulesResource>;

  /**
   * Get counters
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("PreRules_getCounters")
  getCounters is ArmResourceActionSync<
    PreRulesResource,
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
  @operationId("PreRules_refreshCounters")
  refreshCounters is ArmResourceActionSync<
    PreRulesResource,
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
  @operationId("PreRules_resetCounters")
  resetCounters is ArmResourceActionSync<
    PreRulesResource,
    void,
    ArmResponse<RuleCounterReset>,
    Parameters = {
      #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @query("firewallName")
      firewallName?: string;
    }
  >;
}

@@doc(PreRulesResource.name, "Pre Rule priority");
@@doc(PreRulesResource.properties,
  "The resource-specific properties for this resource."
);
