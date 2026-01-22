import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.SecurityInsights;

/**
 * The kind of the alert rule
 */
union AlertRuleKind {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Scheduled: "Scheduled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  MicrosoftSecurityIncidentCreation: "MicrosoftSecurityIncidentCreation",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Fusion: "Fusion",
}

/**
 * The type of identity that created the resource.
 */
union CreatedByType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  User: "User",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Application: "Application",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ManagedIdentity: "ManagedIdentity",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Key: "Key",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union TriggersOn {
  string,

  /**
   * Trigger on Incidents
   */
  Incidents: "Incidents",

  /**
   * Trigger on Alerts
   */
  Alerts: "Alerts",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union TriggersWhen {
  string,

  /**
   * Trigger on created objects
   */
  Created: "Created",

  /**
   * Trigger on updated objects
   */
  Updated: "Updated",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union ConditionType {
  string,

  /**
   * Evaluate an object property value
   */
  Property: "Property",

  /**
   * Evaluate an object array property value
   */
  PropertyArray: "PropertyArray",

  /**
   * Evaluate an object property changed value
   */
  PropertyChanged: "PropertyChanged",

  /**
   * Evaluate an object array property changed value
   */
  PropertyArrayChanged: "PropertyArrayChanged",

  /**
   * Apply a boolean operator (e.g AND, OR) to conditions
   */
  Boolean: "Boolean",
}

/**
 * The type of the automation rule action.
 */
union ActionType {
  string,

  /**
   * Modify an object's properties
   */
  ModifyProperties: "ModifyProperties",

  /**
   * Run a playbook on an object
   */
  RunPlaybook: "RunPlaybook",

  /**
   * Add a task to an incident object
   */
  AddIncidentTask: "AddIncidentTask",
}

/**
 * The severity of the incident
 */
union IncidentSeverity {
  string,

  /**
   * High severity
   */
  High: "High",

  /**
   * Medium severity
   */
  Medium: "Medium",

  /**
   * Low severity
   */
  Low: "Low",

  /**
   * Informational severity
   */
  Informational: "Informational",
}

/**
 * The package kind
 */
union PackageKind {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Solution: "Solution",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standalone: "Standalone",
}

/**
 * The boolean value the metadata is for.
 */
union Flag {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `true`: "true",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `false`: "false",
}

/**
 * Source type of the content
 */
union SourceKind {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  LocalWorkspace: "LocalWorkspace",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Community: "Community",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Solution: "Solution",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SourceRepository: "SourceRepository",
}

/**
 * Type of support for content item
 */
union SupportTier {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Microsoft: "Microsoft",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Partner: "Partner",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Community: "Community",
}

/**
 * The kind of content the metadata is for.
 */
union Kind {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  DataConnector: "DataConnector",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  DataType: "DataType",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Workbook: "Workbook",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  WorkbookTemplate: "WorkbookTemplate",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Playbook: "Playbook",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  PlaybookTemplate: "PlaybookTemplate",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AnalyticsRuleTemplate: "AnalyticsRuleTemplate",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AnalyticsRule: "AnalyticsRule",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  HuntingQuery: "HuntingQuery",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  InvestigationQuery: "InvestigationQuery",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Parser: "Parser",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Watchlist: "Watchlist",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  WatchlistTemplate: "WatchlistTemplate",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Solution: "Solution",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AzureFunction: "AzureFunction",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  LogicAppsCustomConnector: "LogicAppsCustomConnector",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AutomationRule: "AutomationRule",

  /**
   * The Codeless Connector Platform (CCP) Connectors
   */
  ResourcesDataConnector: "ResourcesDataConnector",

  /**
   * Jupyter Notebooks
   */
  Notebook: "Notebook",

  /**
   * one-off / standalone content contributed by community contributors
   */
  Standalone: "Standalone",

  /**
   * Summary rules perform batch processing directly in your Log Analytics workspace.
   */
  SummaryRule: "SummaryRule",
}

/**
 * Operator used for list of dependencies in criteria array.
 */
union Operator {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AND: "AND",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  OR: "OR",
}

/**
 * The kind of the data connector definitions
 */
union DataConnectorDefinitionKind {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Customizable: "Customizable",
}

/**
 * The kind of the data connector
 */
union DataConnectorKind {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AzureActiveDirectory: "AzureActiveDirectory",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AzureSecurityCenter: "AzureSecurityCenter",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  MicrosoftCloudAppSecurity: "MicrosoftCloudAppSecurity",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ThreatIntelligence: "ThreatIntelligence",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  MicrosoftThreatIntelligence: "MicrosoftThreatIntelligence",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  PremiumMicrosoftDefenderForThreatIntelligence: "PremiumMicrosoftDefenderForThreatIntelligence",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Office365: "Office365",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AmazonWebServicesCloudTrail: "AmazonWebServicesCloudTrail",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AzureAdvancedThreatProtection: "AzureAdvancedThreatProtection",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  MicrosoftDefenderAdvancedThreatProtection: "MicrosoftDefenderAdvancedThreatProtection",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  RestApiPoller: "RestApiPoller",
}

/**
 * The severity for alerts created by this alert rule.
 */
union AttackTactic {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Reconnaissance: "Reconnaissance",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ResourceDevelopment: "ResourceDevelopment",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  InitialAccess: "InitialAccess",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Execution: "Execution",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Persistence: "Persistence",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  PrivilegeEscalation: "PrivilegeEscalation",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  DefenseEvasion: "DefenseEvasion",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  CredentialAccess: "CredentialAccess",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Discovery: "Discovery",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  LateralMovement: "LateralMovement",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Collection: "Collection",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Exfiltration: "Exfiltration",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  CommandAndControl: "CommandAndControl",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Impact: "Impact",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  PreAttack: "PreAttack",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ImpairProcessControl: "ImpairProcessControl",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  InhibitResponseFunction: "InhibitResponseFunction",
}

/**
 * The reason the incident was closed
 */
union IncidentClassification {
  string,

  /**
   * Incident classification was undetermined
   */
  Undetermined: "Undetermined",

  /**
   * Incident was true positive
   */
  TruePositive: "TruePositive",

  /**
   * Incident was benign positive
   */
  BenignPositive: "BenignPositive",

  /**
   * Incident was false positive
   */
  FalsePositive: "FalsePositive",
}

/**
 * The classification reason the incident was closed with
 */
union IncidentClassificationReason {
  string,

  /**
   * Classification reason was suspicious activity
   */
  SuspiciousActivity: "SuspiciousActivity",

  /**
   * Classification reason was suspicious but expected
   */
  SuspiciousButExpected: "SuspiciousButExpected",

  /**
   * Classification reason was incorrect alert logic
   */
  IncorrectAlertLogic: "IncorrectAlertLogic",

  /**
   * Classification reason was inaccurate data
   */
  InaccurateData: "InaccurateData",
}

/**
 * The type of the label
 */
union IncidentLabelType {
  string,

  /**
   * Label manually created by a user
   */
  User: "User",

  /**
   * Label automatically created by the system
   */
  AutoAssigned: "AutoAssigned",
}

/**
 * The type of the owner the incident is assigned to.
 */
union OwnerType {
  string,

  /**
   * The incident owner type is unknown
   */
  Unknown: "Unknown",

  /**
   * The incident owner type is an AAD user
   */
  User: "User",

  /**
   * The incident owner type is an AAD group
   */
  Group: "Group",
}

/**
 * The status of the incident
 */
union IncidentStatus {
  string,

  /**
   * An active incident which isn't being handled currently
   */
  New: "New",

  /**
   * An active incident which is being handled
   */
  Active: "Active",

  /**
   * A non-active incident
   */
  Closed: "Closed",
}

/**
 * The confidence level of this alert.
 */
union ConfidenceLevel {
  string,

  /**
   * Unknown confidence, the is the default value
   */
  Unknown: "Unknown",

  /**
   * Low confidence, meaning we have some doubts this is indeed malicious or part of an attack
   */
  Low: "Low",

  /**
   * High confidence that the alert is true positive malicious
   */
  High: "High",
}

/**
 * The confidence score calculation status, i.e. indicating if score calculation is pending for this alert, not applicable or final.
 */
union ConfidenceScoreStatus {
  string,

  /**
   * Score will not be calculated for this alert as it is not supported by virtual analyst
   */
  NotApplicable: "NotApplicable",

  /**
   * No score was set yet and calculation is in progress
   */
  InProcess: "InProcess",

  /**
   * Score is calculated and shown as part of the alert, but may be updated again at a later time following the processing of additional data
   */
  NotFinal: "NotFinal",

  /**
   * Final score was calculated and available
   */
  Final: "Final",
}

/**
 * Holds the alert intent stage(s) mapping for this alert.
 */
union KillChainIntent {
  string,

  /**
   * The default value.
   */
  Unknown: "Unknown",

  /**
   * Probing could be an attempt to access a certain resource regardless of a malicious intent or a failed attempt to gain access to a target system to gather information prior to exploitation. This step is usually detected as an attempt originating from outside the network in attempt to scan the target system and find a way in.
   */
  Probing: "Probing",

  /**
   * Exploitation is the stage where an attacker manage to get foothold on the attacked resource. This stage is applicable not only for compute hosts, but also for resources such as user accounts, certificates etc. Adversaries will often be able to control the resource after this stage.
   */
  Exploitation: "Exploitation",

  /**
   * Persistence is any access, action, or configuration change to a system that gives an adversary a persistent presence on that system. Adversaries will often need to maintain access to systems through interruptions such as system restarts, loss of credentials, or other failures that would require a remote access tool to restart or alternate backdoor for them to regain access.
   */
  Persistence: "Persistence",

  /**
   * Privilege escalation is the result of actions that allow an adversary to obtain a higher level of permissions on a system or network. Certain tools or actions require a higher level of privilege to work and are likely necessary at many points throughout an operation. User accounts with permissions to access specific systems or perform specific functions necessary for adversaries to achieve their objective may also be considered an escalation of privilege.
   */
  PrivilegeEscalation: "PrivilegeEscalation",

  /**
   * Defense evasion consists of techniques an adversary may use to evade detection or avoid other defenses. Sometimes these actions are the same as or variations of techniques in other categories that have the added benefit of subverting a particular defense or mitigation.
   */
  DefenseEvasion: "DefenseEvasion",

  /**
   * Credential access represents techniques resulting in access to or control over system, domain, or service credentials that are used within an enterprise environment. Adversaries will likely attempt to obtain legitimate credentials from users or administrator accounts (local system administrator or domain users with administrator access) to use within the network. With sufficient access within a network, an adversary can create accounts for later use within the environment.
   */
  CredentialAccess: "CredentialAccess",

  /**
   * Discovery consists of techniques that allow the adversary to gain knowledge about the system and internal network. When adversaries gain access to a new system, they must orient themselves to what they now have control of and what benefits operating from that system give to their current objective or overall goals during the intrusion. The operating system provides many native tools that aid in this post-compromise information-gathering phase.
   */
  Discovery: "Discovery",

  /**
   * Lateral movement consists of techniques that enable an adversary to access and control remote systems on a network and could, but does not necessarily, include execution of tools on remote systems. The lateral movement techniques could allow an adversary to gather information from a system without needing additional tools, such as a remote access tool. An adversary can use lateral movement for many purposes, including remote Execution of tools, pivoting to additional systems, access to specific information or files, access to additional credentials, or to cause an effect.
   */
  LateralMovement: "LateralMovement",

  /**
   * The execution tactic represents techniques that result in execution of adversary-controlled code on a local or remote system. This tactic is often used in conjunction with lateral movement to expand access to remote systems on a network.
   */
  Execution: "Execution",

  /**
   * Collection consists of techniques used to identify and gather information, such as sensitive files, from a target network prior to exfiltration. This category also covers locations on a system or network where the adversary may look for information to exfiltrate.
   */
  Collection: "Collection",

  /**
   * Exfiltration refers to techniques and attributes that result or aid in the adversary removing files and information from a target network. This category also covers locations on a system or network where the adversary may look for information to exfiltrate.
   */
  Exfiltration: "Exfiltration",

  /**
   * The command and control tactic represents how adversaries communicate with systems under their control within a target network.
   */
  CommandAndControl: "CommandAndControl",

  /**
   * The impact intent primary objective is to directly reduce the availability or integrity of a system, service, or network; including manipulation of data to impact a business or operational process. This would often refer to techniques such as ransom-ware, defacement, data manipulation and others.
   */
  Impact: "Impact",
}

/**
 * The severity of the alert
 */
union AlertSeverity {
  string,

  /**
   * High severity
   */
  High: "High",

  /**
   * Medium severity
   */
  Medium: "Medium",

  /**
   * Low severity
   */
  Low: "Low",

  /**
   * Informational severity
   */
  Informational: "Informational",
}

/**
 * The lifecycle status of the alert.
 */
union AlertStatus {
  string,

  /**
   * Unknown value
   */
  Unknown: "Unknown",

  /**
   * New alert
   */
  New: "New",

  /**
   * Alert closed after handling
   */
  Resolved: "Resolved",

  /**
   * Alert dismissed as false positive
   */
  Dismissed: "Dismissed",

  /**
   * Alert is being handled
   */
  InProgress: "InProgress",
}

/**
 * The kind of the entity
 */
union EntityKindEnum {
  string,

  /**
   * Entity represents account in the system.
   */
  Account: "Account",

  /**
   * Entity represents host in the system.
   */
  Host: "Host",

  /**
   * Entity represents file in the system.
   */
  File: "File",

  /**
   * Entity represents azure resource in the system.
   */
  AzureResource: "AzureResource",

  /**
   * Entity represents cloud application in the system.
   */
  CloudApplication: "CloudApplication",

  /**
   * Entity represents dns resolution in the system.
   */
  DnsResolution: "DnsResolution",

  /**
   * Entity represents file hash in the system.
   */
  FileHash: "FileHash",

  /**
   * Entity represents ip in the system.
   */
  Ip: "Ip",

  /**
   * Entity represents malware in the system.
   */
  Malware: "Malware",

  /**
   * Entity represents process in the system.
   */
  Process: "Process",

  /**
   * Entity represents registry key in the system.
   */
  RegistryKey: "RegistryKey",

  /**
   * Entity represents registry value in the system.
   */
  RegistryValue: "RegistryValue",

  /**
   * Entity represents security group in the system.
   */
  SecurityGroup: "SecurityGroup",

  /**
   * Entity represents url in the system.
   */
  Url: "Url",

  /**
   * Entity represents IoT device in the system.
   */
  IoTDevice: "IoTDevice",

  /**
   * Entity represents security alert in the system.
   */
  SecurityAlert: "SecurityAlert",

  /**
   * Entity represents bookmark in the system.
   */
  Bookmark: "Bookmark",

  /**
   * Entity represents mail cluster in the system.
   */
  MailCluster: "MailCluster",

  /**
   * Entity represents mail message in the system.
   */
  MailMessage: "MailMessage",

  /**
   * Entity represents mailbox in the system.
   */
  Mailbox: "Mailbox",

  /**
   * Entity represents submission mail in the system.
   */
  SubmissionMail: "SubmissionMail",
}

/**
 * The status of the task
 */
union IncidentTaskStatus {
  string,

  /**
   * A new task
   */
  New: "New",

  /**
   * A completed task
   */
  Completed: "Completed",
}

/**
 * The kind of security ML analytics settings
 */
union SecurityMLAnalyticsSettingsKind {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Anomaly: "Anomaly",
}

/**
 * The kind of repository access credentials
 */
union RepositoryAccessKind {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  OAuth: "OAuth",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  PAT: "PAT",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  App: "App",
}

/**
 * The version of the source control.
 */
union Version {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  V1: "V1",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  V2: "V2",
}

/**
 * The type of repository.
 */
union RepoType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Github: "Github",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AzureDevOps: "AzureDevOps",
}

/**
 * The content type of a source control path.
 */
union ContentType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AnalyticsRule: "AnalyticsRule",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AutomationRule: "AutomationRule",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  HuntingQuery: "HuntingQuery",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Parser: "Parser",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Playbook: "Playbook",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Workbook: "Workbook",
}

/**
 * Status while trying to fetch the deployment information.
 */
union DeploymentFetchStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Success: "Success",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Unauthorized: "Unauthorized",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NotFound: "NotFound",
}

/**
 * The current state of the deployment.
 */
union DeploymentState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  In_Progress: "In_Progress",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Completed: "Completed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Queued: "Queued",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Canceling: "Canceling",
}

/**
 * Status while trying to fetch the deployment information.
 */
union DeploymentResult {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Success: "Success",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Canceled: "Canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
}

/**
 * Status of the pull request.
 */
union State {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Open: "Open",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Closed: "Closed",
}

/**
 * The type of repository.
 */
union WarningCode {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SourceControlWarning_DeleteServicePrincipal: "SourceControlWarning_DeleteServicePrincipal",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SourceControlWarning_DeletePipelineFromAzureDevOps: "SourceControlWarning_DeletePipelineFromAzureDevOps",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SourceControlWarning_DeleteWorkflowAndSecretFromGitHub: "SourceControlWarning_DeleteWorkflowAndSecretFromGitHub",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SourceControlWarning_DeleteRoleAssignment: "SourceControlWarning_DeleteRoleAssignment",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SourceControl_DeletedWithWarnings: "SourceControl_DeletedWithWarnings",
}

/**
 * The kind of the threat intelligence entity
 */
union ThreatIntelligenceResourceInnerKind {
  string,

  /**
   * Entity represents threat intelligence indicator in the system.
   */
  indicator: "indicator",
}

/**
 * Sorting order (ascending/descending/unsorted).
 */
union ThreatIntelligenceSortingOrder {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  unsorted: "unsorted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ascending: "ascending",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  descending: "descending",
}

/**
 * The sourceType of the watchlist
 */
union SourceType {
  string,

  /**
   * The source from local file.
   */
  Local: "Local",

  /**
   * The source from Azure storage.
   */
  AzureStorage: "AzureStorage",
}

/**
 * Describes provisioning state
 */
union ProvisioningState {
  string,

  /**
   * The New provisioning state.
   */
  New: "New",

  /**
   * The InProgress provisioning state.
   */
  InProgress: "InProgress",

  /**
   * The Uploading provisioning state.
   */
  Uploading: "Uploading",

  /**
   * The Deleting provisioning state.
   */
  Deleting: "Deleting",

  /**
   * The Succeeded provisioning state.
   */
  Succeeded: "Succeeded",

  /**
   * The Failed provisioning state.
   */
  Failed: "Failed",

  /**
   * The Canceled provisioning state.
   */
  Canceled: "Canceled",
}

/**
 * The alert rule template status.
 */
union TemplateStatus {
  string,

  /**
   * Alert rule template installed. and can not use more then once
   */
  Installed: "Installed",

  /**
   * Alert rule template is available.
   */
  Available: "Available",

  /**
   * Alert rule template is not available
   */
  NotAvailable: "NotAvailable",
}

/**
 * The alerts' productName on which the cases will be generated
 */
union MicrosoftSecurityProductName {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `Microsoft Cloud App Security`: "Microsoft Cloud App Security",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `Azure Security Center`: "Azure Security Center",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `Azure Advanced Threat Protection`: "Azure Advanced Threat Protection",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `Azure Active Directory Identity Protection`: "Azure Active Directory Identity Protection",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `Azure Security Center for IoT`: "Azure Security Center for IoT",
}

/**
 * Grouping matching method. When method is Selected at least one of groupByEntities, groupByAlertDetails, groupByCustomDetails must be provided and not empty.
 */
union MatchingMethod {
  string,

  /**
   * Grouping alerts into a single incident if all the entities match
   */
  AllEntities: "AllEntities",

  /**
   * Grouping any alerts triggered by this rule into a single incident
   */
  AnyAlert: "AnyAlert",

  /**
   * Grouping alerts into a single incident if the selected entities, custom details and alert details match
   */
  Selected: "Selected",
}

/**
 * The V3 type of the mapped entity
 */
union EntityMappingType {
  string,

  /**
   * User account entity type
   */
  Account: "Account",

  /**
   * Host entity type
   */
  Host: "Host",

  /**
   * IP address entity type
   */
  IP: "IP",

  /**
   * Malware entity type
   */
  Malware: "Malware",

  /**
   * System file entity type
   */
  File: "File",

  /**
   * Process entity type
   */
  Process: "Process",

  /**
   * Cloud app entity type
   */
  CloudApplication: "CloudApplication",

  /**
   * DNS entity type
   */
  DNS: "DNS",

  /**
   * Azure resource entity type
   */
  AzureResource: "AzureResource",

  /**
   * File-hash entity type
   */
  FileHash: "FileHash",

  /**
   * Registry key entity type
   */
  RegistryKey: "RegistryKey",

  /**
   * Registry value entity type
   */
  RegistryValue: "RegistryValue",

  /**
   * Security group entity type
   */
  SecurityGroup: "SecurityGroup",

  /**
   * URL entity type
   */
  URL: "URL",

  /**
   * Mailbox entity type
   */
  Mailbox: "Mailbox",

  /**
   * Mail cluster entity type
   */
  MailCluster: "MailCluster",

  /**
   * Mail message entity type
   */
  MailMessage: "MailMessage",

  /**
   * Submission mail entity type
   */
  SubmissionMail: "SubmissionMail",
}

/**
 * Alert detail
 */
union AlertDetail {
  string,

  /**
   * Alert display name
   */
  DisplayName: "DisplayName",

  /**
   * Alert severity
   */
  Severity: "Severity",
}

/**
 * The event grouping aggregation kinds
 */
union EventGroupingAggregationKind {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SingleAlert: "SingleAlert",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AlertPerResult: "AlertPerResult",
}

