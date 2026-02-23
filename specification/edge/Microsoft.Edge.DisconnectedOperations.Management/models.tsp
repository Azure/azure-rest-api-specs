import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.Edge;

/**
 * Connection Intent
 */
union ConnectionIntent {
  /**
   * Device is connected to cloud.
   */
  Connected: "Connected",

  string,

  /**
   * Device is disconnected from cloud.
   */
  Disconnected: "Disconnected",

  string,
}

/**
 * Billing model
 */
union BillingModel {
  /**
   * Billed on capacity.
   */
  @doc("Billed on capacity.")
  Capacity: "Capacity",

  string,
}

/**
 * Connection status
 */
union ConnectionStatus {
  /**
   * Device is connected to cloud.
   */
  Connected: "Connected",

  string,

  /**
   * Device is disconnected from cloud.
   */
  Disconnected: "Disconnected",

  string,
}

/**
 * Registration status
 */
union RegistrationStatus {
  /**
   * Device is registered to cloud.
   */
  Registered: "Registered",

  string,

  /**
   * Device is not registered to cloud.
   */
  Unregistered: "Unregistered",

  string,
}

/**
 * Auto renew status
 */
@added(Microsoft.Edge.Versions.v2026_03_01)
union AutoRenew {
  /**
   * Auto renew is enabled.
   */
  Enabled: "Enabled",

  string,

  /**
   * Auto renew is disabled.
   */
  Disabled: "Disabled",

  string,
}

/**
 * Pricing model
 */
@added(Microsoft.Edge.Versions.v2026_03_01)
union PricingModel {
  /**
   * Trial pricing model.
   */
  Trial: "Trial",

  string,

  /**
   * Annual pricing model.
   */
  Annual: "Annual",

  string,
}

/**
 * Billing status
 */
@added(Microsoft.Edge.Versions.v2026_03_01)
union BillingStatus {
  /**
   * Billing is enabled.
   */
  Enabled: "Enabled",

  string,

  /**
   * Billing is disabled.
   */
  Disabled: "Disabled",

  string,

  /**
   * Billing is stopped.
   */
  Stopped: "Stopped",

  string,
}

/**
 * Benefit plans status
 */
@added(Microsoft.Edge.Versions.v2026_03_01)
union BenefitPlanStatus {
  /**
   * Benefit plan is enabled.
   */
  Enabled: "Enabled",

  string,

  /**
   * Benefit plan is disabled.
   */
  Disabled: "Disabled",

  string,
}

@doc("The benefit plans")
@added(Microsoft.Edge.Versions.v2026_03_01)
model BenefitPlans {
  @doc("Azure Hybrid Windows Server Benefit plan")
  azureHybridWindowsServerBenefit?: BenefitPlanStatus;

  @doc("Number of Windows Server VMs to license under the Azure Hybrid Benefit plan")
  @added(Microsoft.Edge.Versions.v2026_03_01)
  @minValue(1)
  windowsServerVmCount?: int32;
}

@doc("The disconnected operation properties")
model DisconnectedOperationProperties {
  @visibility(Lifecycle.Read)
  @doc("The resource provisioning state")
  provisioningState?: ResourceProvisioningState;

  @visibility(Lifecycle.Read)
  @doc("The unique GUID of the stamp")
  stampId: string;

  @visibility(Lifecycle.Read)
  @doc("The billing model")
  billingModel: BillingModel;

  @renamedFrom(Microsoft.Edge.Versions.v2026_03_01, "connectionIntent")
  @removed(Microsoft.Edge.Versions.v2026_03_01)
  @doc("The connection intent")
  oldConnectionIntent: ConnectionIntent;

  @added(Microsoft.Edge.Versions.v2026_03_01)
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("The connection intent")
  connectionIntent: ConnectionIntent;

  @visibility(Lifecycle.Read)
  @doc("The connection status")
  connectionStatus?: ConnectionStatus;

  @doc("The registration intent")
  @visibility(Lifecycle.Update, Lifecycle.Read)
  registrationStatus?: RegistrationStatus;

  @doc("The device version")
  @visibility(Lifecycle.Update, Lifecycle.Read)
  deviceVersion?: string;

  @doc("The billing configuration")
  @added(Microsoft.Edge.Versions.v2026_03_01)
  billingConfiguration?: BillingConfiguration;

  @doc("The benefit plans")
  @added(Microsoft.Edge.Versions.v2026_03_01)
  benefitPlans?: BenefitPlans;
}

@doc("The disconnected operation manifest")
model DisconnectedOperationDeploymentManifest {
  @visibility(Lifecycle.Read)
  @doc("The resource identifier of the disconnected operations resource")
  resourceId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Edge/disconnectedOperations";
    }
  ]>;

  @visibility(Lifecycle.Read)
  @doc("The resource name")
  resourceName: string;

  @visibility(Lifecycle.Read)
  @doc("The unique GUID of the stamp")
  stampId: string;

  @visibility(Lifecycle.Read)
  @doc("The resource location")
  location: string;

  @visibility(Lifecycle.Read)
  @doc("The billing model")
  billingModel: BillingModel;

  @visibility(Lifecycle.Read)
  @doc("The connection intent")
  connectionIntent: ConnectionIntent;

  @visibility(Lifecycle.Read)
  @doc("The cloud in which the resource is registered")
  @added(Microsoft.Edge.Versions.v2025_06_01)
  cloud?: string;

  @visibility(Lifecycle.Read)
  @doc("The billing configuration")
  @added(Microsoft.Edge.Versions.v2026_03_01)
  billingConfiguration?: BillingConfiguration;

  @visibility(Lifecycle.Read)
  @doc("The benefit plans")
  @added(Microsoft.Edge.Versions.v2026_03_01)
  benefitPlans?: BenefitPlans;
}

