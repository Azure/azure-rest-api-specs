import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace PaloAltoNetworks.Cloudngfw;

interface GlobalRulestackOperations {
  @doc("List GlobalRulestackResource resources by Tenant")
  @route("/providers/PaloAltoNetworks.Cloudngfw/globalRulestacks")
  @get
  List is Azure.Core.Foundations.Operation<
    {},
    GlobalRulestackResourceListResult
  >;

  @doc("Get a GlobalRulestackResource")
  @route("/providers/PaloAltoNetworks.Cloudngfw/globalRulestacks/{globalRulestackName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("GlobalRulestack resource name")
      @path
      globalRulestackName: string;
    },
    GlobalRulestackResource
  >;

  @doc("Create a GlobalRulestackResource")
  @route("/providers/PaloAltoNetworks.Cloudngfw/globalRulestacks/{globalRulestackName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("GlobalRulestack resource name")
      @path
      globalRulestackName: string;

      @doc("Resource create parameters.")
      @body
      resource: GlobalRulestackResource;
    },
    GlobalRulestackResource
  >;

  @doc("Update a GlobalRulestackResource")
  @route("/providers/PaloAltoNetworks.Cloudngfw/globalRulestacks/{globalRulestackName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("GlobalRulestack resource name")
      @path
      globalRulestackName: string;

      @doc("The resource properties to be updated.")
      @body
      properties: GlobalRulestackResourceUpdate;
    },
    GlobalRulestackResource
  >;

  @doc("Delete a GlobalRulestackResource")
  @route("/providers/PaloAltoNetworks.Cloudngfw/globalRulestacks/{globalRulestackName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("GlobalRulestack resource name")
      @path
      globalRulestackName: string;
    },
    void
  >;

  @doc("Commit rulestack configuration")
  @route("/providers/PaloAltoNetworks.Cloudngfw/globalRulestacks/{globalRulestackName}/commit")
  @post
  commit is Azure.Core.Foundations.Operation<
    {
      @doc("GlobalRulestack resource name")
      @path
      globalRulestackName: string;
    },
    void
  >;

  @doc("Get changelog")
  @route("/providers/PaloAltoNetworks.Cloudngfw/globalRulestacks/{globalRulestackName}/getChangeLog")
  @post
  getChangeLog is Azure.Core.Foundations.Operation<
    {
      @doc("GlobalRulestack resource name")
      @path
      globalRulestackName: string;
    },
    Changelog
  >;

  @doc("Get the list of advanced security objects")
  @route("/providers/PaloAltoNetworks.Cloudngfw/globalRulestacks/{globalRulestackName}/listAdvancedSecurityObjects")
  @post
  listAdvancedSecurityObjects is Azure.Core.Foundations.Operation<
    {
      @doc("GlobalRulestack resource name")
      @path
      globalRulestackName: string;

      @query skip: string;
      @query top: int32;
      @query type: AdvSecurityObjectTypeEnum;
    },
    AdvSecurityObjectListResponse
  >;

  @doc("List of AppIds for GlobalRulestack ApiVersion")
  @route("/providers/PaloAltoNetworks.Cloudngfw/globalRulestacks/{globalRulestackName}/listAppIds")
  @post
  listAppIds is Azure.Core.Foundations.Operation<
    {
      @doc("GlobalRulestack resource name")
      @path
      globalRulestackName: string;

      @query appIdVersion: string;
      @query appPrefix: string;
      @query skip: string;
      @query top: int32;
    },
    ListAppIdResponse
  >;

  @doc("List of countries for Rulestack")
  @route("/providers/PaloAltoNetworks.Cloudngfw/globalRulestacks/{globalRulestackName}/listCountries")
  @post
  listCountries is Azure.Core.Foundations.Operation<
    {
      @doc("GlobalRulestack resource name")
      @path
      globalRulestackName: string;

      @query skip: string;
      @query top: int32;
    },
    CountriesResponse
  >;