/**
 * The V3 alert property
 */
union AlertProperty {
  string,

  /**
   * Alert's link
   */
  AlertLink: "AlertLink",

  /**
   * Confidence level property
   */
  ConfidenceLevel: "ConfidenceLevel",

  /**
   * Confidence score
   */
  ConfidenceScore: "ConfidenceScore",

  /**
   * Extended links to the alert
   */
  ExtendedLinks: "ExtendedLinks",

  /**
   * Product name alert property
   */
  ProductName: "ProductName",

  /**
   * Provider name alert property
   */
  ProviderName: "ProviderName",

  /**
   * Product component name alert property
   */
  ProductComponentName: "ProductComponentName",

  /**
   * Remediation steps alert property
   */
  RemediationSteps: "RemediationSteps",

  /**
   * Techniques alert property
   */
  Techniques: "Techniques",
}

/**
 * Describes a boolean condition operator.
 */
union AutomationRuleBooleanConditionSupportedOperator {
  string,

  /**
   * Evaluates as true if all the item conditions are evaluated as true
   */
  And: "And",

  /**
   * Evaluates as true if at least one of the item conditions are evaluated as true
   */
  Or: "Or",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union AutomationRulePropertyArrayChangedConditionSupportedArrayType {
  string,

  /**
   * Evaluate the condition on the alerts
   */
  Alerts: "Alerts",

  /**
   * Evaluate the condition on the labels
   */
  Labels: "Labels",

  /**
   * Evaluate the condition on the tactics
   */
  Tactics: "Tactics",

  /**
   * Evaluate the condition on the comments
   */
  Comments: "Comments",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union AutomationRulePropertyArrayChangedConditionSupportedChangeType {
  string,

  /**
   * Evaluate the condition on items added to the array
   */
  Added: "Added",
}

/**
 * Describes an array condition evaluated array type.
 */
union AutomationRulePropertyArrayConditionSupportedArrayType {
  string,

  /**
   * Evaluate the condition on the custom detail keys
   */
  CustomDetails: "CustomDetails",

  /**
   * Evaluate the condition on a custom detail's values
   */
  CustomDetailValues: "CustomDetailValues",
}

/**
 * Describes an array condition evaluation type.
 */
union AutomationRulePropertyArrayConditionSupportedArrayConditionType {
  string,

  /**
   * Evaluate the condition as true if any item fulfills it
   */
  AnyItem: "AnyItem",

  /**
   * Evaluate the condition as true if all the items fulfill it
   */
  AllItems: "AllItems",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union AutomationRulePropertyChangedConditionSupportedPropertyType {
  string,

  /**
   * Evaluate the condition on the incident severity
   */
  IncidentSeverity: "IncidentSeverity",

  /**
   * Evaluate the condition on the incident status
   */
  IncidentStatus: "IncidentStatus",

  /**
   * Evaluate the condition on the incident owner
   */
  IncidentOwner: "IncidentOwner",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union AutomationRulePropertyChangedConditionSupportedChangedType {
  string,

  /**
   * Evaluate the condition on the previous value of the property
   */
  ChangedFrom: "ChangedFrom",

  /**
   * Evaluate the condition on the updated value of the property
   */
  ChangedTo: "ChangedTo",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union AutomationRulePropertyConditionSupportedOperator {
  string,

  /**
   * Evaluates if the property equals at least one of the condition values
   */
  Equals: "Equals",

  /**
   * Evaluates if the property does not equal any of the condition values
   */
  NotEquals: "NotEquals",

  /**
   * Evaluates if the property contains at least one of the condition values
   */
  Contains: "Contains",

  /**
   * Evaluates if the property does not contain any of the condition values
   */
  NotContains: "NotContains",

  /**
   * Evaluates if the property starts with any of the condition values
   */
  StartsWith: "StartsWith",

  /**
   * Evaluates if the property does not start with any of the condition values
   */
  NotStartsWith: "NotStartsWith",

  /**
   * Evaluates if the property ends with any of the condition values
   */
  EndsWith: "EndsWith",

  /**
   * Evaluates if the property does not end with any of the condition values
   */
  NotEndsWith: "NotEndsWith",
}

/**
 * The property to evaluate in an automation rule property condition.
 */
union AutomationRulePropertyConditionSupportedProperty {
  string,

  /**
   * The title of the incident
   */
  IncidentTitle: "IncidentTitle",

  /**
   * The description of the incident
   */
  IncidentDescription: "IncidentDescription",

  /**
   * The severity of the incident
   */
  IncidentSeverity: "IncidentSeverity",

  /**
   * The status of the incident
   */
  IncidentStatus: "IncidentStatus",

  /**
   * The related Analytic rule ids of the incident
   */
  IncidentRelatedAnalyticRuleIds: "IncidentRelatedAnalyticRuleIds",

  /**
   * The tactics of the incident
   */
  IncidentTactics: "IncidentTactics",

  /**
   * The labels of the incident
   */
  IncidentLabel: "IncidentLabel",

  /**
   * The provider name of the incident
   */
  IncidentProviderName: "IncidentProviderName",

  /**
   * The update source of the incident
   */
  IncidentUpdatedBySource: "IncidentUpdatedBySource",

  /**
   * The incident custom detail key
   */
  IncidentCustomDetailsKey: "IncidentCustomDetailsKey",

  /**
   * The incident custom detail value
   */
  IncidentCustomDetailsValue: "IncidentCustomDetailsValue",

  /**
   * The account Azure Active Directory tenant id
   */
  AccountAadTenantId: "AccountAadTenantId",

  /**
   * The account Azure Active Directory user id
   */
  AccountAadUserId: "AccountAadUserId",

  /**
   * The account name
   */
  AccountName: "AccountName",

  /**
   * The account NetBIOS domain name
   */
  AccountNTDomain: "AccountNTDomain",

  /**
   * The account Azure Active Directory Passport User ID
   */
  AccountPUID: "AccountPUID",

  /**
   * The account security identifier
   */
  AccountSid: "AccountSid",

  /**
   * The account unique identifier
   */
  AccountObjectGuid: "AccountObjectGuid",

  /**
   * The account user principal name suffix
   */
  AccountUPNSuffix: "AccountUPNSuffix",

  /**
   * The name of the product of the alert
   */
  AlertProductNames: "AlertProductNames",

  /**
   * The analytic rule ids of the alert
   */
  AlertAnalyticRuleIds: "AlertAnalyticRuleIds",

  /**
   * The Azure resource id
   */
  AzureResourceResourceId: "AzureResourceResourceId",

  /**
   * The Azure resource subscription id
   */
  AzureResourceSubscriptionId: "AzureResourceSubscriptionId",

  /**
   * The cloud application identifier
   */
  CloudApplicationAppId: "CloudApplicationAppId",

  /**
   * The cloud application name
   */
  CloudApplicationAppName: "CloudApplicationAppName",

  /**
   * The dns record domain name
   */
  DNSDomainName: "DNSDomainName",

  /**
   * The file directory full path
   */
  FileDirectory: "FileDirectory",

  /**
   * The file name without path
   */
  FileName: "FileName",

  /**
   * The file hash value
   */
  FileHashValue: "FileHashValue",

  /**
   * The host Azure resource id
   */
  HostAzureID: "HostAzureID",

  /**
   * The host name without domain
   */
  HostName: "HostName",

  /**
   * The host NetBIOS name
   */
  HostNetBiosName: "HostNetBiosName",

  /**
   * The host NT domain
   */
  HostNTDomain: "HostNTDomain",

  /**
   * The host operating system
   */
  HostOSVersion: "HostOSVersion",

  /**
   * "The IoT device id
   */
  IoTDeviceId: "IoTDeviceId",

  /**
   * The IoT device name
   */
  IoTDeviceName: "IoTDeviceName",

  /**
   * The IoT device type
   */
  IoTDeviceType: "IoTDeviceType",

  /**
   * The IoT device vendor
   */
  IoTDeviceVendor: "IoTDeviceVendor",

  /**
   * The IoT device model
   */
  IoTDeviceModel: "IoTDeviceModel",

  /**
   * The IoT device operating system
   */
  IoTDeviceOperatingSystem: "IoTDeviceOperatingSystem",

  /**
   * The IP address
   */
  IPAddress: "IPAddress",

  /**
   * The mailbox display name
   */
  MailboxDisplayName: "MailboxDisplayName",

  /**
   * The mailbox primary address
   */
  MailboxPrimaryAddress: "MailboxPrimaryAddress",

  /**
   * The mailbox user principal name
   */
  MailboxUPN: "MailboxUPN",

  /**
   * The mail message delivery action
   */
  MailMessageDeliveryAction: "MailMessageDeliveryAction",

  /**
   * The mail message delivery location
   */
  MailMessageDeliveryLocation: "MailMessageDeliveryLocation",

  /**
   * The mail message recipient
   */
  MailMessageRecipient: "MailMessageRecipient",

  /**
   * The mail message sender IP address
   */
  MailMessageSenderIP: "MailMessageSenderIP",

  /**
   * The mail message subject
   */
  MailMessageSubject: "MailMessageSubject",

  /**
   * The mail message P1 sender
   */
  MailMessageP1Sender: "MailMessageP1Sender",

  /**
   * The mail message P2 sender
   */
  MailMessageP2Sender: "MailMessageP2Sender",

  /**
   * The malware category
   */
  MalwareCategory: "MalwareCategory",

  /**
   * The malware name
   */
  MalwareName: "MalwareName",

  /**
   * The process execution command line
   */
  ProcessCommandLine: "ProcessCommandLine",

  /**
   * The process id
   */
  ProcessId: "ProcessId",

  /**
   * The registry key path
   */
  RegistryKey: "RegistryKey",

  /**
   * The registry key value in string formatted representation
   */
  RegistryValueData: "RegistryValueData",

  /**
   * The url
   */
  Url: "Url",
}

/**
 * The scope on which the user should have permissions, in order to be able to create connections.
 */
union ProviderPermissionsScope {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Subscription: "Subscription",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ResourceGroup: "ResourceGroup",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Workspace: "Workspace",
}

/**
 * Describe whether this data type connection is enabled or not.
 */
union DataTypeState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
}

/**
 * Type of paging
 */
union CcpAuthType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Basic: "Basic",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  APIKey: "APIKey",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  OAuth2: "OAuth2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AWS: "AWS",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  GCP: "GCP",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Session: "Session",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  JwtToken: "JwtToken",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  GitHub: "GitHub",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ServiceBus: "ServiceBus",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Oracle: "Oracle",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  None: "None",
}

/**
 * The HTTP method, default value GET.
 */
union HttpMethodVerb {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  GET: "GET",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  POST: "POST",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  PUT: "PUT",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  DELETE: "DELETE",
}

/**
 * Type of paging
 */
union RestApiPollerRequestPagingKind {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  LinkHeader: "LinkHeader",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NextPageToken: "NextPageToken",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NextPageUrl: "NextPageUrl",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  PersistentToken: "PersistentToken",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  PersistentLinkHeader: "PersistentLinkHeader",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Offset: "Offset",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  CountBasedPaging: "CountBasedPaging",
}

/**
 * The anomaly SecurityMLAnalyticsSettings status
 */
union SettingsStatus {
  string,

  /**
   * Anomaly settings status in Production mode
   */
  Production: "Production",

  /**
   * Anomaly settings status in Flighting mode
   */
  Flighting: "Flighting",
}

/**
 * The hash algorithm type.
 */
union FileHashAlgorithm {
  string,

  /**
   * Unknown hash algorithm
   */
  Unknown: "Unknown",

  /**
   * MD5 hash type
   */
  MD5: "MD5",

  /**
   * SHA1 hash type
   */
  SHA1: "SHA1",

  /**
   * SHA256 hash type
   */
  SHA256: "SHA256",

  /**
   * SHA256 Authenticode hash type
   */
  SHA256AC: "SHA256AC",
}

/**
 * The directionality of this mail message
 */
union AntispamMailDirection {
  string,

  /**
   * Unknown
   */
  Unknown: "Unknown",

  /**
   * Inbound
   */
  Inbound: "Inbound",

  /**
   * Outbound
   */
  Outbound: "Outbound",

  /**
   * Intraorg
   */
  Intraorg: "Intraorg",
}

/**
 * the hive that holds the registry key.
 */
union RegistryHive {
  string,

  /**
   * HKEY_LOCAL_MACHINE
   */
  HKEY_LOCAL_MACHINE: "HKEY_LOCAL_MACHINE",

  /**
   * HKEY_CLASSES_ROOT
   */
  HKEY_CLASSES_ROOT: "HKEY_CLASSES_ROOT",

  /**
   * HKEY_CURRENT_CONFIG
   */
  HKEY_CURRENT_CONFIG: "HKEY_CURRENT_CONFIG",

  /**
   * HKEY_USERS
   */
  HKEY_USERS: "HKEY_USERS",

  /**
   * HKEY_CURRENT_USER_LOCAL_SETTINGS
   */
  HKEY_CURRENT_USER_LOCAL_SETTINGS: "HKEY_CURRENT_USER_LOCAL_SETTINGS",

  /**
   * HKEY_PERFORMANCE_DATA
   */
  HKEY_PERFORMANCE_DATA: "HKEY_PERFORMANCE_DATA",

  /**
   * HKEY_PERFORMANCE_NLSTEXT
   */
  HKEY_PERFORMANCE_NLSTEXT: "HKEY_PERFORMANCE_NLSTEXT",

  /**
   * HKEY_PERFORMANCE_TEXT
   */
  HKEY_PERFORMANCE_TEXT: "HKEY_PERFORMANCE_TEXT",

  /**
   * HKEY_A
   */
  HKEY_A: "HKEY_A",

  /**
   * HKEY_CURRENT_USER
   */
  HKEY_CURRENT_USER: "HKEY_CURRENT_USER",
}

/**
 * Specifies the data types to use when storing values in the registry, or identifies the data type of a value in the registry.
 */
union RegistryValueKind {
  string,

  /**
   * None
   */
  None: "None",

  /**
   * Unknown value type
   */
  Unknown: "Unknown",

  /**
   * String value type
   */
  String: "String",

  /**
   * ExpandString value type
   */
  ExpandString: "ExpandString",

  /**
   * Binary value type
   */
  Binary: "Binary",

  /**
   * DWord value type
   */
  DWord: "DWord",

  /**
   * MultiString value type
   */
  MultiString: "MultiString",

  /**
   * QWord value type
   */
  QWord: "QWord",
}

/**
 * The operation against the threshold that triggers alert rule.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum TriggerOperator {
  GreaterThan,
  LessThan,
  Equal,
  NotEqual,
}

/**
 * The operating system type.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum OSFamily {
  /**
   * Host with Linux operating system.
   */
  Linux,

  /**
   * Host with Windows operating system.
   */
  Windows,

  /**
   * Host with Android operating system.
   */
  Android,

  /**
   * Host with IOS operating system.
   */
  IOS,

  /**
   * Host with Unknown operating system.
   */
  Unknown,
}

/**
 * The delivery action of this mail message like Delivered, Blocked, Replaced etc
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum DeliveryAction {
  /**
   * Unknown
   */
  Unknown,

  /**
   * DeliveredAsSpam
   */
  DeliveredAsSpam,

  /**
   * Delivered
   */
  Delivered,

  /**
   * Blocked
   */
  Blocked,

  /**
   * Replaced
   */
  Replaced,
}

/**
 * The delivery location of this mail message like Inbox, JunkFolder etc
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum DeliveryLocation {
  /**
   * Unknown
   */
  Unknown,

  /**
   * Inbox
   */
  Inbox,

  /**
   * JunkFolder
   */
  JunkFolder,

  /**
   * DeletedFolder
   */
  DeletedFolder,

  /**
   * Quarantine
   */
  Quarantine,

  /**
   * External
   */
  External,

  /**
   * Failed
   */
  Failed,

  /**
   * Dropped
   */
  Dropped,

  /**
   * Forwarded
   */
  Forwarded,
}

/**
 * The elevation token associated with the process.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum ElevationToken {
  /**
   * Default elevation token
   */
  Default,

  /**
   * Full elevation token
   */
  Full,

  /**
   * Limited elevation token
   */
  Limited,
}

/**
 * List all the alert rules.
 */
model AlertRulesList is Azure.Core.Page<AlertRule>;

/**
 * An azure resource object with an Etag property
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ResourceWithEtag extends Azure.ResourceManager.CommonTypes.Resource {
  /**
   * Etag of the azure resource
   */
  etag?: string;
}

/**
 * Error response structure.
 */
@error
model CloudError {
  /**
   * Error data
   */
  error?: CloudErrorBody;
}

/**
 * Error details.
 */
model CloudErrorBody {
  /**
   * An identifier for the error. Codes are invariant and are intended to be consumed programmatically.
   */
  @visibility(Lifecycle.Read)
  code?: string;

  /**
   * A message describing the error, intended to be suitable for display in a user interface.
   */
  @visibility(Lifecycle.Read)
  message?: string;
}

/**
 * List all the actions.
 */
model ActionsList is Azure.Core.Page<ActionResponse>;

/**
 * Action property bag.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model ActionResponseProperties extends ActionPropertiesBase {
  /**
   * The name of the logic app's workflow.
   */
  workflowId?: string;
}

/**
 * Action property bag base.
 */
model ActionPropertiesBase {
  /**
   * Logic App Resource Id, /subscriptions/{my-subscription}/resourceGroups/{my-resource-group}/providers/Microsoft.Logic/workflows/{my-workflow-id}.
   */
  logicAppResourceId: string;
}

/**
 * Action for alert rule.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ActionRequest extends ResourceWithEtag {
  /**
   * Action properties for put request
   */
  properties?: ActionRequestProperties;
}

/**
 * Action property bag.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ActionRequestProperties extends ActionPropertiesBase {
  /**
   * Logic App Callback URL for this specific workflow.
   */
  @secret
  triggerUri: string;
}

/**
 * List all the alert rule templates.
 */
model AlertRuleTemplatesList is Azure.Core.Page<AlertRuleTemplate>;

/**
 * Automation rule properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model AutomationRuleProperties {
  /**
   * The display name of the automation rule.
   */
  @maxLength(500)
  displayName: string;

  /**
   * The order of execution of the automation rule.
   */
  @maxValue(1000)
  @minValue(1)
  order: int32;

  /**
   * Describes automation rule triggering logic.
   */
  triggeringLogic: AutomationRuleTriggeringLogic;

  /**
   * The actions to execute when the automation rule is triggered.
   */
  @identifiers(#[])
  @maxItems(20)
  actions: AutomationRuleAction[];

  /**
   * The last time the automation rule was updated.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTimeUtc?: utcDateTime;

  /**
   * The time the automation rule was created.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdTimeUtc?: utcDateTime;

  /**
   * Information on the client (user or application) that made some action
   */
  @visibility(Lifecycle.Read)
  lastModifiedBy?: ClientInfo;

  /**
   * Information on the client (user or application) that made some action
   */
  @visibility(Lifecycle.Read)
  createdBy?: ClientInfo;
}

/**
 * Describes automation rule triggering logic.
 */
model AutomationRuleTriggeringLogic {
  /**
   * Determines whether the automation rule is enabled or disabled.
   */
  isEnabled: boolean;

  /**
   * Determines when the automation rule should automatically expire and be disabled.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expirationTimeUtc?: utcDateTime;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  triggersOn: TriggersOn;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  triggersWhen: TriggersWhen;

  /**
   * The conditions to evaluate to determine if the automation rule should be triggered on a given object.
   */
  @identifiers(#["conditionType"])
  @maxItems(50)
  conditions?: AutomationRuleCondition[];
}

/**
 * Describes an automation rule condition.
 */
@discriminator("conditionType")
model AutomationRuleCondition {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  conditionType: ConditionType;
}

/**
 * Describes an automation rule action.
 */
@discriminator("actionType")
model AutomationRuleAction {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  order: int32;

  /**
   * The type of the automation rule action.
   */
  actionType: ActionType;
}

/**
 * Information on the client (user or application) that made some action
 */
model ClientInfo {
  /**
   * The email of the client.
   */
  email?: string;

  /**
   * The name of the client.
   */
  name?: string;

  /**
   * The object id of the client.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @format("uuid")
  objectId?: string;

  /**
   * The user principal name of the client.
   */
  userPrincipalName?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model AutomationRulesList is Azure.Core.Page<AutomationRule>;

/**
 * Describes the request body for triggering a playbook on an entity.
 */
model EntityManualTriggerRequestBody {
  /**
   * The incident id to associate the entity with.
   */
  incidentArmId?: Azure.Core.armResourceIdentifier<[
    {
      scopes: ["Extension"];
      type: "Microsoft.SecurityInsights/incidents";
    }
  ]>;

  /**
   * The tenant id of the playbook resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @format("uuid")
  tenantId?: string;

  /**
   * The resource id of the playbook resource.
   */
  logicAppsResourceId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Logic/workflows";
    },
    {
      type: "Microsoft.Web/sites";
    }
  ]>;
}

/**
 * Describes the request body for triggering a playbook on an incident.
 */
model ManualTriggerRequestBody {
  /**
   * The tenant id of the playbook resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @format("uuid")
  tenantId?: string;

  /**
   * The resource id of the playbook resource.
   */
  logicAppsResourceId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Logic/workflows";
    },
    {
      type: "Microsoft.Web/sites";
    }
  ]>;
}

/**
 * List all the bookmarks.
 */
model BookmarkList is Azure.Core.Page<Bookmark>;

