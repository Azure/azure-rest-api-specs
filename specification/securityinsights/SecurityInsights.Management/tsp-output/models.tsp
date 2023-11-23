import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.SecurityInsights;

interface Operations extends Azure.ResourceManager.Operations {}

enum AlertRuleKind {
  Scheduled,
  MicrosoftSecurityIncidentCreation,
  Fusion,
  MLBehaviorAnalytics,
  ThreatIntelligence,
  NRT,
}

enum CreatedByType {
  User,
  Application,
  ManagedIdentity,
  Key,
}

enum TriggersOn {
  @doc("Trigger on Incidents") Incidents,
  @doc("Trigger on Alerts") Alerts,
}

enum TriggersWhen {
  @doc("Trigger on created objects") Created,
  @doc("Trigger on updated objects") Updated,
}

enum ConditionType {
  @doc("Evaluate an object property value") Property,
  @doc("Evaluate an object array property value") PropertyArray,
  @doc("Evaluate an object property changed value") PropertyChanged,
  @doc("Evaluate an object array property changed value") PropertyArrayChanged,
  @doc("Apply a boolean operator (e.g AND, OR) to conditions") Boolean,
}

enum ActionType {
  @doc("Modify an object's properties") ModifyProperties,
  @doc("Run a playbook on an object") RunPlaybook,
  @doc("Add a task to an incident object") AddIncidentTask,
}

enum IncidentSeverity {
  @doc("High severity") High,
  @doc("Medium severity") Medium,
  @doc("Low severity") Low,
  @doc("Informational severity") Informational,
}

enum AttackTactic {
  Reconnaissance,
  ResourceDevelopment,
  InitialAccess,
  Execution,
  Persistence,
  PrivilegeEscalation,
  DefenseEvasion,
  CredentialAccess,
  Discovery,
  LateralMovement,
  Collection,
  Exfiltration,
  CommandAndControl,
  Impact,
  PreAttack,
  ImpairProcessControl,
  InhibitResponseFunction,
}

enum EntityKind {
  @doc("Entity represents account in the system.") Account,
  @doc("Entity represents host in the system.") Host,
  @doc("Entity represents file in the system.") File,
  @doc("Entity represents azure resource in the system.") AzureResource,
  @doc("Entity represents cloud application in the system.") CloudApplication,
  @doc("Entity represents dns resolution in the system.") DnsResolution,
  @doc("Entity represents file hash in the system.") FileHash,
  @doc("Entity represents ip in the system.") Ip,
  @doc("Entity represents malware in the system.") Malware,
  @doc("Entity represents process in the system.") Process,
  @doc("Entity represents registry key in the system.") RegistryKey,
  @doc("Entity represents registry value in the system.") RegistryValue,
  @doc("Entity represents security group in the system.") SecurityGroup,
  @doc("Entity represents url in the system.") Url,
  @doc("Entity represents IoT device in the system.") IoTDevice,
  @doc("Entity represents security alert in the system.") SecurityAlert,
  @doc("Entity represents bookmark in the system.") Bookmark,
  @doc("Entity represents mail cluster in the system.") MailCluster,
  @doc("Entity represents mail message in the system.") MailMessage,
  @doc("Entity represents mailbox in the system.") Mailbox,
  @doc("Entity represents submission mail in the system.") SubmissionMail,
  @doc("Entity represents network interface in the system.") Nic,
}

enum EntityTimelineKind {
  @doc("activity") Activity,
  @doc("bookmarks") Bookmark,
  @doc("security alerts") SecurityAlert,
  @doc("anomaly") Anomaly,
}

enum EntityItemQueryKind {
  @doc("insight") Insight,
}

enum EntityQueryKind {
  Expansion,
  Insight,
  Activity,
}

enum GetInsightsError {
  Insight,
}

enum ComponentsL8W718ParametersEntityquerykindSchema {
  Expansion,
  Activity,
}

enum CustomEntityQueryKind {
  Activity,
}

enum Components9D9QekParametersEntityquerytemplatekindSchema {
  Activity,
}

enum EntityQueryTemplateKind {
  Activity,
}

enum IngestionMode {
  @doc("No records should be ingested when invalid records are detected.")
  IngestOnlyIfAllAreValid,
  @doc("Valid records should still be ingested when invalid records are detected.")
  IngestAnyValidRecords,
  @doc("Unspecified") Unspecified,
}

enum FileImportContentType {
  @doc("File containing records with the core fields of an indicator, plus the observables to construct the STIX pattern.")
  BasicIndicator,
  @doc("File containing STIX indicators.") StixIndicator,
  @doc("File containing other records.") Unspecified,
}

enum FileFormat {
  @doc("A CSV file.") CSV,
  @doc("A JSON file.") JSON,
  @doc("A file of other format.") Unspecified,
}

enum DeleteStatus {
  @doc("The file was deleted.") Deleted,
  @doc("The file was not deleted.") NotDeleted,
  @doc("Unspecified") Unspecified,
}

enum FileImportState {
  @doc("A fatal error has occurred while ingesting the file.") FatalError,
  @doc("The file has been ingested.") Ingested,
  @doc("The file has been ingested with errors.") IngestedWithErrors,
  @doc("The file ingestion is in progress.") InProgress,
  @doc("The file is invalid.") Invalid,
  @doc("Waiting for the file to be uploaded.") WaitingForUpload,
  @doc("Unspecified state.") Unspecified,
}

enum IncidentStatus {
  @doc("An active incident which isn't being handled currently") New,
  @doc("An active incident which is being handled") Active,
  @doc("A non-active incident") Closed,
}

enum IncidentClassification {
  @doc("Incident classification was undetermined") Undetermined,
  @doc("Incident was true positive") TruePositive,
  @doc("Incident was benign positive") BenignPositive,
  @doc("Incident was false positive") FalsePositive,
}

enum IncidentClassificationReason {
  @doc("Classification reason was suspicious activity") SuspiciousActivity,
  @doc("Classification reason was suspicious but expected")
  SuspiciousButExpected,
  @doc("Classification reason was incorrect alert logic") IncorrectAlertLogic,
  @doc("Classification reason was inaccurate data") InaccurateData,
}

enum OwnerType {
  @doc("The incident owner type is unknown") Unknown,
  @doc("The incident owner type is an AAD user") User,
  @doc("The incident owner type is an AAD group") Group,
}

enum IncidentLabelType {
  @doc("Label manually created by a user") User,
  @doc("Label automatically created by the system") AutoAssigned,
}

enum ConfidenceLevel {
  @doc("Unknown confidence, the is the default value") Unknown,
  @doc("Low confidence, meaning we have some doubts this is indeed malicious or part of an attack")
  Low,
  @doc("High confidence that the alert is true positive malicious") High,
}

enum ConfidenceScoreStatus {
  @doc("Score will not be calculated for this alert as it is not supported by virtual analyst")
  NotApplicable,
  @doc("No score was set yet and calculation is in progress") InProcess,
  @doc("Score is calculated and shown as part of the alert, but may be updated again at a later time following the processing of additional data")
  NotFinal,
  @doc("Final score was calculated and available") Final,
}

enum KillChainIntent {
  @doc("The default value.") Unknown,
  @doc("Probing could be an attempt to access a certain resource regardless of a malicious intent or a failed attempt to gain access to a target system to gather information prior to exploitation. This step is usually detected as an attempt originating from outside the network in attempt to scan the target system and find a way in.")
  Probing,
  @doc("Exploitation is the stage where an attacker manage to get foothold on the attacked resource. This stage is applicable not only for compute hosts, but also for resources such as user accounts, certificates etc. Adversaries will often be able to control the resource after this stage.")
  Exploitation,
  @doc("Persistence is any access, action, or configuration change to a system that gives an adversary a persistent presence on that system. Adversaries will often need to maintain access to systems through interruptions such as system restarts, loss of credentials, or other failures that would require a remote access tool to restart or alternate backdoor for them to regain access.")
  Persistence,
  @doc("Privilege escalation is the result of actions that allow an adversary to obtain a higher level of permissions on a system or network. Certain tools or actions require a higher level of privilege to work and are likely necessary at many points throughout an operation. User accounts with permissions to access specific systems or perform specific functions necessary for adversaries to achieve their objective may also be considered an escalation of privilege.")
  PrivilegeEscalation,
  @doc("Defense evasion consists of techniques an adversary may use to evade detection or avoid other defenses. Sometimes these actions are the same as or variations of techniques in other categories that have the added benefit of subverting a particular defense or mitigation. ")
  DefenseEvasion,
  @doc("Credential access represents techniques resulting in access to or control over system, domain, or service credentials that are used within an enterprise environment. Adversaries will likely attempt to obtain legitimate credentials from users or administrator accounts (local system administrator or domain users with administrator access) to use within the network. With sufficient access within a network, an adversary can create accounts for later use within the environment.")
  CredentialAccess,
  @doc("Discovery consists of techniques that allow the adversary to gain knowledge about the system and internal network. When adversaries gain access to a new system, they must orient themselves to what they now have control of and what benefits operating from that system give to their current objective or overall goals during the intrusion. The operating system provides many native tools that aid in this post-compromise information-gathering phase.")
  Discovery,
  @doc("Lateral movement consists of techniques that enable an adversary to access and control remote systems on a network and could, but does not necessarily, include execution of tools on remote systems. The lateral movement techniques could allow an adversary to gather information from a system without needing additional tools, such as a remote access tool. An adversary can use lateral movement for many purposes, including remote Execution of tools, pivoting to additional systems, access to specific information or files, access to additional credentials, or to cause an effect.")
  LateralMovement,
  @doc("The execution tactic represents techniques that result in execution of adversary-controlled code on a local or remote system. This tactic is often used in conjunction with lateral movement to expand access to remote systems on a network.")
  Execution,
  @doc("Collection consists of techniques used to identify and gather information, such as sensitive files, from a target network prior to exfiltration. This category also covers locations on a system or network where the adversary may look for information to exfiltrate.")
  Collection,
  @doc("Exfiltration refers to techniques and attributes that result or aid in the adversary removing files and information from a target network. This category also covers locations on a system or network where the adversary may look for information to exfiltrate.")
  Exfiltration,
  @doc("The command and control tactic represents how adversaries communicate with systems under their control within a target network.")
  CommandAndControl,
  @doc("The impact intent primary objective is to directly reduce the availability or integrity of a system, service, or network; including manipulation of data to impact a business or operational process. This would often refer to techniques such as ransom-ware, defacement, data manipulation and others.")
  Impact,
}

enum AlertSeverity {
  @doc("High severity") High,
  @doc("Medium severity") Medium,
  @doc("Low severity") Low,
  @doc("Informational severity") Informational,
}

enum AlertStatus {
  @doc("Unknown value") Unknown,
  @doc("New alert") New,
  @doc("Alert closed after handling") Resolved,
  @doc("Alert dismissed as false positive") Dismissed,
  @doc("Alert is being handled") InProgress,
}

enum IncidentTaskStatus {
  @doc("A new task") New,
  @doc("A completed task") Completed,
}

enum Kind {
  DataConnector,
  DataType,
  Workbook,
  WorkbookTemplate,
  Playbook,
  PlaybookTemplate,
  AnalyticsRuleTemplate,
  AnalyticsRule,
  HuntingQuery,
  InvestigationQuery,
  Parser,
  Watchlist,
  WatchlistTemplate,
  Solution,
  AzureFunction,
  LogicAppsCustomConnector,
  AutomationRule,
}

enum SourceKind {
  LocalWorkspace,
  Community,
  Solution,
  SourceRepository,
}

enum SupportTier {
  Microsoft,
  Partner,
  Community,
}

enum Operator {
  AND,
  OR,
}

enum Category {
  @doc("Onboarding recommendation.") Onboarding,
  @doc("New feature recommendation.") NewFeature,
  @doc("Soc Efficiency recommendation.") SocEfficiency,
  @doc("Cost optimization recommendation.") CostOptimization,
  @doc("Demo recommendation.") Demo,
}

enum Context {
  @doc("Analytics context.") Analytics,
  @doc("Incidents context.") Incidents,
  @doc("Overview context.") Overview,
  @doc("No context.") None,
}

enum Priority {
  @doc("Low priority for recommendation.") Low,
  @doc("Medium priority for recommendation.") Medium,
  @doc("High priority for recommendation.") High,
}

enum State {
  @doc("Recommendation is active.") Active,
  @doc("Recommendation is disabled.") Disabled,
  @doc("Recommendation has been completed by user.") CompletedByUser,
  @doc("Recommendation has been completed by action.") CompletedByAction,
  @doc("Recommendation is hidden.") Hidden,
}

enum SecurityMLAnalyticsSettingsKind {
  Anomaly,
}

enum SettingKind {
  Anomalies,
  EyesOn,
  EntityAnalytics,
  Ueba,
}

enum RepoType {
  Github,
  DevOps,
}

enum Version {
  V1,
  V2,
}

enum ContentType {
  AnalyticRule,
  Workbook,
}

enum DeploymentFetchStatus {
  Success,
  Unauthorized,
  NotFound,
}

enum DeploymentState {
  In_Progress,
  Completed,
  Queued,
  Canceling,
}

enum DeploymentResult {
  Success,
  Canceled,
  Failed,
}

enum ThreatIntelligenceResourceKindEnum {
  @doc("Entity represents threat intelligence indicator in the system.")
  indicator,
}

enum ThreatIntelligenceSortingCriteriaEnum {
  unsorted,
  ascending,
  descending,
}

enum SourceType {
  `Local file`,
  `Remote storage`,
}

enum DataConnectorKind {
  AzureActiveDirectory,
  AzureSecurityCenter,
  MicrosoftCloudAppSecurity,
  ThreatIntelligence,
  ThreatIntelligenceTaxii,
  Office365,
  OfficeATP,
  OfficeIRM,
  Office365Project,
  OfficePowerBI,
  AmazonWebServicesCloudTrail,
  AmazonWebServicesS3,
  AzureAdvancedThreatProtection,
  MicrosoftDefenderAdvancedThreatProtection,
  Dynamics365,
  MicrosoftThreatProtection,
  MicrosoftThreatIntelligence,
  GenericUI,
  APIPolling,
  IOT,
}

enum ConnectAuthKind {
  Basic,
  OAuth2,
  APIKey,
}

enum DataConnectorAuthorizationState {
  Valid,
  Invalid,
}

enum DataConnectorLicenseState {
  Valid,
  Invalid,
  Unknown,
}

enum TemplateStatus {
  @doc("Alert rule template installed. and can not use more then once")
  Installed,
  @doc("Alert rule template is available.") Available,
  @doc("Alert rule template is not available") NotAvailable,
}

enum EntityMappingType {
  @doc("User account entity type") Account,
  @doc("Host entity type") Host,
  @doc("IP address entity type") IP,
  @doc("Malware entity type") Malware,
  @doc("System file entity type") File,
  @doc("Process entity type") Process,
  @doc("Cloud app entity type") CloudApplication,
  @doc("DNS entity type") DNS,
  @doc("Azure resource entity type") AzureResource,
  @doc("File-hash entity type") FileHash,
  @doc("Registry key entity type") RegistryKey,
  @doc("Registry value entity type") RegistryValue,
  @doc("Security group entity type") SecurityGroup,
  @doc("URL entity type") URL,
  @doc("Mailbox entity type") Mailbox,
  @doc("Mail cluster entity type") MailCluster,
  @doc("Mail message entity type") MailMessage,
  @doc("Submission mail entity type") SubmissionMail,
}

enum AlertProperty {
  @doc("Alert's link") AlertLink,
  @doc("Confidence level property") ConfidenceLevel,
  @doc("Confidence score") ConfidenceScore,
  @doc("Extended links to the alert") ExtendedLinks,
  @doc("Product name alert property") ProductName,
  @doc("Provider name alert property") ProviderName,
  @doc("Product component name alert property") ProductComponentName,
  @doc("Remediation steps alert property") RemediationSteps,
  @doc("Techniques alert property") Techniques,
}

enum EventGroupingAggregationKind {
  SingleAlert,
  AlertPerResult,
}

enum MicrosoftSecurityProductName {
  `Microsoft Cloud App Security`,
  `Azure Security Center`,
  `Azure Advanced Threat Protection`,
  `Azure Active Directory Identity Protection`,
  `Azure Security Center for IoT`,
  `Office 365 Advanced Threat Protection`,
  `Microsoft Defender Advanced Threat Protection`,
}

enum MatchingMethod {
  @doc("Grouping alerts into a single incident if all the entities match")
  AllEntities,
  @doc("Grouping any alerts triggered by this rule into a single incident")
  AnyAlert,
  @doc("Grouping alerts into a single incident if the selected entities, custom details and alert details match")
  Selected,
}

enum AlertDetail {
  @doc("Alert display name") DisplayName,
  @doc("Alert severity") Severity,
}

enum AutomationRuleBooleanConditionSupportedOperator {
  @doc("Evaluates as true if all the item conditions are evaluated as true")
  And,
  @doc("Evaluates as true if at least one of the item conditions are evaluated as true")
  Or,
}

enum AutomationRulePropertyArrayChangedConditionSupportedArrayType {
  @doc("Evaluate the condition on the alerts") Alerts,
  @doc("Evaluate the condition on the labels") Labels,
  @doc("Evaluate the condition on the tactics") Tactics,
  @doc("Evaluate the condition on the comments") Comments,
}

enum AutomationRulePropertyArrayChangedConditionSupportedChangeType {
  @doc("Evaluate the condition on items added to the array") Added,
}

enum AutomationRulePropertyArrayConditionSupportedArrayType {
  @doc("Evaluate the condition on the custom detail keys") CustomDetails,
  @doc("Evaluate the condition on a custom detail's values") CustomDetailValues,
}

enum AutomationRulePropertyArrayConditionSupportedArrayConditionType {
  @doc("Evaluate the condition as true if any item fulfills it") AnyItem,
}

enum AutomationRulePropertyChangedConditionSupportedPropertyType {
  @doc("Evaluate the condition on the incident severity") IncidentSeverity,
  @doc("Evaluate the condition on the incident status") IncidentStatus,
  @doc("Evaluate the condition on the incident owner") IncidentOwner,
}

enum AutomationRulePropertyChangedConditionSupportedChangedType {
  @doc("Evaluate the condition on the previous value of the property")
  ChangedFrom,
  @doc("Evaluate the condition on the updated value of the property") ChangedTo,
}

enum AutomationRulePropertyConditionSupportedOperator {
  @doc("Evaluates if the property equals at least one of the condition values")
  Equals,
  @doc("Evaluates if the property does not equal any of the condition values")
  NotEquals,
  @doc("Evaluates if the property contains at least one of the condition values")
  Contains,
  @doc("Evaluates if the property does not contain any of the condition values")
  NotContains,
  @doc("Evaluates if the property starts with any of the condition values")
  StartsWith,
  @doc("Evaluates if the property does not start with any of the condition values")
  NotStartsWith,
  @doc("Evaluates if the property ends with any of the condition values")
  EndsWith,
  @doc("Evaluates if the property does not end with any of the condition values")
  NotEndsWith,
}

enum AutomationRulePropertyConditionSupportedProperty {
  @doc("The title of the incident") IncidentTitle,
  @doc("The description of the incident") IncidentDescription,
  @doc("The severity of the incident") IncidentSeverity,
  @doc("The status of the incident") IncidentStatus,
  @doc("The related Analytic rule ids of the incident")
  IncidentRelatedAnalyticRuleIds,
  @doc("The tactics of the incident") IncidentTactics,
  @doc("The labels of the incident") IncidentLabel,
  @doc("The provider name of the incident") IncidentProviderName,
  @doc("The update source of the incident") IncidentUpdatedBySource,
  @doc("The incident custom detail key") IncidentCustomDetailsKey,
  @doc("The incident custom detail value") IncidentCustomDetailsValue,
  @doc("The account Azure Active Directory tenant id") AccountAadTenantId,
  @doc("The account Azure Active Directory user id") AccountAadUserId,
  @doc("The account name") AccountName,
  @doc("The account NetBIOS domain name") AccountNTDomain,
  @doc("The account Azure Active Directory Passport User ID") AccountPUID,
  @doc("The account security identifier") AccountSid,
  @doc("The account unique identifier") AccountObjectGuid,
  @doc("The account user principal name suffix") AccountUPNSuffix,
  @doc("The name of the product of the alert") AlertProductNames,
  @doc("The analytic rule ids of the alert") AlertAnalyticRuleIds,
  @doc("The Azure resource id") AzureResourceResourceId,
  @doc("The Azure resource subscription id") AzureResourceSubscriptionId,
  @doc("The cloud application identifier") CloudApplicationAppId,
  @doc("The cloud application name") CloudApplicationAppName,
  @doc("The dns record domain name") DNSDomainName,
  @doc("The file directory full path") FileDirectory,
  @doc("The file name without path") FileName,
  @doc("The file hash value") FileHashValue,
  @doc("The host Azure resource id") HostAzureID,
  @doc("The host name without domain") HostName,
  @doc("The host NetBIOS name") HostNetBiosName,
  @doc("The host NT domain") HostNTDomain,
  @doc("The host operating system") HostOSVersion,
  @doc("\"The IoT device id") IoTDeviceId,
  @doc("The IoT device name") IoTDeviceName,
  @doc("The IoT device type") IoTDeviceType,
  @doc("The IoT device vendor") IoTDeviceVendor,
  @doc("The IoT device model") IoTDeviceModel,
  @doc("The IoT device operating system") IoTDeviceOperatingSystem,
  @doc("The IP address") IPAddress,
  @doc("The mailbox display name") MailboxDisplayName,
  @doc("The mailbox primary address") MailboxPrimaryAddress,
  @doc("The mailbox user principal name") MailboxUPN,
  @doc("The mail message delivery action") MailMessageDeliveryAction,
  @doc("The mail message delivery location") MailMessageDeliveryLocation,
  @doc("The mail message recipient") MailMessageRecipient,
  @doc("The mail message sender IP address") MailMessageSenderIP,
  @doc("The mail message subject") MailMessageSubject,
  @doc("The mail message P1 sender") MailMessageP1Sender,
  @doc("The mail message P2 sender") MailMessageP2Sender,
  @doc("The malware category") MalwareCategory,
  @doc("The malware name") MalwareName,
  @doc("The process execution command line") ProcessCommandLine,
  @doc("The process id") ProcessId,
  @doc("The registry key path") RegistryKey,
  @doc("The registry key value in string formatted representation")
  RegistryValueData,
  @doc("The url") Url,
}

