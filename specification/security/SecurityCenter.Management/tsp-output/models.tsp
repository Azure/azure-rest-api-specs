import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Azure.ResourceManager.SecurityCenter;

interface Operations extends Azure.ResourceManager.Operations {}

enum CreatedByType {
  User,
  Application,
  ManagedIdentity,
  Key,
}

enum SupportedCloudEnum {
  AWS,
  GCP,
}

enum SeverityEnum {
  High,
  Medium,
  Low,
}

enum ResourceStatus {
  @doc("This assessment on the resource is healthy") Healthy,
  @doc("This assessment is not applicable to this resource") NotApplicable,
  @doc("This assessment is turned off by policy on this subscription")
  OffByPolicy,
  @doc("This assessment on the resource is not healthy") NotHealthy,
}

enum PricingTier {
  @doc("Get free Microsoft Defender for Cloud experience with basic security features")
  Free,
  @doc("Get the standard Microsoft Defender for Cloud experience with advanced security features")
  Standard,
}

enum IsEnabled {
  @doc("Indicates the extension is enabled") True,
  @doc("Indicates the extension is disabled") False,
}

enum Code {
  @doc("Extension was created/updated successfully.") Succeeded,
  @doc("Extension was not created/updated successfully. See operation status message for more details.")
  Failed,
}

enum ValueType {
  @doc("An IP range in CIDR format (e.g. '192.168.0.1/8').") IpCidr,
  @doc("Any string value.") String,
}

enum SecuritySolutionStatus {
  Enabled,
  Disabled,
}

enum ExportData {
  @doc("Agent raw events") RawEvents,
}

enum DataSource {
  @doc("Devices twin data") TwinData,
}

enum RecommendationType {
  @doc("Authentication schema used for pull an edge module from an ACR repository does not use Service Principal Authentication.")
  IoT_ACRAuthentication,
  @doc("IoT agent message size capacity is currently underutilized, causing an increase in the number of sent messages. Adjust message intervals for better utilization.")
  IoT_AgentSendsUnutilizedMessages,
  @doc("Identified security related system configuration issues.") IoT_Baseline,
  @doc("You can optimize Edge Hub memory usage by turning off protocol heads for any protocols not used by Edge modules in your solution.")
  IoT_EdgeHubMemOptimize,
  @doc("Logging is disabled for this edge module.") IoT_EdgeLoggingOptions,
  @doc("A minority within a device security group has inconsistent Edge Module settings with the rest of their group.")
  IoT_InconsistentModuleSettings,
  @doc("Install the Azure Security of Things Agent.") IoT_InstallAgent,
  @doc("IP Filter Configuration should have rules defined for allowed traffic and should deny all other traffic by default.")
  IoT_IPFilter_DenyAll,
  @doc("An Allow IP Filter rules source IP range is too large. Overly permissive rules might expose your IoT hub to malicious intenders.")
  IoT_IPFilter_PermissiveRule,
  @doc("A listening endpoint was found on the device.") IoT_OpenPorts,
  @doc("An Allowed firewall policy was found (INPUT/OUTPUT). The policy should Deny all traffic by default and define rules to allow necessary communication to/from the device.")
  IoT_PermissiveFirewallPolicy,
  @doc("A rule in the firewall has been found that contains a permissive pattern for a wide range of IP addresses or Ports.")
  IoT_PermissiveInputFirewallRules,
  @doc("A rule in the firewall has been found that contains a permissive pattern for a wide range of IP addresses or Ports.")
  IoT_PermissiveOutputFirewallRules,
  @doc("Edge module is configured to run in privileged mode, with extensive Linux capabilities or with host-level network access (send/receive data to host machine).")
  IoT_PrivilegedDockerOptions,
  @doc("Same authentication credentials to the IoT Hub used by multiple devices. This could indicate an illegitimate device impersonating a legitimate device. It also exposes the risk of device impersonation by an attacker.")
  IoT_SharedCredentials,
  @doc("Insecure TLS configurations detected. Immediate upgrade recommended.")
  IoT_VulnerableTLSCipherSuite,
}

enum RecommendationConfigStatus {
  Disabled,
  Enabled,
}

enum UnmaskedIpLoggingStatus {
  @doc("Unmasked IP logging is disabled") Disabled,
  @doc("Unmasked IP logging is enabled") Enabled,
}

enum AdditionalWorkspaceType {
  Sentinel,
}

enum AdditionalWorkspaceDataType {
  Alerts,
  RawEvents,
}

enum ReportedSeverity {
  Informational,
  Low,
  Medium,
  High,
}

enum AutoProvision {
  @doc("Install missing security agent on VMs automatically") On,
  @doc("Do not install security agent on the VMs automatically") Off,
}

enum InformationProtectionPolicyName {
  effective,
  custom,
}

enum SecurityAlertNotificationState {
  @doc("Get notifications on new alerts") On,
  @doc("Don't get notifications on new alerts") Off,
}

enum MinimalSeverity {
  @doc("Get notifications on new alerts with High severity") High,
  @doc("Get notifications on new alerts with medium or high severity") Medium,
  @doc("Don't get notifications on new alerts with low, medium or high severity")
  Low,
}

enum SecurityAlertNotificationByRoleState {
  @doc("Send notification on new alerts to the subscription's admins") On,
  @doc("Don't send notification on new alerts to the subscription's admins")
  Off,
}

enum Roles {
  @doc("If enabled, send notification on new alerts to the account admins")
  AccountAdmin,
  @doc("If enabled, send notification on new alerts to the service admins")
  ServiceAdmin,
  @doc("If enabled, send notification on new alerts to the subscription owners")
  Owner,
  @doc("If enabled, send notification on new alerts to the subscription contributors")
  Contributor,
}

enum State {
  @doc("All supported regulatory compliance controls in the given standard have a passed state")
  Passed,
  @doc("At least one supported regulatory compliance control in the given standard has a state of failed")
  Failed,
  @doc("All supported regulatory compliance controls in the given standard have a state of skipped")
  Skipped,
  @doc("No supported regulatory compliance data for the given standard")
  Unsupported,
}

enum SubAssessmentStatusCode {
  @doc("The resource is healthy") Healthy,
  @doc("The resource has a security issue that needs to be addressed")
  Unhealthy,
  @doc("Assessment for this resource did not happen") NotApplicable,
}

enum Severity {
  Low,
  Medium,
  High,
}

enum Source {
  @doc("Resource is in Azure") Azure,
  @doc("Resource in an on premise machine connected to Azure cloud") OnPremise,
  @doc("SQL Resource in an on premise machine connected to Azure cloud")
  OnPremiseSql,
}

enum AssessedResourceType {
  SqlServerVulnerability,
  ContainerRegistryVulnerability,
  ServerVulnerability,
}

enum EventSource {
  Assessments,
  AssessmentsSnapshot,
  SubAssessments,
  SubAssessmentsSnapshot,
  Alerts,
  SecureScores,
  SecureScoresSnapshot,
  SecureScoreControls,
  SecureScoreControlsSnapshot,
  RegulatoryComplianceAssessment,
  RegulatoryComplianceAssessmentSnapshot,
}

enum PropertyType {
  String,
  Integer,
  Number,
  Boolean,
}

enum Operator {
  @doc("Applies for decimal and non-decimal operands") Equals,
  @doc("Applies only for decimal operands") GreaterThan,
  @doc("Applies only for decimal operands") GreaterThanOrEqualTo,
  @doc("Applies only for decimal operands") LesserThan,
  @doc("Applies only for decimal operands") LesserThanOrEqualTo,
  @doc("Applies  for decimal and non-decimal operands") NotEquals,
  @doc("Applies only for non-decimal operands") Contains,
  @doc("Applies only for non-decimal operands") StartsWith,
  @doc("Applies only for non-decimal operands") EndsWith,
}

enum ActionType {
  LogicApp,
  EventHub,
  Workspace,
}

enum ServerVulnerabilityAssessmentPropertiesProvisioningState {
  Succeeded,
  Failed,
  Canceled,
  Provisioning,
  Deprovisioning,
}

enum Tactics {
  Reconnaissance,
  `Resource Development`,
  `Initial Access`,
  Execution,
  Persistence,
  `Privilege Escalation`,
  `Defense Evasion`,
  `Credential Access`,
  Discovery,
  `Lateral Movement`,
  Collection,
  `Command and Control`,
  Exfiltration,
  Impact,
}

enum Techniques {
  `Abuse Elevation Control Mechanism`,
  `Access Token Manipulation`,
  `Account Discovery`,
  `Account Manipulation`,
  `Active Scanning`,
  `Application Layer Protocol`,
  `Audio Capture`,
  `Boot or Logon Autostart Execution`,
  `Boot or Logon Initialization Scripts`,
  `Brute Force`,
  `Cloud Infrastructure Discovery`,
  `Cloud Service Dashboard`,
  `Cloud Service Discovery`,
  `Command and Scripting Interpreter`,
  `Compromise Client Software Binary`,
  `Compromise Infrastructure`,
  `Container and Resource Discovery`,
  `Create Account`,
  `Create or Modify System Process`,
  `Credentials from Password Stores`,
  `Data Destruction`,
  `Data Encrypted for Impact`,
  `Data from Cloud Storage Object`,
  `Data from Configuration Repository`,
  `Data from Information Repositories`,
  `Data from Local System`,
  `Data Manipulation`,
  `Data Staged`,
  Defacement,
  `Deobfuscate/Decode Files or Information`,
  `Disk Wipe`,
  `Domain Trust Discovery`,
  `Drive-by Compromise`,
  `Dynamic Resolution`,
  `Endpoint Denial of Service`,
  `Event Triggered Execution`,
  `Exfiltration Over Alternative Protocol`,
  `Exploit Public-Facing Application`,
  `Exploitation for Client Execution`,
  `Exploitation for Credential Access`,
  `Exploitation for Defense Evasion`,
  `Exploitation for Privilege Escalation`,
  `Exploitation of Remote Services`,
  `External Remote Services`,
  `Fallback Channels`,
  `File and Directory Discovery`,
  `Gather Victim Network Information`,
  `Hide Artifacts`,
  `Hijack Execution Flow`,
  `Impair Defenses`,
  `Implant Container Image`,
  `Indicator Removal on Host`,
  `Indirect Command Execution`,
  `Ingress Tool Transfer`,
  `Input Capture`,
  `Inter-Process Communication`,
  `Lateral Tool Transfer`,
  `Man-in-the-Middle`,
  Masquerading,
  `Modify Authentication Process`,
  `Modify Registry`,
  `Network Denial of Service`,
  `Network Service Scanning`,
  `Network Sniffing`,
  `Non-Application Layer Protocol`,
  `Non-Standard Port`,
  `Obtain Capabilities`,
  `Obfuscated Files or Information`,
  `Office Application Startup`,
  `OS Credential Dumping`,
  `Permission Groups Discovery`,
  Phishing,
  `Pre-OS Boot`,
  `Process Discovery`,
  `Process Injection`,
  `Protocol Tunneling`,
  Proxy,
  `Query Registry`,
  `Remote Access Software`,
  `Remote Service Session Hijacking`,
  `Remote Services`,
  `Remote System Discovery`,
  `Resource Hijacking`,
  `Scheduled Task/Job`,
  `Screen Capture`,
  `Search Victim-Owned Websites`,
  `Server Software Component`,
  `Service Stop`,
  `Signed Binary Proxy Execution`,
  `Software Deployment Tools`,
  `SQL Stored Procedures`,
  `Steal or Forge Kerberos Tickets`,
  `Subvert Trust Controls`,
  `Supply Chain Compromise`,
  `System Information Discovery`,
  `Taint Shared Content`,
  `Traffic Signaling`,
  `Transfer Data to Cloud Account`,
  `Trusted Relationship`,
  `Unsecured Credentials`,
  `User Execution`,
  `Valid Accounts`,
  `Windows Management Instrumentation`,
  `File and Directory Permissions Modification`,
}

enum Categories {
  Compute,
  Networking,
  Data,
  IdentityAndAccess,
  IoT,
}

enum UserImpact {
  Low,
  Moderate,
  High,
}

enum ImplementationEffort {
  Low,
  Moderate,
  High,
}

enum Threats {
  accountBreach,
  dataExfiltration,
  dataSpillage,
  maliciousInsider,
  elevationOfPrivilege,
  threatResistance,
  missingCoverage,
  denialOfService,
}

enum AssessmentType {
  @doc("Microsoft Defender for Cloud managed assessments") BuiltIn,
  @doc("User defined policies that are automatically ingested from Azure Policy to Microsoft Defender for Cloud")
  CustomPolicy,
  @doc("User assessments pushed directly by the user or other third party to Microsoft Defender for Cloud")
  CustomerManaged,
  @doc("An assessment that was created by a verified 3rd party if the user connected it to ASC")
  VerifiedPartner,
}

enum AssessmentStatusCode {
  @doc("The resource is healthy") Healthy,
  @doc("The resource has a security issue that needs to be addressed")
  Unhealthy,
  @doc("Assessment for this resource did not happen") NotApplicable,
}

enum ExpandEnum {
  @doc("All links associated with an assessment") links,
  @doc("Assessment metadata") metadata,
}

enum EnforcementMode {
  Audit,
  Enforce,
  None,
}

enum ConfigurationStatus {
  Configured,
  NotConfigured,
  InProgress,
  Failed,
  NoStatus,
}

enum RecommendationStatus {
  Recommended,
  NotRecommended,
  NotAvailable,
  NoStatus,
}

enum AdaptiveApplicationControlIssue {
  ViolationsAudited,
  ViolationsBlocked,
  MsiAndScriptViolationsAudited,
  MsiAndScriptViolationsBlocked,
  ExecutableViolationsAudited,
  RulesViolatedManually,
}

enum SourceSystem {
  Azure_AppLocker,
  Azure_AuditD,
  NonAzure_AppLocker,
  NonAzure_AuditD,
  None,
}

enum RecommendationAction {
  Recommended,
  Add,
  Remove,
}

enum EnforcementSupport {
  Supported,
  NotSupported,
  Unknown,
}

enum FileType {
  Exe,
  Dll,
  Msi,
  Script,
  Executable,
  Unknown,
}

enum Direction {
  Inbound,
  Outbound,
}

enum TransportProtocol {
  TCP,
  UDP,
}

enum ConnectionType {
  Internal,
  External,
}

enum Protocol {
  TCP,
  UDP,
  All: "*",
}

enum Status {
  Revoked,
  Initiated,
}

enum StatusReason {
  Expired,
  UserRequested,
  NewerRequestInitiated,
}

enum SecurityFamily {
  Waf,
  Ngfw,
  SaasWaf,
  Va,
}

enum ExternalSecuritySolutionKind {
  CEF,
  ATA,
  AAD,
}

enum ExpandControlsEnum {
  @doc("Add definition object for each control") definition,
}

enum ControlType {
  @doc("Microsoft Defender for Cloud managed assessments") BuiltIn,
  @doc("Non Microsoft Defender for Cloud managed assessments") Custom,
}

enum ProvisioningState {
  Succeeded,
  Failed,
  Updating,
}

enum HybridComputeProvisioningState {
  @doc("Valid service principal details.") Valid,
  @doc("Invalid service principal details.") Invalid,
  @doc("the service principal details are expired") Expired,
}

enum AuthenticationProvisioningState {
  @doc("Valid connector") Valid,
  @doc("Invalid connector") Invalid,
  @doc("the connection has expired") Expired,
  @doc("Incorrect policy of the connector") IncorrectPolicy,
}

enum PermissionProperty {
  @doc("This permission provides read only access to AWS Security Hub resources.")
  `AWS::AWSSecurityHubReadOnlyAccess`,
  @doc("This permission grants access to read security configuration metadata.")
  `AWS::SecurityAudit`,
  @doc("The permission provides for EC2 Automation service to execute activities defined within Automation documents.")
  `AWS::AmazonSSMAutomationRole`,
  @doc("This permission provides read only access to GCP Security Command Center.")
  `GCP::Security Center Admin Viewer`,
}

enum AuthenticationType {
  @doc("AWS cloud account connector user credentials authentication") awsCreds,
  @doc("AWS account connector assume role authentication") awsAssumeRole,
  @doc("GCP account connector service to service authentication")
  gcpCredentials,
}

enum AlertSeverity {
  @doc("Informational") Informational,
  @doc("Low") Low,
  @doc("Medium") Medium,
  @doc("High") High,
}

