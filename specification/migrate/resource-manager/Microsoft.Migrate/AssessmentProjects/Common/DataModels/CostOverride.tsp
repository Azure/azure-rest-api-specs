import "@typespec/versioning";

using TypeSpec.Versioning;

namespace Microsoft.Migrate;

@doc("The category of on-premises cost that can be overridden.")
@added(AssessmentProjectApiVersions.v2025_09_09_preview)
union OnPremisesCostCategory {
  string,

  @doc("Hardware acquisition cost.")
  HardwareAcquisition: "HardwareAcquisition",

  @doc("Hardware maintenance cost.")
  HardwareMaintenance: "HardwareMaintenance",

  @doc("Database licensing cost.")
  DatabaseLicensing: "DatabaseLicensing",

  @doc("Virtualization license cost.")
  VirtualizationLicenseCost: "VirtualizationLicenseCost",

  @doc("Linux license cost.")
  LinuxLicenseCost: "LinuxLicenseCost",

  @doc("Windows license cost.")
  WindowsLicenseCost: "WindowsLicenseCost",

  @doc("Storage acquisition cost.")
  StorageAcquisition: "StorageAcquisition",

  @doc("Storage maintenance cost.")
  StorageMaintenance: "StorageMaintenance",

  @doc("Network acquisition cost.")
  NetworkAcquisition: "NetworkAcquisition",

  @doc("Network maintenance cost.")
  NetworkMaintenance: "NetworkMaintenance",

  @doc("Labour cost.")
  LaborCost: "LaborCost",

  @doc("Security cost.")
  SecurityCost: "SecurityCost",

  @doc("Management costs.")
  ManagementCosts: "ManagementCosts",

  @doc("Facilities costs.")
  FacilitiesCosts: "FacilitiesCosts",
}

@doc("A cost override entry that allows the customer to specify a custom value for a specific on-premises cost category.")
@added(AssessmentProjectApiVersions.v2025_09_09_preview)
model CostOverride {
  @doc("The on-premises cost category to override.")
  name: OnPremisesCostCategory;

  @doc("The override value for the cost category.")
  value: float64;
}