enum EntityType {
  @doc("Entity represents account in the system.") Account,
  @doc("Entity represents host in the system.") Host,
  @doc("Entity represents file in the system.") File,
  @doc("Entity represents azure resource in the system.") AzureResource,
  @doc("Entity represents cloud application in the system.") CloudApplication,
  @doc("Entity represents dns in the system.") DNS,
  @doc("Entity represents file hash in the system.") FileHash,
  @doc("Entity represents ip in the system.") IP,
  @doc("Entity represents malware in the system.") Malware,
  @doc("Entity represents process in the system.") Process,
  @doc("Entity represents registry key in the system.") RegistryKey,
  @doc("Entity represents registry value in the system.") RegistryValue,
  @doc("Entity represents security group in the system.") SecurityGroup,
  @doc("Entity represents url in the system.") URL,
  @doc("Entity represents IoT device in the system.") IoTDevice,
  @doc("Entity represents security alert in the system.") SecurityAlert,
  @doc("Entity represents HuntingBookmark in the system.") HuntingBookmark,
  @doc("Entity represents mail cluster in the system.") MailCluster,
  @doc("Entity represents mail message in the system.") MailMessage,
  @doc("Entity represents mailbox in the system.") Mailbox,
  @doc("Entity represents submission mail in the system.") SubmissionMail,
  @doc("Entity represents network interface in the system.") Nic,
}

enum OutputType {
  Number,
  String,
  Date,
  Entity,
}

enum SettingsStatus {
  @doc("Anomaly settings status in Production mode") Production,
  @doc("Anomaly settings status in Flighting mode") Flighting,
}

enum EntityProviders {
  ActiveDirectory,
  AzureActiveDirectory,
}

enum UebaDataSources {
  AuditLogs,
  AzureActivity,
  SecurityEvent,
  SigninLogs,
}

enum DataTypeState {
  Enabled,
  Disabled,
}

enum PollingFrequency {
  @doc("Once a minute") OnceAMinute,
  @doc("Once an hour") OnceAnHour,
  @doc("Once a day") OnceADay,
}

enum ConnectivityType {
  IsConnectedQuery,
}

enum ProviderName {
  `Microsoft.OperationalInsights/solutions`,
  `Microsoft.OperationalInsights/workspaces`,
  `Microsoft.OperationalInsights/workspaces/datasources`,
  `microsoft.aadiam/diagnosticSettings`,
  `Microsoft.OperationalInsights/workspaces/sharedKeys`,
  `Microsoft.Authorization/policyAssignments`,
}

enum PermissionProviderScope {
  ResourceGroup,
  Subscription,
  Workspace,
}

enum SettingType {
  CopyableLabel,
  InstructionStepsGroup,
  InfoMessage,
}

enum FileHashAlgorithm {
  @doc("Unknown hash algorithm") Unknown,
  @doc("MD5 hash type") MD5,
  @doc("SHA1 hash type") SHA1,
  @doc("SHA256 hash type") SHA256,
  @doc("SHA256 Authenticode hash type") SHA256AC,
}

enum DeviceImportance {
  @doc("Unknown - Default value") Unknown,
  @doc("Low") Low,
  @doc("Normal") Normal,
  @doc("High") High,
}

enum AntispamMailDirection {
  @doc("Unknown") Unknown,
  @doc("Inbound") Inbound,
  @doc("Outbound") Outbound,
  @doc("Intraorg") Intraorg,
}

enum RegistryHive {
  @doc("HKEY_LOCAL_MACHINE") HKEY_LOCAL_MACHINE,
  @doc("HKEY_CLASSES_ROOT") HKEY_CLASSES_ROOT,
  @doc("HKEY_CURRENT_CONFIG") HKEY_CURRENT_CONFIG,
  @doc("HKEY_USERS") HKEY_USERS,
  @doc("HKEY_CURRENT_USER_LOCAL_SETTINGS") HKEY_CURRENT_USER_LOCAL_SETTINGS,
  @doc("HKEY_PERFORMANCE_DATA") HKEY_PERFORMANCE_DATA,
  @doc("HKEY_PERFORMANCE_NLSTEXT") HKEY_PERFORMANCE_NLSTEXT,
  @doc("HKEY_PERFORMANCE_TEXT") HKEY_PERFORMANCE_TEXT,
  @doc("HKEY_A") HKEY_A,
  @doc("HKEY_CURRENT_USER") HKEY_CURRENT_USER,
}

enum RegistryValueKind {
  @doc("None") None,
  @doc("Unknown value type") Unknown,
  @doc("String value type") String,
  @doc("ExpandString value type") ExpandString,
  @doc("Binary value type") Binary,
  @doc("DWord value type") DWord,
  @doc("MultiString value type") MultiString,
  @doc("QWord value type") QWord,
}
@Azure.Core.fixed
enum TriggerOperator {
  GreaterThan,
  LessThan,
  Equal,
  NotEqual,
}
@Azure.Core.fixed
enum OSFamily {
  @doc("Host with Linux operating system.") Linux,
  @doc("Host with Windows operating system.") Windows,
  @doc("Host with Android operating system.") Android,
  @doc("Host with IOS operating system.") IOS,
  @doc("Host with Unknown operating system.") Unknown,
}
@Azure.Core.fixed
enum DeliveryAction {
  @doc("Unknown") Unknown,
  @doc("DeliveredAsSpam") DeliveredAsSpam,
  @doc("Delivered") Delivered,
  @doc("Blocked") Blocked,
  @doc("Replaced") Replaced,
}
@Azure.Core.fixed
enum DeliveryLocation {
  @doc("Unknown") Unknown,
  @doc("Inbox") Inbox,
  @doc("JunkFolder") JunkFolder,
  @doc("DeletedFolder") DeletedFolder,
  @doc("Quarantine") Quarantine,
  @doc("External") External,
  @doc("Failed") Failed,
  @doc("Dropped") Dropped,
  @doc("Forwarded") Forwarded,
}
@Azure.Core.fixed
enum ElevationToken {
  @doc("Default elevation token") Default,
  @doc("Full elevation token") Full,
  @doc("Limited elevation token") Limited,
}

@doc("An azure resource object with an Etag property")
model ResourceWithEtag {
  ...Resource;

  @doc("Etag of the azure resource")
  etag?: string;
}

@doc("Error response structure.")
@error
model CloudError {
  @doc("Error data")
  error?: CloudErrorBody;
}

@doc("Error details.")
model CloudErrorBody {
  @doc("An identifier for the error. Codes are invariant and are intended to be consumed programmatically.")
  @visibility("read")
  code?: string;

  @doc("A message describing the error, intended to be suitable for display in a user interface.")
  @visibility("read")
  message?: string;
}

@doc("Action property bag.")
model ActionResponseProperties {
  ...ActionPropertiesBase;

  @doc("The name of the logic app's workflow.")
  workflowId?: string;
}

@doc("Action property bag base.")
model ActionPropertiesBase {
  @doc("Logic App Resource Id, /subscriptions/{my-subscription}/resourceGroups/{my-resource-group}/providers/Microsoft.Logic/workflows/{my-workflow-id}.")
  logicAppResourceId: string;
}

@doc("Action for alert rule.")
model ActionRequest {
  ...ResourceWithEtag;

  @doc("Action properties for put request")
  properties?: ActionRequestProperties;
}

@doc("Action property bag.")
model ActionRequestProperties {
  ...ActionPropertiesBase;

  @doc("Logic App Callback URL for this specific workflow.")
  triggerUri: string;
}

