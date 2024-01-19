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
@doc("PaloAltoNetworks LocalRulestack")
model LocalRulestackResource is TrackedResource<RulestackProperties> {
  @doc("LocalRulestack resource name")
  @path
  @key("localRulestackName")
  @segment("localRulestacks")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface LocalRulestackResources {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get a LocalRulestackResource")
  @operationId("LocalRulestacks_Get")
  get is ArmResourceRead<LocalRulestackResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create a LocalRulestackResource")
  @operationId("LocalRulestacks_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    LocalRulestackResource,
    BaseParameters<LocalRulestackResource>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Update a LocalRulestackResource")
  @operationId("LocalRulestacks_Update")
  update is ArmCustomPatchSync<
    LocalRulestackResource,
    LocalRulestackResourceUpdate
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete a LocalRulestackResource")
  @operationId("LocalRulestacks_Delete")
  delete is ArmResourceDeleteAsync<
    LocalRulestackResource,
    BaseParameters<LocalRulestackResource>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List LocalRulestackResource resources by resource group")
  @operationId("LocalRulestacks_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<LocalRulestackResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List LocalRulestackResource resources by subscription ID")
  @operationId("LocalRulestacks_ListBySubscription")
  listBySubscription is ArmListBySubscription<LocalRulestackResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Commit rulestack configuration")
  @operationId("LocalRulestacks_commit")
  commit is ArmResourceActionNoResponseContentAsync<
    LocalRulestackResource,
    void,
    BaseParameters<LocalRulestackResource>,
    ArmLroLocationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get changelog")
  @operationId("LocalRulestacks_getChangeLog")
  getChangeLog is ArmResourceActionSync<
    LocalRulestackResource,
    void,
    Changelog
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("support info for rulestack.")
  @operationId("LocalRulestacks_getSupportInfo")
  getSupportInfo is ArmResourceActionSync<
    LocalRulestackResource,
    void,
    SupportInfo,
    {
      ...BaseParameters<LocalRulestackResource>;

      @doc("email address on behalf of which this API called")
      @query("email")
      email?: string;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get the list of advanced security objects")
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

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List of AppIds for LocalRulestack ApiVersion")
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

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List of countries for Rulestack")
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

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List of Firewalls associated with Rulestack")
  @operationId("LocalRulestacks_listFirewalls")
  listFirewalls is ArmResourceActionSync<
    LocalRulestackResource,
    void,
    ListFirewallsResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List predefined URL categories for rulestack")
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

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List the security services for rulestack")
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

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Revert rulestack configuration")
  @operationId("LocalRulestacks_revert")
  revert is ArmResourceActionNoContentSync<LocalRulestackResource, void>;
}