enum Intent {
  @doc("Unknown") Unknown,
  @doc("PreAttack could be either an attempt to access a certain resource regardless of a malicious intent, or a failed attempt to gain access to a target system to gather information prior to exploitation. This step is usually detected as an attempt, originating from outside the network, to scan the target system and find a way in.  Further details on the PreAttack stage can be read in [MITRE Pre-Att&ck matrix](https://attack.mitre.org/matrices/pre/).")
  PreAttack,
  @doc("InitialAccess is the stage where an attacker manages to get foothold on the attacked resource.")
  InitialAccess,
  @doc("Persistence is any access, action, or configuration change to a system that gives a threat actor a persistent presence on that system.")
  Persistence,
  @doc("Privilege escalation is the result of actions that allow an adversary to obtain a higher level of permissions on a system or network.")
  PrivilegeEscalation,
  @doc("Defense evasion consists of techniques an adversary may use to evade detection or avoid other defenses.")
  DefenseEvasion,
  @doc("Credential access represents techniques resulting in access to or control over system, domain, or service credentials that are used within an enterprise environment.")
  CredentialAccess,
  @doc("Discovery consists of techniques that allow the adversary to gain knowledge about the system and internal network.")
  Discovery,
  @doc("Lateral movement consists of techniques that enable an adversary to access and control remote systems on a network and could, but does not necessarily, include execution of tools on remote systems.")
  LateralMovement,
  @doc("The execution tactic represents techniques that result in execution of adversary-controlled code on a local or remote system.")
  Execution,
  @doc("Collection consists of techniques used to identify and gather information, such as sensitive files, from a target network prior to exfiltration.")
  Collection,
  @doc("Exfiltration refers to techniques and attributes that result or aid in the adversary removing files and information from a target network.")
  Exfiltration,
  @doc("The command and control tactic represents how adversaries communicate with systems under their control within a target network.")
  CommandAndControl,
  @doc("Impact events primarily try to directly reduce the availability or integrity of a system, service, or network; including manipulation of data to impact a business or operational process.")
  Impact,
  @doc("Probing could be either an attempt to access a certain resource regardless of a malicious intent, or a failed attempt to gain access to a target system to gather information prior to exploitation.")
  Probing,
  @doc("Exploitation is the stage where an attacker manages to get a foothold on the attacked resource. This stage is relevant for compute hosts and resources such as user accounts, certificates etc.")
  Exploitation,
}

enum ResourceIdentifierType {
  AzureResource,
  LogAnalytics,
}

enum AlertStatus {
  @doc("An alert which doesn't specify a value is assigned the status 'Active'")
  Active,
  @doc("An alert which is in handling state") InProgress,
  @doc("Alert closed after handling") Resolved,
  @doc("Alert dismissed as false positive") Dismissed,
}

enum Kind {
  @doc("Simulate alerts according to bundles") Bundles,
}

enum SettingKind {
  DataExportSettings,
  AlertSuppressionSetting,
  AlertSyncSettings,
}

enum SettingName {
  MCAS,
  WDATP,
  WDATP_EXCLUDE_LINUX_PUBLIC_PREVIEW,
  WDATP_UNIFIED_SOLUTION,
  Sentinel,
}

enum EndOfSupportStatus {
  None,
  noLongerSupported,
  versionNoLongerSupported,
  upcomingNoLongerSupported,
  upcomingVersionNoLongerSupported,
}

enum CloudName {
  Azure,
  AWS,
  GCP,
  Github,
  AzureDevOps,
}

enum OfferingType {
  CspmMonitorAws,
  DefenderForContainersAws,
  DefenderForServersAws,
  DefenderForDatabasesAws,
  InformationProtectionAws,
  CspmMonitorGcp,
  CspmMonitorGithub,
  CspmMonitorAzureDevOps,
  DefenderForServersGcp,
  DefenderForContainersGcp,
  DefenderForDatabasesGcp,
  DefenderCspmAws,
  DefenderCspmGcp,
  DefenderForDevOpsGithub,
  DefenderForDevOpsAzureDevOps,
}

enum EnvironmentType {
  AwsAccount,
  GcpProject,
  GithubScope,
  AzureDevOpsScope,
}

enum GovernanceRuleType {
  @doc("The source of the rule type definition is integrated") Integrated,
  @doc("The source of the rule type definition is ServiceNow") ServiceNow,
}

enum GovernanceRuleSourceResourceType {
  @doc("The source of the governance rule is assessments") Assessments,
}

enum GovernanceRuleOwnerSourceType {
  @doc("The rule source type defined using resource tag") ByTag,
  @doc("The rule source type defined manually") Manually,
}

enum ApplicationSourceResourceType {
  @doc("The source of the application is assessments") Assessments,
}

enum ScanTriggerType {
  @doc("OnDemand") OnDemand,
  @doc("Recurring") Recurring,
}

enum ScanState {
  @doc("Failed") Failed,
  @doc("FailedToRun") FailedToRun,
  @doc("InProgress") InProgress,
  @doc("Passed") Passed,
}

enum RuleStatus {
  @doc("NonFinding") NonFinding,
  @doc("Finding") Finding,
  @doc("InternalError") InternalError,
}

enum RuleSeverity {
  @doc("High") High,
  @doc("Medium") Medium,
  @doc("Low") Low,
  @doc("Informational") Informational,
  @doc("Obsolete") Obsolete,
}

enum RuleType {
  @doc("Binary") Binary,
  @doc("BaselineExpected") BaselineExpected,
  @doc("PositiveList") PositiveList,
  @doc("NegativeList") NegativeList,
}

enum AadConnectivityStateType {
  Discovered,
  NotLicensed,
  Connected,
}

enum BundleType {
  AppServices,
  DNS,
  KeyVaults,
  KubernetesService,
  ResourceManager,
  SqlServers,
  StorageAccounts,
  VirtualMachines,
  CosmosDbs,
}

enum OrganizationMembershipType {
  Member,
  Organization,
}

enum VulnerabilityAssessmentAutoProvisioningType {
  Qualys,
  TVM,
}

enum AvailableSubPlanType {
  P1,
  P2,
}

enum ScanningMode {
  Default,
}

enum GovernanceRuleConditionOperator {
  @doc("Checks that the string value of the data defined in Property equals the given value - exact fit")
  Equals,
  @doc("Checks that the string value of the data defined in Property equals any of the given values (exact fit)")
  In,
}

enum OperationResultStatus {
  @doc("The operation succeeded") Succeeded,
  @doc("The operation failed") Failed,
  @doc("The operation canceled") Canceled,
}

enum ApplicationConditionOperator {
  @doc("Checks that the string value of the data defined in Property contains the given value")
  Contains,
  @doc("Checks that the string value of the data defined in Property equals the given value")
  Equals,
  @doc("Checks that the string value of the data defined in Property equals any of the given values (exact fit)")
  In,
}

enum TaskUpdateActionType {
  Activate,
  Dismiss,
  Start,
  Resolve,
  Close,
}
@Azure.Core.fixed
enum Rank {
  None,
  Low,
  Medium,
  High,
  Critical,
}
@Azure.Core.fixed
enum RuleState {
  Enabled,
  Disabled,
  Expired,
}

@doc("List of all MDE onboarding data resources")
model MdeOnboardingDataList {
  @doc("List of the resources of the configuration or data needed to onboard the machine to MDE")
  value?: MdeOnboardingData[];
}

@doc("The resource of the configuration or data needed to onboard the machine to MDE")
model MdeOnboardingData extends Resource {
  @doc("Properties of the MDE configuration or data parameter needed to onboard the machine to MDE")
  properties?: MdeOnboardingDataProperties;
}

@doc("Properties of the MDE configuration or data parameter needed to onboard the machine to MDE")
model MdeOnboardingDataProperties {
  @doc("The onboarding package used to onboard Windows machines to MDE, coded in base64. This can also be used for onboarding using the dedicated VM Extension")
  onboardingPackageWindows?: bytes;

  @doc("The onboarding package used to onboard Linux machines to MDE, coded in base64. This can also be used for onboarding using the dedicated VM Extension")
  onboardingPackageLinux?: bytes;
}

@doc("Common error response for all Azure Resource Manager APIs to return error details for failed operations. (This also follows the OData error response format.).")
@error
model CloudError {
  @doc("The error object.")
  error?: CloudErrorBody;
}

@doc("The error detail.")
model CloudErrorBody {
  @doc("The error code.")
  @visibility("read")
  code?: string;

  @doc("The error message.")
  @visibility("read")
  message?: string;

  @doc("The error target.")
  @visibility("read")
  target?: string;

  @doc("The error details.")
  @visibility("read")
  details?: CloudErrorBody[];

  @doc("The error additional info.")
  @visibility("read")
  additionalInfo?: ErrorAdditionalInfo[];
}

@doc("describes the Custom Assessment Automation properties")
model CustomAssessmentAutomationProperties {
  @doc("GZip encoded KQL query representing the assessment automation results required.")
  compressedQuery?: string;

  @doc("Relevant cloud for the custom assessment automation.")
  supportedCloud?: SupportedCloudEnum;

  @doc("The severity to relate to the assessments generated by this assessment automation.")
  severity?: SeverityEnum;

  @doc("The display name of the assessments generated by this assessment automation.")
  displayName?: string;

  @doc("The description to relate to the assessments generated by this assessment automation.")
  description?: string;

  @doc("The remediation description to relate to the assessments generated by this assessment automation.")
  remediationDescription?: string;

  @doc("The assessment metadata key used when an assessment is generated for this assessment automation.")
  assessmentKey?: string;
}

@doc("Custom Assessment Automation request")
model CustomAssessmentAutomationRequest extends Resource {
  @doc("describes Custom Assessment Automation request properties.")
  properties?: CustomAssessmentAutomationRequestProperties;
}

@doc("describes the Custom Assessment Automation properties")
model CustomAssessmentAutomationRequestProperties {
  @doc("Base 64 encoded KQL query representing the assessment automation results required.")
  compressedQuery?: string;

  @doc("Relevant cloud for the custom assessment automation.")
  supportedCloud?: SupportedCloudEnum;

  @doc("The severity to relate to the assessments generated by this assessment automation.")
  severity?: SeverityEnum;

  @doc("The display name of the assessments generated by this assessment automation.")
  displayName?: string;

  @doc("The description to relate to the assessments generated by this assessment automation.")
  description?: string;

  @doc("The remediation description to relate to the assessments generated by this assessment automation.")
  remediationDescription?: string;
}

@doc("describes the custom entity store assignment properties")
model CustomEntityStoreAssignmentProperties {
  @doc("The principal assigned with entity store. Format of principal is: [AAD type]=[PrincipalObjectId];[TenantId]")
  principal?: string;

  @doc("The link to entity store database.")
  entityStoreDatabaseLink?: string;
}

@doc("describes the custom entity store assignment request")
model CustomEntityStoreAssignmentRequest {
  @doc("describes properties of custom entity store assignment request")
  properties?: CustomEntityStoreAssignmentRequestProperties;
}

@doc("describes properties of custom entity store assignment request")
model CustomEntityStoreAssignmentRequestProperties {
  @doc("The principal assigned with entity store. If not provided, will use caller principal. Format of principal is: [AAD type]=[PrincipalObjectId];[TenantId]")
  principal?: string;
}

@doc("Compliance result data")
model ComplianceResultProperties {
  @doc("The status of the resource regarding a single assessment")
  @visibility("read")
  resourceStatus?: ResourceStatus;
}

@doc("Pricing properties for the relevant scope")
model PricingProperties {
  @doc("The pricing tier value. Microsoft Defender for Cloud is provided in two pricing tiers: free and standard. The standard tier offers advanced security capabilities, while the free tier offers basic security features.")
  pricingTier: PricingTier;

  @doc("The sub-plan selected for a Standard pricing configuration, when more than one sub-plan is available. Each sub-plan enables a set of security features. When not specified, full plan is applied.")
  subPlan?: string;

  @doc("The duration left for the subscriptions free trial period - in ISO 8601 format (e.g. P3Y6M4DT12H30M5S).")
  @visibility("read")
  freeTrialRemainingTime?: duration;

  @doc("Optional. If `pricingTier` is `Standard` then this property holds the date of the last time the `pricingTier` was set to `Standard`, when available (e.g 2023-03-01T12:42:42.1921106Z).")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  enablementTime?: utcDateTime;

  @doc("Optional. True if the plan is deprecated. If there are replacing plans they will appear in `replacedBy` property")
  @visibility("read")
  deprecated?: boolean;

  @doc("Optional. List of plans that replace this plan. This property exists only if this plan is deprecated.")
  @visibility("read")
  replacedBy?: string[];

  @doc("Optional. List of extensions offered under a plan.")
  extensions?: Extension[];
}

@doc("A plan's extension properties")
model Extension {
  @doc("""
The extension name. Supported values are: <br><br>**AgentlessDiscoveryForKubernetes** - API-based discovery of information about Kubernetes cluster architecture, workload objects, and setup. Required for Kubernetes inventory, identity and network exposure detection, attack path analysis and risk hunting as part of the cloud security explorer.
Available for CloudPosture plan.<br><br>**OnUploadMalwareScanning** - Limits the GB to be scanned per month for each storage account within the subscription. Once this limit reached on a given storage account, Blobs won't be scanned during current calendar month.
Available for StorageAccounts plan.<br><br>**SensitiveDataDiscovery** - Sensitive data discovery identifies Blob storage container with sensitive data such as credentials, credit cards, and more, to help prioritize and investigate security events.
Available for StorageAccounts and CloudPosture plans.<br><br>**ContainerRegistriesVulnerabilityAssessments** - Provides vulnerability management for images stored in your container registries.
Available for CloudPosture and Containers plans.
""")
  name: string;

  @doc("Indicates whether the extension is enabled.")
  isEnabled: IsEnabled;

  @doc("Property values associated with the extension.")
  additionalExtensionProperties?: Record<unknown>;

  @doc("Optional. A status describing the success/failure of the extension's enablement/disablement operation.")
  @visibility("read")
  operationStatus?: OperationStatus;
}

@doc("A status describing the success/failure of the extension's enablement/disablement operation.")
model OperationStatus {
  @doc("The operation status code.")
  code?: Code;

  @doc("Additional information regarding the success/failure of the operation.")
  message?: string;
}

@doc("The Advanced Threat Protection settings.")
model AdvancedThreatProtectionProperties {
  @doc("Indicates whether Advanced Threat Protection is enabled.")
  isEnabled?: boolean;
}

@doc("describes properties of a security group.")
model DeviceSecurityGroupProperties {
  @doc("The list of custom alert threshold rules.")
  thresholdRules?: ThresholdCustomAlertRule[];

  @doc("The list of custom alert time-window rules.")
  timeWindowRules?: TimeWindowCustomAlertRule[];

  @doc("The allow-list custom alert rules.")
  allowlistRules?: AllowlistCustomAlertRule[];

  @doc("The deny-list custom alert rules.")
  denylistRules?: DenylistCustomAlertRule[];
}

@doc("A custom alert rule that checks if a value (depends on the custom alert type) is within the given range.")
@discriminator("ruleType")
model ThresholdCustomAlertRule extends CustomAlertRule {
  @doc("The minimum threshold.")
  minThreshold: int32;

  @doc("The maximum threshold.")
  maxThreshold: int32;
}

@doc("A custom alert rule.")
@discriminator("ruleType")
model CustomAlertRule {
  @doc("The display name of the custom alert.")
  @visibility("read")
  displayName?: string;

  @doc("The description of the custom alert.")
  @visibility("read")
  description?: string;

  @doc("Status of the custom alert.")
  isEnabled: boolean;
}

@doc("A custom alert rule that checks if the number of activities (depends on the custom alert type) in a time window is within the given range.")
@discriminator("ruleType")
model TimeWindowCustomAlertRule extends ThresholdCustomAlertRule {
  @doc("The time window size in iso8601 format.")
  timeWindowSize: duration;
}

@doc("A custom alert rule that checks if a value (depends on the custom alert type) is allowed.")
@discriminator("ruleType")
model AllowlistCustomAlertRule extends ListCustomAlertRule {
  @doc("The values to allow. The format of the values depends on the rule type.")
  allowlistValues: string[];
}

@doc("A List custom alert rule.")
@discriminator("ruleType")
model ListCustomAlertRule extends CustomAlertRule {
  @doc("The value type of the items in the list.")
  @visibility("read")
  valueType?: ValueType;
}

@doc("A custom alert rule that checks if a value (depends on the custom alert type) is denied.")
model DenylistCustomAlertRule extends ListCustomAlertRule {
  @doc("The values to deny. The format of the values depends on the rule type.")
  denylistValues: string[];

  @doc("The type of the custom alert rule.")
  ruleType: "DenylistCustomAlertRule";
}

@doc("Security Solution setting data")
model IoTSecuritySolutionProperties {
  @doc("Workspace resource ID")
  workspace?: string;

  @doc("Resource display name.")
  displayName: string;

  @doc("Status of the IoT Security solution.")
  status?: SecuritySolutionStatus;

  @doc("List of additional options for exporting to workspace data.")
  export?: ExportData[];

  @doc("Disabled data sources. Disabling these data sources compromises the system.")
  disabledDataSources?: DataSource[];

  @doc("IoT Hub resource IDs")
  iotHubs: string[];

  @doc("Properties of the IoT Security solution's user defined resources.")
  userDefinedResources?: UserDefinedResourcesProperties;

  @doc("List of resources that were automatically discovered as relevant to the security solution.")
  @visibility("read")
  autoDiscoveredResources?: string[];

  @doc("List of the configuration status for each recommendation type.")
  recommendationsConfiguration?: RecommendationConfigurationProperties[];

  @doc("Unmasked IP address logging status")
  unmaskedIpLoggingStatus?: UnmaskedIpLoggingStatus;

  @doc("List of additional workspaces")
  additionalWorkspaces?: AdditionalWorkspacesProperties[];
}

