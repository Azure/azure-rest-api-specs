import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/http";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Microsoft.BillingBenefits;

/**
 * A catalog group represents a BenefitResourceType + Namespace grouping used for benefit SKU discovery.
 */
model CatalogGroup
  is Azure.ResourceManager.ProxyResource<CatalogGroupProperties> {
  ...ResourceNameParameter<
    Resource = CatalogGroup,
    KeyName = "catalogGroupName",
    SegmentName = "catalogGroups",
    NamePattern = "^[a-zA-Z0-9_\\-\\.]+$"
  >;
}

/**
 * Additional parameters for the CatalogGroups list operation.
 */
model CatalogGroupsListParameters {
  /**
   * OData filter expression to narrow the list of catalog groups.
   */
  @query("$filter")
  $filter?: string;
}

/**
 * Reusable CatalogGroup extension operations for a specific target scope.
 */
interface CatalogGroupsExtensionOps<Scope extends Azure.ResourceManager.Foundations.SimpleResource> {
  /**
   * List catalog groups at the target scope.
   */
  list is Extension.ListByTarget<
    Scope,
    CatalogGroup,
    CatalogGroupsListParameters
  >;

  /**
   * Get a specific catalog group at the target scope.
   */
  get is Extension.Read<Scope, CatalogGroup>;
}

/**
 * Subscription scope: /subscriptions/{subscriptionId}
 */
alias SubscriptionScope = Extension.Subscription;

/**
 * Billing account scope: /providers/Microsoft.Billing/billingAccounts/{billingAccountName}
 */
alias BillingAccountScope = Extension.ExternalResource<
  TargetNamespace = "Microsoft.Billing",
  ResourceType = "billingAccounts",
  ResourceParameterName = "billingAccountName",
  NamePattern = "^[a-zA-Z0-9_\\-\\.:]+$",
  Description = "The name of the billing account.",
  ParentType = "Tenant"
>;

/**
 * Billing profile scope: /providers/Microsoft.Billing/billingAccounts/{billingAccountName}/billingProfiles/{billingProfileName}
 */
alias BillingProfileScope = Extension.ExternalChildResource<
  BillingAccountScope,
  "billingProfiles",
  "billingProfileName",
  NamePattern = "^[a-zA-Z0-9_\\-\\.]+$",
  Description = "The name of the billing profile."
>;

@armResourceOperations
interface SubscriptionCatalogGroupsOps
  extends CatalogGroupsExtensionOps<SubscriptionScope> {}

@armResourceOperations
interface BillingAccountCatalogGroupsOps
  extends CatalogGroupsExtensionOps<BillingAccountScope> {}

@armResourceOperations
interface BillingProfileCatalogGroupsOps
  extends CatalogGroupsExtensionOps<BillingProfileScope> {}
