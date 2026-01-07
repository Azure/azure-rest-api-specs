import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";


using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.Core;
using Azure.ResourceManager.Foundations;


namespace Microsoft.SecurityInsights;


/**
* The kind of the alert rule
*/
    union AlertRuleKind {
        string,

        /**
* Scheduled
*/"Scheduled": "Scheduled", /**
* MicrosoftSecurityIncidentCreation
*/"MicrosoftSecurityIncidentCreation": "MicrosoftSecurityIncidentCreation", /**
* Fusion
*/"Fusion": "Fusion", /**
* MLBehaviorAnalytics
*/"MLBehaviorAnalytics": "MLBehaviorAnalytics", /**
* ThreatIntelligence
*/"ThreatIntelligence": "ThreatIntelligence", /**
* NRT
*/"NRT": "NRT"
    }

/**
* The type of identity that created the resource.
*/
    union CreatedByType {
        string,

        /**
* User
*/"User": "User", /**
* Application
*/"Application": "Application", /**
* ManagedIdentity
*/"ManagedIdentity": "ManagedIdentity", /**
* Key
*/"Key": "Key"
    }

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"

    union TriggersOn {
        string,

        /**
* Trigger on Incidents
*/"Incidents": "Incidents", /**
* Trigger on Alerts
*/"Alerts": "Alerts"
    }

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"

    union TriggersWhen {
        string,

        /**
* Trigger on created objects
*/"Created": "Created", /**
* Trigger on updated objects
*/"Updated": "Updated"
    }

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"

    union ConditionType {
        string,

        /**
* Evaluate an object property value
*/"Property": "Property", /**
* Evaluate an object array property value
*/"PropertyArray": "PropertyArray", /**
* Evaluate an object property changed value
*/"PropertyChanged": "PropertyChanged", /**
* Evaluate an object array property changed value
*/"PropertyArrayChanged": "PropertyArrayChanged", /**
* Apply a boolean operator (e.g AND, OR) to conditions
*/"Boolean": "Boolean"
    }

/**
* The type of the automation rule action.
*/
    union ActionType {
        string,

        /**
* Modify an object's properties
*/"ModifyProperties": "ModifyProperties", /**
* Run a playbook on an object
*/"RunPlaybook": "RunPlaybook", /**
* Add a task to an incident object
*/"AddIncidentTask": "AddIncidentTask"
    }

/**
* The kind of the billing statistic
*/
    union BillingStatisticKind {
        string,

        /**
* SapSolutionUsage
*/"SapSolutionUsage": "SapSolutionUsage"
    }

/**
* The severity of the incident
*/
    union IncidentSeverity {
        string,

        /**
* High severity
*/"High": "High", /**
* Medium severity
*/"Medium": "Medium", /**
* Low severity
*/"Low": "Low", /**
* Informational severity
*/"Informational": "Informational"
    }

/**
* The severity for alerts created by this alert rule.
*/
    union AttackTactic {
        string,

        /**
* Reconnaissance
*/"Reconnaissance": "Reconnaissance", /**
* ResourceDevelopment
*/"ResourceDevelopment": "ResourceDevelopment", /**
* InitialAccess
*/"InitialAccess": "InitialAccess", /**
* Execution
*/"Execution": "Execution", /**
* Persistence
*/"Persistence": "Persistence", /**
* PrivilegeEscalation
*/"PrivilegeEscalation": "PrivilegeEscalation", /**
* DefenseEvasion
*/"DefenseEvasion": "DefenseEvasion", /**
* CredentialAccess
*/"CredentialAccess": "CredentialAccess", /**
* Discovery
*/"Discovery": "Discovery", /**
* LateralMovement
*/"LateralMovement": "LateralMovement", /**
* Collection
*/"Collection": "Collection", /**
* Exfiltration
*/"Exfiltration": "Exfiltration", /**
* CommandAndControl
*/"CommandAndControl": "CommandAndControl", /**
* Impact
*/"Impact": "Impact", /**
* PreAttack
*/"PreAttack": "PreAttack", /**
* ImpairProcessControl
*/"ImpairProcessControl": "ImpairProcessControl", /**
* InhibitResponseFunction
*/"InhibitResponseFunction": "InhibitResponseFunction"
    }

/**
* The kind of the entity
*/
    union EntityKindEnum {
        string,

        /**
* Entity represents account in the system.
*/"Account": "Account", /**
* Entity represents host in the system.
*/"Host": "Host", /**
* Entity represents file in the system.
*/"File": "File", /**
* Entity represents azure resource in the system.
*/"AzureResource": "AzureResource", /**
* Entity represents cloud application in the system.
*/"CloudApplication": "CloudApplication", /**
* Entity represents dns resolution in the system.
*/"DnsResolution": "DnsResolution", /**
* Entity represents file hash in the system.
*/"FileHash": "FileHash", /**
* Entity represents ip in the system.
*/"Ip": "Ip", /**
* Entity represents malware in the system.
*/"Malware": "Malware", /**
* Entity represents process in the system.
*/"Process": "Process", /**
* Entity represents registry key in the system.
*/"RegistryKey": "RegistryKey", /**
* Entity represents registry value in the system.
*/"RegistryValue": "RegistryValue", /**
* Entity represents security group in the system.
*/"SecurityGroup": "SecurityGroup", /**
* Entity represents url in the system.
*/"Url": "Url", /**
* Entity represents IoT device in the system.
*/"IoTDevice": "IoTDevice", /**
* Entity represents security alert in the system.
*/"SecurityAlert": "SecurityAlert", /**
* Entity represents bookmark in the system.
*/"Bookmark": "Bookmark", /**
* Entity represents mail cluster in the system.
*/"MailCluster": "MailCluster", /**
* Entity represents mail message in the system.
*/"MailMessage": "MailMessage", /**
* Entity represents mailbox in the system.
*/"Mailbox": "Mailbox", /**
* Entity represents submission mail in the system.
*/"SubmissionMail": "SubmissionMail", /**
* Entity represents network interface in the system.
*/"Nic": "Nic"
    }

/**
* Type of the agent
*/
    union AgentType {
        string,

        /**
* SAP
*/"SAP": "SAP"
    }

/**
* The status of the system.
*/
    union SystemStatusType {
        string,

        /**
* Running
*/"Running": "Running", /**
* Stopped
*/"Stopped": "Stopped"
    }

/**
* Represents the types of configuration for a system.
*/
    union ConfigurationType {
        string,

        /**
* SAP
*/"SAP": "SAP"
    }

/**
* The kind of the action
*/
    union ListActionKind {
        string,

        /**
* LockUser
*/"LockUser": "LockUser", /**
* UnlockUser
*/"UnlockUser": "UnlockUser"
    }

/**
* The package kind
*/
    union PackageKind {
        string,

        /**
* Solution
*/"Solution": "Solution", /**
* Standalone
*/"Standalone": "Standalone"
    }

/**
* The boolean value the metadata is for.
*/
    union Flag {
        string,

        /**
* true
*/"true": "true", /**
* false
*/"false": "false"
    }

/**
* Source type of the content
*/
    union SourceKind {
        string,

        /**
* LocalWorkspace
*/"LocalWorkspace": "LocalWorkspace", /**
* Community
*/"Community": "Community", /**
* Solution
*/"Solution": "Solution", /**
* SourceRepository
*/"SourceRepository": "SourceRepository"
    }

/**
* Type of support for content item
*/
    union SupportTier {
        string,

        /**
* Microsoft
*/"Microsoft": "Microsoft", /**
* Partner
*/"Partner": "Partner", /**
* Community
*/"Community": "Community"
    }

/**
* The kind of content the metadata is for.
*/
    union Kind {
        string,

        /**
* DataConnector
*/"DataConnector": "DataConnector", /**
* DataType
*/"DataType": "DataType", /**
* Workbook
*/"Workbook": "Workbook", /**
* WorkbookTemplate
*/"WorkbookTemplate": "WorkbookTemplate", /**
* Playbook
*/"Playbook": "Playbook", /**
* PlaybookTemplate
*/"PlaybookTemplate": "PlaybookTemplate", /**
* AnalyticsRuleTemplate
*/"AnalyticsRuleTemplate": "AnalyticsRuleTemplate", /**
* AnalyticsRule
*/"AnalyticsRule": "AnalyticsRule", /**
* HuntingQuery
*/"HuntingQuery": "HuntingQuery", /**
* InvestigationQuery
*/"InvestigationQuery": "InvestigationQuery", /**
* Parser
*/"Parser": "Parser", /**
* Watchlist
*/"Watchlist": "Watchlist", /**
* WatchlistTemplate
*/"WatchlistTemplate": "WatchlistTemplate", /**
* Solution
*/"Solution": "Solution", /**
* AzureFunction
*/"AzureFunction": "AzureFunction", /**
* LogicAppsCustomConnector
*/"LogicAppsCustomConnector": "LogicAppsCustomConnector", /**
* AutomationRule
*/"AutomationRule": "AutomationRule", /**
* ResourcesDataConnector
*/"ResourcesDataConnector": "ResourcesDataConnector", /**
* Notebook
*/"Notebook": "Notebook", /**
* Standalone
*/"Standalone": "Standalone", /**
* SummaryRule
*/"SummaryRule": "SummaryRule", /**
* Custom detections enable proactive monitoring and automated response actions for various events and system states across your tenant.
*/"CustomDetection": "CustomDetection"
    }

/**
* Represents an operator in a ConditionClause.
*/
    union Operator {
        string,

        /**
* Equals
*/"Equals": "Equals", /**
* NotEquals
*/"NotEquals": "NotEquals", /**
* LessThan
*/"LessThan": "LessThan", /**
* LessThanEqual
*/"LessThanEqual": "LessThanEqual", /**
* GreaterThan
*/"GreaterThan": "GreaterThan", /**
* GreaterThanEqual
*/"GreaterThanEqual": "GreaterThanEqual", /**
* StringContains
*/"StringContains": "StringContains", /**
* StringNotContains
*/"StringNotContains": "StringNotContains", /**
* StringStartsWith
*/"StringStartsWith": "StringStartsWith", /**
* StringNotStartsWith
*/"StringNotStartsWith": "StringNotStartsWith", /**
* StringEndsWith
*/"StringEndsWith": "StringEndsWith", /**
* StringNotEndsWith
*/"StringNotEndsWith": "StringNotEndsWith", /**
* StringIsEmpty
*/"StringIsEmpty": "StringIsEmpty", /**
* IsNull
*/"IsNull": "IsNull", /**
* IsTrue
*/"IsTrue": "IsTrue", /**
* IsFalse
*/"IsFalse": "IsFalse", /**
* ArrayContains
*/"ArrayContains": "ArrayContains", /**
* ArrayNotContains
*/"ArrayNotContains": "ArrayNotContains", /**
* OnOrAfterRelative
*/"OnOrAfterRelative": "OnOrAfterRelative", /**
* AfterRelative
*/"AfterRelative": "AfterRelative", /**
* OnOrBeforeRelative
*/"OnOrBeforeRelative": "OnOrBeforeRelative", /**
* BeforeRelative
*/"BeforeRelative": "BeforeRelative", /**
* OnOrAfterAbsolute
*/"OnOrAfterAbsolute": "OnOrAfterAbsolute", /**
* AfterAbsolute
*/"AfterAbsolute": "AfterAbsolute", /**
* OnOrBeforeAbsolute
*/"OnOrBeforeAbsolute": "OnOrBeforeAbsolute", /**
* BeforeAbsolute
*/"BeforeAbsolute": "BeforeAbsolute"
    }

/**
* The kind of the data connector definitions
*/
    union DataConnectorDefinitionKind {
        string,

        /**
* Customizable
*/"Customizable": "Customizable"
    }

/**
* The kind of the data connector
*/
    union DataConnectorKind {
        string,

        /**
* AzureActiveDirectory
*/"AzureActiveDirectory": "AzureActiveDirectory", /**
* AzureSecurityCenter
*/"AzureSecurityCenter": "AzureSecurityCenter", /**
* MicrosoftCloudAppSecurity
*/"MicrosoftCloudAppSecurity": "MicrosoftCloudAppSecurity", /**
* ThreatIntelligence
*/"ThreatIntelligence": "ThreatIntelligence", /**
* ThreatIntelligenceTaxii
*/"ThreatIntelligenceTaxii": "ThreatIntelligenceTaxii", /**
* Office365
*/"Office365": "Office365", /**
* OfficeATP
*/"OfficeATP": "OfficeATP", /**
* OfficeIRM
*/"OfficeIRM": "OfficeIRM", /**
* Office365Project
*/"Office365Project": "Office365Project", /**
* MicrosoftPurviewInformationProtection
*/"MicrosoftPurviewInformationProtection": "MicrosoftPurviewInformationProtection", /**
* OfficePowerBI
*/"OfficePowerBI": "OfficePowerBI", /**
* AmazonWebServicesCloudTrail
*/"AmazonWebServicesCloudTrail": "AmazonWebServicesCloudTrail", /**
* AmazonWebServicesS3
*/"AmazonWebServicesS3": "AmazonWebServicesS3", /**
* AzureAdvancedThreatProtection
*/"AzureAdvancedThreatProtection": "AzureAdvancedThreatProtection", /**
* MicrosoftDefenderAdvancedThreatProtection
*/"MicrosoftDefenderAdvancedThreatProtection": "MicrosoftDefenderAdvancedThreatProtection", /**
* Dynamics365
*/"Dynamics365": "Dynamics365", /**
* MicrosoftThreatProtection
*/"MicrosoftThreatProtection": "MicrosoftThreatProtection", /**
* MicrosoftThreatIntelligence
*/"MicrosoftThreatIntelligence": "MicrosoftThreatIntelligence", /**
* PremiumMicrosoftDefenderForThreatIntelligence
*/"PremiumMicrosoftDefenderForThreatIntelligence": "PremiumMicrosoftDefenderForThreatIntelligence", /**
* GenericUI
*/"GenericUI": "GenericUI", /**
* APIPolling
*/"APIPolling": "APIPolling", /**
* IOT
*/"IOT": "IOT", /**
* GCP
*/"GCP": "GCP", /**
* RestApiPoller
*/"RestApiPoller": "RestApiPoller", /**
* PurviewAudit
*/"PurviewAudit": "PurviewAudit"
    }

/**
* The authentication kind used to poll the data
*/
    union ConnectAuthKind {
        string,

        /**
* Basic
*/"Basic": "Basic", /**
* OAuth2
*/"OAuth2": "OAuth2", /**
* APIKey
*/"APIKey": "APIKey"
    }

/**
* Describes the state of user's authorization for a connector kind.
*/
    union DataConnectorAuthorizationState {
        string,

        /**
* Valid
*/"Valid": "Valid", /**
* Invalid
*/"Invalid": "Invalid"
    }

/**
* Describes the state of user's license for a connector kind.
*/
    union DataConnectorLicenseState {
        string,

        /**
* Valid
*/"Valid": "Valid", /**
* Invalid
*/"Invalid": "Invalid", /**
* Unknown
*/"Unknown": "Unknown"
    }

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"

    union EnrichmentType {
        string,

        /**
* main
*/"main": "main"
    }

/**
* The entity query kind
*/
    union EntityTimelineKind {
        string,

        /**
* activity
*/"Activity": "Activity", /**
* bookmarks
*/"Bookmark": "Bookmark", /**
* security alerts
*/"SecurityAlert": "SecurityAlert", /**
* anomaly
*/"Anomaly": "Anomaly"
    }

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"

    union EntityItemQueryKind {
        string,

        /**
* insight
*/"Insight": "Insight"
    }

/**
* The kind of the entity query
*/
    union EntityQueryKind {
        string,

        /**
* Expansion
*/"Expansion": "Expansion", /**
* Insight
*/"Insight": "Insight", /**
* Activity
*/"Activity": "Activity"
    }

/**
* the query kind
*/
    union GetInsightsError {
        string,

        /**
* Insight
*/"Insight": "Insight"
    }

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"

    union EntityQueryTemplateKind {
        string,

        /**
* Activity
*/"Activity": "Activity", /**
* Insight
*/"Insight": "Insight", /**
* SecurityAlert
*/"SecurityAlert": "SecurityAlert", /**
* Bookmark
*/"Bookmark": "Bookmark", /**
* Expansion
*/"Expansion": "Expansion", /**
* GuidedInsight
*/"GuidedInsight": "GuidedInsight", /**
* Anomaly
*/"Anomaly": "Anomaly"
    }

/**
* The kind of the entity query that supports put request.
*/
    union CustomEntityQueryKind {
        string,

        /**
* Activity
*/"Activity": "Activity"
    }

/**
* Describes how to ingest the records in the file.
*/
    union IngestionMode {
        string,

        /**
* No records should be ingested when invalid records are detected.
*/"IngestOnlyIfAllAreValid": "IngestOnlyIfAllAreValid", /**
* Valid records should still be ingested when invalid records are detected.
*/"IngestAnyValidRecords": "IngestAnyValidRecords", /**
* Unspecified
*/"Unspecified": "Unspecified"
    }

/**
* The content type of this file.
*/
    union FileImportContentType {
        string,

        /**
* File containing records with the core fields of an indicator, plus the observables to construct the STIX pattern.
*/"BasicIndicator": "BasicIndicator", /**
* File containing STIX indicators.
*/"StixIndicator": "StixIndicator", /**
* File containing other records.
*/"Unspecified": "Unspecified"
    }

/**
* The format of the file
*/
    union FileFormat {
        string,

        /**
* A CSV file.
*/"CSV": "CSV", /**
* A JSON file.
*/"JSON": "JSON", /**
* A file of other format.
*/"Unspecified": "Unspecified"
    }

/**
* Indicates whether the file was deleted from the storage account.
*/
    union DeleteStatus {
        string,

        /**
* The file was deleted.
*/"Deleted": "Deleted", /**
* The file was not deleted.
*/"NotDeleted": "NotDeleted", /**
* Unspecified
*/"Unspecified": "Unspecified"
    }

/**
* The state of the file import.
*/
    union FileImportState {
        string,

        /**
* A fatal error has occurred while ingesting the file.
*/"FatalError": "FatalError", /**
* The file has been ingested.
*/"Ingested": "Ingested", /**
* The file has been ingested with errors.
*/"IngestedWithErrors": "IngestedWithErrors", /**
* The file ingestion is in progress.
*/"InProgress": "InProgress", /**
* The file is invalid.
*/"Invalid": "Invalid", /**
* Waiting for the file to be uploaded.
*/"WaitingForUpload": "WaitingForUpload", /**
* Unspecified state.
*/"Unspecified": "Unspecified"
    }

/**
* The status of the hunt.
*/
    union Status {
        string,

        /**
* New
*/"New": "New", /**
* Active
*/"Active": "Active", /**
* Closed
*/"Closed": "Closed", /**
* Backlog
*/"Backlog": "Backlog", /**
* Approved
*/"Approved": "Approved", /**
* Succeeded
*/"Succeeded": "Succeeded", /**
* Failed
*/"Failed": "Failed", /**
* InProgress
*/"InProgress": "InProgress"
    }

/**
* The hypothesis status of the hunt.
*/
    union HypothesisStatus {
        string,

        /**
* Unknown
*/"Unknown": "Unknown", /**
* Invalidated
*/"Invalidated": "Invalidated", /**
* Validated
*/"Validated": "Validated"
    }

/**
* The type of the owner the hunt is assigned to.
*/
    union OwnerType {
        string,

        /**
* The hunt owner type is unknown
*/"Unknown": "Unknown", /**
* The hunt owner type is an AAD user
*/"User": "User", /**
* The hunt owner type is an AAD group
*/"Group": "Group"
    }

/**
* The status of the incident
*/
    union IncidentStatus {
        string,

        /**
* An active incident which isn't being handled currently
*/"New": "New", /**
* An active incident which is being handled
*/"Active": "Active", /**
* A non-active incident
*/"Closed": "Closed"
    }

/**
* The reason the incident was closed
*/
    union IncidentClassification {
        string,

        /**
* Incident classification was undetermined
*/"Undetermined": "Undetermined", /**
* Incident was true positive
*/"TruePositive": "TruePositive", /**
* Incident was benign positive
*/"BenignPositive": "BenignPositive", /**
* Incident was false positive
*/"FalsePositive": "FalsePositive"
    }

/**
* The classification reason the incident was closed with
*/
    union IncidentClassificationReason {
        string,

        /**
* Classification reason was suspicious activity
*/"SuspiciousActivity": "SuspiciousActivity", /**
* Classification reason was suspicious but expected
*/"SuspiciousButExpected": "SuspiciousButExpected", /**
* Classification reason was incorrect alert logic
*/"IncorrectAlertLogic": "IncorrectAlertLogic", /**
* Classification reason was inaccurate data
*/"InaccurateData": "InaccurateData"
    }

/**
* The type of the label
*/
    union IncidentLabelType {
        string,

        /**
* Label manually created by a user
*/"User": "User", /**
* Label automatically created by the system
*/"AutoAssigned": "AutoAssigned"
    }

/**
* The confidence level of this alert.
*/
    union ConfidenceLevel {
        string,

        /**
* Unknown confidence, the is the default value
*/"Unknown": "Unknown", /**
* Low confidence, meaning we have some doubts this is indeed malicious or part of an attack
*/"Low": "Low", /**
* High confidence that the alert is true positive malicious
*/"High": "High"
    }

/**
* The confidence score calculation status, i.e. indicating if score calculation is pending for this alert, not applicable or final.
*/
    union ConfidenceScoreStatus {
        string,

        /**
* Score will not be calculated for this alert as it is not supported by virtual analyst
*/"NotApplicable": "NotApplicable", /**
* No score was set yet and calculation is in progress
*/"InProcess": "InProcess", /**
* Score is calculated and shown as part of the alert, but may be updated again at a later time following the processing of additional data
*/"NotFinal": "NotFinal", /**
* Final score was calculated and available
*/"Final": "Final"
    }

/**
* The intent of the alert.
*/
    union KillChainIntent {
        string,

        /**
* The default value.
*/"Unknown": "Unknown", /**
* Probing could be an attempt to access a certain resource regardless of a malicious intent or a failed attempt to gain access to a target system to gather information prior to exploitation. This step is usually detected as an attempt originating from outside the network in attempt to scan the target system and find a way in.
*/"Probing": "Probing", /**
* Exploitation is the stage where an attacker manage to get foothold on the attacked resource. This stage is applicable not only for compute hosts, but also for resources such as user accounts, certificates etc. Adversaries will often be able to control the resource after this stage.
*/"Exploitation": "Exploitation", /**
* Persistence is any access, action, or configuration change to a system that gives an adversary a persistent presence on that system. Adversaries will often need to maintain access to systems through interruptions such as system restarts, loss of credentials, or other failures that would require a remote access tool to restart or alternate backdoor for them to regain access.
*/"Persistence": "Persistence", /**
* Privilege escalation is the result of actions that allow an adversary to obtain a higher level of permissions on a system or network. Certain tools or actions require a higher level of privilege to work and are likely necessary at many points throughout an operation. User accounts with permissions to access specific systems or perform specific functions necessary for adversaries to achieve their objective may also be considered an escalation of privilege.
*/"PrivilegeEscalation": "PrivilegeEscalation", /**
* Defense evasion consists of techniques an adversary may use to evade detection or avoid other defenses. Sometimes these actions are the same as or variations of techniques in other categories that have the added benefit of subverting a particular defense or mitigation. 
*/"DefenseEvasion": "DefenseEvasion", /**
* Credential access represents techniques resulting in access to or control over system, domain, or service credentials that are used within an enterprise environment. Adversaries will likely attempt to obtain legitimate credentials from users or administrator accounts (local system administrator or domain users with administrator access) to use within the network. With sufficient access within a network, an adversary can create accounts for later use within the environment.
*/"CredentialAccess": "CredentialAccess", /**
* Discovery consists of techniques that allow the adversary to gain knowledge about the system and internal network. When adversaries gain access to a new system, they must navigate themselves to what they now have control of and what benefits operating from that system give to their current objective or overall goals during the intrusion. The operating system provides many native tools that aid in this post-compromise information-gathering phase.
*/"Discovery": "Discovery", /**
* Lateral movement consists of techniques that enable an adversary to access and control remote systems on a network and could, but does not necessarily, include execution of tools on remote systems. The lateral movement techniques could allow an adversary to gather information from a system without needing additional tools, such as a remote access tool. An adversary can use lateral movement for many purposes, including remote Execution of tools, pivoting to additional systems, access to specific information or files, access to additional credentials, or to cause an effect.
*/"LateralMovement": "LateralMovement", /**
* The execution tactic represents techniques that result in execution of adversary-controlled code on a local or remote system. This tactic is often used in conjunction with lateral movement to expand access to remote systems on a network.
*/"Execution": "Execution", /**
* Collection consists of techniques used to identify and gather information, such as sensitive files, from a target network prior to exfiltration. This category also covers locations on a system or network where the adversary may look for information to exfiltrate.
*/"Collection": "Collection", /**
* Exfiltration refers to techniques and attributes that result or aid in the adversary removing files and information from a target network. This category also covers locations on a system or network where the adversary may look for information to exfiltrate.
*/"Exfiltration": "Exfiltration", /**
* The command and control tactic represents how adversaries communicate with systems under their control within a target network.
*/"CommandAndControl": "CommandAndControl", /**
* The impact intent primary objective is to directly reduce the availability or integrity of a system, service, or network; including manipulation of data to impact a business or operational process. This would often refer to techniques such as ransom-ware, defacement, data manipulation and others.
*/"Impact": "Impact"
    }

/**
* The severity of the alert
*/
    union AlertSeverity {
        string,

        /**
* High severity
*/"High": "High", /**
* Medium severity
*/"Medium": "Medium", /**
* Low severity
*/"Low": "Low", /**
* Informational severity
*/"Informational": "Informational"
    }

/**
* The lifecycle status of the alert.
*/
    union AlertStatus {
        string,

        /**
* Unknown value
*/"Unknown": "Unknown", /**
* New alert
*/"New": "New", /**
* Alert closed after handling
*/"Resolved": "Resolved", /**
* Alert dismissed as false positive
*/"Dismissed": "Dismissed", /**
* Alert is being handled
*/"InProgress": "InProgress"
    }

/**
* The status of the task
*/
    union IncidentTaskStatus {
        string,

        /**
* A new task
*/"New": "New", /**
* A completed task
*/"Completed": "Completed"
    }

/**
* State of recommendation.
*/
    union State {
        string,

        /**
* Recommendation is active.
*/"Active": "Active", /**
* Recommendation is in progress.
*/"InProgress": "InProgress", /**
* Recommendation has been dismissed.
*/"Dismissed": "Dismissed", /**
* Recommendation has been completed by user.
*/"CompletedByUser": "CompletedByUser", /**
* Recommendation has been completed by the system.
*/"CompletedBySystem": "CompletedBySystem"
    }

/**
* The kind of security ML analytics settings
*/
    union SecurityMLAnalyticsSettingsKind {
        string,

        /**
* Anomaly
*/"Anomaly": "Anomaly"
    }

/**
* The kind of the setting
*/
    union SettingKind {
        string,

        /**
* Anomalies
*/"Anomalies": "Anomalies", /**
* EyesOn
*/"EyesOn": "EyesOn", /**
* EntityAnalytics
*/"EntityAnalytics": "EntityAnalytics", /**
* Ueba
*/"Ueba": "Ueba"
    }

/**
* The kind of repository access credentials
*/
    union RepositoryAccessKind {
        string,

        /**
* OAuth
*/"OAuth": "OAuth", /**
* PAT
*/"PAT": "PAT", /**
* App
*/"App": "App"
    }

/**
* The version of the source control.
*/
    union Version {
        string,

        /**
* V1
*/"V1": "V1", /**
* V2
*/"V2": "V2"
    }

/**
* The type of repository.
*/
    union RepoType {
        string,

        /**
* Github
*/"Github": "Github", /**
* AzureDevOps
*/"AzureDevOps": "AzureDevOps"
    }

/**
* The content type of a source control path.
*/
    union ContentType {
        string,

        /**
* AnalyticsRule
*/"AnalyticsRule": "AnalyticsRule", /**
* AutomationRule
*/"AutomationRule": "AutomationRule", /**
* HuntingQuery
*/"HuntingQuery": "HuntingQuery", /**
* Parser
*/"Parser": "Parser", /**
* Playbook
*/"Playbook": "Playbook", /**
* Workbook
*/"Workbook": "Workbook"
    }

/**
* Status while trying to fetch the deployment information.
*/
    union DeploymentFetchStatus {
        string,

        /**
* Success
*/"Success": "Success", /**
* Unauthorized
*/"Unauthorized": "Unauthorized", /**
* NotFound
*/"NotFound": "NotFound"
    }

/**
* The current state of the deployment.
*/
    union DeploymentState {
        string,

        /**
* In_Progress
*/"In_Progress": "In_Progress", /**
* Completed
*/"Completed": "Completed", /**
* Queued
*/"Queued": "Queued", /**
* Canceling
*/"Canceling": "Canceling"
    }

/**
* Status while trying to fetch the deployment information.
*/
    union DeploymentResult {
        string,

        /**
* Success
*/"Success": "Success", /**
* Canceled
*/"Canceled": "Canceled", /**
* Failed
*/"Failed": "Failed"
    }

/**
* The type of repository.
*/
    union WarningCode {
        string,

        /**
* SourceControlWarning_DeleteServicePrincipal
*/"SourceControlWarning_DeleteServicePrincipal": "SourceControlWarning_DeleteServicePrincipal", /**
* SourceControlWarning_DeletePipelineFromAzureDevOps
*/"SourceControlWarning_DeletePipelineFromAzureDevOps": "SourceControlWarning_DeletePipelineFromAzureDevOps", /**
* SourceControlWarning_DeleteWorkflowAndSecretFromGitHub
*/"SourceControlWarning_DeleteWorkflowAndSecretFromGitHub": "SourceControlWarning_DeleteWorkflowAndSecretFromGitHub", /**
* SourceControlWarning_DeleteRoleAssignment
*/"SourceControlWarning_DeleteRoleAssignment": "SourceControlWarning_DeleteRoleAssignment", /**
* SourceControl_DeletedWithWarnings
*/"SourceControl_DeletedWithWarnings": "SourceControl_DeletedWithWarnings"
    }

/**
* The kind of the threat intelligence entity
*/
    union ThreatIntelligenceResourceInnerKind {
        string,

        /**
* Entity represents threat intelligence indicator in the system.
*/"indicator": "indicator"
    }

/**
* Sorting order (ascending/descending/unsorted).
*/
    union ThreatIntelligenceSortingOrder {
        string,

        /**
* unsorted
*/"unsorted": "unsorted", /**
* ascending
*/"ascending": "ascending", /**
* descending
*/"descending": "descending"
    }

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"

    union TiType {
        string,

        /**
* main
*/"main": "main"
    }

/**
* Represents boolean connectives used to join clauses in conditions.
*/
    union Connective {
        string,

        /**
* 'And' connective
*/"And": "And", /**
* 'Or' connective
*/"Or": "Or"
    }

/**
* The direction to sort the results by.
*/
    union SortingDirection {
        string,

        /**
* Indicates that the query should be sorted from lowest-to-highest value.
*/"ASC": "ASC", /**
* Indicates that the query should be sorted from lowest-to-highest value.
*/"DESC": "DESC"
    }

/**
* The kind of the TI object
*/
    union TIObjectKind {
        string,

        /**
* A TI object that represents an attack pattern.
*/"AttackPattern": "AttackPattern", /**
* A TI object that represents an identity.
*/"Identity": "Identity", /**
* A TI object that represents an indicator.
*/"Indicator": "Indicator", /**
* A TI object that represents a relationship between two TI objects.
*/"Relationship": "Relationship", /**
* A TI object that represents a threat actor.
*/"ThreatActor": "ThreatActor"
    }

/**
* The triggered analytics rule run provisioning state
*/
    union ProvisioningState {
        string,

        /**
* Accepted
*/"Accepted": "Accepted", /**
* InProgress
*/"InProgress": "InProgress", /**
* Succeeded
*/"Succeeded": "Succeeded", /**
* Failed
*/"Failed": "Failed", /**
* Canceled
*/"Canceled": "Canceled"
    }

/**
* The sourceType of the watchlist
*/
    union SourceType {
        string,

        /**
* The source from local file.
*/"Local": "Local", /**
* The source from Azure storage.
*/"AzureStorage": "AzureStorage"
    }

/**
* The current mode of the workspace manager configuration
*/
    union Mode {
        string,

        /**
* The workspace manager configuration is enabled
*/"Enabled": "Enabled", /**
* The workspace manager configuration is disabled
*/"Disabled": "Disabled"
    }

/**
* The alert rule template status.
*/
    union TemplateStatus {
        string,

        /**
* Alert rule template installed. and can not use more then once
*/"Installed": "Installed", /**
* Alert rule template is available.
*/"Available": "Available", /**
* Alert rule template is not available
*/"NotAvailable": "NotAvailable"
    }

/**
* The V3 type of the mapped entity
*/
    union EntityMappingType {
        string,

        /**
* User account entity type
*/"Account": "Account", /**
* Host entity type
*/"Host": "Host", /**
* IP address entity type
*/"IP": "IP", /**
* Malware entity type
*/"Malware": "Malware", /**
* System file entity type
*/"File": "File", /**
* Process entity type
*/"Process": "Process", /**
* Cloud app entity type
*/"CloudApplication": "CloudApplication", /**
* DNS entity type
*/"DNS": "DNS", /**
* Azure resource entity type
*/"AzureResource": "AzureResource", /**
* File-hash entity type
*/"FileHash": "FileHash", /**
* Registry key entity type
*/"RegistryKey": "RegistryKey", /**
* Registry value entity type
*/"RegistryValue": "RegistryValue", /**
* Security group entity type
*/"SecurityGroup": "SecurityGroup", /**
* URL entity type
*/"URL": "URL", /**
* Mailbox entity type
*/"Mailbox": "Mailbox", /**
* Mail cluster entity type
*/"MailCluster": "MailCluster", /**
* Mail message entity type
*/"MailMessage": "MailMessage", /**
* Submission mail entity type
*/"SubmissionMail": "SubmissionMail"
    }

/**
* The V3 alert property
*/
    union AlertProperty {
        string,

        /**
* Alert's link
*/"AlertLink": "AlertLink", /**
* Confidence level property
*/"ConfidenceLevel": "ConfidenceLevel", /**
* Confidence score
*/"ConfidenceScore": "ConfidenceScore", /**
* Extended links to the alert
*/"ExtendedLinks": "ExtendedLinks", /**
* Product name alert property
*/"ProductName": "ProductName", /**
* Provider name alert property
*/"ProviderName": "ProviderName", /**
* Product component name alert property
*/"ProductComponentName": "ProductComponentName", /**
* Remediation steps alert property
*/"RemediationSteps": "RemediationSteps", /**
* Techniques alert property
*/"Techniques": "Techniques", /**
* SubTechniques alert property
*/"SubTechniques": "SubTechniques"
    }

/**
* The event grouping aggregation kinds
*/
    union EventGroupingAggregationKind {
        string,

        /**
* SingleAlert
*/"SingleAlert": "SingleAlert", /**
* AlertPerResult
*/"AlertPerResult": "AlertPerResult"
    }

/**
* The alerts' productName on which the cases will be generated
*/
    union MicrosoftSecurityProductName {
        string,

        /**
* Microsoft Cloud App Security
*/"Microsoft Cloud App Security": "Microsoft Cloud App Security", /**
* Azure Security Center
*/"Azure Security Center": "Azure Security Center", /**
* Azure Advanced Threat Protection
*/"Azure Advanced Threat Protection": "Azure Advanced Threat Protection", /**
* Azure Active Directory Identity Protection
*/"Azure Active Directory Identity Protection": "Azure Active Directory Identity Protection", /**
* Azure Security Center for IoT
*/"Azure Security Center for IoT": "Azure Security Center for IoT", /**
* Office 365 Advanced Threat Protection
*/"Office 365 Advanced Threat Protection": "Office 365 Advanced Threat Protection", /**
* Microsoft Defender Advanced Threat Protection
*/"Microsoft Defender Advanced Threat Protection": "Microsoft Defender Advanced Threat Protection"
    }

/**
* Grouping matching method. When method is Selected at least one of groupByEntities, groupByAlertDetails, groupByCustomDetails must be provided and not empty.
*/
    union MatchingMethod {
        string,

        /**
* Grouping alerts into a single incident if all the entities match
*/"AllEntities": "AllEntities", /**
* Grouping any alerts triggered by this rule into a single incident
*/"AnyAlert": "AnyAlert", /**
* Grouping alerts into a single incident if the selected entities, custom details and alert details match
*/"Selected": "Selected"
    }

