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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PostRules_Get")
  get is ArmResourceRead<PostRulesResource>;

  /**
   * Create a PostRulesResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PostRules_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<PostRulesResource>;

  /**
   * Delete a PostRulesResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("PostRules_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    PostRulesResource,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse
  >;

  /**
   * List PostRulesResource resources by Tenant
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PostRules_List")
  list is ArmResourceListByParent<PostRulesResource>;

  /**
   * Get counters
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PostRules_getCounters")
  getCounters is ArmResourceActionSync<
    PostRulesResource,
    void,
    ArmResponse<RuleCounter>,
    Parameters = {
      #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
      @query("firewallName")
      firewallName?: string;
    }
  >;

  /**
   * Refresh counters
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PostRules_refreshCounters")
  refreshCounters is ArmResourceActionSync<
    PostRulesResource,
    void,
    NoContentResponse,
    Parameters = {
      #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
      @query("firewallName")
      firewallName?: string;
    }
  >;

  /**
   * Reset counters
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PostRules_resetCounters")
  resetCounters is ArmResourceActionSync<
    PostRulesResource,
    void,
    ArmResponse<RuleCounterReset>,
    Parameters = {
      #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
      @query("firewallName")
      firewallName?: string;
    }
  >;
}

@@doc(PostRulesResource.name, "Post Rule priority");
@@doc(PostRulesResource.properties,
  "The resource-specific properties for this resource."
);
