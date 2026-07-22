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
@doc("On-premises Total Cost of Ownership resource.")
@added(AssessmentProjectApiVersions.v2025_09_09_preview)
model OnPremTco
  is Azure.ResourceManager.ExtensionResource<OnPremTcoProperties> {
  @doc("The name of the on-premises TCO resource.")
  @key("onPremisesTcoName")
  @segment("onPremTcoDetails")
  @path
  name: "default";
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Operations on the resource are sync"
@doc("Properties describing on-premises Total Cost of Ownership.")
@added(AssessmentProjectApiVersions.v2025_09_09_preview)
model OnPremTcoProperties {
  @doc("Overall aggregated total, capex, and opex costs for on-premises workloads.")
  overallCost: CostComponentDetails;

  @doc("Detailed breakdown of on-premises cost components.")
  costDetails: CostDetailsV2;

  @doc("Carbon emission details associated with on-premises workloads.")
  sustainabilityDetails: CarbonEmissionsDetails;

  @doc("Year-wise Extended Security Update (ESU) costs for on-premises workloads.")
  @identifiers(#["year"])
  yearlyOnPremisesEsu: YearlyEsuDetails[];
}

@doc("Represents a breakdown of a cost component (total, capex, opex).")
@added(AssessmentProjectApiVersions.v2025_09_09_preview)
model CostComponentDetails {
  @doc("Gets or sets the total cost.")
  totalCost?: float64;

  @doc("Gets or sets the capital expenditure (CapEx) cost.")
  capexCost?: float64;

  @doc("Gets or sets the operational expenditure (OpEx) cost.")
  opexCost?: float64;

  @visibility(Lifecycle.Read)
  @doc("Gets or sets the list of cost line items.")
  @identifiers(#[])
  costLineItems?: CostLineItem[];
}

@doc("Represents the type of cost component.")
@added(AssessmentProjectApiVersions.v2025_09_09_preview)
union CostComponentType {
  @doc("Unknown or uninitialized cost type.")
  Unknown: "Unknown",

  @doc("Capital expenditure (CapEx) cost.")
  CapexCost: "CapexCost",

  @doc("Operational expenditure (OpEx) cost.")
  OpexCost: "OpexCost",

  string,
}

@doc("Represents the category of a cost component.")
@added(AssessmentProjectApiVersions.v2025_09_09_preview)
union CostComponentCategory {
  @doc("Unknown or uninitialized category.")
  Unknown: "Unknown",

  @doc("Hardware acquisition cost.")
  HardwareAcquisitionCost: "HardwareAcquisitionCost",

  @doc("Virtualization license cost.")
  VirtualizationLicenseCost: "VirtualizationLicenseCost",

  @doc("Linux license cost.")
  LinuxLicenseCost: "LinuxLicenseCost",

  @doc("SQL license cost.")
  SqlLicenseCost: "SqlLicenseCost",

  @doc("Windows license cost.")
  WindowsLicenseCost: "WindowsLicenseCost",

  @doc("ESU costs.")
  EsuCosts: "EsuCosts",

  @doc("Hardware maintainance cost.")
  HardwareMaintainanceCost: "HardwareMaintainanceCost",

  @doc("Storage acquisition cost.")
  StorageAcquisitionCost: "StorageAcquisitionCost",

  @doc("Storage maintenance cost.")
  StorageMaintenanceCost: "StorageMaintenanceCost",

  @doc("Network acquisition cost.")
  NetworkAcquisitionCost: "NetworkAcquisitionCost",

  @doc("Network maintenance cost.")
  NetworkMaintenanceCost: "NetworkMaintenanceCost",

  @doc("Facilities cost.")
  FacilitiesCost: "FacilitiesCost",

  @doc("Security cost.")
  SecurityCost: "SecurityCost",

  @doc("Labor cost.")
  LaborCost: "LaborCost",

  @doc("Monitoring cost in Azure Arc.")
  AzureArcMonitoringCost: "AzureArcMonitoringCost",

  @doc("Patching cost in Azure Arc.")
  AzureArcPatchingCost: "AzureArcPatchingCost",

  @doc("Data protection cost in Azure.")
  AzureDataProtectionCost: "AzureDataProtectionCost",

  @doc("Management cost.")
  ManagementCost: "ManagementCost",

  @doc("Monitoring service cost.")
  MonitoringServiceCost: "MonitoringServiceCost",

  @doc("Other data protection management cost.")
  OtherDataProtectionManagementCost: "OtherDataProtectionManagementCost",

  @doc("Other monitoring management cost.")
  OtherMonitoringManagementCost: "OtherMonitoringManagementCost",

  @doc("Other patching management cost.")
  OtherPatchingManagementCost: "OtherPatchingManagementCost",

  @doc("Patching service cost.")
  PatchingServiceCost: "PatchingServiceCost",

  @doc("Storage backup cost.")
  StorageBackupCost: "StorageBackupCost",

  @doc("System Center license cost.")
  SystemCenterLicenseCost: "SystemCenterLicenseCost",

  @doc("Third party management cost.")
  ThirdPartyManagementCost: "ThirdPartyManagementCost",

  @doc("VSphere management cost.")
  VSphereManagementCost: "VSphereManagementCost",

  string,
}

@doc("Represents the cost pillar a line item belongs to.")
@added(AssessmentProjectApiVersions.v2025_09_09_preview)
union CostPillar {
  @doc("Unknown or uninitialized pillar.")
  Unknown: "Unknown",

  @doc("Compute pillar.")
  Compute: "Compute",

  @doc("Facilities pillar.")
  Facilities: "Facilities",

  @doc("IT labor pillar.")
  ItLabor: "ItLabor",

  @doc("Licensing pillar.")
  Licensing: "Licensing",

  @doc("Management pillar.")
  Management: "Management",

  @doc("Network pillar.")
  Network: "Network",

  @doc("Security pillar.")
  Security: "Security",

  @doc("Storage pillar.")
  Storage: "Storage",

  string,
}

@doc("Represents a single line item in a cost breakdown.")
@added(AssessmentProjectApiVersions.v2025_09_09_preview)
model CostLineItem {
  @doc("Gets or sets the pillar this cost belongs to.")
  pillar: CostPillar;

  @doc("Gets or sets the name of the cost component.")
  name: CostComponentCategory;

  @doc("Gets or sets the value of the cost component.")
  value: float64;

  @doc("Gets or sets the type of cost (Capex or Opex).")
  costType: CostComponentType;
}

@doc("Represents an individual cost component and its value.")
@added(AssessmentProjectApiVersions.v2025_09_09_preview)
model CostComponent {
  @doc("Name of the cost component.")
  name: string;

  @doc("Cost value associated with the component.")
  value: float64;
}

@doc("Management-related cost details for on-premises workloads.")
@added(AssessmentProjectApiVersions.v2025_09_09_preview)
model ManagementCostDetails {
  @doc("Total management cost.")
  managementCost: float64;

  @doc("Breakdown of individual management cost components.")
  managementCostComponents: CostComponent[];
}

@doc("License-related cost details for on-premises workloads.")
@added(AssessmentProjectApiVersions.v2025_09_09_preview)
model LicenseCostDetails {
  @doc("Total license cost.")
  licenseCost: float64;

  @doc("Breakdown of individual license cost components.")
  licenseCostComponents: CostComponent[];
}

@doc("The on premises cost details.")
@added(AssessmentProjectApiVersions.v2025_09_09_preview)
model CostDetailsV2 {
  @doc("Gets or sets the storage cost.")
  storageCost: CostComponentDetails;

  @doc("Gets or sets the compute cost.")
  computeCost: CostComponentDetails;

  @doc("Gets or sets the IT labor cost.")
  itLaborCost: CostComponentDetails;

  @doc("Gets or sets the network cost.")
  networkCost: CostComponentDetails;

  @doc("Gets or sets the security cost (scalar). Deprecated: Use securityCostDetails instead.")
  securityCost?: float64;

  @doc("Gets or sets the security cost details.")
  securityCostDetails?: CostComponentDetails;

  @doc("Gets or sets the management cost details (legacy format). Deprecated: Use managementCost instead.")
  managementCostDetails?: ManagementCostDetails;

  @doc("Gets or sets the management cost.")
  managementCost?: CostComponentDetails;

  @doc("Gets or sets the facilities cost.")
  facilitiesCost: CostComponentDetails;

  @doc("Gets or sets the license cost details (legacy format). Deprecated: Use licensingCost instead.")
  licenseCostDetails?: LicenseCostDetails;

  @doc("Gets or sets the licensing cost.")
  licensingCost?: CostComponentDetails;
}

@doc("Represents a carbon emission metric and its measured value.")
@added(AssessmentProjectApiVersions.v2025_09_09_preview)
model CarbonEmissionMetric {
  @doc("Name of the emission metric.")
  name: string;

  @doc("Measured value of the emission metric.")
  value: float64;
}

@doc("Carbon emission details grouped by scope.")
@added(AssessmentProjectApiVersions.v2025_09_09_preview)
model CarbonEmissionsDetails {
  @doc("Scope 1 carbon emission metrics.")
  scope1: CarbonEmissionMetric[];

  @doc("Scope 2 carbon emission metrics.")
  scope2: CarbonEmissionMetric[];

  @doc("Scope 3 carbon emission metrics.")
  scope3: CarbonEmissionMetric[];
}

@doc("Year-wise Extended Security Update (ESU) cost details.")
@added(AssessmentProjectApiVersions.v2025_09_09_preview)
model YearlyEsuDetails {
  @doc("Year identifier for the ESU cost.")
  year: string;

  @doc("ESU cost value for the specified year.")
  value: float64;
}
