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
 * Tactic of the assessment
 */
union Tactics {
  string,

  /**
   * Reconnaissance
   */
  Reconnaissance: "Reconnaissance",

  /**
   * Resource Development
   */
  `Resource Development`: "Resource Development",

  /**
   * Initial Access
   */
  `Initial Access`: "Initial Access",

  /**
   * Execution
   */
  Execution: "Execution",

  /**
   * Persistence
   */
  Persistence: "Persistence",

  /**
   * Privilege Escalation
   */
  `Privilege Escalation`: "Privilege Escalation",

  /**
   * Defense Evasion
   */
  `Defense Evasion`: "Defense Evasion",

  /**
   * Credential Access
   */
  `Credential Access`: "Credential Access",

  /**
   * Discovery
   */
  Discovery: "Discovery",

  /**
   * Lateral Movement
   */
  `Lateral Movement`: "Lateral Movement",

  /**
   * Collection
   */
  Collection: "Collection",

  /**
   * Command and Control
   */
  `Command and Control`: "Command and Control",

  /**
   * Exfiltration
   */
  Exfiltration: "Exfiltration",

  /**
   * Impact
   */
  Impact: "Impact",
}

/**
 * Techniques of the assessment
 */
union Techniques {
  string,

  /**
   * Abuse Elevation Control Mechanism
   */
  `Abuse Elevation Control Mechanism`: "Abuse Elevation Control Mechanism",

  /**
   * Access Token Manipulation
   */
  `Access Token Manipulation`: "Access Token Manipulation",

  /**
   * Account Discovery
   */
  `Account Discovery`: "Account Discovery",

  /**
   * Account Manipulation
   */
  `Account Manipulation`: "Account Manipulation",

  /**
   * Active Scanning
   */
  `Active Scanning`: "Active Scanning",

  /**
   * Application Layer Protocol
   */
  `Application Layer Protocol`: "Application Layer Protocol",

  /**
   * Audio Capture
   */
  `Audio Capture`: "Audio Capture",

  /**
   * Boot or Logon Autostart Execution
   */
  `Boot or Logon Autostart Execution`: "Boot or Logon Autostart Execution",

  /**
   * Boot or Logon Initialization Scripts
   */
  `Boot or Logon Initialization Scripts`: "Boot or Logon Initialization Scripts",

  /**
   * Brute Force
   */
  `Brute Force`: "Brute Force",

  /**
   * Cloud Infrastructure Discovery
   */
  `Cloud Infrastructure Discovery`: "Cloud Infrastructure Discovery",

  /**
   * Cloud Service Dashboard
   */
  `Cloud Service Dashboard`: "Cloud Service Dashboard",

  /**
   * Cloud Service Discovery
   */
  `Cloud Service Discovery`: "Cloud Service Discovery",

  /**
   * Command and Scripting Interpreter
   */
  `Command and Scripting Interpreter`: "Command and Scripting Interpreter",

  /**
   * Compromise Client Software Binary
   */
  `Compromise Client Software Binary`: "Compromise Client Software Binary",

  /**
   * Compromise Infrastructure
   */
  `Compromise Infrastructure`: "Compromise Infrastructure",

  /**
   * Container and Resource Discovery
   */
  `Container and Resource Discovery`: "Container and Resource Discovery",

  /**
   * Create Account
   */
  `Create Account`: "Create Account",

  /**
   * Create or Modify System Process
   */
  `Create or Modify System Process`: "Create or Modify System Process",

  /**
   * Credentials from Password Stores
   */
  `Credentials from Password Stores`: "Credentials from Password Stores",

  /**
   * Data Destruction
   */
  `Data Destruction`: "Data Destruction",

  /**
   * Data Encrypted for Impact
   */
  `Data Encrypted for Impact`: "Data Encrypted for Impact",

  /**
   * Data from Cloud Storage Object
   */
  `Data from Cloud Storage Object`: "Data from Cloud Storage Object",