  @doc("List of Firewalls associated with Rulestack")
  @route("/providers/PaloAltoNetworks.Cloudngfw/globalRulestacks/{globalRulestackName}/listFirewalls")
  @post
  listFirewalls is Azure.Core.Foundations.Operation<
    {
      @doc("GlobalRulestack resource name")
      @path
      globalRulestackName: string;
    },
    ListFirewallsResponse
  >;

  @doc("List predefined URL categories for rulestack")
  @route("/providers/PaloAltoNetworks.Cloudngfw/globalRulestacks/{globalRulestackName}/listPredefinedUrlCategories")
  @post
  listPredefinedUrlCategories is Azure.Core.Foundations.Operation<
    {
      @doc("GlobalRulestack resource name")
      @path
      globalRulestackName: string;

      @query skip: string;
      @query top: int32;
    },
    PredefinedUrlCategoriesResponse
  >;

  @doc("List the security services for rulestack")
  @route("/providers/PaloAltoNetworks.Cloudngfw/globalRulestacks/{globalRulestackName}/listSecurityServices")
  @post
  listSecurityServices is Azure.Core.Foundations.Operation<
    {
      @doc("GlobalRulestack resource name")
      @path
      globalRulestackName: string;

      @query skip: string;
      @query top: int32;
      @query type: SecurityServicesTypeEnum;
    },
    SecurityServicesResponse
  >;

  @doc("Revert rulestack configuration")
  @route("/providers/PaloAltoNetworks.Cloudngfw/globalRulestacks/{globalRulestackName}/revert")
  @post
  revert is Azure.Core.Foundations.Operation<
    {
      @doc("GlobalRulestack resource name")
      @path
      globalRulestackName: string;
    },
    void
  >;
}

interface CertificateObjectGlobalRulestackOperations {
  @doc("List CertificateObjectGlobalRulestackResource resources by Tenant")
  @route("/providers/PaloAltoNetworks.Cloudngfw/globalRulestacks/{globalRulestackName}/certificates")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("GlobalRulestack resource name")
      @path
      globalRulestackName: string;
    },
    CertificateObjectGlobalRulestackResourceListResult
  >;

  @doc("Get a CertificateObjectGlobalRulestackResource")
  @route("/providers/PaloAltoNetworks.Cloudngfw/globalRulestacks/{globalRulestackName}/certificates/{name}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("GlobalRulestack resource name")
      @path
      globalRulestackName: string;

      @doc("certificate name")
      @path
      name: string;
    },
    CertificateObjectGlobalRulestackResource
  >;

  @doc("Create a CertificateObjectGlobalRulestackResource")
  @route("/providers/PaloAltoNetworks.Cloudngfw/globalRulestacks/{globalRulestackName}/certificates/{name}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("GlobalRulestack resource name")
      @path
      globalRulestackName: string;

      @doc("certificate name")
      @path
      name: string;

      @doc("Resource create parameters.")
      @body
      resource: CertificateObjectGlobalRulestackResource;
    },
    CertificateObjectGlobalRulestackResource
  >;

  @doc("Delete a CertificateObjectGlobalRulestackResource")
  @route("/providers/PaloAltoNetworks.Cloudngfw/globalRulestacks/{globalRulestackName}/certificates/{name}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("GlobalRulestack resource name")
      @path
      globalRulestackName: string;

      @doc("certificate name")
      @path
      name: string;
    },
    void
  >;
}

