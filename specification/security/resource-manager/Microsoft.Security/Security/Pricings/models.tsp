import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-azure-core";
import "../Common/main.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.Core;
using Azure.ResourceManager.Foundations;
using Common;

namespace PricingsAPI;

/**
 * Indicates whether the Defender plan is enabled on the selected scope. Microsoft Defender for Cloud is provided in two pricing tiers: free and standard. The standard tier offers advanced security capabilities, while the free tier offers basic security features.
 */
union PricingTier {
  string,

  /**
   * Get free Microsoft Defender for Cloud experience with basic security features
   */
  Free: "Free",

  /**
   * Get the standard Microsoft Defender for Cloud experience with advanced security features
   */
  Standard: "Standard",
}

/**
 * If set to "False", it allows the descendants of this scope to override the pricing configuration set on this scope (allows setting inherited="False"). If set to "True", it prevents overrides and forces this pricing configuration on all the descendants of this scope. This field is only available for subscription-level pricing.
 */
union Enforce {
  string,

  /**
   * Allows the descendants of this scope to override the pricing configuration set on this scope (allows setting inherited="False")
   */
  False: "False",

  /**
   * Prevents overrides and forces the current scope's pricing configuration to all descendants
   */
  True: "True",
}

/**
 * "inherited" = "True" indicates that the current scope inherits its pricing configuration from its parent. The ID of the parent scope that provides the inherited configuration is displayed in the "inheritedFrom" field. On the other hand, "inherited" = "False" indicates that the current scope has its own pricing configuration explicitly set, and does not inherit from its parent. This field is read only and available only for resource-level pricing.
 */
union Inherited {
  string,

  /**
   * Indicates that the current scope is inheriting its pricing configuration from its parent
   */
  True: "True",

  /**
   * Indicates that the current scope sets its own pricing configuration and does not inherit it from its parent
   */
  False: "False",
}

/**
 * This field is available for subscription-level only, and reflects the coverage status of the resources under the subscription. Please note: The "pricingTier" field reflects the plan status of the subscription. However, since the plan status can also be defined at the resource level, there might be misalignment between the subscription's plan status and the resource status. This field helps indicate the coverage status of the resources.
 */
union ResourcesCoverageStatus {
  string,

  /**
   * This value indicates that all resources associated with the subscription have the Defender plan enabled.
   */
  FullyCovered: "FullyCovered",

  /**
   * This value indicates that some resources under the subscription have the Defender plan enabled, while others have it disabled. There is a mixed coverage status among resources.
   */
  PartiallyCovered: "PartiallyCovered",

  /**
   * This value indicates that the Defender plan is disabled for all resources under the subscription. None of the resources are protected by the Defender plan.
   */
  NotCovered: "NotCovered",
}

/**
 * Indicates whether the extension is enabled.
 */
union IsEnabled {
  string,

  /**
   * Indicates the extension is enabled
   */
  True: "True",

  /**
   * Indicates the extension is disabled
   */
  False: "False",
}

/**
 * The operation status code.
 */
union Code {
  string,

  /**
   * Extension was created/updated successfully.
   */
  Succeeded: "Succeeded",

  /**
   * Extension was not created/updated successfully. See operation status message for more details.
   */
  Failed: "Failed",
}

/**
 * Pricing properties for the relevant scope
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PricingProperties {
  /**
   * Indicates whether the Defender plan is enabled on the selected scope. Microsoft Defender for Cloud is provided in two pricing tiers: free and standard. The standard tier offers advanced security capabilities, while the free tier offers basic security features.
   */
  pricingTier: PricingTier;

  /**
   * The sub-plan selected for a Standard pricing configuration, when more than one sub-plan is available. Each sub-plan enables a set of security features. When not specified, full plan is applied. For VirtualMachines plan, available sub plans are 'P1' & 'P2', where for resource level only 'P1' sub plan is supported.
   */
  subPlan?: string;

  /**
   * The duration left for the subscriptions free trial period - in ISO 8601 format (e.g. P3Y6M4DT12H30M5S).
   */
  @visibility(Lifecycle.Read)
  freeTrialRemainingTime?: duration;

  /**
   * Optional. If `pricingTier` is `Standard` then this property holds the date of the last time the `pricingTier` was set to `Standard`, when available (e.g 2023-03-01T12:42:42.1921106Z).
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  enablementTime?: utcDateTime;

  /**
   * If set to "False", it allows the descendants of this scope to override the pricing configuration set on this scope (allows setting inherited="False"). If set to "True", it prevents overrides and forces this pricing configuration on all the descendants of this scope. This field is only available for subscription-level pricing.
   */
  enforce?: Enforce;

  /**
   * "inherited" = "True" indicates that the current scope inherits its pricing configuration from its parent. The ID of the parent scope that provides the inherited configuration is displayed in the "inheritedFrom" field. On the other hand, "inherited" = "False" indicates that the current scope has its own pricing configuration explicitly set, and does not inherit from its parent. This field is read only and available only for resource-level pricing.
   */
  @visibility(Lifecycle.Read)
  inherited?: Inherited;

  /**
   * The id of the scope inherited from. "Null" if not inherited. This field is only available for resource-level pricing.
   */
  @visibility(Lifecycle.Read)
  inheritedFrom?: string;

  /**
   * This field is available for subscription-level only, and reflects the coverage status of the resources under the subscription. Please note: The "pricingTier" field reflects the plan status of the subscription. However, since the plan status can also be defined at the resource level, there might be misalignment between the subscription's plan status and the resource status. This field helps indicate the coverage status of the resources.
   */
  @visibility(Lifecycle.Read)
  resourcesCoverageStatus?: ResourcesCoverageStatus;

  /**
   * Optional. List of extensions offered under a plan.
   */
  @identifiers(#[])
  extensions?: Extension[];

  /**
   * Optional. True if the plan is deprecated. If there are replacing plans they will appear in `replacedBy` property
   */
  @visibility(Lifecycle.Read)
  deprecated?: boolean;

  /**
   * Optional. List of plans that replace this plan. This property exists only if this plan is deprecated.
   */
  @visibility(Lifecycle.Read)
  replacedBy?: string[];
}

