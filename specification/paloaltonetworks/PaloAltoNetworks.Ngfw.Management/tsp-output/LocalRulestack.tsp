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
model LocalRulestack is TrackedResource<RulestackProperties> {
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
  get is ArmResourceRead<LocalRulestack>;
  @doc("Create a LocalRulestackResource")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<LocalRulestack>;
  @doc("Update a LocalRulestackResource")
  update is ArmResourcePatchSync<LocalRulestack, RulestackProperties>;
  @doc("Delete a LocalRulestackResource")
  delete is ArmResourceDeleteAsync<LocalRulestack>;
  @doc("List LocalRulestackResource resources by resource group")
  listByResourceGroup is ArmResourceListByParent<LocalRulestack>;
  @doc("List LocalRulestackResource resources by subscription ID")
  listBySubscription is ArmListBySubscription<LocalRulestack>;
  @doc("Commit rulestack configuration")
  commit is ArmResourceActionNoResponseContentAsync<LocalRulestack, {}>;
  @doc("Get changelog")
  getChangeLog is ArmResourceActionSync<LocalRulestack, {}, Changelog>;
  @doc("support info for rulestack.")
  getSupportInfo is ArmResourceActionSync<
    LocalRulestack,
    {},
    SupportInfo,
    {
      ...BaseParameters<LocalRulestack>;

      @doc("email address on behalf of which this API called")
      @query("email")
      email?: string;
    }
  >;
  @doc("Get the list of advanced security objects")
  listAdvancedSecurityObjects is ArmResourceActionSync<
    LocalRulestack,
    {},
    AdvSecurityObjectListResponse,
    {
      ...BaseParameters<LocalRulestack>;

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
    LocalRulestack,
    {},
    ListAppIdResponse,
    {
      ...BaseParameters<LocalRulestack>;

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
    LocalRulestack,
    {},
    CountriesResponse,
    {
      ...BaseParameters<LocalRulestack>;

      @query("skip")
      skip?: string;

      @query("top")
      top?: int32;
    }
  >;
  @doc("List of Firewalls associated with Rulestack")
  listFirewalls is ArmResourceActionSync<
    LocalRulestack,
    {},
    ListFirewallsResponse
  >;
  @doc("List predefined URL categories for rulestack")
  listPredefinedUrlCategories is ArmResourceActionSync<
    LocalRulestack,
    {},
    PredefinedUrlCategoriesResponse,
    {
      ...BaseParameters<LocalRulestack>;

      @query("skip")
      skip?: string;

      @query("top")
      top?: int32;
    }
  >;
  @doc("List the security services for rulestack")
  listSecurityServices is ArmResourceActionSync<
    LocalRulestack,
    {},
    SecurityServicesResponse,
    {
      ...BaseParameters<LocalRulestack>;

      @query("skip")
      skip?: string;

      @query("top")
      top?: int32;

      @query("type")
      type: SecurityServicesTypeEnum;
    }
  >;
  @doc("Revert rulestack configuration")
  revert is ArmResourceActionNoContentSync<LocalRulestack, {}>;
}