interface FqdnListGlobalRulestackOperations {
  @doc("List FqdnListGlobalRulestackResource resources by Tenant")
  @route("/providers/PaloAltoNetworks.Cloudngfw/globalRulestacks/{globalRulestackName}/fqdnlists")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("GlobalRulestack resource name")
      @path
      globalRulestackName: string;
    },
    FqdnListGlobalRulestackResourceListResult
  >;

  @doc("Get a FqdnListGlobalRulestackResource")
  @route("/providers/PaloAltoNetworks.Cloudngfw/globalRulestacks/{globalRulestackName}/fqdnlists/{name}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("GlobalRulestack resource name")
      @path
      globalRulestackName: string;

      @doc("fqdn list name")
      @path
      name: string;
    },
    FqdnListGlobalRulestackResource
  >;

  @doc("Create a FqdnListGlobalRulestackResource")
  @route("/providers/PaloAltoNetworks.Cloudngfw/globalRulestacks/{globalRulestackName}/fqdnlists/{name}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("GlobalRulestack resource name")
      @path
      globalRulestackName: string;

      @doc("fqdn list name")
      @path
      name: string;

      @doc("Resource create parameters.")
      @body
      resource: FqdnListGlobalRulestackResource;
    },
    FqdnListGlobalRulestackResource
  >;

  @doc("Delete a FqdnListGlobalRulestackResource")
  @route("/providers/PaloAltoNetworks.Cloudngfw/globalRulestacks/{globalRulestackName}/fqdnlists/{name}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("GlobalRulestack resource name")
      @path
      globalRulestackName: string;

      @doc("fqdn list name")
      @path
      name: string;
    },
    void
  >;
}

interface PostRulesOperations {
  @doc("List PostRulesResource resources by Tenant")
  @route("/providers/PaloAltoNetworks.Cloudngfw/globalRulestacks/{globalRulestackName}/postRules")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("GlobalRulestack resource name")
      @path
      globalRulestackName: string;
    },
    PostRulesResourceListResult
  >;

  @doc("Get a PostRulesResource")
  @route("/providers/PaloAltoNetworks.Cloudngfw/globalRulestacks/{globalRulestackName}/postRules/{priority}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("GlobalRulestack resource name")
      @path
      globalRulestackName: string;

      @doc("Post Rule priority")
      @path
      priority: string;
    },
    PostRulesResource
  >;

  @doc("Create a PostRulesResource")
  @route("/providers/PaloAltoNetworks.Cloudngfw/globalRulestacks/{globalRulestackName}/postRules/{priority}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("GlobalRulestack resource name")
      @path
      globalRulestackName: string;

      @doc("Post Rule priority")
      @path
      priority: string;

      @doc("Resource create parameters.")
      @body
      resource: PostRulesResource;
    },
    PostRulesResource
  >;

  @doc("Delete a PostRulesResource")
  @route("/providers/PaloAltoNetworks.Cloudngfw/globalRulestacks/{globalRulestackName}/postRules/{priority}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("GlobalRulestack resource name")
      @path
      globalRulestackName: string;

      @doc("Post Rule priority")
      @path
      priority: string;
    },
    void
  >;

  @doc("Get counters")
  @route("/providers/PaloAltoNetworks.Cloudngfw/globalRulestacks/{globalRulestackName}/postRules/{priority}/getCounters")
  @post
  getCounters is Azure.Core.Foundations.Operation<
    {
      @doc("GlobalRulestack resource name")
      @path
      globalRulestackName: string;

      @doc("Post Rule priority")
      @path
      priority: string;

      @query firewallName: string;
    },
    RuleCounter
  >;

  @doc("Refresh counters")
  @route("/providers/PaloAltoNetworks.Cloudngfw/globalRulestacks/{globalRulestackName}/postRules/{priority}/refreshCounters")
  @post
  refreshCounters is Azure.Core.Foundations.Operation<
    {
      @doc("GlobalRulestack resource name")
      @path
      globalRulestackName: string;

      @doc("Post Rule priority")
      @path
      priority: string;

      @query firewallName: string;
    },
    void
  >;

  @doc("Reset counters")
  @route("/providers/PaloAltoNetworks.Cloudngfw/globalRulestacks/{globalRulestackName}/postRules/{priority}/resetCounters")
  @post
  resetCounters is Azure.Core.Foundations.Operation<
    {
      @doc("GlobalRulestack resource name")
      @path
      globalRulestackName: string;

      @doc("Post Rule priority")
      @path
      priority: string;

      @query firewallName: string;
    },
    RuleCounterReset
  >;
}

