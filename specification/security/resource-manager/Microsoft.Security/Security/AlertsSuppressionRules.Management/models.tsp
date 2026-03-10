import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Security;

/**
 * Possible states of the rule
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
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
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
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

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model SuppressionAlertsScope {
  /**
   * All the conditions inside need to be true in order to suppress the alert
   */
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

/**
 * Describes an Azure resource.
 */
model Resource {
  /**
   * Resource Id
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Resource name
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Resource type
   */
  @visibility(Lifecycle.Read)
  type?: string;
}

/**
 * Common error response for all Azure Resource Manager APIs to return error details for failed operations. (This also follows the OData error response format.).
 */
@error
model CloudError {
  /**
   * The error object.
   */
  error?: CloudErrorBody;
}

/**
 * The error detail.
 */
model CloudErrorBody {
  /**
   * The error code.
   */
  @visibility(Lifecycle.Read)
  code?: string;

  /**
   * The error message.
   */
  @visibility(Lifecycle.Read)
  message?: string;

  /**
   * The error target.
   */
  @visibility(Lifecycle.Read)
  target?: string;

  /**
   * The error details.
   */
  @visibility(Lifecycle.Read)
  details?: CloudErrorBody[];

  /**
   * The error additional info.
   */
  @visibility(Lifecycle.Read)
  additionalInfo?: ErrorAdditionalInfo[];
}

/**
 * The resource management error additional info.
 */
model ErrorAdditionalInfo {
  /**
   * The additional info type.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * The additional info.
   */
  @visibility(Lifecycle.Read)
  info?: unknown;
}
