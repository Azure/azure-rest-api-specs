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

namespace AlertsAPI;

/**
 * The risk level of the threat that was detected. Learn more: https://docs.microsoft.com/en-us/azure/security-center/security-center-alerts-overview#how-are-alerts-classified.
 */
union AlertSeverity {
  string,

  /**
   * Informational
   */
  Informational: "Informational",

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
}

/**
 * The kill chain related intent behind the alert. For list of supported values, and explanations of Azure Security Center's supported kill chain intents.
 */
union Intent {
  string,

  /**
   * Unknown
   */
  Unknown: "Unknown",

  /**
   * PreAttack could be either an attempt to access a certain resource regardless of a malicious intent, or a failed attempt to gain access to a target system to gather information prior to exploitation. This step is usually detected as an attempt, originating from outside the network, to scan the target system and find a way in.  Further details on the PreAttack stage can be read in [MITRE Pre-Att&ck matrix](https://attack.mitre.org/matrices/pre/).
   */
  PreAttack: "PreAttack",

  /**
   * InitialAccess is the stage where an attacker manages to get foothold on the attacked resource.
   */
  InitialAccess: "InitialAccess",

  /**
   * Persistence is any access, action, or configuration change to a system that gives a threat actor a persistent presence on that system.
   */
  Persistence: "Persistence",

  /**
   * Privilege escalation is the result of actions that allow an adversary to obtain a higher level of permissions on a system or network.
   */
  PrivilegeEscalation: "PrivilegeEscalation",

  /**
   * Defense evasion consists of techniques an adversary may use to evade detection or avoid other defenses.
   */
  DefenseEvasion: "DefenseEvasion",

  /**
   * Credential access represents techniques resulting in access to or control over system, domain, or service credentials that are used within an enterprise environment.
   */
  CredentialAccess: "CredentialAccess",

  /**
   * Discovery consists of techniques that allow the adversary to gain knowledge about the system and internal network.
   */
  Discovery: "Discovery",

  /**
   * Lateral movement consists of techniques that enable an adversary to access and control remote systems on a network and could, but does not necessarily, include execution of tools on remote systems.
   */
  LateralMovement: "LateralMovement",

  /**
   * The execution tactic represents techniques that result in execution of adversary-controlled code on a local or remote system.
   */
  Execution: "Execution",

  /**
   * Collection consists of techniques used to identify and gather information, such as sensitive files, from a target network prior to exfiltration.
   */
  Collection: "Collection",

  /**
   * Exfiltration refers to techniques and attributes that result or aid in the adversary removing files and information from a target network.
   */
  Exfiltration: "Exfiltration",

  /**
   * The command and control tactic represents how adversaries communicate with systems under their control within a target network.
   */
  CommandAndControl: "CommandAndControl",

  /**
   * Impact events primarily try to directly reduce the availability or integrity of a system, service, or network; including manipulation of data to impact a business or operational process.
   */
  Impact: "Impact",

  /**
   * Probing could be either an attempt to access a certain resource regardless of a malicious intent, or a failed attempt to gain access to a target system to gather information prior to exploitation.
   */
  Probing: "Probing",

  /**
   * Exploitation is the stage where an attacker manages to get a foothold on the attacked resource. This stage is relevant for compute hosts and resources such as user accounts, certificates etc.
   */
  Exploitation: "Exploitation",
}

/**
 * There can be multiple identifiers of different type per alert, this field specify the identifier type.
 */
union ResourceIdentifierType {
  string,

  /**
   * AzureResource
   */
  AzureResource: "AzureResource",

  /**
   * LogAnalytics
   */
  LogAnalytics: "LogAnalytics",
}

/**
 * The life cycle status of the alert.
 */
union AlertStatus {
  string,

  /**
   * An alert which doesn't specify a value is assigned the status 'Active'
   */
  Active: "Active",

  /**
   * An alert which is in handling state
   */
  InProgress: "InProgress",

  /**
   * Alert closed after handling
   */
  Resolved: "Resolved",

  /**
   * Alert dismissed as false positive
   */
  Dismissed: "Dismissed",
}

/**
 * The kind of alert simulation.
 */
