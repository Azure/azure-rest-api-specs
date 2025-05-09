import "../../Common/StandardizedContracts/AssessedWorkloadProperties.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.Migrate;

@doc("Machine assessment V2 Assessed Machine resource.")
@parentResource(MachineAssessmentV2)
model AssessedMachineV2 is ProxyResource<AssessedMachineV2Properties> {
  @doc("Machine assessment V2 Assessed Machine ARM name")
  @key("assessedMachineName")
  @segment("assessedMachines")
  @path
  // "^[^<>&:\\?\/#\x00-\x1F\x7F]{1,260}$"
  @pattern("^[^<>&:\\?/#]{1,260}$")
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "AvsAssessedMachine doesn't have a PUT and hence no need for provisioning state. It is always hydrated by the service."
@doc("Assessed machine properties class.")
model AssessedMachineV2Properties
  is AssessedWorkloadProperties<Linkages, MachineAssessmentRecommendation> {
  @doc("The assessed machine extended details.")
  @visibility(Lifecycle.Read)
  extendedDetails?: AssessedMachineExtendedDetails;

  @doc("When was machine first created.")
  @visibility(Lifecycle.Read)
  createdTimestamp?: utcDateTime;

  @doc("When was machine last updated.")
  @visibility(Lifecycle.Read)
  updatedTimestamp?: utcDateTime;
}

@doc("The assessed machine extended details.")
model AssessedMachineExtendedDetails {
  @doc("Display Name of the Machine.")
  @visibility(Lifecycle.Read)
  displayName?: string;

  @doc("Gets the product support status related details.")
  @visibility(Lifecycle.Read)
  productSupportStatus?: ProductSupportStatus;

  @doc("Dictionary of disks attached to the machine. Key is ID of disk. Value is a disk object.")
  @visibility(Lifecycle.Read)
  @extension("x-ms-identifiers", #[])
  disks?: AssessedDiskDataV3[];

  @doc("Gets or sets the processor details of the host.")
  hostProcessor?: ProcessorInfo;

  @doc("""
    List of Network Adapters that were assessed as part of this machine's
    assessment.
    """)
  @visibility(Lifecycle.Read)
  @extension("x-ms-identifiers", #[])
  networkAdapters?: AssessedMachineNetworkAdaptersV3[];

  @doc("Assessed machine type.")
  @visibility(Lifecycle.Read)
  assessedMachineType?: AssessedMachineType;

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

  @doc("Description for the machine.")
  @visibility(Lifecycle.Read)
  description?: string;

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

  @doc("List of errors for this machine.")
  @visibility(Lifecycle.Read)
  @extension("x-ms-identifiers", #[])
  errors?: Error[];
}

@doc("Assessed network adapter data for normalized contract for sql machines.")
model AssessedMachineNetworkAdaptersV3 is AssessedNetworkAdaptersV3 {
  @doc("Display Name of the Machine.")
  @visibility(Lifecycle.Read)
  displayName?: string;
}

@doc("Machine Assessment Recommendation with additional properties.")
model MachineAssessmentRecommendation
  is Recommendations<
    MigrationIssues,
    MigrationSuitability,
    Skus<MigrationSuitability>
  > {
  @doc("VM Security Suitability Results.")
  @visibility(Lifecycle.Read)
  @extension("x-ms-identifiers", #[])
  vmSecuritySuitabilityResults?: VmSecuritySuitability[];

  @doc("Recommended security type for the VM.")
  @visibility(Lifecycle.Read)
  recommendedVmSecurityType?: AzureVmSecurityType;
}