  /**
   * Data from Configuration Repository
   */
  `Data from Configuration Repository`: "Data from Configuration Repository",

  /**
   * Data from Information Repositories
   */
  `Data from Information Repositories`: "Data from Information Repositories",

  /**
   * Data from Local System
   */
  `Data from Local System`: "Data from Local System",

  /**
   * Data Manipulation
   */
  `Data Manipulation`: "Data Manipulation",

  /**
   * Data Staged
   */
  `Data Staged`: "Data Staged",

  /**
   * Defacement
   */
  Defacement: "Defacement",

  /**
   * Deobfuscate/Decode Files or Information
   */
  `Deobfuscate/Decode Files or Information`: "Deobfuscate/Decode Files or Information",

  /**
   * Disk Wipe
   */
  `Disk Wipe`: "Disk Wipe",

  /**
   * Domain Trust Discovery
   */
  `Domain Trust Discovery`: "Domain Trust Discovery",

  /**
   * Drive-by Compromise
   */
  `Drive-by Compromise`: "Drive-by Compromise",

  /**
   * Dynamic Resolution
   */
  `Dynamic Resolution`: "Dynamic Resolution",

  /**
   * Endpoint Denial of Service
   */
  `Endpoint Denial of Service`: "Endpoint Denial of Service",

  /**
   * Event Triggered Execution
   */
  `Event Triggered Execution`: "Event Triggered Execution",

  /**
   * Exfiltration Over Alternative Protocol
   */
  `Exfiltration Over Alternative Protocol`: "Exfiltration Over Alternative Protocol",

  /**
   * Exploit Public-Facing Application
   */
  `Exploit Public-Facing Application`: "Exploit Public-Facing Application",

  /**
   * Exploitation for Client Execution
   */
  `Exploitation for Client Execution`: "Exploitation for Client Execution",

  /**
   * Exploitation for Credential Access
   */
  `Exploitation for Credential Access`: "Exploitation for Credential Access",

  /**
   * Exploitation for Defense Evasion
   */
  `Exploitation for Defense Evasion`: "Exploitation for Defense Evasion",

  /**
   * Exploitation for Privilege Escalation
   */
  `Exploitation for Privilege Escalation`: "Exploitation for Privilege Escalation",

  /**
   * Exploitation of Remote Services
   */
  `Exploitation of Remote Services`: "Exploitation of Remote Services",

  /**
   * External Remote Services
   */
  `External Remote Services`: "External Remote Services",

  /**
   * Fallback Channels
   */
  `Fallback Channels`: "Fallback Channels",

  /**
   * File and Directory Discovery
   */
  `File and Directory Discovery`: "File and Directory Discovery",

  /**
   * Gather Victim Network Information
   */
  `Gather Victim Network Information`: "Gather Victim Network Information",

  /**
   * Hide Artifacts
   */
  `Hide Artifacts`: "Hide Artifacts",

  /**
   * Hijack Execution Flow
   */
  `Hijack Execution Flow`: "Hijack Execution Flow",

  /**
   * Impair Defenses
   */
  `Impair Defenses`: "Impair Defenses",

  /**
   * Implant Container Image
   */
  `Implant Container Image`: "Implant Container Image",

  /**
   * Indicator Removal on Host
   */
  `Indicator Removal on Host`: "Indicator Removal on Host",

  /**
   * Indirect Command Execution
   */
  `Indirect Command Execution`: "Indirect Command Execution",

  /**
   * Ingress Tool Transfer
   */
  `Ingress Tool Transfer`: "Ingress Tool Transfer",

  /**
   * Input Capture
   */
  `Input Capture`: "Input Capture",

  /**
   * Inter-Process Communication
   */
  `Inter-Process Communication`: "Inter-Process Communication",

  /**
   * Lateral Tool Transfer
   */
  `Lateral Tool Transfer`: "Lateral Tool Transfer",