/**
 * Describes bookmark properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model BookmarkProperties {
  /**
   * The time the bookmark was created
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  created?: utcDateTime;

  /**
   * Describes a user that created the bookmark
   */
  createdBy?: UserInfo;

  /**
   * The display name of the bookmark
   */
  displayName: string;

  /**
   * List of labels relevant to this bookmark
   */
  labels?: string[];

  /**
   * The notes of the bookmark
   */
  notes?: string;

  /**
   * The query of the bookmark.
   */
  query: string;

  /**
   * The query result of the bookmark.
   */
  queryResult?: string;

  /**
   * The last time the bookmark was updated
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  updated?: utcDateTime;

  /**
   * Describes a user that updated the bookmark
   */
  updatedBy?: UserInfo;

  /**
   * The bookmark event time
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  eventTime?: utcDateTime;

  /**
   * The start time for the query
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  queryStartTime?: utcDateTime;

  /**
   * The end time for the query
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  queryEndTime?: utcDateTime;

  /**
   * Describes an incident that relates to bookmark
   */
  incidentInfo?: IncidentInfo;
}

/**
 * User information that made some action
 */
model UserInfo {
  /**
   * The email of the user.
   */
  @visibility(Lifecycle.Read)
  email?: string;

  /**
   * The name of the user.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The object id of the user.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @format("uuid")
  objectId?: string;
}

/**
 * Describes related incident information for the bookmark
 */
model IncidentInfo {
  /**
   * Incident Id
   */
  incidentId?: string;

  /**
   * The severity of the incident
   */
  severity?: IncidentSeverity;

  /**
   * The title of the incident
   */
  title?: string;

  /**
   * Relation Name
   */
  relationName?: string;
}

/**
 * List available packages.
 */
model PackageList is Azure.Core.Page<PackageModel>;

/**
 * Describes package properties
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "For backward compatibility"
model PackageProperties extends PackageBaseProperties {}

/**
 * Describes package properties
 */
model PackageBaseProperties {
  /**
   * The content id of the package
   */
  contentId?: string;

  /**
   * Unique ID for the content. It should be generated based on the contentId, contentKind and the contentVersion of the package
   */
  contentProductId?: string;

  /**
   * The package kind
   */
  contentKind?: PackageKind;

  /**
   * The version of the content schema.
   */
  contentSchemaVersion?: string;

  /**
   * Flag indicates if this is a newly published package.
   */
  isNew?: Flag;

  /**
   * Flag indicates if this package is in preview.
   */
  isPreview?: Flag;

  /**
   * Flag indicates if this package is among the featured list.
   */
  isFeatured?: Flag;

  /**
   * Flag indicates if this template is deprecated
   */
  isDeprecated?: Flag;

  /**
   * the latest version number of the package
   */
  version?: string;

  /**
   * The display name of the package
   */
  displayName?: string;

  /**
   * The description of the package
   */
  description?: string;

  /**
   * The publisher display name of the package
   */
  publisherDisplayName?: string;

  /**
   * The source of the package
   */
  source?: MetadataSource;

  /**
   * The author of the package
   */
  author?: MetadataAuthor;

  /**
   * The support tier of the package
   */
  support?: MetadataSupport;

  /**
   * The support tier of the package
   */
  dependencies?: MetadataDependencies;

  /**
   * Providers for the package item
   */
  providers?: string[];

  /**
   * first publish date package item
   */
  firstPublishDate?: plainDate;

  /**
   * last publish date for the package item
   */
  lastPublishDate?: plainDate;

  /**
   * The categories of the package
   */
  categories?: MetadataCategories;

  /**
   * the tactics the resource covers
   */
  threatAnalysisTactics?: string[];

  /**
   * the techniques the resource covers, these have to be aligned with the tactics being used
   */
  threatAnalysisTechniques?: string[];

  /**
   * the icon identifier. this id can later be fetched from the content metadata
   */
  icon?: string;
}

/**
 * The original source of the content item, where it comes from.
 */
model MetadataSource {
  /**
   * Source type of the content
   */
  kind: SourceKind;

  /**
   * Name of the content source.  The repo name, solution name, LA workspace name etc.
   */
  name?: string;

  /**
   * ID of the content source.  The solution ID, workspace ID, etc
   */
  sourceId?: string;
}

/**
 * Publisher or creator of the content item.
 */
model MetadataAuthor {
  /**
   * Name of the author. Company or person.
   */
  name?: string;

  /**
   * Email of author contact
   */
  email?: string;

  /**
   * Link for author/vendor page
   */
  link?: string;
}

/**
 * Support information for the content item.
 */
model MetadataSupport {
  /**
   * Type of support for content item
   */
  tier: SupportTier;

  /**
   * Name of the support contact. Company or person.
   */
  name?: string;

  /**
   * Email of support contact
   */
  email?: string;

  /**
   * Link for support help, like to support page to open a ticket etc.
   */
  link?: string;
}

/**
 * Dependencies for the content item, what other content items it requires to work.  Can describe more complex dependencies using a recursive/nested structure. For a single dependency an id/kind/version can be supplied or operator/criteria for complex dependencies.
 */
model MetadataDependencies {
  /**
   * Id of the content item we depend on
   */
  contentId?: string;

  /**
   * Type of the content item we depend on
   */
  kind?: Kind;

  /**
   * Version of the the content item we depend on.  Can be blank, * or missing to indicate any version fulfills the dependency.  If version does not match our defined numeric format then an exact match is required.
   */
  version?: string;

  /**
   * Name of the content item
   */
  name?: string;

  /**
   * Operator used for list of dependencies in criteria array.
   */
  operator?: Operator;

  /**
   * This is the list of dependencies we must fulfill, according to the AND/OR operator
   */
  @identifiers(#["contentId"])
  criteria?: MetadataDependencies[];
}

/**
 * ies for the solution content item
 */
model MetadataCategories {
  /**
   * domain for the solution content item
   */
  domains?: string[];

  /**
   * Industry verticals for the solution content item
   */
  verticals?: string[];
}

/**
 * List available packages.
 */
model ProductPackageList is Azure.Core.Page<ProductPackageModel>;

/**
 * Describes package properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model ProductPackageProperties {
  ...PackageBaseProperties;
  ...ProductPackageAdditionalProperties;
}

/**
 * product package additional properties
 */
model ProductPackageAdditionalProperties {
  /**
   * The version of the installed package, null or absent means not installed.
   */
  installedVersion?: string;

  /**
   * The metadata resource id.
   */
  metadataResourceId?: Azure.Core.armResourceIdentifier;

  /**
   * The json of the ARM template to deploy. Expandable.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "For backward compatibility"
  packagedContent?: unknown;
}

/**
 * List of all the template.
 */
model ProductTemplateList is Azure.Core.Page<ProductTemplateModel>;

/**
 * Template property bag.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model ProductTemplateProperties {
  ...TemplateBaseProperties;
  ...ProductTemplateAdditionalProperties;
}

/**
 * Template property bag.
 */
model TemplateBaseProperties {
  /**
   * Static ID for the content.  Used to identify dependencies and content from solutions or community.  Hard-coded/static for out of the box content and solutions. Dynamic for user-created.  This is the resource name
   */
  contentId?: string;

  /**
   * Unique ID for the content. It should be generated based on the contentId of the package, contentId of the template, contentKind of the template and the contentVersion of the template
   */
  contentProductId?: string;

  /**
   * Version of the package.  Default and recommended format is numeric (e.g. 1, 1.0, 1.0.0, 1.0.0.0), following ARM metadata best practices.  Can also be any string, but then we cannot guarantee any version checks
   */
  packageVersion?: string;

  /**
   * Version of the content.  Default and recommended format is numeric (e.g. 1, 1.0, 1.0.0, 1.0.0.0), following ARM metadata best practices.  Can also be any string, but then we cannot guarantee any version checks
   */
  version?: string;

  /**
   * The display name of the template
   */
  displayName?: string;

  /**
   * The kind of content the template is for.
   */
  contentKind?: Kind;

  /**
   * Source of the content.  This is where/how it was created.
   */
  source?: MetadataSource;

  /**
   * The creator of the content item.
   */
  author?: MetadataAuthor;

  /**
   * Support information for the template - type, name, contact information
   */
  support?: MetadataSupport;

  /**
   * Dependencies for the content item, what other content items it requires to work.  Can describe more complex dependencies using a recursive/nested structure. For a single dependency an id/kind/version can be supplied or operator/criteria for complex formats.
   */
  dependencies?: MetadataDependencies;

  /**
   * Categories for the item
   */
  categories?: MetadataCategories;

  /**
   * Providers for the content item
   */
  providers?: string[];

  /**
   * first publish date content item
   */
  firstPublishDate?: plainDate;

  /**
   * last publish date for the content item
   */
  lastPublishDate?: plainDate;

  /**
   * The custom version of the content. A optional free text
   */
  customVersion?: string;

  /**
   * Schema version of the content. Can be used to distinguish between different flow based on the schema version
   */
  contentSchemaVersion?: string;

  /**
   * the icon identifier. this id can later be fetched from the content metadata
   */
  icon?: string;

  /**
   * the tactics the resource covers
   */
  threatAnalysisTactics?: string[];

  /**
   * the techniques the resource covers, these have to be aligned with the tactics being used
   */
  threatAnalysisTechniques?: string[];

  /**
   * preview image file names. These will be taken from the solution artifacts
   */
  previewImages?: string[];

  /**
   * preview image file names. These will be taken from the solution artifacts. used for dark theme support
   */
  previewImagesDark?: string[];

  /**
   * the package Id contains this template
   */
  packageId?: string;

  /**
   * the packageKind of the package contains this template
   */
  packageKind?: PackageKind;

  /**
   * the name of the package contains this template
   */
  packageName?: string;

  /**
   * Flag indicates if this template is deprecated
   */
  @visibility(Lifecycle.Read)
  isDeprecated?: Flag;
}

/**
 * additional properties of product template.
 */
model ProductTemplateAdditionalProperties {
  /**
   * The json of the ARM template to deploy
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "For backward compatibility"
  packagedContent?: unknown;
}

/**
 * List of all the template.
 */
model TemplateList is Azure.Core.Page<TemplateModel>;

/**
 * Template property bag.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model TemplateProperties {
  ...TemplateBaseProperties;
  ...TemplateAdditionalProperties;
}

/**
 * additional properties of product template.
 */
model TemplateAdditionalProperties {
  /**
   * The JSON of the ARM template to deploy active content. Expandable.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "For backward compatibility"
  mainTemplate?: unknown;

  /**
   * Dependant templates. Expandable.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["contentId"])
  dependantTemplates?: TemplateProperties[];
}

/**
 * Encapsulate the data connector definition object
 */
model DataConnectorDefinitionArmCollectionWrapper
  is Azure.Core.Page<DataConnectorDefinition>;

/**
 * List all the data connectors.
 */
model DataConnectorList is Azure.Core.Page<DataConnector>;

/**
 * List all the incidents.
 */
model IncidentList is Azure.Core.Page<Incident>;

/**
 * Describes incident properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model IncidentProperties {
  /**
   * Additional data on the incident
   */
  @visibility(Lifecycle.Read)
  additionalData?: IncidentAdditionalData;

  /**
   * The reason the incident was closed
   */
  classification?: IncidentClassification;

  /**
   * Describes the reason the incident was closed
   */
  classificationComment?: string;

  /**
   * The classification reason the incident was closed with
   */
  classificationReason?: IncidentClassificationReason;

  /**
   * The time the incident was created
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdTimeUtc?: utcDateTime;

  /**
   * The description of the incident
   */
  description?: string;

  /**
   * The time of the first activity in the incident
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  firstActivityTimeUtc?: utcDateTime;

  /**
   * The deep-link url to the incident in Azure portal
   */
  @visibility(Lifecycle.Read)
  incidentUrl?: string;

  /**
   * The name of the source provider that generated the incident
   */
  @visibility(Lifecycle.Read)
  providerName?: string;

  /**
   * The incident ID assigned by the incident provider
   */
  @visibility(Lifecycle.Read)
  providerIncidentId?: string;

  /**
   * A sequential number
   */
  @visibility(Lifecycle.Read)
  incidentNumber?: int32;

  /**
   * List of labels relevant to this incident
   */
  @identifiers(#[])
  labels?: IncidentLabel[];

  /**
   * The time of the last activity in the incident
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastActivityTimeUtc?: utcDateTime;

  /**
   * The last time the incident was updated
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTimeUtc?: utcDateTime;

  /**
   * Describes a user that the incident is assigned to
   */
  owner?: IncidentOwnerInfo;

  /**
   * List of resource ids of Analytic rules related to the incident
   */
  @visibility(Lifecycle.Read)
  relatedAnalyticRuleIds?: Azure.Core.armResourceIdentifier<[
    {
      scopes: ["Extension"];
      type: "Microsoft.SecurityInsights/alertRules";
    }
  ]>[];

  /**
   * The severity of the incident
   */
  severity: IncidentSeverity;

  /**
   * The status of the incident
   */
  status: IncidentStatus;

  /**
   * The title of the incident
   */
  title: string;
}

/**
 * Incident additional data property bag.
 */
model IncidentAdditionalData {
  /**
   * The number of alerts in the incident
   */
  @visibility(Lifecycle.Read)
  alertsCount?: int32;

  /**
   * The number of bookmarks in the incident
   */
  @visibility(Lifecycle.Read)
  bookmarksCount?: int32;

  /**
   * The number of comments in the incident
   */
  @visibility(Lifecycle.Read)
  commentsCount?: int32;

  /**
   * List of product names of alerts in the incident
   */
  @visibility(Lifecycle.Read)
  alertProductNames?: string[];

  /**
   * The tactics associated with incident
   */
  @visibility(Lifecycle.Read)
  tactics?: AttackTactic[];

  /**
   * The provider incident url to the incident in Microsoft 365 Defender portal
   */
  @visibility(Lifecycle.Read)
  providerIncidentUrl?: string;
}

/**
 * Represents an incident label
 */
model IncidentLabel {
  /**
   * The name of the label
   */
  labelName: string;

  /**
   * The type of the label
   */
  @visibility(Lifecycle.Read)
  labelType?: IncidentLabelType;
}

/**
 * Information on the user an incident is assigned to
 */
model IncidentOwnerInfo {
  /**
   * The email of the user the incident is assigned to.
   */
  email?: string;

  /**
   * The name of the user the incident is assigned to.
   */
  assignedTo?: string;

  /**
   * The object id of the user the incident is assigned to.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @format("uuid")
  objectId?: string;

  /**
   * The user principal name of the user the incident is assigned to.
   */
  userPrincipalName?: string;

  /**
   * The type of the owner the incident is assigned to.
   */
  ownerType?: OwnerType;
}

/**
 * List of incident alerts.
 */
model IncidentAlertList {
  /**
   * Array of incident alerts.
   */
  @pageItems
  @identifiers(#[])
  value: SecurityAlert[];
}

/**
 * Represents a security alert entity.
 */
model SecurityAlert extends Entity {
  /**
   * SecurityAlert entity properties
   */
  properties?: SecurityAlertProperties;

  /**
   * The kind of the entity.
   */
  kind: "SecurityAlert";
}

/**
 * SecurityAlert entity property bag.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model SecurityAlertProperties extends EntityCommonProperties {
  /**
   * The display name of the alert.
   */
  @visibility(Lifecycle.Read)
  alertDisplayName?: string;

  /**
   * The type name of the alert.
   */
  @visibility(Lifecycle.Read)
  alertType?: string;

  /**
   * Display name of the main entity being reported on.
   */
  @visibility(Lifecycle.Read)
  compromisedEntity?: string;

  /**
   * The confidence level of this alert.
   */
  @visibility(Lifecycle.Read)
  confidenceLevel?: ConfidenceLevel;

  /**
   * The confidence reasons
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  confidenceReasons?: SecurityAlertPropertiesConfidenceReasonsItem[];

  /**
   * The confidence score of the alert.
   */
  @visibility(Lifecycle.Read)
  confidenceScore?: float64;

  /**
   * The confidence score calculation status, i.e. indicating if score calculation is pending for this alert, not applicable or final.
   */
  @visibility(Lifecycle.Read)
  confidenceScoreStatus?: ConfidenceScoreStatus;

  /**
   * Alert description.
   */
  @visibility(Lifecycle.Read)
  description?: string;

  /**
   * The impact end time of the alert (the time of the last event contributing to the alert).
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTimeUtc?: utcDateTime;

  /**
   * Holds the alert intent stage(s) mapping for this alert.
   */
  @visibility(Lifecycle.Read)
  intent?: KillChainIntent;

  /**
   * The identifier of the alert inside the product which generated the alert.
   */
  @visibility(Lifecycle.Read)
  providerAlertId?: string;

  /**
   * The time the alert was made available for consumption.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  processingEndTime?: utcDateTime;

  /**
   * The name of a component inside the product which generated the alert.
   */
  @visibility(Lifecycle.Read)
  productComponentName?: string;

  /**
   * The name of the product which published this alert.
   */
  @visibility(Lifecycle.Read)
  productName?: string;

  /**
   * The version of the product generating the alert.
   */
  @visibility(Lifecycle.Read)
  productVersion?: string;

  /**
   * Manual action items to take to remediate the alert.
   */
  @visibility(Lifecycle.Read)
  remediationSteps?: string[];

  /**
   * The severity of the alert
   */
  severity?: AlertSeverity;

  /**
   * The impact start time of the alert (the time of the first event contributing to the alert).
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTimeUtc?: utcDateTime;

  /**
   * The lifecycle status of the alert.
   */
  @visibility(Lifecycle.Read)
  status?: AlertStatus;

  /**
   * Holds the product identifier of the alert for the product.
   */
  @visibility(Lifecycle.Read)
  systemAlertId?: string;

  /**
   * The tactics of the alert
   */
  @visibility(Lifecycle.Read)
  tactics?: AttackTactic[];

  /**
   * The time the alert was generated.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timeGenerated?: utcDateTime;

  /**
   * The name of the vendor that raise the alert.
   */
  @visibility(Lifecycle.Read)
  vendorName?: string;

  /**
   * The uri link of the alert.
   */
  @visibility(Lifecycle.Read)
  alertLink?: string;

  /**
   * The list of resource identifiers of the alert.
   */
  @visibility(Lifecycle.Read)
  resourceIdentifiers?: unknown[];
}

/**
 * confidence reason item
 */
model SecurityAlertPropertiesConfidenceReasonsItem {
  /**
   * The reason's description
   */
  @visibility(Lifecycle.Read)
  reason?: string;

  /**
   * The type (category) of the reason
   */
  @visibility(Lifecycle.Read)
  reasonType?: string;
}

/**
 * Entity common property bag.
 */
model EntityCommonProperties {
  /**
   * A bag of custom fields that should be part of the entity and will be presented to the user.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  @visibility(Lifecycle.Read)
  additionalData?: Record<unknown>;

  /**
   * The graph item display name which is a short humanly readable description of the graph item instance. This property is optional and might be system generated.
   */
  @visibility(Lifecycle.Read)
  friendlyName?: string;
}

/**
 * Specific entity.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
@discriminator("kind")
model Entity extends Azure.ResourceManager.CommonTypes.Resource {
  /**
   * The kind of the entity.
   */
  kind: EntityKindEnum;
}

/**
 * List of incident bookmarks.
 */
model IncidentBookmarkList {
  /**
   * Array of incident bookmarks.
   */
  @pageItems
  @identifiers(#[])
  value: HuntingBookmark[];
}

/**
 * Represents a Hunting bookmark entity.
 */
model HuntingBookmark extends Entity {
  /**
   * HuntingBookmark entity properties
   */
  properties?: HuntingBookmarkProperties;

  /**
   * The kind of the entity.
   */
  kind: "Bookmark";
}

/**
 * Describes bookmark properties
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model HuntingBookmarkProperties extends EntityCommonProperties {
  /**
   * The time the bookmark was created
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  created?: utcDateTime;

  /**
   * Describes a user that created the bookmark
   */
  createdBy?: UserInfo;

  /**
   * The display name of the bookmark
   */
  displayName: string;

  /**
   * The time of the event
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  eventTime?: utcDateTime;

  /**
   * List of labels relevant to this bookmark
   */
  labels?: string[];

  /**
   * The notes of the bookmark
   */
  notes?: string;

  /**
   * The query of the bookmark.
   */
  query: string;

  /**
   * The query result of the bookmark.
   */
  queryResult?: string;

  /**
   * The last time the bookmark was updated
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  updated?: utcDateTime;

  /**
   * Describes a user that updated the bookmark
   */
  updatedBy?: UserInfo;

  /**
   * Describes an incident that relates to bookmark
   */
  incidentInfo?: IncidentInfo;
}

/**
 * List of incident comments.
 */
model IncidentCommentList is Azure.Core.Page<IncidentComment>;

/**
 * Incident comment property bag.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model IncidentCommentProperties {
  /**
   * The time the comment was created
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdTimeUtc?: utcDateTime;

  /**
   * The time the comment was updated
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTimeUtc?: utcDateTime;

  /**
   * The comment message
   */
  message: string;

  /**
   * Describes the client that created the comment
   */
  @visibility(Lifecycle.Read)
  author?: ClientInfo;
}

/**
 * The incident related entities response.
 */
model IncidentEntitiesResponse {
  /**
   * Array of the incident related entities.
   */
  @identifiers(#[])
  entities?: Entity[];

  /**
   * The metadata from the incident related entities results.
   */
  @identifiers(#[])
  metaData?: IncidentEntitiesResultsMetadata[];
}

/**
 * Information of a specific aggregation in the incident related entities result.
 */
model IncidentEntitiesResultsMetadata {
  /**
   * Total number of aggregations of the given kind in the incident related entities result.
   */
  count: int32;

  /**
   * The kind of the aggregated entity.
   */
  entityKind: EntityKindEnum;
}

/**
 * List of relations.
 */
model RelationList is Azure.Core.Page<Relation>;

/**
 * Relation property bag.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model RelationProperties {
  /**
   * The resource ID of the related resource
   */
  relatedResourceId: string;

  /**
   * The name of the related resource
   */
  @visibility(Lifecycle.Read)
  relatedResourceName?: string;

  /**
   * The resource type of the related resource
   */
  @visibility(Lifecycle.Read)
  relatedResourceType?: string;

  /**
   * The resource kind of the related resource
   */
  @visibility(Lifecycle.Read)
  relatedResourceKind?: string;
}

/**
 * List of incident tasks
 */
model IncidentTaskList is Azure.Core.Page<IncidentTask>;

/**
 * Describes the properties of an incident task
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model IncidentTaskProperties {
  /**
   * The title of the task
   */
  title: string;

  /**
   * The description of the task
   */
  description?: string;

  /**
   * The status of the task
   */
  status: IncidentTaskStatus;

  /**
   * The time the task was created
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdTimeUtc?: utcDateTime;

  /**
   * The last time the task was updated
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTimeUtc?: utcDateTime;

  /**
   * Information on the client (user or application) that made some action
   */
  createdBy?: ClientInfo;

  /**
   * Information on the client (user or application) that made some action
   */
  lastModifiedBy?: ClientInfo;
}

/**
 * List of all the metadata.
 */
model MetadataList is Azure.Core.Page<MetadataModel>;

/**
 * Metadata property bag.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model MetadataProperties {
  /**
   * Static ID for the content.  Used to identify dependencies and content from solutions or community.  Hard-coded/static for out of the box content and solutions. Dynamic for user-created.  This is the resource name
   */
  contentId?: string;

  /**
   * Full parent resource ID of the content item the metadata is for.  This is the full resource ID including the scope (subscription and resource group)
   */
  parentId: string;

  /**
   * Version of the content.  Default and recommended format is numeric (e.g. 1, 1.0, 1.0.0, 1.0.0.0), following ARM template best practices.  Can also be any string, but then we cannot guarantee any version checks
   */
  version?: string;

  /**
   * The kind of content the metadata is for.
   */
  kind: string;

  /**
   * Source of the content.  This is where/how it was created.
   */
  source?: MetadataSource;

  /**
   * The creator of the content item.
   */
  author?: MetadataAuthor;

  /**
   * Support information for the metadata - type, name, contact information
   */
  support?: MetadataSupport;

  /**
   * Dependencies for the content item, what other content items it requires to work.  Can describe more complex dependencies using a recursive/nested structure. For a single dependency an id/kind/version can be supplied or operator/criteria for complex formats.
   */
  dependencies?: MetadataDependencies;

  /**
   * Categories for the solution content item
   */
  categories?: MetadataCategories;

  /**
   * Providers for the solution content item
   */
  providers?: string[];

  /**
   * first publish date solution content item
   */
  firstPublishDate?: plainDate;

  /**
   * last publish date for the solution content item
   */
  lastPublishDate?: plainDate;

  /**
   * The custom version of the content. A optional free text
   */
  customVersion?: string;

  /**
   * Schema version of the content. Can be used to distinguish between different flow based on the schema version
   */
  contentSchemaVersion?: string;

  /**
   * the icon identifier. this id can later be fetched from the solution template
   */
  icon?: string;

  /**
   * the tactics the resource covers
   */
  threatAnalysisTactics?: string[];

  /**
   * the techniques the resource covers, these have to be aligned with the tactics being used
   */
  threatAnalysisTechniques?: string[];

  /**
   * preview image file names. These will be taken from the solution artifacts
   */
  previewImages?: string[];

  /**
   * preview image file names. These will be taken from the solution artifacts. used for dark theme support
   */
  previewImagesDark?: string[];
}

/**
 * Metadata patch request body.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model MetadataPatch extends ResourceWithEtag {
  /**
   * Metadata patch request body
   */
  properties?: MetadataPropertiesPatch;
}

/**
 * Metadata property bag for patch requests.  This is the same as the MetadataProperties, but with nothing required
 */
model MetadataPropertiesPatch {
  /**
   * Static ID for the content.  Used to identify dependencies and content from solutions or community.  Hard-coded/static for out of the box content and solutions. Dynamic for user-created.  This is the resource name
   */
  contentId?: string;

  /**
   * Full parent resource ID of the content item the metadata is for.  This is the full resource ID including the scope (subscription and resource group)
   */
  parentId?: string;

  /**
   * Version of the content.  Default and recommended format is numeric (e.g. 1, 1.0, 1.0.0, 1.0.0.0), following ARM template best practices.  Can also be any string, but then we cannot guarantee any version checks
   */
  version?: string;

  /**
   * The kind of content the metadata is for.
   */
  kind?: string;

  /**
   * Source of the content.  This is where/how it was created.
   */
  source?: MetadataSource;

  /**
   * The creator of the content item.
   */
  author?: MetadataAuthor;

  /**
   * Support information for the metadata - type, name, contact information
   */
  support?: MetadataSupport;

  /**
   * Dependencies for the content item, what other content items it requires to work.  Can describe more complex dependencies using a recursive/nested structure. For a single dependency an id/kind/version can be supplied or operator/criteria for complex formats.
   */
  dependencies?: MetadataDependencies;

  /**
   * Categories for the solution content item
   */
  categories?: MetadataCategories;

  /**
   * Providers for the solution content item
   */
  providers?: string[];

  /**
   * first publish date solution content item
   */
  firstPublishDate?: plainDate;

  /**
   * last publish date for the solution content item
   */
  lastPublishDate?: plainDate;

  /**
   * The custom version of the content. A optional free text
   */
  customVersion?: string;

  /**
   * Schema version of the content. Can be used to distinguish between different flow based on the schema version
   */
  contentSchemaVersion?: string;

  /**
   * the icon identifier. this id can later be fetched from the solution template
   */
  icon?: string;

  /**
   * the tactics the resource covers
   */
  threatAnalysisTactics?: string[];

  /**
   * the techniques the resource covers, these have to be aligned with the tactics being used
   */
  threatAnalysisTechniques?: string[];

  /**
   * preview image file names. These will be taken from the solution artifacts
   */
  previewImages?: string[];

  /**
   * preview image file names. These will be taken from the solution artifacts. used for dark theme support
   */
  previewImagesDark?: string[];
}

/**
 * The Sentinel onboarding state properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model SentinelOnboardingStateProperties {
  /**
   * Flag that indicates the status of the CMK setting
   */
  customerManagedKey?: boolean;
}

