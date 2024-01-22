import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace PaloAltoNetworks.Cloudngfw;
/**
 * PaloAltoNetworks GlobalRulestack
 */
@tenantResource
model GlobalRulestackResource is ProxyResource<RulestackProperties> {
  /**
   * GlobalRulestack resource name
   */
  @path
  @key("globalRulestackName")
  @segment("globalRulestacks")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface GlobalRulestackResources {
  /**
   * Get a GlobalRulestackResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("GlobalRulestack_Get")
  get is ArmResourceRead<GlobalRulestackResource>;

  /**
   * Create a GlobalRulestackResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("GlobalRulestack_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    GlobalRulestackResource,
    BaseParameters<GlobalRulestackResource>,
    ArmAsyncOperationHeader
  >;

  /**
   * Update a GlobalRulestackResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("GlobalRulestack_Update")
  update is ArmCustomPatchSync<
    GlobalRulestackResource,
    GlobalRulestackResourceUpdate
  >;

  /**
   * Delete a GlobalRulestackResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("GlobalRulestack_Delete")
  delete is ArmResourceDeleteAsync<
    GlobalRulestackResource,
    BaseParameters<GlobalRulestackResource>,
    ArmAsyncOperationHeader
  >;

  /**
   * List GlobalRulestackResource resources by Tenant
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("GlobalRulestack_List")
  list is ArmResourceListByParent<GlobalRulestackResource>;

  /**
   * Commit rulestack configuration
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("GlobalRulestack_commit")
  commit is ArmResourceActionNoResponseContentAsync<
    GlobalRulestackResource,
    void,
    BaseParameters<GlobalRulestackResource>,
    ArmLroLocationHeader
  >;

  /**
   * Get changelog
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("GlobalRulestack_getChangeLog")
  getChangeLog is ArmResourceActionSync<
    GlobalRulestackResource,
    void,
    Changelog
  >;

  /**
   * Get the list of advanced security objects
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("GlobalRulestack_listAdvancedSecurityObjects")
  listAdvancedSecurityObjects is ArmResourceActionSync<
    GlobalRulestackResource,
    void,
    AdvSecurityObjectListResponse,
    {
      ...BaseParameters<GlobalRulestackResource>;

      @query("skip")
      skip?: string;

      @query("top")
      top?: int32;

      @query("type")
      type: AdvSecurityObjectTypeEnum;
    }
  >;

  /**
   * List of AppIds for GlobalRulestack ApiVersion
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("GlobalRulestack_listAppIds")
  listAppIds is ArmResourceActionSync<
    GlobalRulestackResource,
    void,
    ListAppIdResponse,
    {
      ...BaseParameters<GlobalRulestackResource>;

      @query("appIdVersion")
      appIdVersion?: string;

      @query("appPrefix")
      appPrefix?: string;

      @query("skip")
      skip?: string;

      @query("top")
      top?: int32;
    }
  >;

  /**
   * List of countries for Rulestack
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("GlobalRulestack_listCountries")
  listCountries is ArmResourceActionSync<
    GlobalRulestackResource,
    void,
    CountriesResponse,
    {
      ...BaseParameters<GlobalRulestackResource>;

      @query("skip")
      skip?: string;

      @query("top")
      top?: int32;
    }
  >;

  /**
   * List of Firewalls associated with Rulestack
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("GlobalRulestack_listFirewalls")
  listFirewalls is ArmResourceActionSync<
    GlobalRulestackResource,
    void,
    ListFirewallsResponse
  >;

  /**
   * List predefined URL categories for rulestack
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("GlobalRulestack_listPredefinedUrlCategories")
  listPredefinedUrlCategories is ArmResourceActionSync<
    GlobalRulestackResource,
    void,
    PredefinedUrlCategoriesResponse,
    {
      ...BaseParameters<GlobalRulestackResource>;

      @query("skip")
      skip?: string;

      @query("top")
      top?: int32;
    }
  >;

  /**
   * List the security services for rulestack
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("GlobalRulestack_listSecurityServices")
  listSecurityServices is ArmResourceActionSync<
    GlobalRulestackResource,
    void,
    SecurityServicesResponse,
    {
      ...BaseParameters<GlobalRulestackResource>;

      @query("skip")
      skip?: string;

      @query("top")
      top?: int32;

      @query("type")
      type: SecurityServicesTypeEnum;
    }
  >;

  /**
   * Revert rulestack configuration
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("GlobalRulestack_revert")
  revert is ArmResourceActionNoContentSync<GlobalRulestackResource, void>;
}