@doc("Properties of the IoT Security solution's user defined resources.")
model UserDefinedResourcesProperties {
  @doc("Azure Resource Graph query which represents the security solution's user defined resources. Required to start with \"where type != \"Microsoft.Devices/IotHubs\"\"")
  query: string;

  @doc("List of Azure subscription ids on which the user defined resources query should be executed.")
  querySubscriptions: string[];
}

@doc("The type of IoT Security recommendation.")
model RecommendationConfigurationProperties {
  @doc("The type of IoT Security recommendation.")
  recommendationType: RecommendationType;

  @visibility("read")
  name?: string;

  @doc("Recommendation status. When the recommendation status is disabled recommendations are not generated.")
  status: RecommendationConfigStatus;
}

@doc("Properties of the additional workspaces.")
model AdditionalWorkspacesProperties {
  @doc("Workspace resource id")
  workspace?: string;

  @doc("Workspace type.")
  type?: AdditionalWorkspaceType;

  @doc("List of data types sent to workspace")
  dataTypes?: AdditionalWorkspaceDataType[];
}

@doc("A container holding only the Tags for a resource, allowing the user to update the tags.")
model TagsResource {
  @doc("Resource tags")
  tags?: Record<string>;
}

@doc("Security analytics properties of your IoT Security solution")
model IoTSecuritySolutionAnalyticsModelProperties {
  @doc("Security analytics of your IoT Security solution.")
  @visibility("read")
  metrics?: IoTSeverityMetrics;

  @doc("Number of unhealthy devices within your IoT Security solution.")
  @visibility("read")
  unhealthyDeviceCount?: int32;

  @doc("List of device metrics by the aggregation date.")
  @visibility("read")
  devicesMetrics?: IoTSecuritySolutionAnalyticsModelPropertiesDevicesMetricsItem[];

  @doc("List of the 3 devices with the most alerts.")
  topAlertedDevices?: IoTSecurityAlertedDevice[];

  @doc("List of the 3 most prevalent device alerts.")
  mostPrevalentDeviceAlerts?: IoTSecurityDeviceAlert[];

  @doc("List of the 3 most prevalent device recommendations.")
  mostPrevalentDeviceRecommendations?: IoTSecurityDeviceRecommendation[];
}

@doc("IoT Security solution analytics severity metrics.")
model IoTSeverityMetrics {
  @doc("Count of high severity alerts/recommendations.")
  high?: int32;

  @doc("Count of medium severity alerts/recommendations.")
  medium?: int32;

  @doc("Count of low severity alerts/recommendations.")
  low?: int32;
}