interface PrefixListGlobalRulestackOperations {
  @doc("List PrefixListGlobalRulestackResource resources by Tenant")
  @route("/providers/PaloAltoNetworks.Cloudngfw/globalRulestacks/{globalRulestackName}/prefixlists")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("GlobalRulestack resource name")
      @path
      globalRulestackName: string;
    },
    PrefixListGlobalRulestackResourceListResult
  >;

  @doc("Get a PrefixListGlobalRulestackResource")
  @route("/providers/PaloAltoNetworks.Cloudngfw/globalRulestacks/{globalRulestackName}/prefixlists/{name}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("GlobalRulestack resource name")
      @path
      globalRulestackName: string;

      @doc("Local Rule priority")
      @path
      name: string;
    },
    PrefixListGlobalRulestackResource
  >;

  @doc("Create a PrefixListGlobalRulestackResource")
  @route("/providers/PaloAltoNetworks.Cloudngfw/globalRulestacks/{globalRulestackName}/prefixlists/{name}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("GlobalRulestack resource name")
      @path
      globalRulestackName: string;

      @doc("Local Rule priority")
      @path
      name: string;

      @doc("Resource create parameters.")
      @body
      resource: PrefixListGlobalRulestackResource;
    },
    PrefixListGlobalRulestackResource
  >;

  @doc("Delete a PrefixListGlobalRulestackResource")
  @route("/providers/PaloAltoNetworks.Cloudngfw/globalRulestacks/{globalRulestackName}/prefixlists/{name}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("GlobalRulestack resource name")
      @path
      globalRulestackName: string;

      @doc("Local Rule priority")
      @path
      name: string;
    },
    void
  >;
}

interface PreRulesOperations {
  @doc("List PreRulesResource resources by Tenant")
  @route("/providers/PaloAltoNetworks.Cloudngfw/globalRulestacks/{globalRulestackName}/preRules")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("GlobalRulestack resource name")
      @path
      globalRulestackName: string;
    },
    PreRulesResourceListResult
  >;

  @doc("Get a PreRulesResource")
  @route("/providers/PaloAltoNetworks.Cloudngfw/globalRulestacks/{globalRulestackName}/preRules/{priority}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("GlobalRulestack resource name")
      @path
      globalRulestackName: string;

      @doc("Pre Rule priority")
      @path
      priority: string;
    },
    PreRulesResource
  >;

  @doc("Create a PreRulesResource")
  @route("/providers/PaloAltoNetworks.Cloudngfw/globalRulestacks/{globalRulestackName}/preRules/{priority}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("GlobalRulestack resource name")
      @path
      globalRulestackName: string;

      @doc("Pre Rule priority")
      @path
      priority: string;

      @doc("Resource create parameters.")
      @body
      resource: PreRulesResource;
    },
    PreRulesResource
  >;

  @doc("Delete a PreRulesResource")
  @route("/providers/PaloAltoNetworks.Cloudngfw/globalRulestacks/{globalRulestackName}/preRules/{priority}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("GlobalRulestack resource name")
      @path
      globalRulestackName: string;

      @doc("Pre Rule priority")
      @path
      priority: string;
    },
    void
  >;

  @doc("Get counters")
  @route("/providers/PaloAltoNetworks.Cloudngfw/globalRulestacks/{globalRulestackName}/preRules/{priority}/getCounters")
  @post
  getCounters is Azure.Core.Foundations.Operation<
    {
      @doc("GlobalRulestack resource name")
      @path
      globalRulestackName: string;

      @doc("Pre Rule priority")
      @path
      priority: string;

      @query firewallName: string;
    },
    RuleCounter
  >;

  @doc("Refresh counters")
  @route("/providers/PaloAltoNetworks.Cloudngfw/globalRulestacks/{globalRulestackName}/preRules/{priority}/refreshCounters")
  @post
  refreshCounters is Azure.Core.Foundations.Operation<
    {
      @doc("GlobalRulestack resource name")
      @path
      globalRulestackName: string;

      @doc("Pre Rule priority")
      @path
      priority: string;

      @query firewallName: string;
    },
    void
  >;

  @doc("Reset counters")
  @route("/providers/PaloAltoNetworks.Cloudngfw/globalRulestacks/{globalRulestackName}/preRules/{priority}/resetCounters")
  @post
  resetCounters is Azure.Core.Foundations.Operation<
    {
      @doc("GlobalRulestack resource name")
      @path
      globalRulestackName: string;

      @doc("Pre Rule priority")
      @path
      priority: string;

      @query firewallName: string;
    },
    RuleCounterReset
  >;
}