union Kind {
  string,

  /**
   * Simulate alerts according to bundles
   */
  Bundles: "Bundles",
}

/**
 * Alert Simulator supported bundles.
 */
union BundleType {
  string,

  /**
   * AppServices
   */
  AppServices: "AppServices",

  /**
   * DNS
   */
  DNS: "DNS",

  /**
   * KeyVaults
   */
  KeyVaults: "KeyVaults",

  /**
   * KubernetesService
   */
  KubernetesService: "KubernetesService",

  /**
   * ResourceManager
   */
  ResourceManager: "ResourceManager",

  /**
   * SqlServers
   */
  SqlServers: "SqlServers",

  /**
   * StorageAccounts
   */
  StorageAccounts: "StorageAccounts",

  /**
   * VirtualMachines
   */
  VirtualMachines: "VirtualMachines",

  /**
   * CosmosDbs
   */
  CosmosDbs: "CosmosDbs",
}

/**
 * List of security alerts
 */
model AlertList {
  /**
   * The Alert items on this page
   */
  @pageItems
  value?: Alert[];

  /**
   * The link to the next page of items
   */
  @nextLink
  nextLink?: string;
}

/**
 * describes security alert properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AlertProperties {
  /**
   * Schema version.
   */
  @visibility(Lifecycle.Read)
  version?: string;

  /**
   * Unique identifier for the detection logic (all alert instances from the same detection logic will have the same alertType).
   */
  @visibility(Lifecycle.Read)
  alertType?: string;

  /**
   * Unique identifier for the alert.
   */
  @visibility(Lifecycle.Read)
  systemAlertId?: string;

  /**
   * The name of Azure Security Center pricing tier which powering this alert. Learn more: https://docs.microsoft.com/en-us/azure/security-center/security-center-pricing
   */
  @visibility(Lifecycle.Read)
  productComponentName?: string;

  /**
   * The display name of the alert.
   */
  @visibility(Lifecycle.Read)
  alertDisplayName?: string;

  /**
   * Description of the suspicious activity that was detected.
   */
  @visibility(Lifecycle.Read)
  description?: string;

  /**
   * The risk level of the threat that was detected. Learn more: https://docs.microsoft.com/en-us/azure/security-center/security-center-alerts-overview#how-are-alerts-classified.
   */
  @visibility(Lifecycle.Read)
  severity?: AlertSeverity;

  /**
   * The kill chain related intent behind the alert. For list of supported values, and explanations of Azure Security Center's supported kill chain intents.
   */
  @visibility(Lifecycle.Read)
  intent?: Intent;

  /**
   * The UTC time of the first event or activity included in the alert in ISO8601 format.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTimeUtc?: utcDateTime;

  /**
   * The UTC time of the last event or activity included in the alert in ISO8601 format.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTimeUtc?: utcDateTime;

  /**
   * The resource identifiers that can be used to direct the alert to the right product exposure group (tenant, workspace, subscription etc.). There can be multiple identifiers of different type per alert.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  resourceIdentifiers?: ResourceIdentifier[];

  /**
   * Manual action items to take to remediate the alert.
   */
  @visibility(Lifecycle.Read)
  remediationSteps?: string[];

  /**
   * The name of the vendor that raises the alert.
   */
  @visibility(Lifecycle.Read)
  vendorName?: string;

  /**
   * The life cycle status of the alert.
   */
  @visibility(Lifecycle.Read)
  status?: AlertStatus;

  /**
   * Links related to the alert
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  extendedLinks?: Record<string>[];

  /**
   * A direct link to the alert page in Azure Portal.
   */
  @visibility(Lifecycle.Read)
  alertUri?: string;

  /**
   * The UTC time the alert was generated in ISO8601 format.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timeGeneratedUtc?: utcDateTime;

  /**
   * The name of the product which published this alert (Microsoft Sentinel, Microsoft Defender for Identity, Microsoft Defender for Endpoint, Microsoft Defender for Office, Microsoft Defender for Cloud Apps, and so on).
   */
  @visibility(Lifecycle.Read)
  productName?: string;

  /**
   * The UTC processing end time of the alert in ISO8601 format.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  processingEndTimeUtc?: utcDateTime;

  /**
   * A list of entities related to the alert.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  entities?: AlertEntity[];

  /**
   * This field determines whether the alert is an incident (a compound grouping of several alerts) or a single alert.
   */
  @visibility(Lifecycle.Read)
  isIncident?: boolean;

  /**
   * Key for corelating related alerts. Alerts with the same correlation key considered to be related.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  correlationKey?: string;

  /**
   * Custom properties for the alert.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  extendedProperties?: Record<string>;

  /**
   * The display name of the resource most related to this alert.
   */
  @visibility(Lifecycle.Read)
  compromisedEntity?: string;

  /**
   * kill chain related techniques behind the alert.
   */
  @visibility(Lifecycle.Read)
  techniques?: string[];

  /**
   * Kill chain related sub-techniques behind the alert.
   */
  @visibility(Lifecycle.Read)
  subTechniques?: string[];

  /**
   * Changing set of properties depending on the supportingEvidence type.
   */
  supportingEvidence?: AlertPropertiesSupportingEvidence;
}

