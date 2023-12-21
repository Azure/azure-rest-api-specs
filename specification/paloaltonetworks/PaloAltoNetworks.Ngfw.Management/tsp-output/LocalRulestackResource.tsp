import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.PaloAltoNetworks.Ngfw;
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
interface LocalRulestacks {
  @doc("Get a LocalRulestackResource")
  get is ArmResourceRead<LocalRulestackResource>;
  @doc("Create a LocalRulestackResource")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<LocalRulestackResource>;
  @doc("Update a LocalRulestackResource")
  update is ArmResourcePatchSync<LocalRulestackResource, RulestackProperties>;
  @doc("Delete a LocalRulestackResource")
  delete is ArmResourceDeleteAsync<LocalRulestackResource>;
  @doc("List LocalRulestackResource resources by resource group")
  listByResourceGroup is ArmResourceListByParent<LocalRulestackResource>;
  @doc("List LocalRulestackResource resources by subscription ID")
  listBySubscription is ArmListBySubscription<LocalRulestackResource>;
  @doc("Commit rulestack configuration")
  commit is ArmResourceActionNoResponseContentAsync<
    LocalRulestackResource,
    void
  >;
  @doc("Get changelog")
  getChangeLog is ArmResourceActionSync<
    LocalRulestackResource,
    void,
    Changelog
  >;
  @doc("support info for rulestack.")
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
  @doc("Get the list of advanced security objects")
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
  @doc("List of AppIds for LocalRulestack ApiVersion")
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
  @doc("List of countries for Rulestack")
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
  @doc("List of Firewalls associated with Rulestack")
  listFirewalls is ArmResourceActionSync<
    LocalRulestackResource,
    void,
    ListFirewallsResponse
  >;
  @doc("List predefined URL categories for rulestack")
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
  @doc("List the security services for rulestack")
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
  @doc("Revert rulestack configuration")
  revert is ArmResourceActionNoContentSync<LocalRulestackResource, void>;
}
