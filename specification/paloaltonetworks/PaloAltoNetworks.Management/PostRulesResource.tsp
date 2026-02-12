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
 * PostRulestack rule list
 */
@parentResource(GlobalRulestackResource)
model PostRulesResource
  is Azure.ResourceManager.ProxyResource<RuleEntry, false> {
  ...ResourceNameParameter<
    Resource = PostRulesResource,
    KeyName = "priority",
    SegmentName = "postRules",
    NamePattern = ""
  >;
}

@armResourceOperations
interface PostRulesResources {
  /**
   * Get a PostRulesResource
   */
  get is ArmResourceRead<PostRulesResource>;

  /**
   * Create a PostRulesResource
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<PostRulesResource>;

  /**
   * Delete a PostRulesResource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    PostRulesResource,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader> | ArmNoContentResponse
  >;

  /**
   * List PostRulesResource resources by Tenant
   */
  list is ArmResourceListByParent<PostRulesResource>;

  /**
   * Get counters
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("PostRules_getCounters")
  getCounters is ArmResourceActionSync<
    PostRulesResource,
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
  @operationId("PostRules_refreshCounters")
  refreshCounters is ArmResourceActionSync<
    PostRulesResource,
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
  @operationId("PostRules_resetCounters")
  resetCounters is ArmResourceActionSync<
    PostRulesResource,
    void,
    ArmResponse<RuleCounterReset>,
    Parameters = {
      #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @query("firewallName")
      firewallName?: string;
    }
  >;
}

@@doc(PostRulesResource.name, "Post Rule priority");
@@doc(PostRulesResource.properties,
  "The resource-specific properties for this resource."
);
