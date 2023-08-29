import "../Common/AvsEnums.tsp";
import "../Common/CommonEnums.tsp";
import "../Common/AzureResourceProperties.tsp";

using Autorest;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.Migrate;

@doc("AVS assessment Assessed Machine resource.")
@parentResource(AvsAssessment)
model AvsAssessedMachine is ProxyResource<AvsAssessedMachineProperties> {
    @doc("AVS assessment Assessed Machine ARM name")
    @key("avsAssessedMachineName")
    @segment("avsAssessedMachines")
    @path
    name: string;
}

@doc("AVS assessed machine properties web model.")
model AvsAssessedMachineProperties extends AzureResourceProperties {
//   @doc("List of errors for this machine.")
//   @visibility("read")
//   errors?: Error[];

  @doc("List of Disks that were assessed as part of this machine's assessment.")
  @visibility("read")
  disks?: Record<AvsAssessedDisk>;

  @doc("""
List of Network Adapters that were assessed as part of this machine's
assessment.
""")
  @visibility("read")
  networkAdapters?: Record<AvsAssessedNetworkAdapter>;

  #suppress "@azure-tools/cadl-azure-core/casing-style"
  @doc("Gets the storage in use.")
  @visibility("read")
  storageInUseGB?: float32;

  @doc("Gets the explanation if machine is not suitable for cloud.")
  @visibility("read")
  suitabilityExplanation?: AzureAvsVmSuitabilityExplanation;

  @doc("Gets the details if machine is not suitable for cloud.")
  @visibility("read")
  suitabilityDetail?: AzureAvsVmSuitabilityDetail;

  #suppress "@azure-tools/cadl-azure-resource-manager/arm-resource-duplicate-property"
  @doc("Assessed machine type.")
  @visibility("read")
  type?: AssessedMachineType;

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

@doc("AVS assessed disk web model class.")
model AvsAssessedDisk {
  @doc("Gets the ID of the disk.")
  @visibility("read")
  name?: string;

  @doc("Gets the display name of the disk.")
  @visibility("read")
  displayName?: string;

  @doc("Gigabytes Provisioned for a disk in private data center.")
  @visibility("read")
  gigabytesProvisioned?: float32;

  @doc("Disk Read Throughput in MB/s.")
  @visibility("read")
  megabytesPerSecondOfRead?: float32;

  @doc("Disk Write Throughput in MB/s.")
  @visibility("read")
  megabytesPerSecondOfWrite?: float32;

  @doc("Read Operations per second.")
  @visibility("read")
  numberOfReadOperationsPerSecond?: float32;

  @doc("Write Operations per second.")
  @visibility("read")
  numberOfWriteOperationsPerSecond?: float32;
}

@doc("Second level object returned as part of AVS AssessedMachine REST resource.")
model AvsAssessedNetworkAdapter {
  @doc("Mac address of the NIC.")
  @visibility("read")
  macAddress?: string;

  @doc("IP V4 addresses for the machine.")
  @visibility("read")
  ipAddresses?: string[];

  @doc("Gets the display name of the network adapter.")
  @visibility("read")
  displayName?: string;

  @doc("""
Gets the Received data for Network Adapter in MB/s.
            This value is
the percentile of historical data based on options selected in Assessment.
""")
  @visibility("read")
  megabytesPerSecondReceived?: float32;

  @doc("""
Gets the Transmitted data for Network Adapter in MB/s.
            This value
is the percentile of historical data based on options selected in Assessment.
""")
  @visibility("read")
  megabytesPerSecondTransmitted?: float32;
}
