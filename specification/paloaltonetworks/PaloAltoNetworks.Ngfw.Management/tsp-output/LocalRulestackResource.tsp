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
 * PaloAltoNetworks LocalRulestack
 */
model LocalRulestackResource is TrackedResource<RulestackProperties> {
  /**
   * LocalRulestack resource name
   */
  @path
  @key("localRulestackName")
  @segment("localRulestacks")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface LocalRulestackResources {
  /**
   * Get a LocalRulestackResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("LocalRulestacks_Get")
  get is ArmResourceRead<LocalRulestackResource>;

  /**
   * Create a LocalRulestackResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("LocalRulestacks_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    LocalRulestackResource,
    BaseParameters<LocalRulestackResource>,
    ArmAsyncOperationHeader
  >;

  /**
   * Update a LocalRulestackResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("LocalRulestacks_Update")
  update is ArmCustomPatchSync<
    LocalRulestackResource,
    LocalRulestackResourceUpdate
  >;

  /**
   * Delete a LocalRulestackResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("LocalRulestacks_Delete")
  delete is ArmResourceDeleteAsync<
    LocalRulestackResource,
    BaseParameters<LocalRulestackResource>,
    ArmAsyncOperationHeader
  >;

  /**
   * List LocalRulestackResource resources by resource group
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("LocalRulestacks_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<LocalRulestackResource>;

  /**
   * List LocalRulestackResource resources by subscription ID
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("LocalRulestacks_ListBySubscription")
  listBySubscription is ArmListBySubscription<LocalRulestackResource>;

  /**
   * Commit rulestack configuration
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("LocalRulestacks_commit")
  commit is ArmResourceActionNoResponseContentAsync<
    LocalRulestackResource,
    void,
    BaseParameters<LocalRulestackResource>,
    ArmLroLocationHeader
  >;

  /**
   * Get changelog
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("LocalRulestacks_getChangeLog")
  getChangeLog is ArmResourceActionSync<
    LocalRulestackResource,
    void,
    Changelog
  >;

  /**
   * support info for rulestack.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("LocalRulestacks_getSupportInfo")
  getSupportInfo is ArmResourceActionSync<
    LocalRulestackResource,
    void,
    SupportInfo,
    {
      ...BaseParameters<LocalRulestackResource>;

      /**
       * email address on behalf of which this API called
       */
      @query("email")
      email?: string;
    }
  >;

  /**
   * Get the list of advanced security objects
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("LocalRulestacks_listAdvancedSecurityObjects")
  listAdvancedSecurityObjects is ArmResourceActionSync<
    LocalRulestackResource,
    void,
    AdvSecurityObjectListResponse,
    {
      ...BaseParameters<LocalRulestackResource>;

      @query("skip")
      skip?: string;

      @query("top")
      top?: int32;

      @query("type")
      type: AdvSecurityObjectTypeEnum;
    }
  >;

  /**
   * List of AppIds for LocalRulestack ApiVersion
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("LocalRulestacks_listAppIds")
  listAppIds is ArmResourceActionSync<
    LocalRulestackResource,
    void,
    ListAppIdResponse,
    {
      ...BaseParameters<LocalRulestackResource>;

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
  @operationId("LocalRulestacks_listCountries")
  listCountries is ArmResourceActionSync<
    LocalRulestackResource,
    void,
    CountriesResponse,
    {
      ...BaseParameters<LocalRulestackResource>;

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
  @operationId("LocalRulestacks_listFirewalls")
  listFirewalls is ArmResourceActionSync<
    LocalRulestackResource,
    void,
    ListFirewallsResponse
  >;

  /**
   * List predefined URL categories for rulestack
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("LocalRulestacks_listPredefinedUrlCategories")
  listPredefinedUrlCategories is ArmResourceActionSync<
    LocalRulestackResource,
    void,
    PredefinedUrlCategoriesResponse,
    {
      ...BaseParameters<LocalRulestackResource>;

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
  @operationId("LocalRulestacks_listSecurityServices")
  listSecurityServices is ArmResourceActionSync<
    LocalRulestackResource,
    void,
    SecurityServicesResponse,
    {
      ...BaseParameters<LocalRulestackResource>;

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
  @operationId("LocalRulestacks_revert")
  revert is ArmResourceActionNoContentSync<LocalRulestackResource, void>;
}
