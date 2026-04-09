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
 * A valid event source type.
 */
union EventSource {
  string,

  /**
   * Assessments
   */
  Assessments: "Assessments",

  /**
   * AssessmentsSnapshot
   */
  AssessmentsSnapshot: "AssessmentsSnapshot",

  /**
   * SubAssessments
   */
  SubAssessments: "SubAssessments",

  /**
   * SubAssessmentsSnapshot
   */
  SubAssessmentsSnapshot: "SubAssessmentsSnapshot",

  /**
   * Alerts
   */
  Alerts: "Alerts",

  /**
   * SecureScores
   */
  SecureScores: "SecureScores",

  /**
   * SecureScoresSnapshot
   */
  SecureScoresSnapshot: "SecureScoresSnapshot",

  /**
   * SecureScoreControls
   */
  SecureScoreControls: "SecureScoreControls",

  /**
   * SecureScoreControlsSnapshot
   */
  SecureScoreControlsSnapshot: "SecureScoreControlsSnapshot",

  /**
   * RegulatoryComplianceAssessment
   */
  RegulatoryComplianceAssessment: "RegulatoryComplianceAssessment",

  /**
   * RegulatoryComplianceAssessmentSnapshot
   */
  RegulatoryComplianceAssessmentSnapshot: "RegulatoryComplianceAssessmentSnapshot",

  /**
   * AttackPaths
   */
  AttackPaths: "AttackPaths",

  /**
   * AttackPathsSnapshot
   */
  AttackPathsSnapshot: "AttackPathsSnapshot",
}

/**
 * The data type of the compared operands (string, integer, floating point number or a boolean [true/false]]
 */
union PropertyType {
  string,

  /**
   * String
   */
  String: "String",

  /**
   * Integer
   */
  Integer: "Integer",

  /**
   * Number
   */
  Number: "Number",

  /**
   * Boolean
   */
  Boolean: "Boolean",
}

/**
 * A valid comparer operator to use. A case-insensitive comparison will be applied for String PropertyType.
 */
union Operator {
  string,

  /**
   * Applies for decimal and non-decimal operands
   */
  Equals: "Equals",

  /**
   * Applies only for decimal operands
   */
  GreaterThan: "GreaterThan",

  /**
   * Applies only for decimal operands
   */
  GreaterThanOrEqualTo: "GreaterThanOrEqualTo",

  /**
   * Applies only for decimal operands
   */
  LesserThan: "LesserThan",

  /**
   * Applies only for decimal operands
   */
  LesserThanOrEqualTo: "LesserThanOrEqualTo",

  /**
   * Applies  for decimal and non-decimal operands
   */
  NotEquals: "NotEquals",

  /**
   * Applies only for non-decimal operands
   */
  Contains: "Contains",

  /**
   * Applies only for non-decimal operands
   */
  StartsWith: "StartsWith",

  /**
   * Applies only for non-decimal operands
   */
  EndsWith: "EndsWith",
}

/**
 * The source type that will trigger the notification
 */
union SourceType {
  string,

  /**
   * Alert
   */
  Alert: "Alert",

  /**
   * AttackPath
   */
  AttackPath: "AttackPath",
}

/**
 * A possible role to configure sending security notification alerts to
 */
union SecurityContactRole {
  string,

  /**
   * If enabled, send notification on new alerts to the account admins
   */
  AccountAdmin: "AccountAdmin",

  /**
   * If enabled, send notification on new alerts to the service admins
   */
  ServiceAdmin: "ServiceAdmin",

  /**
   * If enabled, send notification on new alerts to the subscription owners
   */
  Owner: "Owner",

  /**
   * If enabled, send notification on new alerts to the subscription contributors
   */
  Contributor: "Contributor",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union SecurityContactName {
  string,

  /**
   * The single applicable name of the security contact object
   */
  default: "default",
}

/**
 * Defines the minimal alert severity which will be sent as email notifications
 */
union MinimalSeverity {
  string,

  /**
   * Get notifications on new alerts with High severity
   */
  High: "High",

  /**
   * Get notifications on new alerts with Medium or High severity
   */
  Medium: "Medium",