@doc("Automation rule properties")
model AutomationRuleProperties {
  @doc("The display name of the automation rule.")
  @maxLength(500)
  displayName: string;

  @doc("The order of execution of the automation rule.")
  order: int32;

  @doc("Describes automation rule triggering logic.")
  triggeringLogic: AutomationRuleTriggeringLogic;

  @doc("The actions to execute when the automation rule is triggered.")
  actions: AutomationRuleAction[];

  @doc("The last time the automation rule was updated.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTimeUtc?: utcDateTime;

  @doc("The time the automation rule was created.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdTimeUtc?: utcDateTime;

  @doc("Information on the client (user or application) that made some action")
  @visibility("read")
  lastModifiedBy?: ClientInfo;

  @doc("Information on the client (user or application) that made some action")
  @visibility("read")
  createdBy?: ClientInfo;
}

@doc("Describes automation rule triggering logic.")
model AutomationRuleTriggeringLogic {
  @doc("Determines whether the automation rule is enabled or disabled.")
  isEnabled: boolean;

  @doc("Determines when the automation rule should automatically expire and be disabled.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expirationTimeUtc?: utcDateTime;

  triggersOn: TriggersOn;
  triggersWhen: TriggersWhen;

  @doc("The conditions to evaluate to determine if the automation rule should be triggered on a given object.")
  conditions?: AutomationRuleCondition[];
}

@doc("Describes an automation rule condition.")
@discriminator("conditionType")
model AutomationRuleCondition {}

@doc("Describes an automation rule action.")
@discriminator("actionType")
model AutomationRuleAction {
  order: int32;
}

@doc("Information on the client (user or application) that made some action")
model ClientInfo {
  @doc("The email of the client.")
  email?: string;

  @doc("The name of the client.")
  name?: string;

  @doc("The object id of the client.")
  objectId?: string;

  @doc("The user principal name of the client.")
  userPrincipalName?: string;
}

model ManualTriggerRequestBody {
  tenantId?: string;
  logicAppsResourceId: string;
}

@doc("Describes bookmark properties")
model BookmarkProperties {
  @doc("The time the bookmark was created")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  created?: utcDateTime;

  @doc("Describes a user that created the bookmark")
  createdBy?: UserInfo;

  @doc("The display name of the bookmark")
  displayName: string;

  @doc("List of labels relevant to this bookmark")
  labels?: string[];

  @doc("The notes of the bookmark")
  notes?: string;

  @doc("The query of the bookmark.")
  query: string;

  @doc("The query result of the bookmark.")
  queryResult?: string;

  @doc("The last time the bookmark was updated")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  updated?: utcDateTime;

  @doc("Describes a user that updated the bookmark")
  updatedBy?: UserInfo;

  @doc("The bookmark event time")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  eventTime?: utcDateTime;

  @doc("The start time for the query")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  queryStartTime?: utcDateTime;

  @doc("The end time for the query")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  queryEndTime?: utcDateTime;

  @doc("Describes an incident that relates to bookmark")
  incidentInfo?: IncidentInfo;

  @doc("Describes the entity mappings of the bookmark")
  entityMappings?: BookmarkEntityMappings[];

  @doc("A list of relevant mitre attacks")
  tactics?: AttackTactic[];

  @doc("A list of relevant mitre techniques")
  techniques?: string[];
}

@doc("User information that made some action")
model UserInfo {
  @doc("The email of the user.")
  @visibility("read")
  email?: string;

  @doc("The name of the user.")
  @visibility("read")
  name?: string;

  @doc("The object id of the user.")
  objectId?: string;
}

@doc("Describes related incident information for the bookmark")
model IncidentInfo {
  @doc("Incident Id")
  incidentId?: string;

  @doc("The severity of the incident")
  severity?: IncidentSeverity;

  @doc("The title of the incident")
  title?: string;

  @doc("Relation Name")
  relationName?: string;
}

@doc("Describes the entity mappings of a single entity")
model BookmarkEntityMappings {
  @doc("The entity type")
  entityType?: string;

  @doc("Array of fields mapping for that entity type")
  fieldMappings?: EntityFieldMapping[];
}

@doc("Map identifiers of a single entity")
model EntityFieldMapping {
  @doc("Alert V3 identifier")
  identifier?: string;

  @doc("The value of the identifier")
  value?: string;
}

@doc("Relation property bag.")
model RelationProperties {
  @doc("The resource ID of the related resource")
  relatedResourceId: string;

  @doc("The name of the related resource")
  @visibility("read")
  relatedResourceName?: string;

  @doc("The resource type of the related resource")
  @visibility("read")
  relatedResourceType?: string;

  @doc("The resource kind of the related resource")
  @visibility("read")
  relatedResourceKind?: string;
}

@doc("The parameters required to execute an expand operation on the given bookmark.")
model BookmarkExpandParameters {
  @doc("The end date filter, so the only expansion results returned are before this date.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  @doc("The Id of the expansion to perform.")
  expansionId?: string;

  @doc("The start date filter, so the only expansion results returned are after this date.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;
}

@doc("The entity expansion result operation response.")
model BookmarkExpandResponse {
  @doc("The metadata from the expansion operation results.")
  metaData?: ExpansionResultsMetadata;

  @doc("The expansion result values.")
  value?: BookmarkExpandResponseValue;
}

@doc("Expansion result metadata.")
model ExpansionResultsMetadata {
  @doc("Information of the aggregated nodes in the expansion result.")
  aggregations?: ExpansionResultAggregation[];
}

@doc("Information of a specific aggregation in the expansion result.")
model ExpansionResultAggregation {
  @doc("The common type of the aggregation. (for e.g. entity field name)")
  aggregationType?: string;

  @doc("Total number of aggregations of the given kind (and aggregationType if given) in the expansion result.")
  count: int32;

  @doc("The display name of the aggregation by type.")
  displayName?: string;

  @doc("The kind of the aggregated entity.")
  entityKind: EntityKind;
}

@doc("The expansion result values.")
model BookmarkExpandResponseValue {
  @doc("Array of the expansion result entities.")
  entities?: Entity[];

  @doc("Array of expansion result connected entities")
  edges?: ConnectedEntity[];
}

@doc("Expansion result connected entities")
model ConnectedEntity {
  @doc("Entity Id of the connected entity")
  targetEntityId?: string;

  @doc("key-value pairs for a connected entity mapping")
  additionalData?: Record<unknown>;
}

@doc("Geodata information for a given IP address")
model EnrichmentIpGeodata {
  @doc("The autonomous system number associated with this IP address")
  asn?: string;

  @doc("The name of the carrier for this IP address")
  carrier?: string;

  @doc("The city this IP address is located in")
  city?: string;

  @doc("A numeric rating of confidence that the value in the 'city' field is correct, on a scale of 0-100")
  cityCf?: int32;

  @doc("The continent this IP address is located on")
  continent?: string;

  @doc("The county this IP address is located in")
  country?: string;

  @doc("A numeric rating of confidence that the value in the 'country' field is correct on a scale of 0-100")
  countryCf?: int32;

  @doc("The dotted-decimal or colon-separated string representation of the IP address")
  ipAddr?: string;

  @doc("A description of the connection type of this IP address")
  ipRoutingType?: string;

  @doc("The latitude of this IP address")
  latitude?: string;

  @doc("The longitude of this IP address")
  longitude?: string;

  @doc("The name of the organization for this IP address")
  organization?: string;

  @doc("The type of the organization for this IP address")
  organizationType?: string;

  @doc("The geographic region this IP address is located in")
  region?: string;

  @doc("The state this IP address is located in")
  state?: string;

  @doc("A numeric rating of confidence that the value in the 'state' field is correct on a scale of 0-100")
  stateCf?: int32;

  @doc("The abbreviated name for the state this IP address is located in")
  stateCode?: string;
}

@doc("Whois information for a given domain and associated metadata")
model EnrichmentDomainWhois {
  @doc("The domain for this whois record")
  domain?: string;

  @doc("The hostname of this registrar's whois server")
  server?: string;

  @doc("The timestamp at which this record was created")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  created?: utcDateTime;

  @doc("The timestamp at which this record was last updated")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  updated?: utcDateTime;

  @doc("The timestamp at which this record will expire")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expires?: utcDateTime;

  @doc("The whois record for a given domain")
  parsedWhois?: EnrichmentDomainWhoisDetails;
}

@doc("The whois record for a given domain")
model EnrichmentDomainWhoisDetails {
  @doc("The registrar associated with this domain")
  registrar?: EnrichmentDomainWhoisRegistrarDetails;

  @doc("The set of contacts associated with this domain")
  contacts?: EnrichmentDomainWhoisContacts;

  @doc("A list of name servers associated with this domain")
  nameServers?: string[];

  @doc("The set of status flags for this whois record")
  statuses?: string[];
}

@doc("The registrar associated with this domain")
model EnrichmentDomainWhoisRegistrarDetails {
  @doc("The name of this registrar")
  name?: string;

  @doc("This registrar's abuse contact email")
  abuseContactEmail?: string;

  @doc("This registrar's abuse contact phone number")
  abuseContactPhone?: string;

  @doc("This registrar's Internet Assigned Numbers Authority id")
  ianaId?: string;

  @doc("This registrar's URL")
  url?: string;

  @doc("The hostname of this registrar's whois server")
  whoisServer?: string;
}

@doc("The set of contacts associated with this domain")
model EnrichmentDomainWhoisContacts {
  @doc("The admin contact for this whois record")
  admin?: EnrichmentDomainWhoisContact;

  @doc("The billing contact for this whois record")
  billing?: EnrichmentDomainWhoisContact;

  @doc("The registrant contact for this whois record")
  registrant?: EnrichmentDomainWhoisContact;

  @doc("The technical contact for this whois record")
  tech?: EnrichmentDomainWhoisContact;
}

@doc("An individual contact associated with this domain")
model EnrichmentDomainWhoisContact {
  @doc("The name of this contact")
  name?: string;

  @doc("The organization for this contact")
  org?: string;

  @doc("A list describing the street address for this contact")
  street?: string[];

  @doc("The city for this contact")
  city?: string;

  @doc("The state for this contact")
  state?: string;

  @doc("The postal code for this contact")
  postal?: string;

  @doc("The country for this contact")
  country?: string;

  @doc("The phone number for this contact")
  phone?: string;

  @doc("The fax number for this contact")
  fax?: string;

  @doc("The email address for this contact")
  email?: string;
}

@doc("The parameters required to execute an expand operation on the given entity.")
model EntityExpandParameters {
  @doc("The end date filter, so the only expansion results returned are before this date.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  @doc("The Id of the expansion to perform.")
  expansionId?: string;

  @doc("The start date filter, so the only expansion results returned are after this date.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;
}

@doc("The entity expansion result operation response.")
model EntityExpandResponse {
  @doc("The metadata from the expansion operation results.")
  metaData?: ExpansionResultsMetadata;

  @doc("The expansion result values.")
  value?: EntityExpandResponseValue;
}

@doc("The expansion result values.")
model EntityExpandResponseValue {
  @doc("Array of the expansion result entities.")
  entities?: Entity[];

  @doc("Array of edges that connects the entity to the list of entities.")
  edges?: EntityEdges[];
}

@doc("The edge that connects the entity to the other entity.")
model EntityEdges {
  @doc("The target entity Id.")
  targetEntityId?: string;

  @doc("A bag of custom fields that should be part of the entity and will be presented to the user.")
  additionalData?: Record<unknown>;
}

@doc("The parameters required to execute s timeline operation on the given entity.")
model EntityTimelineParameters {
  @doc("Array of timeline Item kinds.")
  kinds?: EntityTimelineKind[];

  @doc("The start timeline date, so the results returned are after this date.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime: utcDateTime;

  @doc("The end timeline date, so the results returned are before this date.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime: utcDateTime;

  @doc("The number of bucket for timeline queries aggregation.")
  numberOfBucket?: int32;
}

@doc("The entity timeline result operation response.")
model EntityTimelineResponse {
  @doc("The metadata from the timeline operation results.")
  metaData?: TimelineResultsMetadata;

  @doc("The timeline result values.")
  value?: EntityTimelineItem[];
}

@doc("Expansion result metadata.")
model TimelineResultsMetadata {
  @doc("the total items found for the timeline request")
  totalCount: int32;

  @doc("timeline aggregation per kind")
  aggregations: TimelineAggregation[];

  @doc("information about the failure queries")
  errors?: TimelineError[];
}

@doc("timeline aggregation information per kind")
model TimelineAggregation {
  @doc("the total items found for a kind")
  count: int32;

  @doc("the query kind")
  kind: EntityTimelineKind;
}

@doc("Timeline Query Errors.")
model TimelineError {
  @doc("the query kind")
  kind: EntityTimelineKind;

  @doc("the query id")
  queryId?: string;

  @doc("the error message")
  errorMessage: string;
}

@doc("Entity timeline Item.")
@discriminator("kind")
model EntityTimelineItem {}

@doc("Retrieve queries for entity result operation response.")
model GetQueriesResponse {
  @doc("The query result values.")
  value?: EntityQueryItem[];
}

@doc("An abstract Query item for entity")
@discriminator("kind")
model EntityQueryItem {
  @doc("Query Template ARM ID")
  @visibility("read")
  id?: string;

  @doc("Query Template ARM Name")
  name?: string;

  @doc("ARM Type")
  type?: string;
}

@doc("The parameters required to execute insights operation on the given entity.")
model EntityGetInsightsParameters {
  @doc("The start timeline date, so the results returned are after this date.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime: utcDateTime;

  @doc("The end timeline date, so the results returned are before this date.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime: utcDateTime;

  @doc("Indicates if query time range should be extended with default time range of the query. Default value is false")
  addDefaultExtendedTimeRange?: boolean;

  @doc("List of Insights Query Id. If empty, default value is all insights of this entity")
  insightQueryIds?: string[];
}

@doc("The Get Insights result operation response.")
model EntityGetInsightsResponse {
  @doc("The metadata from the get insights operation results.")
  metaData?: GetInsightsResultsMetadata;

  @doc("The insights result values.")
  value?: EntityInsightItem[];
}

@doc("Get Insights result metadata.")
model GetInsightsResultsMetadata {
  @doc("the total items found for the insights request")
  totalCount: int32;

  @doc("information about the failed queries")
  errors?: GetInsightsErrorKind[];
}

@doc("GetInsights Query Errors.")
model GetInsightsErrorKind {
  @doc("the query kind")
  kind: GetInsightsError;

  @doc("the query id")
  queryId?: string;

  @doc("the error message")
  errorMessage: string;
}

@doc("Entity insight Item.")
model EntityInsightItem {
  @doc("The query id of the insight")
  queryId?: string;

  @doc("The Time interval that the query actually executed on.")
  queryTimeInterval?: EntityInsightItemQueryTimeInterval;

  @doc("Query results for table insights query.")
  tableQueryResults?: InsightsTableResult;

  @doc("Query results for table insights query.")
  chartQueryResults?: InsightsTableResult[];
}

@doc("The Time interval that the query actually executed on.")
model EntityInsightItemQueryTimeInterval {
  @doc("Insight query start time")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  @doc("Insight query end time")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;
}

@doc("Query results for table insights query.")
model InsightsTableResult {
  @doc("Columns Metadata of the table")
  columns?: InsightsTableResultColumnsItem[];

  @doc("Rows data of the table")
  rows?: string[][];
}

model InsightsTableResultColumnsItem {
  @doc("the type of the colum")
  type?: string;

  @doc("the name of the colum")
  name?: string;
}

@doc("Specific entity query that supports put requests.")
@discriminator("kind")
model CustomEntityQuery {
  ...ResourceWithEtag;
}

@doc("Describes the FileImport's properties")
model FileImportProperties {
  @doc("Describes how to ingest the records in the file.")
  ingestionMode: IngestionMode;

  @doc("The content type of this file.")
  contentType: FileImportContentType;

  @doc("The time the file was imported.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdTimeUTC?: utcDateTime;

  @doc("Represents the error file (if the import was ingested with errors or failed the validation).")
  @visibility("read")
  errorFile?: FileMetadata;

  @doc("An ordered list of some of the errors that were encountered during validation.")
  @visibility("read")
  errorsPreview?: ValidationError[];

  @doc("Represents the imported file.")
  importFile: FileMetadata;

  @doc("The number of records that have been successfully ingested.")
  @visibility("read")
  ingestedRecordCount?: int32;

  @doc("The source for the data in the file.")
  source: string;

  @doc("The state of the file import.")
  @visibility("read")
  state?: FileImportState;

  @doc("The number of records in the file.")
  @visibility("read")
  totalRecordCount?: int32;

  @doc("The number of records that have passed validation.")
  @visibility("read")
  validRecordCount?: int32;

  @doc("The time the files associated with this import are deleted from the storage account.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  filesValidUntilTimeUTC?: utcDateTime;

  @doc("The time the file import record is soft deleted from the database and history.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  importValidUntilTimeUTC?: utcDateTime;
}

@doc("Represents a file.")
model FileMetadata {
  @doc("The format of the file")
  fileFormat?: FileFormat;

  @doc("The name of the file.")
  fileName?: string;

  @doc("The size of the file.")
  fileSize?: int32;

  @doc("A URI with a valid SAS token to allow uploading / downloading the file.")
  @visibility("read")
  fileContentUri?: string;

  @doc("Indicates whether the file was deleted from the storage account.")
  @visibility("read")
  deleteStatus?: DeleteStatus;
}

@doc("Describes an error encountered in the file during validation.")
model ValidationError {
  @doc("The number of the record that has the error.")
  recordIndex?: int32;

  @doc("A list of descriptions of the error.")
  @visibility("read")
  errorMessages?: string[];
}

model IncidentProperties {
  @doc("The title of the incident")
  title: string;

  @doc("The description of the incident")
  description?: string;

  @doc("The severity of the incident")
  severity: IncidentSeverity;

  @doc("The status of the incident")
  status: IncidentStatus;

  @doc("The reason the incident was closed")
  classification?: IncidentClassification;

  @doc("The classification reason the incident was closed with")
  classificationReason?: IncidentClassificationReason;

  @doc("Describes the reason the incident was closed")
  classificationComment?: string;

  @doc("Describes a user that the incident is assigned to")
  owner?: IncidentOwnerInfo;

  @doc("List of labels relevant to this incident")
  labels?: IncidentLabel[];

  @doc("The time of the first activity in the incident")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  firstActivityTimeUtc?: utcDateTime;

  @doc("The time of the last activity in the incident")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastActivityTimeUtc?: utcDateTime;

  @doc("The last time the incident was updated")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTimeUtc?: utcDateTime;

  @doc("The time the incident was created")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdTimeUtc?: utcDateTime;

  @doc("A sequential number")
  @visibility("read")
  incidentNumber?: int32;

  @doc("Additional data on the incident")
  @visibility("read")
  additionalData?: IncidentAdditionalData;

  @doc("List of resource ids of Analytic rules related to the incident")
  @visibility("read")
  relatedAnalyticRuleIds?: string[];

  @doc("The deep-link url to the incident in Azure portal")
  @visibility("read")
  incidentUrl?: string;

  @doc("The name of the source provider that generated the incident")
  providerName?: string;

  @doc("The incident ID assigned by the incident provider")
  providerIncidentId?: string;

  @doc("Describes a team for the incident")
  teamInformation?: TeamInformation;
}

@doc("Information on the user an incident is assigned to")
model IncidentOwnerInfo {
  @doc("The email of the user the incident is assigned to.")
  email?: string;

  @doc("The name of the user the incident is assigned to.")
  assignedTo?: string;

  @doc("The object id of the user the incident is assigned to.")
  objectId?: string;

  @doc("The user principal name of the user the incident is assigned to.")
  userPrincipalName?: string;

  @doc("The type of the owner the incident is assigned to.")
  ownerType?: OwnerType;
}

@doc("Represents an incident label")
model IncidentLabel {
  @doc("The name of the label")
  labelName: string;

  @doc("The type of the label")
  @visibility("read")
  labelType?: IncidentLabelType;
}

@doc("Incident additional data property bag.")
model IncidentAdditionalData {
  @doc("The number of alerts in the incident")
  @visibility("read")
  alertsCount?: int32;

  @doc("The number of bookmarks in the incident")
  @visibility("read")
  bookmarksCount?: int32;

  @doc("The number of comments in the incident")
  @visibility("read")
  commentsCount?: int32;

  @doc("List of product names of alerts in the incident")
  @visibility("read")
  alertProductNames?: string[];

  @doc("The tactics associated with incident")
  @visibility("read")
  tactics?: AttackTactic[];

  @doc("The techniques associated with incident's tactics")
  @visibility("read")
  techniques?: string[];

  @doc("The provider incident url to the incident in Microsoft 365 Defender portal")
  @visibility("read")
  providerIncidentUrl?: string;
}

@doc("Describes team information")
model TeamInformation {
  @doc("Team ID")
  @visibility("read")
  teamId?: string;

  @doc("The primary channel URL of the team")
  @visibility("read")
  primaryChannelUrl?: string;

  @doc("The time the team was created")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  teamCreationTimeUtc?: utcDateTime;

  @doc("The name of the team")
  @visibility("read")
  name?: string;

  @doc("The description of the team")
  @visibility("read")
  description?: string;
}

@doc("List of incident alerts.")
model IncidentAlertList {
  @doc("Array of incident alerts.")
  value: SecurityAlert[];
}

@doc("Represents a security alert entity.")
model SecurityAlert extends Entity {
  @doc("SecurityAlert entity properties")
  properties?: SecurityAlertProperties;

  @doc("The kind of the entity.")
  kind: "SecurityAlert";
}

@doc("SecurityAlert entity property bag.")
model SecurityAlertProperties {
  ...EntityCommonProperties;

  @doc("The display name of the alert.")
  @visibility("read")
  alertDisplayName?: string;

  @doc("The type name of the alert.")
  @visibility("read")
  alertType?: string;

  @doc("Display name of the main entity being reported on.")
  @visibility("read")
  compromisedEntity?: string;

  @doc("The confidence level of this alert.")
  @visibility("read")
  confidenceLevel?: ConfidenceLevel;

  @doc("The confidence reasons")
  @visibility("read")
  confidenceReasons?: SecurityAlertPropertiesConfidenceReasonsItem[];

  @doc("The confidence score of the alert.")
  @visibility("read")
  confidenceScore?: float32;

  @doc("The confidence score calculation status, i.e. indicating if score calculation is pending for this alert, not applicable or final.")
  @visibility("read")
  confidenceScoreStatus?: ConfidenceScoreStatus;

  @doc("Alert description.")
  @visibility("read")
  description?: string;

  @doc("The impact end time of the alert (the time of the last event contributing to the alert).")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTimeUtc?: utcDateTime;

  @doc("Holds the alert intent stage(s) mapping for this alert.")
  @visibility("read")
  intent?: KillChainIntent;

  @doc("The identifier of the alert inside the product which generated the alert.")
  @visibility("read")
  providerAlertId?: string;

  @doc("The time the alert was made available for consumption.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  processingEndTime?: utcDateTime;

  @doc("The name of a component inside the product which generated the alert.")
  @visibility("read")
  productComponentName?: string;

  @doc("The name of the product which published this alert.")
  @visibility("read")
  productName?: string;

  @doc("The version of the product generating the alert.")
  @visibility("read")
  productVersion?: string;

  @doc("Manual action items to take to remediate the alert.")
  @visibility("read")
  remediationSteps?: string[];

  @doc("The severity of the alert")
  severity?: AlertSeverity;

  @doc("The impact start time of the alert (the time of the first event contributing to the alert).")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTimeUtc?: utcDateTime;

  @doc("The lifecycle status of the alert.")
  @visibility("read")
  status?: AlertStatus;

  @doc("Holds the product identifier of the alert for the product.")
  @visibility("read")
  systemAlertId?: string;

  @doc("The tactics of the alert")
  @visibility("read")
  tactics?: AttackTactic[];

  @doc("The time the alert was generated.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timeGenerated?: utcDateTime;

  @doc("The name of the vendor that raise the alert.")
  @visibility("read")
  vendorName?: string;

  @doc("The uri link of the alert.")
  @visibility("read")
  alertLink?: string;

  @doc("The list of resource identifiers of the alert.")
  @visibility("read")
  resourceIdentifiers?: Record<unknown>[];
}

@doc("confidence reason item")
model SecurityAlertPropertiesConfidenceReasonsItem {
  @doc("The reason's description")
  @visibility("read")
  reason?: string;

  @doc("The type (category) of the reason")
  @visibility("read")
  reasonType?: string;
}

@doc("Entity common property bag.")
model EntityCommonProperties {
  @doc("A bag of custom fields that should be part of the entity and will be presented to the user.")
  @visibility("read")
  additionalData?: Record<unknown>;

  @doc("The graph item display name which is a short humanly readable description of the graph item instance. This property is optional and might be system generated.")
  @visibility("read")
  friendlyName?: string;
}

@doc("List of incident bookmarks.")
model IncidentBookmarkList {
  @doc("Array of incident bookmarks.")
  value: HuntingBookmark[];
}

@doc("Represents a Hunting bookmark entity.")
model HuntingBookmark extends Entity {
  @doc("HuntingBookmark entity properties")
  properties?: HuntingBookmarkProperties;

  @doc("The kind of the entity.")
  kind: "Bookmark";
}

@doc("Describes bookmark properties")
model HuntingBookmarkProperties {
  ...EntityCommonProperties;

  @doc("The time the bookmark was created")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  created?: utcDateTime;

  @doc("Describes a user that created the bookmark")
  createdBy?: UserInfo;

  @doc("The display name of the bookmark")
  displayName: string;

  @doc("The time of the event")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  eventTime?: utcDateTime;

  @doc("List of labels relevant to this bookmark")
  labels?: string[];

  @doc("The notes of the bookmark")
  notes?: string;

  @doc("The query of the bookmark.")
  query: string;

  @doc("The query result of the bookmark.")
  queryResult?: string;

  @doc("The last time the bookmark was updated")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  updated?: utcDateTime;

  @doc("Describes a user that updated the bookmark")
  updatedBy?: UserInfo;

  @doc("Describes an incident that relates to bookmark")
  incidentInfo?: IncidentInfo;
}

@doc("Incident comment property bag.")
model IncidentCommentProperties {
  @doc("The comment message")
  message: string;

  @doc("The time the comment was created")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdTimeUtc?: utcDateTime;

  @doc("The time the comment was updated")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTimeUtc?: utcDateTime;

  @doc("Describes the client that created the comment")
  @visibility("read")
  author?: ClientInfo;
}

@doc("The incident related entities response.")
model IncidentEntitiesResponse {
  @doc("Array of the incident related entities.")
  entities?: Entity[];

  @doc("The metadata from the incident related entities results.")
  metaData?: IncidentEntitiesResultsMetadata[];
}

@doc("Information of a specific aggregation in the incident related entities result.")
model IncidentEntitiesResultsMetadata {
  @doc("The kind of the aggregated entity.")
  entityKind: EntityKind;

  @doc("Total number of aggregations of the given kind in the incident related entities result.")
  count: int32;
}

model IncidentTaskProperties {
  @doc("The title of the task")
  title: string;

  @doc("The description of the task")
  description?: string;

  status: IncidentTaskStatus;

  @doc("The time the task was created")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdTimeUtc?: utcDateTime;

  @doc("The last time the task was updated")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTimeUtc?: utcDateTime;

  @doc("Information on the client (user or application) that made some action")
  createdBy?: ClientInfo;

  @doc("Information on the client (user or application) that made some action")
  lastModifiedBy?: ClientInfo;
}

@doc("Metadata property bag.")
model MetadataProperties {
  @doc("Static ID for the content.  Used to identify dependencies and content from solutions or community.  Hard-coded/static for out of the box content and solutions. Dynamic for user-created.  This is the resource name")
  contentId?: string;

  @doc("Full parent resource ID of the content item the metadata is for.  This is the full resource ID including the scope (subscription and resource group)")
  parentId: string;

  @doc("Version of the content.  Default and recommended format is numeric (e.g. 1, 1.0, 1.0.0, 1.0.0.0), following ARM template best practices.  Can also be any string, but then we cannot guarantee any version checks")
  version?: string;

  @doc("The kind of content the metadata is for.")
  kind: Kind;

  @doc("Source of the content.  This is where/how it was created.")
  source?: MetadataSource;

  @doc("The creator of the content item.")
  author?: MetadataAuthor;

  @doc("Support information for the metadata - type, name, contact information")
  support?: MetadataSupport;

  @doc("Dependencies for the content item, what other content items it requires to work.  Can describe more complex dependencies using a recursive/nested structure. For a single dependency an id/kind/version can be supplied or operator/criteria for complex formats.")
  dependencies?: MetadataDependencies;

  @doc("Categories for the solution content item")
  categories?: MetadataCategories;

  @doc("Providers for the solution content item")
  providers?: string[];

  @doc("first publish date solution content item")
  firstPublishDate?: plainDate;

  @doc("last publish date for the solution content item")
  lastPublishDate?: plainDate;

  @doc("The custom version of the content. A optional free text")
  customVersion?: string;

  @doc("Schema version of the content. Can be used to distinguish between different flow based on the schema version")
  contentSchemaVersion?: string;

  @doc("the icon identifier. this id can later be fetched from the solution template")
  icon?: string;

  @doc("the tactics the resource covers")
  threatAnalysisTactics?: string[];

  @doc("the techniques the resource covers, these have to be aligned with the tactics being used")
  threatAnalysisTechniques?: string[];

  @doc("preview image file names. These will be taken from the solution artifacts")
  previewImages?: string[];

  @doc("preview image file names. These will be taken from the solution artifacts. used for dark theme support")
  previewImagesDark?: string[];
}

@doc("The original source of the content item, where it comes from.")
model MetadataSource {
  @doc("Source type of the content")
  kind: SourceKind;

  @doc("Name of the content source.  The repo name, solution name, LA workspace name etc.")
  name?: string;

  @doc("ID of the content source.  The solution ID, workspace ID, etc")
  sourceId?: string;
}

@doc("Publisher or creator of the content item.")
model MetadataAuthor {
  @doc("Name of the author. Company or person.")
  name?: string;

  @doc("Email of author contact")
  email?: string;

  @doc("Link for author/vendor page")
  link?: string;
}

@doc("Support information for the content item.")
model MetadataSupport {
  @doc("Type of support for content item")
  tier: SupportTier;

  @doc("Name of the support contact. Company or person.")
  name?: string;

  @doc("Email of support contact")
  email?: string;

  @doc("Link for support help, like to support page to open a ticket etc.")
  link?: string;
}

@doc("Dependencies for the content item, what other content items it requires to work.  Can describe more complex dependencies using a recursive/nested structure. For a single dependency an id/kind/version can be supplied or operator/criteria for complex dependencies.")
model MetadataDependencies {
  @doc("Id of the content item we depend on")
  contentId?: string;

  @doc("Type of the content item we depend on")
  kind?: Kind;

  @doc("Version of the the content item we depend on.  Can be blank, * or missing to indicate any version fulfills the dependency.  If version does not match our defined numeric format then an exact match is required.")
  version?: string;

  @doc("Name of the content item")
  name?: string;

  @doc("Operator used for list of dependencies in criteria array.")
  operator?: Operator;

  @doc("This is the list of dependencies we must fulfill, according to the AND/OR operator")
  criteria?: MetadataDependencies[];
}

@doc("ies for the solution content item")
model MetadataCategories {
  @doc("domain for the solution content item")
  domains?: string[];

  @doc("Industry verticals for the solution content item")
  verticals?: string[];
}

@doc("Consent property bag.")
model OfficeConsentProperties {
  @doc("The tenantId of the Office365 with the consent.")
  tenantId?: string;

  @doc("Help to easily cascade among the data layers.")
  consentId?: string;
}

@doc("The Sentinel onboarding state properties")
model SentinelOnboardingStateProperties {
  @doc("Flag that indicates the status of the CMK setting")
  customerManagedKey?: boolean;
}

@doc("A list of recommendations")
model RecommendationList {
  @doc("An list of recommendations")
  value?: Recommendation[];
}

@doc("Recommendation object.")
model Recommendation {
  @doc("id of recommendation.")
  id: string;

  @doc("Instructions of the recommendation.")
  instructions: Instructions;

  @doc("Content of the recommendation.")
  content?: Content;

  @doc("Id of the resource this recommendation refers to.")
  resourceId?: string;

  @doc("Collection of additional properties for the recommendation.")
  additionalProperties?: Record<string>;

  @doc("Title of the recommendation.")
  title: string;

  @doc("Description of the recommendation.")
  description: string;

  @doc("Title of the recommendation type.")
  recommendationTypeTitle: string;

  @doc("Id of the recommendation type.")
  recommendationTypeId: string;

  @doc("Category of the recommendation.")
  category: Category;

  @doc("Context of the recommendation.")
  context: Context;

  @doc("Id of the workspace this recommendation refers to.")
  workspaceId: string;

  @doc("List of actions to take for this recommendation.")
  actions: RecommendedAction[];

  @doc("State of the recommendation.")
  state: State;

  @doc("Priority of the recommendation.")
  priority: Priority;

  @doc("The time stamp (UTC) when the recommendation was last evaluated.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastEvaluatedTimeUtc: utcDateTime;

  @doc("The time stamp (UTC) when the recommendation should be displayed again.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  hideUntilTimeUtc?: utcDateTime;

  @doc("The timestamp (UTC) after which the recommendation should not be displayed anymore.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  displayUntilTimeUtc?: utcDateTime;

  @doc("Value indicating if the recommendation should be displayed or not.")
  visible?: boolean;
}

@doc("Instructions section of a recommendation.")
model Instructions {
  @doc("What actions should be taken to complete the recommendation.")
  actionsToBePerformed: string;

  @doc("Explains why the recommendation is important.")
  recommendationImportance: string;

  @doc("How should the user complete the recommendation.")
  howToPerformActionDetails?: string;
}

@doc("Content section of the recommendation.")
model Content {
  @doc("Title of the content.")
  title: string;

  @doc("Description of the content.")
  description: string;
}

@doc("What actions should be taken to complete the recommendation.")
model RecommendedAction {
  @doc("Text of the link to complete the action.")
  linkText: string;

  @doc("The Link to complete the action.")
  linkUrl: string;

  @doc("The state of the action.")
  state?: Priority;
}

@doc("Recommendation Fields to update.")
model RecommendationPatch {
  @doc("State of the recommendation.")
  state?: State;

  @doc("The time stamp (UTC) when the recommendation should be displayed again.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  hideUntilTimeUtc?: utcDateTime;
}

@doc("List all the source controls.")
model RepoList is Azure.Core.Page<Repo>;

@doc("Represents a repository.")
model Repo {
  @doc("The url to access the repository.")
  url?: string;

  @doc("The name of the repository.")
  fullName?: string;

  @doc("Array of branches.")
  branches?: string[];
}

@doc("Describes source control properties")
model SourceControlProperties {
  @doc("The id (a Guid) of the source control")
  id?: string;

  @doc("The version number associated with the source control")
  version?: Version;

  @doc("The display name of the source control")
  displayName: string;

  @doc("A description of the source control")
  description?: string;

  @doc("The repository type of the source control")
  repoType: RepoType;

  @doc("Array of source control content types.")
  contentTypes: ContentType[];

  @doc("Repository metadata.")
  repository: Repository;

  @doc("Information regarding the resources created in user's repository.")
  repositoryResourceInfo?: RepositoryResourceInfo;

  @doc("Information regarding the latest deployment for the source control.")
  lastDeploymentInfo?: DeploymentInfo;
}

@doc("metadata of a repository.")
model Repository {
  @doc("Url of repository.")
  url?: string;

  @doc("Branch name of repository.")
  branch?: string;

  @doc("Display url of repository.")
  displayUrl?: string;

  @doc("Url to access repository action logs.")
  deploymentLogsUrl?: string;

  @doc("Dictionary of source control content type and path mapping.")
  pathMapping?: ContentPathMap[];
}

@doc("The mapping of content type to a repo path.")
model ContentPathMap {
  @doc("Content type.")
  contentType?: ContentType;

  @doc("The path to the content.")
  path?: string;
}

@doc("Resources created in user's repository for the source-control.")
model RepositoryResourceInfo {
  @doc("The webhook object created for the source-control.")
  webhook?: Webhook;

  @doc("Resources created in GitHub for this source-control.")
  gitHubResourceInfo?: GitHubResourceInfo;

  @doc("Resources created in Azure DevOps for this source-control.")
  azureDevOpsResourceInfo?: AzureDevOpsResourceInfo;
}

@doc("Detail about the webhook object.")
model Webhook {
  @doc("Unique identifier for the webhook.")
  webhookId?: string;

  @doc("URL that gets invoked by the webhook.")
  webhookUrl?: string;

  @doc("Time when the webhook secret was updated.")
  webhookSecretUpdateTime?: string;

  @doc("A flag to instruct the backend service to rotate webhook secret.")
  rotateWebhookSecret?: boolean;
}

@doc("Resources created in GitHub repository.")
model GitHubResourceInfo {
  @doc("GitHub application installation id.")
  appInstallationId?: string;
}

@doc("Resources created in Azure DevOps repository.")
model AzureDevOpsResourceInfo {
  @doc("Id of the pipeline created for the source-control.")
  pipelineId?: string;

  @doc("Id of the service-connection created for the source-control.")
  serviceConnectionId?: string;
}

@doc("Information regarding a deployment.")
model DeploymentInfo {
  @doc("Status while fetching the last deployment.")
  deploymentFetchStatus?: DeploymentFetchStatus;

  @doc("Deployment information.")
  deployment?: Deployment;

  @doc("Additional details about the deployment that can be shown to the user.")
  message?: string;
}

@doc("Description about a deployment.")
model Deployment {
  @doc("Deployment identifier.")
  deploymentId?: string;

  @doc("Current status of the deployment.")
  deploymentState?: DeploymentState;

  @doc("The outcome of the deployment.")
  deploymentResult?: DeploymentResult;

  @doc("The time when the deployment finished.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  deploymentTime?: utcDateTime;

  @doc("Url to access repository action logs.")
  deploymentLogsUrl?: string;
}

@doc("Threat intelligence indicator entity.")
model ThreatIntelligenceIndicatorModel extends ThreatIntelligenceInformation {
  @doc("Threat Intelligence Entity properties")
  properties?: ThreatIntelligenceIndicatorProperties;

  @doc("The kind of the entity.")
  kind: "indicator";
}

@doc("Describes threat intelligence entity properties")
model ThreatIntelligenceIndicatorProperties {
  ...EntityCommonProperties;

  @doc("List of tags")
  threatIntelligenceTags?: string[];

  @doc("Last updated time in UTC")
  lastUpdatedTimeUtc?: string;

  @doc("Source of a threat intelligence entity")
  source?: string;

  @doc("Display name of a threat intelligence entity")
  displayName?: string;

  @doc("Description of a threat intelligence entity")
  description?: string;

  @doc("Indicator types of threat intelligence entities")
  indicatorTypes?: string[];

  @doc("Pattern of a threat intelligence entity")
  pattern?: string;

  @doc("Pattern type of a threat intelligence entity")
  patternType?: string;

  @doc("Pattern version of a threat intelligence entity")
  patternVersion?: string;

  @doc("Kill chain phases")
  killChainPhases?: ThreatIntelligenceKillChainPhase[];

  @doc("Parsed patterns")
  parsedPattern?: ThreatIntelligenceParsedPattern[];

  @doc("External ID of threat intelligence entity")
  externalId?: string;

  @doc("Created by reference of threat intelligence entity")
  createdByRef?: string;

  @doc("Is threat intelligence entity defanged")
  defanged?: boolean;

  @doc("External last updated time in UTC")
  externalLastUpdatedTimeUtc?: string;

  @doc("External References")
  externalReferences?: ThreatIntelligenceExternalReference[];

  @doc("Granular Markings")
  granularMarkings?: ThreatIntelligenceGranularMarkingModel[];

  @doc("Labels  of threat intelligence entity")
  labels?: string[];

  @doc("Is threat intelligence entity revoked")
  revoked?: boolean;

  @doc("Confidence of threat intelligence entity")
  confidence?: int32;

  @doc("Threat intelligence entity object marking references")
  objectMarkingRefs?: string[];

  @doc("Language of threat intelligence entity")
  language?: string;

  @doc("Threat types")
  threatTypes?: string[];

  @doc("Valid from")
  validFrom?: string;

  @doc("Valid until")
  validUntil?: string;

  @doc("Created by")
  created?: string;

  @doc("Modified by")
  modified?: string;

  @doc("Extensions map")
  extensions?: Record<unknown>;
}

@doc("Describes threat kill chain phase entity")
model ThreatIntelligenceKillChainPhase {
  @doc("Kill chainName name")
  killChainName?: string;

  @doc("Phase name")
  phaseName?: string;
}

@doc("Describes parsed pattern entity")
model ThreatIntelligenceParsedPattern {
  @doc("Pattern type key")
  patternTypeKey?: string;

  @doc("Pattern type keys")
  patternTypeValues?: ThreatIntelligenceParsedPatternTypeValue[];
}

@doc("Describes threat kill chain phase entity")
model ThreatIntelligenceParsedPatternTypeValue {
  @doc("Type of the value")
  valueType?: string;

  @doc("Value of parsed pattern")
  value?: string;
}

@doc("Describes external reference")
model ThreatIntelligenceExternalReference {
  @doc("External reference description")
  description?: string;

  @doc("External reference ID")
  externalId?: string;

  @doc("External reference source name")
  sourceName?: string;

  @doc("External reference URL")
  url?: string;

  @doc("External reference hashes")
  hashes?: Record<string>;
}

@doc("Describes threat granular marking model entity")
model ThreatIntelligenceGranularMarkingModel {
  @doc("Language granular marking model")
  language?: string;

  @doc("marking reference granular marking model")
  markingRef?: int32;

  @doc("granular marking model selectors")
  selectors?: string[];
}

@doc("Filtering criteria for querying threat intelligence indicators.")
model ThreatIntelligenceFilteringCriteria {
  @doc("Page size")
  pageSize?: int32;

  @doc("Minimum confidence.")
  minConfidence?: int32;

  @doc("Maximum confidence.")
  maxConfidence?: int32;

  @doc("Start time for ValidUntil filter.")
  minValidUntil?: string;

  @doc("End time for ValidUntil filter.")
  maxValidUntil?: string;

  @doc("Parameter to include/exclude disabled indicators.")
  includeDisabled?: boolean;

  @doc("Columns to sort by and sorting order")
  sortBy?: ThreatIntelligenceSortingCriteria[];

  @doc("Sources of threat intelligence indicators")
  sources?: string[];

  @doc("Pattern types")
  patternTypes?: string[];

  @doc("Threat types of threat intelligence indicators")
  threatTypes?: string[];

  @doc("Ids of threat intelligence indicators")
  ids?: string[];

  @doc("Keywords for searching threat intelligence indicators")
  keywords?: string[];

  @doc("Skip token.")
  skipToken?: string;
}

@doc("List of available columns for sorting")
model ThreatIntelligenceSortingCriteria {
  @doc("Column name")
  itemKey?: string;

  @doc("Sorting order (ascending/descending/unsorted).")
  sortOrder?: ThreatIntelligenceSortingCriteriaEnum;
}

@doc("List of all the threat intelligence metric fields (type/threat type/source).")
model ThreatIntelligenceMetricsList {
  @doc("Array of threat intelligence metric fields (type/threat type/source).")
  value: ThreatIntelligenceMetrics[];
}

@doc("Threat intelligence metrics.")
model ThreatIntelligenceMetrics {
  @doc("Threat intelligence metrics.")
  properties?: ThreatIntelligenceMetric;
}

@doc("Describes threat intelligence metric")
model ThreatIntelligenceMetric {
  @doc("Last updated indicator metric")
  lastUpdatedTimeUtc?: string;

  @doc("Threat type metrics")
  threatTypeMetrics?: ThreatIntelligenceMetricEntity[];

  @doc("Pattern type metrics")
  patternTypeMetrics?: ThreatIntelligenceMetricEntity[];

  @doc("Source metrics")
  sourceMetrics?: ThreatIntelligenceMetricEntity[];
}

@doc("Describes threat intelligence metric entity")
model ThreatIntelligenceMetricEntity {
  @doc("Metric name")
  metricName?: string;

  @doc("Metric value")
  metricValue?: int32;
}

@doc("Array of tags to be appended to the threat intelligence indicator.")
model ThreatIntelligenceAppendTags {
  @doc("List of tags to be appended.")
  threatIntelligenceTags?: string[];
}

@doc("Describes watchlist properties")
model WatchlistProperties {
  @doc("The id (a Guid) of the watchlist")
  watchlistId?: string;

  @doc("The display name of the watchlist")
  displayName: string;

  @doc("The provider of the watchlist")
  provider: string;

  @doc("The filename of the watchlist, called 'source'")
  source?: string;

  @doc("The sourceType of the watchlist")
  sourceType?: SourceType;

  @doc("The time the watchlist was created")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  created?: utcDateTime;

  @doc("The last time the watchlist was updated")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  updated?: utcDateTime;

  @doc("Describes a user that created the watchlist")
  createdBy?: UserInfo;

  @doc("Describes a user that updated the watchlist")
  updatedBy?: UserInfo;

  @doc("A description of the watchlist")
  description?: string;

  @doc("The type of the watchlist")
  watchlistType?: string;

  @doc("The alias of the watchlist")
  watchlistAlias?: string;

  @doc("A flag that indicates if the watchlist is deleted or not")
  isDeleted?: boolean;

  @doc("List of labels relevant to this watchlist")
  labels?: string[];

  @doc("The default duration of a watchlist (in ISO 8601 duration format)")
  defaultDuration?: duration;

  @doc("The tenantId where the watchlist belongs to")
  tenantId?: string;

  @doc("The number of lines in a csv/tsv content to skip before the header")
  numberOfLinesToSkip?: int32;

  @doc("The raw content that represents to watchlist items to create. In case of csv/tsv content type, it's the content of the file that will parsed by the endpoint")
  rawContent?: string;

  @doc("The search key is used to optimize query performance when using watchlists for joins with other data. For example, enable a column with IP addresses to be the designated SearchKey field, then use this field as the key field when joining to other event data by IP address.")
  itemsSearchKey: string;

  @doc("The content type of the raw content. Example : text/csv or text/tsv ")
  contentType?: string;

  @doc("The status of the Watchlist upload : New, InProgress or Complete. Pls note : When a Watchlist upload status is equal to InProgress, the Watchlist cannot be deleted")
  uploadStatus?: string;
}

@doc("Describes watchlist item properties")
model WatchlistItemProperties {
  @doc("The type of the watchlist item")
  watchlistItemType?: string;

  @doc("The id (a Guid) of the watchlist item")
  watchlistItemId?: string;

  @doc("The tenantId to which the watchlist item belongs to")
  tenantId?: string;

  @doc("A flag that indicates if the watchlist item is deleted or not")
  isDeleted?: boolean;

  @doc("The time the watchlist item was created")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  created?: utcDateTime;

  @doc("The last time the watchlist item was updated")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  updated?: utcDateTime;

  @doc("Describes a user that created the watchlist item")
  createdBy?: UserInfo;

  @doc("Describes a user that updated the watchlist item")
  updatedBy?: UserInfo;

  @doc("key-value pairs for a watchlist item")
  itemsKeyValue: Record<unknown>;

  @doc("key-value pairs for a watchlist item entity mapping")
  entityMapping?: Record<unknown>;
}

@doc("Represents Codeless API Polling data connector.")
model DataConnectorConnectBody {
  @doc("The authentication kind used to poll the data")
  kind?: ConnectAuthKind;

  @doc("The API key of the audit server.")
  apiKey?: string;

  @doc("Used in v2 logs connector. Represents the data collection ingestion endpoint in log analytics.")
  dataCollectionEndpoint?: string;

  @doc("Used in v2 logs connector. The data collection rule immutable id, the rule defines the transformation and data destination.")
  dataCollectionRuleImmutableId?: string;

  @doc("Used in v2 logs connector. The stream we are sending the data to, this is the name of the streamDeclarations defined in the DCR.")
  outputStream?: string;

  @doc("The client secret of the OAuth 2.0 application.")
  clientSecret?: string;

  @doc("The client id of the OAuth 2.0 application.")
  clientId?: string;

  @doc("The authorization code used in OAuth 2.0 code flow to issue a token.")
  authorizationCode?: string;

  @doc("The user name in the audit log server.")
  userName?: string;

  @doc("The user password in the audit log server.")
  password?: string;

  requestConfigUserInputValues?: Record<unknown>[];
}

@doc("Data connector requirements properties.")
@discriminator("kind")
model DataConnectorsCheckRequirements {}

@doc("Data connector requirements status.")
model DataConnectorRequirementsState {
  @doc("Authorization state for this connector")
  authorizationState?: DataConnectorAuthorizationState;

  @doc("License state for this connector")
  licenseState?: DataConnectorLicenseState;
}

@doc("Lists the operations available in the SecurityInsights RP.")
model OperationsList is Azure.Core.Page<Operation>;

@doc("alert rule template data sources")
model AlertRuleTemplateDataSource {
  @doc("The connector id that provides the following data types")
  connectorId?: string;

  @doc("The data types used by the alert rule template")
  dataTypes?: string[];
}

@doc("Base alert rule template property bag.")
model AlertRuleTemplatePropertiesBase {
  @doc("the number of alert rules that were created by this template")
  alertRulesCreatedByTemplateCount?: int32;

  @doc("The last time that this alert rule template has been updated.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdatedDateUTC?: utcDateTime;

  @doc("The time that this alert rule template has been added.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdDateUTC?: utcDateTime;

  @doc("The description of the alert rule template.")
  description?: string;

  @doc("The display name for alert rule template.")
  displayName?: string;

  @doc("The required data sources for this template")
  requiredDataConnectors?: AlertRuleTemplateDataSource[];

  @doc("The alert rule template status.")
  status?: TemplateStatus;
}

@doc("Alert rule template with MITRE property bag.")
model AlertRuleTemplateWithMitreProperties {
  ...AlertRuleTemplatePropertiesBase;

  @doc("The tactics of the alert rule")
  tactics?: AttackTactic[];

  @doc("The techniques of the alert rule")
  techniques?: string[];
}

@doc("Query based alert rule template base property bag.")
model QueryBasedAlertRuleTemplateProperties {
  @doc("The query that creates alerts for this rule.")
  query?: string;

  @doc("The severity for alerts created by this alert rule.")
  severity?: AlertSeverity;

  @doc("The version of this template - in format <a.b.c>, where all are numbers. For example <1.0.2>.")
  version?: string;

  @doc("Dictionary of string key-value pairs of columns to be attached to the alert")
  customDetails?: Record<string>;

  @doc("Array of the entity mappings of the alert rule")
  entityMappings?: EntityMapping[];

  @doc("The alert details override settings")
  alertDetailsOverride?: AlertDetailsOverride;

  @doc("The event grouping settings.")
  eventGroupingSettings?: EventGroupingSettings;

  @doc("Array of the sentinel entity mappings of the alert rule")
  sentinelEntitiesMappings?: SentinelEntityMapping[];
}

@doc("Single entity mapping for the alert rule")
model EntityMapping {
  @doc("The V3 type of the mapped entity")
  entityType?: EntityMappingType;

  @doc("array of field mappings for the given entity mapping")
  fieldMappings?: FieldMapping[];
}

@doc("A single field mapping of the mapped entity")
model FieldMapping {
  @doc("the V3 identifier of the entity")
  identifier?: string;

  @doc("the column name to be mapped to the identifier")
  columnName?: string;
}

@doc("Settings for how to dynamically override alert static details")
model AlertDetailsOverride {
  @doc("the format containing columns name(s) to override the alert name")
  alertDisplayNameFormat?: string;

  @doc("the format containing columns name(s) to override the alert description")
  alertDescriptionFormat?: string;

  @doc("the column name to take the alert tactics from")
  alertTacticsColumnName?: string;

  @doc("the column name to take the alert severity from")
  alertSeverityColumnName?: string;

  @doc("List of additional dynamic properties to override")
  alertDynamicProperties?: AlertPropertyMapping[];
}

@doc("A single alert property mapping to override")
model AlertPropertyMapping {
  @doc("The V3 alert property")
  alertProperty?: AlertProperty;

  @doc("the column name to use to override this property")
  value?: string;
}

@doc("Event grouping settings property bag.")
model EventGroupingSettings {
  @doc("The event grouping aggregation kinds")
  aggregationKind?: EventGroupingAggregationKind;
}

@doc("A single sentinel entity mapping")
model SentinelEntityMapping {
  @doc("the column name to be mapped to the SentinelEntities")
  columnName?: string;
}

@doc("Represents MLBehaviorAnalytics alert rule.")
model MLBehaviorAnalyticsAlertRule extends AlertRule {
  @doc("MLBehaviorAnalytics alert rule properties")
  properties?: MLBehaviorAnalyticsAlertRuleProperties;

  @doc("The kind of the alert rule")
  kind: "MLBehaviorAnalytics";
}

@doc("MLBehaviorAnalytics alert rule base property bag.")
model MLBehaviorAnalyticsAlertRuleProperties {
  @doc("The Name of the alert rule template used to create this rule.")
  alertRuleTemplateName: string;

  @doc("The description of the alert rule.")
  @visibility("read")
  description?: string;

  @doc("The display name for alerts created by this alert rule.")
  @visibility("read")
  displayName?: string;

  @doc("Determines whether this alert rule is enabled or disabled.")
  enabled: boolean;

  @doc("The last time that this alert rule has been modified.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedUtc?: utcDateTime;

  @doc("The severity for alerts created by this alert rule.")
  @visibility("read")
  severity?: AlertSeverity;

  @doc("The tactics of the alert rule")
  @visibility("read")
  tactics?: AttackTactic[];

  @doc("The techniques of the alert rule")
  @visibility("read")
  techniques?: string[];
}

@doc("Represents MLBehaviorAnalytics alert rule template.")
model MLBehaviorAnalyticsAlertRuleTemplate extends AlertRuleTemplate {
  @doc("MLBehaviorAnalytics alert rule template properties.")
  properties?: MLBehaviorAnalyticsAlertRuleTemplateProperties;

  @doc("The kind of the alert rule")
  kind: "MLBehaviorAnalytics";
}

@doc("MLBehaviorAnalytics alert rule template properties.")
model MLBehaviorAnalyticsAlertRuleTemplateProperties {
  ...AlertRuleTemplateWithMitreProperties;

  @doc("The severity for alerts created by this alert rule.")
  severity: AlertSeverity;
}

@doc("Represents Fusion alert rule.")
model FusionAlertRule extends AlertRule {
  @doc("Fusion alert rule properties")
  properties?: FusionAlertRuleProperties;

  @doc("The kind of the alert rule")
  kind: "Fusion";
}

@doc("Fusion alert rule base property bag.")
model FusionAlertRuleProperties {
  @doc("The Name of the alert rule template used to create this rule.")
  alertRuleTemplateName: string;

  @doc("The description of the alert rule.")
  @visibility("read")
  description?: string;

  @doc("The display name for alerts created by this alert rule.")
  @visibility("read")
  displayName?: string;

  @doc("Determines whether this alert rule is enabled or disabled.")
  enabled: boolean;

  @doc("Configuration for all supported source signals in fusion detection.")
  sourceSettings?: FusionSourceSettings[];

  @doc("Configuration to exclude scenarios in fusion detection.")
  scenarioExclusionPatterns?: FusionScenarioExclusionPattern[];

  @doc("The last time that this alert has been modified.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedUtc?: utcDateTime;

  @doc("The severity for alerts created by this alert rule.")
  @visibility("read")
  severity?: AlertSeverity;

  @doc("The tactics of the alert rule")
  @visibility("read")
  tactics?: AttackTactic[];

  @doc("The techniques of the alert rule")
  @visibility("read")
  techniques?: string[];
}

@doc("Represents a supported source signal configuration in Fusion detection.")
model FusionSourceSettings {
  @doc("Determines whether this source signal is enabled or disabled in Fusion detection.")
  enabled: boolean;

  @doc("Name of the Fusion source signal. Refer to Fusion alert rule template for supported values.")
  sourceName: string;

  @doc("Configuration for all source subtypes under this source signal consumed in fusion detection.")
  sourceSubTypes?: FusionSourceSubTypeSetting[];
}

@doc("Represents a supported source subtype configuration under a source signal in Fusion detection.")
model FusionSourceSubTypeSetting {
  @doc("Determines whether this source subtype under source signal is enabled or disabled in Fusion detection.")
  enabled: boolean;

  @doc("The Name of the source subtype under a given source signal in Fusion detection. Refer to Fusion alert rule template for supported values.")
  sourceSubTypeName: string;

  @doc("The display name of source subtype under a source signal consumed in Fusion detection.")
  @visibility("read")
  sourceSubTypeDisplayName?: string;

  @doc("Severity configuration for a source subtype consumed in fusion detection.")
  severityFilters: FusionSubTypeSeverityFilter;
}

@doc("Represents severity configuration for a source subtype consumed in Fusion detection.")
model FusionSubTypeSeverityFilter {
  @doc("Determines whether this source subtype supports severity configuration or not.")
  @visibility("read")
  isSupported?: boolean;

  @doc("Individual Severity configuration settings for a given source subtype consumed in Fusion detection.")
  filters?: FusionSubTypeSeverityFiltersItem[];
}

@doc("Represents a Severity filter setting for a given source subtype consumed in Fusion detection.")
model FusionSubTypeSeverityFiltersItem {
  @doc("The Severity for a given source subtype consumed in Fusion detection.")
  severity: AlertSeverity;

  @doc("Determines whether this severity is enabled or disabled for this source subtype consumed in Fusion detection.")
  enabled: boolean;
}

@doc("Represents a Fusion scenario exclusion patterns in Fusion detection.")
model FusionScenarioExclusionPattern {
  @doc("Scenario exclusion pattern.")
  exclusionPattern: string;

  @doc("DateTime when scenario exclusion pattern is added in UTC.")
  dateAddedInUTC: string;
}

@doc("Represents Fusion alert rule template.")
model FusionAlertRuleTemplate extends AlertRuleTemplate {
  @doc("Fusion alert rule template properties")
  properties?: FusionAlertRuleTemplateProperties;

  @doc("The kind of the alert rule")
  kind: "Fusion";
}

@doc("Fusion alert rule template properties")
model FusionAlertRuleTemplateProperties {
  @doc("the number of alert rules that were created by this template")
  alertRulesCreatedByTemplateCount?: int32;

  @doc("The time that this alert rule template has been added.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdDateUTC?: utcDateTime;

  @doc("The time that this alert rule template was last updated.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdatedDateUTC?: utcDateTime;

  @doc("The description of the alert rule template.")
  description?: string;

  @doc("The display name for alert rule template.")
  displayName?: string;

  @doc("The required data connectors for this template")
  requiredDataConnectors?: AlertRuleTemplateDataSource[];

  @doc("The alert rule template status.")
  status?: TemplateStatus;

  @doc("The severity for alerts created by this alert rule.")
  severity?: AlertSeverity;

  @doc("The tactics of the alert rule template")
  tactics?: AttackTactic[];

  @doc("The techniques of the alert rule")
  techniques?: string[];

  @doc("All supported source signal configurations consumed in fusion detection.")
  sourceSettings?: FusionTemplateSourceSetting[];
}

@doc("Represents a source signal consumed in Fusion detection.")
model FusionTemplateSourceSetting {
  @doc("The name of a source signal consumed in Fusion detection.")
  sourceName: string;

  @doc("All supported source subtypes under this source signal consumed in fusion detection.")
  sourceSubTypes?: FusionTemplateSourceSubType[];
}

@doc("Represents a source subtype under a source signal consumed in Fusion detection.")
model FusionTemplateSourceSubType {
  @doc("The name of source subtype under a source signal consumed in Fusion detection.")
  sourceSubTypeName: string;

  @doc("The display name of source subtype under a source signal consumed in Fusion detection.")
  @visibility("read")
  sourceSubTypeDisplayName?: string;

  @doc("Severity configuration available for a source subtype consumed in fusion detection.")
  severityFilter: FusionTemplateSubTypeSeverityFilter;
}

@doc("Represents severity configurations available for a source subtype consumed in Fusion detection.")
model FusionTemplateSubTypeSeverityFilter {
  @doc("Determines whether severity configuration is supported for this source subtype consumed in Fusion detection.")
  isSupported: boolean;

  @doc("List of all supported severities for this source subtype consumed in Fusion detection.")
  severityFilters?: AlertSeverity[];
}

@doc("Represents Threat Intelligence alert rule.")
model ThreatIntelligenceAlertRule extends AlertRule {
  @doc("Threat Intelligence alert rule properties")
  properties?: ThreatIntelligenceAlertRuleProperties;

  @doc("The kind of the alert rule")
  kind: "ThreatIntelligence";
}

@doc("Threat Intelligence alert rule base property bag.")
model ThreatIntelligenceAlertRuleProperties {
  @doc("The Name of the alert rule template used to create this rule.")
  alertRuleTemplateName: string;

  @doc("The description of the alert rule.")
  @visibility("read")
  description?: string;

  @doc("The display name for alerts created by this alert rule.")
  @visibility("read")
  displayName?: string;

  @doc("Determines whether this alert rule is enabled or disabled.")
  enabled: boolean;

  @doc("The last time that this alert has been modified.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedUtc?: utcDateTime;

  @doc("The severity for alerts created by this alert rule.")
  @visibility("read")
  severity?: AlertSeverity;

  @doc("The tactics of the alert rule")
  @visibility("read")
  tactics?: AttackTactic[];

  @doc("The techniques of the alert rule")
  @visibility("read")
  techniques?: string[];
}

@doc("Represents Threat Intelligence alert rule template.")
model ThreatIntelligenceAlertRuleTemplate extends AlertRuleTemplate {
  @doc("Threat Intelligence alert rule template properties")
  properties?: ThreatIntelligenceAlertRuleTemplateProperties;

  @doc("The kind of the alert rule")
  kind: "ThreatIntelligence";
}

@doc("Threat Intelligence alert rule template properties")
model ThreatIntelligenceAlertRuleTemplateProperties {
  ...AlertRuleTemplateWithMitreProperties;

  @doc("The severity for alerts created by this alert rule.")
  severity: AlertSeverity;
}

@doc("Represents MicrosoftSecurityIncidentCreation rule.")
model MicrosoftSecurityIncidentCreationAlertRule extends AlertRule {
  @doc("MicrosoftSecurityIncidentCreation rule properties")
  properties?: MicrosoftSecurityIncidentCreationAlertRuleProperties;

  @doc("The kind of the alert rule")
  kind: "MicrosoftSecurityIncidentCreation";
}

@doc("MicrosoftSecurityIncidentCreation rule property bag.")
model MicrosoftSecurityIncidentCreationAlertRuleProperties {
  ...MicrosoftSecurityIncidentCreationAlertRuleCommonProperties;

  @doc("The Name of the alert rule template used to create this rule.")
  alertRuleTemplateName?: string;

  @doc("The description of the alert rule.")
  description?: string;

  @doc("The display name for alerts created by this alert rule.")
  displayName: string;

  @doc("Determines whether this alert rule is enabled or disabled.")
  enabled: boolean;

  @doc("The last time that this alert has been modified.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedUtc?: utcDateTime;
}

@doc("MicrosoftSecurityIncidentCreation rule common property bag.")
model MicrosoftSecurityIncidentCreationAlertRuleCommonProperties {
  @doc("the alerts' displayNames on which the cases will be generated")
  displayNamesFilter?: string[];

  @doc("the alerts' displayNames on which the cases will not be generated")
  displayNamesExcludeFilter?: string[];

  @doc("The alerts' productName on which the cases will be generated")
  productFilter: MicrosoftSecurityProductName;

  @doc("the alerts' severities on which the cases will be generated")
  severitiesFilter?: AlertSeverity[];
}

@doc("Represents MicrosoftSecurityIncidentCreation rule template.")
model MicrosoftSecurityIncidentCreationAlertRuleTemplate
  extends AlertRuleTemplate {
  @doc("MicrosoftSecurityIncidentCreation rule template properties")
  properties?: MicrosoftSecurityIncidentCreationAlertRuleTemplateProperties;

  @doc("The kind of the alert rule")
  kind: "MicrosoftSecurityIncidentCreation";
}

@doc("MicrosoftSecurityIncidentCreation rule template properties")
model MicrosoftSecurityIncidentCreationAlertRuleTemplateProperties {
  ...AlertRuleTemplatePropertiesBase;

  @doc("the alerts' displayNames on which the cases will be generated")
  displayNamesFilter?: string[];

  @doc("the alerts' displayNames on which the cases will not be generated")
  displayNamesExcludeFilter?: string[];

  @doc("The alerts' productName on which the cases will be generated")
  productFilter?: MicrosoftSecurityProductName;

  @doc("the alerts' severities on which the cases will be generated")
  severitiesFilter?: AlertSeverity[];
}

@doc("Scheduled alert rule base property bag.")
model ScheduledAlertRuleProperties {
  ...ScheduledAlertRuleCommonProperties;

  @doc("The Name of the alert rule template used to create this rule.")
  alertRuleTemplateName?: string;

  @doc("The version of the alert rule template used to create this rule - in format <a.b.c>, where all are numbers, for example 0 <1.0.2>")
  templateVersion?: string;

  @doc("The description of the alert rule.")
  description?: string;

  @doc("The display name for alerts created by this alert rule.")
  displayName: string;

  @doc("Determines whether this alert rule is enabled or disabled.")
  enabled: boolean;

  @doc("The last time that this alert rule has been modified.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedUtc?: utcDateTime;

  @doc("The suppression (in ISO 8601 duration format) to wait since last time this alert rule been triggered.")
  suppressionDuration: duration;

  @doc("Determines whether the suppression for this alert rule is enabled or disabled.")
  suppressionEnabled: boolean;

  @doc("The tactics of the alert rule")
  tactics?: AttackTactic[];

  @doc("The techniques of the alert rule")
  techniques?: string[];

  @doc("The settings of the incidents that created from alerts triggered by this analytics rule")
  incidentConfiguration?: IncidentConfiguration;
}

@doc("Incident Configuration property bag.")
model IncidentConfiguration {
  @doc("Create incidents from alerts triggered by this analytics rule")
  createIncident: boolean;

  @doc("Set how the alerts that are triggered by this analytics rule, are grouped into incidents")
  groupingConfiguration?: GroupingConfiguration;
}

@doc("Grouping configuration property bag.")
model GroupingConfiguration {
  @doc("Grouping enabled")
  enabled: boolean;

  @doc("Re-open closed matching incidents")
  reopenClosedIncident: boolean;

  @doc("Limit the group to alerts created within the lookback duration (in ISO 8601 duration format)")
  lookbackDuration: duration;

  @doc("Grouping matching method. When method is Selected at least one of groupByEntities, groupByAlertDetails, groupByCustomDetails must be provided and not empty.")
  matchingMethod: MatchingMethod;

  @doc("A list of entity types to group by (when matchingMethod is Selected). Only entities defined in the current alert rule may be used.")
  groupByEntities?: EntityMappingType[];

  @doc("A list of alert details to group by (when matchingMethod is Selected)")
  groupByAlertDetails?: AlertDetail[];

  @doc("A list of custom details keys to group by (when matchingMethod is Selected). Only keys defined in the current alert rule may be used.")
  groupByCustomDetails?: string[];
}

@doc("Scheduled alert rule template property bag.")
model ScheduledAlertRuleCommonProperties {
  @doc("The query that creates alerts for this rule.")
  query?: string;

  @doc("The frequency (in ISO 8601 duration format) for this alert rule to run.")
  queryFrequency?: duration;

  @doc("The period (in ISO 8601 duration format) that this alert rule looks at.")
  queryPeriod?: duration;

  @doc("The severity for alerts created by this alert rule.")
  severity?: AlertSeverity;

  @doc("The operation against the threshold that triggers alert rule.")
  triggerOperator?: TriggerOperator;

  @doc("The threshold triggers this alert rule.")
  triggerThreshold?: int32;

  @doc("The event grouping settings.")
  eventGroupingSettings?: EventGroupingSettings;

  @doc("Dictionary of string key-value pairs of columns to be attached to the alert")
  customDetails?: Record<string>;

  @doc("Array of the entity mappings of the alert rule")
  entityMappings?: EntityMapping[];

  @doc("The alert details override settings")
  alertDetailsOverride?: AlertDetailsOverride;

  @doc("Array of the sentinel entity mappings of the alert rule")
  sentinelEntitiesMappings?: SentinelEntityMapping[];
}

@doc("Nrt alert rule base property bag.")
model NrtAlertRuleProperties {
  @doc("The Name of the alert rule template used to create this rule.")
  alertRuleTemplateName?: string;

  @doc("The version of the alert rule template used to create this rule - in format <a.b.c>, where all are numbers, for example 0 <1.0.2>")
  templateVersion?: string;

  @doc("The description of the alert rule.")
  description?: string;

  @doc("The query that creates alerts for this rule.")
  query: string;

  @doc("The tactics of the alert rule")
  tactics?: AttackTactic[];

  @doc("The techniques of the alert rule")
  techniques?: string[];

  @doc("The display name for alerts created by this alert rule.")
  displayName: string;

  @doc("Determines whether this alert rule is enabled or disabled.")
  enabled: boolean;

  @doc("The last time that this alert rule has been modified.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedUtc?: utcDateTime;

  @doc("The suppression (in ISO 8601 duration format) to wait since last time this alert rule been triggered.")
  suppressionDuration: duration;

  @doc("Determines whether the suppression for this alert rule is enabled or disabled.")
  suppressionEnabled: boolean;

  @doc("The severity for alerts created by this alert rule.")
  severity: AlertSeverity;

  @doc("The settings of the incidents that created from alerts triggered by this analytics rule")
  incidentConfiguration?: IncidentConfiguration;

  @doc("Dictionary of string key-value pairs of columns to be attached to the alert")
  customDetails?: Record<string>;

  @doc("Array of the entity mappings of the alert rule")
  entityMappings?: EntityMapping[];

  @doc("The alert details override settings")
  alertDetailsOverride?: AlertDetailsOverride;

  @doc("The event grouping settings.")
  eventGroupingSettings?: EventGroupingSettings;

  @doc("Array of the sentinel entity mappings of the alert rule")
  sentinelEntitiesMappings?: SentinelEntityMapping[];
}

@doc("Scheduled alert rule template properties")
model ScheduledAlertRuleTemplateProperties {
  @doc("the number of alert rules that were created by this template")
  alertRulesCreatedByTemplateCount?: int32;

  @doc("The time that this alert rule template has been added.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdDateUTC?: utcDateTime;

  @doc("The time that this alert rule template was last updated.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdatedDateUTC?: utcDateTime;

  @doc("The description of the alert rule template.")
  description?: string;

  @doc("The display name for alert rule template.")
  displayName?: string;

  @doc("The required data connectors for this template")
  requiredDataConnectors?: AlertRuleTemplateDataSource[];

  @doc("The alert rule template status.")
  status?: TemplateStatus;

  @doc("The query that creates alerts for this rule.")
  query?: string;

  @doc("The frequency (in ISO 8601 duration format) for this alert rule to run.")
  queryFrequency?: duration;

  @doc("The period (in ISO 8601 duration format) that this alert rule looks at.")
  queryPeriod?: duration;

  @doc("The severity for alerts created by this alert rule.")
  severity?: AlertSeverity;

  @doc("The operation against the threshold that triggers alert rule.")
  triggerOperator?: TriggerOperator;

  @doc("The threshold triggers this alert rule.")
  triggerThreshold?: int32;

  @doc("The tactics of the alert rule template")
  tactics?: AttackTactic[];

  @doc("The techniques of the alert rule")
  techniques?: string[];

  @doc("The version of this template - in format <a.b.c>, where all are numbers. For example <1.0.2>.")
  version?: string;

  @doc("The event grouping settings.")
  eventGroupingSettings?: EventGroupingSettings;

  @doc("Dictionary of string key-value pairs of columns to be attached to the alert")
  customDetails?: Record<string>;

  @doc("Array of the entity mappings of the alert rule")
  entityMappings?: EntityMapping[];

  @doc("The alert details override settings")
  alertDetailsOverride?: AlertDetailsOverride;

  @doc("Array of the sentinel entity mappings of the alert rule")
  sentinelEntitiesMappings?: SentinelEntityMapping[];
}

@doc("Represents scheduled alert rule template.")
model ScheduledAlertRuleTemplate extends AlertRuleTemplate {
  @doc("Scheduled alert rule template properties")
  properties?: ScheduledAlertRuleTemplateProperties;

  @doc("The kind of the alert rule")
  kind: "Scheduled";
}

@doc("Represents NRT alert rule template.")
model NrtAlertRuleTemplate extends AlertRuleTemplate {
  @doc("NRT alert rule template properties")
  properties?: NrtAlertRuleTemplateProperties;

  @doc("The kind of the alert rule")
  kind: "NRT";
}

@doc("NRT alert rule template properties")
model NrtAlertRuleTemplateProperties {
  ...AlertRuleTemplateWithMitreProperties;
  ...QueryBasedAlertRuleTemplateProperties;
}

@doc("Represents scheduled alert rule.")
model ScheduledAlertRule extends AlertRule {
  @doc("Scheduled alert rule properties")
  properties?: ScheduledAlertRuleProperties;

  @doc("The kind of the alert rule")
  kind: "Scheduled";
}

@doc("Represents NRT alert rule.")
model NrtAlertRule extends AlertRule {
  @doc("NRT alert rule properties")
  properties?: NrtAlertRuleProperties;

  @doc("The kind of the alert rule")
  kind: "NRT";
}

model AddIncidentTaskActionProperties {
  @doc("The title of the task.")
  title: string;

  @doc("The description of the task.")
  description?: string;
}

@doc("Describes an automation rule action to add a task to an incident")
model AutomationRuleAddIncidentTaskAction extends AutomationRuleAction {
  actionConfiguration?: AddIncidentTaskActionProperties;

  @doc("The type of the automation rule action.")
  actionType: "AddIncidentTask";
}

model AutomationRuleBooleanCondition {
  operator?: AutomationRuleBooleanConditionSupportedOperator;
  innerConditions?: AutomationRuleCondition[];
}

@doc("Describes an automation rule action to modify an object's properties")
model AutomationRuleModifyPropertiesAction extends AutomationRuleAction {
  actionConfiguration?: IncidentPropertiesAction;

  @doc("The type of the automation rule action.")
  actionType: "ModifyProperties";
}

model IncidentPropertiesAction {
  @doc("The severity of the incident")
  severity?: IncidentSeverity;

  @doc("The status of the incident")
  status?: IncidentStatus;

  @doc("The reason the incident was closed")
  classification?: IncidentClassification;

  @doc("The classification reason the incident was closed with")
  classificationReason?: IncidentClassificationReason;

  @doc("Describes the reason the incident was closed.")
  classificationComment?: string;

  @doc("Information on the user an incident is assigned to")
  owner?: IncidentOwnerInfo;

  @doc("List of labels to add to the incident.")
  labels?: IncidentLabel[];
}

model AutomationRulePropertyArrayChangedValuesCondition {
  arrayType?: AutomationRulePropertyArrayChangedConditionSupportedArrayType;
  changeType?: AutomationRulePropertyArrayChangedConditionSupportedChangeType;
}

model AutomationRulePropertyArrayValuesCondition {
  arrayType?: AutomationRulePropertyArrayConditionSupportedArrayType;
  arrayConditionType?: AutomationRulePropertyArrayConditionSupportedArrayConditionType;
  itemConditions?: AutomationRuleCondition[];
}

model AutomationRulePropertyValuesChangedCondition {
  propertyName?: AutomationRulePropertyChangedConditionSupportedPropertyType;
  changeType?: AutomationRulePropertyChangedConditionSupportedChangedType;
  operator?: AutomationRulePropertyConditionSupportedOperator;
  propertyValues?: string[];
}

model AutomationRulePropertyValuesCondition {
  @doc("The property to evaluate in an automation rule property condition.")
  propertyName?: AutomationRulePropertyConditionSupportedProperty;

  operator?: AutomationRulePropertyConditionSupportedOperator;
  propertyValues?: string[];
}

@doc("Describes an automation rule action to run a playbook")
model AutomationRuleRunPlaybookAction extends AutomationRuleAction {
  actionConfiguration?: PlaybookActionProperties;

  @doc("The type of the automation rule action.")
  actionType: "RunPlaybook";
}

model PlaybookActionProperties {
  @doc("The resource id of the playbook resource.")
  logicAppResourceId?: string;

  @doc("The tenant id of the playbook resource.")
  tenantId?: string;
}

@doc("Describes an automation rule condition that applies a boolean operator (e.g AND, OR) to conditions")
model BooleanConditionProperties extends AutomationRuleCondition {
  conditionProperties?: AutomationRuleBooleanCondition;
  conditionType: "Boolean";
}

@doc("Describes an automation rule condition that evaluates an array property's value change")
model PropertyArrayChangedConditionProperties extends AutomationRuleCondition {
  conditionProperties?: AutomationRulePropertyArrayChangedValuesCondition;
  conditionType: "PropertyArrayChanged";
}

@doc("Describes an automation rule condition that evaluates an array property's value")
model PropertyArrayConditionProperties extends AutomationRuleCondition {
  conditionProperties?: AutomationRulePropertyArrayValuesCondition;
  conditionType: "PropertyArray";
}

@doc("Describes an automation rule condition that evaluates a property's value change")
model PropertyChangedConditionProperties extends AutomationRuleCondition {
  conditionProperties?: AutomationRulePropertyValuesChangedCondition;
  conditionType: "PropertyChanged";
}

@doc("Describes an automation rule condition that evaluates a property's value")
model PropertyConditionProperties extends AutomationRuleCondition {
  conditionProperties?: AutomationRulePropertyValuesCondition;
  conditionType: "Property";
}

@doc("Represents Activity timeline item.")
model ActivityTimelineItem extends EntityTimelineItem {
  @doc("The activity query id.")
  queryId: string;

  @doc("The grouping bucket start time.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  bucketStartTimeUTC: utcDateTime;

  @doc("The grouping bucket end time.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  bucketEndTimeUTC: utcDateTime;

  @doc("The time of the first activity in the grouping bucket.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  firstActivityTimeUTC: utcDateTime;

  @doc("The time of the last activity in the grouping bucket.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastActivityTimeUTC: utcDateTime;

  @doc("The activity timeline content.")
  content: string;

  @doc("The activity timeline title.")
  title: string;

  @doc("The entity query kind type.")
  kind: "Activity";
}

@doc("Represents bookmark timeline item.")
model BookmarkTimelineItem extends EntityTimelineItem {
  @doc("The bookmark azure resource id.")
  azureResourceId: string;

  @doc("The bookmark display name.")
  displayName?: string;

  @doc("The notes of the bookmark")
  notes?: string;

  @doc("The bookmark end time.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTimeUtc?: utcDateTime;

  @doc("The bookmark start time.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTimeUtc?: utcDateTime;

  @doc("The bookmark event time.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  eventTime?: utcDateTime;

  @doc("Describes a user that created the bookmark")
  createdBy?: UserInfo;

  @doc("List of labels relevant to this bookmark")
  labels?: string[];

  @doc("The entity query kind type.")
  kind: "Bookmark";
}

@doc("Represents anomaly timeline item.")
model AnomalyTimelineItem extends EntityTimelineItem {
  @doc("The anomaly azure resource id.")
  azureResourceId: string;

  @doc("The anomaly product name.")
  productName?: string;

  @doc("The anomaly description.")
  description?: string;

  @doc("The anomaly name.")
  displayName: string;

  @doc("The anomaly end time.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTimeUtc: utcDateTime;

  @doc("The anomaly start time.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTimeUtc: utcDateTime;

  @doc("The anomaly generated time.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timeGenerated: utcDateTime;

  @doc("The name of the anomaly vendor.")
  vendor?: string;

  @doc("The intent of the anomaly.")
  intent?: string;

  @doc("The techniques of the anomaly.")
  techniques?: string[];

  @doc("The reasons that cause the anomaly.")
  reasons?: string[];

  @doc("The entity query kind type.")
  kind: "Anomaly";
}

@doc("An properties abstract Query item for entity")
model EntityQueryItemProperties {
  @doc("Data types for template")
  dataTypes?: EntityQueryItemPropertiesDataTypesItem[];

  @doc("The type of the entity")
  inputEntityType?: EntityType;

  @doc("Data types for template")
  requiredInputFieldsSets?: string[][];

  @doc("The query applied only to entities matching to all filters")
  entitiesFilter?: Record<unknown>;
}

model EntityQueryItemPropertiesDataTypesItem {
  @doc("Data type name")
  dataType?: string;
}

@doc("Represents Insight Query.")
model InsightQueryItem extends EntityQueryItem {
  @doc("Properties bag for InsightQueryItem")
  properties?: InsightQueryItemProperties;

  @doc("The kind of the entity query")
  kind: "Insight";
}

@doc("Represents Insight Query.")
model InsightQueryItemProperties {
  ...EntityQueryItemProperties;

  @doc("The insight display name.")
  displayName?: string;

  @doc("The insight description.")
  description?: string;

  @doc("The base query of the insight.")
  baseQuery?: string;

  @doc("The insight table query.")
  tableQuery?: InsightQueryItemPropertiesTableQuery;

  @doc("The insight chart query.")
  chartQuery?: Record<unknown>;

  @doc("The activity query definitions.")
  additionalQuery?: InsightQueryItemPropertiesAdditionalQuery;

  @doc("The insight chart query.")
  defaultTimeRange?: InsightQueryItemPropertiesDefaultTimeRange;

  @doc("The insight chart query.")
  referenceTimeRange?: InsightQueryItemPropertiesReferenceTimeRange;
}

@doc("The insight table query.")
model InsightQueryItemPropertiesTableQuery {
  @doc("List of insight column definitions.")
  columnsDefinitions?: InsightQueryItemPropertiesTableQueryColumnsDefinitionsItem[];

  @doc("List of insight queries definitions.")
  queriesDefinitions?: InsightQueryItemPropertiesTableQueryQueriesDefinitionsItem[];
}

model InsightQueryItemPropertiesTableQueryColumnsDefinitionsItem {
  @doc("Insight column header.")
  header?: string;

  @doc("Insights Column type.")
  outputType?: OutputType;

  @doc("Is query supports deep-link.")
  supportDeepLink?: boolean;
}

model InsightQueryItemPropertiesTableQueryQueriesDefinitionsItem {
  @doc("Insight column header.")
  filter?: string;

  @doc("Insight column header.")
  summarize?: string;

  @doc("Insight column header.")
  project?: string;

  @doc("Insight column header.")
  linkColumnsDefinitions?: InsightQueryItemPropertiesTableQueryQueriesDefinitionsPropertiesItemsItem[];
}

model InsightQueryItemPropertiesTableQueryQueriesDefinitionsPropertiesItemsItem {
  @doc("Insight Link Definition Projected Name.")
  projectedName?: string;

  @doc("Insight Link Definition Query.")
  @projectedName("json", "Query")
  query?: string;
}

@doc("The activity query definitions.")
model InsightQueryItemPropertiesAdditionalQuery {
  @doc("The insight query.")
  query?: string;

  @doc("The insight text.")
  text?: string;
}

@doc("The insight chart query.")
model InsightQueryItemPropertiesDefaultTimeRange {
  @doc("The padding for the start time of the query.")
  beforeRange?: string;

  @doc("The padding for the end time of the query.")
  afterRange?: string;
}

@doc("The insight chart query.")
model InsightQueryItemPropertiesReferenceTimeRange {
  @doc("Additional query time for looking back.")
  beforeRange?: string;
}

@doc("Represents security alert timeline item.")
model SecurityAlertTimelineItem extends EntityTimelineItem {
  @doc("The alert azure resource id.")
  azureResourceId: string;

  @doc("The alert product name.")
  productName?: string;

  @doc("The alert description.")
  description?: string;

  @doc("The alert name.")
  displayName: string;

  @doc("The alert severity.")
  severity: AlertSeverity;

  @doc("The alert end time.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTimeUtc: utcDateTime;

  @doc("The alert start time.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTimeUtc: utcDateTime;

  @doc("The alert generated time.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timeGenerated: utcDateTime;

  @doc("The name of the alert type.")
  alertType: string;

  @doc("The intent of the alert.")
  @visibility("read")
  intent?: KillChainIntent;

  @doc("The techniques of the alert.")
  techniques?: string[];

  @doc("The entity query kind type.")
  kind: "SecurityAlert";
}

@doc("Represents Expansion entity query.")
model ExpansionEntityQuery extends EntityQuery {
  @doc("Expansion entity query properties")
  properties?: ExpansionEntityQueriesProperties;

  @doc("the entity query kind")
  kind: "Expansion";
}

@doc("Describes expansion entity query properties")
model ExpansionEntityQueriesProperties {
  @doc("List of the data sources that are required to run the query")
  dataSources?: string[];

  @doc("The query display name")
  displayName?: string;

  @doc("The type of the query's source entity")
  inputEntityType?: EntityType;

  @doc("List of the fields of the source entity that are required to run the query")
  inputFields?: string[];

  @doc("List of the desired output types to be constructed from the result")
  outputEntityTypes?: EntityType[];

  @doc("The template query string to be parsed and formatted")
  queryTemplate?: string;
}

@doc("Represents Activity entity query.")
model ActivityEntityQuery extends EntityQuery {
  @doc("Activity entity query properties")
  properties?: ActivityEntityQueriesProperties;

  @doc("the entity query kind")
  kind: "Activity";
}

@doc("Describes activity entity query properties")
model ActivityEntityQueriesProperties {
  @doc("The entity query title")
  title?: string;

  @doc("The entity query content to display in timeline")
  content?: string;

  @doc("The entity query description")
  description?: string;

  @doc("The Activity query definitions")
  queryDefinitions?: ActivityEntityQueriesPropertiesQueryDefinitions;

  @doc("The type of the query's source entity")
  inputEntityType?: EntityType;

  @doc("List of the fields of the source entity that are required to run the query")
  requiredInputFieldsSets?: string[][];

  @doc("The query applied only to entities matching to all filters")
  entitiesFilter?: Record<string[]>;

  @doc("The template id this activity was created from")
  templateName?: string;

  @doc("Determines whether this activity is enabled or disabled.")
  enabled?: boolean;

  @doc("The time the activity was created")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdTimeUtc?: utcDateTime;

  @doc("The last time the activity was updated")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTimeUtc?: utcDateTime;
}

@doc("The Activity query definitions")
model ActivityEntityQueriesPropertiesQueryDefinitions {
  @doc("The Activity query to run on a given entity")
  query?: string;
}

@doc("Represents Activity entity query.")
model ActivityCustomEntityQuery extends CustomEntityQuery {
  @doc("Activity entity query properties")
  properties?: ActivityEntityQueriesProperties;

  @doc("the entity query kind")
  kind: "Activity";
}

@doc("Represents Activity entity query.")
model ActivityEntityQueryTemplate extends EntityQueryTemplate {
  @doc("Activity entity query properties")
  properties?: ActivityEntityQueryTemplateProperties;

  @doc("the entity query template kind")
  kind: "Activity";
}

@doc("Describes activity entity query properties")
model ActivityEntityQueryTemplateProperties {
  @doc("The entity query title")
  title?: string;

  @doc("The entity query content to display in timeline")
  content?: string;

  @doc("The entity query description")
  description?: string;

  @doc("The Activity query definitions")
  queryDefinitions?: ActivityEntityQueryTemplatePropertiesQueryDefinitions;

  @doc("List of required data types for the given entity query template")
  dataTypes?: DataTypeDefinitions[];

  @doc("The type of the query's source entity")
  inputEntityType?: EntityType;

  @doc("List of the fields of the source entity that are required to run the query")
  requiredInputFieldsSets?: string[][];

  @doc("The query applied only to entities matching to all filters")
  entitiesFilter?: Record<string[]>;
}

@doc("The Activity query definitions")
model ActivityEntityQueryTemplatePropertiesQueryDefinitions {
  @doc("The Activity query to run on a given entity")
  query?: string;

  @doc("The dimensions we want to summarize the timeline results on, this is comma separated list")
  summarizeBy?: string;
}

@doc("The data type definition")
model DataTypeDefinitions {
  @doc("The data type name")
  dataType?: string;
}

@doc("Describes team properties")
model TeamProperties {
  @doc("The name of the team")
  teamName: string;

  @doc("The description of the team")
  teamDescription?: string;

  @doc("List of group IDs to add their members to the team")
  groupIds?: string[];

  @doc("List of member IDs to add to the team")
  memberIds?: string[];
}

@doc("Represents Anomaly Security ML Analytics Settings")
model AnomalySecurityMLAnalyticsSettings extends SecurityMLAnalyticsSetting {
  @doc("Anomaly Security ML Analytics Settings properties")
  properties?: AnomalySecurityMLAnalyticsSettingsProperties;

  @doc("The kind of security ML Analytics Settings")
  kind: "Anomaly";
}

@doc("AnomalySecurityMLAnalytics settings base property bag.")
model AnomalySecurityMLAnalyticsSettingsProperties {
  @doc("The description of the SecurityMLAnalyticsSettings.")
  description?: string;

  @doc("The display name for settings created by this SecurityMLAnalyticsSettings.")
  displayName: string;

  @doc("Determines whether this settings is enabled or disabled.")
  enabled: boolean;

  @doc("The last time that this SecurityMLAnalyticsSettings has been modified.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedUtc?: utcDateTime;

  @doc("The required data sources for this SecurityMLAnalyticsSettings")
  requiredDataConnectors?: SecurityMLAnalyticsSettingsDataSource[];

  @doc("The tactics of the SecurityMLAnalyticsSettings")
  tactics?: AttackTactic[];

  @doc("The techniques of the SecurityMLAnalyticsSettings")
  techniques?: string[];

  @doc("The anomaly version of the AnomalySecurityMLAnalyticsSettings.")
  anomalyVersion: string;

  @doc("The customizable observations of the AnomalySecurityMLAnalyticsSettings.")
  customizableObservations?: Record<unknown>;

  @doc("The frequency that this SecurityMLAnalyticsSettings will be run.")
  frequency: duration;

  @doc("The anomaly SecurityMLAnalyticsSettings status")
  settingsStatus: SettingsStatus;

  @doc("Determines whether this anomaly security ml analytics settings is a default settings")
  isDefaultSettings: boolean;

  @doc("The anomaly settings version of the Anomaly security ml analytics settings that dictates whether job version gets updated or not.")
  anomalySettingsVersion?: int32;

  @doc("The anomaly settings definition Id")
  settingsDefinitionId?: string;
}

@doc("security ml analytics settings data sources")
model SecurityMLAnalyticsSettingsDataSource {
  @doc("The connector id that provides the following data types")
  connectorId?: string;

  @doc("The data types used by the security ml analytics settings")
  dataTypes?: string[];
}

@doc("Settings with single toggle.")
model Anomalies extends Settings {
  @doc("Anomalies properties")
  properties?: AnomaliesSettingsProperties;

  @doc("The kind of the setting")
  kind: "Anomalies";
}

@doc("Anomalies property bag.")
model AnomaliesSettingsProperties {
  @doc("Determines whether the setting is enable or disabled.")
  @visibility("read")
  isEnabled?: boolean;
}

@doc("Settings with single toggle.")
model EyesOn extends Settings {
  @doc("EyesOn properties")
  properties?: EyesOnSettingsProperties;

  @doc("The kind of the setting")
  kind: "EyesOn";
}

@doc("EyesOn property bag.")
model EyesOnSettingsProperties {
  @doc("Determines whether the setting is enable or disabled.")
  @visibility("read")
  isEnabled?: boolean;
}

@doc("Settings with single toggle.")
model EntityAnalytics extends Settings {
  @doc("EntityAnalytics properties")
  properties?: EntityAnalyticsProperties;

  @doc("The kind of the setting")
  kind: "EntityAnalytics";
}

@doc("EntityAnalytics property bag.")
model EntityAnalyticsProperties {
  @doc("The relevant entity providers that are synced")
  entityProviders?: EntityProviders[];
}

@doc("Settings with single toggle.")
model Ueba extends Settings {
  @doc("Ueba properties")
  properties?: UebaProperties;

  @doc("The kind of the setting")
  kind: "Ueba";
}

@doc("Ueba property bag.")
model UebaProperties {
  @doc("The relevant data sources that enriched by ueba")
  dataSources?: UebaDataSources[];
}

@doc("Represents AAD (Azure Active Directory) requirements check request.")
model AADCheckRequirements extends DataConnectorsCheckRequirements {
  @doc("AAD (Azure Active Directory) requirements check properties.")
  properties?: AADCheckRequirementsProperties;

  @doc("Describes the kind of connector to be checked.")
  kind: "AzureActiveDirectory";
}

@doc("AAD (Azure Active Directory) requirements check properties.")
model AADCheckRequirementsProperties {
  ...DataConnectorTenantId;
}

@doc("Properties data connector on tenant level.")
model DataConnectorTenantId {
  @doc("The tenant id to connect to, and get the data from.")
  tenantId: string;
}

@doc("Represents AATP (Azure Advanced Threat Protection) requirements check request.")
model AatpCheckRequirements extends DataConnectorsCheckRequirements {
  @doc("AATP (Azure Advanced Threat Protection) requirements check properties.")
  properties?: AatpCheckRequirementsProperties;

  @doc("Describes the kind of connector to be checked.")
  kind: "AzureAdvancedThreatProtection";
}

@doc("AATP (Azure Advanced Threat Protection) requirements check properties.")
model AatpCheckRequirementsProperties {
  ...DataConnectorTenantId;
}

@doc("Represents ASC (Azure Security Center) requirements check request.")
model ASCCheckRequirements extends DataConnectorsCheckRequirements {
  @doc("ASC (Azure Security Center) requirements check properties.")
  properties?: ASCCheckRequirementsProperties;

  @doc("Describes the kind of connector to be checked.")
  kind: "AzureSecurityCenter";
}

@doc("ASC (Azure Security Center) requirements check properties.")
model ASCCheckRequirementsProperties {
  @doc("The subscription id to connect to, and get the data from.")
  subscriptionId?: string;
}

@doc("Amazon Web Services CloudTrail requirements check request.")
model AwsCloudTrailCheckRequirements extends DataConnectorsCheckRequirements {
  @doc("Describes the kind of connector to be checked.")
  kind: "AmazonWebServicesCloudTrail";
}

@doc("Amazon Web Services S3 requirements check request.")
model AwsS3CheckRequirements extends DataConnectorsCheckRequirements {
  @doc("Describes the kind of connector to be checked.")
  kind: "AmazonWebServicesS3";
}

@doc("Represents Dynamics365 requirements check request.")
model Dynamics365CheckRequirements extends DataConnectorsCheckRequirements {
  @doc("Dynamics365 requirements check properties.")
  properties?: Dynamics365CheckRequirementsProperties;

  @doc("Describes the kind of connector to be checked.")
  kind: "Dynamics365";
}

@doc("Dynamics365 requirements check properties.")
model Dynamics365CheckRequirementsProperties {
  ...DataConnectorTenantId;
}

@doc("Represents MCAS (Microsoft Cloud App Security) requirements check request.")
model McasCheckRequirements extends DataConnectorsCheckRequirements {
  @doc("MCAS (Microsoft Cloud App Security) requirements check properties.")
  properties?: McasCheckRequirementsProperties;

  @doc("Describes the kind of connector to be checked.")
  kind: "MicrosoftCloudAppSecurity";
}

@doc("MCAS (Microsoft Cloud App Security) requirements check properties.")
model McasCheckRequirementsProperties {
  ...DataConnectorTenantId;
}

@doc("Represents MDATP (Microsoft Defender Advanced Threat Protection) requirements check request.")
model MdatpCheckRequirements extends DataConnectorsCheckRequirements {
  @doc("MDATP (Microsoft Defender Advanced Threat Protection) requirements check properties.")
  properties?: MdatpCheckRequirementsProperties;

  @doc("Describes the kind of connector to be checked.")
  kind: "MicrosoftDefenderAdvancedThreatProtection";
}

@doc("MDATP (Microsoft Defender Advanced Threat Protection) requirements check properties.")
model MdatpCheckRequirementsProperties {
  ...DataConnectorTenantId;
}

@doc("Represents Microsoft Threat Intelligence requirements check request.")
model MstiCheckRequirements extends DataConnectorsCheckRequirements {
  @doc("Microsoft Threat Intelligence requirements check properties.")
  properties?: MstiCheckRequirementsProperties;

  @doc("Describes the kind of connector to be checked.")
  kind: "MicrosoftThreatIntelligence";
}

@doc("Microsoft Threat Intelligence requirements check properties.")
model MstiCheckRequirementsProperties {
  ...DataConnectorTenantId;
}

@doc("Represents MTP (Microsoft Threat Protection) requirements check request.")
model MtpCheckRequirements extends DataConnectorsCheckRequirements {
  @doc("MTP (Microsoft Threat Protection) requirements check properties.")
  properties?: MTPCheckRequirementsProperties;

  @doc("Describes the kind of connector to be checked.")
  kind: "MicrosoftThreatProtection";
}

@doc("MTP (Microsoft Threat Protection) requirements check properties.")
model MTPCheckRequirementsProperties {
  ...DataConnectorTenantId;
}

@doc("Represents OfficeATP (Office 365 Advanced Threat Protection) requirements check request.")
model OfficeATPCheckRequirements extends DataConnectorsCheckRequirements {
  @doc("OfficeATP (Office 365 Advanced Threat Protection) requirements check properties.")
  properties?: OfficeATPCheckRequirementsProperties;

  @doc("Describes the kind of connector to be checked.")
  kind: "OfficeATP";
}

@doc("OfficeATP (Office 365 Advanced Threat Protection) requirements check properties.")
model OfficeATPCheckRequirementsProperties {
  ...DataConnectorTenantId;
}

@doc("Represents OfficeIRM (Microsoft Insider Risk Management) requirements check request.")
model OfficeIRMCheckRequirements extends DataConnectorsCheckRequirements {
  @doc("OfficeIRM (Microsoft Insider Risk Management) requirements check properties.")
  properties?: OfficeIRMCheckRequirementsProperties;

  @doc("Describes the kind of connector to be checked.")
  kind: "OfficeIRM";
}

@doc("OfficeIRM (Microsoft Insider Risk Management) requirements check properties.")
model OfficeIRMCheckRequirementsProperties {
  ...DataConnectorTenantId;
}

@doc("Represents Office365 Project requirements check request.")
model Office365ProjectCheckRequirements
  extends DataConnectorsCheckRequirements {
  @doc("Office365 Project requirements check properties.")
  properties?: Office365ProjectCheckRequirementsProperties;

  @doc("Describes the kind of connector to be checked.")
  kind: "Office365Project";
}

@doc("Office365 Project requirements check properties.")
model Office365ProjectCheckRequirementsProperties {
  ...DataConnectorTenantId;
}

@doc("Represents Office PowerBI requirements check request.")
model OfficePowerBICheckRequirements extends DataConnectorsCheckRequirements {
  @doc("Office Power BI requirements check properties.")
  properties?: OfficePowerBICheckRequirementsProperties;

  @doc("Describes the kind of connector to be checked.")
  kind: "OfficePowerBI";
}

@doc("Office PowerBI requirements check properties.")
model OfficePowerBICheckRequirementsProperties {
  ...DataConnectorTenantId;
}

@doc("Threat Intelligence Platforms data connector check requirements")
model TICheckRequirements extends DataConnectorsCheckRequirements {
  @doc("Threat Intelligence Platforms data connector check required properties")
  properties?: TICheckRequirementsProperties;

  @doc("Describes the kind of connector to be checked.")
  kind: "ThreatIntelligence";
}

@doc("Threat Intelligence Platforms data connector required properties.")
model TICheckRequirementsProperties {
  ...DataConnectorTenantId;
}

@doc("Threat Intelligence TAXII data connector check requirements")
model TiTaxiiCheckRequirements extends DataConnectorsCheckRequirements {
  @doc("Threat Intelligence TAXII check required properties.")
  properties?: TiTaxiiCheckRequirementsProperties;

  @doc("Describes the kind of connector to be checked.")
  kind: "ThreatIntelligenceTaxii";
}

@doc("Threat Intelligence TAXII data connector required properties.")
model TiTaxiiCheckRequirementsProperties {
  ...DataConnectorTenantId;
}

@doc("Represents IoT requirements check request.")
model IoTCheckRequirements extends DataConnectorsCheckRequirements {
  @doc("IoT requirements check properties.")
  properties?: IoTCheckRequirementsProperties;

  @doc("Describes the kind of connector to be checked.")
  kind: "IOT";
}

@doc("IoT requirements check properties.")
model IoTCheckRequirementsProperties {
  @doc("The subscription id to connect to, and get the data from.")
  subscriptionId?: string;
}

@doc("Represents AAD (Azure Active Directory) data connector.")
model AADDataConnector extends DataConnector {
  @doc("AAD (Azure Active Directory) data connector properties.")
  properties?: AADDataConnectorProperties;

  @doc("The data connector kind")
  kind: "AzureActiveDirectory";
}

@doc("AAD (Azure Active Directory) data connector properties.")
model AADDataConnectorProperties {
  ...DataConnectorTenantId;
  ...DataConnectorWithAlertsProperties;
}

@doc("Data connector properties.")
model DataConnectorWithAlertsProperties {
  @doc("The available data types for the connector.")
  dataTypes?: AlertsDataTypeOfDataConnector;
}

@doc("Alerts data type for data connectors.")
model AlertsDataTypeOfDataConnector {
  @doc("Alerts data type connection.")
  alerts: DataConnectorDataTypeCommon;
}

@doc("Common field for data type in data connectors.")
model DataConnectorDataTypeCommon {
  @doc("Describe whether this data type connection is enabled or not.")
  state: DataTypeState;
}

@doc("Represents Microsoft Threat Intelligence data connector.")
model MstiDataConnector extends DataConnector {
  @doc("Microsoft Threat Intelligence data connector properties.")
  properties?: MstiDataConnectorProperties;

  @doc("The data connector kind")
  kind: "MicrosoftThreatIntelligence";
}

@doc("Microsoft Threat Intelligence data connector properties.")
model MstiDataConnectorProperties {
  ...DataConnectorTenantId;

  @doc("The available data types for the connector.")
  dataTypes: MstiDataConnectorDataTypes;
}

@doc("The available data types for Microsoft Threat Intelligence Platforms data connector.")
model MstiDataConnectorDataTypes {
  @doc("Data type for Microsoft Threat Intelligence Platforms data connector.")
  bingSafetyPhishingURL: MstiDataConnectorDataTypesBingSafetyPhishingURL;

  @doc("Data type for Microsoft Threat Intelligence Platforms data connector.")
  microsoftEmergingThreatFeed: MstiDataConnectorDataTypesMicrosoftEmergingThreatFeed;
}

@doc("Data type for Microsoft Threat Intelligence Platforms data connector.")
model MstiDataConnectorDataTypesBingSafetyPhishingURL {
  ...DataConnectorDataTypeCommon;

  @doc("lookback period")
  lookbackPeriod: string;
}

@doc("Data type for Microsoft Threat Intelligence Platforms data connector.")
model MstiDataConnectorDataTypesMicrosoftEmergingThreatFeed {
  ...DataConnectorDataTypeCommon;

  @doc("lookback period")
  lookbackPeriod: string;
}

@doc("Represents MTP (Microsoft Threat Protection) data connector.")
model MTPDataConnector extends DataConnector {
  @doc("MTP (Microsoft Threat Protection) data connector properties.")
  properties?: MTPDataConnectorProperties;

  @doc("The data connector kind")
  kind: "MicrosoftThreatProtection";
}

@doc("MTP (Microsoft Threat Protection) data connector properties.")
model MTPDataConnectorProperties {
  ...DataConnectorTenantId;

  @doc("The available data types for the connector.")
  dataTypes: MTPDataConnectorDataTypes;
}

@doc("The available data types for Microsoft Threat Protection Platforms data connector.")
model MTPDataConnectorDataTypes {
  @doc("Data type for Microsoft Threat Protection Platforms data connector.")
  incidents: MTPDataConnectorDataTypesIncidents;
}

@doc("Data type for Microsoft Threat Protection Platforms data connector.")
model MTPDataConnectorDataTypesIncidents {
  ...DataConnectorDataTypeCommon;
}

@doc("Represents AATP (Azure Advanced Threat Protection) data connector.")
model AatpDataConnector extends DataConnector {
  @doc("AATP (Azure Advanced Threat Protection) data connector properties.")
  properties?: AatpDataConnectorProperties;

  @doc("The data connector kind")
  kind: "AzureAdvancedThreatProtection";
}

@doc("AATP (Azure Advanced Threat Protection) data connector properties.")
model AatpDataConnectorProperties {
  ...DataConnectorTenantId;
  ...DataConnectorWithAlertsProperties;
}

@doc("Represents ASC (Azure Security Center) data connector.")
model ASCDataConnector extends DataConnector {
  @doc("ASC (Azure Security Center) data connector properties.")
  properties?: ASCDataConnectorProperties;

  @doc("The data connector kind")
  kind: "AzureSecurityCenter";
}

@doc("ASC (Azure Security Center) data connector properties.")
model ASCDataConnectorProperties {
  ...DataConnectorWithAlertsProperties;

  @doc("The subscription id to connect to, and get the data from.")
  subscriptionId?: string;
}

@doc("Represents Amazon Web Services CloudTrail data connector.")
model AwsCloudTrailDataConnector extends DataConnector {
  @doc("Amazon Web Services CloudTrail data connector properties.")
  properties?: AwsCloudTrailDataConnectorProperties;

  @doc("The data connector kind")
  kind: "AmazonWebServicesCloudTrail";
}

@doc("Amazon Web Services CloudTrail data connector properties.")
model AwsCloudTrailDataConnectorProperties {
  @doc("The Aws Role Arn (with CloudTrailReadOnly policy) that is used to access the Aws account.")
  awsRoleArn?: string;

  @doc("The available data types for the connector.")
  dataTypes: AwsCloudTrailDataConnectorDataTypes;
}

@doc("The available data types for Amazon Web Services CloudTrail data connector.")
model AwsCloudTrailDataConnectorDataTypes {
  @doc("Logs data type.")
  logs: AwsCloudTrailDataConnectorDataTypesLogs;
}

@doc("Logs data type.")
model AwsCloudTrailDataConnectorDataTypesLogs {
  ...DataConnectorDataTypeCommon;
}

@doc("Represents Amazon Web Services S3 data connector.")
model AwsS3DataConnector extends DataConnector {
  @doc("Amazon Web Services S3 data connector properties.")
  properties?: AwsS3DataConnectorProperties;

  @doc("The data connector kind")
  kind: "AmazonWebServicesS3";
}

@doc("Amazon Web Services S3 data connector properties.")
model AwsS3DataConnectorProperties {
  @doc("The logs destination table name in LogAnalytics.")
  destinationTable: string;

  @doc("The AWS sqs urls for the connector.")
  sqsUrls: string[];

  @doc("The Aws Role Arn that is used to access the Aws account.")
  roleArn: string;

  @doc("The available data types for the connector.")
  dataTypes: AwsS3DataConnectorDataTypes;
}

@doc("The available data types for Amazon Web Services S3 data connector.")
model AwsS3DataConnectorDataTypes {
  @doc("Logs data type.")
  logs: AwsS3DataConnectorDataTypesLogs;
}

@doc("Logs data type.")
model AwsS3DataConnectorDataTypesLogs {
  ...DataConnectorDataTypeCommon;
}

@doc("Represents MCAS (Microsoft Cloud App Security) data connector.")
model McasDataConnector extends DataConnector {
  @doc("MCAS (Microsoft Cloud App Security) data connector properties.")
  properties?: McasDataConnectorProperties;

  @doc("The data connector kind")
  kind: "MicrosoftCloudAppSecurity";
}

@doc("MCAS (Microsoft Cloud App Security) data connector properties.")
model McasDataConnectorProperties {
  ...DataConnectorTenantId;

  @doc("The available data types for the connector.")
  dataTypes: McasDataConnectorDataTypes;
}

@doc("The available data types for MCAS (Microsoft Cloud App Security) data connector.")
model McasDataConnectorDataTypes {
  ...AlertsDataTypeOfDataConnector;

  @doc("Discovery log data type connection.")
  discoveryLogs?: DataConnectorDataTypeCommon;
}

@doc("Represents Dynamics365 data connector.")
model Dynamics365DataConnector extends DataConnector {
  @doc("Dynamics365 data connector properties.")
  properties?: Dynamics365DataConnectorProperties;

  @doc("The data connector kind")
  kind: "Dynamics365";
}

@doc("Dynamics365 data connector properties.")
model Dynamics365DataConnectorProperties {
  ...DataConnectorTenantId;

  @doc("The available data types for the connector.")
  dataTypes: Dynamics365DataConnectorDataTypes;
}

@doc("The available data types for Dynamics365 data connector.")
model Dynamics365DataConnectorDataTypes {
  @doc("Common Data Service data type connection.")
  dynamics365CdsActivities: Dynamics365DataConnectorDataTypesDynamics365CdsActivities;
}

@doc("Common Data Service data type connection.")
model Dynamics365DataConnectorDataTypesDynamics365CdsActivities {
  ...DataConnectorDataTypeCommon;
}

@doc("Represents OfficeATP (Office 365 Advanced Threat Protection) data connector.")
model OfficeATPDataConnector extends DataConnector {
  @doc("OfficeATP (Office 365 Advanced Threat Protection) data connector properties.")
  properties?: OfficeATPDataConnectorProperties;

  @doc("The data connector kind")
  kind: "OfficeATP";
}

@doc("OfficeATP (Office 365 Advanced Threat Protection) data connector properties.")
model OfficeATPDataConnectorProperties {
  ...DataConnectorTenantId;
  ...DataConnectorWithAlertsProperties;
}

@doc("Represents Office Microsoft Project data connector.")
model Office365ProjectDataConnector extends DataConnector {
  @doc("Office Microsoft Project data connector properties.")
  properties?: Office365ProjectDataConnectorProperties;

  @doc("The data connector kind")
  kind: "Office365Project";
}

@doc("Office Microsoft Project data connector properties.")
model Office365ProjectDataConnectorProperties {
  ...DataConnectorTenantId;

  @doc("The available data types for the connector.")
  dataTypes: Office365ProjectConnectorDataTypes;
}

@doc("The available data types for Office Microsoft Project data connector.")
model Office365ProjectConnectorDataTypes {
  @doc("Logs data type.")
  logs: Office365ProjectConnectorDataTypesLogs;
}

@doc("Logs data type.")
model Office365ProjectConnectorDataTypesLogs {
  ...DataConnectorDataTypeCommon;
}

@doc("Represents Office Microsoft PowerBI data connector.")
model OfficePowerBIDataConnector extends DataConnector {
  @doc("Office Microsoft PowerBI data connector properties.")
  properties?: OfficePowerBIDataConnectorProperties;

  @doc("The data connector kind")
  kind: "OfficePowerBI";
}

@doc("Office Microsoft PowerBI data connector properties.")
model OfficePowerBIDataConnectorProperties {
  ...DataConnectorTenantId;

  @doc("The available data types for the connector.")
  dataTypes: OfficePowerBIConnectorDataTypes;
}

@doc("The available data types for Office Microsoft PowerBI data connector.")
model OfficePowerBIConnectorDataTypes {
  @doc("Logs data type.")
  logs: OfficePowerBIConnectorDataTypesLogs;
}

@doc("Logs data type.")
model OfficePowerBIConnectorDataTypesLogs {
  ...DataConnectorDataTypeCommon;
}

@doc("Represents OfficeIRM (Microsoft Insider Risk Management) data connector.")
model OfficeIRMDataConnector extends DataConnector {
  @doc("OfficeIRM (Microsoft Insider Risk Management) data connector properties.")
  properties?: OfficeIRMDataConnectorProperties;

  @doc("The data connector kind")
  kind: "OfficeIRM";
}

@doc("OfficeIRM (Microsoft Insider Risk Management) data connector properties.")
model OfficeIRMDataConnectorProperties {
  ...DataConnectorTenantId;
  ...DataConnectorWithAlertsProperties;
}

@doc("Represents MDATP (Microsoft Defender Advanced Threat Protection) data connector.")
model MdatpDataConnector extends DataConnector {
  @doc("MDATP (Microsoft Defender Advanced Threat Protection) data connector properties.")
  properties?: MdatpDataConnectorProperties;

  @doc("The data connector kind")
  kind: "MicrosoftDefenderAdvancedThreatProtection";
}

@doc("MDATP (Microsoft Defender Advanced Threat Protection) data connector properties.")
model MdatpDataConnectorProperties {
  ...DataConnectorTenantId;
  ...DataConnectorWithAlertsProperties;
}

@doc("Represents office data connector.")
model OfficeDataConnector extends DataConnector {
  @doc("Office data connector properties.")
  properties?: OfficeDataConnectorProperties;

  @doc("The data connector kind")
  kind: "Office365";
}

@doc("Office data connector properties.")
model OfficeDataConnectorProperties {
  ...DataConnectorTenantId;

  @doc("The available data types for the connector.")
  dataTypes: OfficeDataConnectorDataTypes;
}

@doc("The available data types for office data connector.")
model OfficeDataConnectorDataTypes {
  @doc("Exchange data type connection.")
  exchange: OfficeDataConnectorDataTypesExchange;

  @doc("SharePoint data type connection.")
  sharePoint: OfficeDataConnectorDataTypesSharePoint;

  @doc("Teams data type connection.")
  teams: OfficeDataConnectorDataTypesTeams;
}

@doc("Exchange data type connection.")
model OfficeDataConnectorDataTypesExchange {
  ...DataConnectorDataTypeCommon;
}

@doc("SharePoint data type connection.")
model OfficeDataConnectorDataTypesSharePoint {
  ...DataConnectorDataTypeCommon;
}

@doc("Teams data type connection.")
model OfficeDataConnectorDataTypesTeams {
  ...DataConnectorDataTypeCommon;
}

@doc("Represents threat intelligence data connector.")
model TIDataConnector extends DataConnector {
  @doc("TI (Threat Intelligence) data connector properties.")
  properties?: TIDataConnectorProperties;

  @doc("The data connector kind")
  kind: "ThreatIntelligence";
}

@doc("TI (Threat Intelligence) data connector properties.")
model TIDataConnectorProperties {
  ...DataConnectorTenantId;

  @doc("The lookback period for the feed to be imported.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  tipLookbackPeriod?: utcDateTime;

  @doc("The available data types for the connector.")
  dataTypes: TIDataConnectorDataTypes;
}

@doc("The available data types for TI (Threat Intelligence) data connector.")
model TIDataConnectorDataTypes {
  @doc("Data type for indicators connection.")
  indicators: TIDataConnectorDataTypesIndicators;
}

@doc("Data type for indicators connection.")
model TIDataConnectorDataTypesIndicators {
  ...DataConnectorDataTypeCommon;
}

@doc("Data connector to pull Threat intelligence data from TAXII 2.0/2.1 server")
model TiTaxiiDataConnector extends DataConnector {
  @doc("Threat intelligence TAXII data connector properties.")
  properties?: TiTaxiiDataConnectorProperties;

  @doc("The data connector kind")
  kind: "ThreatIntelligenceTaxii";
}

@doc("Threat Intelligence TAXII data connector properties.")
model TiTaxiiDataConnectorProperties {
  ...DataConnectorTenantId;

  @doc("The workspace id.")
  workspaceId?: string;

  @doc("The friendly name for the TAXII server.")
  friendlyName?: string;

  @doc("The API root for the TAXII server.")
  taxiiServer?: string;

  @doc("The collection id of the TAXII server.")
  collectionId?: string;

  @doc("The userName for the TAXII server.")
  userName?: string;

  @doc("The password for the TAXII server.")
  password?: string;

  @doc("The lookback period for the TAXII server.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  taxiiLookbackPeriod?: utcDateTime;

  @doc("The polling frequency for the TAXII server.")
  pollingFrequency: PollingFrequency;

  @doc("The available data types for Threat Intelligence TAXII data connector.")
  dataTypes: TiTaxiiDataConnectorDataTypes;
}

@doc("The available data types for Threat Intelligence TAXII data connector.")
model TiTaxiiDataConnectorDataTypes {
  @doc("Data type for TAXII connector.")
  taxiiClient: TiTaxiiDataConnectorDataTypesTaxiiClient;
}

@doc("Data type for TAXII connector.")
model TiTaxiiDataConnectorDataTypesTaxiiClient {
  ...DataConnectorDataTypeCommon;
}

@doc("Represents IoT data connector.")
model IoTDataConnector extends DataConnector {
  @doc("IoT data connector properties.")
  properties?: IoTDataConnectorProperties;

  @doc("The data connector kind")
  kind: "IOT";
}

@doc("IoT data connector properties.")
model IoTDataConnectorProperties {
  ...DataConnectorWithAlertsProperties;

  @doc("The subscription id to connect to, and get the data from.")
  subscriptionId?: string;
}

@doc("Represents Codeless UI data connector.")
model CodelessUiDataConnector extends DataConnector {
  @doc("Codeless UI data connector properties")
  properties?: CodelessParameters;

  @doc("The data connector kind")
  kind: "GenericUI";
}

@doc("Represents Codeless UI data connector")
model CodelessParameters {
  @doc("Config to describe the instructions blade")
  connectorUiConfig?: CodelessUiConnectorConfigProperties;
}

@doc("Config to describe the instructions blade")
model CodelessUiConnectorConfigProperties {
  @doc("Connector blade title")
  title: string;

  @doc("Connector publisher name")
  publisher: string;

  @doc("Connector description")
  descriptionMarkdown: string;

  @doc("An optional custom image to be used when displaying the connector within Azure Sentinel's connector's gallery")
  customImage?: string;

  @doc("Name of the table the connector will insert the data to")
  graphQueriesTableName: string;

  @doc("The graph query to show the current data status")
  graphQueries: CodelessUiConnectorConfigPropertiesGraphQueriesItem[];

  @doc("The sample queries for the connector")
  sampleQueries: CodelessUiConnectorConfigPropertiesSampleQueriesItem[];

  @doc("Data types to check for last data received")
  dataTypes: CodelessUiConnectorConfigPropertiesDataTypesItem[];

  @doc("Define the way the connector check connectivity")
  connectivityCriteria: CodelessUiConnectorConfigPropertiesConnectivityCriteriaItem[];

  @doc("Connector Availability Status")
  availability: Availability;

  @doc("Permissions required for the connector")
  permissions: Permissions;

  @doc("Instruction steps to enable the connector")
  instructionSteps: CodelessUiConnectorConfigPropertiesInstructionStepsItem[];
}

model CodelessUiConnectorConfigPropertiesGraphQueriesItem {
  ...GraphQueries;
}

@doc("The graph query to show the current data status")
model GraphQueries {
  @doc("the metric that the query is checking")
  metricName?: string;

  @doc("The legend for the graph")
  legend?: string;

  @doc("The base query for the graph")
  baseQuery?: string;
}

model CodelessUiConnectorConfigPropertiesSampleQueriesItem {
  ...SampleQueries;
}

@doc("The sample queries for the connector")
model SampleQueries {
  @doc("The sample query description")
  description?: string;

  @doc("the sample query")
  query?: string;
}

model CodelessUiConnectorConfigPropertiesDataTypesItem {
  ...LastDataReceivedDataType;
}

@doc("Data type for last data received")
model LastDataReceivedDataType {
  @doc("Name of the data type to show in the graph. can be use with {{graphQueriesTableName}} placeholder")
  name?: string;

  @doc("Query for indicate last data received")
  lastDataReceivedQuery?: string;
}

model CodelessUiConnectorConfigPropertiesConnectivityCriteriaItem {
  ...ConnectivityCriteria;
}

@doc("Setting for the connector check connectivity")
model ConnectivityCriteria {
  @doc("type of connectivity")
  type?: ConnectivityType;

  @doc("Queries for checking connectivity")
  value?: string[];
}

@doc("Connector Availability Status")
model Availability {
  @doc("The connector Availability Status")
  status?: 1;

  @doc("Set connector as preview")
  isPreview?: boolean;
}

@doc("Permissions required for the connector")
model Permissions {
  @doc("Resource provider permissions required for the connector")
  resourceProvider?: PermissionsResourceProviderItem[];

  @doc("Customs permissions required for the connector")
  customs?: PermissionsCustomsItem[];
}

model PermissionsResourceProviderItem {
  ...ResourceProvider;
}

@doc("Resource provider permissions required for the connector")
model ResourceProvider {
  @doc("Provider name")
  provider?: ProviderName;

  @doc("Permission description text")
  permissionsDisplayText?: string;

  @doc("Permission provider display name")
  providerDisplayName?: string;

  @doc("Permission provider scope")
  scope?: PermissionProviderScope;

  @doc("Required permissions for the connector")
  requiredPermissions?: RequiredPermissions;
}

@doc("Required permissions for the connector")
model RequiredPermissions {
  @doc("action permission")
  action?: boolean;

  @doc("write permission")
  write?: boolean;

  @doc("read permission")
  read?: boolean;

  @doc("delete permission")
  delete?: boolean;
}

model PermissionsCustomsItem {
  ...Customs;
}

@doc("Customs permissions required for the connector")
model Customs {
  ...CustomsPermission;
}

@doc("Customs permissions required for the connector")
model CustomsPermission {
  @doc("Customs permissions name")
  name?: string;

  @doc("Customs permissions description")
  description?: string;
}

model CodelessUiConnectorConfigPropertiesInstructionStepsItem {
  ...InstructionSteps;
}

@doc("Instruction steps to enable the connector")
model InstructionSteps {
  @doc("Instruction step title")
  title?: string;

  @doc("Instruction step description")
  description?: string;

  @doc("Instruction step details")
  instructions?: InstructionStepsInstructionsItem[];
}

model InstructionStepsInstructionsItem {
  ...ConnectorInstructionModelBase;
}

@doc("Instruction step details")
model ConnectorInstructionModelBase {
  @doc("The parameters for the setting")
  parameters?: Record<unknown>;

  @doc("The kind of the setting")
  type: SettingType;
}

@doc("Represents Codeless API Polling data connector.")
model CodelessApiPollingDataConnector extends DataConnector {
  @doc("Codeless poling data connector properties")
  properties?: ApiPollingParameters;

  @doc("The data connector kind")
  kind: "APIPolling";
}

@doc("Represents Codeless API Polling data connector")
model ApiPollingParameters {
  @doc("Config to describe the instructions blade")
  connectorUiConfig?: CodelessUiConnectorConfigProperties;

  @doc("Config to describe the polling instructions")
  pollingConfig?: CodelessConnectorPollingConfigProperties;
}

@doc("Config to describe the polling config for API poller connector")
model CodelessConnectorPollingConfigProperties {
  @doc("The poller active status")
  isActive?: boolean;

  @doc("Describe the authentication type of the poller")
  auth: CodelessConnectorPollingAuthProperties;

  @doc("Describe the poll request config parameters of the poller")
  request: CodelessConnectorPollingRequestProperties;

  @doc("Describe the poll request paging config of the poller")
  paging?: CodelessConnectorPollingPagingProperties;

  @doc("Describe the response config parameters of the poller")
  response?: CodelessConnectorPollingResponseProperties;
}

@doc("Describe the authentication properties needed to successfully authenticate with the server")
model CodelessConnectorPollingAuthProperties {
  @doc("The authentication type")
  authType: string;

  @doc("The header name which the token is sent with")
  apiKeyName?: string;

  @doc("A prefix send in the header before the actual token")
  apiKeyIdentifier?: string;

  @doc("Marks if the key should sent in header")
  isApiKeyInPostPayload?: string;

  @doc("Describes the flow name, for example 'AuthCode' for Oauth 2.0")
  flowName?: string;

  @doc("The endpoint used to issue a token, used in Oauth 2.0 flow")
  tokenEndpoint?: string;

  @doc("The endpoint used to authorize the user, used in Oauth 2.0 flow")
  authorizationEndpoint?: string;

  @doc("The query parameters used in authorization request, used in Oauth 2.0 flow")
  authorizationEndpointQueryParameters?: Record<unknown>;

  @doc("The redirect endpoint where we will get the authorization code, used in Oauth 2.0 flow")
  redirectionEndpoint?: string;

  @doc("The query headers used in token request, used in Oauth 2.0 flow")
  tokenEndpointHeaders?: Record<unknown>;

  @doc("The query parameters used in token request, used in Oauth 2.0 flow")
  tokenEndpointQueryParameters?: Record<unknown>;

  @doc("Marks if we should send the client secret in header or payload, used in Oauth 2.0 flow")
  isClientSecretInHeader?: boolean;

  @doc("The OAuth token scope")
  scope?: string;
}

@doc("Describe the request properties needed to successfully pull from the server")
model CodelessConnectorPollingRequestProperties {
  @doc("Describe the endpoint we should pull the data from")
  apiEndpoint: string;

  @doc("Defines the rate limit QPS")
  rateLimitQps?: int32;

  @doc("The window interval we will use the pull the data")
  queryWindowInMin: int32;

  @doc("The http method type we will use in the poll request, GET or POST")
  httpMethod: string;

  @doc("The time format will be used the query events in a specific window")
  queryTimeFormat: string;

  @doc("Describe the amount of time we should try and poll the data in case of failure")
  retryCount?: int32;

  @doc("The number of seconds we will consider as a request timeout")
  timeoutInSeconds?: int32;

  @doc("Describe the headers sent in the poll request")
  headers?: Record<unknown>;

  @doc("Describe the query parameters sent in the poll request")
  queryParameters?: Record<unknown>;

  @doc("For advanced scenarios for example user name/password embedded in nested JSON payload")
  queryParametersTemplate?: string;

  @doc("This will be used the query events from a start of the time window")
  startTimeAttributeName?: string;

  @doc("This will be used the query events from the end of the time window")
  endTimeAttributeName?: string;
}

@doc("Describe the properties needed to make a pagination call")
model CodelessConnectorPollingPagingProperties {
  @doc("Describes the type. could be 'None', 'PageToken', 'PageCount', 'TimeStamp'")
  pagingType: string;

  @doc("Defines the name of a next page attribute")
  nextPageParaName?: string;

  @doc("Defines the path to a next page token JSON")
  nextPageTokenJsonPath?: string;

  @doc("Defines the path to a page count attribute")
  pageCountAttributePath?: string;

  @doc("Defines the path to a page total count attribute")
  pageTotalCountAttributePath?: string;

  @doc("Defines the path to a paging time stamp attribute")
  pageTimeStampAttributePath?: string;

  @doc("Determines whether to search for the latest time stamp in the events list")
  searchTheLatestTimeStampFromEventsList?: string;

  @doc("Defines the name of the page size parameter")
  pageSizeParaName?: string;

  @doc("Defines the paging size")
  pageSize?: int32;
}

@doc("Describes the response from the external server")
model CodelessConnectorPollingResponseProperties {
  @doc("Describes the path we should extract the data in the response")
  eventsJsonPaths: string[];

  @doc("Describes the path we should extract the status code in the response")
  successStatusJsonPath?: string;

  @doc("Describes the path we should extract the status value in the response")
  successStatusValue?: string;

  @doc("Describes if the data in the response is Gzip")
  isGzipCompressed?: boolean;
}

@doc("Represents an account entity.")
model AccountEntity extends Entity {
  @doc("Account entity properties")
  properties?: AccountEntityProperties;

  @doc("The kind of the entity.")
  kind: "Account";
}

@doc("Account entity property bag.")
model AccountEntityProperties {
  ...EntityCommonProperties;

  @doc("The Azure Active Directory tenant id.")
  @visibility("read")
  aadTenantId?: string;

  @doc("The Azure Active Directory user id.")
  @visibility("read")
  aadUserId?: string;

  @doc("The name of the account. This field should hold only the name without any domain added to it, i.e. administrator.")
  @visibility("read")
  accountName?: string;

  @doc("The display name of the account.")
  @visibility("read")
  displayName?: string;

  @doc("The Host entity id that contains the account in case it is a local account (not domain joined)")
  @visibility("read")
  hostEntityId?: string;

  @doc("Determines whether this is a domain account.")
  @visibility("read")
  isDomainJoined?: boolean;

  @doc("The NetBIOS domain name as it appears in the alert format domain/username. Examples: NT AUTHORITY.")
  @visibility("read")
  ntDomain?: string;

  @doc("The objectGUID attribute is a single-value attribute that is the unique identifier for the object, assigned by active directory.")
  @visibility("read")
  objectGuid?: string;

  @doc("The Azure Active Directory Passport User ID.")
  @visibility("read")
  puid?: string;

  @doc("The account security identifier, e.g. S-1-5-18.")
  @visibility("read")
  sid?: string;

  @doc("The user principal name suffix for the account, in some cases it is also the domain name. Examples: contoso.com.")
  @visibility("read")
  upnSuffix?: string;

  @doc("The fully qualified domain DNS name.")
  @visibility("read")
  dnsDomain?: string;
}

@doc("Represents an azure resource entity.")
model AzureResourceEntity extends Entity {
  @doc("AzureResource entity properties")
  properties?: AzureResourceEntityProperties;

  @doc("The kind of the entity.")
  kind: "AzureResource";
}

@doc("AzureResource entity property bag.")
model AzureResourceEntityProperties {
  ...EntityCommonProperties;

  @doc("The azure resource id of the resource")
  @visibility("read")
  resourceId?: string;

  @doc("The subscription id of the resource")
  @visibility("read")
  subscriptionId?: string;
}

@doc("Represents a cloud application entity.")
model CloudApplicationEntity extends Entity {
  @doc("CloudApplication entity properties")
  properties?: CloudApplicationEntityProperties;

  @doc("The kind of the entity.")
  kind: "CloudApplication";
}

@doc("CloudApplication entity property bag.")
model CloudApplicationEntityProperties {
  ...EntityCommonProperties;

  @doc("The technical identifier of the application.")
  @visibility("read")
  appId?: int32;

  @doc("The name of the related cloud application.")
  @visibility("read")
  appName?: string;

  @doc("The user defined instance name of the cloud application. It is often used to distinguish between several applications of the same type that a customer has.")
  @visibility("read")
  instanceName?: string;
}

@doc("Represents a dns entity.")
model DnsEntity extends Entity {
  @doc("Dns entity properties")
  properties?: DnsEntityProperties;

  @doc("The kind of the entity.")
  kind: "DnsResolution";
}

@doc("Dns entity property bag.")
model DnsEntityProperties {
  ...EntityCommonProperties;

  @doc("An ip entity id for the dns server resolving the request")
  @visibility("read")
  dnsServerIpEntityId?: string;

  @doc("The name of the dns record associated with the alert")
  @visibility("read")
  domainName?: string;

  @doc("An ip entity id for the dns request client")
  @visibility("read")
  hostIpAddressEntityId?: string;

  @doc("Ip entity identifiers for the resolved ip address.")
  @visibility("read")
  ipAddressEntityIds?: string[];
}

@doc("Represents a file entity.")
model FileEntity extends Entity {
  @doc("File entity properties")
  properties?: FileEntityProperties;

  @doc("The kind of the entity.")
  kind: "File";
}

@doc("File entity property bag.")
model FileEntityProperties {
  ...EntityCommonProperties;

  @doc("The full path to the file.")
  @visibility("read")
  directory?: string;

  @doc("The file hash entity identifiers associated with this file")
  @visibility("read")
  fileHashEntityIds?: string[];

  @doc("The file name without path (some alerts might not include path).")
  @visibility("read")
  fileName?: string;

  @doc("The Host entity id which the file belongs to")
  @visibility("read")
  hostEntityId?: string;
}

@doc("Represents a file hash entity.")
model FileHashEntity extends Entity {
  @doc("FileHash entity properties")
  properties?: FileHashEntityProperties;

  @doc("The kind of the entity.")
  kind: "FileHash";
}

@doc("FileHash entity property bag.")
model FileHashEntityProperties {
  ...EntityCommonProperties;

  @doc("The hash algorithm type.")
  @visibility("read")
  algorithm?: FileHashAlgorithm;

  @doc("The file hash value.")
  @visibility("read")
  hashValue?: string;
}

@doc("Represents a host entity.")
model HostEntity extends Entity {
  @doc("Host entity properties")
  properties?: HostEntityProperties;

  @doc("The kind of the entity.")
  kind: "Host";
}

@doc("Host entity property bag.")
model HostEntityProperties {
  ...EntityCommonProperties;

  @doc("The azure resource id of the VM.")
  @visibility("read")
  azureID?: string;

  @doc("The DNS domain that this host belongs to. Should contain the compete DNS suffix for the domain")
  @visibility("read")
  dnsDomain?: string;

  @doc("The hostname without the domain suffix.")
  @visibility("read")
  hostName?: string;

  @doc("Determines whether this host belongs to a domain.")
  @visibility("read")
  isDomainJoined?: boolean;

  @doc("The host name (pre-windows2000).")
  @visibility("read")
  netBiosName?: string;

  @doc("The NT domain that this host belongs to.")
  @visibility("read")
  ntDomain?: string;

  @doc("The OMS agent id, if the host has OMS agent installed.")
  @visibility("read")
  omsAgentID?: string;

  @doc("The operating system type.")
  osFamily?: OSFamily;

  @doc("A free text representation of the operating system. This field is meant to hold specific versions the are more fine grained than OSFamily or future values not supported by OSFamily enumeration")
  @visibility("read")
  osVersion?: string;
}

@doc("Represents an IoT device entity.")
model IoTDeviceEntity extends Entity {
  @doc("IoTDevice entity properties")
  properties?: IoTDeviceEntityProperties;

  @doc("The kind of the entity.")
  kind: "IoTDevice";
}

@doc("IoTDevice entity property bag.")
model IoTDeviceEntityProperties {
  ...EntityCommonProperties;

  @doc("The ID of the IoT Device in the IoT Hub")
  @visibility("read")
  deviceId?: string;

  @doc("The friendly name of the device")
  @visibility("read")
  deviceName?: string;

  @doc("The source of the device")
  @visibility("read")
  source?: string;

  @doc("The ID of the security agent running on the device")
  @visibility("read")
  iotSecurityAgentId?: string;

  @doc("The type of the device")
  @visibility("read")
  deviceType?: string;

  @doc("The vendor of the device")
  @visibility("read")
  vendor?: string;

  @doc("The ID of the edge device")
  @visibility("read")
  edgeId?: string;

  @doc("The MAC address of the device")
  @visibility("read")
  macAddress?: string;

  @doc("The model of the device")
  @visibility("read")
  `model`?: string;

  @doc("The serial number of the device")
  @visibility("read")
  serialNumber?: string;

  @doc("The firmware version of the device")
  @visibility("read")
  firmwareVersion?: string;

  @doc("The operating system of the device")
  @visibility("read")
  operatingSystem?: string;

  @doc("The AzureResource entity id of the IoT Hub")
  @visibility("read")
  iotHubEntityId?: string;

  @doc("The Host entity id of this device")
  @visibility("read")
  hostEntityId?: string;

  @doc("The IP entity if of this device")
  @visibility("read")
  ipAddressEntityId?: string;

  @doc("A list of TI contexts attached to the IoTDevice entity.")
  @visibility("read")
  threatIntelligence?: ThreatIntelligence[];

  @doc("A list of protocols of the IoTDevice entity.")
  @visibility("read")
  protocols?: string[];

  @doc("A list of owners of the IoTDevice entity.")
  @visibility("read")
  owners?: string[];

  @doc("A list of Nic entity ids of the IoTDevice entity.")
  @visibility("read")
  nicEntityIds?: string[];

  @doc("The site of the device")
  @visibility("read")
  site?: string;

  @doc("The zone location of the device within a site")
  @visibility("read")
  zone?: string;

  @doc("The sensor the device is monitored by")
  @visibility("read")
  sensor?: string;

  @doc("The subType of the device ('PLC', 'HMI', 'EWS', etc.)")
  @visibility("read")
  deviceSubType?: string;

  @doc("Device importance, determines if the device classified as 'crown jewel'")
  importance?: DeviceImportance;

  @doc("The Purdue Layer of the device")
  @visibility("read")
  purdueLayer?: string;

  @doc("Determines whether the device classified as authorized device")
  @visibility("read")
  isAuthorized?: boolean;

  @doc("Determines whether the device classified as programming device")
  @visibility("read")
  isProgramming?: boolean;

  @doc("Is the device classified as a scanner device")
  @visibility("read")
  isScanner?: boolean;
}

@doc("ThreatIntelligence property bag.")
model ThreatIntelligence {
  @doc("Confidence (must be between 0 and 1)")
  @visibility("read")
  confidence?: float32;

  @doc("Name of the provider from whom this Threat Intelligence information was received")
  @visibility("read")
  providerName?: string;

  @doc("Report link")
  @visibility("read")
  reportLink?: string;

  @doc("Threat description (free text)")
  @visibility("read")
  threatDescription?: string;

  @doc("Threat name (e.g. \"Jedobot malware\")")
  @visibility("read")
  threatName?: string;

  @doc("Threat type (e.g. \"Botnet\")")
  @visibility("read")
  threatType?: string;
}

@doc("Represents an ip entity.")
model IpEntity extends Entity {
  @doc("Ip entity properties")
  properties?: IpEntityProperties;

  @doc("The kind of the entity.")
  kind: "Ip";
}

@doc("Ip entity property bag.")
model IpEntityProperties {
  ...EntityCommonProperties;

  @doc("The IP address as string, e.g. 127.0.0.1 (either in Ipv4 or Ipv6)")
  @visibility("read")
  address?: string;

  @doc("The geo-location context attached to the ip entity")
  @visibility("read")
  location?: GeoLocation;

  @doc("A list of TI contexts attached to the ip entity.")
  @visibility("read")
  threatIntelligence?: ThreatIntelligence[];
}

@doc("The geo-location context attached to the ip entity")
model GeoLocation {
  @doc("Autonomous System Number")
  @visibility("read")
  asn?: int32;

  @doc("City name")
  @visibility("read")
  city?: string;

  @doc("The country code according to ISO 3166 format")
  @visibility("read")
  countryCode?: string;

  @doc("Country name according to ISO 3166 Alpha 2: the lowercase of the English Short Name")
  @visibility("read")
  countryName?: string;

  @doc("The longitude of the identified location, expressed as a floating point number with range of -180 to 180, with positive numbers representing East and negative numbers representing West. Latitude and longitude are derived from the city or postal code.")
  @visibility("read")
  latitude?: float32;

  @doc("The latitude of the identified location, expressed as a floating point number with range of - 90 to 90, with positive numbers representing North and negative numbers representing South. Latitude and longitude are derived from the city or postal code.")
  @visibility("read")
  longitude?: float32;

  @doc("State name")
  @visibility("read")
  state?: string;
}

@doc("Represents a mailbox entity.")
model MailboxEntity extends Entity {
  @doc("Mailbox entity properties")
  properties?: MailboxEntityProperties;

  @doc("The kind of the entity.")
  kind: "Mailbox";
}

@doc("Mailbox entity property bag.")
model MailboxEntityProperties {
  ...EntityCommonProperties;

  @doc("The mailbox's primary address")
  @visibility("read")
  mailboxPrimaryAddress?: string;

  @doc("The mailbox's display name")
  @visibility("read")
  displayName?: string;

  @doc("The mailbox's UPN")
  @visibility("read")
  upn?: string;

  @doc("The AzureAD identifier of mailbox. Similar to AadUserId in account entity but this property is specific to mailbox object on office side")
  @visibility("read")
  externalDirectoryObjectId?: string;
}

@doc("Represents a mail cluster entity.")
model MailClusterEntity extends Entity {
  @doc("Mail cluster entity properties")
  properties?: MailClusterEntityProperties;

  @doc("The kind of the entity.")
  kind: "MailCluster";
}

@doc("Mail cluster entity property bag.")
model MailClusterEntityProperties {
  ...EntityCommonProperties;

  @doc("The mail message IDs that are part of the mail cluster")
  @visibility("read")
  networkMessageIds?: string[];

  @doc("Count of mail messages by DeliveryStatus string representation")
  @visibility("read")
  countByDeliveryStatus?: Record<unknown>;

  @doc("Count of mail messages by ThreatType string representation")
  @visibility("read")
  countByThreatType?: Record<unknown>;

  @doc("Count of mail messages by ProtectionStatus string representation")
  @visibility("read")
  countByProtectionStatus?: Record<unknown>;

  @doc("The threats of mail messages that are part of the mail cluster")
  @visibility("read")
  threats?: string[];

  @doc("The query that was used to identify the messages of the mail cluster")
  @visibility("read")
  query?: string;

  @doc("The query time")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  queryTime?: utcDateTime;

  @doc("The number of mail messages that are part of the mail cluster")
  @visibility("read")
  mailCount?: int32;

  @doc("Is this a volume anomaly mail cluster")
  @visibility("read")
  isVolumeAnomaly?: boolean;

  @doc("The source of the mail cluster (default is 'O365 ATP')")
  @visibility("read")
  source?: string;

  @doc("The id of the cluster source")
  @visibility("read")
  clusterSourceIdentifier?: string;

  @doc("The type of the cluster source")
  @visibility("read")
  clusterSourceType?: string;

  @doc("The cluster query start time")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  clusterQueryStartTime?: utcDateTime;

  @doc("The cluster query end time")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  clusterQueryEndTime?: utcDateTime;

  @doc("The cluster group")
  @visibility("read")
  clusterGroup?: string;
}

@doc("Represents a mail message entity.")
model MailMessageEntity extends Entity {
  @doc("Mail message entity properties")
  properties?: MailMessageEntityProperties;

  @doc("The kind of the entity.")
  kind: "MailMessage";
}

@doc("Mail message entity property bag.")
model MailMessageEntityProperties {
  ...EntityCommonProperties;

  @doc("The File entity ids of this mail message's attachments")
  @visibility("read")
  fileEntityIds?: string[];

  @doc("The recipient of this mail message. Note that in case of multiple recipients the mail message is forked and each copy has one recipient")
  @visibility("read")
  recipient?: string;

  @doc("The Urls contained in this mail message")
  @visibility("read")
  urls?: string[];

  @doc("The threats of this mail message")
  @visibility("read")
  threats?: string[];

  @doc("The p1 sender's email address")
  @visibility("read")
  p1Sender?: string;

  @doc("The p1 sender's display name")
  @visibility("read")
  p1SenderDisplayName?: string;

  @doc("The p1 sender's domain")
  @visibility("read")
  p1SenderDomain?: string;

  @doc("The sender's IP address")
  @visibility("read")
  senderIP?: string;

  @doc("The p2 sender's email address")
  @visibility("read")
  p2Sender?: string;

  @doc("The p2 sender's display name")
  @visibility("read")
  p2SenderDisplayName?: string;

  @doc("The p2 sender's domain")
  @visibility("read")
  p2SenderDomain?: string;

  @doc("The receive date of this message")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  receiveDate?: utcDateTime;

  @doc("The network message id of this mail message")
  @visibility("read")
  networkMessageId?: string;

  @doc("The internet message id of this mail message")
  @visibility("read")
  internetMessageId?: string;

  @doc("The subject of this mail message")
  @visibility("read")
  subject?: string;

  @doc("The language of this mail message")
  @visibility("read")
  language?: string;

  @doc("The threat detection methods")
  @visibility("read")
  threatDetectionMethods?: string[];

  @doc("The bodyFingerprintBin1")
  bodyFingerprintBin1?: int32;

  @doc("The bodyFingerprintBin2")
  bodyFingerprintBin2?: int32;

  @doc("The bodyFingerprintBin3")
  bodyFingerprintBin3?: int32;

  @doc("The bodyFingerprintBin4")
  bodyFingerprintBin4?: int32;

  @doc("The bodyFingerprintBin5")
  bodyFingerprintBin5?: int32;

  @doc("The directionality of this mail message")
  antispamDirection?: AntispamMailDirection;

  @doc("The delivery action of this mail message like Delivered, Blocked, Replaced etc")
  deliveryAction?: DeliveryAction;

  @doc("The delivery location of this mail message like Inbox, JunkFolder etc")
  deliveryLocation?: DeliveryLocation;
}

@doc("Represents a malware entity.")
model MalwareEntity extends Entity {
  @doc("File entity properties")
  properties?: MalwareEntityProperties;

  @doc("The kind of the entity.")
  kind: "Malware";
}

@doc("Malware entity property bag.")
model MalwareEntityProperties {
  ...EntityCommonProperties;

  @doc("The malware category by the vendor, e.g. Trojan")
  @visibility("read")
  category?: string;

  @doc("List of linked file entity identifiers on which the malware was found")
  @visibility("read")
  fileEntityIds?: string[];

  @doc("The malware name by the vendor, e.g. Win32/Toga!rfn")
  @visibility("read")
  malwareName?: string;

  @doc("List of linked process entity identifiers on which the malware was found.")
  @visibility("read")
  processEntityIds?: string[];
}

@doc("Represents a process entity.")
model ProcessEntity extends Entity {
  @doc("Process entity properties")
  properties?: ProcessEntityProperties;

  @doc("The kind of the entity.")
  kind: "Process";
}

@doc("Process entity property bag.")
model ProcessEntityProperties {
  ...EntityCommonProperties;

  @doc("The account entity id running the processes.")
  @visibility("read")
  accountEntityId?: string;

  @doc("The command line used to create the process")
  @visibility("read")
  commandLine?: string;

  @doc("The time when the process started to run")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTimeUtc?: utcDateTime;

  @doc("The elevation token associated with the process.")
  elevationToken?: ElevationToken;

  @doc("The host entity id on which the process was running")
  @visibility("read")
  hostEntityId?: string;

  @doc("The session entity id in which the process was running")
  @visibility("read")
  hostLogonSessionEntityId?: string;

  @doc("Image file entity id")
  @visibility("read")
  imageFileEntityId?: string;

  @doc("The parent process entity id.")
  @visibility("read")
  parentProcessEntityId?: string;

  @doc("The process ID")
  @visibility("read")
  processId?: string;
}

@doc("Represents a registry key entity.")
model RegistryKeyEntity extends Entity {
  @doc("RegistryKey entity properties")
  properties?: RegistryKeyEntityProperties;

  @doc("The kind of the entity.")
  kind: "RegistryKey";
}

@doc("RegistryKey entity property bag.")
model RegistryKeyEntityProperties {
  ...EntityCommonProperties;

  @doc("the hive that holds the registry key.")
  @visibility("read")
  hive?: RegistryHive;

  @doc("The registry key path.")
  @visibility("read")
  key?: string;
}

@doc("Represents a registry value entity.")
model RegistryValueEntity extends Entity {
  @doc("RegistryKey entity properties")
  properties?: RegistryValueEntityProperties;

  @doc("The kind of the entity.")
  kind: "RegistryValue";
}

@doc("RegistryValue entity property bag.")
model RegistryValueEntityProperties {
  ...EntityCommonProperties;

  @doc("The registry key entity id.")
  @visibility("read")
  keyEntityId?: string;

  @doc("String formatted representation of the value data.")
  @visibility("read")
  valueData?: string;

  @doc("The registry value name.")
  @visibility("read")
  valueName?: string;

  @doc("Specifies the data types to use when storing values in the registry, or identifies the data type of a value in the registry.")
  @visibility("read")
  valueType?: RegistryValueKind;
}

@doc("Represents a security group entity.")
model SecurityGroupEntity extends Entity {
  @doc("SecurityGroup entity properties")
  properties?: SecurityGroupEntityProperties;

  @doc("The kind of the entity.")
  kind: "SecurityGroup";
}

@doc("SecurityGroup entity property bag.")
model SecurityGroupEntityProperties {
  ...EntityCommonProperties;

  @doc("The group distinguished name")
  @visibility("read")
  distinguishedName?: string;

  @doc("A single-value attribute that is the unique identifier for the object, assigned by active directory.")
  @visibility("read")
  objectGuid?: string;

  @doc("The SID attribute is a single-value attribute that specifies the security identifier (SID) of the group")
  @visibility("read")
  sid?: string;
}

@doc("Represents a submission mail entity.")
model SubmissionMailEntity extends Entity {
  @doc("Submission mail entity properties")
  properties?: SubmissionMailEntityProperties;

  @doc("The kind of the entity.")
  kind: "SubmissionMail";
}

@doc("Submission mail entity property bag.")
model SubmissionMailEntityProperties {
  ...EntityCommonProperties;

  @doc("The network message id of email to which submission belongs")
  @visibility("read")
  networkMessageId?: string;

  @doc("The submission id")
  @visibility("read")
  submissionId?: string;

  @doc("The submitter")
  @visibility("read")
  submitter?: string;

  @doc("The submission date")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  submissionDate?: utcDateTime;

  @doc("The Time stamp when the message is received (Mail)")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timestamp?: utcDateTime;

  @doc("The recipient of the mail")
  @visibility("read")
  recipient?: string;

  @doc("The sender of the mail")
  @visibility("read")
  sender?: string;

  @doc("The sender's IP")
  @visibility("read")
  senderIp?: string;

  @doc("The subject of submission mail")
  @visibility("read")
  subject?: string;

  @doc("The submission type for the given instance. This maps to Junk, Phish, Malware or NotJunk.")
  @visibility("read")
  reportType?: string;
}

@doc("Represents a url entity.")
model UrlEntity extends Entity {
  @doc("Url entity properties")
  properties?: UrlEntityProperties;

  @doc("The kind of the entity.")
  kind: "Url";
}

@doc("Url entity property bag.")
model UrlEntityProperties {
  ...EntityCommonProperties;

  @doc("A full URL the entity points to")
  @visibility("read")
  url?: string;
}

@doc("Represents an network interface entity.")
model NicEntity extends Entity {
  @doc("Network interface entity properties")
  properties?: NicEntityProperties;

  @doc("The kind of the entity.")
  kind: "Nic";
}

@doc("Nic entity property bag.")
model NicEntityProperties {
  ...EntityCommonProperties;

  @doc("The MAC address of this network interface")
  @visibility("read")
  macAddress?: string;

  @doc("The IP entity id of this network interface")
  @visibility("read")
  ipAddressEntityId?: string;

  @doc("A list of VLANs of the network interface entity.")
  @visibility("read")
  vlans?: string[];
}