model IoTSecuritySolutionAnalyticsModelPropertiesDevicesMetricsItem {
  @doc("Aggregation of IoT Security solution device alert metrics by date.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  date?: utcDateTime;

  @doc("Device alert count by severity.")
  devicesMetrics?: IoTSeverityMetrics;
}

@doc("Statistical information about the number of alerts per device during last set number of days.")
model IoTSecurityAlertedDevice {
  @doc("Device identifier.")
  @visibility("read")
  deviceId?: string;

  @doc("Number of alerts raised for this device.")
  @visibility("read")
  alertsCount?: int32;
}

@doc("Statistical information about the number of alerts per alert type during last set number of days")
model IoTSecurityDeviceAlert {
  @doc("Display name of the alert")
  @visibility("read")
  alertDisplayName?: string;

  @doc("Assessed Alert severity.")
  @visibility("read")
  reportedSeverity?: ReportedSeverity;

  @doc("Number of alerts raised for this alert type.")
  @visibility("read")
  alertsCount?: int32;
}

@doc("Statistical information about the number of recommendations per device, per recommendation type.")
model IoTSecurityDeviceRecommendation {
  @doc("Display name of the recommendation.")
  @visibility("read")
  recommendationDisplayName?: string;

  @doc("Assessed recommendation severity.")
  @visibility("read")
  reportedSeverity?: ReportedSeverity;

  @doc("Number of devices with this recommendation.")
  @visibility("read")
  devicesCount?: int32;
}

@doc("IoT Security solution aggregated alert details.")
model IoTSecurityAggregatedAlertProperties {
  @doc("Name of the alert type.")
  @visibility("read")
  alertType?: string;

  @doc("Display name of the alert type.")
  @visibility("read")
  alertDisplayName?: string;

  @doc("Date of detection.")
  @visibility("read")
  aggregatedDateUtc?: plainDate;

  @doc("Name of the organization that raised the alert.")
  @visibility("read")
  vendorName?: string;

  @doc("Assessed alert severity.")
  @visibility("read")
  reportedSeverity?: ReportedSeverity;

  @doc("Recommended steps for remediation.")
  @visibility("read")
  remediationSteps?: string;

  @doc("Description of the suspected vulnerability and meaning.")
  @visibility("read")
  description?: string;

  @doc("Number of alerts occurrences within the aggregated time window.")
  @visibility("read")
  count?: int32;

  @doc("Azure resource ID of the resource that received the alerts.")
  @visibility("read")
  effectedResourceType?: string;

  @doc("The type of the alerted resource (Azure, Non-Azure).")
  @visibility("read")
  systemSource?: string;

  @doc("IoT Security solution alert response.")
  @visibility("read")
  actionTaken?: string;

  @doc("Log analytics query for getting the list of affected devices/alerts.")
  @visibility("read")
  logAnalyticsQuery?: string;

  @doc("10 devices with the highest number of occurrences of this alert type, on this day.")
  @visibility("read")
  topDevicesList?: IoTSecurityAggregatedAlertPropertiesTopDevicesListItem[];
}

model IoTSecurityAggregatedAlertPropertiesTopDevicesListItem {
  @doc("Name of the device.")
  @visibility("read")
  deviceId?: string;

  @doc("Number of alerts raised for this device.")
  @visibility("read")
  alertsCount?: int32;

  @doc("Most recent time this alert was raised for this device, on this day.")
  @visibility("read")
  lastOccurrence?: string;
}

@doc("IoT Security solution aggregated recommendation information")
model IoTSecurityAggregatedRecommendationProperties {
  @doc("Name of the recommendation.")
  recommendationName?: string;

  @doc("Display name of the recommendation type.")
  @visibility("read")
  recommendationDisplayName?: string;

  @doc("Description of the suspected vulnerability and meaning.")
  @visibility("read")
  description?: string;

  @doc("Recommendation-type GUID.")
  @visibility("read")
  recommendationTypeId?: string;

  @doc("Name of the organization that made the recommendation.")
  @visibility("read")
  detectedBy?: string;

  @doc("Recommended steps for remediation")
  @visibility("read")
  remediationSteps?: string;

  @doc("Assessed recommendation severity.")
  @visibility("read")
  reportedSeverity?: ReportedSeverity;

  @doc("Number of healthy devices within the IoT Security solution.")
  @visibility("read")
  healthyDevices?: int32;

  @doc("Number of unhealthy devices within the IoT Security solution.")
  @visibility("read")
  unhealthyDeviceCount?: int32;

  @doc("Log analytics query for getting the list of affected devices/alerts.")
  @visibility("read")
  logAnalyticsQuery?: string;
}

@doc("List of possible operations for Microsoft.Security resource provider")
model OperationList is Azure.Core.Page<Operation>;

@doc("Describes properties of a task.")
model SecurityTaskProperties {
  @doc("State of the task (Active, Resolved etc.)")
  @visibility("read")
  state?: string;

  @doc("The time this task was discovered in UTC")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTimeUtc?: utcDateTime;

  @doc("Changing set of properties, depending on the task type that is derived from the name field")
  securityTaskParameters?: SecurityTaskParameters;

  @doc("The time this task's details were last changed in UTC")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastStateChangeTimeUtc?: utcDateTime;

  @doc("Additional data on the state of the task")
  @visibility("read")
  subState?: string;
}

@doc("Changing set of properties, depending on the task type that is derived from the name field")
model SecurityTaskParameters extends Record<unknown> {
  @doc("Name of the task type")
  @visibility("read")
  name?: string;
}

@doc("describes properties of an auto provisioning setting")
model AutoProvisioningSettingProperties {
  @doc("Describes what kind of security agent provisioning action to take")
  autoProvision: AutoProvision;
}

@doc("The Compliance score (percentage) of a Subscription is a sum of all Resources' Compliances under the given Subscription. A Resource Compliance is defined as the compliant ('healthy') Policy Definitions out of all Policy Definitions applicable to a given resource.")
model ComplianceProperties {
  @doc("The timestamp when the Compliance calculation was conducted.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  assessmentTimestampUtcDate?: utcDateTime;

  @doc("The resource count of the given subscription for which the Compliance calculation was conducted (needed for Management Group Compliance calculation).")
  @visibility("read")
  resourceCount?: int32;

  @doc("An array of segment, which is the actually the compliance assessment.")
  @visibility("read")
  assessmentResult?: ComplianceSegment[];
}

@doc("A segment of a compliance assessment.")
model ComplianceSegment {
  @doc("The segment type, e.g. compliant, non-compliance, insufficient coverage, N/A, etc.")
  @visibility("read")
  segmentType?: string;

  @doc("The size (%) of the segment.")
  @visibility("read")
  percentage?: float32;
}

@doc("Information protection policy.")
model InformationProtectionPolicy extends Resource {
  @doc("Information protection policy data")
  properties?: InformationProtectionPolicyProperties;
}

@doc("describes properties of an information protection policy.")
model InformationProtectionPolicyProperties {
  @doc("Describes the last UTC time the policy was modified.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedUtc?: utcDateTime;

  @doc("Describes the version of the policy.")
  @visibility("read")
  version?: string;

  @doc("Dictionary of sensitivity labels.")
  labels?: Record<SensitivityLabel>;

  @doc("The sensitivity information types.")
  informationTypes?: Record<InformationType>;
}

@doc("The sensitivity label.")
model SensitivityLabel {
  @doc("The name of the sensitivity label.")
  displayName?: string;

  @doc("The description of the sensitivity label.")
  description?: string;

  @doc("The rank of the sensitivity label.")
  rank?: Rank;

  @doc("The order of the sensitivity label.")
  order?: int32;

  @doc("Indicates whether the label is enabled or not.")
  enabled?: boolean;
}

@doc("The information type.")
model InformationType {
  @doc("The name of the information type.")
  displayName?: string;

  @doc("The description of the information type.")
  description?: string;

  @doc("The order of the information type.")
  order?: int32;

  @doc("The recommended label id to be associated with this information type.")
  recommendedLabelId?: string;

  @doc("Indicates whether the information type is enabled or not.")
  enabled?: boolean;

  @doc("Indicates whether the information type is custom or not.")
  custom?: boolean;

  @doc("The information type keywords.")
  keywords?: InformationProtectionKeyword[];
}

@doc("The information type keyword.")
model InformationProtectionKeyword {
  @doc("The keyword pattern.")
  pattern?: string;

  @doc("Indicates whether the keyword is custom or not.")
  custom?: boolean;

  @doc("Indicates whether the keyword can be applied on numeric types or not.")
  canBeNumeric?: boolean;

  @doc("Indicates whether the keyword is excluded or not.")
  excluded?: boolean;
}

@doc("Information protection policies response.")
model InformationProtectionPolicyList
  is Azure.Core.Page<InformationProtectionPolicy>;

@doc("Describes security contact properties")
model SecurityContactProperties {
  @doc("List of email addresses which will get notifications from Microsoft Defender for Cloud by the configurations defined in this security contact.")
  emails?: string;

  @doc("The security contact's phone number")
  phone?: string;

  @doc("Defines whether to send email notifications about new security alerts")
  alertNotifications?: SecurityContactPropertiesAlertNotifications;

  @doc("Defines whether to send email notifications from Microsoft Defender for Cloud to persons with specific RBAC roles on the subscription.")
  notificationsByRole?: SecurityContactPropertiesNotificationsByRole;
}

@doc("Defines whether to send email notifications about new security alerts")
model SecurityContactPropertiesAlertNotifications {
  @doc("Defines if email notifications will be sent about new security alerts")
  state?: SecurityAlertNotificationState;

  @doc("Defines the minimal alert severity which will be sent as email notifications")
  minimalSeverity?: MinimalSeverity;
}

@doc("Defines whether to send email notifications from Microsoft Defender for Cloud to persons with specific RBAC roles on the subscription.")
model SecurityContactPropertiesNotificationsByRole {
  @doc("Defines whether to send email notifications from AMicrosoft Defender for Cloud to persons with specific RBAC roles on the subscription.")
  state?: SecurityAlertNotificationByRoleState;

  @doc("Defines which RBAC roles will get email notifications from Microsoft Defender for Cloud. List of allowed RBAC roles: ")
  roles?: Roles[];
}

@doc("Workspace setting data")
model WorkspaceSettingProperties {
  @doc("The full Azure ID of the workspace to save the data in")
  workspaceId: string;

  @doc("All the VMs in this scope will send their security data to the mentioned workspace unless overridden by a setting with more specific scope")
  scope: string;
}

@doc("Regulatory compliance standard data")
model RegulatoryComplianceStandardProperties {
  @doc("Aggregative state based on the standard's supported controls states")
  state?: State;

  @doc("The number of supported regulatory compliance controls of the given standard with a passed state")
  @visibility("read")
  passedControls?: int32;

  @doc("The number of supported regulatory compliance controls of the given standard with a failed state")
  @visibility("read")
  failedControls?: int32;

  @doc("The number of supported regulatory compliance controls of the given standard with a skipped state")
  @visibility("read")
  skippedControls?: int32;

  @doc("The number of regulatory compliance controls of the given standard which are unsupported by automated assessments")
  @visibility("read")
  unsupportedControls?: int32;
}

@doc("Regulatory compliance control data")
model RegulatoryComplianceControlProperties {
  @doc("The description of the regulatory compliance control")
  @visibility("read")
  description?: string;

  @doc("Aggregative state based on the control's supported assessments states")
  state?: State;

  @doc("The number of supported regulatory compliance assessments of the given control with a passed state")
  @visibility("read")
  passedAssessments?: int32;

  @doc("The number of supported regulatory compliance assessments of the given control with a failed state")
  @visibility("read")
  failedAssessments?: int32;

  @doc("The number of supported regulatory compliance assessments of the given control with a skipped state")
  @visibility("read")
  skippedAssessments?: int32;
}

@doc("Regulatory compliance assessment data")
model RegulatoryComplianceAssessmentProperties {
  @doc("The description of the regulatory compliance assessment")
  @visibility("read")
  description?: string;

  @doc("The expected type of assessment contained in the AssessmentDetailsLink")
  @visibility("read")
  assessmentType?: string;

  @doc("Link to more detailed assessment results data. The response type will be according to the assessmentType field")
  @visibility("read")
  assessmentDetailsLink?: string;

  @doc("Aggregative state based on the assessment's scanned resources states")
  state?: State;

  @doc("The given assessment's related resources count with passed state.")
  @visibility("read")
  passedResources?: int32;

  @doc("The given assessment's related resources count with failed state.")
  @visibility("read")
  failedResources?: int32;

  @doc("The given assessment's related resources count with skipped state.")
  @visibility("read")
  skippedResources?: int32;

  @doc("The given assessment's related resources count with unsupported state.")
  @visibility("read")
  unsupportedResources?: int32;
}

@doc("Describes properties of an sub-assessment.")
model SecuritySubAssessmentProperties {
  @doc("Vulnerability ID")
  @visibility("read")
  id?: string;

  @doc("User friendly display name of the sub-assessment")
  @visibility("read")
  displayName?: string;

  @doc("Status of the sub-assessment")
  status?: SubAssessmentStatus;

  @doc("Information on how to remediate this sub-assessment")
  @visibility("read")
  remediation?: string;

  @doc("Description of the impact of this sub-assessment")
  @visibility("read")
  impact?: string;

  @doc("Category of the sub-assessment")
  @visibility("read")
  category?: string;

  @doc("Human readable description of the assessment status")
  @visibility("read")
  description?: string;

  @doc("The date and time the sub-assessment was generated")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timeGenerated?: utcDateTime;

  @doc("Details of the resource that was assessed")
  resourceDetails?: ResourceDetails;

  @doc("Details of the sub-assessment")
  additionalData?: AdditionalData;
}

@doc("Status of the sub-assessment")
model SubAssessmentStatus {
  @doc("Programmatic code for the status of the assessment")
  @visibility("read")
  code?: SubAssessmentStatusCode;

  @doc("Programmatic code for the cause of the assessment status")
  @visibility("read")
  cause?: string;

  @doc("Human readable description of the assessment status")
  @visibility("read")
  description?: string;

  @doc("The sub-assessment severity level")
  @visibility("read")
  severity?: Severity;
}

@doc("Details of the resource that was assessed")
@discriminator("source")
model ResourceDetails {}

@doc("Details of the sub-assessment")
@discriminator("assessedResourceType")
model AdditionalData {}

@doc("A set of properties that defines the behavior of the automation configuration. To learn more about the supported security events data models schemas - please visit https://aka.ms/ASCAutomationSchemas.")
model AutomationProperties {
  @doc("The security automation description.")
  description?: string;

  @doc("Indicates whether the security automation is enabled.")
  isEnabled?: boolean;

  @doc("A collection of scopes on which the security automations logic is applied. Supported scopes are the subscription itself or a resource group under that subscription. The automation will only apply on defined scopes.")
  scopes?: AutomationScope[];

  @doc("A collection of the source event types which evaluate the security automation set of rules.")
  sources?: AutomationSource[];

  @doc("A collection of the actions which are triggered if all the configured rules evaluations, within at least one rule set, are true.")
  actions?: AutomationAction[];
}

@doc("A single automation scope.")
model AutomationScope {
  @doc("The resources scope description.")
  description?: string;

  @doc("The resources scope path. Can be the subscription on which the automation is defined on or a resource group under that subscription (fully qualified Azure resource IDs).")
  scopePath?: string;
}

@doc("The source event types which evaluate the security automation set of rules. For example - security alerts and security assessments. To learn more about the supported security events data models schemas - please visit https://aka.ms/ASCAutomationSchemas.")
model AutomationSource {
  @doc("A valid event source type.")
  eventSource?: EventSource;

  @doc("A set of rules which evaluate upon event interception. A logical disjunction is applied between defined rule sets (logical 'or').")
  ruleSets?: AutomationRuleSet[];
}

@doc("A rule set which evaluates all its rules upon an event interception. Only when all the included rules in the rule set will be evaluated as 'true', will the event trigger the defined actions.")
model AutomationRuleSet {
  rules?: AutomationTriggeringRule[];
}

@doc("A rule which is evaluated upon event interception. The rule is configured by comparing a specific value from the event model to an expected value. This comparison is done by using one of the supported operators set.")
model AutomationTriggeringRule {
  @doc("The JPath of the entity model property that should be checked.")
  propertyJPath?: string;

  @doc("The data type of the compared operands (string, integer, floating point number or a boolean [true/false]]")
  propertyType?: PropertyType;

  @doc("The expected value.")
  expectedValue?: string;

  @doc("A valid comparer operator to use. A case-insensitive comparison will be applied for String PropertyType.")
  operator?: Operator;
}

@doc("The action that should be triggered.")
@discriminator("actionType")
model AutomationAction {}

@doc("Describes an Azure resource with location")
model AzureTrackedResourceLocation {
  @doc("Location where the resource is stored")
  location?: string;
}

@doc("Entity tag is used for comparing two or more entities from the same requested resource.")
model ETag {
  @doc("Entity tag is used for comparing two or more entities from the same requested resource.")
  etag?: string;
}

@doc("A list of key value pairs that describe the resource.")
model Tags {
  @doc("A list of key value pairs that describe the resource.")
  tags?: Record<string>;
}

@doc("The security automation model state property bag.")
model AutomationValidationStatus {
  @doc("Indicates whether the model is valid or not.")
  isValid?: boolean;

  @doc("The validation message.")
  message?: string;
}

@doc("describes AlertsSuppressionRule properties")
model AlertsSuppressionRuleProperties {
  @doc("Type of the alert to automatically suppress. For all alert types, use '*'")
  alertType: string;

  @doc("The last time this rule was modified")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedUtc?: utcDateTime;

  @doc("Expiration date of the rule, if value is not provided or provided as null this field will default to the maximum allowed expiration date.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expirationDateUtc?: utcDateTime;

  @doc("The reason for dismissing the alert")
  reason: string;

  @doc("Possible states of the rule")
  state: RuleState;

  @doc("Any comment regarding the rule")
  comment?: string;

  @doc("The suppression conditions")
  suppressionAlertsScope?: SuppressionAlertsScope;
}

model SuppressionAlertsScope {
  @doc("All the conditions inside need to be true in order to suppress the alert")
  allOf: ScopeElement[];
}

@doc("A more specific scope used to identify the alerts to suppress.")
model ScopeElement extends Record<unknown> {
  @doc("The alert entity type to suppress by.")
  field?: string;
}

@doc("describes ServerVulnerabilityAssessment properties.")
model ServerVulnerabilityAssessmentProperties {
  @doc("The provisioningState of the vulnerability assessment capability on the VM")
  @visibility("read")
  provisioningState?: ServerVulnerabilityAssessmentPropertiesProvisioningState;
}

@doc("Describes properties of an assessment metadata response.")
model SecurityAssessmentMetadataPropertiesResponse
  extends SecurityAssessmentMetadataProperties {
  publishDates?: SecurityAssessmentMetadataPropertiesResponsePublishDates;

  @pattern("^[0-9]{2}/[0-9]{4}$")
  plannedDeprecationDate?: string;

  tactics?: Tactics[];
  techniques?: Techniques[];
}

model SecurityAssessmentMetadataPropertiesResponsePublishDates {
  @pattern("^([0-9]{2}/){2}[0-9]{4}$")
  GA?: string;

  @pattern("^([0-9]{2}/){2}[0-9]{4}$")
  public: string;
}

@doc("Describes properties of an assessment metadata.")
model SecurityAssessmentMetadataProperties {
  @doc("User friendly display name of the assessment")
  displayName: string;

  @doc("Azure resource ID of the policy definition that turns this assessment calculation on")
  @visibility("read")
  policyDefinitionId?: string;

  @doc("Human readable description of the assessment")
  description?: string;

  @doc("Human readable description of what you should do to mitigate this security issue")
  remediationDescription?: string;

  categories?: Categories[];

  @doc("The severity level of the assessment")
  severity: Severity;

  @doc("The user impact of the assessment")
  userImpact?: UserImpact;

  @doc("The implementation effort required to remediate this assessment")
  implementationEffort?: ImplementationEffort;

  threats?: Threats[];

  @doc("True if this assessment is in preview release status")
  preview?: boolean;

  @doc("BuiltIn if the assessment based on built-in Azure Policy definition, Custom if the assessment based on custom Azure Policy definition")
  assessmentType: AssessmentType;

  @doc("Describes the partner that created the assessment")
  partnerData?: SecurityAssessmentMetadataPartnerData;
}

@doc("Describes the partner that created the assessment")
model SecurityAssessmentMetadataPartnerData {
  @doc("Name of the company of the partner")
  partnerName: string;

  @doc("Name of the product of the partner that created the assessment")
  productName?: string;

  @doc("Secret to authenticate the partner and verify it created the assessment - write only")
  secret: string;
}

@doc("Page of a security assessments list")
model SecurityAssessmentList is Azure.Core.Page<SecurityAssessmentResponse>;

@doc("Describes properties of an assessment.")
model SecurityAssessmentPropertiesResponse
  extends SecurityAssessmentPropertiesBase {
  @doc("The result of the assessment")
  status: AssessmentStatusResponse;
}

@doc("The result of the assessment")
model AssessmentStatusResponse extends AssessmentStatus {
  @doc("The time that the assessment was created and first evaluated. Returned as UTC time in ISO 8601 format")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  firstEvaluationDate?: utcDateTime;

  @doc("The time that the status of the assessment last changed. Returned as UTC time in ISO 8601 format")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  statusChangeDate?: utcDateTime;
}

@doc("The result of the assessment")
model AssessmentStatus {
  @doc("Programmatic code for the status of the assessment")
  code: AssessmentStatusCode;

  @doc("Programmatic code for the cause of the assessment status")
  cause?: string;

  @doc("Human readable description of the assessment status")
  description?: string;
}

@doc("Describes properties of an assessment.")
model SecurityAssessmentPropertiesBase {
  @doc("Details of the resource that was assessed")
  resourceDetails: ResourceDetails;

  @doc("User friendly display name of the assessment")
  @visibility("read")
  displayName?: string;

  @doc("Additional data regarding the assessment")
  additionalData?: Record<string>;

  @doc("Links relevant to the assessment")
  @visibility("read")
  links?: AssessmentLinks;

  @doc("Describes properties of an assessment metadata.")
  metadata?: SecurityAssessmentMetadataProperties;

  @doc("Data regarding 3rd party partner integration")
  partnersData?: SecurityAssessmentPartnerData;
}

@doc("Links relevant to the assessment")
model AssessmentLinks {
  @doc("Link to assessment in Azure Portal")
  @visibility("read")
  azurePortalUri?: string;
}

@doc("Data regarding 3rd party partner integration")
model SecurityAssessmentPartnerData {
  @doc("Name of the company of the partner")
  partnerName: string;

  @doc("secret to authenticate the partner - write only")
  secret: string;
}

@doc("Security assessment on a resource")
model SecurityAssessment extends Resource {
  @doc("Describes properties of an assessment.")
  properties?: SecurityAssessmentProperties;
}

@doc("Describes properties of an assessment.")
model SecurityAssessmentProperties extends SecurityAssessmentPropertiesBase {
  @doc("The result of the assessment")
  status: AssessmentStatus;
}

@doc("Represents a machines group and set of rules to be allowed running on a machine")
model AdaptiveApplicationControlGroupData {
  @doc("The application control policy enforcement/protection mode of the machine group")
  enforcementMode?: EnforcementMode;

  @doc("The protection mode of the collection/file types. Exe/Msi/Script are used for Windows, Executable is used for Linux.")
  protectionMode?: ProtectionMode;

  @doc("The configuration status of the machines group or machine or rule")
  @visibility("read")
  configurationStatus?: ConfigurationStatus;

  @doc("The initial recommendation status of the machine group or machine")
  @visibility("read")
  recommendationStatus?: RecommendationStatus;

  @visibility("read")
  issues?: AdaptiveApplicationControlIssueSummary[];

  @doc("The source type of the machine group")
  @visibility("read")
  sourceSystem?: SourceSystem;

  vmRecommendations?: VmRecommendation[];
  pathRecommendations?: PathRecommendation[];
}

@doc("The protection mode of the collection/file types. Exe/Msi/Script are used for Windows, Executable is used for Linux.")
model ProtectionMode {
  @doc("The application control policy enforcement/protection mode of the machine group")
  exe?: EnforcementMode;

  @doc("The application control policy enforcement/protection mode of the machine group")
  msi?: EnforcementMode;

  @doc("The application control policy enforcement/protection mode of the machine group")
  script?: EnforcementMode;

  @doc("The application control policy enforcement/protection mode of the machine group")
  executable?: EnforcementMode;
}

@doc("Represents a summary of the alerts of the machine group")
model AdaptiveApplicationControlIssueSummary {
  @doc("An alert that machines within a group can have")
  issue?: AdaptiveApplicationControlIssue;

  @doc("The number of machines in the group that have this alert")
  numberOfVms?: float32;
}

@doc("Represents a machine that is part of a machine group")
model VmRecommendation {
  @doc("The configuration status of the machines group or machine or rule")
  configurationStatus?: ConfigurationStatus;

  @doc("The recommendation action of the machine or rule")
  recommendationAction?: RecommendationAction;

  @doc("The full resource id of the machine")
  resourceId?: string;

  @doc("The machine supportability of Enforce feature")
  enforcementSupport?: EnforcementSupport;
}

@doc("Represents a path that is recommended to be allowed and its properties")
model PathRecommendation {
  @doc("The full path of the file, or an identifier of the application")
  path?: string;

  @doc("The recommendation action of the machine or rule")
  action?: RecommendationAction;

  @doc("The type of IoT Security recommendation.")
  type?: RecommendationType;

  @doc("Represents the publisher information of a process/rule")
  publisherInfo?: PublisherInfo;

  @doc("Whether the application is commonly run on the machine")
  common?: boolean;

  userSids?: string[];
  usernames?: UserRecommendation[];

  @doc("The type of the file (for Linux files - Executable is used)")
  fileType?: FileType;

  @doc("The configuration status of the machines group or machine or rule")
  configurationStatus?: ConfigurationStatus;
}

@doc("Represents the publisher information of a process/rule")
model PublisherInfo {
  @doc("The Subject field of the x.509 certificate used to sign the code, using the following fields -  O = Organization, L = Locality, S = State or Province, and C = Country")
  publisherName?: string;

  @doc("The product name taken from the file's version resource")
  productName?: string;

  @doc("The \"OriginalName\" field taken from the file's version resource")
  binaryName?: string;

  @doc("The binary file version taken from the file's version resource")
  version?: string;
}

@doc("Represents a user that is recommended to be allowed for a certain rule")
model UserRecommendation {
  @doc("Represents a user that is recommended to be allowed for a certain rule")
  username?: string;

  @doc("The recommendation action of the machine or rule")
  recommendationAction?: RecommendationAction;
}

@doc("Describes an Azure resource with location")
model Location {
  @doc("Location where the resource is stored")
  @visibility("read")
  location?: string;
}

@doc("Adaptive Network Hardening resource properties")
model AdaptiveNetworkHardeningProperties {
  @doc("The security rules which are recommended to be effective on the VM")
  rules?: Rule[];

  @doc("The UTC time on which the rules were calculated")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  rulesCalculationTime?: utcDateTime;

  @doc("The Network Security Groups effective on the network interfaces of the protected resource")
  effectiveNetworkSecurityGroups?: EffectiveNetworkSecurityGroups[];
}

@doc("Describes remote addresses that is recommended to communicate with the Azure resource on some (Protocol, Port, Direction). All other remote addresses are recommended to be blocked")
model Rule {
  @doc("The name of the rule")
  name?: string;

  @doc("The rule's direction")
  direction?: Direction;

  @doc("The rule's destination port")
  @maxValue(65535)
  destinationPort?: int32;

  @doc("The rule's transport protocols")
  protocols?: TransportProtocol[];

  @doc("The remote IP addresses that should be able to communicate with the Azure resource on the rule's destination port and protocol")
  ipAddresses?: string[];
}

@doc("Describes the Network Security Groups effective on a network interface")
model EffectiveNetworkSecurityGroups {
  @doc("The Azure resource ID of the network interface")
  networkInterface?: string;

  @doc("The Network Security Groups effective on the network interface")
  networkSecurityGroups?: string[];
}

model AdaptiveNetworkHardeningEnforceRequest {
  @doc("The rules to enforce")
  rules: Rule[];

  @doc("The Azure resource IDs of the effective network security groups that will be updated with the created security rules from the Adaptive Network Hardening rules")
  networkSecurityGroups: string[];
}

@doc("List of all possible traffic between Azure resources")
model AllowedConnectionsList is Azure.Core.Page<AllowedConnectionsResource>;

@doc("The resource whose properties describes the allowed traffic between Azure resources")
model AllowedConnectionsResource {
  ...Resource;
  ...Location;

  @doc("Describes the allowed traffic between Azure resources")
  @visibility("read")
  properties?: AllowedConnectionsResourceProperties;
}

@doc("Describes the allowed traffic between Azure resources")
model AllowedConnectionsResourceProperties {
  @doc("The UTC time on which the allowed connections resource was calculated")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  calculatedDateTime?: utcDateTime;

  @doc("List of connectable resources")
  @visibility("read")
  connectableResources?: ConnectableResource[];
}

@doc("Describes the allowed inbound and outbound traffic of an Azure resource")
model ConnectableResource {
  @doc("The Azure resource id")
  @visibility("read")
  id?: string;

  @doc("The list of Azure resources that the resource has inbound allowed connection from")
  @visibility("read")
  inboundConnectedResources?: ConnectedResource[];

  @doc("The list of Azure resources that the resource has outbound allowed connection to")
  @visibility("read")
  outboundConnectedResources?: ConnectedResource[];
}

@doc("Describes properties of a connected resource")
model ConnectedResource {
  @doc("The Azure resource id of the connected resource")
  @visibility("read")
  connectedResourceId?: string;

  @doc("The allowed tcp ports")
  @visibility("read")
  tcpPorts?: string;

  @doc("The allowed udp ports")
  @visibility("read")
  udpPorts?: string;
}

model TopologyList is Azure.Core.Page<TopologyResource>;

model TopologyResource {
  ...Resource;
  ...Location;

  @visibility("read")
  properties?: TopologyResourceProperties;
}

model TopologyResourceProperties {
  @doc("The UTC time on which the topology was calculated")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  calculatedDateTime?: utcDateTime;

  @doc("Azure resources which are part of this topology resource")
  @visibility("read")
  topologyResources?: TopologySingleResource[];
}

model TopologySingleResource {
  @doc("Azure resource id")
  @visibility("read")
  resourceId?: string;

  @doc("The security severity of the resource")
  @visibility("read")
  severity?: string;

  @doc("Indicates if the resource has security recommendations")
  @visibility("read")
  recommendationsExist?: boolean;

  @doc("Indicates the resource connectivity level to the Internet (InternetFacing, Internal ,etc.)")
  @visibility("read")
  networkZones?: string;

  @doc("Score of the resource based on its security severity")
  @visibility("read")
  topologyScore?: int32;

  @doc("The location of this resource")
  @visibility("read")
  location?: string;

  @doc("Azure resources connected to this resource which are in higher level in the topology view")
  @visibility("read")
  parents?: TopologySingleResourceParent[];

  @doc("Azure resources connected to this resource which are in lower level in the topology view")
  @visibility("read")
  children?: TopologySingleResourceChild[];
}

model TopologySingleResourceParent {
  @doc("Azure resource id which serves as parent resource in topology view")
  @visibility("read")
  resourceId?: string;
}

model TopologySingleResourceChild {
  @doc("Azure resource id which serves as child resource in topology view")
  @visibility("read")
  resourceId?: string;
}

model JitNetworkAccessPolicyProperties {
  @doc("Configurations for Microsoft.Compute/virtualMachines resource type.")
  virtualMachines: JitNetworkAccessPolicyVirtualMachine[];

  requests?: JitNetworkAccessRequest[];

  @doc("Gets the provisioning state of the Just-in-Time policy.")
  @visibility("read")
  provisioningState?: string;
}

model JitNetworkAccessPolicyVirtualMachine {
  @doc("Resource ID of the virtual machine that is linked to this policy")
  id: string;

  @doc("Port configurations for the virtual machine")
  ports: JitNetworkAccessPortRule[];

  @doc("Public IP address of the Azure Firewall that is linked to this policy, if applicable")
  publicIpAddress?: string;
}

model JitNetworkAccessPortRule {
  @maxValue(65535)
  number: int32;

  protocol: Protocol;

  @doc("Mutually exclusive with the \"allowedSourceAddressPrefixes\" parameter. Should be an IP address or CIDR, for example \"192.168.0.3\" or \"192.168.0.0/16\".")
  allowedSourceAddressPrefix?: string;

  @doc("Mutually exclusive with the \"allowedSourceAddressPrefix\" parameter.")
  allowedSourceAddressPrefixes?: string[];

  @doc("Maximum duration requests can be made for. In ISO 8601 duration format. Minimum 5 minutes, maximum 1 day")
  maxRequestAccessDuration: duration;
}

model JitNetworkAccessRequest {
  virtualMachines: JitNetworkAccessRequestVirtualMachine[];

  @doc("The start time of the request in UTC")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTimeUtc: utcDateTime;

  @doc("The identity of the person who made the request")
  requestor: string;

  @doc("The justification for making the initiate request")
  justification?: string;
}

model JitNetworkAccessRequestVirtualMachine {
  @doc("Resource ID of the virtual machine that is linked to this policy")
  id: string;

  @doc("The ports that were opened for the virtual machine")
  ports: JitNetworkAccessRequestPort[];
}

model JitNetworkAccessRequestPort {
  @maxValue(65535)
  number: int32;

  @doc("Mutually exclusive with the \"allowedSourceAddressPrefixes\" parameter. Should be an IP address or CIDR, for example \"192.168.0.3\" or \"192.168.0.0/16\".")
  allowedSourceAddressPrefix?: string;

  @doc("Mutually exclusive with the \"allowedSourceAddressPrefix\" parameter.")
  allowedSourceAddressPrefixes?: string[];

  @doc("The date & time at which the request ends in UTC")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTimeUtc: utcDateTime;

  @doc("The status of the port")
  status: Status;

  @doc("A description of why the `status` has its value")
  statusReason: StatusReason;

  @doc("The port which is mapped to this port's `number` in the Azure Firewall, if applicable")
  mappedPort?: int32;
}

model JitNetworkAccessPolicyInitiateRequest {
  @doc("A list of virtual machines & ports to open access for")
  virtualMachines: JitNetworkAccessPolicyInitiateVirtualMachine[];

  @doc("The justification for making the initiate request")
  justification?: string;
}

model JitNetworkAccessPolicyInitiateVirtualMachine {
  @doc("Resource ID of the virtual machine that is linked to this policy")
  id: string;

  @doc("The ports to open for the resource with the `id`")
  ports: JitNetworkAccessPolicyInitiatePort[];
}

model JitNetworkAccessPolicyInitiatePort {
  @maxValue(65535)
  number: int32;

  @doc("Source of the allowed traffic. If omitted, the request will be for the source IP address of the initiate request.")
  allowedSourceAddressPrefix?: string;

  @doc("The time to close the request in UTC")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTimeUtc: utcDateTime;
}

model DiscoveredSecuritySolutionList
  is Azure.Core.Page<DiscoveredSecuritySolution>;

model DiscoveredSecuritySolution {
  ...Resource;
  ...Location;
  properties: DiscoveredSecuritySolutionProperties;
}

model DiscoveredSecuritySolutionProperties {
  @doc("The security family of the discovered solution")
  securityFamily: SecurityFamily;

  @doc("The security solutions' image offer")
  offer: string;

  @doc("The security solutions' image publisher")
  publisher: string;

  @doc("The security solutions' image sku")
  sku: string;
}

model SecuritySolutionsReferenceDataList {
  value?: SecuritySolutionsReferenceData[];
}

model SecuritySolutionsReferenceData {
  ...Resource;
  ...Location;
  properties: SecuritySolutionsReferenceDataProperties;
}

model SecuritySolutionsReferenceDataProperties {
  @doc("The security family of the security solution")
  securityFamily: SecurityFamily;

  @doc("The security solutions' vendor name")
  alertVendorName: string;

  @doc("The security solutions' package info url")
  packageInfoUrl: string;

  @doc("The security solutions' product name")
  productName: string;

  @doc("The security solutions' publisher")
  publisher: string;

  @doc("The security solutions' publisher display name")
  publisherDisplayName: string;

  @doc("The security solutions' template")
  template: string;
}

model ExternalSecuritySolutionList is Azure.Core.Page<ExternalSecuritySolution>;

@doc("Represents a security solution external to Microsoft Defender for Cloud which sends information to an OMS workspace and whose data is displayed by Microsoft Defender for Cloud.")
@discriminator("kind")
model ExternalSecuritySolution {
  ...Resource;
  ...Location;
}

@doc("Describes properties of a calculated secure score.")
model SecureScoreItemProperties {
  @doc("The initiative’s name")
  @visibility("read")
  displayName?: string;

  @doc("score object")
  @visibility("read")
  score?: ScoreDetails;

  @doc("The relative weight for each subscription. Used when calculating an aggregated secure score for multiple subscriptions.")
  @visibility("read")
  weight?: int32;
}

@doc("Calculation result data")
model ScoreDetails {
  @doc("Maximum score available")
  @visibility("read")
  max?: int32;

  @doc("Current score")
  @visibility("read")
  current?: float32;

  @doc("Ratio of the current score divided by the maximum. Rounded to 4 digits after the decimal point")
  @visibility("read")
  @maxValue(1)
  percentage?: float32;
}

@doc("List of security controls")
model SecureScoreControlList is Azure.Core.Page<SecureScoreControlDetails>;

@doc("Details of the security control, its score, and the health status of the relevant resources.")
model SecureScoreControlDetails extends Resource {
  @doc("Calculation result data in control level")
  properties?: SecureScoreControlScoreDetails;
}

@doc("Calculation result data in control level")
model SecureScoreControlScoreDetails {
  @doc("User friendly display name of the control")
  @visibility("read")
  displayName?: string;

  @doc("Actual score object for the control")
  @visibility("read")
  score?: ScoreDetails;

  @doc("Number of healthy resources in the control")
  @visibility("read")
  healthyResourceCount?: int32;

  @doc("Number of unhealthy resources in the control")
  @visibility("read")
  unhealthyResourceCount?: int32;

  @doc("Number of not applicable resources in the control")
  @visibility("read")
  notApplicableResourceCount?: int32;

  @doc("The relative weight for this specific control in each of your subscriptions. Used when calculating an aggregated score for this control across all of your subscriptions.")
  @visibility("read")
  weight?: int32;

  @doc("Information about the security control.")
  definition?: SecureScoreControlDefinitionItem;
}

@doc("Information about the security control.")
model SecureScoreControlDefinitionItem extends Resource {
  @doc("Security Control Definition Properties.")
  properties?: SecureScoreControlDefinitionItemProperties;
}

@doc("Security Control Definition Properties.")
model SecureScoreControlDefinitionItemProperties {
  @doc("User friendly display name of the control")
  @visibility("read")
  displayName?: string;

  @doc("User friendly description of the control")
  @visibility("read")
  @maxLength(256)
  description?: string;

  @doc("Maximum control score (0..10)")
  @visibility("read")
  @maxValue(10)
  maxScore?: int32;

  @doc("Source object from which the control was created")
  @visibility("read")
  source?: SecureScoreControlDefinitionSource;

  @doc("Array of assessments metadata IDs that are included in this security control")
  @visibility("read")
  assessmentDefinitions?: AzureResourceLink[];
}

@doc("The type of the security control (For example, BuiltIn)")
model SecureScoreControlDefinitionSource {
  @doc("The type of security control (for example, BuiltIn)")
  sourceType?: ControlType;
}

@doc("Describes an Azure resource with kind")
model AzureResourceLink {
  @doc("Azure resource Id")
  @visibility("read")
  id?: string;
}

@doc("List of security controls definition")
model SecureScoreControlDefinitionList
  is Azure.Core.Page<SecureScoreControlDefinitionItem>;

model SecuritySolutionList is Azure.Core.Page<SecuritySolution>;

model SecuritySolution {
  ...Resource;
  ...Location;
  properties?: SecuritySolutionProperties;
}

model SecuritySolutionProperties {
  @doc("The security family of the security solution")
  securityFamily: SecurityFamily;

  @doc("The security family provisioning State")
  provisioningState: ProvisioningState;

  @doc("The security solutions' template")
  template: string;

  @doc("The security solutions' status")
  protectionStatus: string;
}

@doc("Describes properties of a connector setting")
model ConnectorSettingProperties {
  @doc("Settings for hybrid compute management. These settings are relevant only for Arc autoProvision (Hybrid Compute).")
  hybridComputeSettings?: HybridComputeSettingsProperties;

  @doc("Settings for authentication management, these settings are relevant only for the cloud connector.")
  authenticationDetails?: AuthenticationDetailsProperties;
}

@doc("Settings for hybrid compute management")
model HybridComputeSettingsProperties {
  @doc("State of the service principal and its secret")
  @visibility("read")
  hybridComputeProvisioningState?: HybridComputeProvisioningState;

  @doc("Whether or not to automatically install Azure Arc (hybrid compute) agents on machines")
  autoProvision: AutoProvision;

  @doc("The name of the resource group where Arc (Hybrid Compute) connectors are connected.")
  resourceGroupName?: string;

  @doc("The location where the metadata of machines will be stored")
  @visibility("read", "create")
  region?: string;

  @doc("For a non-Azure machine that is not connected directly to the internet, specify a proxy server that the non-Azure machine can use.")
  proxyServer?: ProxyServerProperties;

  @doc("An object to access resources that are secured by an Azure AD tenant.")
  servicePrincipal?: ServicePrincipalProperties;
}

@doc("For a non-Azure machine that is not connected directly to the internet, specify a proxy server that the non-Azure machine can use.")
model ProxyServerProperties {
  @doc("Proxy server IP")
  ip?: string;

  @doc("Proxy server port")
  port?: string;
}

@doc("Details of the service principal.")
model ServicePrincipalProperties {
  @doc("Application ID of service principal.")
  applicationId?: string;

  @doc("A secret string that the application uses to prove its identity, also can be referred to as application password (write only).")
  secret?: string;
}

@doc("Settings for cloud authentication management")
@discriminator("authenticationType")
model AuthenticationDetailsProperties {
  @doc("State of the multi-cloud connector")
  @visibility("read")
  authenticationProvisioningState?: AuthenticationProvisioningState;

  @doc("The permissions detected in the cloud account.")
  @visibility("read")
  grantedPermissions?: PermissionProperty[];
}

@doc("describes security alert properties.")
model AlertProperties {
  @doc("Schema version.")
  @visibility("read")
  version?: string;

  @doc("Unique identifier for the detection logic (all alert instances from the same detection logic will have the same alertType).")
  @visibility("read")
  alertType?: string;

  @doc("Unique identifier for the alert.")
  @visibility("read")
  systemAlertId?: string;

  @doc("The name of Azure Security Center pricing tier which powering this alert. Learn more: https://docs.microsoft.com/en-us/azure/security-center/security-center-pricing")
  @visibility("read")
  productComponentName?: string;

  @doc("The display name of the alert.")
  @visibility("read")
  alertDisplayName?: string;

  @doc("Description of the suspicious activity that was detected.")
  @visibility("read")
  description?: string;

  @doc("The risk level of the threat that was detected. Learn more: https://docs.microsoft.com/en-us/azure/security-center/security-center-alerts-overview#how-are-alerts-classified.")
  @visibility("read")
  severity?: AlertSeverity;

  @doc("The kill chain related intent behind the alert. For list of supported values, and explanations of Azure Security Center's supported kill chain intents.")
  @visibility("read")
  intent?: Intent;

  @doc("The UTC time of the first event or activity included in the alert in ISO8601 format.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTimeUtc?: utcDateTime;

  @doc("The UTC time of the last event or activity included in the alert in ISO8601 format.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTimeUtc?: utcDateTime;

  @doc("The resource identifiers that can be used to direct the alert to the right product exposure group (tenant, workspace, subscription etc.). There can be multiple identifiers of different type per alert.")
  @visibility("read")
  resourceIdentifiers?: AlertResourceIdentifier[];

  @doc("Manual action items to take to remediate the alert.")
  @visibility("read")
  remediationSteps?: string[];

  @doc("The name of the vendor that raises the alert.")
  @visibility("read")
  vendorName?: string;

  @doc("The life cycle status of the alert.")
  @visibility("read")
  status?: AlertStatus;

  @doc("Links related to the alert")
  @visibility("read")
  extendedLinks?: Record<string>[];

  @doc("A direct link to the alert page in Azure Portal.")
  @visibility("read")
  alertUri?: string;

  @doc("The UTC time the alert was generated in ISO8601 format.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timeGeneratedUtc?: utcDateTime;

  @doc("The name of the product which published this alert (Microsoft Sentinel, Microsoft Defender for Identity, Microsoft Defender for Endpoint, Microsoft Defender for Office, Microsoft Defender for Cloud Apps, and so on).")
  @visibility("read")
  productName?: string;

  @doc("The UTC processing end time of the alert in ISO8601 format.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  processingEndTimeUtc?: utcDateTime;

  @doc("A list of entities related to the alert.")
  @visibility("read")
  entities?: AlertEntity[];

  @doc("This field determines whether the alert is an incident (a compound grouping of several alerts) or a single alert.")
  @visibility("read")
  isIncident?: boolean;

  @doc("Key for corelating related alerts. Alerts with the same correlation key considered to be related.")
  @visibility("read")
  correlationKey?: string;

  @doc("Custom properties for the alert.")
  extendedProperties?: Record<string>;

  @doc("The display name of the resource most related to this alert.")
  @visibility("read")
  compromisedEntity?: string;

  @doc("kill chain related techniques behind the alert.")
  @visibility("read")
  techniques?: string[];

  @doc("Kill chain related sub-techniques behind the alert.")
  @visibility("read")
  subTechniques?: string[];

  @doc("Changing set of properties depending on the supportingEvidence type.")
  supportingEvidence?: AlertPropertiesSupportingEvidence;
}

@doc("A resource identifier for an alert which can be used to direct the alert to the right product exposure group (tenant, workspace, subscription etc.).")
@discriminator("type")
model AlertResourceIdentifier {}

@doc("Changing set of properties depending on the entity type.")
model AlertEntity extends Record<Record<unknown>> {
  @doc("Type of entity")
  @visibility("read")
  type?: string;
}

@doc("Changing set of properties depending on the supportingEvidence type.")
model AlertPropertiesSupportingEvidence extends Record<Record<unknown>> {
  @doc("Type of the supportingEvidence")
  @visibility("read")
  type?: string;
}

@doc("Alert Simulator request body.")
model AlertSimulatorRequestBody {
  @doc("Alert Simulator request body data.")
  properties?: AlertSimulatorRequestProperties;
}

@doc("Describes properties of an alert simulation request")
@discriminator("kind")
model AlertSimulatorRequestProperties extends Record<unknown> {}

@doc("Configures how to correlate scan data and logs with resources associated with the subscription.")
model IngestionSettingToken {
  @doc("The token is used for correlating security data and logs with the resources in the subscription.")
  @visibility("read")
  token?: string;
}

@doc("Connection string for ingesting security data and logs")
model ConnectionStrings {
  @doc("Connection strings")
  value: IngestionConnectionString[];
}

@doc("Connection string for ingesting security data and logs")
model IngestionConnectionString {
  @doc("The region where ingested logs and data resides")
  @visibility("read")
  location?: string;

  @doc("Connection string value")
  @visibility("read")
  value?: string;
}

@doc("Software Inventory resource properties")
model SoftwareProperties {
  @doc("Unique identifier for the virtual machine in the service.")
  deviceId?: string;

  @doc("Platform of the operating system running on the device.")
  osPlatform?: string;

  @doc("Name of the software vendor.")
  vendor?: string;

  @doc("Name of the software product.")
  softwareName?: string;

  @doc("Version number of the software product.")
  version?: string;

  @doc("End of support status.")
  endOfSupportStatus?: EndOfSupportStatus;

  @doc("The end of support date in case the product is upcoming end of support.")
  endOfSupportDate?: string;

  @doc("Number of weaknesses.")
  numberOfKnownVulnerabilities?: int32;

  @doc("First time that the software was seen in the device.")
  firstSeenAt?: string;
}

@doc("A set of properties that defines the security connector configuration.")
model SecurityConnectorProperties {
  @doc("The multi cloud resource identifier (account id in case of AWS connector, project number in case of GCP connector).")
  hierarchyIdentifier?: string;

  @doc("The date on which the trial period will end, if applicable. Trial period exists for 30 days after upgrading to payed offerings.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  hierarchyIdentifierTrialEndDate?: utcDateTime;

  @doc("The multi cloud resource's cloud name.")
  environmentName?: CloudName;

  @doc("A collection of offerings for the security connector.")
  offerings?: CloudOffering[];

  @doc("The security connector environment data.")
  environmentData?: EnvironmentData;
}

@doc("The security offering details")
@discriminator("offeringType")
model CloudOffering {
  @doc("The offering description.")
  @visibility("read")
  description?: string;
}

@doc("The security connector environment data.")
@discriminator("environmentType")
model EnvironmentData {}

@doc("Describes properties of an governance rule")
model GovernanceRuleProperties {
  @doc("The tenantId (GUID)")
  @visibility("read")
  tenantId?: string;

  @doc("Display name of the governance rule")
  displayName: string;

  @doc("Description of the governance rule")
  description?: string;

  @doc("Governance rule remediation timeframe - this is the time that will affect on the grace-period duration e.g. 7.00:00:00 - means 7 days")
  @pattern("^[0-9]+\\.[0-9]{2}:[0-9]{2}:[0-9]{2}$")
  remediationTimeframe?: string;

  @doc("Defines whether there is a grace period on the governance rule")
  isGracePeriod?: boolean;

  @doc("The governance rule priority, priority to the lower number. Rules with the same priority on the same scope will not be allowed")
  @maxValue(1000)
  rulePriority: int32;

  @doc("Defines whether the rule is active/inactive")
  isDisabled?: boolean;

  @doc("The rule type of the governance rule, defines the source of the rule e.g. Integrated")
  ruleType: GovernanceRuleType;

  @doc("The governance rule source, what the rule affects, e.g. Assessments")
  sourceResourceType: GovernanceRuleSourceResourceType;

  @doc("Excluded scopes, filter out the descendants of the scope (on management scopes)")
  excludedScopes?: string[];

  @doc("The governance rule conditionSets - see examples")
  conditionSets: Record<unknown>[];

  @doc("Defines whether the rule is management scope rule (master connector as a single scope or management scope)")
  includeMemberScopes?: boolean;

  @doc("The owner source for the governance rule - e.g. Manually by user@contoso.com - see example")
  ownerSource: GovernanceRuleOwnerSource;

  @doc("The email notifications settings for the governance rule, states whether to disable notifications for mangers and owners")
  governanceEmailNotification?: GovernanceRuleEmailNotification;

  @doc("The governance rule metadata")
  metadata?: GovernanceRuleMetadata;
}

@doc("Describe the owner source of governance rule")
model GovernanceRuleOwnerSource {
  @doc("The owner type for the governance rule owner source")
  type?: GovernanceRuleOwnerSourceType;

  @doc("The source value e.g. tag key like owner name or email address")
  value?: string;
}

@doc("The governance email weekly notification configuration")
model GovernanceRuleEmailNotification {
  @doc("Defines whether manager email notifications are disabled")
  disableManagerEmailNotification?: boolean;

  @doc("Defines whether owner email notifications are disabled")
  disableOwnerEmailNotification?: boolean;
}

@doc("The governance rule metadata")
model GovernanceRuleMetadata {
  @doc("Governance rule Created by object id (GUID)")
  @visibility("read")
  createdBy?: string;

  @doc("Governance rule creation date")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdOn?: utcDateTime;

  @doc("Governance rule last updated by object id (GUID)")
  @visibility("read")
  updatedBy?: string;

  @doc("Governance rule last update date")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  updatedOn?: utcDateTime;
}

@doc("Governance rule execution parameters")
model ExecuteGovernanceRuleParams {
  @doc("Describe if governance rule should be override")
  override?: boolean;
}

@doc("Describes properties of an governance assignment")
model GovernanceAssignmentProperties {
  @doc("The Owner for the governance assignment - e.g. user@contoso.com - see example")
  owner?: string;

  @doc("The remediation due-date - after this date Secure Score will be affected (in case of  active grace-period)")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  remediationDueDate: utcDateTime;

  @doc("The ETA (estimated time of arrival) for remediation (optional), see example")
  remediationEta?: RemediationEta;

  @doc("Defines whether there is a grace period on the governance assignment")
  isGracePeriod?: boolean;

  @doc("The email notifications settings for the governance rule, states whether to disable notifications for mangers and owners")
  governanceEmailNotification?: GovernanceEmailNotification;

  @doc("The additional data for the governance assignment - e.g. links to ticket (optional), see example")
  additionalData?: GovernanceAssignmentAdditionalData;
}

@doc("The ETA (estimated time of arrival) for remediation")
model RemediationEta {
  @doc("ETA for remediation.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  eta: utcDateTime;

  @doc("Justification for change of Eta.")
  justification: string;
}

@doc("The governance email weekly notification configuration.")
model GovernanceEmailNotification {
  @doc("Exclude manager from weekly email notification.")
  disableManagerEmailNotification?: boolean;

  @doc("Exclude  owner from weekly email notification.")
  disableOwnerEmailNotification?: boolean;
}

@doc("Describe the additional data of governance assignment - optional")
model GovernanceAssignmentAdditionalData {
  @doc("Ticket number associated with this governance assignment")
  ticketNumber?: int32;

  @doc("Ticket link associated with this governance assignment - for example: https://snow.com")
  ticketLink?: string;

  @doc("The ticket status associated with this governance assignment - for example: Active")
  ticketStatus?: string;
}

@doc("Describes properties of an application")
model ApplicationProperties {
  @doc("display name of the application")
  displayName?: string;

  @doc("description of the application")
  description?: string;

  @doc("The application source, what it affects, e.g. Assessments")
  sourceResourceType: ApplicationSourceResourceType;

  @doc("The application conditionSets - see examples")
  conditionSets: Record<unknown>[];
}

@doc("A vulnerability assessment scan record properties.")
model ScanProperties {
  @doc("The scan trigger type.")
  triggerType?: ScanTriggerType;

  @doc("The scan status.")
  state?: ScanState;

  @doc("The server name.")
  server?: string;

  @doc("The database name.")
  database?: string;

  @doc("The SQL version.")
  sqlVersion?: string;

  @doc("The scan start time (UTC).")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  @doc("Scan results are valid until end time (UTC).")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  @doc("The number of failed rules with high severity.")
  highSeverityFailedRulesCount?: int32;

  @doc("The number of failed rules with medium severity.")
  mediumSeverityFailedRulesCount?: int32;

  @doc("The number of failed rules with low severity.")
  lowSeverityFailedRulesCount?: int32;

  @doc("The number of total passed rules.")
  totalPassedRulesCount?: int32;

  @doc("The number of total failed rules.")
  totalFailedRulesCount?: int32;

  @doc("The number of total rules assessed.")
  totalRulesCount?: int32;

  @doc("Baseline created for this database, and has one or more rules.")
  isBaselineApplied?: boolean;

  @doc("Last scan time.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastScanTime?: utcDateTime;
}

@doc("A vulnerability assessment scan result for a single rule.")
model ScanResult extends Resource {
  @doc("A vulnerability assessment scan result properties for a single rule.")
  properties?: ScanResultProperties;
}

@doc("A vulnerability assessment scan result properties for a single rule.")
model ScanResultProperties {
  @doc("The rule Id.")
  ruleId?: string;

  @doc("The rule result status.")
  status?: RuleStatus;

  @doc("Indicated whether the results specified here are trimmed.")
  isTrimmed?: boolean;

  @doc("The results of the query that was run.")
  queryResults?: string[][];

  @doc("Remediation details.")
  remediation?: Remediation;

  @doc("The rule result adjusted with baseline.")
  baselineAdjustedResult?: BaselineAdjustedResult;

  @doc("vulnerability assessment rule metadata details.")
  ruleMetadata?: VaRule;
}

@doc("Remediation details.")
model Remediation {
  @doc("Remediation description.")
  description?: string;

  @doc("Remediation script.")
  scripts?: string[];

  @doc("Is remediation automated.")
  automated?: boolean;

  @doc("Optional link to remediate in Azure Portal.")
  portalLink?: string;
}

@doc("The rule result adjusted with baseline.")
model BaselineAdjustedResult {
  @doc("Baseline details.")
  baseline?: Baseline;

  @doc("The rule result status.")
  status?: RuleStatus;

  @doc("Results the are not in baseline.")
  resultsNotInBaseline?: string[][];

  @doc("Results the are in baseline.")
  resultsOnlyInBaseline?: string[][];
}

@doc("Baseline details.")
model Baseline {
  @doc("Expected results.")
  expectedResults?: string[][];

  @doc("Baseline update time (UTC).")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  updatedTime?: utcDateTime;
}

@doc("vulnerability assessment rule metadata details.")
model VaRule {
  @doc("The rule Id.")
  ruleId?: string;

  @doc("The rule severity.")
  severity?: RuleSeverity;

  @doc("The rule category.")
  category?: string;

  @doc("The rule type.")
  ruleType?: RuleType;

  @doc("The rule title.")
  title?: string;

  @doc("The rule description.")
  description?: string;

  @doc("The rule rationale.")
  rationale?: string;

  @doc("The rule query details.")
  queryCheck?: QueryCheck;

  @doc("The benchmark references.")
  benchmarkReferences?: BenchmarkReference[];
}

@doc("The rule query details.")
model QueryCheck {
  @doc("The rule query.")
  query?: string;

  @doc("Expected result.")
  expectedResult?: string[][];

  @doc("Column names of expected result.")
  columnNames?: string[];
}

@doc("The benchmark references.")
model BenchmarkReference {
  @doc("The benchmark name.")
  benchmark?: string;

  @doc("The benchmark reference.")
  reference?: string;
}

@doc("A list of vulnerability assessment scan results.")
model ScanResults {
  @doc("List of vulnerability assessment scan results.")
  value?: ScanResult[];
}

@doc("Rule results input.")
model RuleResultsInput {
  @doc("Take results from latest scan.")
  latestScan?: boolean;

  @doc("""
Expected results to be inserted into the baseline.
Leave this field empty it LatestScan == true.
""")
  results?: string[][];
}

@doc("Rule results properties.")
model RuleResultsProperties {
  @doc("Expected results in the baseline.")
  results?: string[][];
}

@doc("Rules results input.")
model RulesResultsInput {
  @doc("Take results from latest scan.")
  latestScan?: boolean;

  @doc("""
Expected results to be inserted into the baseline.
Leave this field empty it LatestScan == true.
""")
  results?: Record<string[][]>;
}

@doc("Outbound connection to an ip that isn't allowed. Allow list consists of ipv4 or ipv6 range in CIDR notation.")
model ConnectionToIpNotAllowed extends AllowlistCustomAlertRule {
  @doc("The type of the custom alert rule.")
  ruleType: "ConnectionToIpNotAllowed";
}

@doc("Inbound connection from an ip that isn't allowed. Allow list consists of ipv4 or ipv6 range in CIDR notation.")
model ConnectionFromIpNotAllowed extends AllowlistCustomAlertRule {
  @doc("The type of the custom alert rule.")
  ruleType: "ConnectionFromIpNotAllowed";
}

@doc("Login by a local user that isn't allowed. Allow list consists of login names to allow.")
model LocalUserNotAllowed extends AllowlistCustomAlertRule {
  @doc("The type of the custom alert rule.")
  ruleType: "LocalUserNotAllowed";
}

@doc("Execution of a process that isn't allowed. Allow list consists of process names to allow.")
model ProcessNotAllowed extends AllowlistCustomAlertRule {
  @doc("The type of the custom alert rule.")
  ruleType: "ProcessNotAllowed";
}

@doc("Number of active connections is not in allowed range.")
model ActiveConnectionsNotInAllowedRange extends TimeWindowCustomAlertRule {
  @doc("The type of the custom alert rule.")
  ruleType: "ActiveConnectionsNotInAllowedRange";
}

@doc("Number of cloud to device messages (AMQP protocol) is not in allowed range.")
model AmqpC2DMessagesNotInAllowedRange extends TimeWindowCustomAlertRule {
  @doc("The type of the custom alert rule.")
  ruleType: "AmqpC2DMessagesNotInAllowedRange";
}

@doc("Number of cloud to device messages (MQTT protocol) is not in allowed range.")
model MqttC2DMessagesNotInAllowedRange extends TimeWindowCustomAlertRule {
  @doc("The type of the custom alert rule.")
  ruleType: "MqttC2DMessagesNotInAllowedRange";
}

@doc("Number of cloud to device messages (HTTP protocol) is not in allowed range.")
model HttpC2DMessagesNotInAllowedRange extends TimeWindowCustomAlertRule {
  @doc("The type of the custom alert rule.")
  ruleType: "HttpC2DMessagesNotInAllowedRange";
}

@doc("Number of rejected cloud to device messages (AMQP protocol) is not in allowed range.")
model AmqpC2DRejectedMessagesNotInAllowedRange
  extends TimeWindowCustomAlertRule {
  @doc("The type of the custom alert rule.")
  ruleType: "AmqpC2DRejectedMessagesNotInAllowedRange";
}

@doc("Number of rejected cloud to device messages (MQTT protocol) is not in allowed range.")
model MqttC2DRejectedMessagesNotInAllowedRange
  extends TimeWindowCustomAlertRule {
  @doc("The type of the custom alert rule.")
  ruleType: "MqttC2DRejectedMessagesNotInAllowedRange";
}

@doc("Number of rejected cloud to device messages (HTTP protocol) is not in allowed range.")
model HttpC2DRejectedMessagesNotInAllowedRange
  extends TimeWindowCustomAlertRule {
  @doc("The type of the custom alert rule.")
  ruleType: "HttpC2DRejectedMessagesNotInAllowedRange";
}

@doc("Number of device to cloud messages (AMQP protocol) is not in allowed range.")
model AmqpD2CMessagesNotInAllowedRange extends TimeWindowCustomAlertRule {
  @doc("The type of the custom alert rule.")
  ruleType: "AmqpD2CMessagesNotInAllowedRange";
}

@doc("Number of device to cloud messages (MQTT protocol) is not in allowed range.")
model MqttD2CMessagesNotInAllowedRange extends TimeWindowCustomAlertRule {
  @doc("The type of the custom alert rule.")
  ruleType: "MqttD2CMessagesNotInAllowedRange";
}

@doc("Number of device to cloud messages (HTTP protocol) is not in allowed range.")
model HttpD2CMessagesNotInAllowedRange extends TimeWindowCustomAlertRule {
  @doc("The type of the custom alert rule.")
  ruleType: "HttpD2CMessagesNotInAllowedRange";
}

@doc("Number of direct method invokes is not in allowed range.")
model DirectMethodInvokesNotInAllowedRange extends TimeWindowCustomAlertRule {
  @doc("The type of the custom alert rule.")
  ruleType: "DirectMethodInvokesNotInAllowedRange";
}

@doc("Number of failed local logins is not in allowed range.")
model FailedLocalLoginsNotInAllowedRange extends TimeWindowCustomAlertRule {
  @doc("The type of the custom alert rule.")
  ruleType: "FailedLocalLoginsNotInAllowedRange";
}

@doc("Number of file uploads is not in allowed range.")
model FileUploadsNotInAllowedRange extends TimeWindowCustomAlertRule {
  @doc("The type of the custom alert rule.")
  ruleType: "FileUploadsNotInAllowedRange";
}

@doc("Number of device queue purges is not in allowed range.")
model QueuePurgesNotInAllowedRange extends TimeWindowCustomAlertRule {
  @doc("The type of the custom alert rule.")
  ruleType: "QueuePurgesNotInAllowedRange";
}

@doc("Number of twin updates is not in allowed range.")
model TwinUpdatesNotInAllowedRange extends TimeWindowCustomAlertRule {
  @doc("The type of the custom alert rule.")
  ruleType: "TwinUpdatesNotInAllowedRange";
}

@doc("Number of unauthorized operations is not in allowed range.")
model UnauthorizedOperationsNotInAllowedRange
  extends TimeWindowCustomAlertRule {
  @doc("The type of the custom alert rule.")
  ruleType: "UnauthorizedOperationsNotInAllowedRange";
}

@doc("Details of the resource that was assessed")
model SqlServerVulnerabilityProperties extends AdditionalData {
  @doc("The resource type the sub assessment refers to in its resource details")
  @visibility("read")
  type?: string;

  @doc("The T-SQL query that runs on your SQL database to perform the particular check")
  @visibility("read")
  query?: string;

  @doc("Sub-assessment resource type")
  assessedResourceType: "SqlServerVulnerability";
}

@doc("Additional context fields for container registry Vulnerability assessment")
model ContainerRegistryVulnerabilityProperties extends AdditionalData {
  @doc("Vulnerability Type. e.g: Vulnerability, Potential Vulnerability, Information Gathered, Vulnerability")
  @visibility("read")
  type?: string;

  @doc("Dictionary from cvss version to cvss details object")
  @visibility("read")
  cvss?: Record<Cvss>;

  @doc("Indicates whether a patch is available or not")
  @visibility("read")
  patchable?: boolean;

  @doc("List of CVEs")
  @visibility("read")
  cve?: CVE[];

  @doc("Published time")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  publishedTime?: utcDateTime;

  @visibility("read")
  vendorReferences?: VendorReference[];

  @doc("Name of the repository which the vulnerable image belongs to")
  @visibility("read")
  repositoryName?: string;

  @doc("Digest of the vulnerable image")
  @visibility("read")
  imageDigest?: string;

  @doc("Sub-assessment resource type")
  assessedResourceType: "ContainerRegistryVulnerability";
}

@doc("CVSS details")
model Cvss {
  @doc("CVSS base")
  @visibility("read")
  base?: float32;
}

@doc("CVE details")
model CVE {
  @doc("CVE title")
  @visibility("read")
  title?: string;

  @doc("Link url")
  @visibility("read")
  link?: string;
}

@doc("Vendor reference")
model VendorReference {
  @doc("Link title")
  @visibility("read")
  title?: string;

  @doc("Link url")
  @visibility("read")
  link?: string;
}

@doc("Additional context fields for server vulnerability assessment")
model ServerVulnerabilityProperties extends AdditionalData {
  @doc("Vulnerability Type. e.g: Vulnerability, Potential Vulnerability, Information Gathered")
  @visibility("read")
  type?: string;

  @doc("Dictionary from cvss version to cvss details object")
  @visibility("read")
  cvss?: Record<Cvss>;

  @doc("Indicates whether a patch is available or not")
  @visibility("read")
  patchable?: boolean;

  @doc("List of CVEs")
  @visibility("read")
  cve?: CVE[];

  @doc("Threat name")
  @visibility("read")
  threat?: string;

  @doc("Published time")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  publishedTime?: utcDateTime;

  @visibility("read")
  vendorReferences?: VendorReference[];

  @doc("Sub-assessment resource type")
  assessedResourceType: "ServerVulnerabilityAssessment";
}

@doc("The logic app action that should be triggered. To learn more about Microsoft Defender for Cloud's Workflow Automation capabilities, visit https://aka.ms/ASCWorkflowAutomationLearnMore")
model AutomationActionLogicApp extends AutomationAction {
  @doc("The triggered Logic App Azure Resource ID. This can also reside on other subscriptions, given that you have permissions to trigger the Logic App")
  logicAppResourceId?: string;

  @doc("The Logic App trigger URI endpoint (it will not be included in any response).")
  uri?: string;

  @doc("The type of the action that will be triggered by the Automation")
  actionType: "LogicApp";
}

@doc("The target Event Hub to which event data will be exported. To learn more about Microsoft Defender for Cloud continuous export capabilities, visit https://aka.ms/ASCExportLearnMore")
model AutomationActionEventHub extends AutomationAction {
  @doc("The target Event Hub Azure Resource ID.")
  eventHubResourceId?: string;

  @doc("The target Event Hub SAS policy name.")
  @visibility("read")
  sasPolicyName?: string;

  @doc("The target Event Hub connection string (it will not be included in any response).")
  connectionString?: string;

  @doc("The type of the action that will be triggered by the Automation")
  actionType: "EventHub";
}

@doc("The Log Analytics Workspace to which event data will be exported. Security alerts data will reside in the 'SecurityAlert' table and the assessments data will reside in the 'SecurityRecommendation' table (under the 'Security'/'SecurityCenterFree' solutions). Note that in order to view the data in the workspace, the Security Center Log Analytics free/standard solution needs to be enabled on that workspace. To learn more about Microsoft Defender for Cloud continuous export capabilities, visit https://aka.ms/ASCExportLearnMore")
model AutomationActionWorkspace extends AutomationAction {
  @doc("The fully qualified Log Analytics Workspace Azure Resource ID.")
  workspaceResourceId?: string;

  @doc("The type of the action that will be triggered by the Automation")
  actionType: "Workspace";
}

@doc("Security assessment metadata")
model SecurityAssessmentMetadata extends Resource {
  @doc("Describes properties of an assessment metadata.")
  properties?: SecurityAssessmentMetadataProperties;
}

@doc("Represents a security solution which sends CEF logs to an OMS workspace")
model CefExternalSecuritySolution extends ExternalSecuritySolution {
  @doc("The external security solution properties for CEF solutions")
  properties?: CefSolutionProperties;

  @doc("The kind of the external solution")
  kind: "CEF";
}

@doc("The external security solution properties for CEF solutions")
model CefSolutionProperties extends ExternalSecuritySolutionProperties {
  hostname?: string;
  agent?: string;
  lastEventReceived?: string;
}

@doc("The solution properties (correspond to the solution kind)")
model ExternalSecuritySolutionProperties extends Record<unknown> {
  deviceVendor?: string;
  deviceType?: string;

  @doc("Represents an OMS workspace to which the solution is connected")
  workspace?: ConnectedWorkspace;
}

@doc("Represents an OMS workspace to which the solution is connected")
model ConnectedWorkspace {
  @doc("Azure resource ID of the connected OMS workspace")
  id?: string;
}

@doc("Represents an ATA security solution which sends logs to an OMS workspace")
model AtaExternalSecuritySolution extends ExternalSecuritySolution {
  @doc("The external security solution properties for ATA solutions")
  properties?: AtaSolutionProperties;

  @doc("The kind of the external solution")
  kind: "ATA";
}

@doc("The external security solution properties for ATA solutions")
model AtaSolutionProperties extends ExternalSecuritySolutionProperties {
  lastEventReceived?: string;
}

@doc("Represents an AAD identity protection solution which sends logs to an OMS workspace.")
model AadExternalSecuritySolution extends ExternalSecuritySolution {
  @doc("The external security solution properties for AAD solutions")
  properties?: AadSolutionProperties;

  @doc("The kind of the external solution")
  kind: "AAD";
}

@doc("The external security solution properties for AAD solutions")
model AadSolutionProperties {
  ...ExternalSecuritySolutionProperties;
  ...AadConnectivityState;
}

@doc("Describes an Azure resource with kind")
model AadConnectivityState {
  @doc("The connectivity state of the external AAD solution ")
  connectivityState?: AadConnectivityStateType;
}

@doc("Calculation result data")
model SecureScoreControlScore {
  @doc("Maximum control score (0..10)")
  @visibility("read")
  @maxValue(10)
  max?: int32;

  @doc("Actual score for the control = (achieved points / total points) * max score. if total points is zeroed, the return number is 0.00")
  @visibility("read")
  @maxValue(10)
  current?: float32;

  @doc("Ratio of the current score divided by the maximum. Rounded to 4 digits after the decimal point")
  @visibility("read")
  @maxValue(1)
  percentage?: float32;
}

@doc("AWS cloud account connector based credentials, the credentials is composed of access key ID and secret key, for more details, refer to <a href=\"https://docs.aws.amazon.com/IAM/latest/UserGuide/id_users_create.html\">Creating an IAM User in Your AWS Account (write only)</a>")
model AwsCredsAuthenticationDetailsProperties
  extends AuthenticationDetailsProperties {
  @doc("The ID of the cloud account")
  @visibility("read")
  accountId?: string;

  @doc("Public key element of the AWS credential object (write only)")
  awsAccessKeyId: string;

  @doc("Secret key element of the AWS credential object (write only)")
  awsSecretAccessKey: string;

  @doc("Connect to your cloud account, for AWS use either account credentials or role-based authentication. For GCP use account organization credentials.")
  authenticationType: "awsCreds";
}

@doc("AWS cloud account connector based assume role, the role enables delegating access to your AWS resources. The role is composed of role Amazon Resource Name (ARN) and external ID. For more details, refer to <a href=\"https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_create_for-user.html\">Creating a Role to Delegate Permissions to an IAM User (write only)</a>")
model AwAssumeRoleAuthenticationDetailsProperties
  extends AuthenticationDetailsProperties {
  @doc("The ID of the cloud account")
  @visibility("read")
  accountId?: string;

  @doc("Assumed role ID is an identifier that you can use to create temporary security credentials.")
  awsAssumeRoleArn: string;

  @doc("A unique identifier that is required when you assume a role in another account.")
  awsExternalId: string;

  @doc("Connect to your cloud account, for AWS use either account credentials or role-based authentication. For GCP use account organization credentials.")
  authenticationType: "awsAssumeRole";
}

@doc("GCP cloud account connector based service to service credentials, the credentials are composed of the organization ID and a JSON API key (write only)")
model GcpCredentialsDetailsProperties extends AuthenticationDetailsProperties {
  @doc("The organization ID of the GCP cloud account")
  organizationId: string;

  @doc("Type field of the API key (write only)")
  type: string;

  @doc("Project ID field of the API key (write only)")
  projectId: string;

  @doc("Private key ID field of the API key (write only)")
  privateKeyId: string;

  @doc("Private key field of the API key (write only)")
  privateKey: string;

  @doc("Client email field of the API key (write only)")
  clientEmail: string;

  @doc("Client ID field of the API key (write only)")
  clientId: string;

  @doc("Auth URI field of the API key (write only)")
  authUri: string;

  @doc("Token URI field of the API key (write only)")
  tokenUri: string;

  @doc("Auth provider x509 certificate URL field of the API key (write only)")
  authProviderX509CertUrl: string;

  @doc("Client x509 certificate URL field of the API key (write only)")
  clientX509CertUrl: string;

  @doc("Connect to your cloud account, for AWS use either account credentials or role-based authentication. For GCP use account organization credentials.")
  authenticationType: "gcpCredentials";
}

@doc("Azure resource identifier.")
model AzureResourceIdentifier extends AlertResourceIdentifier {
  @doc("ARM resource identifier for the cloud resource being alerted on")
  @visibility("read")
  azureResourceId?: string;

  @doc("There can be multiple identifiers of different type per alert, this field specify the identifier type.")
  type: "AzureResource";
}

@doc("Represents a Log Analytics workspace scope identifier.")
model LogAnalyticsIdentifier extends AlertResourceIdentifier {
  @doc("The LogAnalytics workspace id that stores this alert.")
  @visibility("read")
  workspaceId?: string;

  @doc("The azure subscription id for the LogAnalytics workspace storing this alert.")
  @visibility("read")
  @pattern("^[0-9A-Fa-f]{8}-([0-9A-Fa-f]{4}-){3}[0-9A-Fa-f]{12}$")
  workspaceSubscriptionId?: string;

  @doc("The azure resource group for the LogAnalytics workspace storing this alert")
  @visibility("read")
  workspaceResourceGroup?: string;

  @doc("(optional) The LogAnalytics agent id reporting the event that this alert is based on.")
  @visibility("read")
  agentId?: string;

  @doc("There can be multiple identifiers of different type per alert, this field specify the identifier type.")
  type: "LogAnalytics";
}

@doc("Simulate alerts according to this bundles.")
model AlertSimulatorBundlesRequestProperties
  extends AlertSimulatorRequestProperties {
  @doc("Bundles list.")
  bundles?: BundleType[];

  @doc("The kind of alert simulation.")
  kind: "Bundles";
}

@doc("Represents a data export setting")
model DataExportSettings extends Setting {
  @doc("Data export setting data")
  properties?: DataExportSettingProperties;

  @doc("the kind of the settings string")
  kind: "DataExportSettings";
}

@doc("The data export setting properties")
model DataExportSettingProperties {
  @doc("Is the data export setting enabled")
  enabled: boolean;
}

@doc("Represents an alert sync setting")
model AlertSyncSettings extends Setting {
  @doc("Alert sync setting data")
  properties?: AlertSyncSettingProperties;

  @doc("the kind of the settings string")
  kind: "AlertSyncSettings";
}

@doc("The alert sync setting properties")
model AlertSyncSettingProperties {
  @doc("Is the alert sync setting enabled")
  enabled: boolean;
}

@doc("The aws connector environment data")
model AwsEnvironmentData extends EnvironmentData {
  @doc("The AWS account's organizational data")
  organizationalData?: AwsOrganizationalData;

  @doc("The type of the environment data.")
  environmentType: "AwsAccount";
}

@doc("The awsOrganization data ")
@discriminator("organizationMembershipType")
model AwsOrganizationalData {}

@doc("The awsOrganization data for the master account")
model AwsOrganizationalDataMaster extends AwsOrganizationalData {
  @doc("If the multi cloud account is of membership type organization, this will be the name of the onboarding stackset")
  stacksetName?: string;

  @doc("If the multi cloud account is of membership type organization, list of accounts excluded from offering")
  excludedAccountIds?: string[];

  @doc("The multi cloud account's membership type in the organization")
  organizationMembershipType: "Organization";
}

@doc("The awsOrganization data for the member account")
model AwsOrganizationalDataMember extends AwsOrganizationalData {
  @doc("If the multi cloud account is not of membership type organization, this will be the ID of the account's parent")
  parentHierarchyId?: string;

  @doc("The multi cloud account's membership type in the organization")
  organizationMembershipType: "Member";
}

@doc("The GCP project connector environment data")
model GcpProjectEnvironmentData extends EnvironmentData {
  @doc("The Gcp project's organizational data")
  organizationalData?: GcpOrganizationalData;

  @doc("The Gcp project's details")
  projectDetails?: GcpProjectDetails;

  @doc("The type of the environment data.")
  environmentType: "GcpProject";
}

@doc("The gcpOrganization data")
@discriminator("organizationMembershipType")
model GcpOrganizationalData {}

@doc("The details about the project represented by the security connector")
model GcpProjectDetails {
  @doc("The unique GCP Project number")
  projectNumber?: string;

  @doc("The GCP Project id")
  projectId?: string;

  @doc("The GCP workload identity federation pool id")
  @visibility("read")
  workloadIdentityPoolId?: string;
}

@doc("The gcpOrganization data for the parent account")
model GcpOrganizationalDataOrganization extends GcpOrganizationalData {
  @doc("If the multi cloud account is of membership type organization, list of accounts excluded from offering")
  excludedProjectNumbers?: string[];

  @doc("The service account email address which represents the organization level permissions container.")
  serviceAccountEmailAddress?: string;

  @doc("The GCP workload identity provider id which represents the permissions required to auto provision security connectors")
  workloadIdentityProviderId?: string;

  @doc("The multi cloud account's membership type in the organization")
  organizationMembershipType: "Organization";
}

@doc("The gcpOrganization data for the member account")
model GcpOrganizationalDataMember extends GcpOrganizationalData {
  @doc("If the multi cloud account is not of membership type organization, this will be the ID of the project's parent")
  parentHierarchyId?: string;

  @doc("The GCP management project number from organizational onboarding")
  managementProjectNumber?: string;

  @doc("The multi cloud account's membership type in the organization")
  organizationMembershipType: "Member";
}

@doc("The github scope connector's environment data")
model GithubScopeEnvironmentData extends EnvironmentData {
  @doc("The type of the environment data.")
  environmentType: "GithubScope";
}

@doc("The AzureDevOps scope connector's environment data")
model AzureDevOpsScopeEnvironmentData extends EnvironmentData {
  @doc("The type of the environment data.")
  environmentType: "AzureDevOpsScope";
}

@doc("The CSPM monitoring for AWS offering")
model CspmMonitorAwsOffering extends CloudOffering {
  @doc("The native cloud connection configuration")
  nativeCloudConnection?: CspmMonitorAwsOfferingNativeCloudConnection;

  @doc("The type of the security offering.")
  offeringType: "CspmMonitorAws";
}

@doc("The native cloud connection configuration")
model CspmMonitorAwsOfferingNativeCloudConnection {
  @doc("The cloud role ARN in AWS for this feature")
  cloudRoleArn?: string;
}

@doc("The Defender for Containers AWS offering")
model DefenderForContainersAwsOffering extends CloudOffering {
  @doc("The kubernetes service connection configuration")
  kubernetesService?: DefenderForContainersAwsOfferingKubernetesService;

  @doc("The kubernetes to scuba connection configuration")
  kubernetesScubaReader?: DefenderForContainersAwsOfferingKubernetesScubaReader;

  @doc("The cloudwatch to kinesis connection configuration")
  cloudWatchToKinesis?: DefenderForContainersAwsOfferingCloudWatchToKinesis;

  @doc("The kinesis to s3 connection configuration")
  kinesisToS3?: DefenderForContainersAwsOfferingKinesisToS3;

  @doc("The container vulnerability assessment configuration")
  containerVulnerabilityAssessment?: DefenderForContainersAwsOfferingContainerVulnerabilityAssessment;

  @doc("The container vulnerability assessment task configuration")
  containerVulnerabilityAssessmentTask?: DefenderForContainersAwsOfferingContainerVulnerabilityAssessmentTask;

  @doc("Enable container vulnerability assessment feature")
  enableContainerVulnerabilityAssessment?: boolean;

  @doc("Is audit logs pipeline auto provisioning enabled")
  autoProvisioning?: boolean;

  @doc("The retention time in days of kube audit logs set on the CloudWatch log group")
  kubeAuditRetentionTime?: int32;

  @doc("The externalId used by the data reader to prevent the confused deputy attack")
  scubaExternalId?: string;

  @doc("The type of the security offering.")
  offeringType: "DefenderForContainersAws";
}

@doc("The kubernetes service connection configuration")
model DefenderForContainersAwsOfferingKubernetesService {
  @doc("The cloud role ARN in AWS for this feature used for provisioning resources")
  cloudRoleArn?: string;
}

@doc("The kubernetes to scuba connection configuration")
model DefenderForContainersAwsOfferingKubernetesScubaReader {
  @doc("The cloud role ARN in AWS for this feature used for reading data")
  cloudRoleArn?: string;
}

@doc("The cloudwatch to kinesis connection configuration")
model DefenderForContainersAwsOfferingCloudWatchToKinesis {
  @doc("The cloud role ARN in AWS used by CloudWatch to transfer data into Kinesis")
  cloudRoleArn?: string;
}

@doc("The kinesis to s3 connection configuration")
model DefenderForContainersAwsOfferingKinesisToS3 {
  @doc("The cloud role ARN in AWS used by Kinesis to transfer data into S3")
  cloudRoleArn?: string;
}

@doc("The container vulnerability assessment configuration")
model DefenderForContainersAwsOfferingContainerVulnerabilityAssessment {
  @doc("The cloud role ARN in AWS for this feature")
  cloudRoleArn?: string;
}

@doc("The container vulnerability assessment task configuration")
model DefenderForContainersAwsOfferingContainerVulnerabilityAssessmentTask {
  @doc("The cloud role ARN in AWS for this feature")
  cloudRoleArn?: string;
}

@doc("The Defender for Servers AWS offering")
model DefenderForServersAwsOffering extends CloudOffering {
  @doc("The Defender for servers connection configuration")
  defenderForServers?: DefenderForServersAwsOfferingDefenderForServers;

  @doc("The ARC autoprovisioning configuration")
  arcAutoProvisioning?: DefenderForServersAwsOfferingArcAutoProvisioning;

  @doc("The Vulnerability Assessment autoprovisioning configuration")
  vaAutoProvisioning?: DefenderForServersAwsOfferingVaAutoProvisioning;

  @doc("The Microsoft Defender for Endpoint autoprovisioning configuration")
  mdeAutoProvisioning?: DefenderForServersAwsOfferingMdeAutoProvisioning;

  @doc("configuration for the servers offering subPlan")
  subPlan?: DefenderForServersAwsOfferingSubPlan;

  @doc("The Microsoft Defender for Server VM scanning configuration")
  vmScanners?: DefenderForServersAwsOfferingVmScanners;

  @doc("The type of the security offering.")
  offeringType: "DefenderForServersAws";
}

@doc("The Defender for servers connection configuration")
model DefenderForServersAwsOfferingDefenderForServers {
  @doc("The cloud role ARN in AWS for this feature")
  cloudRoleArn?: string;
}

@doc("The ARC autoprovisioning configuration")
model DefenderForServersAwsOfferingArcAutoProvisioning {
  @doc("Is arc auto provisioning enabled")
  enabled?: boolean;

  @doc("The cloud role ARN in AWS for this feature")
  cloudRoleArn?: string;
}

@doc("The Vulnerability Assessment autoprovisioning configuration")
model DefenderForServersAwsOfferingVaAutoProvisioning {
  @doc("Is Vulnerability Assessment auto provisioning enabled")
  enabled?: boolean;

  @doc("configuration for Vulnerability Assessment autoprovisioning")
  configuration?: DefenderForServersAwsOfferingVaAutoProvisioningConfiguration;
}

@doc("configuration for Vulnerability Assessment autoprovisioning")
model DefenderForServersAwsOfferingVaAutoProvisioningConfiguration {
  @doc("The Vulnerability Assessment solution to be provisioned. Can be either 'TVM' or 'Qualys'")
  type?: VulnerabilityAssessmentAutoProvisioningType;
}

@doc("The Microsoft Defender for Endpoint autoprovisioning configuration")
model DefenderForServersAwsOfferingMdeAutoProvisioning {
  @doc("Is Microsoft Defender for Endpoint auto provisioning enabled")
  enabled?: boolean;

  @doc("configuration for Microsoft Defender for Endpoint autoprovisioning")
  configuration?: Record<unknown>;
}

@doc("configuration for the servers offering subPlan")
model DefenderForServersAwsOfferingSubPlan {
  @doc("The available sub plans")
  type?: AvailableSubPlanType;
}

@doc("The Microsoft Defender for Server VM scanning configuration")
model DefenderForServersAwsOfferingVmScanners {
  @doc("Is Microsoft Defender for Server VM scanning enabled")
  enabled?: boolean;

  @doc("configuration for Microsoft Defender for Server VM scanning")
  configuration?: DefenderForServersAwsOfferingVmScannersConfiguration;
}

@doc("configuration for Microsoft Defender for Server VM scanning")
model DefenderForServersAwsOfferingVmScannersConfiguration {
  @doc("The cloud role ARN in AWS for this feature")
  cloudRoleArn?: string;

  @doc("The scanning mode for the vm scan.")
  scanningMode?: ScanningMode;

  @doc("VM tags that indicates that VM should not be scanned")
  exclusionTags?: Record<string>;
}

@doc("The Defender for Databases AWS offering")
model DefenderForDatabasesAwsOffering extends CloudOffering {
  @doc("The ARC autoprovisioning configuration")
  arcAutoProvisioning?: DefenderFoDatabasesAwsOfferingArcAutoProvisioning;

  @doc("The RDS configuration")
  rds?: DefenderFoDatabasesAwsOfferingRds;

  @doc("The type of the security offering.")
  offeringType: "DefenderForDatabasesAws";
}

@doc("The ARC autoprovisioning configuration")
model DefenderFoDatabasesAwsOfferingArcAutoProvisioning {
  @doc("Is arc auto provisioning enabled")
  enabled?: boolean;

  @doc("The cloud role ARN in AWS for this feature")
  cloudRoleArn?: string;
}

@doc("The RDS configuration")
model DefenderFoDatabasesAwsOfferingRds {
  @doc("Is RDS protection enabled")
  enabled?: boolean;

  @doc("The cloud role ARN in AWS for this feature")
  cloudRoleArn?: string;
}

@doc("The information protection for AWS offering")
model InformationProtectionAwsOffering extends CloudOffering {
  @doc("The native cloud connection configuration")
  informationProtection?: InformationProtectionAwsOfferingInformationProtection;

  @doc("The type of the security offering.")
  offeringType: "InformationProtectionAws";
}

@doc("The native cloud connection configuration")
model InformationProtectionAwsOfferingInformationProtection {
  @doc("The cloud role ARN in AWS for this feature")
  cloudRoleArn?: string;
}

@doc("The CSPM monitoring for GCP offering")
model CspmMonitorGcpOffering extends CloudOffering {
  @doc("The native cloud connection configuration")
  nativeCloudConnection?: CspmMonitorGcpOfferingNativeCloudConnection;

  @doc("The type of the security offering.")
  offeringType: "CspmMonitorGcp";
}

@doc("The native cloud connection configuration")
model CspmMonitorGcpOfferingNativeCloudConnection {
  @doc("The GCP workload identity provider id for the offering")
  workloadIdentityProviderId?: string;

  @doc("The service account email address in GCP for this offering")
  serviceAccountEmailAddress?: string;
}

@doc("The Defender for Servers GCP offering configurations")
model DefenderForServersGcpOffering extends CloudOffering {
  @doc("The Defender for servers connection configuration")
  defenderForServers?: DefenderForServersGcpOfferingDefenderForServers;

  @doc("The ARC autoprovisioning configuration")
  arcAutoProvisioning?: DefenderForServersGcpOfferingArcAutoProvisioning;

  @doc("The Vulnerability Assessment autoprovisioning configuration")
  vaAutoProvisioning?: DefenderForServersGcpOfferingVaAutoProvisioning;

  @doc("The Microsoft Defender for Endpoint autoprovisioning configuration")
  mdeAutoProvisioning?: DefenderForServersGcpOfferingMdeAutoProvisioning;

  @doc("configuration for the servers offering subPlan")
  subPlan?: DefenderForServersGcpOfferingSubPlan;

  @doc("The type of the security offering.")
  offeringType: "DefenderForServersGcp";
}

@doc("The Defender for servers connection configuration")
model DefenderForServersGcpOfferingDefenderForServers {
  @doc("The workload identity provider id in GCP for this feature")
  workloadIdentityProviderId?: string;

  @doc("The service account email address in GCP for this feature")
  serviceAccountEmailAddress?: string;
}

@doc("The ARC autoprovisioning configuration")
model DefenderForServersGcpOfferingArcAutoProvisioning {
  @doc("Is arc auto provisioning enabled")
  enabled?: boolean;
}

@doc("The Vulnerability Assessment autoprovisioning configuration")
model DefenderForServersGcpOfferingVaAutoProvisioning {
  @doc("Is Vulnerability Assessment auto provisioning enabled")
  enabled?: boolean;

  @doc("configuration for Vulnerability Assessment autoprovisioning")
  configuration?: DefenderForServersGcpOfferingVaAutoProvisioningConfiguration;
}

@doc("configuration for Vulnerability Assessment autoprovisioning")
model DefenderForServersGcpOfferingVaAutoProvisioningConfiguration {
  @doc("The Vulnerability Assessment solution to be provisioned. Can be either 'TVM' or 'Qualys'")
  type?: VulnerabilityAssessmentAutoProvisioningType;
}

@doc("The Microsoft Defender for Endpoint autoprovisioning configuration")
model DefenderForServersGcpOfferingMdeAutoProvisioning {
  @doc("Is Microsoft Defender for Endpoint auto provisioning enabled")
  enabled?: boolean;

  @doc("configuration for Microsoft Defender for Endpoint autoprovisioning")
  configuration?: Record<unknown>;
}

@doc("configuration for the servers offering subPlan")
model DefenderForServersGcpOfferingSubPlan {
  @doc("The available sub plans")
  type?: AvailableSubPlanType;
}

@doc("The Defender for Databases GCP offering configurations")
model DefenderForDatabasesGcpOffering extends CloudOffering {
  @doc("The ARC autoprovisioning configuration")
  arcAutoProvisioning?: DefenderForDatabasesGcpOfferingArcAutoProvisioning;

  @doc("The native cloud connection configuration")
  defenderForDatabasesArcAutoProvisioning?: DefenderForDatabasesGcpOfferingDefenderForDatabasesArcAutoProvisioning;

  @doc("The type of the security offering.")
  offeringType: "DefenderForDatabasesGcp";
}

@doc("The ARC autoprovisioning configuration")
model DefenderForDatabasesGcpOfferingArcAutoProvisioning {
  @doc("Is arc auto provisioning enabled")
  enabled?: boolean;
}

@doc("The native cloud connection configuration")
model DefenderForDatabasesGcpOfferingDefenderForDatabasesArcAutoProvisioning {
  @doc("The service account email address in GCP for this offering")
  serviceAccountEmailAddress?: string;

  @doc("The GCP workload identity provider id for this offering")
  workloadIdentityProviderId?: string;
}

@doc("The containers GCP offering")
model DefenderForContainersGcpOffering extends CloudOffering {
  @doc("The native cloud connection configuration")
  nativeCloudConnection?: DefenderForContainersGcpOfferingNativeCloudConnection;

  @doc("The native cloud connection configuration")
  dataPipelineNativeCloudConnection?: DefenderForContainersGcpOfferingDataPipelineNativeCloudConnection;

  @doc("Is audit logs data collection enabled")
  auditLogsAutoProvisioningFlag?: boolean;

  @doc("Is Microsoft Defender for Cloud Kubernetes agent auto provisioning enabled")
  defenderAgentAutoProvisioningFlag?: boolean;

  @doc("Is Policy Kubernetes agent auto provisioning enabled")
  policyAgentAutoProvisioningFlag?: boolean;

  @doc("The type of the security offering.")
  offeringType: "DefenderForContainersGcp";
}

@doc("The native cloud connection configuration")
model DefenderForContainersGcpOfferingNativeCloudConnection {
  @doc("The service account email address in GCP for this offering")
  serviceAccountEmailAddress?: string;

  @doc("The GCP workload identity provider id for this offering")
  workloadIdentityProviderId?: string;
}

@doc("The native cloud connection configuration")
model DefenderForContainersGcpOfferingDataPipelineNativeCloudConnection {
  @doc("The data collection service account email address in GCP for this offering")
  serviceAccountEmailAddress?: string;

  @doc("The data collection GCP workload identity provider id for this offering")
  workloadIdentityProviderId?: string;
}

@doc("The CSPM monitoring for github offering")
model CspmMonitorGithubOffering extends CloudOffering {
  @doc("The type of the security offering.")
  offeringType: "CspmMonitorGithub";
}

@doc("The CSPM monitoring for AzureDevOps offering")
model CspmMonitorAzureDevOpsOffering extends CloudOffering {
  @doc("The type of the security offering.")
  offeringType: "CspmMonitorAzureDevOps";
}

@doc("The CSPM P1 for Aws offering")
model DefenderCspmAwsOffering extends CloudOffering {
  @doc("The Microsoft Defender for Server VM scanning configuration")
  vmScanners?: DefenderCspmAwsOfferingVmScanners;

  @doc("The type of the security offering.")
  offeringType: "DefenderCspmAws";
}

@doc("The Microsoft Defender for Server VM scanning configuration")
model DefenderCspmAwsOfferingVmScanners {
  @doc("Is Microsoft Defender for Server VM scanning enabled")
  enabled?: boolean;

  @doc("configuration for Microsoft Defender for Server VM scanning")
  configuration?: DefenderCspmAwsOfferingVmScannersConfiguration;
}

@doc("configuration for Microsoft Defender for Server VM scanning")
model DefenderCspmAwsOfferingVmScannersConfiguration {
  @doc("The cloud role ARN in AWS for this feature")
  cloudRoleArn?: string;

  @doc("The scanning mode for the vm scan.")
  scanningMode?: ScanningMode;

  @doc("VM tags that indicates that VM should not be scanned")
  exclusionTags?: Record<string>;
}

@doc("The CSPM P1 for GCP offering")
model DefenderCspmGcpOffering extends CloudOffering {
  @doc("The type of the security offering.")
  offeringType: "DefenderCspmGcp";
}

@doc("The Defender for DevOps for Github offering")
model DefenderForDevOpsGithubOffering extends CloudOffering {
  @doc("The type of the security offering.")
  offeringType: "DefenderForDevOpsGithub";
}

@doc("The Defender for DevOps for Azure DevOps offering")
model DefenderForDevOpsAzureDevOpsOffering extends CloudOffering {
  @doc("The type of the security offering.")
  offeringType: "DefenderForDevOpsAzureDevOps";
}

@doc("Governance rule's condition")
model Condition {
  @doc("The governance rule Condition's Property, e.g. Severity or AssessmentKey, see examples")
  property?: string;

  @doc("The governance rule Condition's Value like severity Low, High or assessments keys, see examples")
  value?: string;

  @doc("The governance rule Condition's Operator, for example Equals for severity or In for list of assessments, see examples")
  operator?: GovernanceRuleConditionOperator;
}

@doc("Long run operation status of governance rule over a given scope")
model OperationResult {
  @doc("The status of the long run operation result of governance rule")
  @visibility("read")
  status?: OperationResultStatus;
}

@doc("Application's condition")
model ApplicationCondition {
  @doc("The application Condition's Property, e.g. ID, see examples")
  property?: string;

  @doc("The application Condition's Value like IDs that contain some string, see examples")
  value?: string;

  @doc("The application Condition's Operator, for example Contains for id or In for list of possible IDs, see examples")
  operator?: ApplicationConditionOperator;
}

@doc("Details of the Azure resource that was assessed")
model AzureResourceDetails extends ResourceDetails {
  @doc("Azure resource Id of the assessed resource")
  @visibility("read")
  id?: string;

  @doc("The platform where the assessed resource resides")
  source: "Azure";
}

@doc("Details of the On Premise resource that was assessed")
@discriminator("source")
model OnPremiseResourceDetails extends ResourceDetails {
  @doc("Azure resource Id of the workspace the machine is attached to")
  workspaceId: string;

  @doc("The unique Id of the machine")
  vmuuid: string;

  @doc("The oms agent Id installed on the machine")
  sourceComputerId: string;

  @doc("The name of the machine")
  machineName: string;
}

@doc("Details of the On Premise Sql resource that was assessed")
model OnPremiseSqlResourceDetails extends OnPremiseResourceDetails {
  @doc("The Sql server name installed on the machine")
  serverName: string;

  @doc("The Sql database name installed on the machine")
  databaseName: string;

  @doc("The platform where the assessed resource resides")
  source: "OnPremiseSql";
}