/**
 * A resource identifier for an alert which can be used to direct the alert to the right product exposure group (tenant, workspace, subscription etc.).
 */
@discriminator("type")
model ResourceIdentifier {
  /**
   * There can be multiple identifiers of different type per alert, this field specify the identifier type.
   */
  type: ResourceIdentifierType;
}

/**
 * Changing set of properties depending on the entity type.
 */
model AlertEntity {
  ...Record<unknown>;

  /**
   * Type of entity
   */
  @visibility(Lifecycle.Read)
  type?: string;
}

/**
 * Changing set of properties depending on the supportingEvidence type.
 */
model AlertPropertiesSupportingEvidence {
  ...Record<unknown>;

  /**
   * Type of the supportingEvidence
   */
  @visibility(Lifecycle.Read)
  type?: string;
}

/**
 * Alert Simulator request body.
 */
model AlertSimulatorRequestBody {
  /**
   * Alert Simulator request body data.
   */
  properties?: AlertSimulatorRequestProperties;
}

/**
 * Describes properties of an alert simulation request
 */
@discriminator("kind")
model AlertSimulatorRequestProperties {
  ...Record<unknown>;

  /**
   * The kind of alert simulation.
   */
  kind: Kind;
}

/**
 * Azure resource identifier.
 */
model AzureResourceIdentifier extends ResourceIdentifier {
  /**
   * ARM resource identifier for the cloud resource being alerted on
   */
  @visibility(Lifecycle.Read)
  azureResourceId?: string;

  /**
   * There can be multiple identifiers of different type per alert, this field specify the identifier type.
   */
  type: "AzureResource";
}

/**
 * Represents a Log Analytics workspace scope identifier.
 */
model LogAnalyticsIdentifier extends ResourceIdentifier {
  /**
   * The LogAnalytics workspace id that stores this alert.
   */
  @visibility(Lifecycle.Read)
  workspaceId?: string;

  /**
   * The azure subscription id for the LogAnalytics workspace storing this alert.
   */
  @visibility(Lifecycle.Read)
  @pattern("^[0-9A-Fa-f]{8}-([0-9A-Fa-f]{4}-){3}[0-9A-Fa-f]{12}$")
  workspaceSubscriptionId?: string;

  /**
   * The azure resource group for the LogAnalytics workspace storing this alert
   */
  @visibility(Lifecycle.Read)
  workspaceResourceGroup?: string;

  /**
   * (optional) The LogAnalytics agent id reporting the event that this alert is based on.
   */
  @visibility(Lifecycle.Read)
  agentId?: string;

  /**
   * There can be multiple identifiers of different type per alert, this field specify the identifier type.
   */
  type: "LogAnalytics";
}

/**
 * Simulate alerts according to this bundles.
 */
model AlertSimulatorBundlesRequestProperties
  extends AlertSimulatorRequestProperties {
  /**
   * Bundles list.
   */
  bundles?: BundleType[];

  /**
   * The kind of alert simulation.
   */
  kind: "Bundles";
}
