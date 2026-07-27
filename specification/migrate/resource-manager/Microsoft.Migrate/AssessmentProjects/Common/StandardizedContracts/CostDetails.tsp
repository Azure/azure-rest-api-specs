import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Autorest;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

@doc("The on premises PaaS cost.")
model CostDetails {
  @doc("The storage cost.")
  @visibility(Lifecycle.Read)
  storageCost?: float32;

  @doc("The compute cost.")
  @visibility(Lifecycle.Read)
  computeCost?: float32;

  @doc("The IT labor cost.")
  @visibility(Lifecycle.Read)
  itLaborCost?: float32;

  @doc("The network cost.")
  @visibility(Lifecycle.Read)
  networkCost?: float32;

  @doc("The windows AhubSavings.")
  @visibility(Lifecycle.Read)
  ahubSavings?: float32;

  @doc("The linux AhubSavings.")
  @visibility(Lifecycle.Read)
  linuxAhubSavings?: float32;

  @doc("Security Cost.")
  @visibility(Lifecycle.Read)
  securityCost?: float32;

  @doc("Management Cost Details.")
  @visibility(Lifecycle.Read)
  managementCostDetails?: ManagementCostDetails;

  @doc("esu savings.")
  @visibility(Lifecycle.Read)
  esuSavings?: float32;

  @doc("The facilities cost.")
  @visibility(Lifecycle.Read)
  facilitiesCost?: float32;
}

@doc("Management Cost Details.")
model ManagementCostDetails {
  @doc("Management Cost.")
  @visibility(Lifecycle.Read)
  managementCost?: float32;

  @doc("Management Cost Components.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  managementCostComponents?: ManagementCostComponent[];
}

@doc("Management Cost Component.")
model ManagementCostComponent {
  @doc("Name of Management Cost Component.")
  name: ManagementCostComponentName;

  @doc("Cost of Management Component.")
  value?: float32;
}

@doc("Management Cost Component Names.")
union ManagementCostComponentName {
  @doc("Unknown Management Cost Component.")
  Unknown: "Unknown",

  @doc("System Center License Cost.")
  SystemCenterLicenseCost: "SystemCenterLicenseCost",

  @doc("VMware vSphere Management Cost.")
  VSphereManagementCost: "VSphereManagementCost",

  @doc("Third Party Management Cost.")
  ThirdPartyManagementCost: "ThirdPartyManagementCost",

  @doc("Other Monitoring Cost.")
  OtherMonitoringCost: "OtherMonitoringCost",

  @doc("Other Data Protection Cost.")
  OtherDataProtectionCost: "OtherDataProtectionCost",

  @doc("Other Patching Cost.")
  OtherPatchingCost: "OtherPatchingCost",

  @doc("Azure Monitoring Cost.")
  AzureMonitoringCost: "AzureMonitoringCost",

  @doc("Azure Patching Cost.")
  AzurePatchingCost: "AzurePatchingCost",

  @doc("Azure Data Protection Cost.")
  AzureDataProtectionCost: "AzureDataProtectionCost",

  @doc("Azure Arc Monitoring Cost.")
  AzureArcMonitoringCost: "AzureArcMonitoringCost",

  @doc("Azure Arc Patching Cost.")
  AzureArcPatchingCost: "AzureArcPatchingCost",

  string,
}