/**
 * List of the Sentinel onboarding states
 */
model SentinelOnboardingStatesList {
  /**
   * Array of Sentinel onboarding states
   */
  @pageItems
  value: SentinelOnboardingState[];
}

/**
 * Operation provided by provider
 */
model Operation {
  /**
   * Properties of the operation
   */
  display?: OperationDisplay;

  /**
   * Name of the operation
   */
  name?: string;

  /**
   * The origin of the operation
   */
  origin?: string;

  /**
   * Indicates whether the operation is a data action
   */
  isDataAction?: boolean;
}

/**
 * Properties of the operation
 */
model OperationDisplay {
  /**
   * Description of the operation
   */
  description?: string;

  /**
   * Operation name
   */
  operation?: string;

  /**
   * Provider name
   */
  provider?: string;

  /**
   * Resource name
   */
  resource?: string;
}

/**
 * List all the SecurityMLAnalyticsSettings
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
model SecurityMLAnalyticsSettingsList
  is Azure.Core.Page<SecurityMLAnalyticsSetting>;

/**
 * Credentials to access repository.
 */
model RepositoryAccessProperties {
  /**
   * RepositoryAccess properties
   */
  properties: RepositoryAccessObject;
}

/**
 * Credentials to access repository.
 */
model RepositoryAccessObject {
  /**
   * RepositoryAccess properties
   */
  repositoryAccess: RepositoryAccess;
}

/**
 * Credentials to access repository.
 */
model RepositoryAccess {
  /**
   * The kind of repository access credentials
   */
  kind: RepositoryAccessKind;

  /**
   * OAuth Code. Required when `kind` is `OAuth`
   */
  @secret
  code?: string;

  /**
   * OAuth State. Required when `kind` is `OAuth`
   */
  @secret
  state?: string;

  /**
   * OAuth ClientId. Required when `kind` is `OAuth`
   */
  clientId?: string;

  /**
   * Personal Access Token. Required when `kind` is `PAT`
   */
  @secret
  token?: string;

  /**
   * Application installation ID. Required when `kind` is `App`. Supported by `GitHub` only.
   */
  installationId?: string;
}

/**
 * List all the source controls.
 */
model RepoList is Azure.Core.Page<Repo>;

/**
 * Represents a repository.
 */
model Repo {
  /**
   * The url to access the repository.
   */
  url?: string;

  /**
   * The name of the repository.
   */
  fullName?: string;

  /**
   * The installation id of the repository.
   */
  installationId?: int64;

  /**
   * Array of branches.
   */
  branches?: string[];
}

/**
 * List all the source controls.
 */
model SourceControlList is Azure.Core.Page<SourceControl>;

/**
 * Describes source control properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model SourceControlProperties {
  /**
   * The id (a Guid) of the source control
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "For backward compatibility"
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The version number associated with the source control
   */
  @visibility(Lifecycle.Read)
  version?: Version;

  /**
   * The display name of the source control
   */
  displayName: string;

  /**
   * A description of the source control
   */
  description?: string;

  /**
   * The repository type of the source control
   */
  repoType: RepoType;

  /**
   * Array of source control content types.
   */
  contentTypes: ContentType[];

  /**
   * Repository metadata.
   */
  repository: Repository;

  /**
   * Service principal metadata.
   */
  servicePrincipal?: ServicePrincipal;

  /**
   * Workload Identity metadata.
   */
  @visibility(Lifecycle.Read)
  workloadIdentityFederation?: WorkloadIdentityFederation;

  /**
   * Repository access credentials. This is write-only object and it never returns back to a user.
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  repositoryAccess?: RepositoryAccess;

  /**
   * Information regarding the resources created in user's repository.
   */
  repositoryResourceInfo?: RepositoryResourceInfo;

  /**
   * Information regarding the latest deployment for the source control.
   */
  @visibility(Lifecycle.Read)
  lastDeploymentInfo?: DeploymentInfo;

  /**
   * Information regarding the pull request of the source control.
   */
  @visibility(Lifecycle.Read)
  pullRequest?: PullRequest;
}

/**
 * metadata of a repository.
 */
model Repository {
  /**
   * Url of repository.
   */
  url: string;

  /**
   * Branch name of repository.
   */
  branch: string;

  /**
   * Display url of repository.
   */
  displayUrl?: string;

  /**
   * Url to access repository action logs.
   */
  @visibility(Lifecycle.Read)
  deploymentLogsUrl?: string;
}

/**
 * Service principal metadata.
 */