/**
 * A plan's extension properties
 */
model Extension {
  /**
   * The extension name. Supported values are: <br><br>**AgentlessDiscoveryForKubernetes** - Provides zero footprint, API-based discovery of Kubernetes clusters, their configurations and deployments. The collected data is used to create a contextualized security graph for Kubernetes clusters, provide risk hunting capabilities, and visualize risks and threats to  Kubernetes environments and workloads.<br>Available for CloudPosture plan and Containers plan.<br><br>**OnUploadMalwareScanning** - Limits the GB to be scanned per month for each storage account within the subscription. Once this limit reached on a given storage account, Blobs won't be scanned during current calendar month.<br>Available for StorageAccounts plan (DefenderForStorageV2 sub plans).<br><br>**SensitiveDataDiscovery** - Sensitive data discovery identifies Blob storage container with sensitive data such as credentials, credit cards, and more, to help prioritize and investigate security events.<br>Available for StorageAccounts plan (DefenderForStorageV2 sub plan) and CloudPosture plan.<br><br>**ContainerRegistriesVulnerabilityAssessments** - Provides vulnerability management for images stored in your container registries.<br>Available for CloudPosture plan and Containers plan.<br><br>**MdeDesignatedSubscription** - Direct onboarding is a seamless integration between Defender for Endpoint and Defender for Cloud that doesnâ€™t require extra software deployment on your servers. The onboarded resources will be presented under a designated Azure Subscription you configure<br>Available for VirtualMachines plan (P1 and P2 sub plans).<br><br>**AgentlessVmScanning** - Scans your machines for installed software, vulnerabilities, malware and secret scanning without relying on agents or impacting machine performance. Learn more here https://learn.microsoft.com/en-us/azure/defender-for-cloud/concept-agentless-data-collection.<br>Available for CloudPosture plan, VirtualMachines plan (P2 sub plan) and Containers plan.<br><br>**EntraPermissionsManagement** - Permissions Management provides Cloud Infrastructure Entitlement Management (CIEM) capabilities that helps organizations to manage and control user access and entitlements in their cloud infrastructure - important attack vector for cloud environments.<br>Permissions Management analyzes all permissions and active usage, and suggests recommendations to reduce permissions to enforce the principle of least privilege. Learn more here https://learn.microsoft.com/en-us/azure/defender-for-cloud/permissions-management.<br>Available for CloudPosture plan. <br><br>**FileIntegrityMonitoring** - File integrity monitoring (FIM), examines operating system files.<br>Windows registries, Linux system files, in real time, for changes that might indicate an attack.<br>Available for VirtualMachines plan (P2 sub plan). <br><br>**ContainerSensor** - The sensor is based on IG and provides a rich threat detection suite for Kubernetes clusters, nodes, and workloads, powered by Microsoft leading threat intelligence, provides mapping to MITRE ATT&CK framework.<br>Available for Containers plan. <br><br>**AIPromptEvidence** - Exposes the prompts passed between the user and the AI model as alert evidence. This helps classify and triage the alerts with relevant user context. The prompt snippets will include only segments of the user prompt or model response that were deemed suspicious and relevant for security classifications. The prompt evidence will be available through Defender portal as part of each alert.<br>Available for AI plan. <br><br>
   */
  name: string;

  /**
   * Indicates whether the extension is enabled.
   */
  isEnabled: IsEnabled;

  /**
   * Property values associated with the extension.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  additionalExtensionProperties?: Record<unknown>;

  /**
   * Optional. A status describing the success/failure of the extension's enablement/disablement operation.
   */
  @visibility(Lifecycle.Read)
  operationStatus?: OperationStatus;
}

/**
 * List of pricing configurations response.
 */
model PricingList {
  /**
   * List of pricing configurations
   */
  @pageItems
  value: Pricing[];
}