interface OperationsOperations {
  @doc("List the operations for the provider")
  @route("/providers/PaloAltoNetworks.Cloudngfw/operations")
  @get
  List is Azure.Core.Foundations.Operation<{}, OperationListResult>;
}

interface FirewallsOperations {
  @doc("List FirewallResource resources by subscription ID")
  @route("/subscriptions/{subscriptionId}/providers/PaloAltoNetworks.Cloudngfw/firewalls")
  @get
  ListBySubscription is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;
    },
    FirewallResourceListResult
  >;

  @doc("List FirewallResource resources by resource group")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/PaloAltoNetworks.Cloudngfw/firewalls")
  @get
  ListByResourceGroup is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;
    },
    FirewallResourceListResult
  >;

  @doc("Get a FirewallResource")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/PaloAltoNetworks.Cloudngfw/firewalls/{firewallName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Firewall resource name")
      @path
      firewallName: string;
    },
    FirewallResource
  >;

  @doc("Create a FirewallResource")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/PaloAltoNetworks.Cloudngfw/firewalls/{firewallName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Firewall resource name")
      @path
      firewallName: string;

      @doc("Resource create parameters.")
      @body
      resource: FirewallResource;
    },
    FirewallResource
  >;

  @doc("Update a FirewallResource")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/PaloAltoNetworks.Cloudngfw/firewalls/{firewallName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Firewall resource name")
      @path
      firewallName: string;

      @doc("The resource properties to be updated.")
      @body
      properties: FirewallResourceUpdate;
    },
    FirewallResource
  >;

  @doc("Delete a FirewallResource")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/PaloAltoNetworks.Cloudngfw/firewalls/{firewallName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Firewall resource name")
      @path
      firewallName: string;
    },
    void
  >;

  @doc("Get Global Rulestack associated with the Firewall")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/PaloAltoNetworks.Cloudngfw/firewalls/{firewallName}/getGlobalRulestack")
  @post
  getGlobalRulestack is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Firewall resource name")
      @path
      firewallName: string;
    },
    GlobalRulestackInfo
  >;

  @doc("Log Profile for Firewall")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/PaloAltoNetworks.Cloudngfw/firewalls/{firewallName}/getLogProfile")
  @post
  getLogProfile is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Firewall resource name")
      @path
      firewallName: string;
    },
    LogSettings
  >;

  @doc("support info for firewall.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/PaloAltoNetworks.Cloudngfw/firewalls/{firewallName}/getSupportInfo")
  @post
  getSupportInfo is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Firewall resource name")
      @path
      firewallName: string;

      @doc("email address on behalf of which this API called")
      @query
      email: string;
    },
    SupportInfo
  >;

  @doc("Log Profile for Firewall")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/PaloAltoNetworks.Cloudngfw/firewalls/{firewallName}/saveLogProfile")
  @post
  saveLogProfile is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Firewall resource name")
      @path
      firewallName: string;

      @body logSettings: LogSettings;
    },
    void
  >;
}