model ServicePrincipal {
  /**
   * Id of service principal.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Tenant id of service principal.
   */
  @visibility(Lifecycle.Read)
  tenantId?: string;

  /**
   * App id of service principal.
   */
  @visibility(Lifecycle.Read)
  appId?: string;

  /**
   * Expiration time of service principal credentials.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  credentialsExpireOn?: utcDateTime;
}

/**
 * Workload Identity Federation metadata.
 */
model WorkloadIdentityFederation {
  /**
   * Id of Workload Identity Federation.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Tenant id of Workload Identity Federation.
   */
  @visibility(Lifecycle.Read)
  tenantId?: string;

  /**
   * App id of Workload Identity Federation.
   */
  @visibility(Lifecycle.Read)
  appId?: string;

  /**
   * Subject of Workload Identity Federation.
   */
  @visibility(Lifecycle.Read)
  subject?: string;

  /**
   * Issuer of Workload Identity Federation.
   */
  @visibility(Lifecycle.Read)
  issuer?: string;
}

/**
 * Resources created in user's repository for the source-control.
 */
model RepositoryResourceInfo {
  /**
   * The webhook object created for the source-control.
   */
  webhook?: Webhook;

  /**
   * Resources created in GitHub for this source-control.
   */
  @visibility(Lifecycle.Read)
  gitHubResourceInfo?: GitHubResourceInfo;

  /**
   * Resources created in Azure DevOps for this source-control.
   */
  @visibility(Lifecycle.Read)
  azureDevOpsResourceInfo?: AzureDevOpsResourceInfo;
}

/**
 * Detail about the webhook object.
 */
model Webhook {
  /**
   * Unique identifier for the webhook.
   */
  @visibility(Lifecycle.Read)
  webhookId?: string;

  /**
   * URL that gets invoked by the webhook.
   */
  @visibility(Lifecycle.Read)
  webhookUrl?: string;

  /**
   * Time when the webhook secret was updated.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  webhookSecretUpdateTime?: utcDateTime;

  /**
   * A flag to instruct the backend service to rotate webhook secret.
   */
  rotateWebhookSecret?: boolean;
}

/**
 * Resources created in GitHub repository.
 */
model GitHubResourceInfo {
  /**
   * GitHub application installation id.
   */
  appInstallationId?: string;
}

/**
 * Resources created in Azure DevOps repository.
 */
model AzureDevOpsResourceInfo {
  /**
   * Id of the pipeline created for the source-control.
   */
  pipelineId?: string;

  /**
   * Id of the service-connection created for the source-control.
   */
  serviceConnectionId?: string;
}

/**
 * Information regarding a deployment.
 */
model DeploymentInfo {
  /**
   * Status while fetching the last deployment.
   */
  deploymentFetchStatus?: DeploymentFetchStatus;

  /**
   * Deployment information.
   */
  deployment?: Deployment;

  /**
   * Additional details about the deployment that can be shown to the user.
   */
  message?: string;
}

/**
 * Description about a deployment.
 */
model Deployment {
  /**
   * Deployment identifier.
   */
  deploymentId?: string;

  /**
   * Current status of the deployment.
   */
  deploymentState?: DeploymentState;

  /**
   * The outcome of the deployment.
   */
  deploymentResult?: DeploymentResult;

  /**
   * The time when the deployment finished.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  deploymentTime?: utcDateTime;

  /**
   * Url to access repository action logs.
   */
  deploymentLogsUrl?: string;
}

/**
 * Information regarding pull request for protected branches.
 */
model PullRequest {
  /**
   * URL of pull request
   */
  @visibility(Lifecycle.Read)
  url?: string;

  /**
   * State of the pull request
   */
  @visibility(Lifecycle.Read)
  state?: State;
}

/**
 * Warning response structure.
 */
model Warning {
  /**
   * Warning data.
   */
  #suppress "@azure-tools/typespec-client-generator-core/property-name-conflict" "For backward compatibility"
  @visibility(Lifecycle.Read)
  warning?: WarningBody;
}

/**
 * Warning details.
 */
model WarningBody {
  /**
   * An identifier for the warning. Codes are invariant and are intended to be consumed programmatically.
   */
  @visibility(Lifecycle.Read)
  code?: WarningCode;

  /**
   * A message describing the warning, intended to be suitable for display in a user interface.
   */
  @visibility(Lifecycle.Read)
  message?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  details?: WarningBody[];
}

/**
 * Threat intelligence indicator entity.
 */
@parentResource(ThreatIntelligenceMain)
model ThreatIntelligenceIndicatorModel extends ThreatIntelligenceInformation {
  /**
   * Threat Intelligence Entity properties
   */
  properties?: ThreatIntelligenceIndicatorProperties;

  kind: ThreatIntelligenceResourceInnerKind.indicator;
}

/**
 * Describes threat intelligence entity properties
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ThreatIntelligenceIndicatorProperties extends EntityCommonProperties {
  /**
   * List of tags
   */
  threatIntelligenceTags?: string[];

  /**
   * Last updated time in UTC
   */
  lastUpdatedTimeUtc?: string;

  /**
   * Source of a threat intelligence entity
   */
  source?: string;

  /**
   * Display name of a threat intelligence entity
   */
  displayName?: string;

  /**
   * Description of a threat intelligence entity
   */
  description?: string;

  /**
   * Indicator types of threat intelligence entities
   */
  indicatorTypes?: string[];

  /**
   * Pattern of a threat intelligence entity
   */
  pattern?: string;

  /**
   * Pattern type of a threat intelligence entity
   */
  patternType?: string;

  /**
   * Pattern version of a threat intelligence entity
   */
  patternVersion?: string;

  /**
   * Kill chain phases
   */
  @identifiers(#[])
  killChainPhases?: ThreatIntelligenceKillChainPhase[];

  /**
   * Parsed patterns
   */
  @identifiers(#[])
  parsedPattern?: ThreatIntelligenceParsedPattern[];

  /**
   * External ID of threat intelligence entity
   */
  externalId?: string;

  /**
   * Created by reference of threat intelligence entity
   */
  createdByRef?: string;

  /**
   * Is threat intelligence entity defanged
   */
  defanged?: boolean;

  /**
   * External last updated time in UTC
   */
  externalLastUpdatedTimeUtc?: string;

  /**
   * External References
   */
  @identifiers(#[])
  externalReferences?: ThreatIntelligenceExternalReference[];

  /**
   * Granular Markings
   */
  @identifiers(#[])
  granularMarkings?: ThreatIntelligenceGranularMarkingModel[];

  /**
   * Labels  of threat intelligence entity
   */
  labels?: string[];

  /**
   * Is threat intelligence entity revoked
   */
  revoked?: boolean;

  /**
   * Confidence of threat intelligence entity
   */
  confidence?: int32;

  /**
   * Threat intelligence entity object marking references
   */
  objectMarkingRefs?: string[];

  /**
   * Language of threat intelligence entity
   */
  language?: string;

  /**
   * Threat types
   */
  threatTypes?: string[];

  /**
   * Valid from
   */
  validFrom?: string;

  /**
   * Valid until
   */
  validUntil?: string;

  /**
   * Created by
   */
  created?: string;

  /**
   * Modified by
   */
  modified?: string;

  /**
   * Extensions map
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  extensions?: Record<unknown>;
}

/**
 * Describes threat kill chain phase entity
 */
model ThreatIntelligenceKillChainPhase {
  /**
   * Kill chainName name
   */
  killChainName?: string;

  /**
   * Phase name
   */
  phaseName?: string;
}

/**
 * Describes parsed pattern entity
 */
model ThreatIntelligenceParsedPattern {
  /**
   * Pattern type key
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "For backward compatibility"
  patternTypeKey?: string;

  /**
   * Pattern type keys
   */
  @identifiers(#[])
  patternTypeValues?: ThreatIntelligenceParsedPatternTypeValue[];
}

/**
 * Describes threat kill chain phase entity
 */
model ThreatIntelligenceParsedPatternTypeValue {
  /**
   * Type of the value
   */
  valueType?: string;

  /**
   * Value of parsed pattern
   */
  value?: string;
}

/**
 * Describes external reference
 */
model ThreatIntelligenceExternalReference {
  /**
   * External reference description
   */
  description?: string;

  /**
   * External reference ID
   */
  externalId?: string;

  /**
   * External reference source name
   */
  sourceName?: string;

  /**
   * External reference URL
   */
  url?: string;

  /**
   * External reference hashes
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  hashes?: Record<string>;
}

/**
 * Describes threat granular marking model entity
 */
model ThreatIntelligenceGranularMarkingModel {
  /**
   * Language granular marking model
   */
  language?: string;

  /**
   * marking reference granular marking model
   */
  markingRef?: int32;

  /**
   * granular marking model selectors
   */
  selectors?: string[];
}

/**
 * List of all the threat intelligence information objects.
 */
model ThreatIntelligenceInformationList
  is Azure.Core.Page<ThreatIntelligenceInformation>;

/**
 * Filtering criteria for querying threat intelligence indicators.
 */
model ThreatIntelligenceFilteringCriteria {
  /**
   * Page size
   */
  pageSize?: int32;

  /**
   * Minimum confidence.
   */
  minConfidence?: int32;

  /**
   * Maximum confidence.
   */
  maxConfidence?: int32;

  /**
   * Start time for ValidUntil filter.
   */
  minValidUntil?: string;

  /**
   * End time for ValidUntil filter.
   */
  maxValidUntil?: string;

  /**
   * Parameter to include/exclude disabled indicators.
   */
  includeDisabled?: boolean;

  /**
   * Columns to sort by and sorting order
   */
  @identifiers(#[])
  sortBy?: ThreatIntelligenceSortingCriteria[];

  /**
   * Sources of threat intelligence indicators
   */
  sources?: string[];

  /**
   * Pattern types
   */
  patternTypes?: string[];

  /**
   * Threat types of threat intelligence indicators
   */
  threatTypes?: string[];

  /**
   * Ids of threat intelligence indicators
   */
  ids?: string[];

  /**
   * Keywords for searching threat intelligence indicators
   */
  keywords?: string[];

  /**
   * Skip token.
   */
  skipToken?: string;
}

/**
 * List of available columns for sorting
 */
model ThreatIntelligenceSortingCriteria {
  /**
   * Column name
   */
  itemKey?: string;

  /**
   * Sorting order (ascending/descending/unsorted).
   */
  sortOrder?: ThreatIntelligenceSortingOrder;
}

/**
 * List of all the threat intelligence metric fields (type/threat type/source).
 */
model ThreatIntelligenceMetricsList {
  /**
   * Array of threat intelligence metric fields (type/threat type/source).
   */
  @identifiers(#[])
  value: ThreatIntelligenceMetrics[];
}

/**
 * Threat intelligence metrics.
 */
model ThreatIntelligenceMetrics {
  /**
   * Threat intelligence metrics.
   */
  properties?: ThreatIntelligenceMetric;
}

/**
 * Describes threat intelligence metric
 */
model ThreatIntelligenceMetric {
  /**
   * Last updated indicator metric
   */
  lastUpdatedTimeUtc?: string;

  /**
   * Threat type metrics
   */
  @identifiers(#[])
  threatTypeMetrics?: ThreatIntelligenceMetricEntity[];

  /**
   * Pattern type metrics
   */
  @identifiers(#[])
  patternTypeMetrics?: ThreatIntelligenceMetricEntity[];

  /**
   * Source metrics
   */
  @identifiers(#[])
  sourceMetrics?: ThreatIntelligenceMetricEntity[];
}

/**
 * Describes threat intelligence metric entity
 */
model ThreatIntelligenceMetricEntity {
  /**
   * Metric name
   */
  metricName?: string;

  /**
   * Metric value
   */
  metricValue?: int32;
}

/**
 * Array of tags to be appended to the threat intelligence indicator.
 */
model ThreatIntelligenceAppendTags {
  /**
   * List of tags to be appended.
   */
  threatIntelligenceTags?: string[];
}

/**
 * List all the watchlists.
 */
model WatchlistList is Azure.Core.Page<Watchlist>;

/**
 * Describes watchlist properties
 */
model WatchlistProperties {
  /**
   * The id (a Guid) of the watchlist
   */
  watchlistId?: string;

  /**
   * The display name of the watchlist
   */
  displayName: string;

  /**
   * The provider of the watchlist
   */
  provider: string;

  /**
   * The filename of the watchlist, called 'source'
   */
  source?: string;

  /**
   * The sourceType of the watchlist
   */
  sourceType?: SourceType;

  /**
   * The time the watchlist was created
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  created?: utcDateTime;

  /**
   * The last time the watchlist was updated
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  updated?: utcDateTime;

  /**
   * Describes a user that created the watchlist
   */
  createdBy?: UserInfo;

  /**
   * Describes a user that updated the watchlist
   */
  updatedBy?: UserInfo;

  /**
   * A description of the watchlist
   */
  description?: string;

  /**
   * The type of the watchlist
   */
  watchlistType?: string;

  /**
   * The alias of the watchlist
   */
  watchlistAlias?: string;

  /**
   * A flag that indicates if the watchlist is deleted or not
   */
  isDeleted?: boolean;

  /**
   * List of labels relevant to this watchlist
   */
  labels?: string[];

  /**
   * The default duration of a watchlist (in ISO 8601 duration format)
   */
  defaultDuration?: duration;

  /**
   * The tenantId where the watchlist belongs to
   */
  tenantId?: string;

  /**
   * The number of lines in a csv/tsv content to skip before the header
   */
  numberOfLinesToSkip?: int32;

  /**
   * The raw content that represents to watchlist items to create. In case of csv/tsv content type, it's the content of the file that will parsed by the endpoint
   */
  rawContent?: string;

  /**
   * The search key is used to optimize query performance when using watchlists for joins with other data. For example, enable a column with IP addresses to be the designated SearchKey field, then use this field as the key field when joining to other event data by IP address.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "For backward compatibility"
  itemsSearchKey: string;

  /**
   * The content type of the raw content. Example : text/csv or text/tsv
   */
  contentType?: string;

  /**
   * The status of the Watchlist upload : New, InProgress or Complete. **Note** : When a Watchlist upload status is InProgress, the Watchlist cannot be deleted
   */
  uploadStatus?: string;

  /**
   * Describes provisioning state
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * List all the watchlist items.
 */
model WatchlistItemList is Azure.Core.Page<WatchlistItem>;

/**
 * Describes watchlist item properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model WatchlistItemProperties {
  /**
   * The type of the watchlist item
   */
  watchlistItemType?: string;

  /**
   * The id (a Guid) of the watchlist item
   */
  watchlistItemId?: string;

  /**
   * The tenantId to which the watchlist item belongs to
   */
  tenantId?: string;

  /**
   * A flag that indicates if the watchlist item is deleted or not
   */
  isDeleted?: boolean;

  /**
   * The time the watchlist item was created
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  created?: utcDateTime;

  /**
   * The last time the watchlist item was updated
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  updated?: utcDateTime;

  /**
   * Describes a user that created the watchlist item
   */
  createdBy?: UserInfo;

  /**
   * Describes a user that updated the watchlist item
   */
  updatedBy?: UserInfo;

  /**
   * key-value pairs for a watchlist item
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "For backward compatibility"
  itemsKeyValue: unknown;

  /**
   * key-value pairs for a watchlist item entity mapping
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "For backward compatibility"
  entityMapping?: unknown;
}

/**
 * alert rule template data sources
 */
model AlertRuleTemplateDataSource {
  /**
   * The connector id that provides the following data types
   */
  connectorId?: string;

  /**
   * The data types used by the alert rule template
   */
  dataTypes?: string[];
}

/**
 * Base alert rule template property bag.
 */
model AlertRuleTemplatePropertiesBase {
  /**
   * The number of alert rules that were created by this template
   */
  alertRulesCreatedByTemplateCount?: int32;

  /**
   * The time that this alert rule template has been added.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdDateUTC?: utcDateTime;

  /**
   * The description of the alert rule template.
   */
  description?: string;

  /**
   * The display name for alert rule template.
   */
  displayName?: string;

  /**
   * The last time that this alert rule template has been updated.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdatedDateUTC?: utcDateTime;

  /**
   * The required data sources for this template
   */
  @identifiers(#["connectorId"])
  requiredDataConnectors?: AlertRuleTemplateDataSource[];

  /**
   * The alert rule template status.
   */
  status?: TemplateStatus;
}

/**
 * Represents Fusion alert rule.
 */
model FusionAlertRule extends AlertRule {
  /**
   * Fusion alert rule properties
   */
  properties?: FusionAlertRuleProperties;

  /**
   * The alert rule kind
   */
  kind: "Fusion";
}

/**
 * Fusion alert rule base property bag.
 */
model FusionAlertRuleProperties {
  /**
   * The Name of the alert rule template used to create this rule.
   */
  alertRuleTemplateName: string;

  /**
   * The description of the alert rule.
   */
  @visibility(Lifecycle.Read)
  description?: string;

  /**
   * The display name for alerts created by this alert rule.
   */
  @visibility(Lifecycle.Read)
  displayName?: string;

  /**
   * Determines whether this alert rule is enabled or disabled.
   */
  enabled: boolean;

  /**
   * The last time that this alert has been modified.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedUtc?: utcDateTime;

  /**
   * The severity for alerts created by this alert rule.
   */
  @visibility(Lifecycle.Read)
  severity?: AlertSeverity;

  /**
   * The tactics of the alert rule
   */
  @visibility(Lifecycle.Read)
  tactics?: AttackTactic[];

  /**
   * The techniques of the alert rule
   */
  @visibility(Lifecycle.Read)
  techniques?: string[];
}

/**
 * Represents Fusion alert rule template.
 */
model FusionAlertRuleTemplate extends AlertRuleTemplate {
  /**
   * Fusion alert rule template properties
   */
  properties?: FusionAlertRuleTemplateProperties;

  /**
   * The alert rule kind
   */
  kind: "Fusion";
}

/**
 * Represents Fusion alert rule template properties
 */
model FusionAlertRuleTemplateProperties {
  /**
   * the number of alert rules that were created by this template
   */
  alertRulesCreatedByTemplateCount?: int32;

  /**
   * The time that this alert rule template has been added.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdDateUTC?: utcDateTime;

  /**
   * The time that this alert rule template was last updated.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdatedDateUTC?: utcDateTime;

  /**
   * The description of the alert rule template.
   */
  description?: string;

  /**
   * The display name for alert rule template.
   */
  displayName?: string;

  /**
   * The required data connectors for this template
   */
  @identifiers(#[])
  requiredDataConnectors?: AlertRuleTemplateDataSource[];

  /**
   * The alert rule template status.
   */
  status?: TemplateStatus;

  /**
   * The severity for alerts created by this alert rule.
   */
  severity?: AlertSeverity;

  /**
   * The tactics of the alert rule template
   */
  tactics?: AttackTactic[];

  /**
   * The techniques of the alert rule template
   */
  techniques?: string[];
}

/**
 * Represents MicrosoftSecurityIncidentCreation rule.
 */
model MicrosoftSecurityIncidentCreationAlertRule extends AlertRule {
  /**
   * MicrosoftSecurityIncidentCreation rule properties
   */
  properties?: MicrosoftSecurityIncidentCreationAlertRuleProperties;

  /**
   * The alert rule kind
   */
  kind: "MicrosoftSecurityIncidentCreation";
}

/**
 * MicrosoftSecurityIncidentCreation rule property bag.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model MicrosoftSecurityIncidentCreationAlertRuleProperties
  extends MicrosoftSecurityIncidentCreationAlertRuleCommonProperties {
  /**
   * The Name of the alert rule template used to create this rule.
   */
  alertRuleTemplateName?: string;

  /**
   * The description of the alert rule.
   */
  description?: string;

  /**
   * The display name for alerts created by this alert rule.
   */
  displayName: string;

  /**
   * Determines whether this alert rule is enabled or disabled.
   */
  enabled: boolean;

  /**
   * The last time that this alert has been modified.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedUtc?: utcDateTime;
}

/**
 * MicrosoftSecurityIncidentCreation rule common property bag.
 */
model MicrosoftSecurityIncidentCreationAlertRuleCommonProperties {
  /**
   * the alerts' displayNames on which the cases will be generated
   */
  displayNamesFilter?: string[];

  /**
   * the alerts' displayNames on which the cases will not be generated
   */
  displayNamesExcludeFilter?: string[];

  /**
   * The alerts' productName on which the cases will be generated
   */
  productFilter: MicrosoftSecurityProductName;

  /**
   * the alerts' severities on which the cases will be generated
   */
  severitiesFilter?: AlertSeverity[];
}

/**
 * Represents MicrosoftSecurityIncidentCreation rule template.
 */
model MicrosoftSecurityIncidentCreationAlertRuleTemplate
  extends AlertRuleTemplate {
  /**
   * MicrosoftSecurityIncidentCreation rule template properties
   */
  properties?: MicrosoftSecurityIncidentCreationAlertRuleTemplateProperties;

  /**
   * The alert rule kind
   */
  kind: "MicrosoftSecurityIncidentCreation";
}

/**
 * MicrosoftSecurityIncidentCreation rule template properties
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model MicrosoftSecurityIncidentCreationAlertRuleTemplateProperties
  extends AlertRuleTemplatePropertiesBase {
  /**
   * the alerts' displayNames on which the cases will be generated
   */
  displayNamesFilter?: string[];

  /**
   * the alerts' displayNames on which the cases will not be generated
   */
  displayNamesExcludeFilter?: string[];

  /**
   * The alerts' productName on which the cases will be generated
   */
  productFilter?: MicrosoftSecurityProductName;

  /**
   * the alerts' severities on which the cases will be generated
   */
  severitiesFilter?: AlertSeverity[];
}

/**
 * Represents scheduled alert rule.
 */
model ScheduledAlertRule extends AlertRule {
  /**
   * Scheduled alert rule properties
   */
  properties?: ScheduledAlertRuleProperties;

  /**
   * The alert rule kind
   */
  kind: "Scheduled";
}

/**
 * Scheduled alert rule base property bag.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ScheduledAlertRuleProperties extends ScheduledAlertRuleCommonProperties {
  /**
   * The Name of the alert rule template used to create this rule.
   */
  alertRuleTemplateName?: string;

  /**
   * The version of the alert rule template used to create this rule - in format <a.b.c>, where all are numbers, for example 0 <1.0.2>
   */
  templateVersion?: string;

  /**
   * The description of the alert rule.
   */
  description?: string;

  /**
   * The display name for alerts created by this alert rule.
   */
  displayName: string;

  /**
   * Determines whether this alert rule is enabled or disabled.
   */
  enabled: boolean;

  /**
   * The last time that this alert rule has been modified.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedUtc?: utcDateTime;

  /**
   * The suppression (in ISO 8601 duration format) to wait since last time this alert rule been triggered.
   */
  suppressionDuration: duration;

  /**
   * Determines whether the suppression for this alert rule is enabled or disabled.
   */
  suppressionEnabled: boolean;

  /**
   * The tactics of the alert rule
   */
  tactics?: AttackTactic[];

  /**
   * The techniques of the alert rule
   */
  techniques?: string[];

  /**
   * The settings of the incidents that created from alerts triggered by this analytics rule
   */
  incidentConfiguration?: IncidentConfiguration;
}

/**
 * Incident Configuration property bag.
 */
model IncidentConfiguration {
  /**
   * Create incidents from alerts triggered by this analytics rule
   */
  createIncident: boolean;

  /**
   * Set how the alerts that are triggered by this analytics rule, are grouped into incidents
   */
  groupingConfiguration?: GroupingConfiguration;
}

/**
 * Grouping configuration property bag.
 */
model GroupingConfiguration {
  /**
   * Grouping enabled
   */
  enabled: boolean;

  /**
   * Re-open closed matching incidents
   */
  reopenClosedIncident: boolean;

  /**
   * Limit the group to alerts created within the lookback duration (in ISO 8601 duration format)
   */
  lookbackDuration: duration;

  /**
   * Grouping matching method. When method is Selected at least one of groupByEntities, groupByAlertDetails, groupByCustomDetails must be provided and not empty.
   */
  matchingMethod: MatchingMethod;

  /**
   * A list of entity types to group by (when matchingMethod is Selected). Only entities defined in the current alert rule may be used.
   */
  groupByEntities?: EntityMappingType[];

  /**
   * A list of alert details to group by (when matchingMethod is Selected)
   */
  groupByAlertDetails?: AlertDetail[];

  /**
   * A list of custom details keys to group by (when matchingMethod is Selected). Only keys defined in the current alert rule may be used.
   */
  groupByCustomDetails?: string[];
}

/**
 * Scheduled alert rule template property bag.
 */
model ScheduledAlertRuleCommonProperties {
  /**
   * The query that creates alerts for this rule.
   */
  query?: string;

  /**
   * The frequency (in ISO 8601 duration format) for this alert rule to run.
   */
  queryFrequency?: duration;

  /**
   * The period (in ISO 8601 duration format) that this alert rule looks at.
   */
  queryPeriod?: duration;

  /**
   * The severity for alerts created by this alert rule.
   */
  severity?: AlertSeverity;

  /**
   * The operation against the threshold that triggers alert rule.
   */
  triggerOperator?: TriggerOperator;

  /**
   * The threshold triggers this alert rule.
   */
  triggerThreshold?: int32;

  /**
   * The event grouping settings.
   */
  eventGroupingSettings?: EventGroupingSettings;

  /**
   * Dictionary of string key-value pairs of columns to be attached to the alert
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  customDetails?: Record<string>;

  /**
   * Array of the entity mappings of the alert rule
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "For backward compatibility"
  entityMappings?: EntityMapping[];

  /**
   * The alert details override settings
   */
  alertDetailsOverride?: AlertDetailsOverride;
}

/**
 * Event grouping settings property bag.
 */
model EventGroupingSettings {
  /**
   * The event grouping aggregation kinds
   */
  aggregationKind?: EventGroupingAggregationKind;
}

/**
 * Single entity mapping for the alert rule
 */
model EntityMapping {
  /**
   * The V3 type of the mapped entity
   */
  entityType?: EntityMappingType;

  /**
   * array of field mappings for the given entity mapping
   */
  @identifiers(#[])
  fieldMappings?: FieldMapping[];
}

/**
 * A single field mapping of the mapped entity
 */
model FieldMapping {
  /**
   * the V3 identifier of the entity
   */
  identifier?: string;

  /**
   * the column name to be mapped to the identifier
   */
  columnName?: string;
}

/**
 * Settings for how to dynamically override alert static details
 */
model AlertDetailsOverride {
  /**
   * the format containing columns name(s) to override the alert name
   */
  alertDisplayNameFormat?: string;

  /**
   * the format containing columns name(s) to override the alert description
   */
  alertDescriptionFormat?: string;

  /**
   * the column name to take the alert tactics from
   */
  alertTacticsColumnName?: string;

  /**
   * the column name to take the alert severity from
   */
  alertSeverityColumnName?: string;

  /**
   * List of additional dynamic properties to override
   */
  @identifiers(#[])
  alertDynamicProperties?: AlertPropertyMapping[];
}

/**
 * A single alert property mapping to override
 */
model AlertPropertyMapping {
  /**
   * The V3 alert property
   */
  alertProperty?: AlertProperty;

  /**
   * the column name to use to override this property
   */
  value?: string;
}

/**
 * Scheduled alert rule template properties
 */
model ScheduledAlertRuleTemplateProperties {
  /**
   * the number of alert rules that were created by this template
   */
  alertRulesCreatedByTemplateCount?: int32;

  /**
   * The time that this alert rule template has been added.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdDateUTC?: utcDateTime;

  /**
   * The time that this alert rule template was last updated.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdatedDateUTC?: utcDateTime;

  /**
   * The description of the alert rule template.
   */
  description?: string;

  /**
   * The display name for alert rule template.
   */
  displayName?: string;

  /**
   * The required data connectors for this template
   */
  @identifiers(#[])
  requiredDataConnectors?: AlertRuleTemplateDataSource[];

  /**
   * The alert rule template status.
   */
  status?: TemplateStatus;

  /**
   * The query that creates alerts for this rule.
   */
  query?: string;

  /**
   * The frequency (in ISO 8601 duration format) for this alert rule to run.
   */
  queryFrequency?: duration;

  /**
   * The period (in ISO 8601 duration format) that this alert rule looks at.
   */
  queryPeriod?: duration;

  /**
   * The severity for alerts created by this alert rule.
   */
  severity?: AlertSeverity;

  /**
   * The operation against the threshold that triggers alert rule.
   */
  triggerOperator?: TriggerOperator;

  /**
   * The threshold triggers this alert rule.
   */
  triggerThreshold?: int32;

  /**
   * The tactics of the alert rule template
   */
  tactics?: AttackTactic[];

  /**
   * The techniques of the alert rule template
   */
  techniques?: string[];

  /**
   * The version of this template - in format <a.b.c>, where all are numbers. For example <1.0.2>.
   */
  version?: string;

  /**
   * The event grouping settings.
   */
  eventGroupingSettings?: EventGroupingSettings;

  /**
   * Dictionary of string key-value pairs of columns to be attached to the alert
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  customDetails?: Record<string>;

  /**
   * Array of the entity mappings of the alert rule
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "For backward compatibility"
  entityMappings?: EntityMapping[];

  /**
   * The alert details override settings
   */
  alertDetailsOverride?: AlertDetailsOverride;
}

/**
 * Represents scheduled alert rule template.
 */
model ScheduledAlertRuleTemplate extends AlertRuleTemplate {
  /**
   * Scheduled alert rule template properties
   */
  properties?: ScheduledAlertRuleTemplateProperties;

  /**
   * The alert rule kind
   */
  kind: "Scheduled";
}

/**
 * Describes an automation rule action to add a task to an incident.
 */
model AddIncidentTaskActionProperties {
  /**
   * The title of the task.
   */
  title: string;

  /**
   * The description of the task.
   */
  description?: string;
}

/**
 * Describes an automation rule action to add a task to an incident
 */
model AutomationRuleAddIncidentTaskAction extends AutomationRuleAction {
  /**
   * Describes an automation rule action to add a task to an incident.
   */
  actionConfiguration?: AddIncidentTaskActionProperties;

  /**
   * The type of the automation rule action.
   */
  actionType: "AddIncidentTask";
}

/**
 * Describes an automation rule condition with boolean operators.
 */
model AutomationRuleBooleanCondition {
  /**
   * Describes a boolean condition operator.
   */
  operator?: AutomationRuleBooleanConditionSupportedOperator;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @identifiers(#[])
  @minItems(2)
  @maxItems(10)
  innerConditions?: AutomationRuleCondition[];
}

/**
 * Describes an automation rule action to modify an object's properties
 */
model AutomationRuleModifyPropertiesAction extends AutomationRuleAction {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  actionConfiguration?: IncidentPropertiesAction;

  /**
   * The type of the automation rule action.
   */
  actionType: "ModifyProperties";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model IncidentPropertiesAction {
  /**
   * The severity of the incident
   */
  severity?: IncidentSeverity;

  /**
   * The status of the incident
   */
  status?: IncidentStatus;

  /**
   * The reason the incident was closed
   */
  classification?: IncidentClassification;

  /**
   * The classification reason the incident was closed with
   */
  classificationReason?: IncidentClassificationReason;

  /**
   * Describes the reason the incident was closed.
   */
  classificationComment?: string;

  /**
   * Information on the user an incident is assigned to
   */
  owner?: IncidentOwnerInfo;

  /**
   * List of labels to add to the incident.
   */
  @identifiers(#["labelName"])
  labels?: IncidentLabel[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model AutomationRulePropertyArrayChangedValuesCondition {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  arrayType?: AutomationRulePropertyArrayChangedConditionSupportedArrayType;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  changeType?: AutomationRulePropertyArrayChangedConditionSupportedChangeType;
}

/**
 * Describes an automation rule condition on array properties.
 */
model AutomationRulePropertyArrayValuesCondition {
  /**
   * Describes an array condition evaluated array type.
   */
  arrayType?: AutomationRulePropertyArrayConditionSupportedArrayType;

  /**
   * Describes an array condition evaluation type.
   */
  arrayConditionType?: AutomationRulePropertyArrayConditionSupportedArrayConditionType;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @identifiers(#[])
  @maxItems(10)
  itemConditions?: AutomationRuleCondition[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model AutomationRulePropertyValuesChangedCondition {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  propertyName?: AutomationRulePropertyChangedConditionSupportedPropertyType;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  changeType?: AutomationRulePropertyChangedConditionSupportedChangedType;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  operator?: AutomationRulePropertyConditionSupportedOperator;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  propertyValues?: string[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model AutomationRulePropertyValuesCondition {
  /**
   * The property to evaluate in an automation rule property condition.
   */
  propertyName?: AutomationRulePropertyConditionSupportedProperty;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  operator?: AutomationRulePropertyConditionSupportedOperator;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  propertyValues?: string[];
}

/**
 * Describes an automation rule action to run a playbook
 */
model AutomationRuleRunPlaybookAction extends AutomationRuleAction {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  actionConfiguration?: PlaybookActionProperties;

  /**
   * The type of the automation rule action.
   */
  actionType: "RunPlaybook";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model PlaybookActionProperties {
  /**
   * The resource id of the playbook resource.
   */
  logicAppResourceId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Logic/workflows";
    },
    {
      type: "Microsoft.Web/sites";
    }
  ]>;

  /**
   * The tenant id of the playbook resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @format("uuid")
  tenantId?: string;
}

/**
 * Describes an automation rule condition that applies a boolean operator (e.g AND, OR) to conditions
 */
model BooleanConditionProperties extends AutomationRuleCondition {
  /**
   * Describes an automation rule condition with boolean operators.
   */
  conditionProperties?: AutomationRuleBooleanCondition;

  conditionType: "Boolean";
}

/**
 * Describes an automation rule condition that evaluates an array property's value change
 */
model PropertyArrayChangedConditionProperties extends AutomationRuleCondition {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  conditionProperties?: AutomationRulePropertyArrayChangedValuesCondition;
  conditionType: "PropertyArrayChanged";
}

/**
 * Describes an automation rule condition that evaluates an array property's value
 */
model PropertyArrayConditionProperties extends AutomationRuleCondition {
  /**
   * Describes an automation rule condition on array properties.
   */
  conditionProperties?: AutomationRulePropertyArrayValuesCondition;

  conditionType: "PropertyArray";
}

/**
 * Describes an automation rule condition that evaluates a property's value change
 */
model PropertyChangedConditionProperties extends AutomationRuleCondition {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  conditionProperties?: AutomationRulePropertyValuesChangedCondition;
  conditionType: "PropertyChanged";
}

/**
 * Describes an automation rule condition that evaluates a property's value
 */
model PropertyConditionProperties extends AutomationRuleCondition {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  conditionProperties?: AutomationRulePropertyValuesCondition;
  conditionType: "Property";
}

/**
 * The exposure status of the connector to the customers.
 */
model ConnectorDefinitionsAvailability {
  /**
   * The exposure status of the connector to the customers. Available values are 0-4 (0=None, 1=Available, 2=FeatureFlag, 3=Internal).
   */
  status?: int32;

  /**
   * Gets or sets a value indicating whether the connector is preview.
   */
  isPreview?: boolean;
}

/**
 * The criteria by which we determine whether the connector is connected or not.
 * For Example, use a KQL query to check if  the expected data type is flowing).
 */
model ConnectivityCriterion {
  /**
   * Gets or sets the type of connectivity.
   */
  type: string;

  /**
   * Gets or sets the queries for checking connectivity.
   */
  value?: string[];
}

/**
 * The data type which is created by the connector,
 * including a query indicated when was the last time that data type was received in the workspace.
 */
model ConnectorDataType {
  /**
   * Gets or sets the name of the data type to show in the graph.
   */
  name: string;

  /**
   * Gets or sets the query to indicate when relevant data was last received in the workspace.
   */
  lastDataReceivedQuery: string;
}

/**
 * Connector definition for kind 'Customizable'.
 */
model CustomizableConnectorDefinition extends DataConnectorDefinition {
  /**
   * Customizable properties.
   */
  properties?: CustomizableConnectorDefinitionProperties;

  /**
   * The data connector kind
   */
  kind: "Customizable";
}

/**
 * The UiConfig for 'Customizable' connector definition kind.
 */
model CustomizableConnectorDefinitionProperties {
  /**
   * Gets or sets the connector definition created date in UTC format.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdTimeUtc?: utcDateTime;

  /**
   * Gets or sets the connector definition last modified date in UTC format.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedUtc?: utcDateTime;

  /**
   * The UiConfig for 'Customizable' connector definition kind.
   */
  connectorUiConfig: CustomizableConnectorUiConfig;

  /**
   * The UiConfig for 'Customizable' connector definition kind.
   */
  connectionsConfig?: CustomizableConnectionsConfig;
}

/**
 * The UiConfig for 'Customizable' connector definition kind.
 */
model CustomizableConnectorUiConfig {
  /**
   * Gets or sets custom connector id. optional field.
   */
  id?: string;

  /**
   * Gets or sets the connector blade title.
   */
  title: string;

  /**
   * Gets or sets the connector publisher name.
   */
  publisher: string;

  /**
   * Gets or sets the connector description in markdown format.
   */
  descriptionMarkdown: string;

  /**
   * Gets or sets the graph queries to show the current data volume over time.
   */
  @identifiers(#[])
  graphQueries: GraphQuery[];

  /**
   * Gets or sets the data types to check for last data received.
   */
  @identifiers(#[])
  dataTypes: ConnectorDataType[];

  /**
   * Gets or sets the way the connector checks whether the connector is connected.
   */
  @identifiers(#[])
  connectivityCriteria: ConnectivityCriterion[];

  /**
   * The exposure status of the connector to the customers.
   */
  availability?: ConnectorDefinitionsAvailability;

  /**
   * The required Permissions for the connector.
   */
  permissions: ConnectorDefinitionsPermissions;

  /**
   * Gets or sets the instruction steps to enable the connector.
   */
  @identifiers(#[])
  instructionSteps: InstructionStep[];

  /**
   * Gets or sets the connector logo to be used when displaying the connector within Azure Sentinel's connector's gallery.
   * The logo value should be in SVG format.
   */
  logo?: string;

  /**
   * Gets or sets a value indicating whether to use 'OR'(SOME) or 'AND' between ConnectivityCriteria items.
   */
  isConnectivityCriteriasMatchSome?: boolean;
}

/**
 * The graph query to show the volume of data arriving into the workspace over time.
 */
model GraphQuery {
  /**
   * Gets or sets the metric name that the query is checking. For example: 'Total data receive'.
   */
  metricName: string;

  /**
   * Gets or sets the legend for the graph.
   */
  legend: string;

  /**
   * Gets or sets the base query for the graph.
   * The base query is wrapped by Sentinel UI infra with a KQL query, that measures the volume over time.
   */
  baseQuery: string;
}

/**
 * The required Permissions for the connector.
 */
model ConnectorDefinitionsPermissions {
  /**
   * Gets or sets the required tenant permissions for the connector.
   */
  tenant?: string[];

  /**
   * Gets or sets the required licenses for the user to create connections.
   */
  licenses?: string[];

  /**
   * Gets or sets the resource provider permissions required for the user to create connections.
   */
  @identifiers(#[])
  resourceProvider?: ConnectorDefinitionsResourceProvider[];

  /**
   * Gets or sets the customs permissions required for the user to create connections.
   */
  @identifiers(#[])
  customs?: CustomPermissionDetails[];
}

/**
 * The resource provider details include the required permissions for the user to create connections.
 * The user should have the required permissions(Read\Write, ..) in the specified scope ProviderPermissionsScope against the specified resource provider.
 */
model ConnectorDefinitionsResourceProvider {
  /**
   * Gets or sets the provider name.
   */
  provider: string;

  /**
   * Gets or sets the permissions description text.
   */
  permissionsDisplayText: string;

  /**
   * Gets or sets the permissions provider display name.
   */
  providerDisplayName: string;

  /**
   * The scope on which the user should have permissions, in order to be able to create connections.
   */
  scope: ProviderPermissionsScope;

  /**
   * Required permissions for the connector resource provider that define in ResourceProviders.
   * For more information about the permissions see <see href="https://docs.microsoft.com/en-us/azure/role-based-access-control/role-definitions#actions-format">here</see>.
   */
  requiredPermissions: ResourceProviderRequiredPermissions;
}

/**
 * Required permissions for the connector resource provider that define in ResourceProviders.
 * For more information about the permissions see <see href="https://docs.microsoft.com/en-us/azure/role-based-access-control/role-definitions#actions-format">here</see>.
 */
model ResourceProviderRequiredPermissions {
  /**
   * Gets or sets a value indicating whether the permission is read action (GET).
   */
  read?: boolean;

  /**
   * Gets or sets a value indicating whether the permission is write action (PUT or PATCH).
   */
  write?: boolean;

  /**
   * Gets or sets a value indicating whether the permission is delete action (DELETE).
   */
  delete?: boolean;

  /**
   * Gets or sets a value indicating whether the permission is custom actions (POST).
   */
  action?: boolean;
}

/**
 * The Custom permissions required for the connector.
 */
model CustomPermissionDetails {
  /**
   * Gets or sets the custom permissions name.
   */
  name: string;

  /**
   * Gets or sets the custom permissions description.
   */
  description: string;
}

/**
 * Instruction steps to enable the connector.
 */
model InstructionStep {
  /**
   * Gets or sets the instruction step title.
   */
  title?: string;

  /**
   * Gets or sets the instruction step description.
   */
  description?: string;

  /**
   * Gets or sets the instruction step details.
   */
  @identifiers(#[])
  instructions?: InstructionStepDetails[];

  /**
   * Gets or sets the inner instruction steps details.
   * For Example: instruction step 1 might contain inner instruction steps: [instruction step 1.1, instruction step 1.2].
   */
  @identifiers(#[])
  innerSteps?: InstructionStep[];
}

/**
 * Instruction step details, to be displayed in the Instructions steps section in the connector's page in Sentinel Portal.
 */
model InstructionStepDetails {
  /**
   * Gets or sets the instruction type parameters settings.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "For backward compatibility"
  parameters: unknown;

  /**
   * Gets or sets the instruction type name.
   */
  type: string;
}

/**
 * The UiConfig for 'Customizable' connector definition kind.
 */
model CustomizableConnectionsConfig {
  /**
   * Gets or sets the template name. The template includes ARM templates that can be created by the connector, usually it will be the dataConnectors ARM templates.
   */
  templateSpecName: string;

  /**
   * Gets or sets the template version.
   */
  templateSpecVersion: string;
}

/**
 * Represents Microsoft Entra ID data connector.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
model AADDataConnector extends DataConnector {
  /**
   * Microsoft Entra ID data connector properties.
   */
  properties?: AADDataConnectorProperties;

  /**
   * The data connector kind
   */
  kind: "AzureActiveDirectory";
}

/**
 * Microsoft Entra ID data connector properties.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
model AADDataConnectorProperties {
  ...DataConnectorTenantId;
  ...DataConnectorWithAlertsProperties;
}

/**
 * Properties data connector on tenant level.
 */
model DataConnectorTenantId {
  /**
   * The tenant id to connect to, and get the data from.
   */
  tenantId: string;
}

/**
 * Data connector properties.
 */
model DataConnectorWithAlertsProperties {
  /**
   * The available data types for the connector.
   */
  dataTypes?: AlertsDataTypeOfDataConnector;
}

/**
 * Alerts data type for data connectors.
 */
model AlertsDataTypeOfDataConnector {
  /**
   * Alerts data type connection.
   */
  alerts: DataConnectorDataTypeCommon;
}

/**
 * Common field for data type in data connectors.
 */
model DataConnectorDataTypeCommon {
  /**
   * Describe whether this data type connection is enabled or not.
   */
  state: DataTypeState;
}

/**
 * Represents AATP (Azure Advanced Threat Protection) data connector.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
model AATPDataConnector extends DataConnector {
  /**
   * AATP (Azure Advanced Threat Protection) data connector properties.
   */
  properties?: AATPDataConnectorProperties;

  /**
   * The data connector kind
   */
  kind: "AzureAdvancedThreatProtection";
}

/**
 * AATP (Azure Advanced Threat Protection) data connector properties.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
model AATPDataConnectorProperties {
  ...DataConnectorTenantId;
  ...DataConnectorWithAlertsProperties;
}

/**
 * Represents ASC (Azure Security Center) data connector.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
model ASCDataConnector extends DataConnector {
  /**
   * ASC (Azure Security Center) data connector properties.
   */
  properties?: ASCDataConnectorProperties;

  /**
   * The data connector kind
   */
  kind: "AzureSecurityCenter";
}

/**
 * ASC (Azure Security Center) data connector properties.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
model ASCDataConnectorProperties extends DataConnectorWithAlertsProperties {
  /**
   * The subscription id to connect to, and get the data from.
   */
  subscriptionId?: string;
}

/**
 * Represents Amazon Web Services CloudTrail data connector.
 */
model AwsCloudTrailDataConnector extends DataConnector {
  /**
   * Amazon Web Services CloudTrail data connector properties.
   */
  properties?: AwsCloudTrailDataConnectorProperties;

  /**
   * The data connector kind
   */
  kind: "AmazonWebServicesCloudTrail";
}

/**
 * Amazon Web Services CloudTrail data connector properties.
 */
model AwsCloudTrailDataConnectorProperties {
  /**
   * The Aws Role Arn (with CloudTrailReadOnly policy) that is used to access the Aws account.
   */
  awsRoleArn?: string;

  /**
   * The available data types for the connector.
   */
  dataTypes: AwsCloudTrailDataConnectorDataTypes;
}

/**
 * The available data types for Amazon Web Services CloudTrail data connector.
 */
model AwsCloudTrailDataConnectorDataTypes {
  /**
   * Logs data type.
   */
  logs: AwsCloudTrailDataConnectorDataTypesLogs;
}

/**
 * Logs data type.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "For backward compatibility"
model AwsCloudTrailDataConnectorDataTypesLogs
  extends DataConnectorDataTypeCommon {}

/**
 * Represents Rest Api Poller data connector.
 */
model RestApiPollerDataConnector extends DataConnector {
  /**
   * Rest Api Poller data connector properties.
   */
  properties?: RestApiPollerDataConnectorProperties;

  /**
   * The data connector kind
   */
  kind: "RestApiPoller";
}

/**
 * Rest Api Poller data connector properties.
 */
model RestApiPollerDataConnectorProperties {
  /**
   * The connector definition name (the dataConnectorDefinition resource id).
   */
  connectorDefinitionName: string;

  /**
   * The a authentication model.
   */
  auth: CcpAuthConfig;

  /**
   * The request configuration.
   */
  request: RestApiPollerRequestConfig;

  /**
   * The DCR related properties.
   */
  dcrConfig?: DCRConfiguration;

  /**
   * Indicates whether the connector is active or not.
   */
  isActive?: boolean;

  /**
   * The Log Analytics table destination.
   */
  dataType?: string;

  /**
   * The response configuration.
   */
  response?: CcpResponseConfig;

  /**
   * The paging configuration.
   */
  paging?: RestApiPollerRequestPagingConfig;

  /**
   * The add on attributes. The key name will become attribute name (a column) and the value will become the attribute value in the payload.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  addOnAttributes?: Record<string>;
}

/**
 * Base Model for API authentication.
 */
@discriminator("type")
model CcpAuthConfig {
  /**
   * The auth type
   */
  type: CcpAuthType;
}

/**
 * The request configuration.
 */
model RestApiPollerRequestConfig {
  /**
   * The API endpoint.
   */
  apiEndpoint: string;

  /**
   * The Rate limit queries per second for the request..
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "For backward compatibility"
  rateLimitQPS?: int32 | null;

  /**
   * The query window in minutes for the request.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "For backward compatibility"
  queryWindowInMin?: int32 | null;

  /**
   * The HTTP method, default value GET.
   */
  httpMethod?: HttpMethodVerb;

  /**
   * The query time format. A remote server can have a query to pull data from range 'start' to 'end'. This property indicate what is the expected time format the remote server know to parse.
   */
  queryTimeFormat?: string;

  /**
   * The retry count.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "For backward compatibility"
  retryCount?: int32 | null;

  /**
   * The timeout in seconds.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "For backward compatibility"
  timeoutInSeconds?: int32 | null;

  /**
   * Flag to indicate if HTTP POST payload is in JSON format (vs form-urlencoded).
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "For backward compatibility"
  isPostPayloadJson?: boolean | null;

  /**
   * The header for the request for the remote server.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  headers?: Record<string>;

  /**
   * The HTTP query parameters to RESTful API.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  queryParameters?: Record<unknown>;

  /**
   * the query parameters template. Defines the query parameters template to use when passing query parameters in advanced scenarios.
   */
  queryParametersTemplate?: string;

  /**
   * The query parameter name which the remote server expect to start query. This property goes hand to hand with `endTimeAttributeName`.
   */
  startTimeAttributeName?: string;

  /**
   * The query parameter name which the remote server expect to end query. This property goes hand to hand with `startTimeAttributeName`
   */
  endTimeAttributeName?: string;

  /**
   * The query parameter name which we need to send the server for query logs in time interval. Should be defined with `queryTimeIntervalPrepend` and `queryTimeIntervalDelimiter`
   */
  queryTimeIntervalAttributeName?: string;

  /**
   * The string prepend to the value of the query parameter in `queryTimeIntervalAttributeName`.
   */
  queryTimeIntervalPrepend?: string;

  /**
   * The delimiter string between 2 QueryTimeFormat in the query parameter `queryTimeIntervalAttributeName`.
   */
  queryTimeIntervalDelimiter?: string;
}

/**
 * The configuration of the destination of the data.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
model DCRConfiguration {
  /**
   * Represents the data collection ingestion endpoint in log analytics.
   */
  dataCollectionEndpoint: string;

  /**
   * The data collection rule immutable id, the rule defines the transformation and data destination.
   */
  dataCollectionRuleImmutableId: string;

  /**
   * The stream we are sending the data to.
   */
  streamName: string;
}

/**
 * A custom response configuration for a rule.
 */
model CcpResponseConfig {
  /**
   * The json paths, '$' char is the json root.
   */
  eventsJsonPaths: string[];

  /**
   * The value where the status message/code should appear in the response.
   */
  successStatusJsonPath?: string;

  /**
   * The status value.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "For backward compatibility"
  successStatusValue?: string | null;

  /**
   * The value indicating whether the remote server support Gzip and we should expect Gzip response.
   */
  isGzipCompressed?: boolean;

  /**
   * The compression algorithm. For Example: 'gzip', 'multi-gzip', 'deflate'.
   */
  compressionAlgo?: string = "gzip";

  /**
   * The response format. possible values are json,csv,xml
   */
  format?: string = "json";

  /**
   * The csv delimiter, in case the response format is CSV.
   */
  csvDelimiter?: string;

  /**
   * The value indicating whether the response has CSV boundary in case the response in CSV format.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "For backward compatibility"
  hasCsvBoundary?: boolean | null;

  /**
   * The value indicating whether the response has headers in case the response in CSV format.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "For backward compatibility"
  hasCsvHeader?: boolean | null;

  /**
   * The value indicating whether the response isn't an array of events / logs.  By setting this flag to true it means the remote server will response with an object which each property has as a value an array of events / logs.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "For backward compatibility"
  convertChildPropertiesToArray?: boolean | null;

  /**
   * The character used to escape characters in CSV.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "For backward compatibility"
  @maxLength(1)
  @minLength(1)
  csvEscape?: string | null = "\"";
}

/**
 * The request paging configuration.
 */
model RestApiPollerRequestPagingConfig {
  /**
   * Type of paging
   */
  pagingType: RestApiPollerRequestPagingKind;

  /**
   * Page size
   */
  pageSize?: int32;

  /**
   * Page size parameter name
   */
  pageSizeParameterName?: string;
}

/**
 * The request paging configuration for LinkHeader and PersistentLinkHeader paging type parameters.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model RestApiPollerRequestPagingLinkHeaderConfig
  extends RestApiPollerRequestPagingConfig {
  /**
   * JSON path of link header token in HTTP response payload
   */
  linkHeaderTokenJsonPath?: string;

  /**
   * Rel link name from the link header
   */
  linkHeaderRelLinkName?: string;
}

/**
 * The request paging configuration for NextPageToken and PersistentToken paging type parameters.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model RestApiPollerRequestPagingTokenConfig
  extends RestApiPollerRequestPagingConfig {
  /**
   * JSON path of next page token in HTTP response payload
   */
  nextPageTokenJsonPath?: string;

  /**
   * JSON path of flag in HTTP response payload to indicate more pages
   */
  hasNextFlagJsonPath?: string;

  /**
   * HTTP response header name of next page token
   */
  nextPageTokenResponseHeader?: string;

  /**
   * Next page parameter name in HTTP request
   */
  nextPageParaName?: string;

  /**
   * Next page header name in the request
   */
  nextPageRequestHeader?: string;
}

/**
 * The request paging configuration for NextPageUrl paging type parameters.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model RestApiPollerRequestPagingNextPageUrlConfig
  extends RestApiPollerRequestPagingConfig {
  /**
   * Next page URL
   */
  nextPageUrl?: string;

  /**
   * Query parameters of next page URL
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  nextPageUrlQueryParameters?: Record<string>;

  /**
   * Paging query parameters in string template format
   */
  nextPageUrlQueryParametersTemplate?: string;

  /**
   * Next page parameter name in HTTP request
   */
  nextPageParaName?: string;

  /**
   * Next page header name in the request
   */
  nextPageRequestHeader?: string;

  /**
   * JSON path of flag in HTTP response payload to indicate more pages
   */
  hasNextFlagJsonPath?: string;
}

/**
 * The request paging configuration for Offset paging type parameters.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model RestApiPollerRequestPagingOffsetConfig
  extends RestApiPollerRequestPagingConfig {
  /**
   * Offset parameter name in HTTP request
   */
  offsetParaName?: string;
}

/**
 * The request paging configuration for Count base paging type parameters.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model RestApiPollerRequestPagingCountBaseConfig
  extends RestApiPollerRequestPagingConfig {
  /**
   * Indicates whether the count is zero based
   */
  zeroBasedIndexing?: boolean;

  /**
   * JSON path of page count in HTTP response payload
   */
  pageCountJsonPath?: string;

  /**
   * Parameter name of page number in HTTP request
   */
  pageNumberParaName?: string;

  /**
   * JSON path of page number in HTTP response payload
   */
  pageNumberJsonPath?: string;

  /**
   * JSON path of total number of results in HTTP response payload
   */
  totalResultsJsonPath?: string;
}

/**
 * Model for authentication with the API Key. Will result in additional header on the request (default behavior) to the remote server: 'ApiKeyName: ApiKeyIdentifier ApiKey'. If 'IsApiKeyInPostPayload' is true it will send it in the body of the request and not the header.
 */
model ApiKeyAuthModel extends CcpAuthConfig {
  /**
   * API Key for the user secret key credential
   */
  @secret
  apiKey: string;

  /**
   * API Key name
   */
  apiKeyName: string;

  /**
   * API Key Identifier
   */
  apiKeyIdentifier?: string;

  /**
   * Flag to indicate if API key is set in HTTP POST payload
   */
  isApiKeyInPostPayload?: boolean;

  /**
   * The auth type
   */
  type: "APIKey";
}

/**
 * Model for API authentication with AWS.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
model AWSAuthModel extends CcpAuthConfig {
  /**
   * AWS STS assume role ARN
   */
  roleArn: string;

  /**
   * AWS STS assume role external ID. This is used to prevent the confused deputy problem: 'https://docs.aws.amazon.com/IAM/latest/UserGuide/confused-deputy.html'
   */
  externalId?: string;

  /**
   * The auth type
   */
  type: "AWS";
}

/**
 * Model for API authentication with basic flow - user name + password.
 */
model BasicAuthModel extends CcpAuthConfig {
  /**
   * The user name.
   */
  userName: string;

  /**
   * The password
   */
  @secret
  password: string;

  /**
   * The auth type
   */
  type: "Basic";
}

/**
 * Model for API authentication for all GCP kind connectors.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
model GCPAuthModel extends CcpAuthConfig {
  /**
   * GCP Service Account Email
   */
  serviceAccountEmail: string;

  /**
   * GCP Project Number
   */
  projectNumber: string;

  /**
   * GCP Workload Identity Provider ID
   */
  workloadIdentityProviderId: string;

  /**
   * The auth type
   */
  type: "GCP";
}

/**
 * Model for API authentication for working with service bus or storage account.
 */
model GenericBlobSbsAuthModel extends CcpAuthConfig {
  /**
   * Credentials for service bus namespace, keyvault uri for access key
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  credentialsConfig?: Record<string>;

  /**
   * Credentials for storage account, keyvault uri for access key
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  storageAccountCredentialsConfig?: Record<string>;

  /**
   * The auth type
   */
  type: "ServiceBus";
}

/**
 * Model for API authentication for GitHub. For this authentication first we need to approve the Router app (Microsoft Security DevOps) to access the GitHub account, Then we only need the InstallationId to get the access token from https://api.github.com/app/installations/{installId}/access_tokens.
 */
model GitHubAuthModel extends CcpAuthConfig {
  /**
   * The GitHubApp auth installation id.
   */
  installationId?: string;

  /**
   * The auth type
   */
  type: "GitHub";
}

/**
 * Model for API authentication with no authentication method - public API.
 */
model NoneAuthModel extends CcpAuthConfig {
  /**
   * The auth type
   */
  type: "None";
}

/**
 * Model for API authentication with JWT. Simple exchange between user name + password to access token.
 */
model JwtAuthModel extends CcpAuthConfig {
  /**
   * Token endpoint to request JWT
   */
  tokenEndpoint: string;

  /**
   * The user name. If user name and password sent in header request we only need to populate the `value` property with the user name (Same as basic auth). If user name and password sent in body request we need to specify the `Key` and `Value`.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  userName: Record<string>;

  /**
   * The password
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  @secret
  password: Record<string>;

  /**
   * The custom query parameter we want to add once we send request to token endpoint.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  queryParameters?: Record<string>;

  /**
   * The custom headers we want to add once we send request to token endpoint.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  headers?: Record<string>;

  /**
   * Flag indicating whether we want to send the user name and password to token endpoint in the headers.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "For backward compatibility"
  isCredentialsInHeaders?: boolean | null;

  /**
   * Flag indicating whether the body request is JSON (header Content-Type = application/json), meaning its a Form URL encoded request (header Content-Type = application/x-www-form-urlencoded).
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "For backward compatibility"
  isJsonRequest?: boolean | null = false;

  /**
   * Request timeout in seconds.
   */
  @maxValue(180)
  requestTimeoutInSeconds?: int32 = 100;

  /**
   * The auth type
   */
  type: "JwtToken";
}

/**
 * Model for API authentication with OAuth2.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
model OAuthModel extends CcpAuthConfig {
  /**
   * The user's authorization code.
   */
  @secret
  authorizationCode?: string;

  /**
   * The Application (client) secret that the OAuth provider assigned to your app.
   */
  @secret
  clientSecret: string;

  /**
   * The Application (client) ID that the OAuth provider assigned to your app.
   */
  clientId: string;

  /**
   * Indicating whether we want to send the clientId and clientSecret to token endpoint in the headers.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "For backward compatibility"
  isCredentialsInHeaders?: boolean | null = false;

  /**
   * The Application (client) Scope that the OAuth provider assigned to your app.
   */
  scope?: string;

  /**
   * The Application redirect url that the user config in the OAuth provider.
   */
  redirectUri?: url;

  /**
   * The grant type, usually will be 'authorization code'.
   */
  grantType: string;

  /**
   * The token endpoint. Defines the OAuth2 refresh token.
   */
  tokenEndpoint: string;

  /**
   * The token endpoint headers.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tokenEndpointHeaders?: Record<string>;

  /**
   * The token endpoint query parameters.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tokenEndpointQueryParameters?: Record<string>;

  /**
   * The authorization endpoint.
   */
  authorizationEndpoint?: string;

  /**
   * The authorization endpoint headers.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  authorizationEndpointHeaders?: Record<string>;

  /**
   * The authorization endpoint query parameters.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  authorizationEndpointQueryParameters?: Record<string>;

  /**
   * A value indicating whether it's a JWT flow.
   */
  isJwtBearerFlow?: boolean;

  /**
   * Access token prepend. Default is 'Bearer'.
   */
  accessTokenPrepend?: string;

  /**
   * The auth type
   */
  type: "OAuth2";
}

/**
 * Model for API authentication for Oracle.
 */
model OracleAuthModel extends CcpAuthConfig {
  /**
   * Oracle tenant ID
   */
  tenantId: string;

  /**
   * Oracle user ID
   */
  userId: string;

  /**
   * Public Fingerprint
   */
  publicFingerprint: string;

  /**
   * Content of the PRM file
   */
  pemFile: string;

  /**
   * The auth type
   */
  type: "Oracle";
}

/**
 * Model for API authentication with session cookie.
 */
model SessionAuthModel extends CcpAuthConfig {
  /**
   * The user name attribute key value.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  userName: Record<string>;

  /**
   * The password attribute name.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  @secret
  password: Record<string>;

  /**
   * Query parameters to session service endpoint.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  queryParameters?: Record<unknown>;

  /**
   * Indicating whether API key is set in HTTP POST payload.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "For backward compatibility"
  isPostPayloadJson?: boolean | null;

  /**
   * HTTP request headers to session service endpoint.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  headers?: Record<string>;

  /**
   * Session timeout in minutes.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "For backward compatibility"
  sessionTimeoutInMinutes?: int32 | null;

  /**
   * Session id attribute name from HTTP response header.
   */
  sessionIdName?: string;

  /**
   * HTTP request URL to session service endpoint.
   */
  sessionLoginRequestUri?: string;

  /**
   * The auth type
   */
  type: "Session";
}

/**
 * Represents MCAS (Microsoft Cloud App Security) data connector.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
model MCASDataConnector extends DataConnector {
  /**
   * MCAS (Microsoft Cloud App Security) data connector properties.
   */
  properties?: MCASDataConnectorProperties;

  /**
   * The data connector kind
   */
  kind: "MicrosoftCloudAppSecurity";
}

/**
 * MCAS (Microsoft Cloud App Security) data connector properties.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
model MCASDataConnectorProperties extends DataConnectorTenantId {
  /**
   * The available data types for the connector.
   */
  dataTypes: MCASDataConnectorDataTypes;
}

/**
 * The available data types for MCAS (Microsoft Cloud App Security) data connector.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
model MCASDataConnectorDataTypes extends AlertsDataTypeOfDataConnector {
  /**
   * Discovery log data type connection.
   */
  discoveryLogs?: DataConnectorDataTypeCommon;
}

/**
 * Represents MDATP (Microsoft Defender Advanced Threat Protection) data connector.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
model MDATPDataConnector extends DataConnector {
  /**
   * MDATP (Microsoft Defender Advanced Threat Protection) data connector properties.
   */
  properties?: MDATPDataConnectorProperties;

  /**
   * The data connector kind
   */
  kind: "MicrosoftDefenderAdvancedThreatProtection";
}

/**
 * MDATP (Microsoft Defender Advanced Threat Protection) data connector properties.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
model MDATPDataConnectorProperties {
  ...DataConnectorTenantId;
  ...DataConnectorWithAlertsProperties;
}

/**
 * Represents threat intelligence data connector.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
model TIDataConnector extends DataConnector {
  /**
   * TI (Threat Intelligence) data connector properties.
   */
  properties?: TIDataConnectorProperties;

  /**
   * The data connector kind
   */
  kind: "ThreatIntelligence";
}

/**
 * TI (Threat Intelligence) data connector properties.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
model TIDataConnectorProperties extends DataConnectorTenantId {
  /**
   * The lookback period for the feed to be imported.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "For backward compatibility"
  tipLookbackPeriod?: utcDateTime | null;

  /**
   * The available data types for the connector.
   */
  dataTypes: TIDataConnectorDataTypes;
}

/**
 * The available data types for TI (Threat Intelligence) data connector.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
model TIDataConnectorDataTypes {
  /**
   * Data type for indicators connection.
   */
  indicators: TIDataConnectorDataTypesIndicators;
}

/**
 * Data type for indicators connection.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "For backward compatibility"
model TIDataConnectorDataTypesIndicators extends DataConnectorDataTypeCommon {}

/**
 * Represents Microsoft Threat Intelligence data connector.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
model MSTIDataConnector extends DataConnector {
  /**
   * Microsoft Threat Intelligence data connector properties.
   */
  properties?: MSTIDataConnectorProperties;

  /**
   * The data connector kind
   */
  kind: "MicrosoftThreatIntelligence";
}

/**
 * Microsoft Threat Intelligence data connector properties.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
model MSTIDataConnectorProperties extends DataConnectorTenantId {
  /**
   * The available data types for the connector.
   */
  dataTypes: MSTIDataConnectorDataTypes;
}

/**
 * The available data types for Microsoft Threat Intelligence data connector.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
model MSTIDataConnectorDataTypes {
  /**
   * Data type for Microsoft Threat Intelligence data connector.
   */
  microsoftEmergingThreatFeed: MSTIDataConnectorDataTypesMicrosoftEmergingThreatFeed;
}

/**
 * Data type for Microsoft Threat Intelligence data connector.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
model MSTIDataConnectorDataTypesMicrosoftEmergingThreatFeed
  extends DataConnectorDataTypeCommon {
  /**
   * The lookback period for the feed to be imported. The date-time to begin importing the feed from, for example: 2024-01-01T00:00:00.000Z.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lookbackPeriod: utcDateTime;
}

/**
 * Represents Microsoft Defender for Threat Intelligence Premium data connector.
 */
model PremiumMicrosoftDefenderForThreatIntelligence extends DataConnector {
  /**
   * Microsoft Defender for Threat Intelligence Premium data connector properties.
   */
  properties?: PremiumMdtiDataConnectorProperties;

  /**
   * The data connector kind
   */
  kind: "PremiumMicrosoftDefenderForThreatIntelligence";
}

/**
 * Microsoft Defender for Threat Intelligence Premium data connector properties.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model PremiumMdtiDataConnectorProperties extends DataConnectorTenantId {
  /**
   * The lookback period for the feed to be imported. The date-time to begin importing the feed from, for example: 2024-01-01T00:00:00.000Z.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lookbackPeriod: utcDateTime;

  /**
   * The flag to indicate whether the tenant has the premium SKU required to access this connector.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
  requiredSKUsPresent?: boolean;

  /**
   * The available data types for the connector.
   */
  dataTypes: PremiumMdtiDataConnectorDataTypes;
}

/**
 * The available data types for Microsoft Defender for Threat Intelligence Premium data connector.
 */
model PremiumMdtiDataConnectorDataTypes {
  /**
   * Data type for Microsoft Defender for Threat Intelligence Premium data connector.
   */
  connector: PremiumMdtiDataConnectorDataTypesConnector;
}

/**
 * Data type for Microsoft Defender for Threat Intelligence Premium data connector.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "For backward compatibility"
model PremiumMdtiDataConnectorDataTypesConnector
  extends DataConnectorDataTypeCommon {}

/**
 * Represents office data connector.
 */
model OfficeDataConnector extends DataConnector {
  /**
   * Office data connector properties.
   */
  properties?: OfficeDataConnectorProperties;

  /**
   * The data connector kind
   */
  kind: "Office365";
}

/**
 * Office data connector properties.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model OfficeDataConnectorProperties extends DataConnectorTenantId {
  /**
   * The available data types for the connector.
   */
  dataTypes: OfficeDataConnectorDataTypes;
}

/**
 * The available data types for office data connector.
 */
model OfficeDataConnectorDataTypes {
  /**
   * Exchange data type connection.
   */
  exchange: OfficeDataConnectorDataTypesExchange;

  /**
   * SharePoint data type connection.
   */
  sharePoint: OfficeDataConnectorDataTypesSharePoint;

  /**
   * Teams data type connection.
   */
  teams: OfficeDataConnectorDataTypesTeams;
}

/**
 * Exchange data type connection.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "For backward compatibility"
model OfficeDataConnectorDataTypesExchange
  extends DataConnectorDataTypeCommon {}

/**
 * SharePoint data type connection.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "For backward compatibility"
model OfficeDataConnectorDataTypesSharePoint
  extends DataConnectorDataTypeCommon {}

/**
 * Teams data type connection.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "For backward compatibility"
model OfficeDataConnectorDataTypesTeams extends DataConnectorDataTypeCommon {}

/**
 * Represents Anomaly Security ML Analytics Settings
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
model AnomalySecurityMLAnalyticsSettings extends SecurityMLAnalyticsSetting {
  /**
   * Anomaly Security ML Analytics Settings properties
   */
  properties?: AnomalySecurityMLAnalyticsSettingsProperties;

  /**
   * The kind of security ML Analytics Settings
   */
  kind: "Anomaly";
}

/**
 * AnomalySecurityMLAnalytics settings base property bag.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
model AnomalySecurityMLAnalyticsSettingsProperties {
  /**
   * The description of the SecurityMLAnalyticsSettings.
   */
  description?: string;

  /**
   * The display name for settings created by this SecurityMLAnalyticsSettings.
   */
  displayName: string;

  /**
   * Determines whether this settings is enabled or disabled.
   */
  enabled: boolean;

  /**
   * The last time that this SecurityMLAnalyticsSettings has been modified.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedUtc?: utcDateTime;

  /**
   * The required data sources for this SecurityMLAnalyticsSettings
   */
  @identifiers(#["connectorId"])
  requiredDataConnectors?: SecurityMLAnalyticsSettingsDataSource[];

  /**
   * The tactics of the SecurityMLAnalyticsSettings
   */
  tactics?: AttackTactic[];

  /**
   * The techniques of the SecurityMLAnalyticsSettings
   */
  techniques?: string[];

  /**
   * The anomaly version of the AnomalySecurityMLAnalyticsSettings.
   */
  anomalyVersion: string;

  /**
   * The customizable observations of the AnomalySecurityMLAnalyticsSettings.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "For backward compatibility"
  customizableObservations?: unknown;

  /**
   * The frequency that this SecurityMLAnalyticsSettings will be run.
   */
  frequency: duration;

  /**
   * The anomaly SecurityMLAnalyticsSettings status
   */
  settingsStatus: SettingsStatus;

  /**
   * Determines whether this anomaly security ml analytics settings is a default settings
   */
  isDefaultSettings: boolean;

  /**
   * The anomaly settings version of the Anomaly security ml analytics settings that dictates whether job version gets updated or not.
   */
  anomalySettingsVersion?: int32;

  /**
   * The anomaly settings definition Id
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @format("uuid")
  settingsDefinitionId?: string;
}

/**
 * security ml analytics settings data sources
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
model SecurityMLAnalyticsSettingsDataSource {
  /**
   * The connector id that provides the following data types
   */
  connectorId?: string;

  /**
   * The data types used by the security ml analytics settings
   */
  dataTypes?: string[];
}

/**
 * Represents an account entity.
 */
model AccountEntity extends Entity {
  /**
   * Account entity properties
   */
  properties?: AccountEntityProperties;

  /**
   * The kind of the entity.
   */
  kind: "Account";
}

/**
 * Account entity property bag.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model AccountEntityProperties extends EntityCommonProperties {
  /**
   * The Azure Active Directory tenant id.
   */
  @visibility(Lifecycle.Read)
  aadTenantId?: string;

  /**
   * The Azure Active Directory user id.
   */
  @visibility(Lifecycle.Read)
  aadUserId?: string;

  /**
   * The name of the account. This field should hold only the name without any domain added to it, i.e. administrator.
   */
  @visibility(Lifecycle.Read)
  accountName?: string;

  /**
   * The display name of the account.
   */
  @visibility(Lifecycle.Read)
  displayName?: string;

  /**
   * The Host entity id that contains the account in case it is a local account (not domain joined)
   */
  @visibility(Lifecycle.Read)
  hostEntityId?: string;

  /**
   * Determines whether this is a domain account.
   */
  @visibility(Lifecycle.Read)
  isDomainJoined?: boolean;

  /**
   * The NetBIOS domain name as it appears in the alert format - domain\username. Examples: NT AUTHORITY.
   */
  @visibility(Lifecycle.Read)
  ntDomain?: string;

  /**
   * The objectGUID attribute is a single-value attribute that is the unique identifier for the object, assigned by active directory.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @visibility(Lifecycle.Read)
  @format("uuid")
  objectGuid?: string;

  /**
   * The Azure Active Directory Passport User ID.
   */
  @visibility(Lifecycle.Read)
  puid?: string;

  /**
   * The account security identifier, e.g. S-1-5-18.
   */
  @visibility(Lifecycle.Read)
  sid?: string;

  /**
   * The user principal name suffix for the account, in some cases it is also the domain name. Examples: contoso.com.
   */
  @visibility(Lifecycle.Read)
  upnSuffix?: string;

  /**
   * The fully qualified domain DNS name.
   */
  @visibility(Lifecycle.Read)
  dnsDomain?: string;
}

/**
 * Represents an azure resource entity.
 */
model AzureResourceEntity extends Entity {
  /**
   * AzureResource entity properties
   */
  properties?: AzureResourceEntityProperties;

  /**
   * The kind of the entity.
   */
  kind: "AzureResource";
}

/**
 * AzureResource entity property bag.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model AzureResourceEntityProperties extends EntityCommonProperties {
  /**
   * The azure resource id of the resource
   */
  @visibility(Lifecycle.Read)
  resourceId?: string;

  /**
   * The subscription id of the resource
   */
  @visibility(Lifecycle.Read)
  subscriptionId?: string;
}

/**
 * Represents a cloud application entity.
 */
model CloudApplicationEntity extends Entity {
  /**
   * CloudApplication entity properties
   */
  properties?: CloudApplicationEntityProperties;

  /**
   * The kind of the entity.
   */
  kind: "CloudApplication";
}

/**
 * CloudApplication entity property bag.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model CloudApplicationEntityProperties extends EntityCommonProperties {
  /**
   * The technical identifier of the application.
   */
  @visibility(Lifecycle.Read)
  appId?: int32;

  /**
   * The name of the related cloud application.
   */
  @visibility(Lifecycle.Read)
  appName?: string;

  /**
   * The user defined instance name of the cloud application. It is often used to distinguish between several applications of the same type that a customer has.
   */
  @visibility(Lifecycle.Read)
  instanceName?: string;
}

/**
 * Represents a dns entity.
 */
model DnsEntity extends Entity {
  /**
   * Dns entity properties
   */
  properties?: DnsEntityProperties;

  /**
   * The kind of the entity.
   */
  kind: "DnsResolution";
}

/**
 * Dns entity property bag.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model DnsEntityProperties extends EntityCommonProperties {
  /**
   * An ip entity id for the dns server resolving the request
   */
  @visibility(Lifecycle.Read)
  dnsServerIpEntityId?: string;

  /**
   * The name of the dns record associated with the alert
   */
  @visibility(Lifecycle.Read)
  domainName?: string;

  /**
   * An ip entity id for the dns request client
   */
  @visibility(Lifecycle.Read)
  hostIpAddressEntityId?: string;

  /**
   * Ip entity identifiers for the resolved ip address.
   */
  @visibility(Lifecycle.Read)
  ipAddressEntityIds?: string[];
}

/**
 * Represents a file entity.
 */
model FileEntity extends Entity {
  /**
   * File entity properties
   */
  properties?: FileEntityProperties;

  /**
   * The kind of the entity.
   */
  kind: "File";
}

/**
 * File entity property bag.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model FileEntityProperties extends EntityCommonProperties {
  /**
   * The full path to the file.
   */
  @visibility(Lifecycle.Read)
  directory?: string;

  /**
   * The file hash entity identifiers associated with this file
   */
  @visibility(Lifecycle.Read)
  fileHashEntityIds?: string[];

  /**
   * The file name without path (some alerts might not include path).
   */
  @visibility(Lifecycle.Read)
  fileName?: string;

  /**
   * The Host entity id which the file belongs to
   */
  @visibility(Lifecycle.Read)
  hostEntityId?: string;
}

/**
 * Represents a file hash entity.
 */
model FileHashEntity extends Entity {
  /**
   * FileHash entity properties
   */
  properties?: FileHashEntityProperties;

  /**
   * The kind of the entity.
   */
  kind: "FileHash";
}

/**
 * FileHash entity property bag.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model FileHashEntityProperties extends EntityCommonProperties {
  /**
   * The hash algorithm type.
   */
  @visibility(Lifecycle.Read)
  algorithm?: FileHashAlgorithm;

  /**
   * The file hash value.
   */
  @visibility(Lifecycle.Read)
  hashValue?: string;
}

/**
 * The geo-location context attached to the ip entity
 */
model GeoLocation {
  /**
   * Autonomous System Number
   */
  @visibility(Lifecycle.Read)
  asn?: int32;

  /**
   * City name
   */
  @visibility(Lifecycle.Read)
  city?: string;

  /**
   * The country code according to ISO 3166 format
   */
  @visibility(Lifecycle.Read)
  countryCode?: string;

  /**
   * Country name according to ISO 3166 Alpha 2: the lowercase of the English Short Name
   */
  @visibility(Lifecycle.Read)
  countryName?: string;

  /**
   * The longitude of the identified location, expressed as a floating point number with range of -180 to 180, with positive numbers representing East and negative numbers representing West. Latitude and longitude are derived from the city or postal code.
   */
  @visibility(Lifecycle.Read)
  latitude?: float64;

  /**
   * The latitude of the identified location, expressed as a floating point number with range of - 90 to 90, with positive numbers representing North and negative numbers representing South. Latitude and longitude are derived from the city or postal code.
   */
  @visibility(Lifecycle.Read)
  longitude?: float64;

  /**
   * State name
   */
  @visibility(Lifecycle.Read)
  state?: string;
}

/**
 * Represents a host entity.
 */
model HostEntity extends Entity {
  /**
   * Host entity properties
   */
  properties?: HostEntityProperties;

  /**
   * The kind of the entity.
   */
  kind: "Host";
}

/**
 * Host entity property bag.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model HostEntityProperties extends EntityCommonProperties {
  /**
   * The azure resource id of the VM.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
  @visibility(Lifecycle.Read)
  azureID?: string;

  /**
   * The DNS domain that this host belongs to. Should contain the compete DNS suffix for the domain
   */
  @visibility(Lifecycle.Read)
  dnsDomain?: string;

  /**
   * The hostname without the domain suffix.
   */
  @visibility(Lifecycle.Read)
  hostName?: string;

  /**
   * Determines whether this host belongs to a domain.
   */
  @visibility(Lifecycle.Read)
  isDomainJoined?: boolean;

  /**
   * The host name (pre-windows2000).
   */
  @visibility(Lifecycle.Read)
  netBiosName?: string;

  /**
   * The NT domain that this host belongs to.
   */
  @visibility(Lifecycle.Read)
  ntDomain?: string;

  /**
   * The OMS agent id, if the host has OMS agent installed.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
  @visibility(Lifecycle.Read)
  omsAgentID?: string;

  /**
   * The operating system type.
   */
  osFamily?: OSFamily;

  /**
   * A free text representation of the operating system. This field is meant to hold specific versions the are more fine grained than OSFamily or future values not supported by OSFamily enumeration
   */
  @visibility(Lifecycle.Read)
  osVersion?: string;
}

/**
 * Represents an IoT device entity.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
model IoTDeviceEntity extends Entity {
  /**
   * IoTDevice entity properties
   */
  properties?: IoTDeviceEntityProperties;

  /**
   * The kind of the entity.
   */
  kind: "IoTDevice";
}

/**
 * IoTDevice entity property bag.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
model IoTDeviceEntityProperties extends EntityCommonProperties {
  /**
   * The ID of the IoT Device in the IoT Hub
   */
  @visibility(Lifecycle.Read)
  deviceId?: string;

  /**
   * The friendly name of the device
   */
  @visibility(Lifecycle.Read)
  deviceName?: string;

  /**
   * The source of the device
   */
  @visibility(Lifecycle.Read)
  source?: string;

  /**
   * The ID of the security agent running on the device
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @visibility(Lifecycle.Read)
  @format("uuid")
  iotSecurityAgentId?: string;

  /**
   * The type of the device
   */
  @visibility(Lifecycle.Read)
  deviceType?: string;

  /**
   * The vendor of the device
   */
  @visibility(Lifecycle.Read)
  vendor?: string;

  /**
   * The ID of the edge device
   */
  @visibility(Lifecycle.Read)
  edgeId?: string;

  /**
   * The MAC address of the device
   */
  @visibility(Lifecycle.Read)
  macAddress?: string;

  /**
   * The model of the device
   */
  @visibility(Lifecycle.Read)
  `model`?: string;

  /**
   * The serial number of the device
   */
  @visibility(Lifecycle.Read)
  serialNumber?: string;

  /**
   * The firmware version of the device
   */
  @visibility(Lifecycle.Read)
  firmwareVersion?: string;

  /**
   * The operating system of the device
   */
  @visibility(Lifecycle.Read)
  operatingSystem?: string;

  /**
   * The AzureResource entity id of the IoT Hub
   */
  @visibility(Lifecycle.Read)
  iotHubEntityId?: string;

  /**
   * The Host entity id of this device
   */
  @visibility(Lifecycle.Read)
  hostEntityId?: string;

  /**
   * The IP entity if of this device
   */
  @visibility(Lifecycle.Read)
  ipAddressEntityId?: string;

  /**
   * A list of TI contexts attached to the IoTDevice entity.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  threatIntelligence?: ThreatIntelligence[];

  /**
   * A list of protocols of the IoTDevice entity.
   */
  @visibility(Lifecycle.Read)
  protocols?: string[];
}

/**
 * ThreatIntelligence property bag.
 */
model ThreatIntelligence {
  /**
   * Confidence (must be between 0 and 1)
   */
  @visibility(Lifecycle.Read)
  confidence?: float64;

  /**
   * Name of the provider from whom this Threat Intelligence information was received
   */
  @visibility(Lifecycle.Read)
  providerName?: string;

  /**
   * Report link
   */
  @visibility(Lifecycle.Read)
  reportLink?: string;

  /**
   * Threat description (free text)
   */
  @visibility(Lifecycle.Read)
  threatDescription?: string;

  /**
   * Threat name (e.g. "Jedobot malware")
   */
  @visibility(Lifecycle.Read)
  threatName?: string;

  /**
   * Threat type (e.g. "Botnet")
   */
  @visibility(Lifecycle.Read)
  threatType?: string;
}

/**
 * Represents an ip entity.
 */
model IpEntity extends Entity {
  /**
   * Ip entity properties
   */
  properties?: IpEntityProperties;

  /**
   * The kind of the entity.
   */
  kind: "Ip";
}

/**
 * Ip entity property bag.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model IpEntityProperties extends EntityCommonProperties {
  /**
   * The IP address as string, e.g. 127.0.0.1 (either in Ipv4 or Ipv6)
   */
  @visibility(Lifecycle.Read)
  address?: string;

  /**
   * The geo-location context attached to the ip entity
   */
  @visibility(Lifecycle.Read)
  location?: GeoLocation;

  /**
   * A list of TI contexts attached to the ip entity.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  threatIntelligence?: ThreatIntelligence[];
}

/**
 * Represents a mailbox entity.
 */
model MailboxEntity extends Entity {
  /**
   * Mailbox entity properties
   */
  properties?: MailboxEntityProperties;

  /**
   * The kind of the entity.
   */
  kind: "Mailbox";
}

/**
 * Mailbox entity property bag.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model MailboxEntityProperties extends EntityCommonProperties {
  /**
   * The mailbox's primary address
   */
  @visibility(Lifecycle.Read)
  mailboxPrimaryAddress?: string;

  /**
   * The mailbox's display name
   */
  @visibility(Lifecycle.Read)
  displayName?: string;

  /**
   * The mailbox's UPN
   */
  @visibility(Lifecycle.Read)
  upn?: string;

  /**
   * The AzureAD identifier of mailbox. Similar to AadUserId in account entity but this property is specific to mailbox object on office side
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @visibility(Lifecycle.Read)
  @format("uuid")
  externalDirectoryObjectId?: string;
}

/**
 * Represents a mail cluster entity.
 */
model MailClusterEntity extends Entity {
  /**
   * Mail cluster entity properties
   */
  properties?: MailClusterEntityProperties;

  /**
   * The kind of the entity.
   */
  kind: "MailCluster";
}

/**
 * Mail cluster entity property bag.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model MailClusterEntityProperties extends EntityCommonProperties {
  /**
   * The mail message IDs that are part of the mail cluster
   */
  @visibility(Lifecycle.Read)
  networkMessageIds?: string[];

  /**
   * Count of mail messages by DeliveryStatus string representation
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "For backward compatibility"
  @visibility(Lifecycle.Read)
  countByDeliveryStatus?: unknown;

  /**
   * Count of mail messages by ThreatType string representation
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "For backward compatibility"
  @visibility(Lifecycle.Read)
  countByThreatType?: unknown;

  /**
   * Count of mail messages by ProtectionStatus string representation
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "For backward compatibility"
  @visibility(Lifecycle.Read)
  countByProtectionStatus?: unknown;

  /**
   * The threats of mail messages that are part of the mail cluster
   */
  @visibility(Lifecycle.Read)
  threats?: string[];

  /**
   * The query that was used to identify the messages of the mail cluster
   */
  @visibility(Lifecycle.Read)
  query?: string;

  /**
   * The query time
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  queryTime?: utcDateTime;

  /**
   * The number of mail messages that are part of the mail cluster
   */
  @visibility(Lifecycle.Read)
  mailCount?: int32;

  /**
   * Is this a volume anomaly mail cluster
   */
  @visibility(Lifecycle.Read)
  isVolumeAnomaly?: boolean;

  /**
   * The source of the mail cluster (default is 'O365 ATP')
   */
  @visibility(Lifecycle.Read)
  source?: string;

  /**
   * The id of the cluster source
   */
  @visibility(Lifecycle.Read)
  clusterSourceIdentifier?: string;

  /**
   * The type of the cluster source
   */
  @visibility(Lifecycle.Read)
  clusterSourceType?: string;

  /**
   * The cluster query start time
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  clusterQueryStartTime?: utcDateTime;

  /**
   * The cluster query end time
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  clusterQueryEndTime?: utcDateTime;

  /**
   * The cluster group
   */
  @visibility(Lifecycle.Read)
  clusterGroup?: string;
}

