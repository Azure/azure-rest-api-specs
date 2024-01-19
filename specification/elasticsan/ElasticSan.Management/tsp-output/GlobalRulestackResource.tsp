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
@doc("PaloAltoNetworks GlobalRulestack")
@tenantResource
model GlobalRulestackResource is ProxyResource<RulestackProperties> {
  @doc("GlobalRulestack resource name")
  @path
  @key("globalRulestackName")
  @segment("globalRulestacks")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface GlobalRulestackResources {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get a GlobalRulestackResource")
  @operationId("GlobalRulestack_Get")
  get is ArmResourceRead<GlobalRulestackResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create a GlobalRulestackResource")
  @operationId("GlobalRulestack_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    GlobalRulestackResource,
    BaseParameters<GlobalRulestackResource>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Update a GlobalRulestackResource")
  @operationId("GlobalRulestack_Update")
  update is ArmCustomPatchSync<
    GlobalRulestackResource,
    GlobalRulestackResourceUpdate
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete a GlobalRulestackResource")
  @operationId("GlobalRulestack_Delete")
  delete is ArmResourceDeleteAsync<
    GlobalRulestackResource,
    BaseParameters<GlobalRulestackResource>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List GlobalRulestackResource resources by Tenant")
  @operationId("GlobalRulestack_List")
  list is ArmResourceListByParent<GlobalRulestackResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Commit rulestack configuration")
  @operationId("GlobalRulestack_commit")
  commit is ArmResourceActionNoResponseContentAsync<
    GlobalRulestackResource,
    void,
    BaseParameters<GlobalRulestackResource>,
    ArmLroLocationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get changelog")
  @operationId("GlobalRulestack_getChangeLog")
  getChangeLog is ArmResourceActionSync<
    GlobalRulestackResource,
    void,
    Changelog
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get the list of advanced security objects")
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

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List of AppIds for GlobalRulestack ApiVersion")
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

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List of countries for Rulestack")
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

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List of Firewalls associated with Rulestack")
  @operationId("GlobalRulestack_listFirewalls")
  listFirewalls is ArmResourceActionSync<
    GlobalRulestackResource,
    void,
    ListFirewallsResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List predefined URL categories for rulestack")
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

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List the security services for rulestack")
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

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Revert rulestack configuration")
  @operationId("GlobalRulestack_revert")
  revert is ArmResourceActionNoContentSync<GlobalRulestackResource, void>;
}