/**
* Alert detail
*/
    union AlertDetail {
        string,

        /**
* Alert display name
*/"DisplayName": "DisplayName", /**
* Alert severity
*/"Severity": "Severity"
    }

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"

    union AutomationRuleBooleanConditionSupportedOperator {
        string,

        /**
* Evaluates as true if all the item conditions are evaluated as true
*/"And": "And", /**
* Evaluates as true if at least one of the item conditions are evaluated as true
*/"Or": "Or"
    }

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"

    union AutomationRulePropertyArrayChangedConditionSupportedArrayType {
        string,

        /**
* Evaluate the condition on the alerts
*/"Alerts": "Alerts", /**
* Evaluate the condition on the labels
*/"Labels": "Labels", /**
* Evaluate the condition on the tactics
*/"Tactics": "Tactics", /**
* Evaluate the condition on the comments
*/"Comments": "Comments"
    }

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"

    union AutomationRulePropertyArrayChangedConditionSupportedChangeType {
        string,

        /**
* Evaluate the condition on items added to the array
*/"Added": "Added"
    }

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"

    union AutomationRulePropertyArrayConditionSupportedArrayType {
        string,

        /**
* Evaluate the condition on the custom detail keys
*/"CustomDetails": "CustomDetails", /**
* Evaluate the condition on a custom detail's values
*/"CustomDetailValues": "CustomDetailValues", /**
* Evaluate the condition on the incident labels
*/"IncidentLabels": "IncidentLabels"
    }

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"

    union AutomationRulePropertyArrayConditionSupportedArrayConditionType {
        string,

        /**
* Evaluate the condition as true if any item fulfills it
*/"AnyItem": "AnyItem", /**
* Evaluate the condition as true if all the items fulfill it
*/"AllItems": "AllItems"
    }

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"

    union AutomationRulePropertyChangedConditionSupportedPropertyType {
        string,

        /**
* Evaluate the condition on the incident severity
*/"IncidentSeverity": "IncidentSeverity", /**
* Evaluate the condition on the incident status
*/"IncidentStatus": "IncidentStatus", /**
* Evaluate the condition on the incident owner
*/"IncidentOwner": "IncidentOwner"
    }

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"

    union AutomationRulePropertyChangedConditionSupportedChangedType {
        string,

        /**
* Evaluate the condition on the previous value of the property
*/"ChangedFrom": "ChangedFrom", /**
* Evaluate the condition on the updated value of the property
*/"ChangedTo": "ChangedTo"
    }

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"

    union AutomationRulePropertyConditionSupportedOperator {
        string,

        /**
* Evaluates if the property equals at least one of the condition values
*/"Equals": "Equals", /**
* Evaluates if the property does not equal any of the condition values
*/"NotEquals": "NotEquals", /**
* Evaluates if the property contains at least one of the condition values
*/"Contains": "Contains", /**
* Evaluates if the property does not contain any of the condition values
*/"NotContains": "NotContains", /**
* Evaluates if the property starts with any of the condition values
*/"StartsWith": "StartsWith", /**
* Evaluates if the property does not start with any of the condition values
*/"NotStartsWith": "NotStartsWith", /**
* Evaluates if the property ends with any of the condition values
*/"EndsWith": "EndsWith", /**
* Evaluates if the property does not end with any of the condition values
*/"NotEndsWith": "NotEndsWith"
    }

/**
* The property to evaluate in an automation rule property condition.
*/
    union AutomationRulePropertyConditionSupportedProperty {
        string,

        /**
* The title of the incident
*/"IncidentTitle": "IncidentTitle", /**
* The description of the incident
*/"IncidentDescription": "IncidentDescription", /**
* The severity of the incident
*/"IncidentSeverity": "IncidentSeverity", /**
* The status of the incident
*/"IncidentStatus": "IncidentStatus", /**
* The related Analytic rule ids of the incident
*/"IncidentRelatedAnalyticRuleIds": "IncidentRelatedAnalyticRuleIds", /**
* The tactics of the incident
*/"IncidentTactics": "IncidentTactics", /**
* The labels of the incident
*/"IncidentLabel": "IncidentLabel", /**
* The provider name of the incident
*/"IncidentProviderName": "IncidentProviderName", /**
* The update source of the incident
*/"IncidentUpdatedBySource": "IncidentUpdatedBySource", /**
* The incident custom detail key
*/"IncidentCustomDetailsKey": "IncidentCustomDetailsKey", /**
* The incident custom detail value
*/"IncidentCustomDetailsValue": "IncidentCustomDetailsValue", /**
* The Custom-Detection rule ids associated with any of the incident alerts
*/"IncidentCustomDetectionRuleIds": "IncidentCustomDetectionRuleIds", /**
* The alert title associated with any of the incident alerts
*/"IncidentAlertTitle": "IncidentAlertTitle", /**
* The account Azure Active Directory tenant id
*/"AccountAadTenantId": "AccountAadTenantId", /**
* The account Azure Active Directory user id
*/"AccountAadUserId": "AccountAadUserId", /**
* The account name
*/"AccountName": "AccountName", /**
* The account NetBIOS domain name
*/"AccountNTDomain": "AccountNTDomain", /**
* The account Azure Active Directory Passport User ID
*/"AccountPUID": "AccountPUID", /**
* The account security identifier
*/"AccountSid": "AccountSid", /**
* The account unique identifier
*/"AccountObjectGuid": "AccountObjectGuid", /**
* The account user principal name suffix
*/"AccountUPNSuffix": "AccountUPNSuffix", /**
* The name of the product of the alert
*/"AlertProductNames": "AlertProductNames", /**
* The analytic rule ids of the alert
*/"AlertAnalyticRuleIds": "AlertAnalyticRuleIds", /**
* The Azure resource id
*/"AzureResourceResourceId": "AzureResourceResourceId", /**
* The Azure resource subscription id
*/"AzureResourceSubscriptionId": "AzureResourceSubscriptionId", /**
* The cloud application identifier
*/"CloudApplicationAppId": "CloudApplicationAppId", /**
* The cloud application name
*/"CloudApplicationAppName": "CloudApplicationAppName", /**
* The dns record domain name
*/"DNSDomainName": "DNSDomainName", /**
* The file directory full path
*/"FileDirectory": "FileDirectory", /**
* The file name without path
*/"FileName": "FileName", /**
* The file hash value
*/"FileHashValue": "FileHashValue", /**
* The host Azure resource id
*/"HostAzureID": "HostAzureID", /**
* The host name without domain
*/"HostName": "HostName", /**
* The host NetBIOS name
*/"HostNetBiosName": "HostNetBiosName", /**
* The host NT domain
*/"HostNTDomain": "HostNTDomain", /**
* The host operating system
*/"HostOSVersion": "HostOSVersion", /**
* "The IoT device id
*/"IoTDeviceId": "IoTDeviceId", /**
* The IoT device name
*/"IoTDeviceName": "IoTDeviceName", /**
* The IoT device type
*/"IoTDeviceType": "IoTDeviceType", /**
* The IoT device vendor
*/"IoTDeviceVendor": "IoTDeviceVendor", /**
* The IoT device model
*/"IoTDeviceModel": "IoTDeviceModel", /**
* The IoT device operating system
*/"IoTDeviceOperatingSystem": "IoTDeviceOperatingSystem", /**
* The IP address
*/"IPAddress": "IPAddress", /**
* The mailbox display name
*/"MailboxDisplayName": "MailboxDisplayName", /**
* The mailbox primary address
*/"MailboxPrimaryAddress": "MailboxPrimaryAddress", /**
* The mailbox user principal name
*/"MailboxUPN": "MailboxUPN", /**
* The mail message delivery action
*/"MailMessageDeliveryAction": "MailMessageDeliveryAction", /**
* The mail message delivery location
*/"MailMessageDeliveryLocation": "MailMessageDeliveryLocation", /**
* The mail message recipient
*/"MailMessageRecipient": "MailMessageRecipient", /**
* The mail message sender IP address
*/"MailMessageSenderIP": "MailMessageSenderIP", /**
* The mail message subject
*/"MailMessageSubject": "MailMessageSubject", /**
* The mail message P1 sender
*/"MailMessageP1Sender": "MailMessageP1Sender", /**
* The mail message P2 sender
*/"MailMessageP2Sender": "MailMessageP2Sender", /**
* The malware category
*/"MalwareCategory": "MalwareCategory", /**
* The malware name
*/"MalwareName": "MalwareName", /**
* The process execution command line
*/"ProcessCommandLine": "ProcessCommandLine", /**
* The process id
*/"ProcessId": "ProcessId", /**
* The registry key path
*/"RegistryKey": "RegistryKey", /**
* The registry key value in string formatted representation
*/"RegistryValueData": "RegistryValueData", /**
* The url
*/"Url": "Url"
    }

/**
* Type for authentication identity to key vault
*/
    union KeyVaultAuthenticationMode {
        string,

        /**
* ManagedIdentity
*/"ManagedIdentity": "ManagedIdentity", /**
* ServicePrincipal
*/"ServicePrincipal": "ServicePrincipal"
    }

/**
* Type for Secret Source - Azure Key Vault
*/
    union SecretSource {
        string,

        /**
* AzureKeyVault
*/"AzureKeyVault": "AzureKeyVault"
    }

/**
* Types of logs and tables.
*/
    union LogType {
        string,

        /**
* AbapAuditLog
*/"AbapAuditLog": "AbapAuditLog", /**
* AbapJobLog
*/"AbapJobLog": "AbapJobLog", /**
* AbapSpoolLog
*/"AbapSpoolLog": "AbapSpoolLog", /**
* AbapSpoolOutputLog
*/"AbapSpoolOutputLog": "AbapSpoolOutputLog", /**
* AbapChangeDocsLog
*/"AbapChangeDocsLog": "AbapChangeDocsLog", /**
* AbapAppLog
*/"AbapAppLog": "AbapAppLog", /**
* AbapWorkflowLog
*/"AbapWorkflowLog": "AbapWorkflowLog", /**
* AbapCrLog
*/"AbapCrLog": "AbapCrLog", /**
* AbapTableDataLog
*/"AbapTableDataLog": "AbapTableDataLog", /**
* AbapFilesLogs
*/"AbapFilesLogs": "AbapFilesLogs", /**
* JavaFilesLogs
*/"JavaFilesLogs": "JavaFilesLogs", /**
* AGRTCODES
*/"AGRTCODES": "AGRTCODES", /**
* USR01
*/"USR01": "USR01", /**
* USR02
*/"USR02": "USR02", /**
* AGR1251
*/"AGR1251": "AGR1251", /**
* AGRUSERS
*/"AGRUSERS": "AGRUSERS", /**
* AGRPROF
*/"AGRPROF": "AGRPROF", /**
* UST04
*/"UST04": "UST04", /**
* USR21
*/"USR21": "USR21", /**
* ADR6
*/"ADR6": "ADR6", /**
* ADCP
*/"ADCP": "ADCP", /**
* USR05
*/"USR05": "USR05", /**
* USGRPUSER
*/"USGRPUSER": "USGRPUSER", /**
* USERADDR
*/"USERADDR": "USERADDR", /**
* DEVACCESS
*/"DEVACCESS": "DEVACCESS", /**
* AGRDEFINE
*/"AGRDEFINE": "AGRDEFINE", /**
* PAHI
*/"PAHI": "PAHI", /**
* AGRAGRS
*/"AGRAGRS": "AGRAGRS", /**
* USRSTAMP
*/"USRSTAMP": "USRSTAMP", /**
* AGRFLAGS
*/"AGRFLAGS": "AGRFLAGS", /**
* SNCSYSACL
*/"SNCSYSACL": "SNCSYSACL", /**
* USRACL
*/"USRACL": "USRACL"
    }

/**
* Types of ingestion.
*/
    union IngestionType {
        string,

        /**
* Full
*/"Full": "Full", /**
* Incremental
*/"Incremental": "Incremental"
    }

/**
* Types of log status.
*/
    union LogStatusType {
        string,

        /**
* Enabled
*/"Enabled": "Enabled", /**
* Disabled
*/"Disabled": "Disabled"
    }

/**
* Types of authentication to SAP.
*/
    union SapAuthenticationType {
        string,

        /**
* UsernamePassword
*/"UsernamePassword": "UsernamePassword", /**
* Snc
*/"Snc": "Snc", /**
* SncWithUsernamePassword
*/"SncWithUsernamePassword": "SncWithUsernamePassword"
    }

/**
* Represents the types of SAP systems.
*/
    union SystemConfigurationConnectorType {
        string,

        /**
* Rfc
*/"Rfc": "Rfc", /**
* SapControl
*/"SapControl": "SapControl"
    }

/**
* Represents the types of HTTPS configuration to connect to the SapControl service.
*/
    union HttpsConfigurationType {
        string,

        /**
* HttpOnly
*/"HttpOnly": "HttpOnly", /**
* HttpsWithSslVerification
*/"HttpsWithSslVerification": "HttpsWithSslVerification", /**
* HttpsWithoutSslVerification
*/"HttpsWithoutSslVerification": "HttpsWithoutSslVerification"
    }

/**
* The scope on which the user should have permissions, in order to be able to create connections.
*/
    union ProviderPermissionsScope {
        string,

        /**
* Subscription
*/"Subscription": "Subscription", /**
* ResourceGroup
*/"ResourceGroup": "ResourceGroup", /**
* Workspace
*/"Workspace": "Workspace"
    }

/**
* Describe whether this data type connection is enabled or not.
*/
    union DataTypeState {
        string,

        /**
* Enabled
*/"Enabled": "Enabled", /**
* Disabled
*/"Disabled": "Disabled"
    }

/**
* The available data providers.
*/
    union MtpProvider {
        string,

        /**
* microsoftDefenderForCloudApps
*/"microsoftDefenderForCloudApps": "microsoftDefenderForCloudApps", /**
* microsoftDefenderForIdentity
*/"microsoftDefenderForIdentity": "microsoftDefenderForIdentity"
    }

/**
* Type of paging
*/
    union CcpAuthType {
        string,

        /**
* Basic
*/"Basic": "Basic", /**
* APIKey
*/"APIKey": "APIKey", /**
* OAuth2
*/"OAuth2": "OAuth2", /**
* AWS
*/"AWS": "AWS", /**
* GCP
*/"GCP": "GCP", /**
* Session
*/"Session": "Session", /**
* JwtToken
*/"JwtToken": "JwtToken", /**
* GitHub
*/"GitHub": "GitHub", /**
* ServiceBus
*/"ServiceBus": "ServiceBus", /**
* Oracle
*/"Oracle": "Oracle", /**
* None
*/"None": "None"
    }

/**
* The HTTP method, default value GET.
*/
    union HttpMethodVerb {
        string,

        /**
* GET
*/"GET": "GET", /**
* POST
*/"POST": "POST", /**
* PUT
*/"PUT": "PUT", /**
* DELETE
*/"DELETE": "DELETE"
    }

/**
* Type of paging
*/
    union RestApiPollerRequestPagingKind {
        string,

        /**
* LinkHeader
*/"LinkHeader": "LinkHeader", /**
* NextPageToken
*/"NextPageToken": "NextPageToken", /**
* NextPageUrl
*/"NextPageUrl": "NextPageUrl", /**
* PersistentToken
*/"PersistentToken": "PersistentToken", /**
* PersistentLinkHeader
*/"PersistentLinkHeader": "PersistentLinkHeader", /**
* Offset
*/"Offset": "Offset", /**
* CountBasedPaging
*/"CountBasedPaging": "CountBasedPaging"
    }

/**
* The polling frequency for the TAXII server.
*/
    union PollingFrequency {
        string,

        /**
* Once a minute
*/"OnceAMinute": "OnceAMinute", /**
* Once an hour
*/"OnceAnHour": "OnceAnHour", /**
* Once a day
*/"OnceADay": "OnceADay"
    }

/**
* type of connectivity
*/
    union ConnectivityType {
        string,

        /**
* IsConnectedQuery
*/"IsConnectedQuery": "IsConnectedQuery"
    }

/**
* Provider name
*/
    union ProviderName {
        string,

        /**
* Microsoft.OperationalInsights/solutions
*/"Microsoft.OperationalInsights/solutions": "Microsoft.OperationalInsights/solutions", /**
* Microsoft.OperationalInsights/workspaces
*/"Microsoft.OperationalInsights/workspaces": "Microsoft.OperationalInsights/workspaces", /**
* Microsoft.OperationalInsights/workspaces/datasources
*/"Microsoft.OperationalInsights/workspaces/datasources": "Microsoft.OperationalInsights/workspaces/datasources", /**
* microsoft.aadiam/diagnosticSettings
*/"microsoft.aadiam/diagnosticSettings": "microsoft.aadiam/diagnosticSettings", /**
* Microsoft.OperationalInsights/workspaces/sharedKeys
*/"Microsoft.OperationalInsights/workspaces/sharedKeys": "Microsoft.OperationalInsights/workspaces/sharedKeys", /**
* Microsoft.Authorization/policyAssignments
*/"Microsoft.Authorization/policyAssignments": "Microsoft.Authorization/policyAssignments"
    }

/**
* Permission provider scope
*/
    union PermissionProviderScope {
        string,

        /**
* ResourceGroup
*/"ResourceGroup": "ResourceGroup", /**
* Subscription
*/"Subscription": "Subscription", /**
* Workspace
*/"Workspace": "Workspace"
    }

/**
* The kind of the setting
*/
    union SettingType {
        string,

        /**
* CopyableLabel
*/"CopyableLabel": "CopyableLabel", /**
* InstructionStepsGroup
*/"InstructionStepsGroup": "InstructionStepsGroup", /**
* InfoMessage
*/"InfoMessage": "InfoMessage"
    }

/**
* The type of the entity
*/
    union EntityType {
        string,

        /**
* Entity represents account in the system.
*/"Account": "Account", /**
* Entity represents host in the system.
*/"Host": "Host", /**
* Entity represents file in the system.
*/"File": "File", /**
* Entity represents azure resource in the system.
*/"AzureResource": "AzureResource", /**
* Entity represents cloud application in the system.
*/"CloudApplication": "CloudApplication", /**
* Entity represents dns in the system.
*/"DNS": "DNS", /**
* Entity represents file hash in the system.
*/"FileHash": "FileHash", /**
* Entity represents ip in the system.
*/"IP": "IP", /**
* Entity represents malware in the system.
*/"Malware": "Malware", /**
* Entity represents process in the system.
*/"Process": "Process", /**
* Entity represents registry key in the system.
*/"RegistryKey": "RegistryKey", /**
* Entity represents registry value in the system.
*/"RegistryValue": "RegistryValue", /**
* Entity represents security group in the system.
*/"SecurityGroup": "SecurityGroup", /**
* Entity represents url in the system.
*/"URL": "URL", /**
* Entity represents IoT device in the system.
*/"IoTDevice": "IoTDevice", /**
* Entity represents security alert in the system.
*/"SecurityAlert": "SecurityAlert", /**
* Entity represents HuntingBookmark in the system.
*/"HuntingBookmark": "HuntingBookmark", /**
* Entity represents mail cluster in the system.
*/"MailCluster": "MailCluster", /**
* Entity represents mail message in the system.
*/"MailMessage": "MailMessage", /**
* Entity represents mailbox in the system.
*/"Mailbox": "Mailbox", /**
* Entity represents submission mail in the system.
*/"SubmissionMail": "SubmissionMail", /**
* Entity represents network interface in the system.
*/"Nic": "Nic"
    }

/**
* Insights Column type.
*/
    union OutputType {
        string,

        /**
* Number
*/"Number": "Number", /**
* String
*/"String": "String", /**
* Date
*/"Date": "Date", /**
* Entity
*/"Entity": "Entity"
    }

/**
* The anomaly SecurityMLAnalyticsSettings status
*/
    union SettingsStatus {
        string,

        /**
* Anomaly settings status in Production mode
*/"Production": "Production", /**
* Anomaly settings status in Flighting mode
*/"Flighting": "Flighting"
    }

/**
* The entity provider that is synced.
*/
    union EntityProviders {
        string,

        /**
* ActiveDirectory
*/"ActiveDirectory": "ActiveDirectory", /**
* AzureActiveDirectory
*/"AzureActiveDirectory": "AzureActiveDirectory"
    }

/**
* The data source that enriched by ueba.
*/
    union UebaDataSources {
        string,

        /**
* AuditLogs
*/"AuditLogs": "AuditLogs", /**
* AzureActivity
*/"AzureActivity": "AzureActivity", /**
* SecurityEvent
*/"SecurityEvent": "SecurityEvent", /**
* SigninLogs
*/"SigninLogs": "SigninLogs"
    }

/**
* The hash algorithm type.
*/
    union FileHashAlgorithm {
        string,

        /**
* Unknown hash algorithm
*/"Unknown": "Unknown", /**
* MD5 hash type
*/"MD5": "MD5", /**
* SHA1 hash type
*/"SHA1": "SHA1", /**
* SHA256 hash type
*/"SHA256": "SHA256", /**
* SHA256 Authenticode hash type
*/"SHA256AC": "SHA256AC"
    }

/**
* Device importance, determines if the device classified as 'crown jewel'
*/
    union DeviceImportance {
        string,

        /**
* Unknown - Default value
*/"Unknown": "Unknown", /**
* Low
*/"Low": "Low", /**
* Normal
*/"Normal": "Normal", /**
* High
*/"High": "High"
    }

/**
* The directionality of this mail message
*/
    union AntispamMailDirection {
        string,

        /**
* Unknown
*/"Unknown": "Unknown", /**
* Inbound
*/"Inbound": "Inbound", /**
* Outbound
*/"Outbound": "Outbound", /**
* Intraorg
*/"Intraorg": "Intraorg"
    }

/**
* the hive that holds the registry key.
*/
    union RegistryHive {
        string,

        /**
* HKEY_LOCAL_MACHINE
*/"HKEY_LOCAL_MACHINE": "HKEY_LOCAL_MACHINE", /**
* HKEY_CLASSES_ROOT
*/"HKEY_CLASSES_ROOT": "HKEY_CLASSES_ROOT", /**
* HKEY_CURRENT_CONFIG
*/"HKEY_CURRENT_CONFIG": "HKEY_CURRENT_CONFIG", /**
* HKEY_USERS
*/"HKEY_USERS": "HKEY_USERS", /**
* HKEY_CURRENT_USER_LOCAL_SETTINGS
*/"HKEY_CURRENT_USER_LOCAL_SETTINGS": "HKEY_CURRENT_USER_LOCAL_SETTINGS", /**
* HKEY_PERFORMANCE_DATA
*/"HKEY_PERFORMANCE_DATA": "HKEY_PERFORMANCE_DATA", /**
* HKEY_PERFORMANCE_NLSTEXT
*/"HKEY_PERFORMANCE_NLSTEXT": "HKEY_PERFORMANCE_NLSTEXT", /**
* HKEY_PERFORMANCE_TEXT
*/"HKEY_PERFORMANCE_TEXT": "HKEY_PERFORMANCE_TEXT", /**
* HKEY_A
*/"HKEY_A": "HKEY_A", /**
* HKEY_CURRENT_USER
*/"HKEY_CURRENT_USER": "HKEY_CURRENT_USER"
    }

/**
* Specifies the data types to use when storing values in the registry, or identifies the data type of a value in the registry.
*/
    union RegistryValueKind {
        string,

        /**
* None
*/"None": "None", /**
* Unknown value type
*/"Unknown": "Unknown", /**
* String value type
*/"String": "String", /**
* ExpandString value type
*/"ExpandString": "ExpandString", /**
* Binary value type
*/"Binary": "Binary", /**
* DWord value type
*/"DWord": "DWord", /**
* MultiString value type
*/"MultiString": "MultiString", /**
* QWord value type
*/"QWord": "QWord"
    }

/**
* The status of the action that was performed by the agent
*/
    union ActionStatus {
        string,

        /**
* Actions is pending
*/"Pending": "Pending", /**
* The action is completed successfully.
*/"Completed": "Completed", /**
* The action failed.
*/"Failed": "Failed"
    }

/**
* The operation against the threshold that triggers alert rule.
*/#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"

    enum TriggerOperator {
        /**
* GreaterThan
*/"GreaterThan", /**
* LessThan
*/"LessThan", /**
* Equal
*/"Equal", /**
* NotEqual
*/"NotEqual"
    }

/**
* The operating system type.
*/#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"

    enum OSFamily {
        /**
* Host with Linux operating system.
*/"Linux", /**
* Host with Windows operating system.
*/"Windows", /**
* Host with Android operating system.
*/"Android", /**
* Host with IOS operating system.
*/"IOS", /**
* Host with Unknown operating system.
*/"Unknown"
    }

/**
* The delivery action of this mail message like Delivered, Blocked, Replaced etc
*/#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"

    enum DeliveryAction {
        /**
* Unknown
*/"Unknown", /**
* DeliveredAsSpam
*/"DeliveredAsSpam", /**
* Delivered
*/"Delivered", /**
* Blocked
*/"Blocked", /**
* Replaced
*/"Replaced"
    }

/**
* The delivery location of this mail message like Inbox, JunkFolder etc
*/#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"

    enum DeliveryLocation {
        /**
* Unknown
*/"Unknown", /**
* Inbox
*/"Inbox", /**
* JunkFolder
*/"JunkFolder", /**
* DeletedFolder
*/"DeletedFolder", /**
* Quarantine
*/"Quarantine", /**
* External
*/"External", /**
* Failed
*/"Failed", /**
* Dropped
*/"Dropped", /**
* Forwarded
*/"Forwarded"
    }

/**
* The elevation token associated with the process.
*/#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"

    enum ElevationToken {
        /**
* Default elevation token
*/"Default", /**
* Full elevation token
*/"Full", /**
* Limited elevation token
*/"Limited"
    }




/**
* List all the alert rules.
*/
model AlertRulesList is Azure.Core.Page<AlertRule> {
}

/**
* An azure resource object with an Etag property
*/
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ResourceWithEtag extends Azure.ResourceManager.CommonTypes.Resource {
/**
* Etag of the azure resource
*/
"etag"?: string;
}

/**
* Error response structure.
*/
@error
model CloudError {
/**
* Error data
*/
"error"?: CloudErrorBody;
}

/**
* Error details.
*/
model CloudErrorBody {
/**
* An identifier for the error. Codes are invariant and are intended to be consumed programmatically.
*/
@visibility(Lifecycle.Read)
"code"?: string;
/**
* A message describing the error, intended to be suitable for display in a user interface.
*/
@visibility(Lifecycle.Read)
"message"?: string;
}

/**
* List all the actions.
*/
model ActionsList is Azure.Core.Page<ActionResponse> {
}

/**
* Action property bag.
*/
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model ActionResponseProperties extends ActionPropertiesBase {
/**
* The name of the logic app's workflow.
*/
"workflowId"?: string;
}

/**
* Action property bag base.
*/
model ActionPropertiesBase {
/**
* Logic App Resource Id, /subscriptions/{my-subscription}/resourceGroups/{my-resource-group}/providers/Microsoft.Logic/workflows/{my-workflow-id}.
*/
"logicAppResourceId": string;
}

/**
* Action for alert rule.
*/
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ActionRequest extends ResourceWithEtag {
/**
* Action properties for put request
*/
"properties"?: ActionRequestProperties;
}

/**
* Action property bag.
*/
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ActionRequestProperties extends ActionPropertiesBase {
/**
* Logic App Callback URL for this specific workflow.
*/
"triggerUri": string;
}

/**
* List all the alert rule templates.
*/
model AlertRuleTemplatesList is Azure.Core.Page<AlertRuleTemplate> {
}

/**
* Automation rule properties
*/
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model AutomationRuleProperties {
/**
* The display name of the automation rule.
*/
@maxLength(500)
"displayName": string;
/**
* The order of execution of the automation rule.
*/
@maxValue(1000)
@minValue(1)
"order": int32;
/**
* Describes automation rule triggering logic.
*/
"triggeringLogic": AutomationRuleTriggeringLogic;
/**
* The actions to execute when the automation rule is triggered.
*/
@identifiers(#[])
"actions": AutomationRuleAction[];
/**
* The last time the automation rule was updated.
*/
@visibility(Lifecycle.Read)
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"lastModifiedTimeUtc"?: utcDateTime;
/**
* The time the automation rule was created.
*/
@visibility(Lifecycle.Read)
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"createdTimeUtc"?: utcDateTime;
/**
* Information on the client (user or application) that made some action
*/
@visibility(Lifecycle.Read)
"lastModifiedBy"?: ClientInfo;
/**
* Information on the client (user or application) that made some action
*/
@visibility(Lifecycle.Read)
"createdBy"?: ClientInfo;
}

/**
* Describes automation rule triggering logic.
*/
model AutomationRuleTriggeringLogic {
/**
* Determines whether the automation rule is enabled or disabled.
*/
"isEnabled": boolean;
/**
* Determines when the automation rule should automatically expire and be disabled.
*/
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"expirationTimeUtc"?: utcDateTime;
#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
"triggersOn": TriggersOn;
#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
"triggersWhen": TriggersWhen;
/**
* The conditions to evaluate to determine if the automation rule should be triggered on a given object.
*/
@identifiers(#["conditionType"])
"conditions"?: AutomationRuleCondition[];
}

/**
* Describes an automation rule condition.
*/
@discriminator("conditionType")
model AutomationRuleCondition {
#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
"conditionType": ConditionType;
}

/**
* Describes an automation rule action.
*/
@discriminator("actionType")
model AutomationRuleAction {
#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
"order": int32;
/**
* The type of the automation rule action.
*/
"actionType": ActionType;
}

/**
* Information on the client (user or application) that made some action
*/
model ClientInfo {
/**
* The email of the client.
*/
"email"?: string;
/**
* The name of the client.
*/
"name"?: string;
/**
* The object id of the client.
*/
#suppress "@azure-tools/typespec-azure-core/no-format"
@format("uuid")
"objectId"?: string;
/**
* The user principal name of the client.
*/
"userPrincipalName"?: string;
}


#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model AutomationRulesList is Azure.Core.Page<AutomationRule> {
}

/**
* Describes the request body for triggering a playbook on an entity.
*/
model EntityManualTriggerRequestBody {
/**
* Incident ARM id.
*/
"incidentArmId"?: Azure.Core.armResourceIdentifier<[{type: "Microsoft.SecurityInsights/incidents";}]>;
/**
* The tenant id of the playbook resource.
*/
#suppress "@azure-tools/typespec-azure-core/no-format"
@format("uuid")
"tenantId"?: string;
/**
* The resource id of the playbook resource.
*/
"logicAppsResourceId": Azure.Core.armResourceIdentifier<[{type: "Microsoft.Logic/workflows";},{type: "Microsoft.Web/sites";}]>;
}


#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ManualTriggerRequestBody {
#suppress "@azure-tools/typespec-azure-core/no-format"
@format("uuid")
#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
"tenantId"?: string;
#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
"logicAppsResourceId": Azure.Core.armResourceIdentifier<[{type: "Microsoft.Logic/workflows";},{type: "Microsoft.Web/sites";}]>;
}

/**
* List of all Microsoft Sentinel billing statistics.
*/
model BillingStatisticList is Azure.Core.Page<BillingStatistic> {
}

/**
* List all the bookmarks.
*/
model BookmarkList is Azure.Core.Page<Bookmark> {
}

/**
* Describes bookmark properties
*/
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model BookmarkProperties {
/**
* The time the bookmark was created
*/
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"created"?: utcDateTime;
/**
* Describes a user that created the bookmark
*/
"createdBy"?: UserInfo;
/**
* The display name of the bookmark
*/
"displayName": string;
/**
* List of labels relevant to this bookmark
*/
"labels"?: string[];
/**
* The notes of the bookmark
*/
"notes"?: string;
/**
* The query of the bookmark.
*/
"query": string;
/**
* The query result of the bookmark.
*/
"queryResult"?: string;
/**
* The last time the bookmark was updated
*/
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"updated"?: utcDateTime;
/**
* Describes a user that updated the bookmark
*/
"updatedBy"?: UserInfo;
/**
* The bookmark event time
*/
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"eventTime"?: utcDateTime;
/**
* The start time for the query
*/
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"queryStartTime"?: utcDateTime;
/**
* The end time for the query
*/
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"queryEndTime"?: utcDateTime;
/**
* Describes an incident that relates to bookmark
*/
"incidentInfo"?: IncidentInfo;
/**
* Describes the entity mappings of the bookmark
*/
"entityMappings"?: BookmarkEntityMappings[];
/**
* A list of relevant mitre attacks
*/
"tactics"?: AttackTactic[];
/**
* A list of relevant mitre techniques
*/
"techniques"?: string[];
}

/**
* User information that made some action
*/
model UserInfo {
/**
* The email of the user.
*/
@visibility(Lifecycle.Read)
"email"?: string;
/**
* The name of the user.
*/
@visibility(Lifecycle.Read)
"name"?: string;
/**
* The object id of the user.
*/
#suppress "@azure-tools/typespec-azure-core/no-format"
@format("uuid")
"objectId"?: string;
}

/**
* Describes related incident information for the bookmark
*/
model IncidentInfo {
/**
* Incident Id
*/
"incidentId"?: string;
/**
* The severity of the incident
*/
"severity"?: IncidentSeverity;
/**
* The title of the incident
*/
"title"?: string;
/**
* Relation Name
*/
"relationName"?: string;
}