/**
 * Represents a mail message entity.
 */
model MailMessageEntity extends Entity {
  /**
   * Mail message entity properties
   */
  properties?: MailMessageEntityProperties;

  /**
   * The kind of the entity.
   */
  kind: "MailMessage";
}

/**
 * Mail message entity property bag.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model MailMessageEntityProperties extends EntityCommonProperties {
  /**
   * The File entity ids of this mail message's attachments
   */
  @visibility(Lifecycle.Read)
  fileEntityIds?: string[];

  /**
   * The recipient of this mail message. Note that in case of multiple recipients the mail message is forked and each copy has one recipient
   */
  @visibility(Lifecycle.Read)
  recipient?: string;

  /**
   * The Urls contained in this mail message
   */
  @visibility(Lifecycle.Read)
  urls?: string[];

  /**
   * The threats of this mail message
   */
  @visibility(Lifecycle.Read)
  threats?: string[];

  /**
   * The p1 sender's email address
   */
  @visibility(Lifecycle.Read)
  p1Sender?: string;

  /**
   * The p1 sender's display name
   */
  @visibility(Lifecycle.Read)
  p1SenderDisplayName?: string;

  /**
   * The p1 sender's domain
   */
  @visibility(Lifecycle.Read)
  p1SenderDomain?: string;

  /**
   * The sender's IP address
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
  @visibility(Lifecycle.Read)
  senderIP?: string;

  /**
   * The p2 sender's email address
   */
  @visibility(Lifecycle.Read)
  p2Sender?: string;

  /**
   * The p2 sender's display name
   */
  @visibility(Lifecycle.Read)
  p2SenderDisplayName?: string;

  /**
   * The p2 sender's domain
   */
  @visibility(Lifecycle.Read)
  p2SenderDomain?: string;

  /**
   * The receive date of this message
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  receiveDate?: utcDateTime;

  /**
   * The network message id of this mail message
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @visibility(Lifecycle.Read)
  @format("uuid")
  networkMessageId?: string;

  /**
   * The internet message id of this mail message
   */
  @visibility(Lifecycle.Read)
  internetMessageId?: string;

  /**
   * The subject of this mail message
   */
  @visibility(Lifecycle.Read)
  subject?: string;

  /**
   * The language of this mail message
   */
  @visibility(Lifecycle.Read)
  language?: string;

  /**
   * The threat detection methods
   */
  @visibility(Lifecycle.Read)
  threatDetectionMethods?: string[];

  /**
   * The bodyFingerprintBin1
   */
  bodyFingerprintBin1?: int32;

  /**
   * The bodyFingerprintBin2
   */
  bodyFingerprintBin2?: int32;

  /**
   * The bodyFingerprintBin3
   */
  bodyFingerprintBin3?: int32;

  /**
   * The bodyFingerprintBin4
   */
  bodyFingerprintBin4?: int32;

  /**
   * The bodyFingerprintBin5
   */
  bodyFingerprintBin5?: int32;

  /**
   * The directionality of this mail message
   */
  antispamDirection?: AntispamMailDirection;

  /**
   * The delivery action of this mail message like Delivered, Blocked, Replaced etc
   */
  deliveryAction?: DeliveryAction;

  /**
   * The delivery location of this mail message like Inbox, JunkFolder etc
   */
  deliveryLocation?: DeliveryLocation;
}

