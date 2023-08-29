import "../Common/CommonEnums.tsp";

using Autorest;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.Migrate;

@doc("Machine resource.")
@parentResource(AssessmentProject)
model Machine is ProxyResource<MachineProperties> {
    @doc("Assessible Machine ARM name")
    @key("machineName")
    @segment("machines")
    @path
    @pattern("^[a-zA-Z0-9-]{3,24}$")
    name: string;
}

@doc("Properties of a machine.")
model MachineProperties extends AzureResourceProperties {
    @doc("Gets or sets workload summary.")
    @visibility("read")
    @added(ApiVersions.v2022_02_02_preview)
    workloadSummary?: WorkloadSummary;
    // @doc("List of errors for this machine.")
    // @visibility("read")
    // @added(ApiVersions.v2022_02_02_preview)
    // errors?: Error[];


    @doc("Gets Processor details of the host.")
    @visibility("read")
    @added(ApiVersions.v2020_01_01)
    hostProcessor?: ProcessorInfo;

    @doc("Site id of machine discovered in private data center.")
    @visibility("read")
    discoveryMachineArmId?: string;

    @doc("The data center management server ARM Id for the machine.")
    @visibility("read")
    datacenterManagementServerArmId?: string;

    @doc("The data center management server name for the machine.")
    @visibility("read")
    datacenterManagementServerName?: string;

    @doc("Boot type of machine discovered in private data center.")
    @visibility("read")
    bootType?: MachineBootType;

    @doc("Display Name of the Machine.")
    @visibility("read")
    displayName?: string;

    @doc("Megabytes of memory found allocated for the machine in private data center.")
    @visibility("read")
    megabytesOfMemory?: float32;

    @doc("Number of CPU cores found on the machine.")
    @visibility("read")
    numberOfCores?: int32;

    @doc("Operating system as reported by datacenter management solution.")
    @visibility("read")
    operatingSystemType?: string;

    @doc("Operating system as reported by datacenter management solution.")
    @visibility("read")
    operatingSystemName?: string;

    @doc("Operating system version as reported by datacenter management solution.")
    @visibility("read")
    operatingSystemVersion?: string;

    @doc("Description for the machine.")
    @visibility("read")
    description?: string;

    @doc("When was machine first created.")
    @visibility("read")
    createdTimestamp?: string;

    @doc("Disks attached to the machine discovered in private data center.")
    @visibility("read")
    disks?: Record<Disk>;

    @doc("Gets the References to the groups that this machine is member of.")
    @visibility("read")
    groups?: string[];

    @doc("Network adapters attached to the machine discovered in private data center.")
    @visibility("read")
    networkAdapters?: Record<NetworkAdapter>;

    @doc("SQL instances discovered on the machine.")
    @visibility("read")
    sqlInstances?: string[];

    @doc("Web applications discovered on the machine.")
    @visibility("read")
    webApplications?: string[];

    @doc("When was machine last updated.")
    @visibility("read")
    updatedTimestamp?: string;
}

@doc("A disk discovered on a machine.")
model Disk {
    @doc("Gigabytes of storage provisioned for this disk.")
    @visibility("read")
    gigabytesAllocated?: float32;

    @doc("User friendly name of the disk.")
    @visibility("read")
    displayName?: string;
}

@doc("A network adapter discovered on a machine.")
model NetworkAdapter {
    @doc("MAC Address of the network adapter.")
    @visibility("read")
    macAddress?: string;

    @doc("List of IP Addresses on the network adapter.")
    @visibility("read")
    ipAddresses?: string[];

    @doc("User friendly name of the network adapter.")
    @visibility("read")
    displayName?: string;
}

@doc("Workload summary.")
model WorkloadSummary {
    @doc("Gets or sets oracle databases.")
    oracleInstances?: int32;

    @doc("Gets or sets oracle databases.")
    springApps?: int32;
}

@doc("Represents a information \\ details of a processor.")
model ProcessorInfo {
    @doc("Gets or sets the name \\ model of a processor.")
    name?: string;

    @doc("Gets or sets the number of sockets.")
    numberOfSockets?: int32;

    @doc("Gets or sets the number of cores in a socket.")
    numberOfCoresPerSocket?: int32;
}
