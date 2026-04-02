import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "../Common/main.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Security;

/**
 * The rule type of the governance rule, defines the source of the rule e.g. Integrated
 */
union GovernanceRuleType {
  string,

  /**
   * The source of the rule type definition is integrated
   */
  Integrated: "Integrated",

  /**
   * The source of the rule type definition is ServiceNow
   */
  ServiceNow: "ServiceNow",
}

/**
 * The governance rule source, what the rule affects, e.g. Assessments
 */
union GovernanceRuleSourceResourceType {
  string,

  /**
   * The source of the governance rule is assessments
   */
  Assessments: "Assessments",
}

/**
 * The owner type for the governance rule owner source
 */
union GovernanceRuleOwnerSourceType {
  string,

  /**
   * The rule source type defined using resource tag
   */
  ByTag: "ByTag",

  /**
   * The rule source type defined manually
   */
  Manually: "Manually",
}

/**
 * The status of the long run operation result of governance rule
 */
union OperationResultStatus {
  string,

  /**
   * The operation succeeded
   */
  Succeeded: "Succeeded",

  /**
   * The operation failed
   */
  Failed: "Failed",

  /**
   * The operation canceled
   */
  Canceled: "Canceled",
}

/**
 * The governance rule Condition's Operator, for example Equals for severity or In for list of assessments, see examples
 */
union GovernanceRuleConditionOperator {
  string,

  /**
   * Checks that the string value of the data defined in Property equals the given value - exact fit
   */
  Equals: "Equals",

  /**
   * Checks that the string value of the data defined in Property equals any of the given values (exact fit)
   */
  In: "In",
}

/**
 * Page of a governance assignments list
 */
model GovernanceAssignmentsList {
  /**
   * Collection of governance assignments in this page
   */
  @visibility(Lifecycle.Read)
  @pageItems
  value?: GovernanceAssignment[];

  /**
   * The URI to fetch the next page
   */
  @nextLink
  nextLink?: string;
}

/**
 * Describes properties of an governance assignment
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model GovernanceAssignmentProperties {
  @doc("The Owner for the governance assignment - e.g. user@contoso.com - see example")
  owner?: string;

  /**
   * The remediation due-date - after this date Secure Score will be affected (in case of  active grace-period)
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  remediationDueDate: utcDateTime;

  /**
   * The ETA (estimated time of arrival) for remediation (optional), see example
   */
  remediationEta?: RemediationEta;

  /**
   * Defines whether there is a grace period on the governance assignment
   */
  isGracePeriod?: boolean;

  /**
   * The email notifications settings for the governance rule, states whether to disable notifications for mangers and owners
   */
  governanceEmailNotification?: GovernanceEmailNotification;

  /**
   * The additional data for the governance assignment - e.g. links to ticket (optional), see example
   */
  additionalData?: GovernanceAssignmentAdditionalData;
}

/**
 * The ETA (estimated time of arrival) for remediation
 */
model RemediationEta {
  /**
   * ETA for remediation.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  eta: utcDateTime;

  /**
   * Justification for change of Eta.
   */
  justification: string;
}

/**
 * The governance email weekly notification configuration.
 */
model GovernanceEmailNotification {
  /**
   * Exclude manager from weekly email notification.
   */
  disableManagerEmailNotification?: boolean;

  /**
   * Exclude  owner from weekly email notification.
   */
  disableOwnerEmailNotification?: boolean;
}

/**
 * Describe the additional data of governance assignment - optional
 */
model GovernanceAssignmentAdditionalData {
  /**
   * Ticket number associated with this governance assignment
   */
  @minValue(0)
  ticketNumber?: int32;

  /**
   * Ticket link associated with this governance assignment - for example: https://snow.com
   */
  ticketLink?: string;

  /**
   * The ticket status associated with this governance assignment - for example: Active
   */
  ticketStatus?: string;
}

/**
 * Page of a governance rules list
 */
model GovernanceRuleList {
  /**
   * Collection of governance rules in this page
   */
  @visibility(Lifecycle.Read)
  @pageItems
  value?: GovernanceRule[];

  /**
   * The URI to fetch the next page
   */
  @nextLink
  nextLink?: string;
}

