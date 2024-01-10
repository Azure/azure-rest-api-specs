import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace PaloAltoNetworks.Cloudngfw;
@doc("PaloAltoNetworks GlobalRulestack")
@tenantResource
model GlobalRulestackResource is ProxyResource<RulestackProperties> {
  @doc("GlobalRulestack resource name")
  @key("globalRulestackName")
  @segment("globalRulestacks")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
@projectedName("client", "GlobalRulestack")
interface GlobalRulestackResources_GlobalRulestack {
  @doc("Get a GlobalRulestackResource")
  get is ArmResourceRead<GlobalRulestackResource>;

  @doc("Create a GlobalRulestackResource")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<GlobalRulestackResource>;

  @doc("Update a GlobalRulestackResource")
  update is ArmCustomPatchSync<
    GlobalRulestackResource,
    GlobalRulestackResourceUpdate
  >;

  @doc("Delete a GlobalRulestackResource")
  delete is ArmResourceDeleteAsync<GlobalRulestackResource>;

  @doc("List GlobalRulestackResource resources by Tenant")
  list is ArmResourceListByParent<GlobalRulestackResource>;

  @doc("Commit rulestack configuration")
  commit is ArmResourceActionNoResponseContentAsync<
    GlobalRulestackResource,
    void
  >;

  @doc("Get changelog")
  getChangeLog is ArmResourceActionSync<
    GlobalRulestackResource,
    void,
    Changelog
  >;

  @doc("Get the list of advanced security objects")
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

  @doc("List of AppIds for GlobalRulestack ApiVersion")
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

  @doc("List of countries for Rulestack")
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

  @doc("List of Firewalls associated with Rulestack")
  listFirewalls is ArmResourceActionSync<
    GlobalRulestackResource,
    void,
    ListFirewallsResponse
  >;

  @doc("List predefined URL categories for rulestack")
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

  @doc("List the security services for rulestack")
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

  @doc("Revert rulestack configuration")
  revert is ArmResourceActionNoContentSync<GlobalRulestackResource, void>;
}
