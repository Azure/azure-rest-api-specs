import "../Common/SqlEnums.tsp";
import "../Common/CommonModels.tsp";
import "../Common/AzureResourceProperties.tsp";

using Autorest;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.Migrate;


@doc("SQL Assessment REST resource.")
@parentResource(SqlAssessmentV2)
model AssessedSqlMachine is ProxyResource<AssessedSqlMachineProperties>{
    @doc("Sql assessment Assessed Machine ARM name.")
    @key("assessedSqlMachineName")
    @segment("assessedSqlMachines")
    @path
    name: string;
}

@doc("Assessed SQL machine properties.")
model AssessedSqlMachineProperties extends AzureResourceProperties {
  @doc("Gets or sets the BIOS GUID for the machine.")
  @visibility("read")
  biosGuid?: string;

  @doc("Gets or sets the FQDN for the machine.")
  @visibility("read")
  fqdn?: string;

  @doc("Gets the list of SQL instances discovered on the machine.")
  @visibility("read")
  @extension("x-ms-identifiers", [])
  sqlInstances?: AssessedSqlInstanceSummary[];

  @doc("""
Gets or sets the detailed messages that were set on the machine during
evaluation.
""")
  @visibility("read")
  suitabilityDetail?: AzureVmSuitabilityDetail;

  @doc("Gets or sets the explanation if machine is not suitable for cloud.")
  @visibility("read")
  suitabilityExplanation?: AzureVmSuitabilityExplanation;

  @doc("Gets or sets the Recommended Azure Size for the machine.")
  @visibility("read")
  recommendedVmSize?: AzureVmSize;

  @doc("Gets or sets the Recommended Azure VM Family for the machine.")
  @visibility("read")
  recommendedVmFamily?: AzureVmFamily;

  @doc("Gets or sets the Number of cores for recommended size.")
  @visibility("read")
  recommendedVmSizeNumberOfCores?: int32;

  @doc("Gets or sets the Megabytes of memory for recommended size.")
  @visibility("read")
  recommendedVmSizeMegabytesOfMemory?: float32;

  @doc("Gets or sets the monthly compute cost calculated for recommended size.")
  @visibility("read")
  monthlyComputeCost?: float32;

  @doc("Gets the list of data disks that were assessed as part of this assessment.")
  @visibility("read")
  disks?: Record<AssessedDisk>;

  @doc("Gets the list of network adapters that were assessed as part of this assessment.")
  @visibility("read")
  networkAdapters?: Record<AssessedNetworkAdapter>;

  @doc("Gets or sets the monthly networking cost.")
  @visibility("read")
  monthlyBandwidthCost?: float32;

  @doc("Gets or sets the monthly total storage cost.")
  @visibility("read")
  monthlyStorageCost?: float32;

  @doc("Gets the list of migration guidelines applicable.")
  @visibility("read")
  @extension("x-ms-identifiers", [])
  migrationGuidelines?: SqlMigrationGuideline[];

  @doc("Boot type of machine discovered in private data center.")
  @visibility("read")
  bootType?: MachineBootType;

  @doc("Operating system as reported by datacenter management solution.")
  @visibility("read")
  operatingSystemType?: string;

  @doc("Operating system as reported by datacenter management solution.")
  @visibility("read")
  operatingSystemName?: string;

  @doc("Operating system version as reported by datacenter management solution.")
  @visibility("read")
  operatingSystemVersion?: string;

  @doc("Operating system architecture as reported by datacenter management solution.")
  @visibility("read")
  operatingSystemArchitecture?: GuestOperatingSystemArchitecture;

  @doc("When was machine first created.")
  @visibility("read")
  createdTimestamp?: string;

  @doc("When was machine last updated.")
  @visibility("read")
  updatedTimestamp?: string;

  @doc("Display Name of the Machine.")
  @visibility("read")
  displayName?: string;

  #suppress "@azure-tools/cadl-azure-resource-manager/arm-resource-duplicate-property"
  @doc("Assessed machine type.")
  @visibility("read")
  type?: AssessedMachineType;

@doc("Description for the machine.")
  @visibility("read")
  description?: string;

  @doc("Data center machine ARM id.")
  @visibility("read")
  datacenterMachineArmId?: string;

  @doc("Data center management server ARM id.")
  @visibility("read")
  datacenterManagementServerArmId?: string;

  @doc("Data center management server name.")
  @visibility("read")
  datacenterManagementServerName?: string;

  @doc("Megabytes of memory found allocated for the machine in private data center.")
  @visibility("read")
  megabytesOfMemory?: float32;

  @doc("Number of CPU cores found on the machine.")
  @visibility("read")
  numberOfCores?: int32;

  @doc("Confidence Rating in Percentage.")
  @visibility("read")
  confidenceRatingInPercentage?: float32;

  @doc("""
Percentile of Percentage of Cores Utilized noted during time period T.
        
   Here N and T are settings on Assessment.
""")
  @visibility("read")
  percentageCoresUtilization?: float32;

  @doc("""
Percentile of Percentage of Memory Utilized noted during time period T.
       
    Here N and T are settings on Assessment.
""")
  @visibility("read")
  percentageMemoryUtilization?: float32;

  @doc("""
Gets a value indicating whether machine is suitable for the cloud platform
selected.
""")
  @visibility("read")
  suitability?: CloudSuitability;
}