/**
 * Describes properties of an governance rule
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model GovernanceRuleProperties {
  /**
   * The tenantId (GUID)
   */
  @visibility(Lifecycle.Read)
  tenantId?: string;

  /**
   * Display name of the governance rule
   */
  displayName: string;

  /**
   * Description of the governance rule
   */
  description?: string;

  /**
   * Governance rule remediation timeframe - this is the time that will affect on the grace-period duration e.g. 7.00:00:00 - means 7 days
   */
  @pattern("^[0-9]+\\.[0-9]{2}:[0-9]{2}:[0-9]{2}$")
  remediationTimeframe?: string;

  /**
   * Defines whether there is a grace period on the governance rule
   */
  isGracePeriod?: boolean;

  /**
   * The governance rule priority, priority to the lower number. Rules with the same priority on the same scope will not be allowed
   */
  @maxValue(1000)
  @minValue(0)
  rulePriority: int32;

  /**
   * Defines whether the rule is active/inactive
   */
  isDisabled?: boolean;

  /**
   * The rule type of the governance rule, defines the source of the rule e.g. Integrated
   */
  ruleType: GovernanceRuleType;

  /**
   * The governance rule source, what the rule affects, e.g. Assessments
   */
  sourceResourceType: GovernanceRuleSourceResourceType;

  /**
   * Excluded scopes, filter out the descendants of the scope (on management scopes)
   */
  excludedScopes?: string[];

  /**
   * The governance rule conditionSets - see examples
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  conditionSets: Condition[][][];

  /**
   * Defines whether the rule is management scope rule (master connector as a single scope or management scope)
   */
  includeMemberScopes?: boolean;

  @doc("The owner source for the governance rule - e.g. Manually by user@contoso.com - see example")
  ownerSource: GovernanceRuleOwnerSource;

  /**
   * The email notifications settings for the governance rule, states whether to disable notifications for mangers and owners
   */
  governanceEmailNotification?: GovernanceRuleEmailNotification;

  /**
   * The governance rule metadata
   */
  metadata?: GovernanceRuleMetadata;
}

/**
 * Describe the owner source of governance rule
 */
model GovernanceRuleOwnerSource {
  /**
   * The owner type for the governance rule owner source
   */
  type?: GovernanceRuleOwnerSourceType;

  /**
   * The source value e.g. tag key like owner name or email address
   */
  value?: string;
}

/**
 * The governance email weekly notification configuration
 */
model GovernanceRuleEmailNotification {
  /**
   * Defines whether manager email notifications are disabled
   */
  disableManagerEmailNotification?: boolean;

  /**
   * Defines whether owner email notifications are disabled
   */
  disableOwnerEmailNotification?: boolean;
}

/**
 * The governance rule metadata
 */
model GovernanceRuleMetadata {
  /**
   * Governance rule Created by object id (GUID)
   */
  @visibility(Lifecycle.Read)
  createdBy?: string;

  /**
   * Governance rule creation date
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdOn?: utcDateTime;

  /**
   * Governance rule last updated by object id (GUID)
   */
  @visibility(Lifecycle.Read)
  updatedBy?: string;

  /**
   * Governance rule last update date
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  updatedOn?: utcDateTime;
}

/**
 * Governance rule execution parameters
 */
model ExecuteGovernanceRuleParams {
  /**
   * Describe if governance rule should be override
   */
  override?: boolean;
}

/**
 * Long run operation status of governance rule over a given scope
 */
model OperationResult {
  /**
   * The status of the long run operation result of governance rule
   */
  @visibility(Lifecycle.Read)
  status?: OperationResultStatus;
}

/**
 * Governance rule's condition
 */
model Condition {
  /**
   * The governance rule Condition's Property, e.g. Severity or AssessmentKey, see examples
   */
  property?: string;

  /**
   * The governance rule Condition's Value like severity Low, High or assessments keys, see examples
   */
  value?: string;

  /**
   * The governance rule Condition's Operator, for example Equals for severity or In for list of assessments, see examples
   */
  operator?: GovernanceRuleConditionOperator;
}
