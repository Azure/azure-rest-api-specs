import "../../Common/StandardizedContracts/CommonEnums.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.Migrate;

@doc("SQL Assessment REST resource.")
@parentResource(SqlAssessmentV3)
model AssessedSqlMachineV3 is ProxyResource<AssessedSqlMachineV3Properties> {
  @doc("Sql assessment Assessed Machine ARM name.")
  @key("assessedSqlMachineName")
  @segment("assessedSqlMachines")
  @path
  // "^[^<>&:\\?\/#\x00-\x1F\x7F]{1,260}$"
  @pattern("^[^<>&:\\?/#]{1,260}$")
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "AvsAssessedMachine doesn't have a PUT and hence no need for provisioning state. It is always hydrated by the service."
@doc("Assessed SQL machine properties.")
model AssessedSqlMachineV3Properties
  is AssessedWorkloadProperties<Linkages, SqlMachineRecommendations> {
  @doc("The sql instance extended details.")
  @visibility(Lifecycle.Read)
  extendedDetails?: SqlMachineExtendedDetails;

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

@doc("The sql machine extended details.")
model SqlMachineExtendedDetails {
  @doc("Display Name of the Machine.")
  @visibility(Lifecycle.Read)
  displayName?: string;

  @doc("Gets or sets the BIOS GUID for the machine.")
  @visibility(Lifecycle.Read)
  biosGuid?: string;

  @doc("Gets or sets the FQDN for the machine.")
  @visibility(Lifecycle.Read)
  fqdn?: string;

  @doc("Gets the product support status related details.")
  @visibility(Lifecycle.Read)
  productSupportStatus?: ProductSupportStatus;

  @doc("Gets the list of data disks that were assessed as part of this assessment.")
  @visibility(Lifecycle.Read)
  @extension("x-ms-identifiers", #[])
  disks?: AssessedSqlDiskDataV3[];

  @doc("Gets the list of network adapters that were assessed as part of this assessment.")
  @visibility(Lifecycle.Read)
  @extension("x-ms-identifiers", #[])
  networkAdapters?: AssessedSqlNetworkAdaptersV3[];

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
}

@doc("Recommendations for assessed sql entities.")
model SqlMachineRecommendations
  is Recommendations<
    MigrationIssues,
    MigrationSuitability,
    Skus<MigrationSuitability>
  > {
  @doc("Gets the list of migration guidelines applicable to this target.")
  @visibility(Lifecycle.Read)
  @extension("x-ms-identifiers", #[])
  migrationGuidelines?: SqlMigrationGuideline[];
}

@doc("Assessed disk data for normalized contract for sql machines.")
model AssessedSqlDiskDataV3 is AssessedDiskDataV3;

@doc("Assessed network adapter data for normalized contract for sql machines.")
model AssessedSqlNetworkAdaptersV3 is AssessedNetworkAdaptersV3 {
  @doc("Display Name of the Machine.")
  @visibility(Lifecycle.Read)
  displayName?: string;
}
