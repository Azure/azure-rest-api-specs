import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "../../Common/ArmModels/AzureResourceProperties.tsp";
import "../EvaluatedEntities/EvaluatedMachine.tsp";
import "../EvaluatedEntities/EvaluatedAVSMachine.tsp";
import "../EvaluatedEntities/EvaluatedSqlEntity.tsp";
import "../EvaluatedEntities/EvaluatedWebApp.tsp";
import "../Common/Models.tsp";
import "../Common/Enums.tsp";
import "../Summaries/IaasSummary.tsp";
import "../Summaries/AvsSummary.tsp";
import "../Summaries/PaasSummary.tsp";
import "../Summaries/OverviewSummary.tsp";
import "../Summaries/CompareSummary.tsp";
import "../../Common/ArmModels/AssessmentProjectV2.tsp";
import "../../Common/ArmModels/PrivateEndpointConnection.tsp";

using Autorest;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.Migrate;

@doc("Business case resource.")
@parentResource(AssessmentProject)
model BusinessCase is ProxyResource<BusinessCaseProperties> {
  @doc("Business case ARM name")
  @key("businessCaseName")
  @segment("businessCases")
  @path
  // "^[^<>&:\\?\/#\x00-\x1F\x7F]{1,260}$"
  @pattern("^[^<>&:\\?/#]{1,260}$")
  name: string;
}

@doc("""
  Property bag for an
  Microsoft.Azure.Migrate.BusinessCaseService.Api.V20220202_preview.Resources.BusinessCase
  resource.
  """)