interface LocalRulestacksOperations {
  @doc("List LocalRulestackResource resources by subscription ID")
  @route("/subscriptions/{subscriptionId}/providers/PaloAltoNetworks.Cloudngfw/localRulestacks")
  @get
  ListBySubscription is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;
    },
    LocalRulestackResourceListResult
  >;

  @doc("List LocalRulestackResource resources by resource group")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/PaloAltoNetworks.Cloudngfw/localRulestacks")
  @get
  ListByResourceGroup is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;
    },
    LocalRulestackResourceListResult
  >;

  @doc("Get a LocalRulestackResource")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/PaloAltoNetworks.Cloudngfw/localRulestacks/{localRulestackName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("LocalRulestack resource name")
      @path
      localRulestackName: string;
    },
    LocalRulestackResource
  >;

  @doc("Create a LocalRulestackResource")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/PaloAltoNetworks.Cloudngfw/localRulestacks/{localRulestackName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("LocalRulestack resource name")
      @path
      localRulestackName: string;

      @doc("Resource create parameters.")
      @body
      resource: LocalRulestackResource;
    },
    LocalRulestackResource
  >;

  @doc("Update a LocalRulestackResource")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/PaloAltoNetworks.Cloudngfw/localRulestacks/{localRulestackName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("LocalRulestack resource name")
      @path
      localRulestackName: string;

      @doc("The resource properties to be updated.")
      @body
      properties: LocalRulestackResourceUpdate;
    },
    LocalRulestackResource
  >;

  @doc("Delete a LocalRulestackResource")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/PaloAltoNetworks.Cloudngfw/localRulestacks/{localRulestackName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("LocalRulestack resource name")
      @path
      localRulestackName: string;
    },
    void
  >;

  @doc("Commit rulestack configuration")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/PaloAltoNetworks.Cloudngfw/localRulestacks/{localRulestackName}/commit")
  @post
  commit is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("LocalRulestack resource name")
      @path
      localRulestackName: string;
    },
    void
  >;

  @doc("Get changelog")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/PaloAltoNetworks.Cloudngfw/localRulestacks/{localRulestackName}/getChangeLog")
  @post
  getChangeLog is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("LocalRulestack resource name")
      @path
      localRulestackName: string;
    },
    Changelog
  >;

  @doc("support info for rulestack.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/PaloAltoNetworks.Cloudngfw/localRulestacks/{localRulestackName}/getSupportInfo")
  @post
  getSupportInfo is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("LocalRulestack resource name")
      @path
      localRulestackName: string;

      @doc("email address on behalf of which this API called")
      @query
      email: string;
    },
    SupportInfo
  >;

  @doc("Get the list of advanced security objects")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/PaloAltoNetworks.Cloudngfw/localRulestacks/{localRulestackName}/listAdvancedSecurityObjects")
  @post
  listAdvancedSecurityObjects is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("LocalRulestack resource name")
      @path
      localRulestackName: string;

      @query skip: string;
      @query top: int32;
      @query type: AdvSecurityObjectTypeEnum;
    },
    AdvSecurityObjectListResponse
  >;

  @doc("List of AppIds for LocalRulestack ApiVersion")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/PaloAltoNetworks.Cloudngfw/localRulestacks/{localRulestackName}/listAppIds")
  @post
  listAppIds is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("LocalRulestack resource name")
      @path
      localRulestackName: string;

      @query appIdVersion: string;
      @query appPrefix: string;
      @query skip: string;
      @query top: int32;
    },
    ListAppIdResponse
  >;

  @doc("List of countries for Rulestack")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/PaloAltoNetworks.Cloudngfw/localRulestacks/{localRulestackName}/listCountries")
  @post
  listCountries is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("LocalRulestack resource name")
      @path
      localRulestackName: string;

      @query skip: string;
      @query top: int32;
    },
    CountriesResponse
  >;

  @doc("List of Firewalls associated with Rulestack")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/PaloAltoNetworks.Cloudngfw/localRulestacks/{localRulestackName}/listFirewalls")
  @post
  listFirewalls is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("LocalRulestack resource name")
      @path
      localRulestackName: string;
    },
    ListFirewallsResponse
  >;

  @doc("List predefined URL categories for rulestack")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/PaloAltoNetworks.Cloudngfw/localRulestacks/{localRulestackName}/listPredefinedUrlCategories")
  @post
  listPredefinedUrlCategories is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("LocalRulestack resource name")
      @path
      localRulestackName: string;

      @query skip: string;
      @query top: int32;
    },
    PredefinedUrlCategoriesResponse
  >;

  @doc("List the security services for rulestack")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/PaloAltoNetworks.Cloudngfw/localRulestacks/{localRulestackName}/listSecurityServices")
  @post
  listSecurityServices is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("LocalRulestack resource name")
      @path
      localRulestackName: string;

      @query skip: string;
      @query top: int32;
      @query type: SecurityServicesTypeEnum;
    },
    SecurityServicesResponse
  >;

  @doc("Revert rulestack configuration")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/PaloAltoNetworks.Cloudngfw/localRulestacks/{localRulestackName}/revert")
  @post
  revert is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("LocalRulestack resource name")
      @path
      localRulestackName: string;
    },
    void
  >;
}

