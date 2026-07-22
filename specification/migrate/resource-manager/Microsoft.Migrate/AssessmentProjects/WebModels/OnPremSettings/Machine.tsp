import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";

using Autorest;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.Migrate;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-name-pattern" "Singleton resource"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Operations on the resource are sync"
@doc("Machine On-Premises Settings resource used for calculating on-premises cost.")
@parentResource(AssessmentProject)
@added(AssessmentProjectApiVersions.v2025_09_09_preview)
model MachineOnPremSettings is ProxyResource<MachineOnPremSettingsProperties> {
  @doc("The name of the Machine On-Premises Settings resource.")
  @key("machineOnPremSettingsName")
  @segment("machineOnPremSettings")
  @path
  name: "default";
}

@doc("Properties for Machine On-Premises Settings.")
@added(AssessmentProjectApiVersions.v2025_09_09_preview)
model MachineOnPremSettingsProperties is AzureResourceProperties {
  @doc("Compute-related configuration and cost assumptions for on-premises machines.")
  computeSettings?: MachineComputeSettings;

  @doc("Storage-related configuration and cost assumptions for on-premises machines.")
  storageSettings?: MachineStorageSettings;

  @doc("Network-related configuration and cost assumptions for on-premises infrastructure.")
  networkSettings?: MachineNetworkSettings;

  @doc("Facility-related configuration such as power, cooling, and space costs.")
  facilitySettings?: MachineFacilitySettings;

  @doc("Labor-related configuration including staffing ratios and hourly costs.")
  laborSettings?: MachineLaborSettings;

  @doc("Security-related configuration including physical and software security costs.")
  securitySettings?: MachineSecuritySettings;

  @doc("Management-related configuration including virtualization and third-party tooling.")
  managementSettings?: MachineManagementSettings;

  @doc("Azure Arc–related configuration and cost settings for on-premises machines.")
  azureArcSettings?: AzureArcSettings;

  @doc("Customer-defined cost overrides for on-premises cost categories.")
  @identifiers(#["name"])
  costOverrides?: CostOverride[];

  @doc("Metadata describing the reconciliation status of the settings.")
  reconciliationInfo?: MachineReconciliationInfo;
}

@doc("Compute configuration and licensing settings for an on-premises machine.")
@added(AssessmentProjectApiVersions.v2025_09_09_preview)
model MachineComputeSettings {
  @doc("Ratio of hyperthreaded CPU cores to memory.")
  hyperthreadCoreToMemoryRatio?: float32;

  @doc("Base price of compute resources.")
  price?: float32;

  @doc("Windows Server licensing configuration.")
  windowsServerLicensing?: WindowsServerLicensingSetting;

  @doc("RHEL Linux Server licensing configuration.")
  rhelLinuxServerLicensing?: LinuxServerLicensingSetting;

  @doc("SUSE Linux Server licensing configuration.")
  suseLinuxServerLicensing?: LinuxServerLicensingSetting;

  @doc("Virtualization software configuration and licensing details.")
  virtualizationSoftwareSettings?: VirtualizationSoftwareSettings;

  @doc("Annual compute hardware maintenance cost as a percentage.")
  computeHardwareMaintenanceCostPercentage?: float32;

  @doc("Virtual machine oversubscription ratio.")
  vmOversubscriptionRatio?: float32;

  @doc("CPU oversubscription ratio.")
  cpuOversubscriptionRatio?: float32;
}

@doc("Licensing information for a Linux server.")
@added(AssessmentProjectApiVersions.v2025_09_09_preview)
model LinuxServerLicensingSetting {
  @doc("Cost of the Linux server license.")
  licenseCost: float32;
}

@doc("Licensing information for a Windows server.")
@added(AssessmentProjectApiVersions.v2025_09_09_preview)
model WindowsServerLicensingSetting {
  @doc("Cost of the Windows Server license.")
  licenseCost: float32;

  @doc("Cost of Software Assurance for Windows Server.")
  softwareAssuranceCost: float32;

  @doc("Number of licenses required per physical core.")
  licensesPerCore: float32;
}

@doc("VSphere license types")
@added(AssessmentProjectApiVersions.v2025_09_09_preview)
union LicenseType {
  string,

  @doc("VSphere Standard")
  VSphereStandard: "VSphereStandard",

  @doc("VSphere Enterprise Plus")
  VSphereEnterprisePlus: "VSphereEnterprisePlus",

  @doc("VSphere Server Standard")
  VSphereServerStandard: "VSphereServerStandard",
}

@doc("VSphere management license types")
@added(AssessmentProjectApiVersions.v2025_09_09_preview)
union VSphereManagementLicenseType {
  string,

  @doc("VSphere Standard Management")
  VSphereServerStandard: "VSphereServerStandard",
}

@doc("HyperV license types")
@added(AssessmentProjectApiVersions.v2025_09_09_preview)
union HyperVLicenseType {
  string,

  @doc("Datacentre license")
  Datacentre: "Datacentre",

  @doc("Standard license")
  Standard: "Standard",
}

@doc("HyperV license information")
@added(AssessmentProjectApiVersions.v2025_09_09_preview)
model HyperVirtualizationLicense {
  @doc("License cost")
  licenseCost?: float32;

  @doc("Basic support cost")
  basicSupportCost?: float32;

  @doc("Production support cost")
  productionSupportCost?: float32;

  @doc("Type of HyperV license")
  licenseType?: HyperVLicenseType;
}

@doc("Virtualization software settings used in on-premises assessment.")
@added(AssessmentProjectApiVersions.v2025_09_09_preview)
model VirtualizationSoftwareSettings {
  @doc("List of virtualization license and support information.")
  @identifiers(#["licenseType"])
  licenseAndSupportList?: LicenseAndSupportInfo[];

  @doc("VMware Cloud Foundation license cost.")
  vMwareCloudFoundationLicenseCost?: float64;

  @doc("Number of physical CPU cores covered per license.")
  numberOfPhysicalCoresPerLicense?: int32;

  @doc("Software Assurance cost for virtualization software.")
  softwareAssuranceCost?: float64;
}

@doc("Storage configuration and cost settings for an on-premises machine.")
@added(AssessmentProjectApiVersions.v2025_09_09_preview)
model MachineStorageSettings {
  @doc("Cost per gigabyte of storage per year.")
  costPerGbPerYear?: float32;

  @doc("Maintenance cost percentage relative to acquisition cost.")
  maintainanceCostPercentageToAcquisitionCost?: float32;
}

@doc("Network configuration and cost settings for on-premises infrastructure.")
@added(AssessmentProjectApiVersions.v2025_09_09_preview)
model MachineNetworkSettings {
  @doc("Number of physical servers hosted per network cabinet.")
  physicalServersPerCabinet?: int32;

  @doc("Average cost per network cabinet.")
  averageCostPerCabinet?: float32;

  @doc("Annual maintenance cost percentage for network infrastructure.")
  maintenanceCostPercentage?: float32;
}

@doc("Facility-related configuration and cost settings.")
@added(AssessmentProjectApiVersions.v2025_09_09_preview)
model MachineFacilitySettings {
  @doc("Total facilities-related cost.")
  facilitiesCost?: float64;

  @doc("Power utilization efficiency of the facility.")
  powerUtilizationEfficiency?: float32;

  @doc("Facilities cost per kilowatt-hour.")
  facilitiesCostPerKwh?: float32;
}

@doc("Labor-related configuration and cost settings.")
@added(AssessmentProjectApiVersions.v2025_09_09_preview)
model MachineLaborSettings {
  @doc("Number of physical servers managed per administrator.")
  physicalServersPerAdmin?: int32;

  @doc("Number of virtual machines managed per administrator.")
  virtualMachinesPerAdmin?: int32;

  @doc("Hourly cost of an administrator.")
  hourlyAdminCost?: float32;
}

@doc("Security-related configuration and cost settings.")
@added(AssessmentProjectApiVersions.v2025_09_09_preview)
model MachineSecuritySettings {
  @doc("Annual security cost per server.")
  serverSecurityCostPerServerPerYear?: float32;
}

@doc("Management-related configuration and cost settings.")
@added(AssessmentProjectApiVersions.v2025_09_09_preview)
model MachineManagementSettings {
  @doc("vSphere-specific management and licensing settings.")
  vSphereManagementSettings?: VsphereManagementSettings;

  @doc("Hyper-V virtualization management settings.")
  hypervVirtualizationSoftwareSettings?: AssessmentHypervVirtualizationManagementSettings;

  @doc("Third-party management tool configuration.")
  thirdPartyManagementSettings?: ThirdPartyManagementSettings;

  @doc("Other management-related cost settings.")
  otherManagementCostsSettings?: OtherManagementCostsSettings;
}

@doc("vSphere management and licensing settings.")
@added(AssessmentProjectApiVersions.v2025_09_09_preview)
model VsphereManagementSettings {
  @doc("List of vSphere license and support information.")
  @identifiers(#["licenseType"])
  licenseAndSupportList?: LicenseAndSupportInfo[];
}

@doc("Hyper-V virtualization management settings for assessment.")
@added(AssessmentProjectApiVersions.v2025_09_09_preview)
model AssessmentHypervVirtualizationManagementSettings {
  @doc("Number of physical CPU cores covered per license.")
  numberOfPhysicalCoresPerLicense: int32;

  @doc("Software Assurance cost for Hyper-V.")
  softwareAssuranceCost: float32;

  @doc("List of Hyper-V license and support information.")
  @identifiers(#["licenseType"])
  licenseAndSupportList: HyperVirtualizationLicense[];
}

@doc("License and support cost information.")
@added(AssessmentProjectApiVersions.v2025_09_09_preview)
model LicenseAndSupportInfo {
  @doc("Type of license.")
  licenseType: string;

  @doc("Cost of the license.")
  licenseCost: float64;

  @doc("Basic support cost.")
  basicSupportCost?: float64;

  @doc("Production support cost.")
  productionSupportCost?: float64;
}

@doc("Third-party management tool configuration.")
@added(AssessmentProjectApiVersions.v2025_09_09_preview)
model ThirdPartyManagementSettings {
  @doc("License cost for third-party management tools.")
  licenseCost?: float32;

  @doc("Support cost for third-party management tools.")
  supportCost?: float32;
}

@doc("Other management-related cost settings.")
@added(AssessmentProjectApiVersions.v2025_09_09_preview)
model OtherManagementCostsSettings {
  @doc("Monitoring cost per server per year.")
  monitoringCostPerServerPerYear?: float32;

  @doc("Patching cost per server per year.")
  patchingCostPerServerPerYear?: float32;

  @doc("Data protection cost per server per year.")
  dataProtectionCostPerServerPerYear?: float32;

  @doc("storage backup cost per year.")
  storageBackupCostPerGbPerYear?: float32;
}

@doc("Possible states of Azure Arc enablement.")
@added(AssessmentProjectApiVersions.v2025_09_09_preview)
union AzureArcState {
  @doc("Azure Arc is enabled for the on-premises machine.")
  Enabled: "Enabled",

  @doc("Azure Arc is disabled for the on-premises machine.")
  Disabled: "Disabled",

  @doc("Allows future Azure Arc states.")
  string,
}

@doc("Azure Arc–related configuration and cost settings for on-premises machines.")
@added(AssessmentProjectApiVersions.v2025_09_09_preview)
model AzureArcSettings {
  @doc("Indicates whether Azure Arc is enabled or disabled.")
  azureArcState?: AzureArcState;

  @doc("Percentage of labor cost attributed to Azure Arc management.")
  laborCostPercentage?: float32;

  @doc("Azure Arc management-related configuration.")
  managementSettings?: AzureArcManagementSettings;
}

@doc("Management configuration for Azure Arc.")
@added(AssessmentProjectApiVersions.v2025_09_09_preview)
model AzureArcManagementSettings {
  @doc("Monitoring-related settings for Azure Arc.")
  monitoringSettings?: AzureArcMonitoringSettings;
}

@doc("Monitoring settings used by Azure Arc.")
@added(AssessmentProjectApiVersions.v2025_09_09_preview)
model AzureArcMonitoringSettings {
  @doc("Volume of logs generated per month in gigabytes.")
  logsVolumeInGb?: float32;

  @doc("Number of alert rules configured.")
  alertRulesCount?: int32;
}

@doc("Reconciliation metadata for On-Premises Settings.")
@added(AssessmentProjectApiVersions.v2025_09_09_preview)
model MachineReconciliationInfo {
  @doc("Timestamp of the last reconciliation.")
  lastReconciliationTime?: utcDateTime;

  @doc("Current reconciliation status.")
  reconciliationStatus?: string;

  @doc("Source that triggered reconciliation.")
  reconciliationTriggerSource?: string;
}
