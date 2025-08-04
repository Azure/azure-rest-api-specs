import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace PaloAltoNetworks.Cloudngfw;
/**
 * PaloAltoNetworks GlobalRulestack
 */
@tenantResource
model GlobalRulestackResource
  is Azure.ResourceManager.ProxyResource<RulestackProperties, false> {
  ...ResourceNameParameter<
    Resource = GlobalRulestackResource,
    KeyName = "globalRulestackName",
    SegmentName = "globalRulestacks",
    NamePattern = ""
  >;

  /**
   * Global Location
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  location: string;

  /**
   * The managed service identities assigned to this resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  identity?: AzureResourceManagerManagedIdentityProperties;
}

@armResourceOperations
interface GlobalRulestackResources {
  /**
   * Get a GlobalRulestackResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("GlobalRulestack_Get")
  get is ArmResourceRead<
    GlobalRulestackResource,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;

  /**
   * Create a GlobalRulestackResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("GlobalRulestack_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    GlobalRulestackResource,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;

  /**
   * Update a GlobalRulestackResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("GlobalRulestack_Update")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    GlobalRulestackResource,
    PatchModel = GlobalRulestackResourceUpdate,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;

  /**
   * Delete a GlobalRulestackResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("GlobalRulestack_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    GlobalRulestackResource,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse
  >;

  /**
   * List GlobalRulestackResource resources by Tenant
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("GlobalRulestack_List")
  list is ArmResourceListByParent<
    GlobalRulestackResource,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;

  /**
   * Commit rulestack configuration
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("GlobalRulestack_commit")
  commit is ArmResourceActionAsyncBase<
    GlobalRulestackResource,
    void,
    ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;

  /**
   * Get changelog
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("GlobalRulestack_getChangeLog")
  getChangeLog is ArmResourceActionSync<
    GlobalRulestackResource,
    void,
    ArmResponse<Changelog>,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;

  /**
   * Get the list of advanced security objects
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("GlobalRulestack_listAdvancedSecurityObjects")
  listAdvancedSecurityObjects is ArmResourceActionSync<
    GlobalRulestackResource,
    void,
    ArmResponse<AdvSecurityObjectListResponse>,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Parameters = {
      #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
      @query("skip")
      skip?: string;

      #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
      @query("top")
      top?: int32;

      #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
      @query("type")
      type: AdvSecurityObjectTypeEnum;
    }
  >;

  /**
   * List of AppIds for GlobalRulestack ApiVersion
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("GlobalRulestack_listAppIds")
  listAppIds is ArmResourceActionSync<
    GlobalRulestackResource,
    void,
    ArmResponse<ListAppIdResponse>,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Parameters = {
      #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
      @query("appIdVersion")
      appIdVersion?: string;

      #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
      @query("appPrefix")
      appPrefix?: string;

      #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
      @query("skip")
      skip?: string;

      #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
      @query("top")
      top?: int32;
    }
  >;

  /**
   * List of countries for Rulestack
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("GlobalRulestack_listCountries")
  listCountries is ArmResourceActionSync<
    GlobalRulestackResource,
    void,
    ArmResponse<CountriesResponse>,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Parameters = {
      #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
      @query("skip")
      skip?: string;

      #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
      @query("top")
      top?: int32;
    }
  >;

  /**
   * List of Firewalls associated with Rulestack
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("GlobalRulestack_listFirewalls")
  listFirewalls is ArmResourceActionSync<
    GlobalRulestackResource,
    void,
    ArmResponse<ListFirewallsResponse>,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;

  /**
   * List predefined URL categories for rulestack
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("GlobalRulestack_listPredefinedUrlCategories")
  listPredefinedUrlCategories is ArmResourceActionSync<
    GlobalRulestackResource,
    void,
    ArmResponse<PredefinedUrlCategoriesResponse>,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Parameters = {
      #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
      @query("skip")
      skip?: string;

      #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
      @query("top")
      top?: int32;
    }
  >;

  /**
   * List the security services for rulestack
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("GlobalRulestack_listSecurityServices")
  listSecurityServices is ArmResourceActionSync<
    GlobalRulestackResource,
    void,
    ArmResponse<SecurityServicesResponse>,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Parameters = {
      #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
      @query("skip")
      skip?: string;

      #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
      @query("top")
      top?: int32;

      #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
      @query("type")
      type: SecurityServicesTypeEnum;
    }
  >;

  /**
   * Revert rulestack configuration
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("GlobalRulestack_revert")
  revert is ArmResourceActionSync<
    GlobalRulestackResource,
    void,
    NoContentResponse,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;
}

@@doc(GlobalRulestackResource.name, "GlobalRulestack resource name");
@@doc(GlobalRulestackResource.properties,
  "The resource-specific properties for this resource."
);