/**
 * Release Type
 */
union ReleaseType {
  /**
   * Release is a new install.
   */
  Install: "Install",

  string,

  /**
   * Release is update.
   */
  Update: "Update",

  string,
}

/**
 * System Reboot
 */
@added(Microsoft.Edge.Versions.v2026_03_01)
union SystemReboot {
  /**
   * System reboot is required.
   */
  Required: "Required",

  string,

  /**
   * System reboot is not required.
   */
  NotRequired: "NotRequired",

  string,
}

@added(Microsoft.Edge.Versions.v2026_03_01)
@doc("The update properties of the Update Release type Image")
model ImageUpdateProperties {
  @visibility(Lifecycle.Read)
  @doc("Indicates if a system reboot is required after applying the update.")
  systemReboot: SystemReboot;

  @visibility(Lifecycle.Read)
  @doc("Details of security updates included in this image release.")
  securityUpdates: string;

  @visibility(Lifecycle.Read)
  @doc("The operating system version provided by this image update.")
  osVersion: string;

  @visibility(Lifecycle.Read)
  @doc("The version(s) of the agent software included in this image update.")
  agentVersion: string;

  @visibility(Lifecycle.Read)
  @doc("Details of feature updates included in this image release.")
  featureUpdates: string;
}

@doc("The image properties")
model ImageProperties {
  @visibility(Lifecycle.Read)
  @doc("The resource provisioning state")
  provisioningState?: ResourceProvisioningState;

  @visibility(Lifecycle.Read)
  @doc("The version of the package in the format 1.1.1")
  releaseVersion: string;

  @visibility(Lifecycle.Read)
  @doc("The release name")
  releaseDisplayName: string;

  @visibility(Lifecycle.Read)
  @doc("The release notes")
  releaseNotes: string;

  @visibility(Lifecycle.Read)
  @doc("The release date")
  releaseDate: plainDate;

  @visibility(Lifecycle.Read)
  @doc("The release type")
  releaseType: ReleaseType;

  @visibility(Lifecycle.Read)
  @doc("The versions that are compatible for this update package.")
  compatibleVersions?: Array<string>;

  @added(Microsoft.Edge.Versions.v2026_03_01)
  @visibility(Lifecycle.Read)
  @doc("The image update properties for update release type image.")
  updateProperties?: ImageUpdateProperties;
}

@doc("The image download properties")
model ImageDownloadResult {
  ...ImageProperties;

  @visibility(Lifecycle.Read)
  @doc("The unique identifier of the download")
  transactionId: string;

  @visibility(Lifecycle.Read)
  @doc("The download URI")
  downloadLink: url;

  @visibility(Lifecycle.Read)
  @doc("The download link expiry time")
  linkExpiry: utcDateTime;
}

@doc("The artifact properties")
model ArtifactProperties {
  @visibility(Lifecycle.Read)
  @doc("The resource provisioning state")
  provisioningState?: ResourceProvisioningState;

  @visibility(Lifecycle.Read)
  @doc("The artifact display order")
  artifactOrder: int32;

  @visibility(Lifecycle.Read)
  @doc("The artifact title")
  title: string;

  @visibility(Lifecycle.Read)
  @doc("The artifact description")
  description: string;

  @visibility(Lifecycle.Read)
  @doc("The artifact size in MB")
  size?: int64;
}

@doc("The artifact download properties")
model ArtifactDownloadResult {
  ...ArtifactProperties;

  @visibility(Lifecycle.Read)
  @doc("The download URI")
  downloadLink: url;

  @visibility(Lifecycle.Read)
  @doc("The download link expiry time")
  linkExpiry: utcDateTime;
}

@doc("The hardware setting properties")
@added(Microsoft.Edge.Versions.v2026_03_01)
model HardwareSettingProperties {
  @visibility(Lifecycle.Read)
  @doc("The resource provisioning state")
  provisioningState?: ResourceProvisioningState;

  @doc("The total number of cores")
  totalCores: int32;

  @doc("The disk space in GB")
  diskSpaceInGb: int32;

  @doc("The memory in GB")
  memoryInGb: int32;

  @doc("The OEM")
  oem: string;

  @doc("The hardware SKU")
  hardwareSku: string;

  @doc("The number of nodes")
  nodes: int32;

  @doc("The active version at registration")
  versionAtRegistration: string;

  @doc("The solution builder extension at registration")
  solutionBuilderExtension: string;

  @doc("The unique identifier of the device")
  deviceId: string;
}

@doc("The billing period")
@added(Microsoft.Edge.Versions.v2026_03_01)
model BillingPeriod {
  @doc("The number of cores")
  cores: int32;

  @doc("The pricing model")
  pricingModel: PricingModel;

  @visibility(Lifecycle.Read)
  @doc("The billing start date")
  startDate?: plainDate;

  @visibility(Lifecycle.Read)
  @doc("The billing end date")
  endDate?: plainDate;
}

@doc("The billing configuration")
@added(Microsoft.Edge.Versions.v2026_03_01)
model BillingConfiguration {
  @doc("The auto renew setting")
  autoRenew: AutoRenew;

  @visibility(Lifecycle.Read)
  @doc("The billing status")
  billingStatus: BillingStatus;

  @doc("The current billing configuration")
  current: BillingPeriod;

  @doc("The upcoming billing configuration")
  @visibility(Lifecycle.Update, Lifecycle.Read)
  upcoming?: BillingPeriod;
}
