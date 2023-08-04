
import "../common/machinePropertiesInternal.tsp";
import "../../../operationsTemp.tsp";
import "@azure-tools/typespec-azure-core";
import "../../../operationsTemp.tsp";
import "@typespec/rest";
import "@typespec/openapi";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.Core.Traits;
using OpenAPI;

enum ReplicaType {
    "Unknown", "DatabaseReplica", "AvailabilityGroupReplica"
}

@doc("replica type")
enum ReplicaState {
    "Unknown", "Primary", "Secondary"
}

@doc("replica type")
enum ReplicaSyncStatus {
    "Unknown", "Synchronized", "Unsynchronized"
}

@doc("replica type")
enum ReplicaCommitMode {
    "Unknown", "Synchronous", "Asynchronous"
}

@doc("replica read mode ")
enum ReplicaReadMode {
    "Unknown", "None", "ReadOnly", "ReadWrite"
}

@doc("file type")
enum FileType {
    "Rows", "Log", "Filestream", "NotSupported", "Fulltext"
}

@doc("sql fci role ")
enum SqlMachineOverviewFciRole {
    "Unknown", "NotApplicable", "ActiveNode", "PossibleOwnerNode"
}

@doc("fci instance state ")
enum FCIInstanceState {
    "Unknown", "Inherited", "Initializing", "Online", "Offline", "Failed", "Pending", "OnlinePending", "OfflinePending"
}

@doc("sql server statsu")
enum SqlServerStatus {
    "Unknown", "ContinuePending", "Paused", "PausePending", "Running", "StartPending", "Stopped", "StopPending"
}

@doc("Class for SQL Server properties.")
model SqlServerProperties {
@doc("Gets the Machine Overview properties of all machines on which the SQL server is deployed.")

@visibility("read")
@extension("x-ms-identifiers", [])
"machineOverviewList"?: SqlMachineOverview[];

@doc("Gets or sets tags on the resource.")
tags?: Record<Object>;

@doc("Gets or sets the number of databases part of availability group on this SQL instance.")
"numberOfAgDatabases"?: int32;

@doc("Gets or sets the FCI properties if the instance is an FCI instance. This would be populated if IsClustered is true.")
"fciProperties"?: FciProperties;

@doc("Gets or sets the SQL server version.")
"version"?: string;

@doc("Gets or sets total number of users databases.")
"numberOfUserDatabases"?: int32;

@doc("Gets or sets total size of all user databases.")
"sumOfUserDatabasesSizeInMb"?: float32;

@doc("Gets or sets size of temp database.")
"tempDbSizeInMb"?: float32;

@doc("Gets or sets maximum server memory in use.")
"maxServerMemoryInUseInMb"?: float32;

@doc("Gets or sets the SQL server number of cores that have visible online status.")
"visibleOnlineCoreCount"?: int32;

@doc("Gets or sets number of logins.")
"numOfLogins"?: int32;

@doc("Gets or sets physical CPU count.")
"physicalCpuCount"?: float32;

@doc("Gets or sets logical CPU count.")
"logicalCpuCount"?: int32;

@doc("Gets or sets the SQL server engine edition.")
"engineEdition"?: string;

@doc("Gets or sets the SQL server edition.")
"edition"?: string;

@doc("Gets or sets a value indicating whether High Availability is enabled or not.")
"isHighAvailabilityEnabled"?: boolean;

@doc("Gets or sets a value indicating whether failover cluster is configured or not.")
"isClustered"?: boolean;

@doc("Gets or sets the Hyper thread ratio.")
"hyperthreadRatio"?: int32;

@doc("Gets or sets the SQL start time.")
"sqlStartTime"?: utcDateTime;

@doc("Gets the list of machine ARM Ids on which the SQL server is deployed.")
@visibility("read")
"machineArmIds"?: string[];

@doc("Gets or sets the run as account ID of the SQL server.")
"runAsAccountId"?: string;

@doc("Gets or sets the hydrated run as account ID of the SQL server.")
"hydratedRunAsAccountId"?: string;

@doc("Gets or sets hostname.")
"hostName"?: string;

@doc("Gets or sets the SQL server instance name.")
"sqlServerName"?: string;

@doc("Gets or sets the Preferred Port Number.")
"portNumber"?: int32;

@doc("Gets the errors.")
@visibility("read")
"errors"?: Errors[];

@doc("Gets or sets a value indicating whether the entity is deleted.")
"isDeleted"?: boolean;

@doc("Gets or sets the marking machine creation.")
"createdTimestamp"?: string;

@doc("Gets or sets the timestamp marking last updated on the machine.")
"updatedTimestamp"?: string;

@doc("Gets or sets the powered on status.")
"status"?: SqlServerStatus;

@doc("The status of the last operation.")
provisioningState?: ProvisioningState;
}

