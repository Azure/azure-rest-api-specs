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

namespace AssessmentAPI;

/**
 * Tactic of the assessment
 */
union Tactics {
  string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Reconnaissance
   */
  Reconnaissance: "Reconnaissance",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Resource Development
   */
  `Resource Development`: "Resource Development",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Initial Access
   */
  `Initial Access`: "Initial Access",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Execution
   */
  Execution: "Execution",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Persistence
   */
  Persistence: "Persistence",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Privilege Escalation
   */
  `Privilege Escalation`: "Privilege Escalation",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Defense Evasion
   */
  `Defense Evasion`: "Defense Evasion",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Credential Access
   */
  `Credential Access`: "Credential Access",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Discovery
   */
  Discovery: "Discovery",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Lateral Movement
   */
  `Lateral Movement`: "Lateral Movement",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Collection
   */
  Collection: "Collection",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Command and Control
   */
  `Command and Control`: "Command and Control",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Exfiltration
   */
  Exfiltration: "Exfiltration",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
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

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Abuse Elevation Control Mechanism
   */
  `Abuse Elevation Control Mechanism`: "Abuse Elevation Control Mechanism",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Access Token Manipulation
   */
  `Access Token Manipulation`: "Access Token Manipulation",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Account Discovery
   */
  `Account Discovery`: "Account Discovery",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Account Manipulation
   */
  `Account Manipulation`: "Account Manipulation",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Active Scanning
   */
  `Active Scanning`: "Active Scanning",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Application Layer Protocol
   */
  `Application Layer Protocol`: "Application Layer Protocol",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Audio Capture
   */
  `Audio Capture`: "Audio Capture",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Boot or Logon Autostart Execution
   */
  `Boot or Logon Autostart Execution`: "Boot or Logon Autostart Execution",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Boot or Logon Initialization Scripts
   */
  `Boot or Logon Initialization Scripts`: "Boot or Logon Initialization Scripts",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Brute Force
   */
  `Brute Force`: "Brute Force",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Cloud Infrastructure Discovery
   */
  `Cloud Infrastructure Discovery`: "Cloud Infrastructure Discovery",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Cloud Service Dashboard
   */
  `Cloud Service Dashboard`: "Cloud Service Dashboard",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Cloud Service Discovery
   */
  `Cloud Service Discovery`: "Cloud Service Discovery",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Command and Scripting Interpreter
   */
  `Command and Scripting Interpreter`: "Command and Scripting Interpreter",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Compromise Client Software Binary
   */
  `Compromise Client Software Binary`: "Compromise Client Software Binary",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Compromise Infrastructure
   */
  `Compromise Infrastructure`: "Compromise Infrastructure",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Container and Resource Discovery
   */
  `Container and Resource Discovery`: "Container and Resource Discovery",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Create Account
   */
  `Create Account`: "Create Account",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Create or Modify System Process
   */
  `Create or Modify System Process`: "Create or Modify System Process",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Credentials from Password Stores
   */
  `Credentials from Password Stores`: "Credentials from Password Stores",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Data Destruction
   */
  `Data Destruction`: "Data Destruction",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Data Encrypted for Impact
   */
  `Data Encrypted for Impact`: "Data Encrypted for Impact",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Data from Cloud Storage Object
   */
  `Data from Cloud Storage Object`: "Data from Cloud Storage Object",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Data from Configuration Repository
   */
  `Data from Configuration Repository`: "Data from Configuration Repository",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Data from Information Repositories
   */
  `Data from Information Repositories`: "Data from Information Repositories",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Data from Local System
   */
  `Data from Local System`: "Data from Local System",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Data Manipulation
   */
  `Data Manipulation`: "Data Manipulation",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Data Staged
   */
  `Data Staged`: "Data Staged",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Defacement
   */
  Defacement: "Defacement",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Deobfuscate/Decode Files or Information
   */
  `Deobfuscate/Decode Files or Information`: "Deobfuscate/Decode Files or Information",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Disk Wipe
   */
  `Disk Wipe`: "Disk Wipe",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Domain Trust Discovery
   */
  `Domain Trust Discovery`: "Domain Trust Discovery",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Drive-by Compromise
   */
  `Drive-by Compromise`: "Drive-by Compromise",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Dynamic Resolution
   */
  `Dynamic Resolution`: "Dynamic Resolution",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Endpoint Denial of Service
   */
  `Endpoint Denial of Service`: "Endpoint Denial of Service",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Event Triggered Execution
   */
  `Event Triggered Execution`: "Event Triggered Execution",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Exfiltration Over Alternative Protocol
   */
  `Exfiltration Over Alternative Protocol`: "Exfiltration Over Alternative Protocol",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Exploit Public-Facing Application
   */
  `Exploit Public-Facing Application`: "Exploit Public-Facing Application",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Exploitation for Client Execution
   */
  `Exploitation for Client Execution`: "Exploitation for Client Execution",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Exploitation for Credential Access
   */
  `Exploitation for Credential Access`: "Exploitation for Credential Access",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Exploitation for Defense Evasion
   */
  `Exploitation for Defense Evasion`: "Exploitation for Defense Evasion",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Exploitation for Privilege Escalation
   */
  `Exploitation for Privilege Escalation`: "Exploitation for Privilege Escalation",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Exploitation of Remote Services
   */
  `Exploitation of Remote Services`: "Exploitation of Remote Services",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * External Remote Services
   */
  `External Remote Services`: "External Remote Services",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Fallback Channels
   */
  `Fallback Channels`: "Fallback Channels",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * File and Directory Discovery
   */
  `File and Directory Discovery`: "File and Directory Discovery",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Gather Victim Network Information
   */
  `Gather Victim Network Information`: "Gather Victim Network Information",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Hide Artifacts
   */
  `Hide Artifacts`: "Hide Artifacts",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Hijack Execution Flow
   */
  `Hijack Execution Flow`: "Hijack Execution Flow",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Impair Defenses
   */
  `Impair Defenses`: "Impair Defenses",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Implant Container Image
   */
  `Implant Container Image`: "Implant Container Image",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Indicator Removal on Host
   */
  `Indicator Removal on Host`: "Indicator Removal on Host",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Indirect Command Execution
   */
  `Indirect Command Execution`: "Indirect Command Execution",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Ingress Tool Transfer
   */
  `Ingress Tool Transfer`: "Ingress Tool Transfer",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Input Capture
   */
  `Input Capture`: "Input Capture",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Inter-Process Communication
   */
  `Inter-Process Communication`: "Inter-Process Communication",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Lateral Tool Transfer
   */
  `Lateral Tool Transfer`: "Lateral Tool Transfer",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Man-in-the-Middle
   */
  `Man-in-the-Middle`: "Man-in-the-Middle",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Masquerading
   */
  Masquerading: "Masquerading",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Modify Authentication Process
   */
  `Modify Authentication Process`: "Modify Authentication Process",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Modify Registry
   */
  `Modify Registry`: "Modify Registry",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Network Denial of Service
   */
  `Network Denial of Service`: "Network Denial of Service",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Network Service Scanning
   */
  `Network Service Scanning`: "Network Service Scanning",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Network Sniffing
   */
  `Network Sniffing`: "Network Sniffing",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Non-Application Layer Protocol
   */
  `Non-Application Layer Protocol`: "Non-Application Layer Protocol",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Non-Standard Port
   */
  `Non-Standard Port`: "Non-Standard Port",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Obtain Capabilities
   */
  `Obtain Capabilities`: "Obtain Capabilities",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Obfuscated Files or Information
   */
  `Obfuscated Files or Information`: "Obfuscated Files or Information",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Office Application Startup
   */
  `Office Application Startup`: "Office Application Startup",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * OS Credential Dumping
   */
  `OS Credential Dumping`: "OS Credential Dumping",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Permission Groups Discovery
   */
  `Permission Groups Discovery`: "Permission Groups Discovery",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Phishing
   */
  Phishing: "Phishing",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Pre-OS Boot
   */
  `Pre-OS Boot`: "Pre-OS Boot",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Process Discovery
   */
  `Process Discovery`: "Process Discovery",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Process Injection
   */
  `Process Injection`: "Process Injection",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Protocol Tunneling
   */
  `Protocol Tunneling`: "Protocol Tunneling",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Proxy
   */
  Proxy: "Proxy",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Query Registry
   */
  `Query Registry`: "Query Registry",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Remote Access Software
   */
  `Remote Access Software`: "Remote Access Software",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Remote Service Session Hijacking
   */
  `Remote Service Session Hijacking`: "Remote Service Session Hijacking",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Remote Services
   */
  `Remote Services`: "Remote Services",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Remote System Discovery
   */
  `Remote System Discovery`: "Remote System Discovery",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Resource Hijacking
   */
  `Resource Hijacking`: "Resource Hijacking",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Scheduled Task/Job
   */
  `Scheduled Task/Job`: "Scheduled Task/Job",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Screen Capture
   */
  `Screen Capture`: "Screen Capture",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Search Victim-Owned Websites
   */
  `Search Victim-Owned Websites`: "Search Victim-Owned Websites",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Server Software Component
   */
  `Server Software Component`: "Server Software Component",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Service Stop
   */
  `Service Stop`: "Service Stop",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Signed Binary Proxy Execution
   */
  `Signed Binary Proxy Execution`: "Signed Binary Proxy Execution",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Software Deployment Tools
   */
  `Software Deployment Tools`: "Software Deployment Tools",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * SQL Stored Procedures
   */
  `SQL Stored Procedures`: "SQL Stored Procedures",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Steal or Forge Kerberos Tickets
   */
  `Steal or Forge Kerberos Tickets`: "Steal or Forge Kerberos Tickets",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Subvert Trust Controls
   */
  `Subvert Trust Controls`: "Subvert Trust Controls",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Supply Chain Compromise
   */
  `Supply Chain Compromise`: "Supply Chain Compromise",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * System Information Discovery
   */
  `System Information Discovery`: "System Information Discovery",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Taint Shared Content
   */
  `Taint Shared Content`: "Taint Shared Content",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Traffic Signaling
   */
  `Traffic Signaling`: "Traffic Signaling",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Transfer Data to Cloud Account
   */
  `Transfer Data to Cloud Account`: "Transfer Data to Cloud Account",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Trusted Relationship
   */
  `Trusted Relationship`: "Trusted Relationship",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Unsecured Credentials
   */
  `Unsecured Credentials`: "Unsecured Credentials",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * User Execution
   */
  `User Execution`: "User Execution",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Valid Accounts
   */
  `Valid Accounts`: "Valid Accounts",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Windows Management Instrumentation
   */
  `Windows Management Instrumentation`: "Windows Management Instrumentation",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
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

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Compute
   */
  Compute: "Compute",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Networking
   */
  Networking: "Networking",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Data
   */
  Data: "Data",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * IdentityAndAccess
   */
  IdentityAndAccess: "IdentityAndAccess",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * IoT
   */
  IoT: "IoT",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Container
   */
  Container: "Container",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * AppServices
   */
  AppServices: "AppServices",
}