/**
* Describes the entity mappings of a single entity
*/
model BookmarkEntityMappings {
/**
* The entity type
*/
"entityType"?: string;
/**
* Array of fields mapping for that entity type
*/
@identifiers(#[])
"fieldMappings"?: EntityFieldMapping[];
}

/**
* Map identifiers of a single entity
*/
model EntityFieldMapping {
/**
* Alert V3 identifier
*/
"identifier"?: string;
/**
* The value of the identifier
*/
"value"?: string;
}

/**
* List of relations.
*/
model RelationList is Azure.Core.Page<Relation> {
}

/**
* Relation property bag.
*/
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model RelationProperties {
/**
* The resource ID of the related resource
*/
"relatedResourceId": string;
/**
* The name of the related resource
*/
@visibility(Lifecycle.Read)
"relatedResourceName"?: string;
/**
* The resource type of the related resource
*/
@visibility(Lifecycle.Read)
"relatedResourceType"?: string;
/**
* The resource kind of the related resource
*/
@visibility(Lifecycle.Read)
"relatedResourceKind"?: string;
}

/**
* The parameters required to execute an expand operation on the given bookmark.
*/
model BookmarkExpandParameters {
/**
* The end date filter, so the only expansion results returned are before this date.
*/
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"endTime"?: utcDateTime;
/**
* The Id of the expansion to perform.
*/
#suppress "@azure-tools/typespec-azure-core/no-format"
@format("uuid")
"expansionId"?: string;
/**
* The start date filter, so the only expansion results returned are after this date.
*/
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"startTime"?: utcDateTime;
}

/**
* The entity expansion result operation response.
*/
model BookmarkExpandResponse {
/**
* The metadata from the expansion operation results.
*/
"metaData"?: ExpansionResultsMetadata;
/**
* The expansion result values.
*/
"value"?: BookmarkExpandResponseValue;
}

/**
* Expansion result metadata.
*/
model ExpansionResultsMetadata {
/**
* Information of the aggregated nodes in the expansion result.
*/
@identifiers(#[])
"aggregations"?: ExpansionResultAggregation[];
}

/**
* Information of a specific aggregation in the expansion result.
*/
model ExpansionResultAggregation {
/**
* The common type of the aggregation. (for e.g. entity field name)
*/
"aggregationType"?: string;
/**
* Total number of aggregations of the given kind (and aggregationType if given) in the expansion result.
*/
"count": int32;
/**
* The display name of the aggregation by type.
*/
"displayName"?: string;
/**
* The kind of the aggregated entity.
*/
"entityKind": EntityKindEnum;
}

/**
* The expansion result values.
*/
model BookmarkExpandResponseValue {
/**
* Array of the expansion result entities.
*/
"entities"?: Entity[];
/**
* Array of expansion result connected entities
*/
"edges"?: ConnectedEntity[];
}

/**
* Expansion result connected entities
*/
model ConnectedEntity {
/**
* Entity Id of the connected entity
*/
"targetEntityId"?: string;
/**
* key-value pairs for a connected entity mapping
*/
"additionalData"?: unknown;
}


#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model AgentProperties {
/**
* Describes the configuration of a Business Application Agent.
*/
"configuration": AgentConfiguration;
@visibility(Lifecycle.Read)
#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
"agentSystems"?: AgentSystem[];
@minLength(1)
#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
"displayName": string;
@visibility(Lifecycle.Read)
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
"lastModifiedTimeUtc"?: utcDateTime;
}

/**
* Describes the configuration of a Business Application Agent.
*/
@discriminator("type")
model AgentConfiguration {
/**
* Type of the agent
*/
"type": AgentType;
}

/**
* Describes the configuration of a system inside the agent.
*/
model AgentSystem {
#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
"systemResourceName"?: string;
#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
"systemDisplayName"?: string;
}

/**
* List of agents.
*/
model BusinessApplicationAgentsList is Azure.Core.Page<BusinessApplicationAgentResource> {
}

/**
* The properties of the system.
*/
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model SystemProperties {
/**
* The status of the system.
*/
"status"?: SystemStatusType;
/**
* The configuration of the system.
*/
"configuration": SystemsConfiguration;
@minLength(1)
#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
"displayName": string;
@visibility(Lifecycle.Read)
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
"lastModifiedTimeUtc"?: utcDateTime;
}

/**
* The configuration of the system.
*/
@discriminator("type")
model SystemsConfiguration {
/**
* Represents the types of configuration for a system.
*/
"type": ConfigurationType;
}

/**
* List of Agent's Systems.
*/
model SystemsList is Azure.Core.Page<SystemResource> {
}

/**
* List all actions for a system to perform.
*/
model ListActionsResponse is Azure.Core.Page<Action> {
}

/**
* Represents an action to perform on a specific system.
*/
@discriminator("kind")
model Action {
/**
* The actions kind
*/
"kind": ListActionKind;
}

/**
* Represents the undo action.
*/
model UndoActionPayload {
/**
* The action ID of the original action that was performed and now need to undo
*/
"actionId"?: string;
}

/**
* Report the status of an action that was performed by the agent
*/
model ReportActionStatusPayload {
/**
* The action ID to perform
*/
"actionId"?: string;
/**
* The status of the action that was performed by the agent
*/
"actionStatus"?: string;
/**
* The reason of the failure of the action. Empty if the action is successful.
*/
"failureReason"?: string;
}

/**
* List available packages.
*/
model PackageList is Azure.Core.Page<PackageModel> {
}

/**
* Describes package properties
*/
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model PackageProperties extends PackageBaseProperties {
}

/**
* Describes package properties
*/
model PackageBaseProperties {
/**
* The content id of the package
*/
"contentId"?: string;
/**
* Unique ID for the content. It should be generated based on the contentId, contentKind and the contentVersion of the package
*/
"contentProductId"?: string;
/**
* The package kind
*/
"contentKind"?: PackageKind;
/**
* The version of the content schema.
*/
"contentSchemaVersion"?: string;
/**
* Flag indicates if this is a newly published package.
*/
"isNew"?: Flag;
/**
* Flag indicates if this package is in preview.
*/
"isPreview"?: Flag;
/**
* Flag indicates if this package is among the featured list.
*/
"isFeatured"?: Flag;
/**
* Flag indicates if this template is deprecated
*/
"isDeprecated"?: Flag;
/**
* the latest version number of the package
*/
"version"?: string;
/**
* The display name of the package
*/
"displayName"?: string;
/**
* The description of the package
*/
"description"?: string;
/**
* The publisher display name of the package
*/
"publisherDisplayName"?: string;
/**
* The source of the package
*/
"source"?: MetadataSource;
/**
* The author of the package
*/
"author"?: MetadataAuthor;
/**
* The support tier of the package
*/
"support"?: MetadataSupport;
/**
* The support tier of the package
*/
"dependencies"?: MetadataDependencies;
/**
* Providers for the package item
*/
"providers"?: string[];
/**
* first publish date package item
*/
"firstPublishDate"?: plainDate;
/**
* last publish date for the package item
*/
"lastPublishDate"?: plainDate;
/**
* The categories of the package
*/
"categories"?: MetadataCategories;
/**
* the tactics the resource covers
*/
"threatAnalysisTactics"?: string[];
/**
* the techniques the resource covers, these have to be aligned with the tactics being used
*/
"threatAnalysisTechniques"?: string[];
/**
* the icon identifier. this id can later be fetched from the content metadata
*/
"icon"?: string;
}

/**
* The original source of the content item, where it comes from.
*/
model MetadataSource {
/**
* Source type of the content
*/
"kind": SourceKind;
/**
* Name of the content source.  The repo name, solution name, LA workspace name etc.
*/
"name"?: string;
/**
* ID of the content source.  The solution ID, workspace ID, etc
*/
"sourceId"?: string;
}

/**
* Publisher or creator of the content item.
*/
model MetadataAuthor {
/**
* Name of the author. Company or person.
*/
"name"?: string;
/**
* Email of author contact
*/
"email"?: string;
/**
* Link for author/vendor page
*/
"link"?: string;
}

/**
* Support information for the content item.
*/
model MetadataSupport {
/**
* Type of support for content item
*/
"tier": SupportTier;
/**
* Name of the support contact. Company or person.
*/
"name"?: string;
/**
* Email of support contact
*/
"email"?: string;
/**
* Link for support help, like to support page to open a ticket etc.
*/
"link"?: string;
}

/**
* Dependencies for the content item, what other content items it requires to work.  Can describe more complex dependencies using a recursive/nested structure. For a single dependency an id/kind/version can be supplied or operator/criteria for complex dependencies.
*/
model MetadataDependencies {
/**
* Id of the content item we depend on
*/
"contentId"?: string;
/**
* Type of the content item we depend on
*/
"kind"?: Kind;
/**
* Version of the the content item we depend on.  Can be blank, * or missing to indicate any version fulfills the dependency.  If version does not match our defined numeric format then an exact match is required.
*/
"version"?: string;
/**
* Name of the content item
*/
"name"?: string;
/**
* Operator used for list of dependencies in criteria array.
*/
"operator"?: Operator;
/**
* This is the list of dependencies we must fulfill, according to the AND/OR operator
*/
@identifiers(#["contentId"])
"criteria"?: MetadataDependencies[];
}

/**
* ies for the solution content item
*/
model MetadataCategories {
/**
* domain for the solution content item
*/
"domains"?: string[];
/**
* Industry verticals for the solution content item
*/
"verticals"?: string[];
}

/**
* List available packages.
*/
model ProductPackageList is Azure.Core.Page<ProductPackageModel> {
}

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
"installedVersion"?: string;
/**
* The metadata resource id.
*/
"metadataResourceId"?: Azure.Core.armResourceIdentifier;
/**
* The json of the ARM template to deploy. Expandable.
*/
"packagedContent"?: unknown;
}

/**
* List of all the template.
*/
model ProductTemplateList is Azure.Core.Page<ProductTemplateModel> {
}

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
"contentId"?: string;
/**
* Unique ID for the content. It should be generated based on the contentId of the package, contentId of the template, contentKind of the template and the contentVersion of the template
*/
"contentProductId"?: string;
/**
* Version of the package.  Default and recommended format is numeric (e.g. 1, 1.0, 1.0.0, 1.0.0.0), following ARM metadata best practices.  Can also be any string, but then we cannot guarantee any version checks
*/
"packageVersion"?: string;
/**
* Version of the content.  Default and recommended format is numeric (e.g. 1, 1.0, 1.0.0, 1.0.0.0), following ARM metadata best practices.  Can also be any string, but then we cannot guarantee any version checks
*/
"version"?: string;
/**
* The display name of the template
*/
"displayName"?: string;
/**
* The kind of content the template is for.
*/
"contentKind"?: Kind;
/**
* Source of the content.  This is where/how it was created.
*/
"source"?: MetadataSource;
/**
* The creator of the content item.
*/
"author"?: MetadataAuthor;
/**
* Support information for the template - type, name, contact information
*/
"support"?: MetadataSupport;
/**
* Dependencies for the content item, what other content items it requires to work.  Can describe more complex dependencies using a recursive/nested structure. For a single dependency an id/kind/version can be supplied or operator/criteria for complex formats.
*/
"dependencies"?: MetadataDependencies;
/**
* Categories for the item
*/
"categories"?: MetadataCategories;
/**
* Providers for the content item
*/
"providers"?: string[];
/**
* first publish date content item
*/
"firstPublishDate"?: plainDate;
/**
* last publish date for the content item
*/
"lastPublishDate"?: plainDate;
/**
* The custom version of the content. A optional free text
*/
"customVersion"?: string;
/**
* Schema version of the content. Can be used to distinguish between different flow based on the schema version
*/
"contentSchemaVersion"?: string;
/**
* the icon identifier. this id can later be fetched from the content metadata
*/
"icon"?: string;
/**
* the tactics the resource covers
*/
"threatAnalysisTactics"?: string[];
/**
* the techniques the resource covers, these have to be aligned with the tactics being used
*/
"threatAnalysisTechniques"?: string[];
/**
* preview image file names. These will be taken from the solution artifacts
*/
"previewImages"?: string[];
/**
* preview image file names. These will be taken from the solution artifacts. used for dark theme support
*/
"previewImagesDark"?: string[];
/**
* the package Id contains this template
*/
"packageId"?: string;
/**
* the packageKind of the package contains this template
*/
"packageKind"?: PackageKind;
/**
* the name of the package contains this template
*/
"packageName"?: string;
/**
* Flag indicates if this template is deprecated
*/
@visibility(Lifecycle.Read)
"isDeprecated"?: Flag;
}

/**
* additional properties of product template.
*/
model ProductTemplateAdditionalProperties {
/**
* The json of the ARM template to deploy
*/
"packagedContent"?: unknown;
}

/**
* List of all the template.
*/
model TemplateList is Azure.Core.Page<TemplateModel> {
}

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
"mainTemplate"?: unknown;
/**
* Dependant templates. Expandable.
*/
@visibility(Lifecycle.Read)
@identifiers(#["contentId"])
"dependantTemplates"?: TemplateProperties[];
}

/**
* Encapsulate the data connector definition object
*/
model DataConnectorDefinitionArmCollectionWrapper is Azure.Core.Page<DataConnectorDefinition> {
}

/**
* List all the data connectors.
*/
model DataConnectorList is Azure.Core.Page<DataConnector> {
}