model BusinessCaseProperties is AzureResourceProperties {
  @doc("Business case settings.")
  settings?: Settings;

  @doc("Business case state.")
  @visibility(Lifecycle.Read)
  state?: BusinessCaseState;

  @doc("Gets the state of business case reports.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  reportStatusDetails?: ReportDetails[];

  @doc("Gets the business case scope.")
  @visibility(Lifecycle.Read)
  businessCaseScope?: BusinessCaseScope;
}

@doc("Business case report details.")
model ReportDetails {
  @doc("Report type.")
  @visibility(Lifecycle.Read)
  reportType?: ReportType;

  @doc("Report status.")
  @visibility(Lifecycle.Read)
  reportStatus?: ReportStatus;
}

@doc("Business case settings.")
model Settings {
  @doc("Azure settings for a business case.")
  azureSettings: AzureSettings;

  @doc("On-premise settings.")
  onPremiseSettings?: OnPremiseSettings;

  @doc("Azure arc settings.")
  azureArcSettings?: AzureArcSettings;
}

@doc("Azure settings for a business case.")
model AzureSettings {
  @doc("Gets or sets azure location.")
  targetLocation: string;

  @doc("Gets azure Discount percentage.")
  @minValue(0.0)
  @maxValue(100.0)
  discountPercentage?: float32;

  @doc("Business case Currency.")
  currency: BusinessCaseCurrency = BusinessCaseCurrency.USD;

  @doc("Migration Strategy.")
  businessCaseType?: MigrationStrategy = MigrationStrategy.OptimizeForCost;

  @doc("Workload discovery source.")
  workloadDiscoverySource?: DiscoverySource = DiscoverySource.Appliance;

  @doc("Gets start time to use for performance.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  performanceDataStartTime?: utcDateTime;

  @doc("Gets end time to use for performance.")
  // FIXME:(utcDateTime) Please double check that this is the correct type for your scenario.
  performanceDataEndTime?: utcDateTime;

  @doc("Gets comfort factor.")
  comfortFactor?: float32 = 1.0;

  @doc("Gets utilization percentile for performance.")
  @minValue(0.0)
  @maxValue(100.0)
  performanceUtilizationPercentile?: float32 = 95;

  @doc("Gets migration completion percentage per year.")
  @identifiers(#[])
  perYearMigrationCompletionPercentage?: NameValuePair<string, float32>[];

  @doc("Gets infrastructure growth rate.")
  @minValue(0.0)
  @maxValue(100.0)
  infrastructureGrowthRate?: float32 = 5.0;

  @doc("Gets wACC percentage.")
  @minValue(0.0)
  @maxValue(100.0)
  wacc?: float32;

  @doc("Gets network cost percentage.")
  @minValue(0.0)
  @maxValue(100.0)
  networkCostPercentage?: float32 = 5.0;

  @doc("Gets IaaS labour cost percentage.")
  @minValue(0.0)
  @maxValue(100.0)
  iaasLaborCostPercentage?: float32 = 75;

  @doc("Gets PaaS labour cost percentage.")
  @minValue(0.0)
  @maxValue(100.0)
  paasLaborCostPercentage?: float32 = 60;

  @doc("Gets Avs labour cost percentage.")
  @minValue(0.0)
  @maxValue(100.0)
  avsLaborCostPercentage?: float32 = 75;

  @doc("Gets the business case savings option type.")
  savingsOption?: SavingsOption = SavingsOption.RI3Year;
}

@doc("On-premise settings.")
model OnPremiseSettings {
  @doc("Compute settings.")
  computeSettings: ComputeSettings;

  @doc("Storage settings.")
  storageSettings: StorageSettings;

  @doc("Network settings.")
  networkSettings: NetworkSettings;

  @doc("Facility settings.")
  facilitySettings: FacilitySettings;

  @doc("Labour settings.")
  laborSettings: LaborSettings;

  @doc("Security settings.")
  securitySettings: SecuritySettings;

  @doc("Management settings.")
  managementSettings?: ManagementSettings;
}

@doc("Azure arc settings for a business case.")
model AzureArcSettings {
  @doc("AzureArc state indicates whether to include azure arc related costs in on-premises or not.")
  azureArcState: AzureArcState;

  @doc("Gets Azure arc labour cost percentage.")
  @minValue(0.0)
  @maxValue(100.0)
  laborCostPercentage?: float32;

  @doc("Management settings.")
  managementSettings?: AzureArcManagementSettings;
}

@doc("Compute settings.")
model ComputeSettings {
  @doc("Hyperthread core to memory ratio.")
  hyperthreadCoreToMemoryRatio: float32;

  @doc("Compute Price.")
  price: float32;

  @doc("Compute Hardware Maintenance Cost.")
  computeHardwareMaintenanceCost: float32;

  @doc("VM Oversubscription Ratio.")
  vmOversubscriptionRatio: float32;

  @doc("CPU Oversubscription Ratio.")
  cpuOversubscriptionRatio: float32;

  @doc("SQL Server licensing settings.")
  @identifiers(#[])
  sqlServerLicensing: SqlServerLicensingSettings[];

  @doc("Windows Server licensing settings.")
  windowsServerLicensing: WindowsServerLicensingSettings;

  @doc("Linux Rhel Server licensing settings.")
  rhelLinuxServerLicensing: LinuxServerLicensingSettings;

  @doc("Linux Suse Server licensing settings.")
  suseLinuxServerLicensing: LinuxServerLicensingSettings;

  @doc("Virtualization software settings.")
  virtualizationSoftwareSettings: VirtualizationSoftwareSettings;
}

@doc("SQL Server licensing settings.")
model SqlServerLicensingSettings {
  @doc("SQL Server version.")
  version: SqlServerLicenseType;

  @doc("Licence cost.")
  licenseCost: float32;

  @doc("Software assurance (SA) cost.")
  softwareAssuranceCost: float32;
}

@doc("Windows Server licensing settings.")
model WindowsServerLicensingSettings {
  @doc("Licence Cost.")
  licenseCost: float32;

  @doc("Software assurance (SA) cost.")
  softwareAssuranceCost: float32;

  @doc("Licenses per core.")
  licensesPerCore: int32;
}

@doc("Linux Server licensing settings.")
model LinuxServerLicensingSettings {
  @doc("Licence Cost.")
  licenseCost: float32;
}

@doc("Virtualization software settings.")
model VirtualizationSoftwareSettings {
  @doc("VMware cloud foundation license cost.")
  vMwareCloudFoundationLicenseCost: float32;
}

@doc("Representation of a vsphere licence base.")
model VsphereLicenseBase {
  @doc("Cost of a licence.")
  licenseCost: float32;

  @doc("Basic support cost.")
  basicSupportCost: float32;

  @doc("Production support cost.")
  productionSupportCost: float32;
}

@doc("Representation of a vsphere licence.")
model VsphereLicense is VsphereLicenseBase {
  @doc("VSphere licence type.")
  licenseType: LicenseType;
}

@doc("Storage settings.")
model StorageSettings {
  @doc("Cost per gigabyte per year.")
  costPerGbPerYear: float32;

  @doc("Maintenance cost percentage.")
  @minValue(0.0)
  @maxValue(100.0)
  maintainanceCostPercentageToAcquisitionCost: float32;
}

@doc("Network settings.")
model NetworkSettings {
  @doc("Network maintenance cost percentage.")
  @minValue(0.0)
  @maxValue(100.0)
  maintenanceCostPercentage: float32;

  @doc("Number of physical servers per cabinet")
  physicalServersPerCabinet: int32;

  @doc("Average cost per cabinet")
  averageCostPerCabinet: float32;
}

@doc("Facility settings.")
model FacilitySettings {
  @doc("The facilities cost.")
  facilitiesCostPerKwh?: float32;

  @doc("Power utilization Efficiency.")
  @minValue(1.0)
  powerUtilizationEfficiency: float32;
}

@doc("Labour settings.")
model LaborSettings {
  @doc("Physical servers per administrator.")
  @minValue(1)
  physicalServersPerAdmin: int32;

  @doc("Virtual machines per administrator.")
  @minValue(1)
  virtualMachinesPerAdmin: int32;

  @doc("Hourly administrator cost.")
  hourlyAdminCost: float32;
}

@doc("Security settings.")
model SecuritySettings {
  @doc("Physical servers per administrator.")
  serverSecurityCostPerServerPerYear: float32;

  @doc("Virtual machines per administrator.")
  sqlServerSecurityCostPerServerPerYear: float32;
}

@doc("Management settings.")
model ManagementSettings {
  @doc("HyperV Virtualization Management Settings.")
  hypervVirtualizationManagementSettings: HypervVirtualizationManagementSettings;

  @doc("Third Party Management Settings.")
  thirdPartyManagementSettings: ThirdPartyManagementSettings;

  @doc("Other Management Costs Settings.")
  otherManagementCostsSettings: OtherManagementCostsSettings;
}

@doc("HyperV Virtualization Management Settings.")
model HypervVirtualizationManagementSettings {
  @doc("Number of physical cores per licence.")
  @minValue(1)
  numberOfPhysicalCoresPerLicense: int32;

  @doc("Software Assurance Cost.")
  softwareAssuranceCost: float32;

  @doc("Licence and support list.")
  @identifiers(#[])
  licenseAndSupportList: HypervLicense[];
}

@doc("Representation of a licence.")
model HypervLicense {
  @doc("Cost of a licence.")
  licenseCost: float32;

  @doc("HyperV licence type.")
  licenseType: HyperVLicenseType;
}

@doc("Vsphere management settings.")
model VsphereManagementSettings {
  @doc("Licence and support list.")
  @identifiers(#[])
  licenseAndSupportList: VsphereManagementLicense[];
}

@doc("Representation of a vsphere management licence.")
model VsphereManagementLicense is VsphereLicenseBase {
  @doc("VSphere licence type.")
  licenseType: VsphereManagementLicenseType;
}

@doc("Third Party Management settings.")
model ThirdPartyManagementSettings {
  @doc("License Cost.")
  licenseCost: float32;

  @doc("Support Cost.")
  supportCost: float32;
}

@doc("Other Management Costs Settings.")
model OtherManagementCostsSettings {
  @doc("Monitoring Cost Per Server Per Year.")
  monitoringCostPerServerPerYear: float32;

  @doc("Patching Cost Per Server Per Year.")
  patchingCostPerServerPerYear: float32;

  @doc("Data Protection Cost Per Server Per Year.")
  dataProtectionCostPerServerPerYear: float32;
}

@doc("Azure Arc Management settings.")
model AzureArcManagementSettings {
  @doc("Gets the azure arc monitoring settings.")
  monitoringSettings: AzureArcMonitoringSettings;
}

@doc("Azure Arc Monitoring settings.")
model AzureArcMonitoringSettings {
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is present in older API versions."
  @doc("Logs volume settings.")
  logsVolumeInGB: float32;

  @doc("Number of alert rules settings.")
  alertRulesCount: int32;
}

@doc("Business case scope.")
model BusinessCaseScope {
  @doc("Scope type.")
  @visibility(Lifecycle.Read)
  scopeType: ScopeType;

  @doc("ARG query.")
  @visibility(Lifecycle.Read)
  azureResourceGraphQuery?: string;
}
