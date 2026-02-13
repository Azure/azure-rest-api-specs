import "./CostComponent.tsp";
import "./ProductSupportStatus.tsp";
import "./CommonEnums.tsp";
import "../Enums/Enums.tsp";
import "./CommonAssessmentPropertiesEnums.tsp";
import "../Enums/Enums.tsp";

using Azure.ResourceManager;

namespace Microsoft.Migrate;

#suppress "@azure-tools/typespec-azure-core/casing-style"
@doc("Shared Resources.")
model SharedResourcesDto {
  @doc("Gets the list of shared data disks.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  sharedDataDisks?: AzureManagedDiskSkuDto[];

  @doc("Gets the list of shared log disks.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  sharedLogDisks?: AzureManagedDiskSkuDto[];

  @doc("Gets the list of shared Temporary database disks.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  sharedTempDbDisks?: AzureManagedDiskSkuDto[];

  @doc("Gets number of mounts of shared disks.")
  @visibility(Lifecycle.Read)
  numberOfMounts?: int32;

  @doc("Gets quorum witness.")
  @visibility(Lifecycle.Read)
  quorumWitness?: AzureQuorumWitnessDto;
}

#suppress "@azure-tools/typespec-azure-core/casing-style"
@doc("Class representing an Azure Managed Disk SKU.")
model AzureManagedDiskSkuDto {
  @doc("Gets the Type (\"tier\") of disk - e.g. standard, premium, ultra.")
  @visibility(Lifecycle.Read)
  diskType?: AzureManagedDiskSkuDtoDiskType;

  @doc("Gets the Size of the managed disk - e.g. P30, P40.")
  @visibility(Lifecycle.Read)
  diskSize?: AzureDiskSize;

  @doc("Gets disk redundancy - e.g. LRS, ZRS.")
  @visibility(Lifecycle.Read)
  diskRedundancy?: AzureManagedDiskSkuDtoDiskRedundancy;

  @doc("Gets the managed disk storage cost.")
  @visibility(Lifecycle.Read)
  storageCost?: float32;

  @doc("Gets the recommended in GB of the managed disk.")
  @visibility(Lifecycle.Read)
  recommendedSizeInGib?: float32;

  @doc("Gets the recommended throughput in MBPS of the managed disk.")
  @visibility(Lifecycle.Read)
  recommendedThroughputInMbps?: float32;

  @doc("Gets the recommended IOPS of the managed disk.")
  @visibility(Lifecycle.Read)
  recommendedIops?: float32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style"
@doc("Quorum Witness.")
model AzureQuorumWitnessDto {
  @doc("Gets quorum witness type.")
  @visibility(Lifecycle.Read)
  quorumWitnessType?: AzureQuorumWitnessDtoQuorumWitnessType;
}

@doc("Class representing the impacted objects.")
model ImpactedAssessmentObject {
  @doc("Gets the object name.")
  @visibility(Lifecycle.Read)
  objectName?: string;

  @doc("Gets the object type.")
  @visibility(Lifecycle.Read)
  objectType?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style"
@doc("Azure Virtual Machine SKU.")
model AzureVirtualMachineSkuDto {
  @doc("Gets the Virtual Machine Family, for example : standardMSFamily.")
  @visibility(Lifecycle.Read)
  azureVmFamily?: AzureVmFamily;

  @doc("Gets the Compute Size in vCores.")
  @visibility(Lifecycle.Read)
  cores?: int32;

  @doc("Gets the Virtual Machine SKU name,: E.g. : Standard_F16s.")
  @visibility(Lifecycle.Read)
  azureSkuName?: AzureVmSize;

  @doc("""
    Gets the Available vCores. This can be less than the vCores in the Constrained
    vCPU VM Sizes.
    """)
  @visibility(Lifecycle.Read)
  availableCores?: int32;

  @doc("Gets the Max network interfaces.")
  @visibility(Lifecycle.Read)
  maxNetworkInterfaces?: int32;
}

@doc("Migration Guideline Context.")
model MigrationGuidelineContext {
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "TODO: Check if this is a secret and add @secret or update reason"
  @doc("Gets the reasoning context key.")
  contextKey?: string;

  @doc("Gets the reasoning context value.")
  contextValue?: string;
}

@doc("Entity Uptime.")
model EntityUptime {
  @doc("Gets the days per month.")
  daysPerMonth?: int32;

  @doc("Gets the hours per day.")
  hoursPerDay?: int32;
}

@doc("App service native settings.")
model AppSvcNativeSettings {
  @doc("Gets or sets the isolation required.")
  isolationRequired: boolean;
}

@doc("App service container settings.")
model AppSvcContainerSettings {
  @doc("Gets or sets the isolation required.")
  isolationRequired: boolean;
}

@doc("Discovered entity light summary.")
model DiscoveredEntityLightSummary {
  @doc("Gets or sets the number of servers.")
  numberOfServers: int32;

  @doc("Gets or sets the number of web apps.")
  numberOfWebApps: int32;

  @doc("Gets or sets the number of machines.")
  numberOfMachines: int32;
}

@doc("The generic name value pair.")
model NameValuePair<TName, TValue> {
  @doc("The name.")
  @visibility(Lifecycle.Read)
  name?: TName;

  @doc("The value.")
  @visibility(Lifecycle.Read)
  value?: TValue;
}

@doc("Assessed disk data for normalized contract.")
model AssessedDiskDataV3 {
  @doc("The disk name.")
  @visibility(Lifecycle.Read)
  name?: string;

  @doc("The disk display name.")
  @visibility(Lifecycle.Read)
  displayName?: string;

  @doc("Gets the gigabytes provisioned.")
  gigabytesProvisioned?: float32;

  @doc("Gets the megabytes per second of read.")
  megabytesPerSecondOfRead?: float32;

  @doc("Gets the megabytes per second of write.")
  megabytesPerSecondOfWrite?: float32;

  @doc("Gets the number of read operations per second.")
  numberOfReadOperationsPerSecond?: float32;

  @doc("Gets the number of write operations per second.")
  numberOfWriteOperationsPerSecond?: float32;
}

@doc("Assessed network adapter data for normalized contract.")
model AssessedNetworkAdaptersV3 {
  @doc("The disk name.")
  @visibility(Lifecycle.Read)
  name?: string;

  @doc("Gets the net gigabytes transmitted per month.")
  netGigabytesTransmittedPerMonth?: float32;

  @doc("Gets the mac address.")
  macAddress?: string;

  @doc("Gets the ip addresses.")
  @visibility(Lifecycle.Read)
  ipAddresses?: string[];

  @doc("Gets the megabytes per second received.")
  megabytesPerSecondRecieved?: float32;

  @doc("Gets the megabytes per second transmitted.")
  megabytesPerSecondTransmitted?: float32;
}

@doc("The cost details.")
model CostDetailsCommon {
  @doc("The savings options.")
  @visibility(Lifecycle.Read)
  savingOptions?: SavingsOptions;

  @doc("The sku cost details per azure offer type.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  costDetail?: NameValuePair<CostType, float32>[];
}

@doc("The savings details.")
model SavingsDetailsCommon {
  @doc("The savings options.")
  @visibility(Lifecycle.Read)
  savingOptions?: SavingsOptions;

  @doc("The sku cost details per azure offer type.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  savingsDetail?: NameValuePair<SavingsType, float32>[];
}

@doc("More information details.")
model MoreInformation {
  @doc("The title of the information.")
  @visibility(Lifecycle.Read)
  title: string;

  @doc("The URL of the information.")
  @visibility(Lifecycle.Read)
  url: string;
}

@doc("The assessment options outbound edge group base.")
model AssessmentOptionsOutboundEdgeGroupBase {
  @doc("Gets or sets the Azure Locations.")
  targetLocations: AzureLocation[];

  @doc("Gets or sets the Azure Currency.")
  currencies: AzureCurrency[];

  @doc("Gets or sets the Assessment Savings Options.")
  savingsOptions: SavingsOptions[];

  @doc("Gets or sets the Licensing Program.")
  licensingProgram: LicensingProgram[];
}