  /**
   * Get notifications on new alerts with Low, Medium or High severity
   */
  Low: "Low",
}

/**
 * Defines the minimal attack path risk level which will be sent as email notifications
 */
union MinimalRiskLevel {
  string,

  /**
   * Get notifications on new attack paths with Critical risk level
   */
  Critical: "Critical",

  /**
   * Get notifications on new attack paths with High or Critical risk level
   */
  High: "High",

  /**
   * Get notifications on new attach paths with Medium, High or Critical risk level
   */
  Medium: "Medium",

  /**
   * Get notifications on new attach paths with Low, Medium, High or Critical risk level
   */
  Low: "Low",
}

/**
 * List of security automations response.
 */
model AutomationList is Azure.Core.Page<Automation>;

/**
 * A set of properties that defines the behavior of the automation configuration. To learn more about the supported security events data models schemas - please visit https://aka.ms/ASCAutomationSchemas.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AutomationProperties {
  /**
   * The security automation description.
   */
  description?: string;

  /**
   * Indicates whether the security automation is enabled.
   */
  isEnabled?: boolean;

  /**
   * A collection of scopes on which the security automations logic is applied. Supported scopes are the subscription itself or a resource group under that subscription. The automation will only apply on defined scopes.
   */
  @identifiers(#[])
  scopes?: AutomationScope[];

  /**
   * A collection of the source event types which evaluate the security automation set of rules.
   */
  @identifiers(#[])
  sources?: AutomationSource[];

  /**
   * A collection of the actions which are triggered if all the configured rules evaluations, within at least one rule set, are true.
   */
  @identifiers(#[])
  actions?: AutomationAction[];
}

/**
 * A single automation scope.
 */
model AutomationScope {
  /**
   * The resources scope description.
   */
  description?: string;

  /**
   * The resources scope path. Can be the subscription on which the automation is defined on or a resource group under that subscription (fully qualified Azure resource IDs).
   */
  scopePath?: string;
}

/**
 * The source event types which evaluate the security automation set of rules. For example - security alerts and security assessments. To learn more about the supported security events data models schemas - please visit https://aka.ms/ASCAutomationSchemas.
 */
model AutomationSource {
  /**
   * A valid event source type.
   */
  eventSource?: EventSource;

  /**
   * A set of rules which evaluate upon event interception. A logical disjunction is applied between defined rule sets (logical 'or').
   */
  @identifiers(#[])
  ruleSets?: AutomationRuleSet[];
}

/**
 * A rule set which evaluates all its rules upon an event interception. Only when all the included rules in the rule set will be evaluated as 'true', will the event trigger the defined actions.
 */
model AutomationRuleSet {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @identifiers(#[])
  rules?: AutomationTriggeringRule[];
}

/**
 * A rule which is evaluated upon event interception. The rule is configured by comparing a specific value from the event model to an expected value. This comparison is done by using one of the supported operators set.
 */
model AutomationTriggeringRule {
  /**
   * The JPath of the entity model property that should be checked.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  propertyJPath?: string;

  /**
   * The data type of the compared operands (string, integer, floating point number or a boolean [true/false]]
   */
  propertyType?: PropertyType;

  /**
   * The expected value.
   */
  expectedValue?: string;

  /**
   * A valid comparer operator to use. A case-insensitive comparison will be applied for String PropertyType.
   */
  operator?: Operator;
}

/**
 * The action that should be triggered.
 */
@discriminator("actionType")
model AutomationAction {
  /**
   * The type of the action that will be triggered by the Automation
   */
  actionType: ActionType;
}

/**
 * The update model of security automation resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AutomationUpdateModel extends Tags {
  /**
   * Security automation data
   */
  properties?: AutomationProperties;
}

/**
 * The security automation model state property bag.
 */
model AutomationValidationStatus {
  /**
   * Indicates whether the model is valid or not.
   */
  isValid?: boolean;

  /**
   * The validation message.
   */
  message?: string;
}

/**
 * List of security contacts response
 */
model SecurityContactList is Azure.Core.Page<SecurityContact>;

/**
 * Describes security contact properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SecurityContactProperties {
  /**
   * List of email addresses which will get notifications from Microsoft Defender for Cloud by the configurations defined in this security contact.
   */
  emails?: string;

  /**
   * The security contact's phone number
   */
  phone?: string;

  /**
   * Indicates whether the security contact is enabled.
   */
  isEnabled?: boolean;

  /**
   * A collection of sources types which evaluate the email notification.
   */
  @identifiers(#[])
  notificationsSources?: NotificationsSource[];

  /**
   * Defines whether to send email notifications from Microsoft Defender for Cloud to persons with specific RBAC roles on the subscription.
   */
  notificationsByRole?: SecurityContactPropertiesNotificationsByRole;
}

/**
 * A valid notification source type
 */
@discriminator("sourceType")
model NotificationsSource {
  /**
   * The source type that will trigger the notification
   */
  sourceType: SourceType;
}

/**
 * Defines whether to send email notifications from Microsoft Defender for Cloud to persons with specific RBAC roles on the subscription.
 */
model SecurityContactPropertiesNotificationsByRole {
  /**
   * Defines whether to send email notifications from AMicrosoft Defender for Cloud to persons with specific RBAC roles on the subscription.
   */
  state?: State;

  /**
   * Defines which RBAC roles will get email notifications from Microsoft Defender for Cloud. List of allowed RBAC roles:
   */
  roles?: SecurityContactRole[];
}

/**
 * The logic app action that should be triggered. To learn more about Microsoft Defender for Cloud's Workflow Automation capabilities, visit https://aka.ms/ASCWorkflowAutomationLearnMore
 */
model AutomationActionLogicApp extends AutomationAction {
  /**
   * The triggered Logic App Azure Resource ID. This can also reside on other subscriptions, given that you have permissions to trigger the Logic App
   */
  logicAppResourceId?: string;

  /**
   * The Logic App trigger URI endpoint (it will not be included in any response).
   */
  uri?: url;

  /**
   * The type of the action that will be triggered by the Automation
   */
  actionType: "LogicApp";
}

/**
 * The target Event Hub to which event data will be exported. To learn more about Microsoft Defender for Cloud continuous export capabilities, visit https://aka.ms/ASCExportLearnMore
 */
model AutomationActionEventHub extends AutomationAction {
  /**
   * The target Event Hub Azure Resource ID.
   */
  eventHubResourceId?: string;

  /**
   * The target Event Hub SAS policy name.
   */
  @visibility(Lifecycle.Read)
  sasPolicyName?: string;

  /**
   * The target Event Hub connection string (it will not be included in any response).
   */
  connectionString?: string;

  /**
   * Indicates whether the trusted service is enabled or not.
   */
  isTrustedServiceEnabled?: boolean;

  /**
   * The type of the action that will be triggered by the Automation
   */
  actionType: "EventHub";
}

/**
 * The Log Analytics Workspace to which event data will be exported. Security alerts data will reside in the 'SecurityAlert' table and the assessments data will reside in the 'SecurityRecommendation' table (under the 'Security'/'SecurityCenterFree' solutions). Note that in order to view the data in the workspace, the Security Center Log Analytics free/standard solution needs to be enabled on that workspace. To learn more about Microsoft Defender for Cloud continuous export capabilities, visit https://aka.ms/ASCExportLearnMore
 */
model AutomationActionWorkspace extends AutomationAction {
  /**
   * The fully qualified Log Analytics Workspace Azure Resource ID.
   */
  workspaceResourceId?: string;

  /**
   * The type of the action that will be triggered by the Automation
   */
  actionType: "Workspace";
}

/**
 * Alert notification source
 */
model NotificationsSourceAlert extends NotificationsSource {
  /**
   * Defines the minimal alert severity which will be sent as email notifications
   */
  minimalSeverity?: MinimalSeverity;

  /**
   * The source type that will trigger the notification
   */
  sourceType: "Alert";
}

/**
 * Attack path notification source
 */
model NotificationsSourceAttackPath extends NotificationsSource {
  /**
   * Defines the minimal attach path risk level which will be sent as email notifications
   */
  minimalRiskLevel?: MinimalRiskLevel;

  /**
   * The source type that will trigger the notification
   */
  sourceType: "AttackPath";
}
