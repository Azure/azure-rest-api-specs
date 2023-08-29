import "../Common/CommonEnums.tsp";
import "../Common/AzureResourceProperties.tsp";
import "../Common/CommonAssessmentPropertiesEnums.tsp";
import "../Common/CostComponent.tsp";
import "../Common/CommonModels.tsp";

using Autorest;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.Migrate;

@doc("Machine assessment Assessed Machine resource.")
@parentResource(Assessment)
model AssessedMachine is ProxyResource<AssessedMachineProperties> {
    @doc("Machine assessment Assessed Machine ARM name")
    @key("assessedMachineName")
    @segment("assessedMachines")
    @path
    name: string;
}

@doc("Assessed machine properties class.")
model AssessedMachineProperties extends AzureResourceProperties {
    // @doc("List of errors for this machine.")
    // @visibility("read")
    // @added(ApiVersions.v2022_02_02_preview)
    // errors?: Error[];

    @doc("Dictionary of disks attached to the machine. Key is ID of disk. Value is a disk object.")
    @visibility("read")
    disks?: Record<AssessedDisk>;

    @doc("Monthly ultra storage cost.")
    @visibility("read")
    @added(ApiVersions.v2020_05_01_preview)
    monthlyUltraStorageCost?: float32;

    @doc("Gets or sets the processor details of the host.")
    @added(ApiVersions.v2020_01_01)
    hostProcessor?: ProcessorInfo;

    @doc("Gets or sets the collection of cost components.")
    @added(ApiVersions.v2020_01_01)
    @extension("x-ms-identifiers", [])
    costComponents?: CostComponent[];

    @doc("Monthly networking cost.")
    @visibility("read")
    monthlyBandwidthCost?: float32;

    @doc("Monthly storage cost.")
    @visibility("read")
    monthlyStorageCost?: float32;

    @doc("Monthly premium storage cost.")
    @visibility("read")
    monthlyPremiumStorageCost?: float32;

    #suppress "@azure-tools/cadl-azure-core/casing-style"
    @doc("Monthly standard SSD storage cost.")
    @visibility("read")
    monthlyStandardSSDStorageCost?: float32;

    @doc("""
List of Network Adapters that were assessed as part of this machine's
assessment.
""")
    @visibility("read")
    networkAdapters?: Record<AssessedNetworkAdapter>;

    @doc("Recommended Azure Size for the machine.")
    @visibility("read")
    recommendedSize?: AzureVmSize;

    @doc("Number of cores for recommended size. Read Only.")
    @visibility("read")
    numberOfCoresForRecommendedSize?: int32;

    @doc("Megabytes of memory for recommended size. Read Only.")
    @visibility("read")
    megabytesOfMemoryForRecommendedSize?: float32;

    @doc("Monthly Compute cost calculated for Recommended size, for a 31-day month.")
    @visibility("read")
    monthlyComputeCostForRecommendedSize?: float32;

    @doc("Gets the explanation if machine is not suitable for cloud.")
    @visibility("read")
    suitabilityExplanation?: AzureVmSuitabilityExplanation;

    @doc("Gets the details if machine is not suitable for cloud.")
    @visibility("read")
    suitabilityDetail?: AzureVmSuitabilityDetail;

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