  /**
   * Man-in-the-Middle
   */
  `Man-in-the-Middle`: "Man-in-the-Middle",

  /**
   * Masquerading
   */
  Masquerading: "Masquerading",

  /**
   * Modify Authentication Process
   */
  `Modify Authentication Process`: "Modify Authentication Process",

  /**
   * Modify Registry
   */
  `Modify Registry`: "Modify Registry",

  /**
   * Network Denial of Service
   */
  `Network Denial of Service`: "Network Denial of Service",

  /**
   * Network Service Scanning
   */
  `Network Service Scanning`: "Network Service Scanning",

  /**
   * Network Sniffing
   */
  `Network Sniffing`: "Network Sniffing",

  /**
   * Non-Application Layer Protocol
   */
  `Non-Application Layer Protocol`: "Non-Application Layer Protocol",

  /**
   * Non-Standard Port
   */
  `Non-Standard Port`: "Non-Standard Port",

  /**
   * Obtain Capabilities
   */
  `Obtain Capabilities`: "Obtain Capabilities",

  /**
   * Obfuscated Files or Information
   */
  `Obfuscated Files or Information`: "Obfuscated Files or Information",

  /**
   * Office Application Startup
   */
  `Office Application Startup`: "Office Application Startup",

  /**
   * OS Credential Dumping
   */
  `OS Credential Dumping`: "OS Credential Dumping",

  /**
   * Permission Groups Discovery
   */
  `Permission Groups Discovery`: "Permission Groups Discovery",

  /**
   * Phishing
   */
  Phishing: "Phishing",

  /**
   * Pre-OS Boot
   */
  `Pre-OS Boot`: "Pre-OS Boot",

  /**
   * Process Discovery
   */
  `Process Discovery`: "Process Discovery",

  /**
   * Process Injection
   */
  `Process Injection`: "Process Injection",

  /**
   * Protocol Tunneling
   */
  `Protocol Tunneling`: "Protocol Tunneling",

  /**
   * Proxy
   */
  Proxy: "Proxy",

  /**
   * Query Registry
   */
  `Query Registry`: "Query Registry",

  /**
   * Remote Access Software
   */
  `Remote Access Software`: "Remote Access Software",

  /**
   * Remote Service Session Hijacking
   */
  `Remote Service Session Hijacking`: "Remote Service Session Hijacking",

  /**
   * Remote Services
   */
  `Remote Services`: "Remote Services",

  /**
   * Remote System Discovery
   */
  `Remote System Discovery`: "Remote System Discovery",

  /**
   * Resource Hijacking
   */
  `Resource Hijacking`: "Resource Hijacking",

  /**
   * Scheduled Task/Job
   */
  `Scheduled Task/Job`: "Scheduled Task/Job",

  /**
   * Screen Capture
   */
  `Screen Capture`: "Screen Capture",

  /**
   * Search Victim-Owned Websites
   */
  `Search Victim-Owned Websites`: "Search Victim-Owned Websites",

  /**
   * Server Software Component
   */
  `Server Software Component`: "Server Software Component",

  /**
   * Service Stop
   */
  `Service Stop`: "Service Stop",

  /**
   * Signed Binary Proxy Execution
   */
  `Signed Binary Proxy Execution`: "Signed Binary Proxy Execution",

  /**
   * Software Deployment Tools
   */
  `Software Deployment Tools`: "Software Deployment Tools",

  /**
   * SQL Stored Procedures
   */
  `SQL Stored Procedures`: "SQL Stored Procedures",

  /**
   * Steal or Forge Kerberos Tickets
   */
  `Steal or Forge Kerberos Tickets`: "Steal or Forge Kerberos Tickets",

  /**
   * Subvert Trust Controls
   */
  `Subvert Trust Controls`: "Subvert Trust Controls",

  /**
   * Supply Chain Compromise
   */
  `Supply Chain Compromise`: "Supply Chain Compromise",