@doc("The class representing the properties for an FCI instance.")
model FciProperties {
@doc("Gets or sets the state of the FCI instance.")
"state"?: FCIInstanceState;
@doc("Gets or sets the FCI Network Name used to connect to this FCI instance.")
"networkName"?: string;
@doc("""
Gets or sets a value indicating whether the FCI is hosted on possible owners
which are in multiple subnets.
""")
"isMultiSubnet"?: boolean;
@doc("Gets or sets the count of Shared Disks for SQL FCI.")
"sharedDiskCount"?: int32;
}

@doc("Gets or sets SQL machine overview data.")
model SqlMachineOverview {

@doc("Gets or sets SQL machine ARM ID.")
"machineArmId"?: string;

@doc("Gets or sets SQL machine display name.")
"displayName"?: string;

@doc("Gets or sets SQL machine FCI role.")
"fciRole"?: SqlMachineOverviewFciRole;
}

// Sql Database
@doc("Class for SQL Server database properties.")
model SqlDatabaseProperties {
@doc("Gets or sets the Replica overview.")
"parentReplicaOverview"?: SqlAvailabilityReplicaOverview;

@doc("Gets or sets a value indicating whether this database is a part of an HA setup.")
"isDatabaseHighlyAvailable"?: boolean;

@doc("Gets the file metadata list.")
@visibility("read")
@extension("x-ms-identifiers", [])
"fileMetadataList"?: FileMetaData[];

@doc("Gets or sets the hostname.")
"hostname"?: string;

@doc("Gets or sets the SQL Server Id in which the database resides.")
"sqlServerName"?: string;

@doc("Gets or sets the status.")
"status"?: string;

@doc("Gets or sets the size in Mb.")
"sizeMb"?: float32;

@doc("Gets or sets the SQL database name.")
"databaseName"?: string;

@doc("Gets or sets the SQL Server ARM Id in which the database resides.")
"sqlServerArmId"?: string;

@doc("Gets or sets the database compatibility level.")
"compatibilityLevel"?: string;

@doc("Gets or sets a value indicating whether the entity is deleted.")
"isDeleted"?: boolean;

@doc("Gets the errors.")
@visibility("read")
"errors"?: Errors[];

@doc("Gets or sets the marking machine creation.")
"createdTimestamp"?: string;

@doc("Gets or sets the timestamp marking last updated on the machine.")
"updatedTimestamp"?: string;

@doc("The status of the last operation.")
provisioningState?: ProvisioningState;
}


@doc("File Metadata web model.")
model FileMetaData {
@doc("Gets or sets the logical name of the file.")
"logicalName"?: string;
@doc("Gets or sets the operating-system full path of the file.")
"physicalFullName"?: string;

@doc("Gets or sets the database file type.")
"fileType"?: FileType;

@doc("Gets or sets the size of the file in MB.")
"sizeInMb"?: float32;

@doc("Gets or sets a value indicating whether memory optimized data option is enabled.")
"isMemoryOptimizedDataOptionEnabled"?: boolean;
}

// SQL discovery site data source model.

@doc("Discovery site data source properties class.")
model SqlDiscoverySiteDataSourceProperties {
@doc("Gets or sets the discovery site Id.")
"discoverySiteId"?: string;

@doc("provisioning state enum")
@visibility("read")
provisioningState?: ProvisioningState;
}