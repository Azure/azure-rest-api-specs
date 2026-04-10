import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "../Common/main.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using Common;

namespace AlertsSuppressionRulesAPI;

/**
 * Possible states of the rule
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum RuleState {
  /**
   * Enabled
   */
  Enabled,

  /**
   * Disabled
   */
  Disabled,

  /**
   * Expired
   */
  Expired,
}

/**
 * Suppression rules list for subscription.
 */
model AlertsSuppressionRulesList is Azure.Core.Page<AlertsSuppressionRule>;

/**
 * describes AlertsSuppressionRule properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AlertsSuppressionRuleProperties {
  /**
   * Type of the alert to automatically suppress. For all alert types, use '*'
   */
  alertType: string;

  /**
   * The last time this rule was modified
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedUtc?: utcDateTime;

  /**
   * Expiration date of the rule, if value is not provided or provided as null there will no expiration at all
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expirationDateUtc?: utcDateTime;

  /**
   * The reason for dismissing the alert
   */
  reason: string;

  /**
   * Possible states of the rule
   */
  state: RuleState;

  /**
   * Any comment regarding the rule
   */
  comment?: string;

  /**
   * The suppression conditions
   */
  suppressionAlertsScope?: SuppressionAlertsScope;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SuppressionAlertsScope {
  /**
   * All the conditions inside need to be true in order to suppress the alert
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  allOf: ScopeElement[];
}

/**
 * A more specific scope used to identify the alerts to suppress.
 */
model ScopeElement {
  ...Record<unknown>;

  /**
   * The alert entity type to suppress by.
   */
  field?: string;
}