interface FirewallStatusOperations {
  @doc("List FirewallStatusResource resources by Firewalls")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/PaloAltoNetworks.Cloudngfw/firewalls/{firewallName}/statuses")
  @get
  ListByFirewalls is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Firewall resource name")
      @path
      firewallName: string;
    },
    FirewallStatusResourceListResult
  >;

  @doc("Get a FirewallStatusResource")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/PaloAltoNetworks.Cloudngfw/firewalls/{firewallName}/statuses/default")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Firewall resource name")
      @path
      firewallName: string;
    },
    FirewallStatusResource
  >;
}

interface CertificateObjectLocalRulestackOperations {
  @doc("List CertificateObjectLocalRulestackResource resources by LocalRulestacks")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/PaloAltoNetworks.Cloudngfw/localRulestacks/{localRulestackName}/certificates")
  @get
  ListByLocalRulestacks is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("LocalRulestack resource name")
      @path
      localRulestackName: string;
    },
    CertificateObjectLocalRulestackResourceListResult
  >;

  @doc("Get a CertificateObjectLocalRulestackResource")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/PaloAltoNetworks.Cloudngfw/localRulestacks/{localRulestackName}/certificates/{name}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("LocalRulestack resource name")
      @path
      localRulestackName: string;

      @doc("certificate name")
      @path
      name: string;
    },
    CertificateObjectLocalRulestackResource
  >;

  @doc("Create a CertificateObjectLocalRulestackResource")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/PaloAltoNetworks.Cloudngfw/localRulestacks/{localRulestackName}/certificates/{name}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("LocalRulestack resource name")
      @path
      localRulestackName: string;

      @doc("certificate name")
      @path
      name: string;

      @doc("Resource create parameters.")
      @body
      resource: CertificateObjectLocalRulestackResource;
    },
    CertificateObjectLocalRulestackResource
  >;

  @doc("Delete a CertificateObjectLocalRulestackResource")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/PaloAltoNetworks.Cloudngfw/localRulestacks/{localRulestackName}/certificates/{name}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("LocalRulestack resource name")
      @path
      localRulestackName: string;

      @doc("certificate name")
      @path
      name: string;
    },
    void
  >;
}

interface FqdnListLocalRulestackOperations {
  @doc("List FqdnListLocalRulestackResource resources by LocalRulestacks")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/PaloAltoNetworks.Cloudngfw/localRulestacks/{localRulestackName}/fqdnlists")
  @get
  ListByLocalRulestacks is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("LocalRulestack resource name")
      @path
      localRulestackName: string;
    },
    FqdnListLocalRulestackResourceListResult
  >;

  @doc("Get a FqdnListLocalRulestackResource")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/PaloAltoNetworks.Cloudngfw/localRulestacks/{localRulestackName}/fqdnlists/{name}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("LocalRulestack resource name")
      @path
      localRulestackName: string;

      @doc("fqdn list name")
      @path
      name: string;
    },
    FqdnListLocalRulestackResource
  >;

  @doc("Create a FqdnListLocalRulestackResource")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/PaloAltoNetworks.Cloudngfw/localRulestacks/{localRulestackName}/fqdnlists/{name}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("LocalRulestack resource name")
      @path
      localRulestackName: string;

      @doc("fqdn list name")
      @path
      name: string;

      @doc("Resource create parameters.")
      @body
      resource: FqdnListLocalRulestackResource;
    },
    FqdnListLocalRulestackResource
  >;

  @doc("Delete a FqdnListLocalRulestackResource")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/PaloAltoNetworks.Cloudngfw/localRulestacks/{localRulestackName}/fqdnlists/{name}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("LocalRulestack resource name")
      @path
      localRulestackName: string;

      @doc("fqdn list name")
      @path
      name: string;
    },
    void
  >;
}