/**
 * Represents a malware entity.
 */
model MalwareEntity extends Entity {
  /**
   * File entity properties
   */
  properties?: MalwareEntityProperties;

  /**
   * The kind of the entity.
   */
  kind: "Malware";
}

/**
 * Malware entity property bag.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model MalwareEntityProperties extends EntityCommonProperties {
  /**
   * The malware category by the vendor, e.g. Trojan
   */
  @visibility(Lifecycle.Read)
  category?: string;

  /**
   * List of linked file entity identifiers on which the malware was found
   */
  @visibility(Lifecycle.Read)
  fileEntityIds?: string[];

  /**
   * The malware name by the vendor, e.g. Win32/Toga!rfn
   */
  @visibility(Lifecycle.Read)
  malwareName?: string;

  /**
   * List of linked process entity identifiers on which the malware was found.
   */
  @visibility(Lifecycle.Read)
  processEntityIds?: string[];
}

/**
 * Represents a process entity.
 */
model ProcessEntity extends Entity {
  /**
   * Process entity properties
   */
  properties?: ProcessEntityProperties;

  /**
   * The kind of the entity.
   */
  kind: "Process";
}

/**
 * Process entity property bag.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ProcessEntityProperties extends EntityCommonProperties {
  /**
   * The account entity id running the processes.
   */
  @visibility(Lifecycle.Read)
  accountEntityId?: string;

  /**
   * The command line used to create the process
   */
  @visibility(Lifecycle.Read)
  commandLine?: string;

  /**
   * The time when the process started to run
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTimeUtc?: utcDateTime;

  /**
   * The elevation token associated with the process.
   */
  elevationToken?: ElevationToken;

  /**
   * The host entity id on which the process was running
   */
  @visibility(Lifecycle.Read)
  hostEntityId?: string;

  /**
   * The session entity id in which the process was running
   */
  @visibility(Lifecycle.Read)
  hostLogonSessionEntityId?: string;

  /**
   * Image file entity id
   */
  @visibility(Lifecycle.Read)
  imageFileEntityId?: string;

  /**
   * The parent process entity id.
   */
  @visibility(Lifecycle.Read)
  parentProcessEntityId?: string;

  /**
   * The process ID
   */
  @visibility(Lifecycle.Read)
  processId?: string;
}

