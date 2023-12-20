import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.PaloAltoNetworks.Ngfw;
@doc("PaloAltoNetworks GlobalRulestack")
@tenantResource
model GlobalRulestack is ProxyResource<RulestackProperties> {
  @doc("GlobalRulestack resource name")
  @path
  @key("globalRulestackName")
  @segment("globalRulestacks")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface GlobalRulestacks {
  @doc("Get a GlobalRulestackResource")
  get is ArmResourceRead<GlobalRulestack>;
  @doc("Create a GlobalRulestackResource")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<GlobalRulestack>;
  @doc("Update a GlobalRulestackResource")
  update is ArmResourcePatchSync<GlobalRulestack, RulestackProperties>;
  @doc("Delete a GlobalRulestackResource")
  delete is ArmResourceDeleteAsync<GlobalRulestack>;
  @doc("List GlobalRulestackResource resources by Tenant")
  list is ArmResourceListByParent<GlobalRulestack>;
  @doc("Commit rulestack configuration")
  commit is ArmResourceActionNoResponseContentAsync<GlobalRulestack, void>;
  @doc("Get changelog")
  getChangeLog is ArmResourceActionSync<GlobalRulestack, void, Changelog>;
  @doc("Get the list of advanced security objects")
  listAdvancedSecurityObjects is ArmResourceActionSync<
    GlobalRulestack,
    void,
    AdvSecurityObjectListResponse,
    {
      ...BaseParameters<GlobalRulestack>;

      @query("skip")
      skip?: string;

      @query("top")
      top?: int32;

      @query("type")
      type: AdvSecurityObjectTypeEnum;
    }
  >;
  @doc("List of AppIds for GlobalRulestack ApiVersion")
  listAppIds is ArmResourceActionSync<
    GlobalRulestack,
    void,
    ListAppIdResponse,
    {
      ...BaseParameters<GlobalRulestack>;

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
  @doc("List of countries for Rulestack")
  listCountries is ArmResourceActionSync<
    GlobalRulestack,
    void,
    CountriesResponse,
    {
      ...BaseParameters<GlobalRulestack>;

      @query("skip")
      skip?: string;

      @query("top")
      top?: int32;
    }
  >;
  @doc("List of Firewalls associated with Rulestack")
  listFirewalls is ArmResourceActionSync<
    GlobalRulestack,
    void,
    ListFirewallsResponse
  >;
  @doc("List predefined URL categories for rulestack")
  listPredefinedUrlCategories is ArmResourceActionSync<
    GlobalRulestack,
    void,
    PredefinedUrlCategoriesResponse,
    {
      ...BaseParameters<GlobalRulestack>;

      @query("skip")
      skip?: string;

      @query("top")
      top?: int32;
    }
  >;
  @doc("List the security services for rulestack")
  listSecurityServices is ArmResourceActionSync<
    GlobalRulestack,
    void,
    SecurityServicesResponse,
    {
      ...BaseParameters<GlobalRulestack>;

      @query("skip")
      skip?: string;

      @query("top")
      top?: int32;

      @query("type")
      type: SecurityServicesTypeEnum;
    }
  >;
  @doc("Revert rulestack configuration")
  revert is ArmResourceActionNoContentSync<GlobalRulestack, void>;
}