  /**
   * System Information Discovery
   */
  `System Information Discovery`: "System Information Discovery",

  /**
   * Taint Shared Content
   */
  `Taint Shared Content`: "Taint Shared Content",

  /**
   * Traffic Signaling
   */
  `Traffic Signaling`: "Traffic Signaling",

  /**
   * Transfer Data to Cloud Account
   */
  `Transfer Data to Cloud Account`: "Transfer Data to Cloud Account",

  /**
   * Trusted Relationship
   */
  `Trusted Relationship`: "Trusted Relationship",

  /**
   * Unsecured Credentials
   */
  `Unsecured Credentials`: "Unsecured Credentials",

  /**
   * User Execution
   */
  `User Execution`: "User Execution",

  /**
   * Valid Accounts
   */
  `Valid Accounts`: "Valid Accounts",

  /**
   * Windows Management Instrumentation
   */
  `Windows Management Instrumentation`: "Windows Management Instrumentation",

  /**
   * File and Directory Permissions Modification
   */
  `File and Directory Permissions Modification`: "File and Directory Permissions Modification",
}

/**
 * The categories of resource that is at risk when the assessment is unhealthy
 */
union Categories {
  string,

  /**
   * Compute
   */
  Compute: "Compute",

  /**
   * Networking
   */
  Networking: "Networking",

  /**
   * Data
   */
  Data: "Data",

  /**
   * IdentityAndAccess
   */
  IdentityAndAccess: "IdentityAndAccess",

  /**
   * IoT
   */
  IoT: "IoT",

  /**
   * Container
   */
  Container: "Container",

  /**
   * AppServices
   */
  AppServices: "AppServices",
}

/**
 * The severity level of the assessment
 */
union Severity {
  string,

  /**
   * Low
   */
  Low: "Low",

  /**
   * Medium
   */
  Medium: "Medium",

  /**
   * High
   */
  High: "High",

  /**
   * Critical
   */
  Critical: "Critical",
}

/**
 * The user impact of the assessment
 */
union UserImpact {
  string,

  /**
   * Low
   */
  Low: "Low",

  /**
   * Moderate
   */
  Moderate: "Moderate",

  /**
   * High
   */
  High: "High",
}

/**
 * The implementation effort required to remediate this assessment
 */
union ImplementationEffort {
  string,

  /**
   * Low
   */
  Low: "Low",

  /**
   * Moderate
   */
  Moderate: "Moderate",

  /**
   * High
   */
  High: "High",
}

/**
 * Threats impact of the assessment
 */
union Threats {
  string,

  /**
   * accountBreach
   */
  accountBreach: "accountBreach",

  /**
   * dataExfiltration
   */
  dataExfiltration: "dataExfiltration",

  /**
   * dataSpillage
   */
  dataSpillage: "dataSpillage",

  /**
   * maliciousInsider
   */
  maliciousInsider: "maliciousInsider",

  /**
   * elevationOfPrivilege
   */
  elevationOfPrivilege: "elevationOfPrivilege",

  /**
   * threatResistance
   */
  threatResistance: "threatResistance",

  /**
   * missingCoverage
   */
  missingCoverage: "missingCoverage",

  /**
   * denialOfService
   */
  denialOfService: "denialOfService",
}

/**
 * BuiltIn if the assessment based on built-in Azure Policy definition, Custom if the assessment based on custom Azure Policy definition
 */
union AssessmentType {
  string,

  /**
   * Unknown assessment type
   */
  Unknown: "Unknown",

  /**
   * Microsoft Defender for Cloud managed assessments
   */
  BuiltIn: "BuiltIn",

  /**
   * User defined custom assessments
   */
  Custom: "Custom",

  /**
   * User defined policies that are automatically ingested from Azure Policy to Microsoft Defender for Cloud
   */
  CustomPolicy: "CustomPolicy",