/**
 * Represents a registry key entity.
 */
model RegistryKeyEntity extends Entity {
  /**
   * RegistryKey entity properties
   */
  properties?: RegistryKeyEntityProperties;

  /**
   * The kind of the entity.
   */
  kind: "RegistryKey";
}

/**
 * RegistryKey entity property bag.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model RegistryKeyEntityProperties extends EntityCommonProperties {
  /**
   * the hive that holds the registry key.
   */
  @visibility(Lifecycle.Read)
  hive?: RegistryHive;

  /**
   * The registry key path.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "For backward compatibility"
  @visibility(Lifecycle.Read)
  key?: string;
}

/**
 * Represents a registry value entity.
 */
model RegistryValueEntity extends Entity {
  /**
   * RegistryKey entity properties
   */
  properties?: RegistryValueEntityProperties;

  /**
   * The kind of the entity.
   */
  kind: "RegistryValue";
}

/**
 * RegistryValue entity property bag.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model RegistryValueEntityProperties extends EntityCommonProperties {
  /**
   * The registry key entity id.
   */
  @visibility(Lifecycle.Read)
  keyEntityId?: string;

  /**
   * String formatted representation of the value data.
   */
  @visibility(Lifecycle.Read)
  valueData?: string;

  /**
   * The registry value name.
   */
  @visibility(Lifecycle.Read)
  valueName?: string;

  /**
   * Specifies the data types to use when storing values in the registry, or identifies the data type of a value in the registry.
   */
  @visibility(Lifecycle.Read)
  valueType?: RegistryValueKind;
}

/**
 * Represents a security group entity.
 */
model SecurityGroupEntity extends Entity {
  /**
   * SecurityGroup entity properties
   */
  properties?: SecurityGroupEntityProperties;

  /**
   * The kind of the entity.
   */
  kind: "SecurityGroup";
}

/**
 * SecurityGroup entity property bag.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model SecurityGroupEntityProperties extends EntityCommonProperties {
  /**
   * The group distinguished name
   */
  @visibility(Lifecycle.Read)
  distinguishedName?: string;

  /**
   * A single-value attribute that is the unique identifier for the object, assigned by active directory.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @visibility(Lifecycle.Read)
  @format("uuid")
  objectGuid?: string;

  /**
   * The SID attribute is a single-value attribute that specifies the security identifier (SID) of the group
   */
  @visibility(Lifecycle.Read)
  sid?: string;
}

/**
 * Represents a submission mail entity.
 */
model SubmissionMailEntity extends Entity {
  /**
   * Submission mail entity properties
   */
  properties?: SubmissionMailEntityProperties;

  /**
   * The kind of the entity.
   */
  kind: "SubmissionMail";
}

/**
 * Submission mail entity property bag.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model SubmissionMailEntityProperties extends EntityCommonProperties {
  /**
   * The network message id of email to which submission belongs
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @visibility(Lifecycle.Read)
  @format("uuid")
  networkMessageId?: string;

  /**
   * The submission id
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @visibility(Lifecycle.Read)
  @format("uuid")
  submissionId?: string;

  /**
   * The submitter
   */
  @visibility(Lifecycle.Read)
  submitter?: string;

  /**
   * The submission date
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  submissionDate?: utcDateTime;

  /**
   * The Time stamp when the message is received (Mail)
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timestamp?: utcDateTime;

  /**
   * The recipient of the mail
   */
  @visibility(Lifecycle.Read)
  recipient?: string;

  /**
   * The sender of the mail
   */
  @visibility(Lifecycle.Read)
  sender?: string;

  /**
   * The sender's IP
   */
  @visibility(Lifecycle.Read)
  senderIp?: string;

  /**
   * The subject of submission mail
   */
  @visibility(Lifecycle.Read)
  subject?: string;

  /**
   * The submission type for the given instance. This maps to Junk, Phish, Malware or NotJunk.
   */
  @visibility(Lifecycle.Read)
  reportType?: string;
}

/**
 * Represents a url entity.
 */
model UrlEntity extends Entity {
  /**
   * Url entity properties
   */
  properties?: UrlEntityProperties;

  /**
   * The kind of the entity.
   */
  kind: "Url";
}

/**
 * Url entity property bag.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model UrlEntityProperties extends EntityCommonProperties {
  /**
   * A full URL the entity points to
   */
  @visibility(Lifecycle.Read)
  url?: string;
}

/**
 * Lists the operations available in the SecurityInsights RP.
 */
model OperationsList {
  /**
   * URL to fetch the next set of operations.
   */
  @visibility(Lifecycle.Read)
  @nextLink
  nextLink?: string;

  /**
   * Array of operations
   */
  @identifiers(#[])
  @pageItems
  value: Operation[];
}