/**
 * The user impact of the assessment
 */
union UserImpact {
  string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Low
   */
  Low: "Low",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Moderate
   */
  Moderate: "Moderate",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
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

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Low
   */
  Low: "Low",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Moderate
   */
  Moderate: "Moderate",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
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

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * accountBreach
   */
  accountBreach: "accountBreach",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * dataExfiltration
   */
  dataExfiltration: "dataExfiltration",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * dataSpillage
   */
  dataSpillage: "dataSpillage",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * maliciousInsider
   */
  maliciousInsider: "maliciousInsider",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * elevationOfPrivilege
   */
  elevationOfPrivilege: "elevationOfPrivilege",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * threatResistance
   */
  threatResistance: "threatResistance",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * missingCoverage
   */
  missingCoverage: "missingCoverage",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
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

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * None
   */
  None: "None",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Low
   */
  Low: "Low",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Medium
   */
  Medium: "Medium",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * High
   */
  High: "High",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Critical
   */
  Critical: "Critical",
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
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
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
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
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
model SecurityAssessment extends Azure.ResourceManager.Foundations.Resource {
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
model SecurityAssessmentMetadata
  extends Azure.ResourceManager.Foundations.Resource {
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
model OnPremiseResourceDetails extends ResourceDetails {
  ...OnPremiseResourceDetailsProperties;
  source: Source.OnPremiseResourceDetails;
}

alias OnPremiseResourceDetailsProperties = {
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
};

/**
 * Details of the On Premise Sql resource that was assessed
 */
#suppress "@azure-tools/typespec-azure-core/no-multiple-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(OnPremiseResourceDetails)
model OnPremiseSqlResourceDetails extends ResourceDetails {
  ...OnPremiseResourceDetailsProperties;

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
  source: Source.OnPremiseSql;
}