  /**
   * User assessments pushed directly by the user or other third party to Microsoft Defender for Cloud
   */
  CustomerManaged: "CustomerManaged",

  /**
   * Microsoft Defender for Cloud managed policies
   */
  BuiltInPolicy: "BuiltInPolicy",

  /**
   * Third party assessments that are verified by Microsoft Defender for Cloud
   */
  VerifiedPartner: "VerifiedPartner",

  /**
   * Microsoft Defender for Cloud managed policies that are manually created by the user
   */
  ManualBuiltInPolicy: "ManualBuiltInPolicy",

  /**
   * Microsoft Defender for Cloud managed assessments that are manually created by the user
   */
  ManualBuiltIn: "ManualBuiltIn",

  /**
   * User defined policies that are manually created by the user
   */
  ManualCustomPolicy: "ManualCustomPolicy",

  /**
   * Microsoft Defender for Cloud managed assessments that are dynamically created by the system
   */
  DynamicBuiltIn: "DynamicBuiltIn",
}

/**
 * Programmatic code for the status of the assessment
 */
union AssessmentStatusCode {
  string,

  /**
   * The resource is healthy
   */
  Healthy: "Healthy",

  /**
   * The resource has a security issue that needs to be addressed
   */
  Unhealthy: "Unhealthy",

  /**
   * Assessment for this resource did not happen
   */
  NotApplicable: "NotApplicable",
}

/**
 * The risk level
 */
union RiskLevel {
  string,

  /**
   * None
   */
  None: "None",

  /**
   * Low
   */
  Low: "Low",

  /**
   * Medium
   */
  Medium: "Medium",

  /**
   * High
   */
  High: "High",

  /**
   * Critical
   */
  Critical: "Critical",
}

/**
 * The platform where the assessed resource resides
 */
union Source {
  string,

  /**
   * Resource is in Azure
   */
  Azure: "Azure",

  /**
   * Resource in an on premise machine connected to Azure cloud
   */
  OnPremise: "OnPremise",