interface LocalRulesOperations {
  @doc("List LocalRulesResource resources by LocalRulestacks")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/PaloAltoNetworks.Cloudngfw/localRulestacks/{localRulestackName}/localRules")
  @get
  ListByLocalRulestacks is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("LocalRulestack resource name")
      @path
      localRulestackName: string;
    },
    LocalRulesResourceListResult
  >;

  @doc("Get a LocalRulesResource")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/PaloAltoNetworks.Cloudngfw/localRulestacks/{localRulestackName}/localRules/{priority}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("LocalRulestack resource name")
      @path
      localRulestackName: string;

      @doc("Local Rule priority")
      @path
      priority: string;
    },
    LocalRulesResource
  >;

  @doc("Create a LocalRulesResource")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/PaloAltoNetworks.Cloudngfw/localRulestacks/{localRulestackName}/localRules/{priority}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("LocalRulestack resource name")
      @path
      localRulestackName: string;

      @doc("Local Rule priority")
      @path
      priority: string;

      @doc("Resource create parameters.")
      @body
      resource: LocalRulesResource;
    },
    LocalRulesResource
  >;

  @doc("Delete a LocalRulesResource")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/PaloAltoNetworks.Cloudngfw/localRulestacks/{localRulestackName}/localRules/{priority}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("LocalRulestack resource name")
      @path
      localRulestackName: string;

      @doc("Local Rule priority")
      @path
      priority: string;
    },
    void
  >;

  @doc("Get counters")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/PaloAltoNetworks.Cloudngfw/localRulestacks/{localRulestackName}/localRules/{priority}/getCounters")
  @post
  getCounters is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("LocalRulestack resource name")
      @path
      localRulestackName: string;

      @doc("Local Rule priority")
      @path
      priority: string;

      @query firewallName: string;
    },
    RuleCounter
  >;

  @doc("Refresh counters")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/PaloAltoNetworks.Cloudngfw/localRulestacks/{localRulestackName}/localRules/{priority}/refreshCounters")
  @post
  refreshCounters is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("LocalRulestack resource name")
      @path
      localRulestackName: string;

      @doc("Local Rule priority")
      @path
      priority: string;

      @query firewallName: string;
    },
    void
  >;

  @doc("Reset counters")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/PaloAltoNetworks.Cloudngfw/localRulestacks/{localRulestackName}/localRules/{priority}/resetCounters")
  @post
  resetCounters is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("LocalRulestack resource name")
      @path
      localRulestackName: string;

      @doc("Local Rule priority")
      @path
      priority: string;

      @query firewallName: string;
    },
    RuleCounterReset
  >;
}

interface PrefixListLocalRulestackOperations {
  @doc("List PrefixListResource resources by LocalRulestacks")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/PaloAltoNetworks.Cloudngfw/localRulestacks/{localRulestackName}/prefixlists")
  @get
  ListByLocalRulestacks is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("LocalRulestack resource name")
      @path
      localRulestackName: string;
    },
    PrefixListResourceListResult
  >;

  @doc("Get a PrefixListResource")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/PaloAltoNetworks.Cloudngfw/localRulestacks/{localRulestackName}/prefixlists/{name}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("LocalRulestack resource name")
      @path
      localRulestackName: string;

      @doc("Local Rule priority")
      @path
      name: string;
    },
    PrefixListResource
  >;

  @doc("Create a PrefixListResource")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/PaloAltoNetworks.Cloudngfw/localRulestacks/{localRulestackName}/prefixlists/{name}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("LocalRulestack resource name")
      @path
      localRulestackName: string;

      @doc("Local Rule priority")
      @path
      name: string;

      @doc("Resource create parameters.")
      @body
      resource: PrefixListResource;
    },
    PrefixListResource
  >;

  @doc("Delete a PrefixListResource")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/PaloAltoNetworks.Cloudngfw/localRulestacks/{localRulestackName}/prefixlists/{name}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("LocalRulestack resource name")
      @path
      localRulestackName: string;

      @doc("Local Rule priority")
      @path
      name: string;
    },
    void
  >;
}
