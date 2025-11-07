import "../Common/AvsEnums.tsp";
import "../Normalized Contract/StandardizedContracts/AssessedWorkloadProperties.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.Migrate;

@doc("AVS assessment V2 Assessed Machine resource.")
@parentResource(AvsAssessmentV2)
model AvsAssessedMachineV2 is ProxyResource<AvsAssessedMachinePropertiesV2> {
  @doc("AVS assessment Assessed Machine V2 ARM name")
  @key("avsAssessedMachineName")
  @segment("avsAssessedMachines")
  @path
  // "^[^<>&:\\?\/#\x00-\x1F\x7F]{1,260}$"
  @pattern("^[^<>&:\\?/#]{1,260}$")
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "AvsAssessedMachine doesn't have a PUT and hence no need for provisioning state. It is always hydrated by the service."
@doc("AVS assessed machine properties web model.")
model AvsAssessedMachinePropertiesV2
  is AssessedWorkloadProperties<
    Linkages,
    AvsRecommendations<
      MigrationIssues,
      MigrationSuitability,
      Skus<MigrationSuitability>
    >
  > {
  @doc("The assessed machine extended details.")
  @visibility(Lifecycle.Read)
  extendedDetails?: AvsAssessedMachineExtendedDetails;

  @doc("Assessed machine type.")
  @visibility(Lifecycle.Read)
  assessedMachineType?: AssessedMachineType;

  @doc("When was machine first created.")
  @visibility(Lifecycle.Read)
  createdTimestamp?: utcDateTime;

  @doc("When was machine last updated.")
  @visibility(Lifecycle.Read)
  updatedTimestamp?: utcDateTime;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Need to mention GigaBytes and hence used GB, Gb would give Gigabits"
@doc("The avs assessed machine extended details.")
model AvsAssessedMachineExtendedDetails {
  @doc("List of errors for this machine.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  errors?: Error[];

  @doc("List of Disks that were assessed as part of this machine's assessment.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  disks?: AvsAssessedDiskV2[];

  @doc("""
    List of Network Adapters that were assessed as part of this machine's
    assessment.
    """)
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  networkAdapters?: AvsAssessedNetworkAdapter[];

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Need to mention GigaBytes and hence used GB, Gb would give Gigabits"
  @doc("Gets the storage in use.")
  @visibility(Lifecycle.Read)
  storageInUseGB?: float32;

  @doc("Boot type of machine discovered in private data center.")
  @visibility(Lifecycle.Read)
  bootType?: MachineBootType;

  @doc("Operating system as reported by datacenter management solution.")
  @visibility(Lifecycle.Read)
  operatingSystemType?: string;

  @doc("Operating system as reported by datacenter management solution.")
  @visibility(Lifecycle.Read)
  operatingSystemName?: string;

  @doc("Operating system version as reported by datacenter management solution.")
  @visibility(Lifecycle.Read)
  operatingSystemVersion?: string;

  @doc("Operating system architecture as reported by datacenter management solution.")
  @visibility(Lifecycle.Read)
  operatingSystemArchitecture?: GuestOperatingSystemArchitecture;

  @doc("Display Name of the Machine.")
  @visibility(Lifecycle.Read)
  displayName?: string;

  @doc("Description for the machine.")
  @visibility(Lifecycle.Read)
  description?: string;

  @doc("Data center management server name.")
  @visibility(Lifecycle.Read)
  datacenterManagementServerName?: string;

  @doc("Megabytes of memory found allocated for the machine in private data center.")
  @visibility(Lifecycle.Read)
  megabytesOfMemory?: float32;

  @doc("Number of CPU cores found on the machine.")
  @visibility(Lifecycle.Read)
  numberOfCores?: int32;

  @doc("""
    Percentile of Percentage of Cores Utilized noted during time period T.
            
       Here N and T are settings on Assessment.
    """)
  @visibility(Lifecycle.Read)
  percentageCoresUtilization?: float32;

  @doc("""
    Percentile of Percentage of Memory Utilized noted during time period T.
           
        Here N and T are settings on Assessment.
    """)
  @visibility(Lifecycle.Read)
  percentageMemoryUtilization?: float32;

  @doc("Gets the Avs Target Type for Machine.")
  @visibility(Lifecycle.Read)
  avsTargetNode?: AzureAvsNodeType;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Need to mention GigaBytes and hence used GB, Gb would give Gigabits"
@doc("AVS assessed disk web model class.")
model AvsAssessedDiskV2 {
  @doc("Gets the ID of the disk.")
  @visibility(Lifecycle.Read)
  name?: string;

  @doc("Gets the display name of the disk.")
  @visibility(Lifecycle.Read)
  displayName?: string;

  @doc("Gigabytes Provisioned for a disk in private data center.")
  @visibility(Lifecycle.Read)
  gigabytesProvisioned?: float32;

  @doc("Disk Read Throughput in MB/s.")
  @visibility(Lifecycle.Read)
  megabytesPerSecondOfRead?: float32;

  @doc("Disk Write Throughput in MB/s.")
  @visibility(Lifecycle.Read)
  megabytesPerSecondOfWrite?: float32;

  @doc("Read Operations per second.")
  @visibility(Lifecycle.Read)
  numberOfReadOperationsPerSecond?: float32;

  @doc("Write Operations per second.")
  @visibility(Lifecycle.Read)
  numberOfWriteOperationsPerSecond?: float32;

  @doc("Associated storage Type recommended for Disk.")
  @visibility(Lifecycle.Read)
  assessedExternalStorageType?: ExternalStorageType;

  @doc("Estimated Disk Size in GB.")
  @visibility(Lifecycle.Read)
  estimatedDiskSizeInGB?: float32;
}

@doc("Second level object returned as part of AVS AssessedMachine REST resource.")
model AvsAssessedNetworkAdapter {
  @doc("Mac address of the NIC.")
  @visibility(Lifecycle.Read)
  macAddress?: string;

  @doc("IP V4 addresses for the machine.")
  @visibility(Lifecycle.Read)
  ipAddresses?: string[];

  @doc("Gets the display name of the network adapter.")
  @visibility(Lifecycle.Read)
  displayName?: string;

  @doc("Gets the name of the network adapter.")
  @visibility(Lifecycle.Read)
  name?: string;

  @doc("""
    Gets the Recieved data for Network Adapter in MB/s.
                This value is
    the percentile of historical data based on options selected in Assessment.
    """)
  @visibility(Lifecycle.Read)
  megabytesPerSecondRecieved?: float32;

  @doc("""
    Gets the Transmitted data for Network Adapter in MB/s.
                This value
    is the percentile of historical data based on options selected in Assessment.
    """)
  @visibility(Lifecycle.Read)
  megabytesPerSecondTransmitted?: float32;
}

@doc("AVS-specific recommendations details.")
model AvsRecommendations<TMigrationIssues, TMigrationSuitability, TSkus>
  is Recommendations<TMigrationIssues, TMigrationSuitability, TSkus> {
  @doc("Gets or sets the machine assessment ARM ID for VM fallback.")
  fallbackMachineAssessmentArmId?: string;
}
