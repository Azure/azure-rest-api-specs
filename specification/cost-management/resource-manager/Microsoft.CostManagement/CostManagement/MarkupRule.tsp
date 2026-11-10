import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.CostManagement;

/**
 * Markup rule
 */
@added(Versions.v2026_06_01)
@tenantResource
model MarkupRule is Azure.ResourceManager.ProxyResource<MarkupRuleProperties> {
  ...ResourceNameParameter<
    Resource = MarkupRule,
    KeyName = "ruleName",
    SegmentName = "markupRules",
    NamePattern = "^[a-zA-Z0-9_][a-zA-Z0-9_-]{0,63}$"
  >;
}

/**
 * The billing account that a markup rule's billing profile belongs to, addressed
 * under the Microsoft.Billing provider at tenant scope.
 */
alias MarkupRuleBillingAccount = Extension.ExternalResource<
  "Microsoft.Billing",
  "billingAccounts",
  "billingAccountId",
  Description = "BillingAccount ID",
  ParentType = "Tenant"
>;

/**
 * The billing profile that a markup rule is scoped to, addressed as a child of a
 * billing account under the Microsoft.Billing provider.
 */
alias MarkupRuleBillingProfile = Extension.ExternalChildResource<
  MarkupRuleBillingAccount,
  "billingProfiles",
  "billingProfileId",
  Description = "BillingProfile ID"
>;

@added(Versions.v2026_06_01)
@armResourceOperations
interface MarkupRules {
  /**
   * Get a markup rule by name for a billing account and billing profile.
   */
  get is Extension.Read<
    MarkupRuleBillingProfile,
    MarkupRule,
    Error = ErrorResponse
  >;

  /**
   * Create or update a markup rule for a billing account and billing profile.
   */
  createOrUpdate is Extension.CreateOrReplaceSync<
    MarkupRuleBillingProfile,
    MarkupRule,
    Error = ErrorResponse
  >;

  /**
   * Delete a markup rule for a billing account and billing profile.
   */
  delete is Extension.DeleteSync<
    MarkupRuleBillingProfile,
    MarkupRule,
    Error = ErrorResponse
  >;

  /**
   * List all markup rules for a billing account and billing profile.
   */
  list is Extension.ListByTarget<
    MarkupRuleBillingProfile,
    MarkupRule,
    Response = ArmResponse<MarkupRulePagedResponse>,
    Error = ErrorResponse
  >;
}

@@doc(MarkupRule.name, "Markup rule name.");
@@doc(MarkupRule.properties, "Markup rule properties");
@@doc(
  MarkupRules.createOrUpdate::parameters.resource,
  "The markup rule to create or update."
);