  /**
   * SQL Resource in an on premise machine connected to Azure cloud
   */
  OnPremiseSql: "OnPremiseSql",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union ExpandEnum {
  string,

  /**
   * All links associated with an assessment
   */
  links: "links",

  /**
   * Assessment metadata
   */
  metadata: "metadata",
}

/**
 * List of security assessment metadata
 */
model SecurityAssessmentMetadataResponseList {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @pageItems
  @visibility(Lifecycle.Read)
  value?: SecurityAssessmentMetadataResponse[];

  /**
   * The URI to fetch the next page.
   */
  @nextLink
  // FIXME: (url) Please double check that this is the correct type for your scenario.
  nextLink?: url;
}

/**
 * Describes properties of an assessment metadata response.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SecurityAssessmentMetadataPropertiesResponse
  extends SecurityAssessmentMetadataProperties {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  publishDates?: SecurityAssessmentMetadataPropertiesResponsePublishDates;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @pattern("^[0-9]{2}/[0-9]{4}$")
  plannedDeprecationDate?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tactics?: Tactics[];
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  techniques?: Techniques[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SecurityAssessmentMetadataPropertiesResponsePublishDates {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @pattern("^([0-9]{2}/){2}[0-9]{4}$")
  GA?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @pattern("^([0-9]{2}/){2}[0-9]{4}$")
  public: string;
}

/**
 * Describes properties of an assessment metadata.
 */
model SecurityAssessmentMetadataProperties {
  /**
   * User friendly display name of the assessment
   */
  displayName: string;

  /**
   * Azure resource ID of the policy definition that turns this assessment calculation on
   */
  @visibility(Lifecycle.Read)
  policyDefinitionId?: string;

  /**
   * Human readable description of the assessment
   */
  description?: string;

  /**
   * Human readable description of what you should do to mitigate this security issue
   */
  remediationDescription?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  categories?: Categories[];

  /**
   * The severity level of the assessment
   */
  severity: Severity;

  /**
   * The user impact of the assessment
   */
  userImpact?: UserImpact;

  /**
   * The implementation effort required to remediate this assessment
   */
  implementationEffort?: ImplementationEffort;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  threats?: Threats[];

  /**
   * True if this assessment is in preview release status
   */
  preview?: boolean;

  /**
   * BuiltIn if the assessment based on built-in Azure Policy definition, Custom if the assessment based on custom Azure Policy definition
   */
  assessmentType: AssessmentType;

  /**
   * Describes the partner that created the assessment
   */
  partnerData?: SecurityAssessmentMetadataPartnerData;
}

/**
 * Describes the partner that created the assessment
 */
model SecurityAssessmentMetadataPartnerData {
  /**
   * Name of the company of the partner
   */
  partnerName: string;

  /**
   * Name of the product of the partner that created the assessment
   */
  productName?: string;

  /**
   * Secret to authenticate the partner and verify it created the assessment - write only
   */
  @secret
  secret: string;
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
 * Page of a security assessments list
 */
model SecurityAssessmentList {
  /**
   * Collection of security assessments in this page
   */
  @pageItems
  @visibility(Lifecycle.Read)
  value?: SecurityAssessmentResponse[];

  /**
   * The URI to fetch the next page.
   */
  @nextLink
  // FIXME: (url) Please double check that this is the correct type for your scenario.
  nextLink?: url;
}

/**
 * Describes properties of an assessment.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SecurityAssessmentPropertiesResponse
  extends SecurityAssessmentPropertiesBase {
  /**
   * The result of the assessment
   */
  status: AssessmentStatusResponse;
}

/**
 * The result of the assessment
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AssessmentStatusResponse extends AssessmentStatus {
  /**
   * The time that the assessment was created and first evaluated. Returned as UTC time in ISO 8601 format
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  firstEvaluationDate?: utcDateTime;

  /**
   * The time that the status of the assessment last changed. Returned as UTC time in ISO 8601 format
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  statusChangeDate?: utcDateTime;
}

/**
 * The result of the assessment
 */
model AssessmentStatus {
  /**
   * Programmatic code for the status of the assessment
   */
  code: AssessmentStatusCode;

  /**
   * Programmatic code for the cause of the assessment status
   */
  cause?: string;

  /**
   * Human readable description of the assessment status
   */
  description?: string;
}

/**
 * Describes properties of an assessment.
 */
model SecurityAssessmentPropertiesBase {
  /**
   * External model of risk result
   */
  risk?: SecurityAssessmentPropertiesBaseRisk;

  /**
   * Details of the resource that was assessed
   */
  resourceDetails: ResourceDetails;

  /**
   * User friendly display name of the assessment
   */
  @visibility(Lifecycle.Read)
  displayName?: string;

  /**
   * Additional data regarding the assessment
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  additionalData?: Record<string>;

  /**
   * Links relevant to the assessment
   */
  @visibility(Lifecycle.Read)
  links?: AssessmentLinks;

  /**
   * Describes properties of an assessment metadata.
   */
  metadata?: SecurityAssessmentMetadataProperties;

  /**
   * Data regarding 3rd party partner integration
   */
  partnersData?: SecurityAssessmentPartnerData;
}

/**
 * External model of risk result
 */
model SecurityAssessmentPropertiesBaseRisk {
  /**
   * The factors of the risk adding base factor
   */
  riskFactors?: string[];

  /**
   * The risk level
   */
  level?: RiskLevel;

  /**
   * The attack paths references of the risk
   */
  attackPathsReferences?: string[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  paths?: SecurityAssessmentPropertiesBaseRiskPathsItem[];

  /**
   * Indicates if the risk is contextual or static
   */
  isContextualRisk?: boolean;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SecurityAssessmentPropertiesBaseRiskPathsItem {
  /**
   * Unique identifier for the path
   */
  id?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  nodes?: SecurityAssessmentPropertiesBaseRiskPathsItemNodesItem[];

  /**
   * Connections between nodes
   */
  edges?: SecurityAssessmentPropertiesBaseRiskPathsItemEdgeItem[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SecurityAssessmentPropertiesBaseRiskPathsItemNodesItem {
  /**
   * Node identifier
   */
  id?: string;

  /**
   * Properties associated with the node
   */
  nodePropertiesLabel?: string[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SecurityAssessmentPropertiesBaseRiskPathsItemEdgeItem {
  /**
   * Edge identifier
   */
  id: string;

  /**
   * Target node identifier
   */
  targetId: string;

  /**
   * Source node identifier
   */
  sourceId: string;
}

/**
 * Details of the resource that was assessed
 */
@discriminator("source")
model ResourceDetails {
  /**
   * The platform where the assessed resource resides
   */
  source: Source;
}

/**
 * Links relevant to the assessment
 */
model AssessmentLinks {
  /**
   * Link to assessment in Azure Portal
   */
  @visibility(Lifecycle.Read)
  azurePortalUri?: string;
}

/**
 * Data regarding 3rd party partner integration
 */
model SecurityAssessmentPartnerData {
  /**
   * Name of the company of the partner
   */
  partnerName: string;

  /**
   * secret to authenticate the partner - write only
   */
  @secret
  secret: string;
}

/**
 * Security assessment on a resource
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SecurityAssessment extends Resource {
  /**
   * Describes properties of an assessment.
   */
  properties?: SecurityAssessmentProperties;
}

/**
 * Describes properties of an assessment.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SecurityAssessmentProperties extends SecurityAssessmentPropertiesBase {
  /**
   * The result of the assessment
   */
  status: AssessmentStatus;
}

/**
 * Represents a path that composes the risk
 */
model Path {
  /**
   * Path ID
   */
  id: string;

  /**
   * Path Nodes
   */
  nodes: NodeIdentifier[];

  /**
   * Path Edges
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  edges: EdgeIdentifiers[];
}

/**
 * Represents a node in the path
 */
model NodeIdentifier {
  /**
   * The unique identifier of the node
   */
  id: string;

  /**
   * The type of the node
   */
  type: string;
}

/**
 * Represents an edge in the path
 */
model EdgeIdentifiers {
  /**
   * The source node of the edge
   */
  source: string;

  /**
   * The target node of the edge
   */
  target: string;

  /**
   * The type of the edge
   */
  type: string;
}

/**
 * Security assessment metadata
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SecurityAssessmentMetadata extends Resource {
  /**
   * Describes properties of an assessment metadata.
   */
  properties?: SecurityAssessmentMetadataProperties;
}

/**
 * Details of the Azure resource that was assessed
 */
model AzureResourceDetails extends ResourceDetails {
  /**
   * Azure resource Id of the assessed resource
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The platform where the assessed resource resides
   */
  source: "Azure";
}

/**
 * Details of the On Premise resource that was assessed
 */
#suppress "@azure-tools/typespec-azure-core/no-multiple-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@discriminator("source")
model OnPremiseResourceDetails extends ResourceDetails {
  /**
   * Azure resource Id of the workspace the machine is attached to
   */
  workspaceId: string;

  /**
   * The unique Id of the machine
   */
  vmuuid: string;

  /**
   * The oms agent Id installed on the machine
   */
  sourceComputerId: string;

  /**
   * The name of the machine
   */
  machineName: string;
}

/**
 * Details of the On Premise Sql resource that was assessed
 */
#suppress "@azure-tools/typespec-azure-core/no-multiple-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model OnPremiseSqlResourceDetails extends OnPremiseResourceDetails {
  /**
   * The Sql server name installed on the machine
   */
  serverName: string;

  /**
   * The Sql database name installed on the machine
   */
  databaseName: string;

  /**
   * The platform where the assessed resource resides
   */
  source: "OnPremiseSql";
}