/**
* Represents Codeless API Polling data connector.
*/
model DataConnectorConnectBody {
/**
* The authentication kind used to poll the data
*/
"kind"?: ConnectAuthKind;
/**
* The API key of the audit server.
*/
"apiKey"?: string;
/**
* Used in v2 logs connector. Represents the data collection ingestion endpoint in log analytics.
*/
"dataCollectionEndpoint"?: string;
/**
* Used in v2 logs connector. The data collection rule immutable id, the rule defines the transformation and data destination.
*/
"dataCollectionRuleImmutableId"?: string;
/**
* Used in v2 logs connector. The stream we are sending the data to, this is the name of the streamDeclarations defined in the DCR.
*/
"outputStream"?: string;
/**
* The client secret of the OAuth 2.0 application.
*/
"clientSecret"?: string;
/**
* The client id of the OAuth 2.0 application.
*/
"clientId"?: string;
/**
* The authorization code used in OAuth 2.0 code flow to issue a token.
*/
"authorizationCode"?: string;
/**
* The user name in the audit log server.
*/
"userName"?: string;
/**
* The user password in the audit log server.
*/
"password"?: string;
@identifiers(#[])
#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
"requestConfigUserInputValues"?: unknown[];
}

/**
* Data connector requirements properties.
*/
@discriminator("kind")
model DataConnectorsCheckRequirements {
/**
* Describes the kind of connector to be checked.
*/
"kind": DataConnectorKind;
}

/**
* Data connector requirements status.
*/
model DataConnectorRequirementsState {
/**
* Authorization state for this connector
*/
"authorizationState"?: DataConnectorAuthorizationState;
/**
* License state for this connector
*/
"licenseState"?: DataConnectorLicenseState;
}

/**
* IP address (v4 or v6) to be enriched
*/
model EnrichmentIpAddressBody {
/**
* The dotted-decimal or colon-separated string representation of the IP address
*/
"ipAddress"?: string;
}

/**
* Geodata information for a given IP address
*/
model EnrichmentIpGeodata {
/**
* The autonomous system number associated with this IP address
*/
"asn"?: string;
/**
* The name of the carrier for this IP address
*/
"carrier"?: string;
/**
* The city this IP address is located in
*/
"city"?: string;
/**
* A numeric rating of confidence that the value in the 'city' field is correct, on a scale of 0-100
*/
@maxValue(100)
"cityConfidenceFactor"?: int32;
/**
* The continent this IP address is located on
*/
"continent"?: string;
/**
* The county this IP address is located in
*/
"country"?: string;
/**
* A numeric rating of confidence that the value in the 'country' field is correct on a scale of 0-100
*/
@maxValue(100)
"countryConfidenceFactor"?: int32;
/**
* The dotted-decimal or colon-separated string representation of the IP address
*/
"ipAddr"?: string;
/**
* A description of the connection type of this IP address
*/
"ipRoutingType"?: string;
/**
* The latitude of this IP address
*/
"latitude"?: string;
/**
* The longitude of this IP address
*/
"longitude"?: string;
/**
* The name of the organization for this IP address
*/
"organization"?: string;
/**
* The type of the organization for this IP address
*/
"organizationType"?: string;
/**
* The geographic region this IP address is located in
*/
"region"?: string;
/**
* The state this IP address is located in
*/
"state"?: string;
/**
* A numeric rating of confidence that the value in the 'state' field is correct on a scale of 0-100
*/
@maxValue(100)
"stateConfidenceFactor"?: int32;
/**
* The abbreviated name for the state this IP address is located in
*/
"stateCode"?: string;
}

/**
* Domain name to be enriched
*/
model EnrichmentDomainBody {
/**
* The domain name
*/
"domain"?: string;
}

/**
* Whois information for a given domain and associated metadata
*/
model EnrichmentDomainWhois {
/**
* The domain for this whois record
*/
"domain"?: string;
/**
* The hostname of this registrar's whois server
*/
"server"?: string;
/**
* The timestamp at which this record was created
*/
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"created"?: utcDateTime;
/**
* The timestamp at which this record was last updated
*/
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"updated"?: utcDateTime;
/**
* The timestamp at which this record will expire
*/
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"expires"?: utcDateTime;
/**
* The whois record for a given domain
*/
"parsedWhois"?: EnrichmentDomainWhoisDetails;
}

/**
* The whois record for a given domain
*/
model EnrichmentDomainWhoisDetails {
/**
* The registrar associated with this domain
*/
"registrar"?: EnrichmentDomainWhoisRegistrarDetails;
/**
* The set of contacts associated with this domain
*/
"contacts"?: EnrichmentDomainWhoisContacts;
/**
* A list of name servers associated with this domain
*/
"nameServers"?: string[];
/**
* The set of status flags for this whois record
*/
"statuses"?: string[];
}

/**
* The registrar associated with this domain
*/
model EnrichmentDomainWhoisRegistrarDetails {
/**
* The name of this registrar
*/
"name"?: string;
/**
* This registrar's abuse contact email
*/
"abuseContactEmail"?: string;
/**
* This registrar's abuse contact phone number
*/
"abuseContactPhone"?: string;
/**
* This registrar's Internet Assigned Numbers Authority id
*/
"ianaId"?: string;
/**
* This registrar's URL
*/
"url"?: string;
/**
* The hostname of this registrar's whois server
*/
"whoisServer"?: string;
}

/**
* The set of contacts associated with this domain
*/
model EnrichmentDomainWhoisContacts {
/**
* The admin contact for this whois record
*/
"admin"?: EnrichmentDomainWhoisContact;
/**
* The billing contact for this whois record
*/
"billing"?: EnrichmentDomainWhoisContact;
/**
* The registrant contact for this whois record
*/
"registrant"?: EnrichmentDomainWhoisContact;
/**
* The technical contact for this whois record
*/
"tech"?: EnrichmentDomainWhoisContact;
}

/**
* An individual contact associated with this domain
*/
model EnrichmentDomainWhoisContact {
/**
* The name of this contact
*/
"name"?: string;
/**
* The organization for this contact
*/
"org"?: string;
/**
* A list describing the street address for this contact
*/
"street"?: string[];
/**
* The city for this contact
*/
"city"?: string;
/**
* The state for this contact
*/
"state"?: string;
/**
* The postal code for this contact
*/
"postal"?: string;
/**
* The country for this contact
*/
"country"?: string;
/**
* The phone number for this contact
*/
"phone"?: string;
/**
* The fax number for this contact
*/
"fax"?: string;
/**
* The email address for this contact
*/
"email"?: string;
}

/**
* List of all the entities.
*/
model EntityList is Azure.Core.Page<Entity> {
}

/**
* The parameters required to execute an expand operation on the given entity.
*/
model EntityExpandParameters {
/**
* The end date filter, so the only expansion results returned are before this date.
*/
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"endTime"?: utcDateTime;
/**
* The Id of the expansion to perform.
*/
#suppress "@azure-tools/typespec-azure-core/no-format"
@format("uuid")
"expansionId"?: string;
/**
* The start date filter, so the only expansion results returned are after this date.
*/
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"startTime"?: utcDateTime;
}

/**
* The entity expansion result operation response.
*/
model EntityExpandResponse {
/**
* The metadata from the expansion operation results.
*/
"metaData"?: ExpansionResultsMetadata;
/**
* The expansion result values.
*/
"value"?: EntityExpandResponseValue;
}

/**
* The expansion result values.
*/
model EntityExpandResponseValue {
/**
* Array of the expansion result entities.
*/
@identifiers(#[])
"entities"?: Entity[];
/**
* Array of edges that connects the entity to the list of entities.
*/
@identifiers(#[])
"edges"?: EntityEdges[];
}

/**
* The edge that connects the entity to the other entity.
*/
model EntityEdges {
/**
* The target entity Id.
*/
"targetEntityId"?: string;
/**
* A bag of custom fields that should be part of the entity and will be presented to the user.
*/
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
"additionalData"?: Record<unknown>;
}

/**
* The parameters required to execute s timeline operation on the given entity.
*/
model EntityTimelineParameters {
/**
* Array of timeline Item kinds.
*/
"kinds"?: EntityTimelineKind[];
/**
* The start timeline date, so the results returned are after this date.
*/
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"startTime": utcDateTime;
/**
* The end timeline date, so the results returned are before this date.
*/
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"endTime": utcDateTime;
/**
* The number of bucket for timeline queries aggregation.
*/
"numberOfBucket"?: int32;
}

/**
* The entity timeline result operation response.
*/
model EntityTimelineResponse {
/**
* The metadata from the timeline operation results.
*/
"metaData"?: TimelineResultsMetadata;
/**
* The timeline result values.
*/
@pageItems
@identifiers(#[])
"value"?: EntityTimelineItem[];
}

/**
* Expansion result metadata.
*/
model TimelineResultsMetadata {
/**
* the total items found for the timeline request
*/
"totalCount": int32;
/**
* timeline aggregation per kind
*/
@identifiers(#[])
"aggregations": TimelineAggregation[];
/**
* information about the failure queries
*/
@identifiers(#[])
"errors"?: TimelineError[];
}

/**
* timeline aggregation information per kind
*/
model TimelineAggregation {
/**
* the total items found for a kind
*/
"count": int32;
/**
* the query kind
*/
"kind": EntityTimelineKind;
}

/**
* Timeline Query Errors.
*/
model TimelineError {
/**
* the query kind
*/
"kind": EntityTimelineKind;
/**
* the query id
*/
"queryId"?: string;
/**
* the error message
*/
"errorMessage": string;
}

/**
* Entity timeline Item.
*/
@discriminator("kind")
model EntityTimelineItem {
/**
* The entity query kind type.
*/
"kind": EntityTimelineKind;
}

/**
* Retrieve queries for entity result operation response.
*/
model GetQueriesResponse {
/**
* The query result values.
*/
@pageItems
"value"?: EntityQueryItem[];
}

/**
* An abstract Query item for entity
*/
@discriminator("kind")
model EntityQueryItem {
/**
* Query Template ARM ID
*/
@visibility(Lifecycle.Read)
"id"?: string;
/**
* Query Template ARM Name
*/
"name"?: string;
/**
* ARM Type
*/
"type"?: string;
/**
* The kind of the entity query
*/
"kind": EntityQueryKind;
}

/**
* The parameters required to execute insights operation on the given entity.
*/
model EntityGetInsightsParameters {
/**
* The start timeline date, so the results returned are after this date.
*/
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"startTime": utcDateTime;
/**
* The end timeline date, so the results returned are before this date.
*/
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"endTime": utcDateTime;
/**
* Indicates if query time range should be extended with default time range of the query. Default value is false
*/
"addDefaultExtendedTimeRange"?: boolean;
/**
* List of Insights Query Id. If empty, default value is all insights of this entity
*/
"insightQueryIds"?: string[];
}

/**
* The Get Insights result operation response.
*/
model EntityGetInsightsResponse {
/**
* The metadata from the get insights operation results.
*/
"metaData"?: GetInsightsResultsMetadata;
/**
* The insights result values.
*/
@pageItems
@identifiers(#[])
"value"?: EntityInsightItem[];
}

/**
* Get Insights result metadata.
*/
model GetInsightsResultsMetadata {
/**
* the total items found for the insights request
*/
"totalCount": int32;
/**
* information about the failed queries
*/
@identifiers(#[])
"errors"?: GetInsightsErrorKind[];
}

/**
* GetInsights Query Errors.
*/
model GetInsightsErrorKind {
/**
* the query kind
*/
"kind": GetInsightsError;
/**
* the query id
*/
"queryId"?: string;
/**
* the error message
*/
"errorMessage": string;
}

/**
* Entity insight Item.
*/
model EntityInsightItem {
/**
* The query id of the insight
*/
"queryId"?: string;
/**
* The Time interval that the query actually executed on.
*/
"queryTimeInterval"?: EntityInsightItemQueryTimeInterval;
/**
* Query results for table insights query.
*/
"tableQueryResults"?: InsightsTableResult;
/**
* Query results for table insights query.
*/
@identifiers(#[])
"chartQueryResults"?: InsightsTableResult[];
}

/**
* The Time interval that the query actually executed on.
*/
model EntityInsightItemQueryTimeInterval {
/**
* Insight query start time
*/
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"startTime"?: utcDateTime;
/**
* Insight query end time
*/
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"endTime"?: utcDateTime;
}

/**
* Query results for table insights query.
*/
model InsightsTableResult {
/**
* Columns Metadata of the table
*/
@identifiers(#[])
"columns"?: InsightsTableResultColumnsItem[];
/**
* Rows data of the table
*/
"rows"?: string[][];
}


#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model InsightsTableResultColumnsItem {
/**
* the type of the colum
*/
"type"?: string;
/**
* the name of the colum
*/
"name"?: string;
}

/**
* List of all the entity queries.
*/
model EntityQueryList is Azure.Core.Page<EntityQuery> {
}

/**
* Specific entity query that supports put requests.
*/
@discriminator("kind")
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model CustomEntityQuery extends ResourceWithEtag {
/**
* the entity query kind
*/
"kind": CustomEntityQueryKind;
}

/**
* List of all the entity query templates.
*/
model EntityQueryTemplateList is Azure.Core.Page<EntityQueryTemplate> {
}

/**
* List all the file imports.
*/
model FileImportList is Azure.Core.Page<FileImport> {
}

/**
* Describes the FileImport's properties
*/
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model FileImportProperties {
/**
* Describes how to ingest the records in the file.
*/
"ingestionMode": IngestionMode;
/**
* The content type of this file.
*/
"contentType": FileImportContentType;
/**
* The time the file was imported.
*/
@visibility(Lifecycle.Read)
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"createdTimeUTC"?: utcDateTime;
/**
* Represents the error file (if the import was ingested with errors or failed the validation).
*/
@visibility(Lifecycle.Read)
"errorFile"?: FileMetadata;
/**
* An ordered list of some of the errors that were encountered during validation.
*/
@visibility(Lifecycle.Read)
@identifiers(#[])
"errorsPreview"?: ValidationError[];
/**
* Represents the imported file.
*/
"importFile": FileMetadata;
/**
* The number of records that have been successfully ingested.
*/
@visibility(Lifecycle.Read)
"ingestedRecordCount"?: int32;
/**
* The source for the data in the file.
*/
"source": string;
/**
* The state of the file import.
*/
@visibility(Lifecycle.Read)
"state"?: FileImportState;
/**
* The number of records in the file.
*/
@visibility(Lifecycle.Read)
"totalRecordCount"?: int32;
/**
* The number of records that have passed validation.
*/
@visibility(Lifecycle.Read)
"validRecordCount"?: int32;
/**
* The time the files associated with this import are deleted from the storage account.
*/
@visibility(Lifecycle.Read)
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"filesValidUntilTimeUTC"?: utcDateTime;
/**
* The time the file import record is soft deleted from the database and history.
*/
@visibility(Lifecycle.Read)
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"importValidUntilTimeUTC"?: utcDateTime;
}

/**
* Represents a file.
*/
model FileMetadata {
/**
* The format of the file
*/
"fileFormat"?: FileFormat;
/**
* The name of the file.
*/
"fileName"?: string;
/**
* The size of the file.
*/
"fileSize"?: int32;
/**
* A URI with a valid SAS token to allow uploading / downloading the file.
*/
@visibility(Lifecycle.Read)
"fileContentUri"?: string;
/**
* Indicates whether the file was deleted from the storage account.
*/
@visibility(Lifecycle.Read)
"deleteStatus"?: DeleteStatus;
}

/**
* Describes an error encountered in the file during validation.
*/
model ValidationError {
/**
* The number of the record that has the error.
*/
"recordIndex"?: int32;
/**
* A list of descriptions of the error.
*/
@visibility(Lifecycle.Read)
"errorMessages"?: string[];
}

/**
* List all the hunts.
*/
model HuntList is Azure.Core.Page<Hunt> {
}

/**
* Describes hunt properties
*/
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model HuntProperties {
/**
* The display name of the hunt
*/
"displayName": string;
/**
* The description of the hunt
*/
"description": string;
/**
* The status of the hunt.
*/
"status"?: Status;
/**
* The hypothesis status of the hunt.
*/
"hypothesisStatus"?: HypothesisStatus = HypothesisStatus.`Unknown`;
/**
* A list of mitre attack tactics the hunt is associated with
*/
"attackTactics"?: AttackTactic[];
/**
* A list of a mitre attack techniques the hunt is associated with
*/
"attackTechniques"?: string[];
/**
* List of labels relevant to this hunt 
*/
"labels"?: string[];
/**
* Describes a user that the hunt is assigned to
*/
"owner"?: HuntOwner;
}

/**
* Describes a user that the hunt is assigned to
*/
model HuntOwner {
/**
* The email of the user the hunt is assigned to.
*/
"email"?: string;
/**
* The name of the user the hunt is assigned to.
*/
"assignedTo"?: string;
/**
* The object id of the user the hunt is assigned to.
*/
#suppress "@azure-tools/typespec-azure-core/no-format"
@format("uuid")
"objectId"?: string;
/**
* The user principal name of the user the hunt is assigned to.
*/
"userPrincipalName"?: string;
/**
* The type of the owner the hunt is assigned to.
*/
"ownerType"?: OwnerType;
}

/**
* List of all the hunt relations
*/
model HuntRelationList is Azure.Core.Page<HuntRelation> {
}

/**
* Describes hunt relation properties
*/
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model HuntRelationProperties {
/**
* The id of the related resource
*/
"relatedResourceId": string;
/**
* The name of the related resource
*/
@visibility(Lifecycle.Read)
"relatedResourceName"?: string;
/**
* The type of the hunt relation
*/
@visibility(Lifecycle.Read)
"relationType"?: string;
/**
* The resource that the relation is related to
*/
@visibility(Lifecycle.Read)
"relatedResourceKind"?: string;
/**
* List of labels relevant to this hunt
*/
"labels"?: string[];
}

/**
* List of all hunt comments
*/
model HuntCommentList is Azure.Core.Page<HuntComment> {
}

/**
* Describes a hunt comment properties
*/
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model HuntCommentProperties {
/**
* The message for the comment
*/
"message": string;
}

/**
* List all the incidents.
*/
model IncidentList is Azure.Core.Page<Incident> {
}

/**
* Describes incident properties
*/
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model IncidentProperties {
/**
* The title of the incident
*/
"title": string;
/**
* The description of the incident
*/
"description"?: string;
/**
* The severity of the incident
*/
"severity": IncidentSeverity;
/**
* The status of the incident
*/
"status": IncidentStatus;
/**
* The reason the incident was closed
*/
"classification"?: IncidentClassification;
/**
* The classification reason the incident was closed with
*/
"classificationReason"?: IncidentClassificationReason;
/**
* Describes the reason the incident was closed
*/
"classificationComment"?: string;
/**
* Describes a user that the incident is assigned to
*/
"owner"?: IncidentOwnerInfo;
/**
* List of labels relevant to this incident
*/
@identifiers(#[])
"labels"?: IncidentLabel[];
/**
* The time of the first activity in the incident
*/
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"firstActivityTimeUtc"?: utcDateTime;
/**
* The time of the last activity in the incident
*/
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"lastActivityTimeUtc"?: utcDateTime;
/**
* The last time the incident was updated
*/
@visibility(Lifecycle.Read)
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"lastModifiedTimeUtc"?: utcDateTime;
/**
* The time the incident was created
*/
@visibility(Lifecycle.Read)
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"createdTimeUtc"?: utcDateTime;
/**
* A sequential number
*/
@visibility(Lifecycle.Read)
"incidentNumber"?: int32;
/**
* Additional data on the incident
*/
@visibility(Lifecycle.Read)
"additionalData"?: IncidentAdditionalData;
/**
* List of resource ids of Analytic rules related to the incident
*/
@visibility(Lifecycle.Read)
@identifiers(#[])
"relatedAnalyticRuleIds"?: Azure.Core.armResourceIdentifier<[{type: "Microsoft.SecurityInsights/alertRules";}]>[];
/**
* The deep-link url to the incident in Azure portal
*/
@visibility(Lifecycle.Read)
"incidentUrl"?: string;
/**
* The name of the source provider that generated the incident
*/
@visibility(Lifecycle.Read)
"providerName"?: string;
/**
* The incident ID assigned by the incident provider
*/
@visibility(Lifecycle.Read)
"providerIncidentId"?: string;
/**
* Describes a team for the incident
*/
"teamInformation"?: TeamInformation;
}

/**
* Information on the user an incident is assigned to
*/
model IncidentOwnerInfo {
/**
* The email of the user the incident is assigned to.
*/
"email"?: string;
/**
* The name of the user the incident is assigned to.
*/
"assignedTo"?: string;
/**
* The object id of the user the incident is assigned to.
*/
#suppress "@azure-tools/typespec-azure-core/no-format"
@format("uuid")
"objectId"?: string;
/**
* The user principal name of the user the incident is assigned to.
*/
"userPrincipalName"?: string;
/**
* The type of the owner the incident is assigned to.
*/
"ownerType"?: OwnerType;
}

/**
* Represents an incident label
*/
model IncidentLabel {
/**
* The name of the label
*/
"labelName": string;
/**
* The type of the label
*/
@visibility(Lifecycle.Read)
"labelType"?: IncidentLabelType;
}

/**
* Incident additional data property bag.
*/
model IncidentAdditionalData {
/**
* The number of alerts in the incident
*/
@visibility(Lifecycle.Read)
"alertsCount"?: int32;
/**
* The number of bookmarks in the incident
*/
@visibility(Lifecycle.Read)
"bookmarksCount"?: int32;
/**
* The number of comments in the incident
*/
@visibility(Lifecycle.Read)
"commentsCount"?: int32;
/**
* List of product names of alerts in the incident
*/
@visibility(Lifecycle.Read)
@identifiers(#[])
"alertProductNames"?: string[];
/**
* The tactics associated with incident
*/
@visibility(Lifecycle.Read)
@identifiers(#[])
"tactics"?: AttackTactic[];
/**
* The techniques associated with incident's tactics
*/
@visibility(Lifecycle.Read)
"techniques"?: string[];
/**
* The provider incident url to the incident in Microsoft 365 Defender portal
*/
@visibility(Lifecycle.Read)
"providerIncidentUrl"?: string;
/**
* The incident number of the incident that the current incident was merged into
*/
@visibility(Lifecycle.Read)
"mergedIncidentNumber"?: string;
/**
* The URL to the incident that the current incident was merged into
*/
@visibility(Lifecycle.Read)
"mergedIncidentUrl"?: string;
}

/**
* Describes team information
*/
model TeamInformation {
/**
* Team ID
*/
@visibility(Lifecycle.Read)
"teamId"?: string;
/**
* The primary channel URL of the team
*/
@visibility(Lifecycle.Read)
"primaryChannelUrl"?: string;
/**
* The time the team was created
*/
@visibility(Lifecycle.Read)
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"teamCreationTimeUtc"?: utcDateTime;
/**
* The name of the team
*/
@visibility(Lifecycle.Read)
"name"?: string;
/**
* The description of the team
*/
@visibility(Lifecycle.Read)
"description"?: string;
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
"value": SecurityAlert[];
}

/**
* Represents a security alert entity.
*/
model SecurityAlert extends Entity {
/**
* SecurityAlert entity properties
*/
"properties"?: SecurityAlertProperties;
/**
* The kind of the entity.
*/
"kind": "SecurityAlert";
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
"alertDisplayName"?: string;
/**
* The type name of the alert.
*/
@visibility(Lifecycle.Read)
"alertType"?: string;
/**
* Display name of the main entity being reported on.
*/
@visibility(Lifecycle.Read)
"compromisedEntity"?: string;
/**
* The confidence level of this alert.
*/
@visibility(Lifecycle.Read)
"confidenceLevel"?: ConfidenceLevel;
/**
* The confidence reasons
*/
@visibility(Lifecycle.Read)
@identifiers(#[])
"confidenceReasons"?: SecurityAlertPropertiesConfidenceReasonsItem[];
/**
* The confidence score of the alert.
*/
@visibility(Lifecycle.Read)
"confidenceScore"?: float64;
/**
* The confidence score calculation status, i.e. indicating if score calculation is pending for this alert, not applicable or final.
*/
@visibility(Lifecycle.Read)
"confidenceScoreStatus"?: ConfidenceScoreStatus;
/**
* Alert description.
*/
@visibility(Lifecycle.Read)
"description"?: string;
/**
* The impact end time of the alert (the time of the last event contributing to the alert).
*/
@visibility(Lifecycle.Read)
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"endTimeUtc"?: utcDateTime;
/**
* Holds the alert intent stage(s) mapping for this alert.
*/
@visibility(Lifecycle.Read)
"intent"?: KillChainIntent;
/**
* The identifier of the alert inside the product which generated the alert.
*/
@visibility(Lifecycle.Read)
"providerAlertId"?: string;
/**
* The time the alert was made available for consumption.
*/
@visibility(Lifecycle.Read)
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"processingEndTime"?: utcDateTime;
/**
* The name of a component inside the product which generated the alert.
*/
@visibility(Lifecycle.Read)
"productComponentName"?: string;
/**
* The name of the product which published this alert.
*/
@visibility(Lifecycle.Read)
"productName"?: string;
/**
* The version of the product generating the alert.
*/
@visibility(Lifecycle.Read)
"productVersion"?: string;
/**
* Manual action items to take to remediate the alert.
*/
@visibility(Lifecycle.Read)
@identifiers(#[])
"remediationSteps"?: string[];
/**
* The severity of the alert
*/
"severity"?: AlertSeverity;
/**
* The impact start time of the alert (the time of the first event contributing to the alert).
*/
@visibility(Lifecycle.Read)
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"startTimeUtc"?: utcDateTime;
/**
* The lifecycle status of the alert.
*/
@visibility(Lifecycle.Read)
"status"?: AlertStatus;
/**
* Holds the product identifier of the alert for the product.
*/
@visibility(Lifecycle.Read)
"systemAlertId"?: string;
/**
* The tactics of the alert
*/
@visibility(Lifecycle.Read)
@identifiers(#[])
"tactics"?: AttackTactic[];
/**
* The time the alert was generated.
*/
@visibility(Lifecycle.Read)
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"timeGenerated"?: utcDateTime;
/**
* The name of the vendor that raise the alert.
*/
@visibility(Lifecycle.Read)
"vendorName"?: string;
/**
* The uri link of the alert.
*/
@visibility(Lifecycle.Read)
"alertLink"?: string;
/**
* The list of resource identifiers of the alert.
*/
@visibility(Lifecycle.Read)
@identifiers(#[])
"resourceIdentifiers"?: unknown[];
}

/**
* confidence reason item
*/
model SecurityAlertPropertiesConfidenceReasonsItem {
/**
* The reason's description
*/
@visibility(Lifecycle.Read)
"reason"?: string;
/**
* The type (category) of the reason
*/
@visibility(Lifecycle.Read)
"reasonType"?: string;
}

/**
* Entity common property bag.
*/
model EntityCommonProperties {
/**
* A bag of custom fields that should be part of the entity and will be presented to the user.
*/
@visibility(Lifecycle.Read)
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
"additionalData"?: Record<unknown>;
/**
* The graph item display name which is a short humanly readable description of the graph item instance. This property is optional and might be system generated.
*/
@visibility(Lifecycle.Read)
"friendlyName"?: string;
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
"value": HuntingBookmark[];
}

/**
* Represents a Hunting bookmark entity.
*/
model HuntingBookmark extends Entity {
/**
* HuntingBookmark entity properties
*/
"properties"?: HuntingBookmarkProperties;
/**
* The kind of the entity.
*/
"kind": "Bookmark";
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
"created"?: utcDateTime;
/**
* Describes a user that created the bookmark
*/
"createdBy"?: UserInfo;
/**
* The display name of the bookmark
*/
"displayName": string;
/**
* The time of the event
*/
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"eventTime"?: utcDateTime;
/**
* List of labels relevant to this bookmark
*/
@identifiers(#[])
"labels"?: string[];
/**
* The notes of the bookmark
*/
"notes"?: string;
/**
* The query of the bookmark.
*/
"query": string;
/**
* The query result of the bookmark.
*/
"queryResult"?: string;
/**
* The last time the bookmark was updated
*/
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"updated"?: utcDateTime;
/**
* Describes a user that updated the bookmark
*/
"updatedBy"?: UserInfo;
/**
* Describes an incident that relates to bookmark
*/
"incidentInfo"?: IncidentInfo;
}

/**
* List of incident comments.
*/
model IncidentCommentList is Azure.Core.Page<IncidentComment> {
}

/**
* Incident comment property bag.
*/
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model IncidentCommentProperties {
/**
* The comment message
*/
"message": string;
/**
* The time the comment was created
*/
@visibility(Lifecycle.Read)
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"createdTimeUtc"?: utcDateTime;
/**
* The time the comment was updated
*/
@visibility(Lifecycle.Read)
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"lastModifiedTimeUtc"?: utcDateTime;
/**
* Describes the client that created the comment
*/
@visibility(Lifecycle.Read)
"author"?: ClientInfo;
}

/**
* The incident related entities response.
*/
model IncidentEntitiesResponse {
/**
* Array of the incident related entities.
*/
@identifiers(#[])
"entities"?: Entity[];
/**
* The metadata from the incident related entities results.
*/
@identifiers(#[])
"metaData"?: IncidentEntitiesResultsMetadata[];
}

/**
* Information of a specific aggregation in the incident related entities result.
*/
model IncidentEntitiesResultsMetadata {
/**
* The kind of the aggregated entity.
*/
"entityKind": EntityKindEnum;
/**
* Total number of aggregations of the given kind in the incident related entities result.
*/
"count": int32;
}

/**
* List of incident tasks
*/
model IncidentTaskList is Azure.Core.Page<IncidentTask> {
}

/**
* Describes the properties of an incident task
*/
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model IncidentTaskProperties {
/**
* The title of the task
*/
"title": string;
/**
* The description of the task
*/
"description"?: string;
/**
* The status of the task
*/
"status": IncidentTaskStatus;
/**
* The time the task was created
*/
@visibility(Lifecycle.Read)
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"createdTimeUtc"?: utcDateTime;
/**
* The last time the task was updated
*/
@visibility(Lifecycle.Read)
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"lastModifiedTimeUtc"?: utcDateTime;
/**
* Information on the client (user or application) that made some action
*/
"createdBy"?: ClientInfo;
/**
* Information on the client (user or application) that made some action
*/
"lastModifiedBy"?: ClientInfo;
}

/**
* List of all the metadata.
*/
model MetadataList is Azure.Core.Page<MetadataModel> {
}

/**
* Metadata property bag.
*/
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model MetadataProperties {
/**
* Static ID for the content.  Used to identify dependencies and content from solutions or community.  Hard-coded/static for out of the box content and solutions. Dynamic for user-created.  This is the resource name
*/
"contentId"?: string;
/**
* Full parent resource ID of the content item the metadata is for.  This is the full resource ID including the scope (subscription and resource group)
*/
"parentId": string;
/**
* Version of the content.  Default and recommended format is numeric (e.g. 1, 1.0, 1.0.0, 1.0.0.0), following ARM template best practices.  Can also be any string, but then we cannot guarantee any version checks
*/
"version"?: string;
/**
* The kind of content the metadata is for.
*/
"kind": string;
/**
* Source of the content.  This is where/how it was created.
*/
"source"?: MetadataSource;
/**
* The creator of the content item.
*/
"author"?: MetadataAuthor;
/**
* Support information for the metadata - type, name, contact information
*/
"support"?: MetadataSupport;
/**
* Dependencies for the content item, what other content items it requires to work.  Can describe more complex dependencies using a recursive/nested structure. For a single dependency an id/kind/version can be supplied or operator/criteria for complex formats.
*/
"dependencies"?: MetadataDependencies;
/**
* Categories for the solution content item
*/
"categories"?: MetadataCategories;
/**
* Providers for the solution content item
*/
"providers"?: string[];
/**
* first publish date solution content item
*/
"firstPublishDate"?: plainDate;
/**
* last publish date for the solution content item
*/
"lastPublishDate"?: plainDate;
/**
* The custom version of the content. A optional free text
*/
"customVersion"?: string;
/**
* Schema version of the content. Can be used to distinguish between different flow based on the schema version
*/
"contentSchemaVersion"?: string;
/**
* the icon identifier. this id can later be fetched from the solution template
*/
"icon"?: string;
/**
* the tactics the resource covers
*/
"threatAnalysisTactics"?: string[];
/**
* the techniques the resource covers, these have to be aligned with the tactics being used
*/
"threatAnalysisTechniques"?: string[];
/**
* preview image file names. These will be taken from the solution artifacts
*/
"previewImages"?: string[];
/**
* preview image file names. These will be taken from the solution artifacts. used for dark theme support
*/
"previewImagesDark"?: string[];
}

/**
* Metadata patch request body.
*/
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model MetadataPatch extends ResourceWithEtag {
/**
* Metadata patch request body
*/
"properties"?: MetadataPropertiesPatch;
}

/**
* Metadata property bag for patch requests.  This is the same as the MetadataProperties, but with nothing required
*/
model MetadataPropertiesPatch {
/**
* Static ID for the content.  Used to identify dependencies and content from solutions or community.  Hard-coded/static for out of the box content and solutions. Dynamic for user-created.  This is the resource name
*/
"contentId"?: string;
/**
* Full parent resource ID of the content item the metadata is for.  This is the full resource ID including the scope (subscription and resource group)
*/
"parentId"?: string;
/**
* Version of the content.  Default and recommended format is numeric (e.g. 1, 1.0, 1.0.0, 1.0.0.0), following ARM template best practices.  Can also be any string, but then we cannot guarantee any version checks
*/
"version"?: string;
/**
* The kind of content the metadata is for.
*/
"kind"?: string;
/**
* Source of the content.  This is where/how it was created.
*/
"source"?: MetadataSource;
/**
* The creator of the content item.
*/
"author"?: MetadataAuthor;
/**
* Support information for the metadata - type, name, contact information
*/
"support"?: MetadataSupport;
/**
* Dependencies for the content item, what other content items it requires to work.  Can describe more complex dependencies using a recursive/nested structure. For a single dependency an id/kind/version can be supplied or operator/criteria for complex formats.
*/
"dependencies"?: MetadataDependencies;
/**
* Categories for the solution content item
*/
"categories"?: MetadataCategories;
/**
* Providers for the solution content item
*/
"providers"?: string[];
/**
* first publish date solution content item
*/
"firstPublishDate"?: plainDate;
/**
* last publish date for the solution content item
*/
"lastPublishDate"?: plainDate;
/**
* The custom version of the content. A optional free text
*/
"customVersion"?: string;
/**
* Schema version of the content. Can be used to distinguish between different flow based on the schema version
*/
"contentSchemaVersion"?: string;
/**
* the icon identifier. this id can later be fetched from the solution template
*/
"icon"?: string;
/**
* the tactics the resource covers
*/
"threatAnalysisTactics"?: string[];
/**
* the techniques the resource covers, these have to be aligned with the tactics being used
*/
"threatAnalysisTechniques"?: string[];
/**
* preview image file names. These will be taken from the solution artifacts
*/
"previewImages"?: string[];
/**
* preview image file names. These will be taken from the solution artifacts. used for dark theme support
*/
"previewImagesDark"?: string[];
}

/**
* List of all the office365 consents.
*/
model OfficeConsentList is Azure.Core.Page<OfficeConsent> {
}

/**
* Consent property bag.
*/
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model OfficeConsentProperties {
/**
* The tenantId of the Office365 with the consent.
*/
"tenantId"?: string;
/**
* Help to easily cascade among the data layers.
*/
"consentId"?: string;
}

/**
* The Sentinel onboarding state properties
*/
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model SentinelOnboardingStateProperties {
/**
* Flag that indicates the status of the CMK setting
*/
"customerManagedKey"?: boolean;
}

/**
* List of the Sentinel onboarding states
*/
model SentinelOnboardingStatesList {
/**
* Array of Sentinel onboarding states
*/
@pageItems
"value": SentinelOnboardingState[];
}

/**
* Operation provided by provider
*/
model Operation {
/**
* Properties of the operation
*/
"display"?: OperationDisplay;
/**
* Name of the operation
*/
"name"?: string;
/**
* The origin of the operation
*/
"origin"?: string;
/**
* Indicates whether the operation is a data action
*/
"isDataAction"?: boolean;
}

/**
* Properties of the operation
*/
model OperationDisplay {
/**
* Description of the operation
*/
"description"?: string;
/**
* Operation name
*/
"operation"?: string;
/**
* Provider name
*/
"provider"?: string;
/**
* Resource name
*/
"resource"?: string;
}

/**
* A list of recommendations
*/
model RecommendationList is Azure.Core.Page<Recommendation> {
}

/**
* Recommendation properties object.
*/
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model RecommendationProperties {
/**
* Id of the recommendation type.
*/
"recommendationTypeId": string;
/**
* State of the recommendation.
*/
"state": State;
/**
* Title of the recommendation.
*/
"title": string;
/**
* Description of the recommendation.
*/
"description": string;
/**
* The time stamp (UTC) when the recommendation was created.
*/
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"creationTimeUtc": utcDateTime;
/**
* The time stamp (UTC) when the recommendation was last evaluated.
*/
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"lastEvaluatedTimeUtc": utcDateTime;
/**
* The time stamp (UTC) when the recommendation was last modified.
*/
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"lastModifiedTimeUtc": utcDateTime;
/**
* List of suggestions to take for this recommendation.
*/
@identifiers(#[])
"suggestions": RecommendedSuggestion[];
/**
* Id of the resource this recommendation refers to.
*/
"resourceId"?: string;
/**
* Collection of additional properties for the recommendation.
*/
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
"additionalProperties"?: Record<string>;
}

/**
* What suggestions should be taken to complete the recommendation.
*/
model RecommendedSuggestion {
/**
* Id of the suggestion type.
*/
"suggestionTypeId": string;
/**
* Title of the suggestion.
*/
"title": string;
/**
* Description of the suggestion.
*/
"description": string;
/**
* Action of the suggestion.
*/
"action": string;
/**
* Collection of additional properties for the suggestion.
*/
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
"additionalProperties"?: Record<string>;
}

/**
* Recommendation Fields to update.
*/
model RecommendationPatch {
/**
* Recommendation Fields Properties to update.
*/
"properties"?: RecommendationPatchProperties;
}

/**
* Recommendation Fields Properties to update.
*/
model RecommendationPatchProperties {
/**
* State of the recommendation.
*/
"state"?: State;
}

/**
* Reevaluate response object.
*/
model ReevaluateResponse {
/**
* The time stamp (UTC) when the recommendation was last evaluated.
*/
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"lastEvaluatedTimeUtc"?: utcDateTime;
}

/**
* List all the SecurityMLAnalyticsSettings
*/
model SecurityMLAnalyticsSettingsList is Azure.Core.Page<SecurityMLAnalyticsSetting> {
}

/**
* List of all the settings.
*/
model SettingList is Azure.Core.Page<Settings> {
}

/**
* Credentials to access repository.
*/
model RepositoryAccessProperties {
/**
* RepositoryAccess properties
*/
"properties": RepositoryAccessObject;
}

/**
* Credentials to access repository.
*/
model RepositoryAccessObject {
/**
* RepositoryAccess properties
*/
"repositoryAccess": RepositoryAccess;
}

/**
* Credentials to access repository.
*/
model RepositoryAccess {
/**
* The kind of repository access credentials
*/
"kind": RepositoryAccessKind;
/**
* OAuth Code. Required when `kind` is `OAuth`
*/
"code"?: string;
/**
* OAuth State. Required when `kind` is `OAuth`
*/
"state"?: string;
/**
* OAuth ClientId. Required when `kind` is `OAuth`
*/
"clientId"?: string;
/**
* Personal Access Token. Required when `kind` is `PAT`
*/
"token"?: string;
/**
* Application installation ID. Required when `kind` is `App`. Supported by `GitHub` only.
*/
"installationId"?: string;
}

/**
* List all the source controls.
*/
model RepoList is Azure.Core.Page<Repo> {
}

/**
* Represents a repository.
*/
model Repo {
/**
* The url to access the repository.
*/
"url"?: string;
/**
* The name of the repository.
*/
"fullName"?: string;
/**
* The installation id of the repository.
*/
"installationId"?: int64;
/**
* Array of branches.
*/
"branches"?: string[];
}

/**
* List all the source controls.
*/
model SourceControlList is Azure.Core.Page<SourceControl> {
}

/**
* Describes source control properties
*/
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model SourceControlProperties {
/**
* The id (a Guid) of the source control
*/
@visibility(Lifecycle.Read)
"id"?: string;
/**
* The version number associated with the source control
*/
@visibility(Lifecycle.Read)
"version"?: Version;
/**
* The display name of the source control
*/
"displayName": string;
/**
* A description of the source control
*/
"description"?: string;
/**
* The repository type of the source control
*/
"repoType": RepoType;
/**
* Array of source control content types.
*/
"contentTypes": ContentType[];
/**
* Repository metadata.
*/
"repository": Repository;
/**
* Service principal metadata.
*/
"servicePrincipal"?: ServicePrincipal;
/**
* Workload Identity metadata.
*/
@visibility(Lifecycle.Read)
"workloadIdentityFederation"?: WorkloadIdentityFederation;
/**
* Repository access credentials. This is write-only object and it never returns back to a user.
*/
@visibility(Lifecycle.Create, Lifecycle.Update)
"repositoryAccess"?: RepositoryAccess;
/**
* Information regarding the resources created in user's repository.
*/
"repositoryResourceInfo"?: RepositoryResourceInfo;
/**
* Information regarding the latest deployment for the source control.
*/
@visibility(Lifecycle.Read)
"lastDeploymentInfo"?: DeploymentInfo;
/**
* Information regarding the pull request of the source control.
*/
@visibility(Lifecycle.Read)
"pullRequest"?: PullRequest;
}

/**
* metadata of a repository.
*/
model Repository {
/**
* Url of repository.
*/
"url": string;
/**
* Branch name of repository.
*/
"branch": string;
/**
* Display url of repository.
*/
"displayUrl"?: string;
/**
* Url to access repository action logs.
*/
@visibility(Lifecycle.Read)
"deploymentLogsUrl"?: string;
}

/**
* Service principal metadata.
*/
model ServicePrincipal {
/**
* Id of service principal.
*/
@visibility(Lifecycle.Read)
"id"?: string;
/**
* Tenant id of service principal.
*/
@visibility(Lifecycle.Read)
"tenantId"?: string;
/**
* App id of service principal.
*/
@visibility(Lifecycle.Read)
"appId"?: string;
/**
* Expiration time of service principal credentials.
*/
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"credentialsExpireOn"?: utcDateTime;
}

/**
* Workload Identity Federation metadata.
*/
model WorkloadIdentityFederation {
/**
* Id of Workload Identity Federation.
*/
@visibility(Lifecycle.Read)
"id"?: string;
/**
* Tenant id of Workload Identity Federation.
*/
@visibility(Lifecycle.Read)
"tenantId"?: string;
/**
* App id of Workload Identity Federation.
*/
@visibility(Lifecycle.Read)
"appId"?: string;
/**
* Subject of Workload Identity Federation.
*/
@visibility(Lifecycle.Read)
"subject"?: string;
/**
* Issuer of Workload Identity Federation.
*/
@visibility(Lifecycle.Read)
"issuer"?: string;
}

/**
* Resources created in user's repository for the source-control.
*/
model RepositoryResourceInfo {
/**
* The webhook object created for the source-control.
*/
"webhook"?: Webhook;
/**
* Resources created in GitHub for this source-control.
*/
@visibility(Lifecycle.Read)
"gitHubResourceInfo"?: GitHubResourceInfo;
/**
* Resources created in Azure DevOps for this source-control.
*/
@visibility(Lifecycle.Read)
"azureDevOpsResourceInfo"?: AzureDevOpsResourceInfo;
}

/**
* Detail about the webhook object.
*/
model Webhook {
/**
* Unique identifier for the webhook.
*/
@visibility(Lifecycle.Read)
"webhookId"?: string;
/**
* URL that gets invoked by the webhook.
*/
@visibility(Lifecycle.Read)
"webhookUrl"?: string;
/**
* Time when the webhook secret was updated.
*/
@visibility(Lifecycle.Read)
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"webhookSecretUpdateTime"?: utcDateTime;
/**
* A flag to instruct the backend service to rotate webhook secret.
*/
"rotateWebhookSecret"?: boolean;
}

/**
* Resources created in GitHub repository.
*/
model GitHubResourceInfo {
/**
* GitHub application installation id.
*/
"appInstallationId"?: string;
}

/**
* Resources created in Azure DevOps repository.
*/
model AzureDevOpsResourceInfo {
/**
* Id of the pipeline created for the source-control.
*/
"pipelineId"?: string;
/**
* Id of the service-connection created for the source-control.
*/
"serviceConnectionId"?: string;
}

/**
* Information regarding a deployment.
*/
model DeploymentInfo {
/**
* Status while fetching the last deployment.
*/
"deploymentFetchStatus"?: DeploymentFetchStatus;
/**
* Deployment information.
*/
"deployment"?: Deployment;
/**
* Additional details about the deployment that can be shown to the user.
*/
"message"?: string;
}

/**
* Description about a deployment.
*/
model Deployment {
/**
* Deployment identifier.
*/
"deploymentId"?: string;
/**
* Current status of the deployment.
*/
"deploymentState"?: DeploymentState;
/**
* The outcome of the deployment.
*/
"deploymentResult"?: DeploymentResult;
/**
* The time when the deployment finished.
*/
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"deploymentTime"?: utcDateTime;
/**
* Url to access repository action logs.
*/
"deploymentLogsUrl"?: string;
}

/**
* Information regarding pull request for protected branches.
*/
model PullRequest {
/**
* URL of pull request
*/
@visibility(Lifecycle.Read)
"url"?: string;
/**
* State of the pull request
*/
@visibility(Lifecycle.Read)
"state"?: State;
}

/**
* Warning response structure.
*/
model Warning {
/**
* Warning data.
*/
@visibility(Lifecycle.Read)
"warning"?: WarningBody;
}

/**
* Warning details.
*/
model WarningBody {
/**
* An identifier for the warning. Codes are invariant and are intended to be consumed programmatically.
*/
@visibility(Lifecycle.Read)
"code"?: WarningCode;
/**
* A message describing the warning, intended to be suitable for display in a user interface.
*/
@visibility(Lifecycle.Read)
"message"?: string;
@visibility(Lifecycle.Read)
@identifiers(#[])
#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
"details"?: WarningBody[];
}

/**
* Threat intelligence indicator entity.
*/
model ThreatIntelligenceIndicatorModel extends ThreatIntelligenceInformation {
/**
* Threat Intelligence Entity properties
*/
"properties"?: ThreatIntelligenceIndicatorProperties;
/**
* The kind of the entity.
*/
"kind": "indicator";
}

/**
* Describes threat intelligence entity properties
*/
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ThreatIntelligenceIndicatorProperties extends EntityCommonProperties {
/**
* List of tags
*/
@identifiers(#[])
"threatIntelligenceTags"?: string[];
/**
* Last updated time in UTC
*/
"lastUpdatedTimeUtc"?: string;
/**
* Source of a threat intelligence entity
*/
"source"?: string;
/**
* Display name of a threat intelligence entity
*/
"displayName"?: string;
/**
* Description of a threat intelligence entity
*/
"description"?: string;
/**
* Indicator types of threat intelligence entities
*/
@identifiers(#[])
"indicatorTypes"?: string[];
/**
* Pattern of a threat intelligence entity
*/
"pattern"?: string;
/**
* Pattern type of a threat intelligence entity
*/
"patternType"?: string;
/**
* Pattern version of a threat intelligence entity
*/
"patternVersion"?: string;
/**
* Kill chain phases
*/
@identifiers(#[])
"killChainPhases"?: ThreatIntelligenceKillChainPhase[];
/**
* Parsed patterns
*/
@identifiers(#[])
"parsedPattern"?: ThreatIntelligenceParsedPattern[];
/**
* External ID of threat intelligence entity
*/
"externalId"?: string;
/**
* Created by reference of threat intelligence entity
*/
"createdByRef"?: string;
/**
* Is threat intelligence entity defanged
*/
"defanged"?: boolean;
/**
* External last updated time in UTC
*/
"externalLastUpdatedTimeUtc"?: string;
/**
* External References
*/
@identifiers(#[])
"externalReferences"?: ThreatIntelligenceExternalReference[];
/**
* Granular Markings
*/
@identifiers(#[])
"granularMarkings"?: ThreatIntelligenceGranularMarkingModel[];
/**
* Labels  of threat intelligence entity
*/
@identifiers(#[])
"labels"?: string[];
/**
* Is threat intelligence entity revoked
*/
"revoked"?: boolean;
/**
* Confidence of threat intelligence entity
*/
"confidence"?: int32;
/**
* Threat intelligence entity object marking references
*/
@identifiers(#[])
"objectMarkingRefs"?: string[];
/**
* Language of threat intelligence entity
*/
"language"?: string;
/**
* Threat types
*/
@identifiers(#[])
"threatTypes"?: string[];
/**
* Valid from
*/
"validFrom"?: string;
/**
* Valid until
*/
"validUntil"?: string;
/**
* Created by
*/
"created"?: string;
/**
* Modified by
*/
"modified"?: string;
/**
* Extensions map
*/
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
"extensions"?: Record<unknown>;
}

/**
* Describes threat kill chain phase entity
*/
model ThreatIntelligenceKillChainPhase {
/**
* Kill chainName name
*/
"killChainName"?: string;
/**
* Phase name
*/
"phaseName"?: string;
}

/**
* Describes parsed pattern entity
*/
model ThreatIntelligenceParsedPattern {
/**
* Pattern type key
*/
"patternTypeKey"?: string;
/**
* Pattern type keys
*/
@identifiers(#[])
"patternTypeValues"?: ThreatIntelligenceParsedPatternTypeValue[];
}

/**
* Describes threat kill chain phase entity
*/
model ThreatIntelligenceParsedPatternTypeValue {
/**
* Type of the value
*/
"valueType"?: string;
/**
* Value of parsed pattern
*/
"value"?: string;
}

/**
* Describes external reference
*/
model ThreatIntelligenceExternalReference {
/**
* External reference description
*/
"description"?: string;
/**
* External reference ID
*/
"externalId"?: string;
/**
* External reference source name
*/
"sourceName"?: string;
/**
* External reference URL
*/
"url"?: string;
/**
* External reference hashes
*/
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
"hashes"?: Record<string>;
}

/**
* Describes threat granular marking model entity
*/
model ThreatIntelligenceGranularMarkingModel {
/**
* Language granular marking model
*/
"language"?: string;
/**
* marking reference granular marking model
*/
"markingRef"?: int32;
/**
* granular marking model selectors
*/
@identifiers(#[])
"selectors"?: string[];
}

/**
* List of all the threat intelligence information objects.
*/
model ThreatIntelligenceInformationList is Azure.Core.Page<ThreatIntelligenceInformation> {
}

/**
* Filtering criteria for querying threat intelligence indicators.
*/
model ThreatIntelligenceFilteringCriteria {
/**
* Page size
*/
"pageSize"?: int32;
/**
* Minimum confidence.
*/
"minConfidence"?: int32;
/**
* Maximum confidence.
*/
"maxConfidence"?: int32;
/**
* Start time for ValidUntil filter.
*/
"minValidUntil"?: string;
/**
* End time for ValidUntil filter.
*/
"maxValidUntil"?: string;
/**
* Parameter to include/exclude disabled indicators.
*/
"includeDisabled"?: boolean;
/**
* Columns to sort by and sorting order
*/
@identifiers(#[])
"sortBy"?: ThreatIntelligenceSortingCriteria[];
/**
* Sources of threat intelligence indicators
*/
@identifiers(#[])
"sources"?: string[];
/**
* Pattern types
*/
@identifiers(#[])
"patternTypes"?: string[];
/**
* Threat types of threat intelligence indicators
*/
@identifiers(#[])
"threatTypes"?: string[];
/**
* Ids of threat intelligence indicators
*/
@identifiers(#[])
"ids"?: string[];
/**
* Keywords for searching threat intelligence indicators
*/
@identifiers(#[])
"keywords"?: string[];
/**
* Skip token.
*/
"skipToken"?: string;
}

/**
* List of available columns for sorting
*/
model ThreatIntelligenceSortingCriteria {
/**
* Column name
*/
"itemKey"?: string;
/**
* Sorting order (ascending/descending/unsorted).
*/
"sortOrder"?: ThreatIntelligenceSortingOrder;
}

/**
* List of all the threat intelligence metric fields (type/threat type/source).
*/
model ThreatIntelligenceMetricsList {
/**
* Array of threat intelligence metric fields (type/threat type/source).
*/
@identifiers(#[])
"value": ThreatIntelligenceMetrics[];
}

/**
* Threat intelligence metrics.
*/
model ThreatIntelligenceMetrics {
/**
* Threat intelligence metrics.
*/
"properties"?: ThreatIntelligenceMetric;
}

/**
* Describes threat intelligence metric
*/
model ThreatIntelligenceMetric {
/**
* Last updated indicator metric
*/
"lastUpdatedTimeUtc"?: string;
/**
* Threat type metrics
*/
@identifiers(#[])
"threatTypeMetrics"?: ThreatIntelligenceMetricEntity[];
/**
* Pattern type metrics
*/
@identifiers(#[])
"patternTypeMetrics"?: ThreatIntelligenceMetricEntity[];
/**
* Source metrics
*/
@identifiers(#[])
"sourceMetrics"?: ThreatIntelligenceMetricEntity[];
}

/**
* Describes threat intelligence metric entity
*/
model ThreatIntelligenceMetricEntity {
/**
* Metric name
*/
"metricName"?: string;
/**
* Metric value
*/
"metricValue"?: int32;
}

/**
* Array of tags to be appended to the threat intelligence indicator.
*/
model ThreatIntelligenceAppendTags {
/**
* List of tags to be appended.
*/
@identifiers(#[])
"threatIntelligenceTags"?: string[];
}

/**
* Represents a query to run on the TI objects in the workspace.
*/
model CountQuery {
/**
* Query properties
*/
"properties"?: QueryProperties;
}

/**
* Describes the query properties
*/
model QueryProperties {
/**
* Represents a condition used to query for TI objects.
*/
"condition"?: ConditionProperties;
}

/**
* Represents a condition used to query for TI objects.
*/
model ConditionProperties {
/**
* The STIX type for the objects returned by this query.
*/
@visibility(Lifecycle.Read)
"stixObjectType"?: string;
/**
* The list of clauses to be evaluated in disjunction or conjunction base on the specified top level connective operator.
*/
"clauses": ConditionClause[];
/**
* The top level connective operator for this condition.
*/
"conditionConnective"?: Connective;
}

/**
* Represents a single clause to be evaluated by a NormalizedCondition.
*/
model ConditionClause {
/**
* The connective used to join all values in this ConditionClause
*/
"clauseConnective"?: Connective;
/**
* The name of the field that is evaluated.
*/
"field": string;
/**
* Represents an operator in a ConditionClause.
*/
"operator": Operator;
/**
* The top level connective operator for this condition.
*/
"values": string[];
}

/**
* Count of all the threat intelligence objects on the workspace that match the provided query.
*/
model ThreatIntelligenceCount {
/**
* Count of all the threat intelligence objects on the workspace that match the provided query.
*/
@visibility(Lifecycle.Read)
"count": int32;
}

/**
* Represents a query to run on the TI objects in the workspace.
*/
model Query {
/**
* Represents a condition used to query for TI objects.
*/
"condition"?: QueryCondition;
/**
* Specifies how to sort the query results.
*/
"sortBy"?: QuerySortBy;
/**
* Represents the maximum size of the page that will be returned from the query API.
*/
"maxPageSize"?: int32;
/**
* Represents the minimum size of the page that will be returned from the query API.
*/
"minPageSize"?: int32;
}

/**
* Represents a condition used to query for TI objects.
*/
model QueryCondition {
/**
* The STIX type for the objects returned by this query.
*/
"stixObjectType"?: string;
/**
* The list of clauses to be evaluated in disjunction or conjunction base on the specified top level connective operator.
*/
"clauses": ConditionClause[];
/**
* The top level connective operator for this condition.
*/
"conditionConnective"?: Connective;
}

/**
* Specifies how to sort the query results.
*/
model QuerySortBy {
/**
* The direction to sort the results by.
*/
"direction"?: SortingDirection;
/**
* Represents the field to sort the results by.
*/
"field"?: string;
}

/**
* List all the threat intelligence objects on the workspace that match the provided query.
*/
model ThreatIntelligenceList is Azure.Core.Page<TIObject> {
}

/**
* Represents a threat intelligence object in Azure Security Insights.
*/
@discriminator("kind")
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model TIObject extends Azure.ResourceManager.CommonTypes.Resource {
/**
* The properties of the TI object
*/
"properties"?: TIObjectCommonProperties;
/**
* The kind of the TI object
*/
"kind": TIObjectKind;
}

/**
* Describes properties common to all threat intelligence objects
*/
model TIObjectCommonProperties {
/**
* The core STIX object that this TI object represents.
*/
@visibility(Lifecycle.Read)
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
"data"?: Record<unknown>;
/**
* The UserInfo of the user/entity which originally created this TI object.
*/
@visibility(Lifecycle.Read)
"createdBy"?: UserInfo;
/**
* The source name for this TI object.
*/
@visibility(Lifecycle.Read)
"source"?: string;
/**
* The timestamp for the first time this object was ingested.
*/
@visibility(Lifecycle.Read)
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"firstIngestedTimeUtc"?: utcDateTime;
/**
* The timestamp for the last time this object was ingested.
*/
@visibility(Lifecycle.Read)
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"lastIngestedTimeUtc"?: utcDateTime;
/**
* The ID of the rules version that was active when this TI object was last ingested.
*/
@visibility(Lifecycle.Read)
#suppress "@azure-tools/typespec-azure-core/no-format"
@format("uuid")
"ingestionRulesVersion"?: string;
/**
* The name of the method/application that initiated the last write to this TI object.
*/
@visibility(Lifecycle.Read)
"lastUpdateMethod"?: string;
/**
* The UserInfo of the user/entity which last modified this TI object.
*/
@visibility(Lifecycle.Read)
"lastModifiedBy"?: UserInfo;
/**
* The timestamp for the last time this TI object was updated.
*/
@visibility(Lifecycle.Read)
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"lastUpdatedDateTimeUtc"?: utcDateTime;
/**
* A dictionary used to help follow relationships from this object to other STIX objects. The keys are field names from the STIX object (in the 'data' field), and the values are lists of sources that can be prepended to the object ID in order to efficiently locate the target TI object.
*/
@visibility(Lifecycle.Read)
"relationshipHints"?: RelationshipHint[];
}

/**
* An object used to help follow relationships from this object to other STIX objects.
*/
model RelationshipHint {
#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
"fieldName"?: string;
#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
"source"?: string;
}

/**
* The triggered analytics rule run Properties
*/
model TriggeredAnalyticsRuleRunProperties {
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
"executionTimeUtc": utcDateTime;
#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
"ruleId": string;
#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
"triggeredAnalyticsRuleRunId": string;
/**
* The triggered analytics rule run provisioning state
*/
"provisioningState": ProvisioningState;
/**
* Dictionary of <any>
*/
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
"ruleRunAdditionalData"?: Record<unknown>;
}

/**
* The triggered analytics rule run array
*/
model TriggeredAnalyticsRuleRuns is Azure.Core.Page<TriggeredAnalyticsRuleRun> {
}

/**
* Analytics Rule Run Trigger request
*/
model AnalyticsRuleRunTrigger {
/**
* The analytics Rule Run Trigger request
*/
"properties": AnalyticsRuleRunTriggerProperties;
}

/**
* The Analytics Rule Run Trigger properties
*/
model AnalyticsRuleRunTriggerProperties {
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
"executionTimeUtc": utcDateTime;
}

/**
* List all the watchlists.
*/
model WatchlistList is Azure.Core.Page<Watchlist> {
}

/**
* Describes watchlist properties
*/
model WatchlistProperties {
/**
* The id (a Guid) of the watchlist
*/
"watchlistId"?: string;
/**
* The display name of the watchlist
*/
"displayName": string;
/**
* The provider of the watchlist
*/
"provider": string;
/**
* The filename of the watchlist, called 'source'
*/
"source"?: string;
/**
* The sourceType of the watchlist
*/
"sourceType"?: SourceType;
/**
* The time the watchlist was created
*/
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"created"?: utcDateTime;
/**
* The last time the watchlist was updated
*/
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"updated"?: utcDateTime;
/**
* Describes a user that created the watchlist
*/
"createdBy"?: UserInfo;
/**
* Describes a user that updated the watchlist
*/
"updatedBy"?: UserInfo;
/**
* A description of the watchlist
*/
"description"?: string;
/**
* The type of the watchlist
*/
"watchlistType"?: string;
/**
* The alias of the watchlist
*/
"watchlistAlias"?: string;
/**
* A flag that indicates if the watchlist is deleted or not
*/
"isDeleted"?: boolean;
/**
* List of labels relevant to this watchlist
*/
"labels"?: string[];
/**
* The default duration of a watchlist (in ISO 8601 duration format)
*/
"defaultDuration"?: duration;
/**
* The tenantId where the watchlist belongs to
*/
"tenantId"?: string;
/**
* The number of lines in a csv/tsv content to skip before the header
*/
"numberOfLinesToSkip"?: int32;
/**
* The raw content that represents to watchlist items to create. In case of csv/tsv content type, it's the content of the file that will parsed by the endpoint
*/
"rawContent"?: string;
/**
* The search key is used to optimize query performance when using watchlists for joins with other data. For example, enable a column with IP addresses to be the designated SearchKey field, then use this field as the key field when joining to other event data by IP address.
*/
"itemsSearchKey": string;
/**
* The content type of the raw content. Example : text/csv or text/tsv
*/
"contentType"?: string;
/**
* The status of the Watchlist upload : New, InProgress or Complete. **Note** : When a Watchlist upload status is InProgress, the Watchlist cannot be deleted
*/
"uploadStatus"?: string;
/**
* The triggered analytics rule run provisioning state
*/
"provisioningState"?: ProvisioningState;
}

/**
* List all the watchlist items.
*/
model WatchlistItemList is Azure.Core.Page<WatchlistItem> {
}

/**
* Describes watchlist item properties
*/
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model WatchlistItemProperties {
/**
* The type of the watchlist item
*/
"watchlistItemType"?: string;
/**
* The id (a Guid) of the watchlist item
*/
"watchlistItemId"?: string;
/**
* The tenantId to which the watchlist item belongs to
*/
"tenantId"?: string;
/**
* A flag that indicates if the watchlist item is deleted or not
*/
"isDeleted"?: boolean;
/**
* The time the watchlist item was created
*/
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"created"?: utcDateTime;
/**
* The last time the watchlist item was updated
*/
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"updated"?: utcDateTime;
/**
* Describes a user that created the watchlist item
*/
"createdBy"?: UserInfo;
/**
* Describes a user that updated the watchlist item
*/
"updatedBy"?: UserInfo;
/**
* key-value pairs for a watchlist item
*/
"itemsKeyValue": unknown;
/**
* key-value pairs for a watchlist item entity mapping
*/
"entityMapping"?: unknown;
}

/**
* List of all the workspace manager assignments.
*/
model WorkspaceManagerAssignmentList is Azure.Core.Page<WorkspaceManagerAssignment> {
}

/**
* The workspace manager assignment properties
*/
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model WorkspaceManagerAssignmentProperties {
/**
* The resource name of the workspace manager group targeted by the workspace manager assignment
*/
"targetResourceName": string;
/**
* The time the last job associated to this assignment ended at
*/
@visibility(Lifecycle.Read)
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"lastJobEndTime"?: utcDateTime;
/**
* State of the last job associated to this assignment
*/
@visibility(Lifecycle.Read)
"lastJobProvisioningState"?: ProvisioningState;
/**
* List of resources included in this workspace manager assignment
*/
@identifiers(#[])
"items": AssignmentItem[];
}

/**
* An entity describing a content item.
*/
model AssignmentItem {
/**
* The resource id of the content item
*/
"resourceId"?: string;
}

/**
* List of all the jobs
*/
model JobList is Azure.Core.Page<Job> {
}

/**
* The job properties
*/
model JobProperties {
/**
* The time the job completed
*/
@visibility(Lifecycle.Read)
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"endTime"?: utcDateTime;
/**
* List of items published by the job
*/
@identifiers(#[])
"items"?: JobItem[];
/**
* State of the job
*/
@visibility(Lifecycle.Read)
"provisioningState"?: ProvisioningState;
/**
* The time the job started
*/
@visibility(Lifecycle.Read)
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"startTime"?: utcDateTime;
/**
* Message to describe error, if an error exists
*/
@visibility(Lifecycle.Read)
"errorMessage"?: string;
}

/**
* An entity describing the publish status of a content item.
*/
model JobItem {
/**
* The resource id of the content item
*/
"resourceId"?: string;
/**
* Status of the item publication
*/
@visibility(Lifecycle.Read)
"status"?: Status;
/**
* The time the item publishing was completed
*/
@visibility(Lifecycle.Read)
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"executionTime"?: utcDateTime;
/**
* The list of error descriptions if the item publication fails.
*/
@identifiers(#[])
"errors"?: Error[];
}

/**
* The error description for why a publication failed
*/
model Error {
/**
* The member resource name for which the publication error occured
*/
"memberResourceName": string;
/**
* The error message
*/
"errorMessage": string;
}

/**
* List all the workspace manager configurations for the workspace.
*/
model WorkspaceManagerConfigurationList is Azure.Core.Page<WorkspaceManagerConfiguration> {
}

/**
* The workspace manager configuration properties
*/
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model WorkspaceManagerConfigurationProperties {
/**
* The current mode of the workspace manager configuration
*/
"mode": Mode;
}

/**
* List of all the workspace manager groups.
*/
model WorkspaceManagerGroupList is Azure.Core.Page<WorkspaceManagerGroup> {
}

/**
* The workspace manager group properties
*/
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model WorkspaceManagerGroupProperties {
/**
* The description of the workspace manager group
*/
"description"?: string;
/**
* The display name of the workspace manager group
*/
"displayName": string;
/**
* The names of the workspace manager members participating in this group.
*/
"memberResourceNames": string[];
}

/**
* List of workspace manager members
*/
model WorkspaceManagerMembersList is Azure.Core.Page<WorkspaceManagerMember> {
}

/**
* The workspace manager member properties
*/
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model WorkspaceManagerMemberProperties {
/**
* Fully qualified resource ID of the target Sentinel workspace joining the given Sentinel workspace manager
*/
"targetWorkspaceResourceId": string;
/**
* Tenant id of the target Sentinel workspace joining the given Sentinel workspace manager
*/
"targetWorkspaceTenantId": string;
}

/**
* alert rule template data sources
*/
model AlertRuleTemplateDataSource {
/**
* The connector id that provides the following data types
*/
"connectorId"?: string;
/**
* The data types used by the alert rule template
*/
@identifiers(#[])
"dataTypes"?: string[];
}

/**
* Base alert rule template property bag.
*/
model AlertRuleTemplatePropertiesBase {
/**
* The number of alert rules that were created by this template
*/
"alertRulesCreatedByTemplateCount"?: int32;
/**
* The last time that this alert rule template has been updated.
*/
@visibility(Lifecycle.Read)
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"lastUpdatedDateUTC"?: utcDateTime;
/**
* The time that this alert rule template has been added.
*/
@visibility(Lifecycle.Read)
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"createdDateUTC"?: utcDateTime;
/**
* The description of the alert rule template.
*/
"description"?: string;
/**
* The display name for alert rule template.
*/
"displayName"?: string;
/**
* The required data sources for this template
*/
@identifiers(#["connectorId"])
"requiredDataConnectors"?: AlertRuleTemplateDataSource[];
/**
* The alert rule template status.
*/
"status"?: TemplateStatus;
}

/**
* Alert rule template with MITRE property bag.
*/
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model AlertRuleTemplateWithMitreProperties extends AlertRuleTemplatePropertiesBase {
/**
* The tactics of the alert rule
*/
"tactics"?: AttackTactic[];
/**
* The techniques of the alert rule
*/
"techniques"?: string[];
}

/**
* Query based alert rule template base property bag.
*/
model QueryBasedAlertRuleTemplateProperties {
/**
* The query that creates alerts for this rule.
*/
"query"?: string;
/**
* The severity for alerts created by this alert rule.
*/
"severity"?: AlertSeverity;
/**
* The version of this template - in format <a.b.c>, where all are numbers. For example <1.0.2>.
*/
"version"?: string;
/**
* Dictionary of string key-value pairs of columns to be attached to the alert
*/
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
"customDetails"?: Record<string>;
/**
* Array of the entity mappings of the alert rule
*/
"entityMappings"?: EntityMapping[];
/**
* The alert details override settings
*/
"alertDetailsOverride"?: AlertDetailsOverride;
/**
* The event grouping settings.
*/
"eventGroupingSettings"?: EventGroupingSettings;
/**
* Array of the sentinel entity mappings of the alert rule
*/
"sentinelEntitiesMappings"?: SentinelEntityMapping[];
}

/**
* Single entity mapping for the alert rule
*/
model EntityMapping {
/**
* The V3 type of the mapped entity
*/
"entityType"?: EntityMappingType;
/**
* array of field mappings for the given entity mapping
*/
@identifiers(#[])
"fieldMappings"?: FieldMapping[];
}

/**
* A single field mapping of the mapped entity
*/
model FieldMapping {
/**
* the V3 identifier of the entity
*/
"identifier"?: string;
/**
* the column name to be mapped to the identifier
*/
"columnName"?: string;
}

/**
* Settings for how to dynamically override alert static details
*/
model AlertDetailsOverride {
/**
* the format containing columns name(s) to override the alert name
*/
"alertDisplayNameFormat"?: string;
/**
* the format containing columns name(s) to override the alert description
*/
"alertDescriptionFormat"?: string;
/**
* the column name to take the alert tactics from
*/
"alertTacticsColumnName"?: string;
/**
* the column name to take the alert severity from
*/
"alertSeverityColumnName"?: string;
/**
* List of additional dynamic properties to override
*/
@identifiers(#[])
"alertDynamicProperties"?: AlertPropertyMapping[];
}

/**
* A single alert property mapping to override
*/
model AlertPropertyMapping {
/**
* The V3 alert property
*/
"alertProperty"?: AlertProperty;
/**
* the column name to use to override this property
*/
"value"?: string;
}

/**
* Event grouping settings property bag.
*/
model EventGroupingSettings {
/**
* The event grouping aggregation kinds
*/
"aggregationKind"?: EventGroupingAggregationKind;
}

/**
* A single sentinel entity mapping
*/
model SentinelEntityMapping {
/**
* the column name to be mapped to the SentinelEntities
*/
"columnName"?: string;
}

/**
* Represents MLBehaviorAnalytics alert rule.
*/
model MLBehaviorAnalyticsAlertRule extends AlertRule {
/**
* MLBehaviorAnalytics alert rule properties
*/
"properties"?: MLBehaviorAnalyticsAlertRuleProperties;
/**
* The kind of the alert rule
*/
"kind": "MLBehaviorAnalytics";
}

/**
* MLBehaviorAnalytics alert rule base property bag.
*/
model MLBehaviorAnalyticsAlertRuleProperties {
/**
* The Name of the alert rule template used to create this rule.
*/
"alertRuleTemplateName": string;
/**
* The description of the alert rule.
*/
@visibility(Lifecycle.Read)
"description"?: string;
/**
* The display name for alerts created by this alert rule.
*/
@visibility(Lifecycle.Read)
"displayName"?: string;
/**
* Determines whether this alert rule is enabled or disabled.
*/
"enabled": boolean;
/**
* The last time that this alert rule has been modified.
*/
@visibility(Lifecycle.Read)
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"lastModifiedUtc"?: utcDateTime;
/**
* The severity for alerts created by this alert rule.
*/
@visibility(Lifecycle.Read)
"severity"?: AlertSeverity;
/**
* The tactics of the alert rule
*/
@visibility(Lifecycle.Read)
@identifiers(#[])
"tactics"?: AttackTactic[];
/**
* The techniques of the alert rule
*/
@visibility(Lifecycle.Read)
"techniques"?: string[];
/**
* The sub-techniques of the alert rule
*/
@visibility(Lifecycle.Read)
"subTechniques"?: string[];
}

/**
* Represents MLBehaviorAnalytics alert rule template.
*/
model MLBehaviorAnalyticsAlertRuleTemplate extends AlertRuleTemplate {
/**
* MLBehaviorAnalytics alert rule template properties.
*/
"properties"?: MLBehaviorAnalyticsAlertRuleTemplateProperties;
/**
* The kind of the alert rule
*/
"kind": "MLBehaviorAnalytics";
}

/**
* MLBehaviorAnalytics alert rule template properties.
*/
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model MLBehaviorAnalyticsAlertRuleTemplateProperties extends AlertRuleTemplateWithMitreProperties {
/**
* The severity for alerts created by this alert rule.
*/
"severity": AlertSeverity;
}

/**
* Represents Fusion alert rule.
*/
model FusionAlertRule extends AlertRule {
/**
* Fusion alert rule properties
*/
"properties"?: FusionAlertRuleProperties;
/**
* The kind of the alert rule
*/
"kind": "Fusion";
}

/**
* Fusion alert rule base property bag.
*/
model FusionAlertRuleProperties {
/**
* The Name of the alert rule template used to create this rule.
*/
"alertRuleTemplateName": string;
/**
* The description of the alert rule.
*/
@visibility(Lifecycle.Read)
"description"?: string;
/**
* The display name for alerts created by this alert rule.
*/
@visibility(Lifecycle.Read)
"displayName"?: string;
/**
* Determines whether this alert rule is enabled or disabled.
*/
"enabled": boolean;
/**
* Configuration for all supported source signals in fusion detection.
*/
@identifiers(#[])
"sourceSettings"?: FusionSourceSettings[];
/**
* Configuration to exclude scenarios in fusion detection.
*/
@identifiers(#[])
"scenarioExclusionPatterns"?: FusionScenarioExclusionPattern[];
/**
* The last time that this alert has been modified.
*/
@visibility(Lifecycle.Read)
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"lastModifiedUtc"?: utcDateTime;
/**
* The severity for alerts created by this alert rule.
*/
@visibility(Lifecycle.Read)
"severity"?: AlertSeverity;
/**
* The tactics of the alert rule
*/
@visibility(Lifecycle.Read)
@identifiers(#[])
"tactics"?: AttackTactic[];
/**
* The techniques of the alert rule
*/
@visibility(Lifecycle.Read)
"techniques"?: string[];
/**
* The sub-techniques of the alert rule
*/
@visibility(Lifecycle.Read)
"subTechniques"?: string[];
}

/**
* Represents a supported source signal configuration in Fusion detection.
*/
model FusionSourceSettings {
/**
* Determines whether this source signal is enabled or disabled in Fusion detection.
*/
"enabled": boolean;
/**
* Name of the Fusion source signal. Refer to Fusion alert rule template for supported values.
*/
"sourceName": string;
/**
* Configuration for all source subtypes under this source signal consumed in fusion detection.
*/
@identifiers(#[])
"sourceSubTypes"?: FusionSourceSubTypeSetting[];
}

/**
* Represents a supported source subtype configuration under a source signal in Fusion detection.
*/
model FusionSourceSubTypeSetting {
/**
* Determines whether this source subtype under source signal is enabled or disabled in Fusion detection.
*/
"enabled": boolean;
/**
* The Name of the source subtype under a given source signal in Fusion detection. Refer to Fusion alert rule template for supported values.
*/
"sourceSubTypeName": string;
/**
* The display name of source subtype under a source signal consumed in Fusion detection.
*/
@visibility(Lifecycle.Read)
"sourceSubTypeDisplayName"?: string;
/**
* Severity configuration for a source subtype consumed in fusion detection.
*/
"severityFilters": FusionSubTypeSeverityFilter;
}

/**
* Represents severity configuration for a source subtype consumed in Fusion detection.
*/
model FusionSubTypeSeverityFilter {
/**
* Determines whether this source subtype supports severity configuration or not.
*/
@visibility(Lifecycle.Read)
"isSupported"?: boolean;
/**
* Individual Severity configuration settings for a given source subtype consumed in Fusion detection.
*/
@identifiers(#[])
"filters"?: FusionSubTypeSeverityFiltersItem[];
}

/**
* Represents a Severity filter setting for a given source subtype consumed in Fusion detection.
*/
model FusionSubTypeSeverityFiltersItem {
/**
* The Severity for a given source subtype consumed in Fusion detection.
*/
"severity": AlertSeverity;
/**
* Determines whether this severity is enabled or disabled for this source subtype consumed in Fusion detection.
*/
"enabled": boolean;
}

/**
* Represents a Fusion scenario exclusion patterns in Fusion detection.
*/
model FusionScenarioExclusionPattern {
/**
* Scenario exclusion pattern.
*/
"exclusionPattern": string;
/**
* DateTime when scenario exclusion pattern is added in UTC.
*/
"dateAddedInUTC": string;
}

/**
* Represents Fusion alert rule template.
*/
model FusionAlertRuleTemplate extends AlertRuleTemplate {
/**
* Fusion alert rule template properties
*/
"properties"?: FusionAlertRuleTemplateProperties;
/**
* The kind of the alert rule
*/
"kind": "Fusion";
}

/**
* Fusion alert rule template properties
*/
model FusionAlertRuleTemplateProperties {
/**
* The number of alert rules that were created by this template
*/
"alertRulesCreatedByTemplateCount"?: int32;
/**
* The time that this alert rule template has been added.
*/
@visibility(Lifecycle.Read)
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"createdDateUTC"?: utcDateTime;
/**
* The time that this alert rule template was last updated.
*/
@visibility(Lifecycle.Read)
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"lastUpdatedDateUTC"?: utcDateTime;
/**
* The description of the alert rule template.
*/
"description"?: string;
/**
* The display name for alert rule template.
*/
"displayName"?: string;
/**
* The required data connectors for this template
*/
@identifiers(#[])
"requiredDataConnectors"?: AlertRuleTemplateDataSource[];
/**
* The alert rule template status.
*/
"status"?: TemplateStatus;
/**
* The severity for alerts created by this alert rule.
*/
"severity"?: AlertSeverity;
/**
* The tactics of the alert rule template
*/
@identifiers(#[])
"tactics"?: AttackTactic[];
/**
* The techniques of the alert rule
*/
"techniques"?: string[];
/**
* The sub-techniques of the alert rule
*/
"subTechniques"?: string[];
/**
* All supported source signal configurations consumed in fusion detection.
*/
@identifiers(#[])
"sourceSettings"?: FusionTemplateSourceSetting[];
}

/**
* Represents a source signal consumed in Fusion detection.
*/
model FusionTemplateSourceSetting {
/**
* The name of a source signal consumed in Fusion detection.
*/
"sourceName": string;
/**
* All supported source subtypes under this source signal consumed in fusion detection.
*/
@identifiers(#[])
"sourceSubTypes"?: FusionTemplateSourceSubType[];
}

/**
* Represents a source subtype under a source signal consumed in Fusion detection.
*/
model FusionTemplateSourceSubType {
/**
* The name of source subtype under a source signal consumed in Fusion detection.
*/
"sourceSubTypeName": string;
/**
* The display name of source subtype under a source signal consumed in Fusion detection.
*/
@visibility(Lifecycle.Read)
"sourceSubTypeDisplayName"?: string;
/**
* Severity configuration available for a source subtype consumed in fusion detection.
*/
"severityFilter": FusionTemplateSubTypeSeverityFilter;
}

/**
* Represents severity configurations available for a source subtype consumed in Fusion detection.
*/
model FusionTemplateSubTypeSeverityFilter {
/**
* Determines whether severity configuration is supported for this source subtype consumed in Fusion detection.
*/
"isSupported": boolean;
/**
* List of all supported severities for this source subtype consumed in Fusion detection.
*/
@identifiers(#[])
"severityFilters"?: AlertSeverity[];
}

/**
* Represents Threat Intelligence alert rule.
*/
model ThreatIntelligenceAlertRule extends AlertRule {
/**
* Threat Intelligence alert rule properties
*/
"properties"?: ThreatIntelligenceAlertRuleProperties;
/**
* The kind of the alert rule
*/
"kind": "ThreatIntelligence";
}

/**
* Threat Intelligence alert rule base property bag.
*/
model ThreatIntelligenceAlertRuleProperties {
/**
* The Name of the alert rule template used to create this rule.
*/
"alertRuleTemplateName": string;
/**
* The description of the alert rule.
*/
@visibility(Lifecycle.Read)
"description"?: string;
/**
* The display name for alerts created by this alert rule.
*/
@visibility(Lifecycle.Read)
"displayName"?: string;
/**
* Determines whether this alert rule is enabled or disabled.
*/
"enabled": boolean;
/**
* The last time that this alert has been modified.
*/
@visibility(Lifecycle.Read)
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"lastModifiedUtc"?: utcDateTime;
/**
* The severity for alerts created by this alert rule.
*/
@visibility(Lifecycle.Read)
"severity"?: AlertSeverity;
/**
* The tactics of the alert rule
*/
@visibility(Lifecycle.Read)
"tactics"?: AttackTactic[];
/**
* The techniques of the alert rule
*/
@visibility(Lifecycle.Read)
"techniques"?: string[];
/**
* The sub-techniques of the alert rule
*/
@visibility(Lifecycle.Read)
"subTechniques"?: string[];
}

/**
* Represents Threat Intelligence alert rule template.
*/
model ThreatIntelligenceAlertRuleTemplate extends AlertRuleTemplate {
/**
* Threat Intelligence alert rule template properties
*/
"properties"?: ThreatIntelligenceAlertRuleTemplateProperties;
/**
* The kind of the alert rule
*/
"kind": "ThreatIntelligence";
}

/**
* Threat Intelligence alert rule template properties
*/
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ThreatIntelligenceAlertRuleTemplateProperties extends AlertRuleTemplateWithMitreProperties {
/**
* The severity for alerts created by this alert rule.
*/
"severity": AlertSeverity;
}

/**
* Represents MicrosoftSecurityIncidentCreation rule.
*/
model MicrosoftSecurityIncidentCreationAlertRule extends AlertRule {
/**
* MicrosoftSecurityIncidentCreation rule properties
*/
"properties"?: MicrosoftSecurityIncidentCreationAlertRuleProperties;
/**
* The kind of the alert rule
*/
"kind": "MicrosoftSecurityIncidentCreation";
}

/**
* MicrosoftSecurityIncidentCreation rule property bag.
*/
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model MicrosoftSecurityIncidentCreationAlertRuleProperties extends MicrosoftSecurityIncidentCreationAlertRuleCommonProperties {
/**
* The Name of the alert rule template used to create this rule.
*/
"alertRuleTemplateName"?: string;
/**
* The description of the alert rule.
*/
"description"?: string;
/**
* The display name for alerts created by this alert rule.
*/
"displayName": string;
/**
* Determines whether this alert rule is enabled or disabled.
*/
"enabled": boolean;
/**
* The last time that this alert has been modified.
*/
@visibility(Lifecycle.Read)
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"lastModifiedUtc"?: utcDateTime;
}

/**
* MicrosoftSecurityIncidentCreation rule common property bag.
*/
model MicrosoftSecurityIncidentCreationAlertRuleCommonProperties {
/**
* the alerts' displayNames on which the cases will be generated
*/
@identifiers(#[])
"displayNamesFilter"?: string[];
/**
* the alerts' displayNames on which the cases will not be generated
*/
@identifiers(#[])
"displayNamesExcludeFilter"?: string[];
/**
* The alerts' productName on which the cases will be generated
*/
"productFilter": MicrosoftSecurityProductName;
/**
* the alerts' severities on which the cases will be generated
*/
@identifiers(#[])
"severitiesFilter"?: AlertSeverity[];
}

/**
* Represents MicrosoftSecurityIncidentCreation rule template.
*/
model MicrosoftSecurityIncidentCreationAlertRuleTemplate extends AlertRuleTemplate {
/**
* MicrosoftSecurityIncidentCreation rule template properties
*/
"properties"?: MicrosoftSecurityIncidentCreationAlertRuleTemplateProperties;
/**
* The kind of the alert rule
*/
"kind": "MicrosoftSecurityIncidentCreation";
}

/**
* MicrosoftSecurityIncidentCreation rule template properties
*/
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model MicrosoftSecurityIncidentCreationAlertRuleTemplateProperties extends AlertRuleTemplatePropertiesBase {
/**
* the alerts' displayNames on which the cases will be generated
*/
@identifiers(#[])
"displayNamesFilter"?: string[];
/**
* the alerts' displayNames on which the cases will not be generated
*/
@identifiers(#[])
"displayNamesExcludeFilter"?: string[];
/**
* The alerts' productName on which the cases will be generated
*/
"productFilter"?: MicrosoftSecurityProductName;
/**
* the alerts' severities on which the cases will be generated
*/
@identifiers(#[])
"severitiesFilter"?: AlertSeverity[];
}

/**
* Scheduled alert rule base property bag.
*/
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ScheduledAlertRuleProperties extends ScheduledAlertRuleCommonProperties {
/**
* The Name of the alert rule template used to create this rule.
*/
"alertRuleTemplateName"?: string;
/**
* The version of the alert rule template used to create this rule - in format <a.b.c>, where all are numbers, for example 0 <1.0.2>
*/
"templateVersion"?: string;
/**
* The description of the alert rule.
*/
"description"?: string;
/**
* The display name for alerts created by this alert rule.
*/
"displayName": string;
/**
* Determines whether this alert rule is enabled or disabled.
*/
"enabled": boolean;
/**
* The last time that this alert rule has been modified.
*/
@visibility(Lifecycle.Read)
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"lastModifiedUtc"?: utcDateTime;
/**
* The suppression (in ISO 8601 duration format) to wait since last time this alert rule been triggered.
*/
"suppressionDuration": duration;
/**
* Determines whether the suppression for this alert rule is enabled or disabled.
*/
"suppressionEnabled": boolean;
/**
* The tactics of the alert rule
*/
@identifiers(#[])
"tactics"?: AttackTactic[];
/**
* The techniques of the alert rule
*/
"techniques"?: string[];
/**
* The sub-techniques of the alert rule
*/
"subTechniques"?: string[];
/**
* The settings of the incidents that created from alerts triggered by this analytics rule
*/
"incidentConfiguration"?: IncidentConfiguration;
}

/**
* Incident Configuration property bag.
*/
model IncidentConfiguration {
/**
* Create incidents from alerts triggered by this analytics rule
*/
"createIncident": boolean;
/**
* Set how the alerts that are triggered by this analytics rule, are grouped into incidents
*/
"groupingConfiguration"?: GroupingConfiguration;
}

/**
* Grouping configuration property bag.
*/
model GroupingConfiguration {
/**
* Grouping enabled
*/
"enabled": boolean;
/**
* Re-open closed matching incidents
*/
"reopenClosedIncident": boolean;
/**
* Limit the group to alerts created within the lookback duration (in ISO 8601 duration format)
*/
"lookbackDuration": duration;
/**
* Grouping matching method. When method is Selected at least one of groupByEntities, groupByAlertDetails, groupByCustomDetails must be provided and not empty.
*/
"matchingMethod": MatchingMethod;
/**
* A list of entity types to group by (when matchingMethod is Selected). Only entities defined in the current alert rule may be used.
*/
@identifiers(#[])
"groupByEntities"?: EntityMappingType[];
/**
* A list of alert details to group by (when matchingMethod is Selected)
*/
@identifiers(#[])
"groupByAlertDetails"?: AlertDetail[];
/**
* A list of custom details keys to group by (when matchingMethod is Selected). Only keys defined in the current alert rule may be used.
*/
@identifiers(#[])
"groupByCustomDetails"?: string[];
}

/**
* Scheduled alert rule template property bag.
*/
model ScheduledAlertRuleCommonProperties {
/**
* The query that creates alerts for this rule.
*/
"query"?: string;
/**
* The frequency (in ISO 8601 duration format) for this alert rule to run.
*/
"queryFrequency"?: duration;
/**
* The period (in ISO 8601 duration format) that this alert rule looks at.
*/
"queryPeriod"?: duration;
/**
* The severity for alerts created by this alert rule.
*/
"severity"?: AlertSeverity;
/**
* The operation against the threshold that triggers alert rule.
*/
"triggerOperator"?: TriggerOperator;
/**
* The threshold triggers this alert rule.
*/
"triggerThreshold"?: int32;
/**
* The event grouping settings.
*/
"eventGroupingSettings"?: EventGroupingSettings;
/**
* Dictionary of string key-value pairs of columns to be attached to the alert
*/
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
"customDetails"?: Record<string>;
/**
* Array of the entity mappings of the alert rule
*/
"entityMappings"?: EntityMapping[];
/**
* The alert details override settings
*/
"alertDetailsOverride"?: AlertDetailsOverride;
/**
* Array of the sentinel entity mappings of the alert rule
*/
"sentinelEntitiesMappings"?: SentinelEntityMapping[];
}

/**
* Nrt alert rule base property bag.
*/
model NrtAlertRuleProperties {
/**
* The Name of the alert rule template used to create this rule.
*/
"alertRuleTemplateName"?: string;
/**
* The version of the alert rule template used to create this rule - in format <a.b.c>, where all are numbers, for example 0 <1.0.2>
*/
"templateVersion"?: string;
/**
* The description of the alert rule.
*/
"description"?: string;
/**
* The query that creates alerts for this rule.
*/
"query": string;
/**
* The tactics of the alert rule
*/
"tactics"?: AttackTactic[];
/**
* The techniques of the alert rule
*/
"techniques"?: string[];
/**
* The sub-techniques of the alert rule
*/
"subTechniques"?: string[];
/**
* The display name for alerts created by this alert rule.
*/
"displayName": string;
/**
* Determines whether this alert rule is enabled or disabled.
*/
"enabled": boolean;
/**
* The last time that this alert rule has been modified.
*/
@visibility(Lifecycle.Read)
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"lastModifiedUtc"?: utcDateTime;
/**
* The suppression (in ISO 8601 duration format) to wait since last time this alert rule been triggered.
*/
"suppressionDuration": duration;
/**
* Determines whether the suppression for this alert rule is enabled or disabled.
*/
"suppressionEnabled": boolean;
/**
* The severity for alerts created by this alert rule.
*/
"severity": AlertSeverity;
/**
* The settings of the incidents that created from alerts triggered by this analytics rule
*/
"incidentConfiguration"?: IncidentConfiguration;
/**
* Dictionary of string key-value pairs of columns to be attached to the alert
*/
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
"customDetails"?: Record<string>;
/**
* Array of the entity mappings of the alert rule
*/
"entityMappings"?: EntityMapping[];
/**
* The alert details override settings
*/
"alertDetailsOverride"?: AlertDetailsOverride;
/**
* The event grouping settings.
*/
"eventGroupingSettings"?: EventGroupingSettings;
/**
* Array of the sentinel entity mappings of the alert rule
*/
"sentinelEntitiesMappings"?: SentinelEntityMapping[];
}

/**
* Scheduled alert rule template properties
*/
model ScheduledAlertRuleTemplateProperties {
/**
* The number of alert rules that were created by this template
*/
"alertRulesCreatedByTemplateCount"?: int32;
/**
* The time that this alert rule template has been added.
*/
@visibility(Lifecycle.Read)
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"createdDateUTC"?: utcDateTime;
/**
* The time that this alert rule template was last updated.
*/
@visibility(Lifecycle.Read)
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"lastUpdatedDateUTC"?: utcDateTime;
/**
* The description of the alert rule template.
*/
"description"?: string;
/**
* The display name for alert rule template.
*/
"displayName"?: string;
/**
* The required data connectors for this template
*/
@identifiers(#[])
"requiredDataConnectors"?: AlertRuleTemplateDataSource[];
/**
* The alert rule template status.
*/
"status"?: TemplateStatus;
/**
* The query that creates alerts for this rule.
*/
"query"?: string;
/**
* The frequency (in ISO 8601 duration format) for this alert rule to run.
*/
"queryFrequency"?: duration;
/**
* The period (in ISO 8601 duration format) that this alert rule looks at.
*/
"queryPeriod"?: duration;
/**
* The severity for alerts created by this alert rule.
*/
"severity"?: AlertSeverity;
/**
* The operation against the threshold that triggers alert rule.
*/
"triggerOperator"?: TriggerOperator;
/**
* The threshold triggers this alert rule.
*/
"triggerThreshold"?: int32;
/**
* The tactics of the alert rule template
*/
@identifiers(#[])
"tactics"?: AttackTactic[];
/**
* The techniques of the alert rule
*/
"techniques"?: string[];
/**
* The sub-techniques of the alert rule
*/
"subTechniques"?: string[];
/**
* The version of this template - in format <a.b.c>, where all are numbers. For example <1.0.2>.
*/
"version"?: string;
/**
* The event grouping settings.
*/
"eventGroupingSettings"?: EventGroupingSettings;
/**
* Dictionary of string key-value pairs of columns to be attached to the alert
*/
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
"customDetails"?: Record<string>;
/**
* Array of the entity mappings of the alert rule
*/
"entityMappings"?: EntityMapping[];
/**
* The alert details override settings
*/
"alertDetailsOverride"?: AlertDetailsOverride;
/**
* Array of the sentinel entity mappings of the alert rule
*/
"sentinelEntitiesMappings"?: SentinelEntityMapping[];
}

/**
* Represents scheduled alert rule template.
*/
model ScheduledAlertRuleTemplate extends AlertRuleTemplate {
/**
* Scheduled alert rule template properties
*/
"properties"?: ScheduledAlertRuleTemplateProperties;
/**
* The kind of the alert rule
*/
"kind": "Scheduled";
}

/**
* Represents NRT alert rule template.
*/
model NrtAlertRuleTemplate extends AlertRuleTemplate {
/**
* NRT alert rule template properties
*/
"properties"?: NrtAlertRuleTemplateProperties;
/**
* The kind of the alert rule
*/
"kind": "NRT";
}

/**
* NRT alert rule template properties
*/
model NrtAlertRuleTemplateProperties {
...AlertRuleTemplateWithMitreProperties;
...QueryBasedAlertRuleTemplateProperties;
}

/**
* Represents scheduled alert rule.
*/
model ScheduledAlertRule extends AlertRule {
/**
* Scheduled alert rule properties
*/
"properties"?: ScheduledAlertRuleProperties;
/**
* The kind of the alert rule
*/
"kind": "Scheduled";
}

/**
* Represents NRT alert rule.
*/
model NrtAlertRule extends AlertRule {
/**
* NRT alert rule properties
*/
"properties"?: NrtAlertRuleProperties;
/**
* The kind of the alert rule
*/
"kind": "NRT";
}


#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model AddIncidentTaskActionProperties {
/**
* The title of the task.
*/
"title": string;
/**
* The description of the task.
*/
"description"?: string;
}

/**
* Describes an automation rule action to add a task to an incident
*/
model AutomationRuleAddIncidentTaskAction extends AutomationRuleAction {
#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
"actionConfiguration"?: AddIncidentTaskActionProperties;
/**
* The type of the automation rule action.
*/
"actionType": "AddIncidentTask";
}


#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model AutomationRuleBooleanCondition {
#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
"operator"?: AutomationRuleBooleanConditionSupportedOperator;
@identifiers(#[])
#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
"innerConditions"?: AutomationRuleCondition[];
}

/**
* Describes an automation rule action to modify an object's properties
*/
model AutomationRuleModifyPropertiesAction extends AutomationRuleAction {
#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
"actionConfiguration"?: IncidentPropertiesAction;
/**
* The type of the automation rule action.
*/
"actionType": "ModifyProperties";
}


#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model IncidentPropertiesAction {
/**
* The severity of the incident
*/
"severity"?: IncidentSeverity;
/**
* The status of the incident
*/
"status"?: IncidentStatus;
/**
* The reason the incident was closed
*/
"classification"?: IncidentClassification;
/**
* The classification reason the incident was closed with
*/
"classificationReason"?: IncidentClassificationReason;
/**
* Describes the reason the incident was closed.
*/
"classificationComment"?: string;
/**
* Information on the user an incident is assigned to
*/
"owner"?: IncidentOwnerInfo;
/**
* List of labels to add to the incident.
*/
@identifiers(#["labelName"])
"labels"?: IncidentLabel[];
}


#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model AutomationRulePropertyArrayChangedValuesCondition {
#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
"arrayType"?: AutomationRulePropertyArrayChangedConditionSupportedArrayType;
#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
"changeType"?: AutomationRulePropertyArrayChangedConditionSupportedChangeType;
}


#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model AutomationRulePropertyArrayValuesCondition {
#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
"arrayType"?: AutomationRulePropertyArrayConditionSupportedArrayType;
#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
"arrayConditionType"?: AutomationRulePropertyArrayConditionSupportedArrayConditionType;
@identifiers(#[])
#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
"itemConditions"?: AutomationRuleCondition[];
}


#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model AutomationRulePropertyValuesChangedCondition {
#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
"propertyName"?: AutomationRulePropertyChangedConditionSupportedPropertyType;
#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
"changeType"?: AutomationRulePropertyChangedConditionSupportedChangedType;
#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
"operator"?: AutomationRulePropertyConditionSupportedOperator;
#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
"propertyValues"?: string[];
}


#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model AutomationRulePropertyValuesCondition {
/**
* The property to evaluate in an automation rule property condition.
*/
"propertyName"?: AutomationRulePropertyConditionSupportedProperty;
#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
"operator"?: AutomationRulePropertyConditionSupportedOperator;
#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
"propertyValues"?: string[];
}

/**
* Describes an automation rule action to run a playbook
*/
model AutomationRuleRunPlaybookAction extends AutomationRuleAction {
#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
"actionConfiguration"?: PlaybookActionProperties;
/**
* The type of the automation rule action.
*/
"actionType": "RunPlaybook";
}


#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model PlaybookActionProperties {
/**
* The resource id of the playbook resource.
*/
"logicAppResourceId": Azure.Core.armResourceIdentifier<[{type: "Microsoft.Logic/workflows";},{type: "Microsoft.Web/sites";}]>;
/**
* The tenant id of the playbook resource.
*/
#suppress "@azure-tools/typespec-azure-core/no-format"
@format("uuid")
"tenantId"?: string;
}

/**
* Describes an automation rule condition that applies a boolean operator (e.g AND, OR) to conditions
*/
model BooleanConditionProperties extends AutomationRuleCondition {
#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
"conditionProperties"?: AutomationRuleBooleanCondition;
"conditionType": "Boolean";
}

/**
* Describes an automation rule condition that evaluates an array property's value change
*/
model PropertyArrayChangedConditionProperties extends AutomationRuleCondition {
#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
"conditionProperties"?: AutomationRulePropertyArrayChangedValuesCondition;
"conditionType": "PropertyArrayChanged";
}

/**
* Describes an automation rule condition that evaluates an array property's value
*/
model PropertyArrayConditionProperties extends AutomationRuleCondition {
#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
"conditionProperties"?: AutomationRulePropertyArrayValuesCondition;
"conditionType": "PropertyArray";
}

/**
* Describes an automation rule condition that evaluates a property's value change
*/
model PropertyChangedConditionProperties extends AutomationRuleCondition {
#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
"conditionProperties"?: AutomationRulePropertyValuesChangedCondition;
"conditionType": "PropertyChanged";
}

/**
* Describes an automation rule condition that evaluates a property's value
*/
model PropertyConditionProperties extends AutomationRuleCondition {
#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
"conditionProperties"?: AutomationRulePropertyValuesCondition;
"conditionType": "Property";
}

/**
* Billing statistic about the Microsoft Sentinel solution for SAP Usage
*/
model SapSolutionUsageStatistic extends BillingStatistic {
/**
* The SAP solution usage object
*/
"properties"?: SapSolutionUsageStatisticProperties;
/**
* The kind of the billing statistic
*/
"kind": "SapSolutionUsage";
}

/**
* Properties of the billing statistic about the Microsoft Sentinel solution for SAP usage
*/
model SapSolutionUsageStatisticProperties {
/**
* The latest count of active SAP system IDs under the Microsoft Sentinel solution for SAP Usage
*/
@visibility(Lifecycle.Read)
"activeSystemIdCount"?: int64;
}

/**
* Describes the configuration of a SAP Docker agent.
*/
model SapAgentConfiguration extends AgentConfiguration {
/**
* The name of the docker agent.
* only letters with numbers, underscores and hyphens are allowed
* example: "my-agent"
*/
@pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]*$")
"agentContainerName"?: string;
/**
* The SDK path (a file not a folder) on the agent machine.
* example: "/path/to/nwrfc750P_8-70002755.zip"
*/
@pattern("^/(([^/]+/)*nwrfc75.*\\.zip$)|^((?:[a-zA-Z]:)?(?:\\\\|\\\\\\\\)(?:[^\\\\/:*?"<>|\\r\\n]+\\\\)*nwrfc75.*\\.zip)$")
"sdkPath"?: string;
/**
* The SNC path (a folder not a file) on the agent machine.
* example: "/path/to/snc"
*/
@pattern("^\\/(?:[^/]+\\/)*[^/]+$|^(?:[a-zA-Z]:)?(?:\\\\|\\\\\\\\)(?:[^\\\\/:*?"<>|\\r\\n]+\\\\)*[^\\\\/:*?"<>|\\r\\n]*$")
"sncPath"?: string;
/**
* The key vault resource id to access the key vault.
* example: "/subscriptions/d0cfe6b2-9ac0-4464-9919-dccaee2e48c0/resourceGroups/myRg/providers/Microsoft.KeyVault/vaults/myVault"
*/
@pattern("^\\/?subscriptions\\/([^\\/]+)\\/resourceGroups\\/([^\\/]+)\\/providers\\/Microsoft\\.KeyVault\\/vaults\\/([^\\/]+)$")
"keyVaultResourceId"?: string;
/**
* The key mode of the agent.
* ManagedIdentity|ApplicationIdentity are the options
*/
"keyVaultAuthenticationMode"?: KeyVaultAuthenticationMode;
/**
* The secret source of the agent.
* AzureKeyVault is the option
*/
"secretSource"?: SecretSource;
/**
* Type of the agent
*/
"type": "SAP";
}

/**
* Represents lock user action.
*/
model LockUserAction extends Action {
/**
* The user to lock
*/
"user"?: string;
/**
* The reason of the failure of the action. Empty if the action is successful.
*/
"failureReason"?: string;
/**
* The actions kind
*/
"kind": "LockUser";
}

/**
* Represents an unlock user action.
*/
model UnlockUserAction extends Action {
/**
* The user to unlock
*/
"user"?: string;
/**
* The reason of the failure of the action. Empty if the action is successful.
*/
"failureReason"?: string;
/**
* The actions kind
*/
"kind": "UnlockUser";
}

/**
* Describes a log.
*/
model Log {
/**
* Types of logs and tables.
*/
"type": LogType;
/**
* Types of ingestion.
*/
"ingestionType"?: IngestionType;
/**
* Types of log status.
*/
"status"?: LogStatusType;
/**
* The schedule interval in seconds.
*/
"scheduleInterval"?: int32;
/**
* The bulk size for the log.
*/
"bulkSize"?: int32;
/**
* The filters for the log.
*/
"filters"?: string[];
}

/**
* Describes the Rfc connector.
*/
model RfcConnector extends SystemsConfigurationConnector {
/**
* FQDN, hostname, or IP address of the ABAP server.
*/
"abapServerHost"?: string;
/**
* FQDN, hostname, or IP address of the Message server.
*/
"messageServerHost"?: string;
/**
* Logon group of the message server.
*/
"group"?: string;
/**
* Port number, or service name (from /etc/services) of the message server.
*/
"messageServerService"?: string;
/**
* SNC QOP.
* Options are 1, 2, 3, 8, 9.
*/
@pattern("^[1,2,3,8,9]$")
"sncQop"?: string;
/**
* The SAP code page used for character encoding.
* Example - 1100
*/
@pattern("^(?:[a-zA-Z0-9]{4}|UTF-8)$")
"codePage"?: string;
/**
* System number of the ABAP server.
*/
@minLength(1)
@pattern("^\\d{1,3}$")
"systemNumber": string;
/**
* System ID of the ABAP server.
* Example - A4H
*/
@minLength(1)
@pattern("^[a-zA-Z0-9]{3}$")
"systemId": string;
/**
* Client number of the ABAP server.
* Example - 001
*/
@minLength(1)
@pattern("^[0-9]{3}$")
"client": string;
/**
* The authentication type to SAP.
*/
"authenticationType"?: SapAuthenticationType;
/**
* Represents the types of SAP systems.
*/
"type": "Rfc";
}

/**
* Base Model for SAP System Connector.
*/
@discriminator("type")
model SystemsConfigurationConnector {
/**
* Represents the types of SAP systems.
*/
"type": SystemConfigurationConnectorType;
}

/**
* Describes the SapControl connector configuration.
*/
model SapControlConnector extends SystemsConfigurationConnector {
/**
* The server name.
* FQDN or IP address.
*/
@minLength(1)
@pattern("^([a-zA-Z0-9]+(-[a-zA-Z0-9]+)*\\.)+[a-zA-Z]{2,}$|^\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}$")
"server": string;
/**
* The instance number. Only 2 digits are allowed.
*/
@minLength(1)
@pattern("^\\d{2}$")
"instance": string;
/**
* The timezone.
* example: "GMT+0" or "GMT-8"
* default: "GMT+0"
*/
@pattern("^GMT[+-]\\d+$")
"timezone"?: string = "GMT+0";
/**
* The port of the SOAP connection to SAP Control.
*/
@pattern("^\\d{1,5}$")
"port"?: string;
/**
* Represents the types of HTTPS configuration to connect to the SapControl service.
*/
"httpsConfiguration"?: HttpsConfigurationType;
/**
* Represents the types of SAP systems.
*/
"type": "SapControl";
}

/**
* Describes the SAP configuration.
*/
model SapSystemsConfiguration extends SystemsConfiguration {
/**
* azure resource id
* example: "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myResourceGroup/providers/Microsoft.Compute/virtualMachines/myVM"
*/
@pattern("^\\/?subscriptions\\/([^\\/]+)\\/resourceGroups\\/([^\\/]+)\\/providers\\/([^\\/]+)\\/([^\\/]+)\\/([^\\/]+)$")
"azureResourceId"?: string;
/**
* Base Model for SAP System Connector.
*/
"connector": SystemsConfigurationConnector;
/**
* The logs configuration.
*/
@identifiers(#[])
"logs"?: Log[];
/**
* Represents the types of configuration for a system.
*/
"type": "SAP";
}

/**
* The exposure status of the connector to the customers.
*/
model ConnectorDefinitionsAvailability {
/**
* The exposure status of the connector to the customers. Available values are 0-4 (0=None, 1=Available, 2=FeatureFlag, 3=Internal).
*/
"status"?: int32;
/**
* Gets or sets a value indicating whether the connector is preview.
*/
"isPreview"?: boolean;
}

/**
* The criteria by which we determine whether the connector is connected or not.
* For Example, use a KQL query to check if  the expected data type is flowing).
*/
model ConnectivityCriterion {
/**
* Gets or sets the type of connectivity.
*/
"type": string;
/**
* Gets or sets the queries for checking connectivity.
*/
"value"?: string[];
}

/**
* The data type which is created by the connector,
* including a query indicated when was the last time that data type was received in the workspace.
*/
model ConnectorDataType {
/**
* Gets or sets the name of the data type to show in the graph.
*/
"name": string;
/**
* Gets or sets the query to indicate when relevant data was last received in the workspace.
*/
"lastDataReceivedQuery": string;
}

/**
* Connector definition for kind 'Customizable'.
*/
model CustomizableConnectorDefinition extends DataConnectorDefinition {
/**
* Customizable properties.
*/
"properties"?: CustomizableConnectorDefinitionProperties;
/**
* The data connector kind
*/
"kind": "Customizable";
}

/**
* The UiConfig for 'Customizable' connector definition kind.
*/
model CustomizableConnectorDefinitionProperties {
/**
* Gets or sets the connector definition created date in UTC format.
*/
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"createdTimeUtc"?: utcDateTime;
/**
* Gets or sets the connector definition last modified date in UTC format.
*/
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"lastModifiedUtc"?: utcDateTime;
/**
* The UiConfig for 'Customizable' connector definition kind.
*/
"connectorUiConfig": CustomizableConnectorUiConfig;
/**
* The UiConfig for 'Customizable' connector definition kind.
*/
"connectionsConfig"?: CustomizableConnectionsConfig;
}

/**
* The UiConfig for 'Customizable' connector definition kind.
*/
model CustomizableConnectorUiConfig {
/**
* Gets or sets custom connector id. optional field.
*/
"id"?: string;
/**
* Gets or sets the connector blade title.
*/
"title": string;
/**
* Gets or sets the connector publisher name.
*/
"publisher": string;
/**
* Gets or sets the connector description in markdown format.
*/
"descriptionMarkdown": string;
/**
* Gets or sets the graph queries to show the current data volume over time.
*/
@identifiers(#[])
"graphQueries": GraphQuery[];
/**
* Gets or sets the data types to check for last data received.
*/
@identifiers(#[])
"dataTypes": ConnectorDataType[];
/**
* Gets or sets the way the connector checks whether the connector is connected.
*/
@identifiers(#[])
"connectivityCriteria": ConnectivityCriterion[];
/**
* The exposure status of the connector to the customers.
*/
"availability"?: ConnectorDefinitionsAvailability;
/**
* The required Permissions for the connector.
*/
"permissions": ConnectorDefinitionsPermissions;
/**
* Gets or sets the instruction steps to enable the connector.
*/
@identifiers(#[])
"instructionSteps": InstructionStep[];
/**
* Gets or sets the connector logo to be used when displaying the connector within Azure Sentinel's connector's gallery.
* The logo value should be in SVG format.
*/
"logo"?: string;
/**
* Gets or sets a value indicating whether to use 'OR'(SOME) or 'AND' between ConnectivityCriteria items.
*/
"isConnectivityCriteriasMatchSome"?: boolean;
}

/**
* The graph query to show the volume of data arriving into the workspace over time.
*/
model GraphQuery {
/**
* Gets or sets the metric name that the query is checking. For example: 'Total data receive'.
*/
"metricName": string;
/**
* Gets or sets the legend for the graph.
*/
"legend": string;
/**
* Gets or sets the base query for the graph.
* The base query is wrapped by Sentinel UI infra with a KQL query, that measures the volume over time.
*/
"baseQuery": string;
}

/**
* The required Permissions for the connector.
*/
model ConnectorDefinitionsPermissions {
/**
* Gets or sets the required tenant permissions for the connector.
*/
"tenant"?: string[];
/**
* Gets or sets the required licenses for the user to create connections.
*/
"licenses"?: string[];
/**
* Gets or sets the resource provider permissions required for the user to create connections.
*/
@identifiers(#[])
"resourceProvider"?: ConnectorDefinitionsResourceProvider[];
/**
* Gets or sets the customs permissions required for the user to create connections.
*/
@identifiers(#[])
"customs"?: CustomPermissionDetails[];
}

/**
* The resource provider details include the required permissions for the user to create connections.
* The user should have the required permissions(Read\Write, ..) in the specified scope ProviderPermissionsScope against the specified resource provider.
*/
model ConnectorDefinitionsResourceProvider {
/**
* Gets or sets the provider name.
*/
"provider": string;
/**
* Gets or sets the permissions description text.
*/
"permissionsDisplayText": string;
/**
* Gets or sets the permissions provider display name.
*/
"providerDisplayName": string;
/**
* The scope on which the user should have permissions, in order to be able to create connections.
*/
"scope": ProviderPermissionsScope;
/**
* Required permissions for the connector resource provider that define in ResourceProviders.
* For more information about the permissions see <see href="https://docs.microsoft.com/en-us/azure/role-based-access-control/role-definitions#actions-format">here</see>.
*/
"requiredPermissions": ResourceProviderRequiredPermissions;
}

/**
* Required permissions for the connector resource provider that define in ResourceProviders.
* For more information about the permissions see <see href="https://docs.microsoft.com/en-us/azure/role-based-access-control/role-definitions#actions-format">here</see>.
*/
model ResourceProviderRequiredPermissions {
/**
* Gets or sets a value indicating whether the permission is read action (GET).
*/
"read"?: boolean;
/**
* Gets or sets a value indicating whether the permission is write action (PUT or PATCH).
*/
"write"?: boolean;
/**
* Gets or sets a value indicating whether the permission is delete action (DELETE).
*/
"delete"?: boolean;
/**
* Gets or sets a value indicating whether the permission is custom actions (POST).
*/
"action"?: boolean;
}

/**
* The Custom permissions required for the connector.
*/
model CustomPermissionDetails {
/**
* Gets or sets the custom permissions name.
*/
"name": string;
/**
* Gets or sets the custom permissions description.
*/
"description": string;
}

/**
* Instruction steps to enable the connector.
*/
model InstructionStep {
/**
* Gets or sets the instruction step title.
*/
"title"?: string;
/**
* Gets or sets the instruction step description.
*/
"description"?: string;
/**
* Gets or sets the instruction step details.
*/
@identifiers(#[])
"instructions"?: InstructionStepDetails[];
/**
* Gets or sets the inner instruction steps details.
* For Example: instruction step 1 might contain inner instruction steps: [instruction step 1.1, instruction step 1.2].
*/
@identifiers(#[])
"innerSteps"?: InstructionStep[];
}

/**
* Instruction step details, to be displayed in the Instructions steps section in the connector's page in Sentinel Portal.
*/
model InstructionStepDetails {
/**
* Gets or sets the instruction type parameters settings.
*/
"parameters": unknown;
/**
* Gets or sets the instruction type name.
*/
"type": string;
}

/**
* The UiConfig for 'Customizable' connector definition kind.
*/
model CustomizableConnectionsConfig {
/**
* Gets or sets the template name. The template includes ARM templates that can be created by the connector, usually it will be the dataConnectors ARM templates.
*/
"templateSpecName": string;
/**
* Gets or sets the template version.
*/
"templateSpecVersion": string;
}

/**
* Represents AADIP (Azure Active Directory Identity Protection) requirements check request.
*/
model AADCheckRequirements extends DataConnectorsCheckRequirements {
/**
* AADIP (Azure Active Directory Identity Protection) requirements check properties.
*/
"properties"?: AADCheckRequirementsProperties;
/**
* Describes the kind of connector to be checked.
*/
"kind": "AzureActiveDirectory";
}

/**
* AADIP (Azure Active Directory Identity Protection) requirements check properties.
*/
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model AADCheckRequirementsProperties extends DataConnectorTenantId {
}

/**
* Properties data connector on tenant level.
*/
model DataConnectorTenantId {
/**
* The tenant id to connect to, and get the data from.
*/
"tenantId": string;
}

/**
* Represents AATP (Azure Advanced Threat Protection) requirements check request.
*/
model AatpCheckRequirements extends DataConnectorsCheckRequirements {
/**
* AATP (Azure Advanced Threat Protection) requirements check properties.
*/
"properties"?: AatpCheckRequirementsProperties;
/**
* Describes the kind of connector to be checked.
*/
"kind": "AzureAdvancedThreatProtection";
}

/**
* AATP (Azure Advanced Threat Protection) requirements check properties.
*/
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model AatpCheckRequirementsProperties extends DataConnectorTenantId {
}

/**
* Represents ASC (Azure Security Center) requirements check request.
*/
model ASCCheckRequirements extends DataConnectorsCheckRequirements {
/**
* ASC (Azure Security Center) requirements check properties.
*/
"properties"?: ASCCheckRequirementsProperties;
/**
* Describes the kind of connector to be checked.
*/
"kind": "AzureSecurityCenter";
}

/**
* ASC (Azure Security Center) requirements check properties.
*/
model ASCCheckRequirementsProperties {
/**
* The subscription id to connect to, and get the data from.
*/
"subscriptionId"?: string;
}

/**
* Amazon Web Services CloudTrail requirements check request.
*/
model AwsCloudTrailCheckRequirements extends DataConnectorsCheckRequirements {
/**
* Describes the kind of connector to be checked.
*/
"kind": "AmazonWebServicesCloudTrail";
}

/**
* Amazon Web Services S3 requirements check request.
*/
model AwsS3CheckRequirements extends DataConnectorsCheckRequirements {
/**
* Describes the kind of connector to be checked.
*/
"kind": "AmazonWebServicesS3";
}

/**
* Represents Dynamics365 requirements check request.
*/
model Dynamics365CheckRequirements extends DataConnectorsCheckRequirements {
/**
* Dynamics365 requirements check properties.
*/
"properties"?: Dynamics365CheckRequirementsProperties;
/**
* Describes the kind of connector to be checked.
*/
"kind": "Dynamics365";
}

/**
* Dynamics365 requirements check properties.
*/
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model Dynamics365CheckRequirementsProperties extends DataConnectorTenantId {
}

/**
* Represents MCAS (Microsoft Cloud App Security) requirements check request.
*/
model McasCheckRequirements extends DataConnectorsCheckRequirements {
/**
* MCAS (Microsoft Cloud App Security) requirements check properties.
*/
"properties"?: McasCheckRequirementsProperties;
/**
* Describes the kind of connector to be checked.
*/
"kind": "MicrosoftCloudAppSecurity";
}

/**
* MCAS (Microsoft Cloud App Security) requirements check properties.
*/
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model McasCheckRequirementsProperties extends DataConnectorTenantId {
}

/**
* Represents MDATP (Microsoft Defender Advanced Threat Protection) requirements check request.
*/
model MdatpCheckRequirements extends DataConnectorsCheckRequirements {
/**
* MDATP (Microsoft Defender Advanced Threat Protection) requirements check properties.
*/
"properties"?: MdatpCheckRequirementsProperties;
/**
* Describes the kind of connector to be checked.
*/
"kind": "MicrosoftDefenderAdvancedThreatProtection";
}

/**
* MDATP (Microsoft Defender Advanced Threat Protection) requirements check properties.
*/
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model MdatpCheckRequirementsProperties extends DataConnectorTenantId {
}

/**
* Represents Microsoft Threat Intelligence requirements check request.
*/
model MstiCheckRequirements extends DataConnectorsCheckRequirements {
/**
* Microsoft Threat Intelligence requirements check properties.
*/
"properties"?: MstiCheckRequirementsProperties;
/**
* Describes the kind of connector to be checked.
*/
"kind": "MicrosoftThreatIntelligence";
}

/**
* Microsoft Threat Intelligence requirements check properties.
*/
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model MstiCheckRequirementsProperties extends DataConnectorTenantId {
}

/**
* Represents MTP (Microsoft Threat Protection) requirements check request.
*/
model MtpCheckRequirements extends DataConnectorsCheckRequirements {
/**
* MTP (Microsoft Threat Protection) requirements check properties.
*/
"properties"?: MTPCheckRequirementsProperties;
/**
* Describes the kind of connector to be checked.
*/
"kind": "MicrosoftThreatProtection";
}

/**
* MTP (Microsoft Threat Protection) requirements check properties.
*/
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model MTPCheckRequirementsProperties extends DataConnectorTenantId {
}

/**
* Represents OfficeATP (Office 365 Advanced Threat Protection) requirements check request.
*/
model OfficeATPCheckRequirements extends DataConnectorsCheckRequirements {
/**
* OfficeATP (Office 365 Advanced Threat Protection) requirements check properties.
*/
"properties"?: OfficeATPCheckRequirementsProperties;
/**
* Describes the kind of connector to be checked.
*/
"kind": "OfficeATP";
}

/**
* OfficeATP (Office 365 Advanced Threat Protection) requirements check properties.
*/
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model OfficeATPCheckRequirementsProperties extends DataConnectorTenantId {
}

/**
* Represents OfficeIRM (Microsoft Insider Risk Management) requirements check request.
*/
model OfficeIRMCheckRequirements extends DataConnectorsCheckRequirements {
/**
* OfficeIRM (Microsoft Insider Risk Management) requirements check properties.
*/
"properties"?: OfficeIRMCheckRequirementsProperties;
/**
* Describes the kind of connector to be checked.
*/
"kind": "OfficeIRM";
}

/**
* OfficeIRM (Microsoft Insider Risk Management) requirements check properties.
*/
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model OfficeIRMCheckRequirementsProperties extends DataConnectorTenantId {
}

/**
* Represents MicrosoftPurviewInformationProtection requirements check request.
*/
model MicrosoftPurviewInformationProtectionCheckRequirements extends DataConnectorsCheckRequirements {
/**
* MicrosoftPurviewInformationProtection requirements check properties.
*/
"properties"?: MicrosoftPurviewInformationProtectionCheckRequirementsProperties;
/**
* Describes the kind of connector to be checked.
*/
"kind": "MicrosoftPurviewInformationProtection";
}

/**
* MicrosoftPurviewInformationProtection requirements check properties.
*/
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model MicrosoftPurviewInformationProtectionCheckRequirementsProperties extends DataConnectorTenantId {
}

/**
* Represents Office365 Project requirements check request.
*/
model Office365ProjectCheckRequirements extends DataConnectorsCheckRequirements {
/**
* Office365 Project requirements check properties.
*/
"properties"?: Office365ProjectCheckRequirementsProperties;
/**
* Describes the kind of connector to be checked.
*/
"kind": "Office365Project";
}

/**
* Office365 Project requirements check properties.
*/
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model Office365ProjectCheckRequirementsProperties extends DataConnectorTenantId {
}

/**
* Represents Office PowerBI requirements check request.
*/
model OfficePowerBICheckRequirements extends DataConnectorsCheckRequirements {
/**
* Office Power BI requirements check properties.
*/
"properties"?: OfficePowerBICheckRequirementsProperties;
/**
* Describes the kind of connector to be checked.
*/
"kind": "OfficePowerBI";
}

/**
* Office PowerBI requirements check properties.
*/
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model OfficePowerBICheckRequirementsProperties extends DataConnectorTenantId {
}

/**
* Represents PurviewAudit requirements check request.
*/
model PurviewAuditCheckRequirements extends DataConnectorsCheckRequirements {
/**
* PurviewAudit requirements check properties.
*/
"properties"?: PurviewAuditCheckRequirementsProperties;
/**
* Describes the kind of connector to be checked.
*/
"kind": "PurviewAudit";
}

/**
* PurviewAudit requirements check properties.
*/
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model PurviewAuditCheckRequirementsProperties extends DataConnectorTenantId {
}

/**
* Threat Intelligence Platforms data connector check requirements
*/
model TICheckRequirements extends DataConnectorsCheckRequirements {
/**
* Threat Intelligence Platforms data connector check required properties
*/
"properties"?: TICheckRequirementsProperties;
/**
* Describes the kind of connector to be checked.
*/
"kind": "ThreatIntelligence";
}

/**
* Threat Intelligence Platforms data connector required properties.
*/
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model TICheckRequirementsProperties extends DataConnectorTenantId {
}

/**
* Threat Intelligence TAXII data connector check requirements
*/
model TiTaxiiCheckRequirements extends DataConnectorsCheckRequirements {
/**
* Threat Intelligence TAXII check required properties.
*/
"properties"?: TiTaxiiCheckRequirementsProperties;
/**
* Describes the kind of connector to be checked.
*/
"kind": "ThreatIntelligenceTaxii";
}

/**
* Threat Intelligence TAXII data connector required properties.
*/
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model TiTaxiiCheckRequirementsProperties extends DataConnectorTenantId {
}

/**
* Represents IoT requirements check request.
*/
model IoTCheckRequirements extends DataConnectorsCheckRequirements {
/**
* IoT requirements check properties.
*/
"properties"?: IoTCheckRequirementsProperties;
/**
* Describes the kind of connector to be checked.
*/
"kind": "IOT";
}

/**
* IoT requirements check properties.
*/
model IoTCheckRequirementsProperties {
/**
* The subscription id to connect to, and get the data from.
*/
"subscriptionId"?: string;
}

/**
* Represents AADIP (Azure Active Directory Identity Protection) data connector.
*/
model AADDataConnector extends DataConnector {
/**
* AADIP (Azure Active Directory Identity Protection) data connector properties.
*/
"properties"?: AADDataConnectorProperties;
/**
* The data connector kind
*/
"kind": "AzureActiveDirectory";
}

/**
* AADIP (Azure Active Directory Identity Protection) data connector properties.
*/
model AADDataConnectorProperties {
...DataConnectorTenantId;
...DataConnectorWithAlertsProperties;
}

/**
* Data connector properties.
*/
model DataConnectorWithAlertsProperties {
/**
* The available data types for the connector.
*/
"dataTypes"?: AlertsDataTypeOfDataConnector;
}

/**
* Alerts data type for data connectors.
*/
model AlertsDataTypeOfDataConnector {
/**
* Alerts data type connection.
*/
"alerts": DataConnectorDataTypeCommon;
}

/**
* Common field for data type in data connectors.
*/
model DataConnectorDataTypeCommon {
/**
* Describe whether this data type connection is enabled or not.
*/
"state": DataTypeState;
}

/**
* Represents Microsoft Threat Intelligence data connector.
*/
model MstiDataConnector extends DataConnector {
/**
* Microsoft Threat Intelligence data connector properties.
*/
"properties"?: MstiDataConnectorProperties;
/**
* The data connector kind
*/
"kind": "MicrosoftThreatIntelligence";
}

/**
* Microsoft Threat Intelligence data connector properties.
*/
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model MstiDataConnectorProperties extends DataConnectorTenantId {
/**
* The available data types for the connector.
*/
"dataTypes": MstiDataConnectorDataTypes;
}

/**
* The available data types for Microsoft Threat Intelligence Platforms data connector.
*/
model MstiDataConnectorDataTypes {
/**
* Data type for Microsoft Threat Intelligence Platforms data connector.
*/
"microsoftEmergingThreatFeed": MstiDataConnectorDataTypesMicrosoftEmergingThreatFeed;
}

/**
* Data type for Microsoft Threat Intelligence Platforms data connector.
*/
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model MstiDataConnectorDataTypesMicrosoftEmergingThreatFeed extends DataConnectorDataTypeCommon {
/**
* The lookback period for the feed to be imported.
*/
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"lookbackPeriod": utcDateTime;
}

/**
* Represents Microsoft Defender for Threat Intelligence Premium data connector.
*/
model PremiumMicrosoftDefenderForThreatIntelligence extends DataConnector {
/**
* Microsoft Defender for Threat Intelligence Premium data connector properties.
*/
"properties"?: PremiumMdtiDataConnectorProperties;
/**
* The data connector kind
*/
"kind": "PremiumMicrosoftDefenderForThreatIntelligence";
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
"lookbackPeriod": utcDateTime;
/**
* The flag to indicate whether the tenant has the premium SKU required to access this connector.
*/
"requiredSKUsPresent"?: boolean;
/**
* The available data types for the connector.
*/
"dataTypes": PremiumMdtiDataConnectorDataTypes;
}

/**
* The available data types for Microsoft Defender for Threat Intelligence Premium data connector.
*/
model PremiumMdtiDataConnectorDataTypes {
/**
* Data type for Microsoft Defender for Threat Intelligence Premium data connector.
*/
"connector": PremiumMdtiDataConnectorDataTypesConnector;
}

/**
* Data type for Microsoft Defender for Threat Intelligence Premium data connector.
*/
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model PremiumMdtiDataConnectorDataTypesConnector extends DataConnectorDataTypeCommon {
}

/**
* Represents MTP (Microsoft Threat Protection) data connector.
*/
model MTPDataConnector extends DataConnector {
/**
* MTP (Microsoft Threat Protection) data connector properties.
*/
"properties"?: MTPDataConnectorProperties;
/**
* The data connector kind
*/
"kind": "MicrosoftThreatProtection";
}

/**
* MTP (Microsoft Threat Protection) data connector properties.
*/
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model MTPDataConnectorProperties extends DataConnectorTenantId {
/**
* The available data types for the connector.
*/
"dataTypes": MTPDataConnectorDataTypes;
/**
* The available filtered providers for the connector.
*/
"filteredProviders"?: MtpFilteredProviders;
}

/**
* The available data types for Microsoft Threat Protection Platforms data connector.
*/
model MTPDataConnectorDataTypes {
/**
* Incidents data type for Microsoft Threat Protection Platforms data connector.
*/
"incidents": MTPDataConnectorDataTypesIncidents;
/**
* Alerts data type for Microsoft Threat Protection Platforms data connector.
*/
"alerts"?: MTPDataConnectorDataTypesAlerts;
}

/**
* Incidents data type for Microsoft Threat Protection Platforms data connector.
*/
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model MTPDataConnectorDataTypesIncidents extends DataConnectorDataTypeCommon {
}

/**
* Alerts data type for Microsoft Threat Protection Platforms data connector.
*/
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model MTPDataConnectorDataTypesAlerts extends DataConnectorDataTypeCommon {
}

/**
* Represents the connector's Filtered providers
*/
model MtpFilteredProviders {
/**
* Alerts filtered providers. When filters are not applied, all alerts will stream through the MTP pipeline, still in private preview for all products EXCEPT MDA and MDI, which are in GA state.
*/
"alerts": MtpProvider[];
}

/**
* Represents AATP (Azure Advanced Threat Protection) data connector.
*/
model AatpDataConnector extends DataConnector {
/**
* AATP (Azure Advanced Threat Protection) data connector properties.
*/
"properties"?: AatpDataConnectorProperties;
/**
* The data connector kind
*/
"kind": "AzureAdvancedThreatProtection";
}

/**
* AATP (Azure Advanced Threat Protection) data connector properties.
*/
model AatpDataConnectorProperties {
...DataConnectorTenantId;
...DataConnectorWithAlertsProperties;
}

/**
* Represents ASC (Azure Security Center) data connector.
*/
model ASCDataConnector extends DataConnector {
/**
* ASC (Azure Security Center) data connector properties.
*/
"properties"?: ASCDataConnectorProperties;
/**
* The data connector kind
*/
"kind": "AzureSecurityCenter";
}

/**
* ASC (Azure Security Center) data connector properties.
*/
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ASCDataConnectorProperties extends DataConnectorWithAlertsProperties {
/**
* The subscription id to connect to, and get the data from.
*/
"subscriptionId"?: string;
}

/**
* Represents Amazon Web Services CloudTrail data connector.
*/
model AwsCloudTrailDataConnector extends DataConnector {
/**
* Amazon Web Services CloudTrail data connector properties.
*/
"properties"?: AwsCloudTrailDataConnectorProperties;
/**
* The data connector kind
*/
"kind": "AmazonWebServicesCloudTrail";
}

/**
* Amazon Web Services CloudTrail data connector properties.
*/
model AwsCloudTrailDataConnectorProperties {
/**
* The Aws Role Arn (with CloudTrailReadOnly policy) that is used to access the Aws account.
*/
"awsRoleArn"?: string;
/**
* The available data types for the connector.
*/
"dataTypes": AwsCloudTrailDataConnectorDataTypes;
}

/**
* The available data types for Amazon Web Services CloudTrail data connector.
*/
model AwsCloudTrailDataConnectorDataTypes {
/**
* Logs data type.
*/
"logs": AwsCloudTrailDataConnectorDataTypesLogs;
}

/**
* Logs data type.
*/
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model AwsCloudTrailDataConnectorDataTypesLogs extends DataConnectorDataTypeCommon {
}

/**
* Represents Amazon Web Services S3 data connector.
*/
model AwsS3DataConnector extends DataConnector {
/**
* Amazon Web Services S3 data connector properties.
*/
"properties"?: AwsS3DataConnectorProperties;
/**
* The data connector kind
*/
"kind": "AmazonWebServicesS3";
}

/**
* Amazon Web Services S3 data connector properties.
*/
model AwsS3DataConnectorProperties {
/**
* The logs destination table name in LogAnalytics.
*/
"destinationTable": string;
/**
* The AWS sqs urls for the connector.
*/
@identifiers(#[])
"sqsUrls": string[];
/**
* The Aws Role Arn that is used to access the Aws account.
*/
"roleArn": string;
/**
* The available data types for the connector.
*/
"dataTypes": AwsS3DataConnectorDataTypes;
}

/**
* The available data types for Amazon Web Services S3 data connector.
*/
model AwsS3DataConnectorDataTypes {
/**
* Logs data type.
*/
"logs": AwsS3DataConnectorDataTypesLogs;
}

/**
* Logs data type.
*/
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model AwsS3DataConnectorDataTypesLogs extends DataConnectorDataTypeCommon {
}

/**
* Represents Rest Api Poller data connector.
*/
model RestApiPollerDataConnector extends DataConnector {
/**
* Rest Api Poller data connector properties.
*/
"properties"?: RestApiPollerDataConnectorProperties;
/**
* The data connector kind
*/
"kind": "RestApiPoller";
}

/**
* Rest Api Poller data connector properties.
*/
model RestApiPollerDataConnectorProperties {
/**
* The connector definition name (the dataConnectorDefinition resource id).
*/
"connectorDefinitionName": string;
/**
* The a authentication model.
*/
"auth": CcpAuthConfig;
/**
* The request configuration.
*/
"request": RestApiPollerRequestConfig;
/**
* The DCR related properties.
*/
"dcrConfig"?: DCRConfiguration;
/**
* Indicates whether the connector is active or not.
*/
"isActive"?: boolean;
/**
* The Log Analytics table destination.
*/
"dataType"?: string;
/**
* The response configuration.
*/
"response"?: CcpResponseConfig;
/**
* The paging configuration.
*/
"paging"?: RestApiPollerRequestPagingConfig;
/**
* The add on attributes. The key name will become attribute name (a column) and the value will become the attribute value in the payload.
*/
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
"addOnAttributes"?: Record<string>;
}

/**
* Base Model for API authentication.
*/
@discriminator("type")
model CcpAuthConfig {
/**
* The auth type
*/
"type": CcpAuthType;
}

/**
* The request configuration.
*/
model RestApiPollerRequestConfig {
/**
* The API endpoint.
*/
"apiEndpoint": string;
/**
* The Rate limit queries per second for the request..
*/
"rateLimitQPS"?: int32;
/**
* The query window in minutes for the request.
*/
"queryWindowInMin"?: int32;
/**
* The HTTP method, default value GET.
*/
"httpMethod"?: HttpMethodVerb;
/**
* The query time format. A remote server can have a query to pull data from range 'start' to 'end'. This property indicate what is the expected time format the remote server know to parse.
*/
"queryTimeFormat"?: string;
/**
* The retry count.
*/
"retryCount"?: int32;
/**
* The timeout in seconds.
*/
"timeoutInSeconds"?: int32;
/**
* Flag to indicate if HTTP POST payload is in JSON format (vs form-urlencoded).
*/
"isPostPayloadJson"?: boolean;
/**
* The header for the request for the remote server.
*/
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
"headers"?: Record<string>;
/**
* The HTTP query parameters to RESTful API.
*/
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
"queryParameters"?: Record<unknown>;
/**
* the query parameters template. Defines the query parameters template to use when passing query parameters in advanced scenarios.
*/
"queryParametersTemplate"?: string;
/**
* The query parameter name which the remote server expect to start query. This property goes hand to hand with `endTimeAttributeName`.
*/
"startTimeAttributeName"?: string;
/**
* The query parameter name which the remote server expect to end query. This property goes hand to hand with `startTimeAttributeName`
*/
"endTimeAttributeName"?: string;
/**
* The query parameter name which we need to send the server for query logs in time interval. Should be defined with `queryTimeIntervalPrepend` and `queryTimeIntervalDelimiter`
*/
"queryTimeIntervalAttributeName"?: string;
/**
* The string prepend to the value of the query parameter in `queryTimeIntervalAttributeName`.
*/
"queryTimeIntervalPrepend"?: string;
/**
* The delimiter string between 2 QueryTimeFormat in the query parameter `queryTimeIntervalAttributeName`.
*/
"queryTimeIntervalDelimiter"?: string;
}

/**
* The configuration of the destination of the data.
*/
model DCRConfiguration {
/**
* Represents the data collection ingestion endpoint in log analytics.
*/
"dataCollectionEndpoint": string;
/**
* The data collection rule immutable id, the rule defines the transformation and data destination.
*/
"dataCollectionRuleImmutableId": string;
/**
* The stream we are sending the data to.
*/
"streamName": string;
}

/**
* A custom response configuration for a rule.
*/
model CcpResponseConfig {
/**
* The json paths, '$' char is the json root.
*/
"eventsJsonPaths": string[];
/**
* The value where the status message/code should appear in the response.
*/
"successStatusJsonPath"?: string;
/**
* The status value.
*/
"successStatusValue"?: string;
/**
* The value indicating whether the remote server support Gzip and we should expect Gzip response.
*/
"isGzipCompressed"?: boolean;
/**
* The compression algorithm. For Example: 'gzip', 'multi-gzip', 'deflate'.
*/
"compressionAlgo"?: string = "gzip";
/**
* The response format. possible values are json,csv,xml
*/
"format"?: string = "json";
/**
* The csv delimiter, in case the response format is CSV.
*/
"csvDelimiter"?: string;
/**
* The value indicating whether the response has CSV boundary in case the response in CSV format.
*/
"hasCsvBoundary"?: boolean;
/**
* The value indicating whether the response has headers in case the response in CSV format.
*/
"hasCsvHeader"?: boolean;
/**
* The value indicating whether the response isn't an array of events / logs.  By setting this flag to true it means the remote server will response with an object which each property has as a value an array of events / logs.
*/
"convertChildPropertiesToArray"?: boolean;
/**
* The character used to escape characters in CSV.
*/
@maxLength(1)
@minLength(1)
"csvEscape"?: string = """;
}

/**
* The request paging configuration.
*/
model RestApiPollerRequestPagingConfig {
/**
* Type of paging
*/
"pagingType": RestApiPollerRequestPagingKind;
/**
* Page size
*/
"pageSize"?: int32;
/**
* Page size parameter name
*/
"pageSizeParameterName"?: string;
}

/**
* The request paging configuration for LinkHeader and PersistentLinkHeader paging type parameters.
*/
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model RestApiPollerRequestPagingLinkHeaderConfig extends RestApiPollerRequestPagingConfig {
/**
* JSON path of link header token in HTTP response payload
*/
"linkHeaderTokenJsonPath"?: string;
/**
* Rel link name from the link header
*/
"linkHeaderRelLinkName"?: string;
}

/**
* The request paging configuration for NextPageToken and PersistentToken paging type parameters.
*/
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model RestApiPollerRequestPagingTokenConfig extends RestApiPollerRequestPagingConfig {
/**
* JSON path of next page token in HTTP response payload
*/
"nextPageTokenJsonPath"?: string;
/**
* JSON path of flag in HTTP response payload to indicate more pages
*/
"hasNextFlagJsonPath"?: string;
/**
* HTTP response header name of next page token
*/
"nextPageTokenResponseHeader"?: string;
/**
* Next page parameter name in HTTP request
*/
"nextPageParaName"?: string;
/**
* Next page header name in the request
*/
"nextPageRequestHeader"?: string;
}

/**
* The request paging configuration for NextPageUrl paging type parameters.
*/
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model RestApiPollerRequestPagingNextPageUrlConfig extends RestApiPollerRequestPagingConfig {
/**
* Next page URL
*/
"nextPageUrl"?: string;
/**
* Query parameters of next page URL
*/
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
"nextPageUrlQueryParameters"?: Record<string>;
/**
* Paging query parameters in string template format
*/
"nextPageUrlQueryParametersTemplate"?: string;
/**
* Next page parameter name in HTTP request
*/
"nextPageParaName"?: string;
/**
* Next page header name in the request
*/
"nextPageRequestHeader"?: string;
/**
* JSON path of flag in HTTP response payload to indicate more pages
*/
"hasNextFlagJsonPath"?: string;
}

/**
* The request paging configuration for Offset paging type parameters.
*/
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model RestApiPollerRequestPagingOffsetConfig extends RestApiPollerRequestPagingConfig {
/**
* Offset parameter name in HTTP request
*/
"offsetParaName"?: string;
}

/**
* The request paging configuration for Count base paging type parameters.
*/
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model RestApiPollerRequestPagingCountBaseConfig extends RestApiPollerRequestPagingConfig {
/**
* Indicates whether the count is zero based
*/
"zeroBasedIndexing"?: boolean;
/**
* JSON path of page count in HTTP response payload
*/
"pageCountJsonPath"?: string;
/**
* Parameter name of page number in HTTP request
*/
"pageNumberParaName"?: string;
/**
* JSON path of page number in HTTP response payload
*/
"pageNumberJsonPath"?: string;
/**
* JSON path of total number of results in HTTP response payload
*/
"totalResultsJsonPath"?: string;
}

/**
* Represents Google Cloud Platform data connector.
*/
model GCPDataConnector extends DataConnector {
/**
* Google Cloud Platform data connector properties.
*/
"properties"?: GCPDataConnectorProperties;
/**
* The data connector kind
*/
"kind": "GCP";
}

/**
* Google Cloud Platform data connector properties.
*/
model GCPDataConnectorProperties {
/**
* The name of the connector definition that represents the UI config.
*/
"connectorDefinitionName": string;
/**
* The auth section of the connector.
*/
"auth": GCPAuthProperties;
/**
* The request section of the connector.
*/
"request": GCPRequestProperties;
/**
* The configuration of the destination of the data.
*/
"dcrConfig"?: DCRConfiguration;
}

/**
* Google Cloud Platform auth section properties.
*/
model GCPAuthProperties {
/**
* The service account that is used to access the GCP project.
*/
"serviceAccountEmail": string;
/**
* The GCP project number.
*/
"projectNumber": string;
/**
* The workload identity provider id that is used to gain access to the GCP project.
*/
"workloadIdentityProviderId": string;
}

/**
* Google Cloud Platform request section properties.
*/
model GCPRequestProperties {
/**
* The GCP project id.
*/
"projectId": string;
/**
* The GCP pub/sub subscription names.
*/
@identifiers(#[])
"subscriptionNames": string[];
}

/**
* Model for authentication with the API Key. Will result in additional header on the request (default behavior) to the remote server: 'ApiKeyName: ApiKeyIdentifier ApiKey'. If 'IsApiKeyInPostPayload' is true it will send it in the body of the request and not the header.
*/
model ApiKeyAuthModel extends CcpAuthConfig {
/**
* API Key for the user secret key credential
*/
"apiKey": string;
/**
* API Key name
*/
"apiKeyName": string;
/**
* API Key Identifier
*/
"apiKeyIdentifier"?: string;
/**
* Flag to indicate if API key is set in HTTP POST payload
*/
"isApiKeyInPostPayload"?: boolean;
/**
* The auth type
*/
"type": "APIKey";
}

/**
* Model for API authentication with AWS.
*/
model AWSAuthModel extends CcpAuthConfig {
/**
* AWS STS assume role ARN
*/
"roleArn": string;
/**
* AWS STS assume role external ID. This is used to prevent the confused deputy problem: 'https://docs.aws.amazon.com/IAM/latest/UserGuide/confused-deputy.html'
*/
"externalId"?: string;
/**
* The auth type
*/
"type": "AWS";
}

/**
* Model for API authentication with basic flow - user name + password.
*/
model BasicAuthModel extends CcpAuthConfig {
/**
* The user name.
*/
"userName": string;
/**
* The password
*/
"password": string;
/**
* The auth type
*/
"type": "Basic";
}

/**
* Model for API authentication for all GCP kind connectors.
*/
model GCPAuthModel extends CcpAuthConfig {
/**
* GCP Service Account Email
*/
"serviceAccountEmail": string;
/**
* GCP Project Number
*/
"projectNumber": string;
/**
* GCP Workload Identity Provider ID
*/
"workloadIdentityProviderId": string;
/**
* The auth type
*/
"type": "GCP";
}

/**
* Model for API authentication for working with service bus or storage account.
*/
model GenericBlobSbsAuthModel extends CcpAuthConfig {
/**
* Credentials for service bus namespace, keyvault uri for access key
*/
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
"credentialsConfig"?: Record<string>;
/**
* Credentials for storage account, keyvault uri for access key
*/
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
"storageAccountCredentialsConfig"?: Record<string>;
/**
* The auth type
*/
"type": "ServiceBus";
}

/**
* Model for API authentication for GitHub. For this authentication first we need to approve the Router app (Microsoft Security DevOps) to access the GitHub account, Then we only need the InstallationId to get the access token from https://api.github.com/app/installations/{installId}/access_tokens.
*/
model GitHubAuthModel extends CcpAuthConfig {
/**
* The GitHubApp auth installation id.
*/
"installationId"?: string;
/**
* The auth type
*/
"type": "GitHub";
}

/**
* Model for API authentication with no authentication method - public API.
*/
model NoneAuthModel extends CcpAuthConfig {
/**
* The auth type
*/
"type": "None";
}

/**
* Model for API authentication with JWT. Simple exchange between user name + password to access token.
*/
model JwtAuthModel extends CcpAuthConfig {
/**
* Token endpoint to request JWT
*/
"tokenEndpoint": string;
/**
* The user name. If user name and password sent in header request we only need to populate the `value` property with the user name (Same as basic auth). If user name and password sent in body request we need to specify the `Key` and `Value`.
*/
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
"userName": Record<string>;
/**
* The password
*/
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
"password": Record<string>;
/**
* The custom query parameter we want to add once we send request to token endpoint.
*/
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
"queryParameters"?: Record<string>;
/**
* The custom headers we want to add once we send request to token endpoint.
*/
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
"headers"?: Record<string>;
/**
* Flag indicating whether we want to send the user name and password to token endpoint in the headers.
*/
"isCredentialsInHeaders"?: boolean;
/**
* Flag indicating whether the body request is JSON (header Content-Type = application/json), meaning its a Form URL encoded request (header Content-Type = application/x-www-form-urlencoded).
*/
"isJsonRequest"?: boolean;
/**
* Request timeout in seconds.
*/
@maxValue(180)
"requestTimeoutInSeconds"?: int32 = 100;
/**
* The auth type
*/
"type": "JwtToken";
}

/**
* Model for API authentication with OAuth2.
*/
model OAuthModel extends CcpAuthConfig {
/**
* The user's authorization code.
*/
"authorizationCode"?: string;
/**
* The Application (client) secret that the OAuth provider assigned to your app.
*/
"clientSecret": string;
/**
* The Application (client) ID that the OAuth provider assigned to your app.
*/
"clientId": string;
/**
* Indicating whether we want to send the clientId and clientSecret to token endpoint in the headers.
*/
"isCredentialsInHeaders"?: boolean;
/**
* The Application (client) Scope that the OAuth provider assigned to your app.
*/
"scope"?: string;
/**
* The Application redirect url that the user config in the OAuth provider.
*/
"redirectUri"?: url;
/**
* The grant type, usually will be 'authorization code'.
*/
"grantType": string;
/**
* The token endpoint. Defines the OAuth2 refresh token.
*/
"tokenEndpoint": string;
/**
* The token endpoint headers.
*/
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
"tokenEndpointHeaders"?: Record<string>;
/**
* The token endpoint query parameters.
*/
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
"tokenEndpointQueryParameters"?: Record<string>;
/**
* The authorization endpoint.
*/
"authorizationEndpoint"?: string;
/**
* The authorization endpoint headers.
*/
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
"authorizationEndpointHeaders"?: Record<string>;
/**
* The authorization endpoint query parameters.
*/
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
"authorizationEndpointQueryParameters"?: Record<string>;
/**
* A value indicating whether it's a JWT flow.
*/
"isJwtBearerFlow"?: boolean;
/**
* Access token prepend. Default is 'Bearer'.
*/
"accessTokenPrepend"?: string;
/**
* The auth type
*/
"type": "OAuth2";
}

/**
* Model for API authentication for Oracle.
*/
model OracleAuthModel extends CcpAuthConfig {
/**
* Oracle tenant ID
*/
"tenantId": string;
/**
* Oracle user ID
*/
"userId": string;
/**
* Public Fingerprint
*/
"publicFingerprint": string;
/**
* Content of the PRM file
*/
"pemFile": string;
/**
* The auth type
*/
"type": "Oracle";
}

/**
* Model for API authentication with session cookie.
*/
model SessionAuthModel extends CcpAuthConfig {
/**
* The user name attribute key value.
*/
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
"userName": Record<string>;
/**
* The password attribute name.
*/
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
"password": Record<string>;
/**
* Query parameters to session service endpoint.
*/
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
"queryParameters"?: Record<unknown>;
/**
* Indicating whether API key is set in HTTP POST payload.
*/
"isPostPayloadJson"?: boolean;
/**
* HTTP request headers to session service endpoint.
*/
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
"headers"?: Record<string>;
/**
* Session timeout in minutes.
*/
"sessionTimeoutInMinutes"?: int32;
/**
* Session id attribute name from HTTP response header.
*/
"sessionIdName"?: string;
/**
* HTTP request URL to session service endpoint.
*/
"sessionLoginRequestUri"?: string;
/**
* The auth type
*/
"type": "Session";
}

/**
* Represents MCAS (Microsoft Cloud App Security) data connector.
*/
model McasDataConnector extends DataConnector {
/**
* MCAS (Microsoft Cloud App Security) data connector properties.
*/
"properties"?: McasDataConnectorProperties;
/**
* The data connector kind
*/
"kind": "MicrosoftCloudAppSecurity";
}

/**
* MCAS (Microsoft Cloud App Security) data connector properties.
*/
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model McasDataConnectorProperties extends DataConnectorTenantId {
/**
* The available data types for the connector.
*/
"dataTypes": McasDataConnectorDataTypes;
}

/**
* The available data types for MCAS (Microsoft Cloud App Security) data connector.
*/
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model McasDataConnectorDataTypes extends AlertsDataTypeOfDataConnector {
/**
* Discovery log data type connection.
*/
"discoveryLogs"?: DataConnectorDataTypeCommon;
}

/**
* Represents Dynamics365 data connector.
*/
model Dynamics365DataConnector extends DataConnector {
/**
* Dynamics365 data connector properties.
*/
"properties"?: Dynamics365DataConnectorProperties;
/**
* The data connector kind
*/
"kind": "Dynamics365";
}

/**
* Dynamics365 data connector properties.
*/
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model Dynamics365DataConnectorProperties extends DataConnectorTenantId {
/**
* The available data types for the connector.
*/
"dataTypes": Dynamics365DataConnectorDataTypes;
}

/**
* The available data types for Dynamics365 data connector.
*/
model Dynamics365DataConnectorDataTypes {
/**
* Common Data Service data type connection.
*/
"dynamics365CdsActivities": Dynamics365DataConnectorDataTypesDynamics365CdsActivities;
}

/**
* Common Data Service data type connection.
*/
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model Dynamics365DataConnectorDataTypesDynamics365CdsActivities extends DataConnectorDataTypeCommon {
}

/**
* Represents OfficeATP (Office 365 Advanced Threat Protection) data connector.
*/
model OfficeATPDataConnector extends DataConnector {
/**
* OfficeATP (Office 365 Advanced Threat Protection) data connector properties.
*/
"properties"?: OfficeATPDataConnectorProperties;
/**
* The data connector kind
*/
"kind": "OfficeATP";
}

/**
* OfficeATP (Office 365 Advanced Threat Protection) data connector properties.
*/
model OfficeATPDataConnectorProperties {
...DataConnectorTenantId;
...DataConnectorWithAlertsProperties;
}

/**
* Represents Microsoft Purview Information Protection data connector.
*/
model MicrosoftPurviewInformationProtectionDataConnector extends DataConnector {
/**
* Microsoft Purview Information Protection data connector properties.
*/
"properties"?: MicrosoftPurviewInformationProtectionDataConnectorProperties;
/**
* The data connector kind
*/
"kind": "MicrosoftPurviewInformationProtection";
}

/**
* Microsoft Purview Information Protection data connector properties.
*/
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model MicrosoftPurviewInformationProtectionDataConnectorProperties extends DataConnectorTenantId {
/**
* The available data types for the connector.
*/
"dataTypes": MicrosoftPurviewInformationProtectionConnectorDataTypes;
}

/**
* The available data types for Microsoft Purview Information Protection data connector.
*/
model MicrosoftPurviewInformationProtectionConnectorDataTypes {
/**
* Logs data type.
*/
"logs": MicrosoftPurviewInformationProtectionConnectorDataTypesLogs;
}

/**
* Logs data type.
*/
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model MicrosoftPurviewInformationProtectionConnectorDataTypesLogs extends DataConnectorDataTypeCommon {
}

/**
* Represents Office Microsoft Project data connector.
*/
model Office365ProjectDataConnector extends DataConnector {
/**
* Office Microsoft Project data connector properties.
*/
"properties"?: Office365ProjectDataConnectorProperties;
/**
* The data connector kind
*/
"kind": "Office365Project";
}

/**
* Office Microsoft Project data connector properties.
*/
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model Office365ProjectDataConnectorProperties extends DataConnectorTenantId {
/**
* The available data types for the connector.
*/
"dataTypes": Office365ProjectConnectorDataTypes;
}

/**
* The available data types for Office Microsoft Project data connector.
*/
model Office365ProjectConnectorDataTypes {
/**
* Logs data type.
*/
"logs": Office365ProjectConnectorDataTypesLogs;
}

/**
* Logs data type.
*/
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model Office365ProjectConnectorDataTypesLogs extends DataConnectorDataTypeCommon {
}

/**
* Represents Office Microsoft PowerBI data connector.
*/
model OfficePowerBIDataConnector extends DataConnector {
/**
* Office Microsoft PowerBI data connector properties.
*/
"properties"?: OfficePowerBIDataConnectorProperties;
/**
* The data connector kind
*/
"kind": "OfficePowerBI";
}

/**
* Office Microsoft PowerBI data connector properties.
*/
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model OfficePowerBIDataConnectorProperties extends DataConnectorTenantId {
/**
* The available data types for the connector.
*/
"dataTypes": OfficePowerBIConnectorDataTypes;
}

/**
* The available data types for Office Microsoft PowerBI data connector.
*/
model OfficePowerBIConnectorDataTypes {
/**
* Logs data type.
*/
"logs": OfficePowerBIConnectorDataTypesLogs;
}

/**
* Logs data type.
*/
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model OfficePowerBIConnectorDataTypesLogs extends DataConnectorDataTypeCommon {
}

/**
* Represents PurviewAudit data connector.
*/
model PurviewAuditDataConnector extends DataConnector {
/**
* PurviewAudit data connector properties.
*/
"properties"?: PurviewAuditDataConnectorProperties;
/**
* The data connector kind
*/
"kind": "PurviewAudit";
}

/**
* PurviewAudit data connector properties.
*/
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model PurviewAuditDataConnectorProperties extends DataConnectorTenantId {
/**
* The connector definition name (the dataConnectorDefinition resource id).
*/
"connectorDefinitionName"?: string;
/**
* The source type indicates which kind of data is relevant for this connector.
*/
"sourceType"?: string;
/**
* The DCR related properties.
*/
"dcrConfig"?: DCRConfiguration;
/**
* The available data types for the connector.
*/
"dataTypes": PurviewAuditConnectorDataTypes;
}

/**
* The available data types for PurviewAudit data connector.
*/
model PurviewAuditConnectorDataTypes {
/**
* Logs data type.
*/
"logs": PurviewAuditConnectorDataTypesLogs;
}

/**
* Logs data type.
*/
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model PurviewAuditConnectorDataTypesLogs extends DataConnectorDataTypeCommon {
}

/**
* Represents OfficeIRM (Microsoft Insider Risk Management) data connector.
*/
model OfficeIRMDataConnector extends DataConnector {
/**
* OfficeIRM (Microsoft Insider Risk Management) data connector properties.
*/
"properties"?: OfficeIRMDataConnectorProperties;
/**
* The data connector kind
*/
"kind": "OfficeIRM";
}

/**
* OfficeIRM (Microsoft Insider Risk Management) data connector properties.
*/
model OfficeIRMDataConnectorProperties {
...DataConnectorTenantId;
...DataConnectorWithAlertsProperties;
}

/**
* Represents MDATP (Microsoft Defender Advanced Threat Protection) data connector.
*/
model MdatpDataConnector extends DataConnector {
/**
* MDATP (Microsoft Defender Advanced Threat Protection) data connector properties.
*/
"properties"?: MdatpDataConnectorProperties;
/**
* The data connector kind
*/
"kind": "MicrosoftDefenderAdvancedThreatProtection";
}

/**
* MDATP (Microsoft Defender Advanced Threat Protection) data connector properties.
*/
model MdatpDataConnectorProperties {
...DataConnectorTenantId;
...DataConnectorWithAlertsProperties;
}

/**
* Represents office data connector.
*/
model OfficeDataConnector extends DataConnector {
/**
* Office data connector properties.
*/
"properties"?: OfficeDataConnectorProperties;
/**
* The data connector kind
*/
"kind": "Office365";
}

/**
* Office data connector properties.
*/
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model OfficeDataConnectorProperties extends DataConnectorTenantId {
/**
* The available data types for the connector.
*/
"dataTypes": OfficeDataConnectorDataTypes;
}

/**
* The available data types for office data connector.
*/
model OfficeDataConnectorDataTypes {
/**
* Exchange data type connection.
*/
"exchange": OfficeDataConnectorDataTypesExchange;
/**
* SharePoint data type connection.
*/
"sharePoint": OfficeDataConnectorDataTypesSharePoint;
/**
* Teams data type connection.
*/
"teams": OfficeDataConnectorDataTypesTeams;
}

/**
* Exchange data type connection.
*/
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model OfficeDataConnectorDataTypesExchange extends DataConnectorDataTypeCommon {
}

/**
* SharePoint data type connection.
*/
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model OfficeDataConnectorDataTypesSharePoint extends DataConnectorDataTypeCommon {
}

/**
* Teams data type connection.
*/
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model OfficeDataConnectorDataTypesTeams extends DataConnectorDataTypeCommon {
}

/**
* Represents threat intelligence data connector.
*/
model TIDataConnector extends DataConnector {
/**
* TI (Threat Intelligence) data connector properties.
*/
"properties"?: TIDataConnectorProperties;
/**
* The data connector kind
*/
"kind": "ThreatIntelligence";
}

/**
* TI (Threat Intelligence) data connector properties.
*/
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model TIDataConnectorProperties extends DataConnectorTenantId {
/**
* The lookback period for the feed to be imported.
*/
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"tipLookbackPeriod"?: utcDateTime;
/**
* The available data types for the connector.
*/
"dataTypes": TIDataConnectorDataTypes;
}

/**
* The available data types for TI (Threat Intelligence) data connector.
*/
model TIDataConnectorDataTypes {
/**
* Data type for indicators connection.
*/
"indicators": TIDataConnectorDataTypesIndicators;
}

/**
* Data type for indicators connection.
*/
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model TIDataConnectorDataTypesIndicators extends DataConnectorDataTypeCommon {
}

/**
* Data connector to pull Threat intelligence data from TAXII 2.0/2.1 server
*/
model TiTaxiiDataConnector extends DataConnector {
/**
* Threat intelligence TAXII data connector properties.
*/
"properties"?: TiTaxiiDataConnectorProperties;
/**
* The data connector kind
*/
"kind": "ThreatIntelligenceTaxii";
}

/**
* Threat Intelligence TAXII data connector properties.
*/
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model TiTaxiiDataConnectorProperties extends DataConnectorTenantId {
/**
* The workspace id.
*/
"workspaceId"?: string;
/**
* The friendly name for the TAXII server.
*/
"friendlyName"?: string;
/**
* The API root for the TAXII server.
*/
"taxiiServer"?: string;
/**
* The collection id of the TAXII server.
*/
"collectionId"?: string;
/**
* The userName for the TAXII server.
*/
"userName"?: string;
/**
* The password for the TAXII server.
*/
"password"?: string;
/**
* The lookback period for the TAXII server.
*/
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"taxiiLookbackPeriod"?: utcDateTime;
/**
* The polling frequency for the TAXII server.
*/
"pollingFrequency": PollingFrequency;
/**
* The available data types for Threat Intelligence TAXII data connector.
*/
"dataTypes": TiTaxiiDataConnectorDataTypes;
}

/**
* The available data types for Threat Intelligence TAXII data connector.
*/
model TiTaxiiDataConnectorDataTypes {
/**
* Data type for TAXII connector.
*/
"taxiiClient": TiTaxiiDataConnectorDataTypesTaxiiClient;
}

/**
* Data type for TAXII connector.
*/
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model TiTaxiiDataConnectorDataTypesTaxiiClient extends DataConnectorDataTypeCommon {
}

/**
* Represents IoT data connector.
*/
model IoTDataConnector extends DataConnector {
/**
* IoT data connector properties.
*/
"properties"?: IoTDataConnectorProperties;
/**
* The data connector kind
*/
"kind": "IOT";
}

/**
* IoT data connector properties.
*/
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model IoTDataConnectorProperties extends DataConnectorWithAlertsProperties {
/**
* The subscription id to connect to, and get the data from.
*/
"subscriptionId"?: string;
}

/**
* Represents Codeless UI data connector.
*/
model CodelessUiDataConnector extends DataConnector {
/**
* Codeless UI data connector properties
*/
"properties"?: CodelessParameters;
/**
* The data connector kind
*/
"kind": "GenericUI";
}

/**
* Represents Codeless UI data connector
*/
model CodelessParameters {
/**
* Config to describe the instructions blade
*/
"connectorUiConfig"?: CodelessUiConnectorConfigProperties;
}

/**
* Config to describe the instructions blade
*/
model CodelessUiConnectorConfigProperties {
/**
* Connector blade title
*/
"title": string;
/**
* Connector publisher name
*/
"publisher": string;
/**
* Connector description
*/
"descriptionMarkdown": string;
/**
* An optional custom image to be used when displaying the connector within Azure Sentinel's connector's gallery
*/
"customImage"?: string;
/**
* Name of the table the connector will insert the data to
*/
"graphQueriesTableName": string;
/**
* The graph query to show the current data status
*/
@identifiers(#[])
"graphQueries": CodelessUiConnectorConfigPropertiesGraphQueriesItem[];
/**
* The sample queries for the connector
*/
@identifiers(#[])
"sampleQueries": CodelessUiConnectorConfigPropertiesSampleQueriesItem[];
/**
* Data types to check for last data received
*/
@identifiers(#[])
"dataTypes": CodelessUiConnectorConfigPropertiesDataTypesItem[];
/**
* Define the way the connector check connectivity
*/
@identifiers(#[])
"connectivityCriteria": CodelessUiConnectorConfigPropertiesConnectivityCriteriaItem[];
/**
* Connector Availability Status
*/
"availability": Availability;
/**
* Permissions required for the connector
*/
"permissions": Permissions;
/**
* Instruction steps to enable the connector
*/
@identifiers(#[])
"instructionSteps": CodelessUiConnectorConfigPropertiesInstructionStepsItem[];
}


#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model CodelessUiConnectorConfigPropertiesGraphQueriesItem extends GraphQueries {
}

/**
* The graph query to show the current data status
*/
model GraphQueries {
/**
* the metric that the query is checking
*/
"metricName"?: string;
/**
* The legend for the graph
*/
"legend"?: string;
/**
* The base query for the graph
*/
"baseQuery"?: string;
}


#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model CodelessUiConnectorConfigPropertiesSampleQueriesItem extends SampleQueries {
}

/**
* The sample queries for the connector
*/
model SampleQueries {
/**
* The sample query description
*/
"description"?: string;
/**
* the sample query
*/
"query"?: string;
}


#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model CodelessUiConnectorConfigPropertiesDataTypesItem extends LastDataReceivedDataType {
}

/**
* Data type for last data received
*/
model LastDataReceivedDataType {
/**
* Name of the data type to show in the graph. can be use with {{graphQueriesTableName}} placeholder
*/
"name"?: string;
/**
* Query for indicate last data received
*/
"lastDataReceivedQuery"?: string;
}


#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model CodelessUiConnectorConfigPropertiesConnectivityCriteriaItem extends ConnectivityCriteria {
}

/**
* Setting for the connector check connectivity
*/
model ConnectivityCriteria {
/**
* type of connectivity
*/
"type"?: ConnectivityType;
/**
* Queries for checking connectivity
*/
@identifiers(#[])
"value"?: string[];
}

/**
* Connector Availability Status
*/
model Availability {
/**
* The connector Availability Status
*/
"status"?: 1;
/**
* Set connector as preview
*/
"isPreview"?: boolean;
}

/**
* Permissions required for the connector
*/
model Permissions {
/**
* Resource provider permissions required for the connector
*/
@identifiers(#[])
"resourceProvider"?: PermissionsResourceProviderItem[];
/**
* Customs permissions required for the connector
*/
@identifiers(#[])
"customs"?: PermissionsCustomsItem[];
}


#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model PermissionsResourceProviderItem extends ResourceProvider {
}

/**
* Resource provider permissions required for the connector
*/
model ResourceProvider {
/**
* Provider name
*/
"provider"?: ProviderName;
/**
* Permission description text
*/
"permissionsDisplayText"?: string;
/**
* Permission provider display name
*/
"providerDisplayName"?: string;
/**
* Permission provider scope
*/
"scope"?: PermissionProviderScope;
/**
* Required permissions for the connector
*/
"requiredPermissions"?: RequiredPermissions;
}

/**
* Required permissions for the connector
*/
model RequiredPermissions {
/**
* action permission
*/
"action"?: boolean;
/**
* write permission
*/
"write"?: boolean;
/**
* read permission
*/
"read"?: boolean;
/**
* delete permission
*/
"delete"?: boolean;
}


#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model PermissionsCustomsItem extends Customs {
}

/**
* Customs permissions required for the connector
*/
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model Customs extends CustomsPermission {
}

/**
* Customs permissions required for the connector
*/
model CustomsPermission {
/**
* Customs permissions name
*/
"name"?: string;
/**
* Customs permissions description
*/
"description"?: string;
}


#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model CodelessUiConnectorConfigPropertiesInstructionStepsItem extends InstructionSteps {
}

/**
* Instruction steps to enable the connector
*/
model InstructionSteps {
/**
* Instruction step title
*/
"title"?: string;
/**
* Instruction step description
*/
"description"?: string;
/**
* Instruction step details
*/
@identifiers(#[])
"instructions"?: InstructionStepsInstructionsItem[];
}


#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model InstructionStepsInstructionsItem extends ConnectorInstructionModelBase {
}

/**
* Instruction step details
*/
model ConnectorInstructionModelBase {
/**
* The parameters for the setting
*/
"parameters"?: unknown;
/**
* The kind of the setting
*/
"type": SettingType;
}

/**
* Represents Codeless API Polling data connector.
*/
model CodelessApiPollingDataConnector extends DataConnector {
/**
* Codeless poling data connector properties
*/
"properties"?: ApiPollingParameters;
/**
* The data connector kind
*/
"kind": "APIPolling";
}

/**
* Represents Codeless API Polling data connector
*/
model ApiPollingParameters {
/**
* Config to describe the instructions blade
*/
"connectorUiConfig"?: CodelessUiConnectorConfigProperties;
/**
* Config to describe the polling instructions
*/
"pollingConfig"?: CodelessConnectorPollingConfigProperties;
}

/**
* Config to describe the polling config for API poller connector
*/
model CodelessConnectorPollingConfigProperties {
/**
* The poller active status
*/
"isActive"?: boolean;
/**
* Describe the authentication type of the poller
*/
"auth": CodelessConnectorPollingAuthProperties;
/**
* Describe the poll request config parameters of the poller
*/
"request": CodelessConnectorPollingRequestProperties;
/**
* Describe the poll request paging config of the poller
*/
"paging"?: CodelessConnectorPollingPagingProperties;
/**
* Describe the response config parameters of the poller
*/
"response"?: CodelessConnectorPollingResponseProperties;
}

/**
* Describe the authentication properties needed to successfully authenticate with the server
*/
model CodelessConnectorPollingAuthProperties {
/**
* The authentication type
*/
"authType": string;
/**
* The header name which the token is sent with
*/
"apiKeyName"?: string;
/**
* A prefix send in the header before the actual token
*/
"apiKeyIdentifier"?: string;
/**
* Marks if the key should sent in header
*/
"isApiKeyInPostPayload"?: string;
/**
* Describes the flow name, for example 'AuthCode' for Oauth 2.0
*/
"flowName"?: string;
/**
* The endpoint used to issue a token, used in Oauth 2.0 flow
*/
"tokenEndpoint"?: string;
/**
* The endpoint used to authorize the user, used in Oauth 2.0 flow
*/
"authorizationEndpoint"?: string;
/**
* The query parameters used in authorization request, used in Oauth 2.0 flow
*/
"authorizationEndpointQueryParameters"?: unknown;
/**
* The redirect endpoint where we will get the authorization code, used in Oauth 2.0 flow
*/
"redirectionEndpoint"?: string;
/**
* The query headers used in token request, used in Oauth 2.0 flow
*/
"tokenEndpointHeaders"?: unknown;
/**
* The query parameters used in token request, used in Oauth 2.0 flow
*/
"tokenEndpointQueryParameters"?: unknown;
/**
* Marks if we should send the client secret in header or payload, used in Oauth 2.0 flow
*/
"isClientSecretInHeader"?: boolean;
/**
* The OAuth token scope
*/
"scope"?: string;
}

/**
* Describe the request properties needed to successfully pull from the server
*/
model CodelessConnectorPollingRequestProperties {
/**
* Describe the endpoint we should pull the data from
*/
"apiEndpoint": string;
/**
* Defines the rate limit QPS
*/
"rateLimitQps"?: int32;
/**
* The window interval we will use the pull the data
*/
"queryWindowInMin": int32;
/**
* The http method type we will use in the poll request, GET or POST
*/
"httpMethod": string;
/**
* The time format will be used the query events in a specific window
*/
"queryTimeFormat": string;
/**
* Describe the amount of time we should try and poll the data in case of failure
*/
"retryCount"?: int32;
/**
* The number of seconds we will consider as a request timeout
*/
"timeoutInSeconds"?: int32;
/**
* Describe the headers sent in the poll request
*/
"headers"?: unknown;
/**
* Describe the query parameters sent in the poll request
*/
"queryParameters"?: unknown;
/**
* For advanced scenarios for example user name/password embedded in nested JSON payload
*/
"queryParametersTemplate"?: string;
/**
* This will be used the query events from a start of the time window
*/
"startTimeAttributeName"?: string;
/**
* This will be used the query events from the end of the time window
*/
"endTimeAttributeName"?: string;
}

/**
* Describe the properties needed to make a pagination call
*/
model CodelessConnectorPollingPagingProperties {
/**
* Describes the type. could be 'None', 'PageToken', 'PageCount', 'TimeStamp'
*/
"pagingType": string;
/**
* Defines the name of a next page attribute
*/
"nextPageParaName"?: string;
/**
* Defines the path to a next page token JSON
*/
"nextPageTokenJsonPath"?: string;
/**
* Defines the path to a page count attribute
*/
"pageCountAttributePath"?: string;
/**
* Defines the path to a page total count attribute
*/
"pageTotalCountAttributePath"?: string;
/**
* Defines the path to a paging time stamp attribute
*/
"pageTimeStampAttributePath"?: string;
/**
* Determines whether to search for the latest time stamp in the events list
*/
"searchTheLatestTimeStampFromEventsList"?: string;
/**
* Defines the name of the page size parameter
*/
"pageSizeParaName"?: string;
/**
* Defines the paging size
*/
"pageSize"?: int32;
}

/**
* Describes the response from the external server
*/
model CodelessConnectorPollingResponseProperties {
/**
* Describes the path we should extract the data in the response
*/
@identifiers(#[])
"eventsJsonPaths": string[];
/**
* Describes the path we should extract the status code in the response
*/
"successStatusJsonPath"?: string;
/**
* Describes the path we should extract the status value in the response
*/
"successStatusValue"?: string;
/**
* Describes if the data in the response is Gzip
*/
"isGzipCompressed"?: boolean;
}

/**
* Represents Activity timeline item.
*/
model ActivityTimelineItem extends EntityTimelineItem {
/**
* The activity query id.
*/
"queryId": string;
/**
* The grouping bucket start time.
*/
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"bucketStartTimeUTC": utcDateTime;
/**
* The grouping bucket end time.
*/
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"bucketEndTimeUTC": utcDateTime;
/**
* The time of the first activity in the grouping bucket.
*/
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"firstActivityTimeUTC": utcDateTime;
/**
* The time of the last activity in the grouping bucket.
*/
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"lastActivityTimeUTC": utcDateTime;
/**
* The activity timeline content.
*/
"content": string;
/**
* The activity timeline title.
*/
"title": string;
/**
* The entity query kind type.
*/
"kind": "Activity";
}

/**
* Represents bookmark timeline item.
*/
model BookmarkTimelineItem extends EntityTimelineItem {
/**
* The bookmark azure resource id.
*/
"azureResourceId": string;
/**
* The bookmark display name.
*/
"displayName"?: string;
/**
* The notes of the bookmark
*/
"notes"?: string;
/**
* The bookmark end time.
*/
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"endTimeUtc"?: utcDateTime;
/**
* The bookmark start time.
*/
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"startTimeUtc"?: utcDateTime;
/**
* The bookmark event time.
*/
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"eventTime"?: utcDateTime;
/**
* Describes a user that created the bookmark
*/
"createdBy"?: UserInfo;
/**
* List of labels relevant to this bookmark
*/
"labels"?: string[];
/**
* The entity query kind type.
*/
"kind": "Bookmark";
}

/**
* Represents anomaly timeline item.
*/
model AnomalyTimelineItem extends EntityTimelineItem {
/**
* The anomaly azure resource id.
*/
"azureResourceId": string;
/**
* The anomaly product name.
*/
"productName"?: string;
/**
* The anomaly description.
*/
"description"?: string;
/**
* The anomaly name.
*/
"displayName": string;
/**
* The anomaly end time.
*/
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"endTimeUtc": utcDateTime;
/**
* The anomaly start time.
*/
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"startTimeUtc": utcDateTime;
/**
* The anomaly generated time.
*/
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"timeGenerated": utcDateTime;
/**
* The name of the anomaly vendor.
*/
"vendor"?: string;
/**
* The intent of the anomaly.
*/
"intent"?: string;
/**
* The techniques of the anomaly.
*/
"techniques"?: string[];
/**
* The reasons that cause the anomaly.
*/
"reasons"?: string[];
/**
* The entity query kind type.
*/
"kind": "Anomaly";
}

/**
* An properties abstract Query item for entity
*/
model EntityQueryItemProperties {
/**
* Data types for template
*/
@identifiers(#[])
"dataTypes"?: EntityQueryItemPropertiesDataTypesItem[];
/**
* The type of the entity
*/
"inputEntityType"?: EntityType;
/**
* Data types for template
*/
"requiredInputFieldsSets"?: string[][];
/**
* The query applied only to entities matching to all filters
*/
"entitiesFilter"?: unknown;
}


#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model EntityQueryItemPropertiesDataTypesItem {
/**
* Data type name
*/
"dataType"?: string;
}

/**
* Represents Insight Query.
*/
model InsightQueryItem extends EntityQueryItem {
/**
* Properties bag for InsightQueryItem
*/
"properties"?: InsightQueryItemProperties;
/**
* The kind of the entity query
*/
"kind": "Insight";
}

/**
* Represents Insight Query.
*/
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model InsightQueryItemProperties extends EntityQueryItemProperties {
/**
* The insight display name.
*/
"displayName"?: string;
/**
* The insight description.
*/
"description"?: string;
/**
* The base query of the insight.
*/
"baseQuery"?: string;
/**
* The insight table query.
*/
"tableQuery"?: InsightQueryItemPropertiesTableQuery;
/**
* The insight chart query.
*/
"chartQuery"?: unknown;
/**
* The activity query definitions.
*/
"additionalQuery"?: InsightQueryItemPropertiesAdditionalQuery;
/**
* The insight chart query.
*/
"defaultTimeRange"?: InsightQueryItemPropertiesDefaultTimeRange;
/**
* The insight chart query.
*/
"referenceTimeRange"?: InsightQueryItemPropertiesReferenceTimeRange;
}

/**
* The insight table query.
*/
model InsightQueryItemPropertiesTableQuery {
/**
* List of insight column definitions.
*/
@identifiers(#[])
"columnsDefinitions"?: InsightQueryItemPropertiesTableQueryColumnsDefinitionsItem[];
/**
* List of insight queries definitions.
*/
@identifiers(#[])
"queriesDefinitions"?: InsightQueryItemPropertiesTableQueryQueriesDefinitionsItem[];
}


#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model InsightQueryItemPropertiesTableQueryColumnsDefinitionsItem {
/**
* Insight column header.
*/
"header"?: string;
/**
* Insights Column type.
*/
"outputType"?: OutputType;
/**
* Is query supports deep-link.
*/
"supportDeepLink"?: boolean;
}


#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model InsightQueryItemPropertiesTableQueryQueriesDefinitionsItem {
/**
* Insight column header.
*/
"filter"?: string;
/**
* Insight column header.
*/
"summarize"?: string;
/**
* Insight column header.
*/
"project"?: string;
/**
* Insight column header.
*/
@identifiers(#[])
"linkColumnsDefinitions"?: InsightQueryItemPropertiesTableQueryQueriesDefinitionsPropertiesItemsItem[];
}


#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model InsightQueryItemPropertiesTableQueryQueriesDefinitionsPropertiesItemsItem {
/**
* Insight Link Definition Projected Name.
*/
"projectedName"?: string;
/**
* Insight Link Definition Query.
*/
"Query"?: string;
}

/**
* The activity query definitions.
*/
model InsightQueryItemPropertiesAdditionalQuery {
/**
* The insight query.
*/
"query"?: string;
/**
* The insight text.
*/
"text"?: string;
}

/**
* The insight chart query.
*/
model InsightQueryItemPropertiesDefaultTimeRange {
/**
* The padding for the start time of the query.
*/
"beforeRange"?: string;
/**
* The padding for the end time of the query.
*/
"afterRange"?: string;
}

/**
* The insight chart query.
*/
model InsightQueryItemPropertiesReferenceTimeRange {
/**
* Additional query time for looking back.
*/
"beforeRange"?: string;
}

/**
* Represents security alert timeline item.
*/
model SecurityAlertTimelineItem extends EntityTimelineItem {
/**
* The alert azure resource id.
*/
"azureResourceId": string;
/**
* The alert product name.
*/
"productName"?: string;
/**
* The alert description.
*/
"description"?: string;
/**
* The alert name.
*/
"displayName": string;
/**
* The alert severity.
*/
"severity": AlertSeverity;
/**
* The alert end time.
*/
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"endTimeUtc": utcDateTime;
/**
* The alert start time.
*/
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"startTimeUtc": utcDateTime;
/**
* The alert generated time.
*/
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"timeGenerated": utcDateTime;
/**
* The name of the alert type.
*/
"alertType": string;
/**
* The intent of the alert.
*/
@visibility(Lifecycle.Read)
"intent"?: KillChainIntent;
/**
* The techniques of the alert.
*/
"techniques"?: string[];
/**
* The entity query kind type.
*/
"kind": "SecurityAlert";
}

/**
* Represents Expansion entity query.
*/
model ExpansionEntityQuery extends EntityQuery {
/**
* Expansion entity query properties
*/
"properties"?: ExpansionEntityQueriesProperties;
/**
* the entity query kind
*/
"kind": "Expansion";
}

/**
* Describes expansion entity query properties
*/
model ExpansionEntityQueriesProperties {
/**
* List of the data sources that are required to run the query
*/
"dataSources"?: string[];
/**
* The query display name
*/
"displayName"?: string;
/**
* The type of the query's source entity
*/
"inputEntityType"?: EntityType;
/**
* List of the fields of the source entity that are required to run the query
*/
"inputFields"?: string[];
/**
* List of the desired output types to be constructed from the result
*/
"outputEntityTypes"?: EntityType[];
/**
* The template query string to be parsed and formatted
*/
"queryTemplate"?: string;
}

/**
* Represents Activity entity query.
*/
model ActivityEntityQuery extends EntityQuery {
/**
* Activity entity query properties
*/
"properties"?: ActivityEntityQueriesProperties;
/**
* the entity query kind
*/
"kind": "Activity";
}

/**
* Describes activity entity query properties
*/
model ActivityEntityQueriesProperties {
/**
* The entity query title
*/
"title"?: string;
/**
* The entity query content to display in timeline
*/
"content"?: string;
/**
* The entity query description
*/
"description"?: string;
/**
* The Activity query definitions
*/
"queryDefinitions"?: ActivityEntityQueriesPropertiesQueryDefinitions;
/**
* The type of the query's source entity
*/
"inputEntityType"?: EntityType;
/**
* List of the fields of the source entity that are required to run the query
*/
"requiredInputFieldsSets"?: string[][];
/**
* The query applied only to entities matching to all filters
*/
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
"entitiesFilter"?: Record<string[]>;
/**
* The template id this activity was created from
*/
"templateName"?: string;
/**
* Determines whether this activity is enabled or disabled.
*/
"enabled"?: boolean;
/**
* The time the activity was created
*/
@visibility(Lifecycle.Read)
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"createdTimeUtc"?: utcDateTime;
/**
* The last time the activity was updated
*/
@visibility(Lifecycle.Read)
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"lastModifiedTimeUtc"?: utcDateTime;
}

/**
* The Activity query definitions
*/
model ActivityEntityQueriesPropertiesQueryDefinitions {
/**
* The Activity query to run on a given entity
*/
"query"?: string;
}

/**
* Represents Activity entity query.
*/
model ActivityCustomEntityQuery extends CustomEntityQuery {
/**
* Activity entity query properties
*/
"properties"?: ActivityEntityQueriesProperties;
/**
* the entity query kind
*/
"kind": "Activity";
}

/**
* Represents Activity entity query.
*/
model ActivityEntityQueryTemplate extends EntityQueryTemplate {
/**
* Activity entity query properties
*/
"properties"?: ActivityEntityQueryTemplateProperties;
/**
* the entity query template kind
*/
"kind": "Activity";
}

/**
* Describes activity entity query properties
*/
model ActivityEntityQueryTemplateProperties {
/**
* The entity query title
*/
"title"?: string;
/**
* The entity query content to display in timeline
*/
"content"?: string;
/**
* The entity query description
*/
"description"?: string;
/**
* The Activity query definitions
*/
"queryDefinitions"?: ActivityEntityQueryTemplatePropertiesQueryDefinitions;
/**
* List of required data types for the given entity query template
*/
"dataTypes"?: DataTypeDefinitions[];
/**
* The type of the query's source entity
*/
"inputEntityType"?: EntityType;
/**
* List of the fields of the source entity that are required to run the query
*/
"requiredInputFieldsSets"?: string[][];
/**
* The query applied only to entities matching to all filters
*/
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
"entitiesFilter"?: Record<string[]>;
}

/**
* The Activity query definitions
*/
model ActivityEntityQueryTemplatePropertiesQueryDefinitions {
/**
* The Activity query to run on a given entity
*/
"query"?: string;
/**
* The dimensions we want to summarize the timeline results on, this is comma separated list
*/
"summarizeBy"?: string;
}

/**
* The data type definition
*/
model DataTypeDefinitions {
/**
* The data type name
*/
"dataType"?: string;
}

/**
* Describes team properties
*/
model TeamProperties {
/**
* The name of the team
*/
"teamName": string;
/**
* The description of the team
*/
"teamDescription"?: string;
/**
* List of group IDs to add their members to the team
*/
"groupIds"?: string[];
/**
* List of member IDs to add to the team
*/
"memberIds"?: string[];
}

/**
* Represents Anomaly Security ML Analytics Settings
*/
model AnomalySecurityMLAnalyticsSettings extends SecurityMLAnalyticsSetting {
/**
* Anomaly Security ML Analytics Settings properties
*/
"properties"?: AnomalySecurityMLAnalyticsSettingsProperties;
/**
* The kind of security ML Analytics Settings
*/
"kind": "Anomaly";
}

/**
* AnomalySecurityMLAnalytics settings base property bag.
*/
model AnomalySecurityMLAnalyticsSettingsProperties {
/**
* The description of the SecurityMLAnalyticsSettings.
*/
"description"?: string;
/**
* The display name for settings created by this SecurityMLAnalyticsSettings.
*/
"displayName": string;
/**
* Determines whether this settings is enabled or disabled.
*/
"enabled": boolean;
/**
* The last time that this SecurityMLAnalyticsSettings has been modified.
*/
@visibility(Lifecycle.Read)
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"lastModifiedUtc"?: utcDateTime;
/**
* The required data sources for this SecurityMLAnalyticsSettings
*/
@identifiers(#["connectorId"])
"requiredDataConnectors"?: SecurityMLAnalyticsSettingsDataSource[];
/**
* The tactics of the SecurityMLAnalyticsSettings
*/
"tactics"?: AttackTactic[];
/**
* The techniques of the SecurityMLAnalyticsSettings
*/
"techniques"?: string[];
/**
* The anomaly version of the AnomalySecurityMLAnalyticsSettings.
*/
"anomalyVersion": string;
/**
* The customizable observations of the AnomalySecurityMLAnalyticsSettings.
*/
"customizableObservations"?: unknown;
/**
* The frequency that this SecurityMLAnalyticsSettings will be run.
*/
"frequency": duration;
/**
* The anomaly SecurityMLAnalyticsSettings status
*/
"settingsStatus": SettingsStatus;
/**
* Determines whether this anomaly security ml analytics settings is a default settings
*/
"isDefaultSettings": boolean;
/**
* The anomaly settings version of the Anomaly security ml analytics settings that dictates whether job version gets updated or not.
*/
"anomalySettingsVersion"?: int32;
/**
* The anomaly settings definition Id
*/
#suppress "@azure-tools/typespec-azure-core/no-format"
@format("uuid")
"settingsDefinitionId"?: string;
}

/**
* security ml analytics settings data sources
*/
model SecurityMLAnalyticsSettingsDataSource {
/**
* The connector id that provides the following data types
*/
"connectorId"?: string;
/**
* The data types used by the security ml analytics settings
*/
"dataTypes"?: string[];
}

/**
* Settings with single toggle.
*/
model Anomalies extends Settings {
/**
* Anomalies properties
*/
"properties"?: AnomaliesSettingsProperties;
/**
* The kind of the setting
*/
"kind": "Anomalies";
}

/**
* Anomalies property bag.
*/
model AnomaliesSettingsProperties {
/**
* Determines whether the setting is enable or disabled.
*/
@visibility(Lifecycle.Read)
"isEnabled"?: boolean;
}

/**
* Settings with single toggle.
*/
model EyesOn extends Settings {
/**
* EyesOn properties
*/
"properties"?: EyesOnSettingsProperties;
/**
* The kind of the setting
*/
"kind": "EyesOn";
}

/**
* EyesOn property bag.
*/
model EyesOnSettingsProperties {
/**
* Determines whether the setting is enable or disabled.
*/
@visibility(Lifecycle.Read)
"isEnabled"?: boolean;
}

/**
* Settings with single toggle.
*/
model EntityAnalytics extends Settings {
/**
* EntityAnalytics properties
*/
"properties"?: EntityAnalyticsProperties;
/**
* The kind of the setting
*/
"kind": "EntityAnalytics";
}

/**
* EntityAnalytics property bag.
*/
model EntityAnalyticsProperties {
/**
* The relevant entity providers that are synced
*/
"entityProviders"?: EntityProviders[];
}

/**
* Settings with single toggle.
*/
model Ueba extends Settings {
/**
* Ueba properties
*/
"properties"?: UebaProperties;
/**
* The kind of the setting
*/
"kind": "Ueba";
}

/**
* Ueba property bag.
*/
model UebaProperties {
/**
* The relevant data sources that enriched by ueba
*/
"dataSources"?: UebaDataSources[];
}

/**
* Represents a threat actor in Azure Security Insights.
*/
model ThreatActor extends TIObject {
/**
* The kind of the TI object
*/
"kind": "ThreatActor";
}

/**
* Represents an attack pattern in Azure Security Insights.
*/
model AttackPattern extends TIObject {
/**
* The kind of the TI object
*/
"kind": "AttackPattern";
}

/**
* Represents an identity in Azure Security Insights.
*/
model Identity extends TIObject {
/**
* The kind of the TI object
*/
"kind": "Identity";
}

/**
* Represents a relationship in Azure Security Insights.
*/
model Relationship extends TIObject {
/**
* The kind of the TI object
*/
"kind": "Relationship";
}

/**
* Represents an indicator in Azure Security Insights.
*/
model Indicator extends TIObject {
/**
* The observables of this indicator
*/
"observables"?: IndicatorObservablesItem[];
/**
* The kind of the TI object
*/
"kind": "Indicator";
}

/**
* An observable of this indicator
*/
model IndicatorObservablesItem {
/**
* The type of the observable of this indicator
*/
"type"?: string;
/**
* The value of the observable of this indicator
*/
"value"?: string;
}

/**
* Represents an account entity.
*/
model AccountEntity extends Entity {
/**
* Account entity properties
*/
"properties"?: AccountEntityProperties;
/**
* The kind of the entity.
*/
"kind": "Account";
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
"aadTenantId"?: string;
/**
* The Azure Active Directory user id.
*/
@visibility(Lifecycle.Read)
"aadUserId"?: string;
/**
* The name of the account. This field should hold only the name without any domain added to it, i.e. administrator.
*/
@visibility(Lifecycle.Read)
"accountName"?: string;
/**
* The display name of the account.
*/
@visibility(Lifecycle.Read)
"displayName"?: string;
/**
* The Host entity id that contains the account in case it is a local account (not domain joined)
*/
@visibility(Lifecycle.Read)
"hostEntityId"?: string;
/**
* Determines whether this is a domain account.
*/
@visibility(Lifecycle.Read)
"isDomainJoined"?: boolean;
/**
* The NetBIOS domain name as it appears in the alert format domain/username. Examples: NT AUTHORITY.
*/
@visibility(Lifecycle.Read)
"ntDomain"?: string;
/**
* The objectGUID attribute is a single-value attribute that is the unique identifier for the object, assigned by active directory.
*/
@visibility(Lifecycle.Read)
#suppress "@azure-tools/typespec-azure-core/no-format"
@format("uuid")
"objectGuid"?: string;
/**
* The Azure Active Directory Passport User ID.
*/
@visibility(Lifecycle.Read)
"puid"?: string;
/**
* The account security identifier, e.g. S-1-5-18.
*/
@visibility(Lifecycle.Read)
"sid"?: string;
/**
* The user principal name suffix for the account, in some cases it is also the domain name. Examples: contoso.com.
*/
@visibility(Lifecycle.Read)
"upnSuffix"?: string;
/**
* The fully qualified domain DNS name.
*/
@visibility(Lifecycle.Read)
"dnsDomain"?: string;
}

/**
* Represents an azure resource entity.
*/
model AzureResourceEntity extends Entity {
/**
* AzureResource entity properties
*/
"properties"?: AzureResourceEntityProperties;
/**
* The kind of the entity.
*/
"kind": "AzureResource";
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
"resourceId"?: string;
/**
* The subscription id of the resource
*/
@visibility(Lifecycle.Read)
"subscriptionId"?: string;
}

/**
* Represents a cloud application entity.
*/
model CloudApplicationEntity extends Entity {
/**
* CloudApplication entity properties
*/
"properties"?: CloudApplicationEntityProperties;
/**
* The kind of the entity.
*/
"kind": "CloudApplication";
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
"appId"?: int32;
/**
* The name of the related cloud application.
*/
@visibility(Lifecycle.Read)
"appName"?: string;
/**
* The user defined instance name of the cloud application. It is often used to distinguish between several applications of the same type that a customer has.
*/
@visibility(Lifecycle.Read)
"instanceName"?: string;
}

/**
* Represents a dns entity.
*/
model DnsEntity extends Entity {
/**
* Dns entity properties
*/
"properties"?: DnsEntityProperties;
/**
* The kind of the entity.
*/
"kind": "DnsResolution";
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
"dnsServerIpEntityId"?: string;
/**
* The name of the dns record associated with the alert
*/
@visibility(Lifecycle.Read)
"domainName"?: string;
/**
* An ip entity id for the dns request client
*/
@visibility(Lifecycle.Read)
"hostIpAddressEntityId"?: string;
/**
* Ip entity identifiers for the resolved ip address.
*/
@visibility(Lifecycle.Read)
@identifiers(#[])
"ipAddressEntityIds"?: string[];
}

/**
* Represents a file entity.
*/
model FileEntity extends Entity {
/**
* File entity properties
*/
"properties"?: FileEntityProperties;
/**
* The kind of the entity.
*/
"kind": "File";
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
"directory"?: string;
/**
* The file hash entity identifiers associated with this file
*/
@visibility(Lifecycle.Read)
@identifiers(#[])
"fileHashEntityIds"?: string[];
/**
* The file name without path (some alerts might not include path).
*/
@visibility(Lifecycle.Read)
"fileName"?: string;
/**
* The Host entity id which the file belongs to
*/
@visibility(Lifecycle.Read)
"hostEntityId"?: string;
}

/**
* Represents a file hash entity.
*/
model FileHashEntity extends Entity {
/**
* FileHash entity properties
*/
"properties"?: FileHashEntityProperties;
/**
* The kind of the entity.
*/
"kind": "FileHash";
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
"algorithm"?: FileHashAlgorithm;
/**
* The file hash value.
*/
@visibility(Lifecycle.Read)
"hashValue"?: string;
}

/**
* Represents a host entity.
*/
model HostEntity extends Entity {
/**
* Host entity properties
*/
"properties"?: HostEntityProperties;
/**
* The kind of the entity.
*/
"kind": "Host";
}

/**
* Host entity property bag.
*/
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model HostEntityProperties extends EntityCommonProperties {
/**
* The azure resource id of the VM.
*/
@visibility(Lifecycle.Read)
"azureID"?: string;
/**
* The DNS domain that this host belongs to. Should contain the compete DNS suffix for the domain
*/
@visibility(Lifecycle.Read)
"dnsDomain"?: string;
/**
* The hostname without the domain suffix.
*/
@visibility(Lifecycle.Read)
"hostName"?: string;
/**
* Determines whether this host belongs to a domain.
*/
@visibility(Lifecycle.Read)
"isDomainJoined"?: boolean;
/**
* The host name (pre-windows2000).
*/
@visibility(Lifecycle.Read)
"netBiosName"?: string;
/**
* The NT domain that this host belongs to.
*/
@visibility(Lifecycle.Read)
"ntDomain"?: string;
/**
* The OMS agent id, if the host has OMS agent installed.
*/
@visibility(Lifecycle.Read)
"omsAgentID"?: string;
/**
* The operating system type.
*/
"osFamily"?: OSFamily;
/**
* A free text representation of the operating system. This field is meant to hold specific versions the are more fine grained than OSFamily or future values not supported by OSFamily enumeration
*/
@visibility(Lifecycle.Read)
"osVersion"?: string;
}

/**
* Represents an IoT device entity.
*/
model IoTDeviceEntity extends Entity {
/**
* IoTDevice entity properties
*/
"properties"?: IoTDeviceEntityProperties;
/**
* The kind of the entity.
*/
"kind": "IoTDevice";
}

/**
* IoTDevice entity property bag.
*/
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model IoTDeviceEntityProperties extends EntityCommonProperties {
/**
* The ID of the IoT Device in the IoT Hub
*/
@visibility(Lifecycle.Read)
"deviceId"?: string;
/**
* The friendly name of the device
*/
@visibility(Lifecycle.Read)
"deviceName"?: string;
/**
* The source of the device
*/
@visibility(Lifecycle.Read)
"source"?: string;
/**
* The ID of the security agent running on the device
*/
@visibility(Lifecycle.Read)
#suppress "@azure-tools/typespec-azure-core/no-format"
@format("uuid")
"iotSecurityAgentId"?: string;
/**
* The type of the device
*/
@visibility(Lifecycle.Read)
"deviceType"?: string;
/**
* The vendor of the device
*/
@visibility(Lifecycle.Read)
"vendor"?: string;
/**
* The ID of the edge device
*/
@visibility(Lifecycle.Read)
"edgeId"?: string;
/**
* The MAC address of the device
*/
@visibility(Lifecycle.Read)
"macAddress"?: string;
/**
* The model of the device
*/
@visibility(Lifecycle.Read)
"model"?: string;
/**
* The serial number of the device
*/
@visibility(Lifecycle.Read)
"serialNumber"?: string;
/**
* The firmware version of the device
*/
@visibility(Lifecycle.Read)
"firmwareVersion"?: string;
/**
* The operating system of the device
*/
@visibility(Lifecycle.Read)
"operatingSystem"?: string;
/**
* The AzureResource entity id of the IoT Hub
*/
@visibility(Lifecycle.Read)
"iotHubEntityId"?: string;
/**
* The Host entity id of this device
*/
@visibility(Lifecycle.Read)
"hostEntityId"?: string;
/**
* The IP entity if of this device
*/
@visibility(Lifecycle.Read)
"ipAddressEntityId"?: string;
/**
* A list of TI contexts attached to the IoTDevice entity.
*/
@visibility(Lifecycle.Read)
@identifiers(#[])
"threatIntelligence"?: ThreatIntelligence[];
/**
* A list of protocols of the IoTDevice entity.
*/
@visibility(Lifecycle.Read)
@identifiers(#[])
"protocols"?: string[];
/**
* A list of owners of the IoTDevice entity.
*/
@visibility(Lifecycle.Read)
@identifiers(#[])
"owners"?: string[];
/**
* A list of Nic entity ids of the IoTDevice entity.
*/
@visibility(Lifecycle.Read)
@identifiers(#[])
"nicEntityIds"?: string[];
/**
* The site of the device
*/
@visibility(Lifecycle.Read)
"site"?: string;
/**
* The zone location of the device within a site
*/
@visibility(Lifecycle.Read)
"zone"?: string;
/**
* The sensor the device is monitored by
*/
@visibility(Lifecycle.Read)
"sensor"?: string;
/**
* The subType of the device ('PLC', 'HMI', 'EWS', etc.)
*/
@visibility(Lifecycle.Read)
"deviceSubType"?: string;
/**
* Device importance, determines if the device classified as 'crown jewel'
*/
"importance"?: DeviceImportance;
/**
* The Purdue Layer of the device
*/
@visibility(Lifecycle.Read)
"purdueLayer"?: string;
/**
* Determines whether the device classified as authorized device
*/
@visibility(Lifecycle.Read)
"isAuthorized"?: boolean;
/**
* Determines whether the device classified as programming device
*/
@visibility(Lifecycle.Read)
"isProgramming"?: boolean;
/**
* Is the device classified as a scanner device
*/
@visibility(Lifecycle.Read)
"isScanner"?: boolean;
}

/**
* ThreatIntelligence property bag.
*/
model ThreatIntelligence {
/**
* Confidence (must be between 0 and 1)
*/
@visibility(Lifecycle.Read)
"confidence"?: float64;
/**
* Name of the provider from whom this Threat Intelligence information was received
*/
@visibility(Lifecycle.Read)
"providerName"?: string;
/**
* Report link
*/
@visibility(Lifecycle.Read)
"reportLink"?: string;
/**
* Threat description (free text)
*/
@visibility(Lifecycle.Read)
"threatDescription"?: string;
/**
* Threat name (e.g. "Jedobot malware")
*/
@visibility(Lifecycle.Read)
"threatName"?: string;
/**
* Threat type (e.g. "Botnet")
*/
@visibility(Lifecycle.Read)
"threatType"?: string;
}

/**
* Represents an ip entity.
*/
model IpEntity extends Entity {
/**
* Ip entity properties
*/
"properties"?: IpEntityProperties;
/**
* The kind of the entity.
*/
"kind": "Ip";
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
"address"?: string;
/**
* The geo-location context attached to the ip entity
*/
@visibility(Lifecycle.Read)
"location"?: GeoLocation;
/**
* A list of TI contexts attached to the ip entity.
*/
@visibility(Lifecycle.Read)
@identifiers(#[])
"threatIntelligence"?: ThreatIntelligence[];
}

/**
* The geo-location context attached to the ip entity
*/
model GeoLocation {
/**
* Autonomous System Number
*/
@visibility(Lifecycle.Read)
"asn"?: int32;
/**
* City name
*/
@visibility(Lifecycle.Read)
"city"?: string;
/**
* The country code according to ISO 3166 format
*/
@visibility(Lifecycle.Read)
"countryCode"?: string;
/**
* Country name according to ISO 3166 Alpha 2: the lowercase of the English Short Name
*/
@visibility(Lifecycle.Read)
"countryName"?: string;
/**
* The latitude of the identified location, expressed as a floating point number with range of - 90 to 90. Latitude and longitude are derived from the city or postal code.
*/
@visibility(Lifecycle.Read)
"latitude"?: float64;
/**
* The longitude of the identified location, expressed as a floating point number with range of -180 to 180. Latitude and longitude are derived from the city or postal code.
*/
@visibility(Lifecycle.Read)
"longitude"?: float64;
/**
* State name
*/
@visibility(Lifecycle.Read)
"state"?: string;
}

/**
* Represents a mailbox entity.
*/
model MailboxEntity extends Entity {
/**
* Mailbox entity properties
*/
"properties"?: MailboxEntityProperties;
/**
* The kind of the entity.
*/
"kind": "Mailbox";
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
"mailboxPrimaryAddress"?: string;
/**
* The mailbox's display name
*/
@visibility(Lifecycle.Read)
"displayName"?: string;
/**
* The mailbox's UPN
*/
@visibility(Lifecycle.Read)
"upn"?: string;
/**
* The AzureAD identifier of mailbox. Similar to AadUserId in account entity but this property is specific to mailbox object on office side
*/
@visibility(Lifecycle.Read)
#suppress "@azure-tools/typespec-azure-core/no-format"
@format("uuid")
"externalDirectoryObjectId"?: string;
}

/**
* Represents a mail cluster entity.
*/
model MailClusterEntity extends Entity {
/**
* Mail cluster entity properties
*/
"properties"?: MailClusterEntityProperties;
/**
* The kind of the entity.
*/
"kind": "MailCluster";
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
@identifiers(#[])
"networkMessageIds"?: string[];
/**
* Count of mail messages by DeliveryStatus string representation
*/
@visibility(Lifecycle.Read)
"countByDeliveryStatus"?: unknown;
/**
* Count of mail messages by ThreatType string representation
*/
@visibility(Lifecycle.Read)
"countByThreatType"?: unknown;
/**
* Count of mail messages by ProtectionStatus string representation
*/
@visibility(Lifecycle.Read)
"countByProtectionStatus"?: unknown;
/**
* The threats of mail messages that are part of the mail cluster
*/
@visibility(Lifecycle.Read)
@identifiers(#[])
"threats"?: string[];
/**
* The query that was used to identify the messages of the mail cluster
*/
@visibility(Lifecycle.Read)
"query"?: string;
/**
* The query time
*/
@visibility(Lifecycle.Read)
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"queryTime"?: utcDateTime;
/**
* The number of mail messages that are part of the mail cluster
*/
@visibility(Lifecycle.Read)
"mailCount"?: int32;
/**
* Is this a volume anomaly mail cluster
*/
@visibility(Lifecycle.Read)
"isVolumeAnomaly"?: boolean;
/**
* The source of the mail cluster (default is 'O365 ATP')
*/
@visibility(Lifecycle.Read)
"source"?: string;
/**
* The id of the cluster source
*/
@visibility(Lifecycle.Read)
"clusterSourceIdentifier"?: string;
/**
* The type of the cluster source
*/
@visibility(Lifecycle.Read)
"clusterSourceType"?: string;
/**
* The cluster query start time
*/
@visibility(Lifecycle.Read)
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"clusterQueryStartTime"?: utcDateTime;
/**
* The cluster query end time
*/
@visibility(Lifecycle.Read)
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"clusterQueryEndTime"?: utcDateTime;
/**
* The cluster group
*/
@visibility(Lifecycle.Read)
"clusterGroup"?: string;
}

/**
* Represents a mail message entity.
*/
model MailMessageEntity extends Entity {
/**
* Mail message entity properties
*/
"properties"?: MailMessageEntityProperties;
/**
* The kind of the entity.
*/
"kind": "MailMessage";
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
@identifiers(#[])
"fileEntityIds"?: string[];
/**
* The recipient of this mail message. Note that in case of multiple recipients the mail message is forked and each copy has one recipient
*/
@visibility(Lifecycle.Read)
"recipient"?: string;
/**
* The Urls contained in this mail message
*/
@visibility(Lifecycle.Read)
@identifiers(#[])
"urls"?: string[];
/**
* The threats of this mail message
*/
@visibility(Lifecycle.Read)
@identifiers(#[])
"threats"?: string[];
/**
* The p1 sender's email address
*/
@visibility(Lifecycle.Read)
"p1Sender"?: string;
/**
* The p1 sender's display name
*/
@visibility(Lifecycle.Read)
"p1SenderDisplayName"?: string;
/**
* The p1 sender's domain
*/
@visibility(Lifecycle.Read)
"p1SenderDomain"?: string;
/**
* The sender's IP address
*/
@visibility(Lifecycle.Read)
"senderIP"?: string;
/**
* The p2 sender's email address
*/
@visibility(Lifecycle.Read)
"p2Sender"?: string;
/**
* The p2 sender's display name
*/
@visibility(Lifecycle.Read)
"p2SenderDisplayName"?: string;
/**
* The p2 sender's domain
*/
@visibility(Lifecycle.Read)
"p2SenderDomain"?: string;
/**
* The receive date of this message
*/
@visibility(Lifecycle.Read)
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"receiveDate"?: utcDateTime;
/**
* The network message id of this mail message
*/
@visibility(Lifecycle.Read)
#suppress "@azure-tools/typespec-azure-core/no-format"
@format("uuid")
"networkMessageId"?: string;
/**
* The internet message id of this mail message
*/
@visibility(Lifecycle.Read)
"internetMessageId"?: string;
/**
* The subject of this mail message
*/
@visibility(Lifecycle.Read)
"subject"?: string;
/**
* The language of this mail message
*/
@visibility(Lifecycle.Read)
"language"?: string;
/**
* The threat detection methods
*/
@visibility(Lifecycle.Read)
@identifiers(#[])
"threatDetectionMethods"?: string[];
/**
* The bodyFingerprintBin1
*/
"bodyFingerprintBin1"?: int32;
/**
* The bodyFingerprintBin2
*/
"bodyFingerprintBin2"?: int32;
/**
* The bodyFingerprintBin3
*/
"bodyFingerprintBin3"?: int32;
/**
* The bodyFingerprintBin4
*/
"bodyFingerprintBin4"?: int32;
/**
* The bodyFingerprintBin5
*/
"bodyFingerprintBin5"?: int32;
/**
* The directionality of this mail message
*/
"antispamDirection"?: AntispamMailDirection;
/**
* The delivery action of this mail message like Delivered, Blocked, Replaced etc
*/
"deliveryAction"?: DeliveryAction;
/**
* The delivery location of this mail message like Inbox, JunkFolder etc
*/
"deliveryLocation"?: DeliveryLocation;
}

/**
* Represents a malware entity.
*/
model MalwareEntity extends Entity {
/**
* File entity properties
*/
"properties"?: MalwareEntityProperties;
/**
* The kind of the entity.
*/
"kind": "Malware";
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
"category"?: string;
/**
* List of linked file entity identifiers on which the malware was found
*/
@visibility(Lifecycle.Read)
@identifiers(#[])
"fileEntityIds"?: string[];
/**
* The malware name by the vendor, e.g. Win32/Toga!rfn
*/
@visibility(Lifecycle.Read)
"malwareName"?: string;
/**
* List of linked process entity identifiers on which the malware was found.
*/
@visibility(Lifecycle.Read)
@identifiers(#[])
"processEntityIds"?: string[];
}

/**
* Represents a process entity.
*/
model ProcessEntity extends Entity {
/**
* Process entity properties
*/
"properties"?: ProcessEntityProperties;
/**
* The kind of the entity.
*/
"kind": "Process";
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
"accountEntityId"?: string;
/**
* The command line used to create the process
*/
@visibility(Lifecycle.Read)
"commandLine"?: string;
/**
* The time when the process started to run
*/
@visibility(Lifecycle.Read)
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"creationTimeUtc"?: utcDateTime;
/**
* The elevation token associated with the process.
*/
"elevationToken"?: ElevationToken;
/**
* The host entity id on which the process was running
*/
@visibility(Lifecycle.Read)
"hostEntityId"?: string;
/**
* The session entity id in which the process was running
*/
@visibility(Lifecycle.Read)
"hostLogonSessionEntityId"?: string;
/**
* Image file entity id
*/
@visibility(Lifecycle.Read)
"imageFileEntityId"?: string;
/**
* The parent process entity id.
*/
@visibility(Lifecycle.Read)
"parentProcessEntityId"?: string;
/**
* The process ID
*/
@visibility(Lifecycle.Read)
"processId"?: string;
}

/**
* Represents a registry key entity.
*/
model RegistryKeyEntity extends Entity {
/**
* RegistryKey entity properties
*/
"properties"?: RegistryKeyEntityProperties;
/**
* The kind of the entity.
*/
"kind": "RegistryKey";
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
"hive"?: RegistryHive;
/**
* The registry key path.
*/
@visibility(Lifecycle.Read)
"key"?: string;
}

/**
* Represents a registry value entity.
*/
model RegistryValueEntity extends Entity {
/**
* RegistryKey entity properties
*/
"properties"?: RegistryValueEntityProperties;
/**
* The kind of the entity.
*/
"kind": "RegistryValue";
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
"keyEntityId"?: string;
/**
* String formatted representation of the value data.
*/
@visibility(Lifecycle.Read)
"valueData"?: string;
/**
* The registry value name.
*/
@visibility(Lifecycle.Read)
"valueName"?: string;
/**
* Specifies the data types to use when storing values in the registry, or identifies the data type of a value in the registry.
*/
@visibility(Lifecycle.Read)
"valueType"?: RegistryValueKind;
}

/**
* Represents a security group entity.
*/
model SecurityGroupEntity extends Entity {
/**
* SecurityGroup entity properties
*/
"properties"?: SecurityGroupEntityProperties;
/**
* The kind of the entity.
*/
"kind": "SecurityGroup";
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
"distinguishedName"?: string;
/**
* A single-value attribute that is the unique identifier for the object, assigned by active directory.
*/
@visibility(Lifecycle.Read)
#suppress "@azure-tools/typespec-azure-core/no-format"
@format("uuid")
"objectGuid"?: string;
/**
* The SID attribute is a single-value attribute that specifies the security identifier (SID) of the group
*/
@visibility(Lifecycle.Read)
"sid"?: string;
}

/**
* Represents a submission mail entity.
*/
model SubmissionMailEntity extends Entity {
/**
* Submission mail entity properties
*/
"properties"?: SubmissionMailEntityProperties;
/**
* The kind of the entity.
*/
"kind": "SubmissionMail";
}

/**
* Submission mail entity property bag.
*/
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model SubmissionMailEntityProperties extends EntityCommonProperties {
/**
* The network message id of email to which submission belongs
*/
@visibility(Lifecycle.Read)
#suppress "@azure-tools/typespec-azure-core/no-format"
@format("uuid")
"networkMessageId"?: string;
/**
* The submission id
*/
@visibility(Lifecycle.Read)
#suppress "@azure-tools/typespec-azure-core/no-format"
@format("uuid")
"submissionId"?: string;
/**
* The submitter
*/
@visibility(Lifecycle.Read)
"submitter"?: string;
/**
* The submission date
*/
@visibility(Lifecycle.Read)
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"submissionDate"?: utcDateTime;
/**
* The Time stamp when the message is received (Mail)
*/
@visibility(Lifecycle.Read)
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"timestamp"?: utcDateTime;
/**
* The recipient of the mail
*/
@visibility(Lifecycle.Read)
"recipient"?: string;
/**
* The sender of the mail
*/
@visibility(Lifecycle.Read)
"sender"?: string;
/**
* The sender's IP
*/
@visibility(Lifecycle.Read)
"senderIp"?: string;
/**
* The subject of submission mail
*/
@visibility(Lifecycle.Read)
"subject"?: string;
/**
* The submission type for the given instance. This maps to Junk, Phish, Malware or NotJunk.
*/
@visibility(Lifecycle.Read)
"reportType"?: string;
}

/**
* Represents a url entity.
*/
model UrlEntity extends Entity {
/**
* Url entity properties
*/
"properties"?: UrlEntityProperties;
/**
* The kind of the entity.
*/
"kind": "Url";
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
"url"?: string;
}

/**
* Represents an network interface entity.
*/
model NicEntity extends Entity {
/**
* Network interface entity properties
*/
"properties"?: NicEntityProperties;
/**
* The kind of the entity.
*/
"kind": "Nic";
}

/**
* Nic entity property bag.
*/
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model NicEntityProperties extends EntityCommonProperties {
/**
* The MAC address of this network interface
*/
@visibility(Lifecycle.Read)
"macAddress"?: string;
/**
* The IP entity id of this network interface
*/
@visibility(Lifecycle.Read)
"ipAddressEntityId"?: string;
/**
* A list of VLANs of the network interface entity.
*/
@visibility(Lifecycle.Read)
@identifiers(#[])
"vlans"?: string[];
}