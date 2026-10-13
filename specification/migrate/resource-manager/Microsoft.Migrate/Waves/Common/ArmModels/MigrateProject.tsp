import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.Migrate;

@doc("A Migrate project Resource.")
model MigrateProject is TrackedResource<MigrateProjectProperties> {
  @doc("Migrate Project Name")
  @segment("migrateProjects")
  @key("projectName")
  @path
  @pattern("^[^<>&:\\?/#]{1,260}$")
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Migrate Project is already GA and does not have provisioning state"
@doc("Properties of a migrate project.")
model MigrateProjectProperties {
  @doc("Register tools inside project.")
  @visibility(Lifecycle.Read)
  registeredTools?: Items[];

  @doc("Service endpoint.")
  serviceEndpoint?: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Migrate Project is already GA and has these properties as record"
  @doc("Project summary.")
  @visibility(Lifecycle.Read)
  summary?: Record<ProjectSummary>;

  @doc("Last summary refresh time.")
  @visibility(Lifecycle.Read)
  lastSummaryRefreshedTime?: utcDateTime;

  @doc("Refresh summary state.")
  @visibility(Lifecycle.Read)
  refreshSummaryState?: RefreshSummaryState;

  @doc("Utility storage account id.")
  utilityStorageAccountId?: string;

  @doc("Gets or sets the state of public network access.")
  publicNetworkAccess?: PublicNetworkAccess;

  @doc("Gets the private endpoint connections.")
  @visibility(Lifecycle.Read)
  privateEndpointConnections?: PrivateEndpointConnection[];
}

@doc("Project summary.")
model ProjectSummary {
  @doc("Instance type.")
  @visibility(Lifecycle.Read)
  instanceType?: string;

  @doc("Refresh summary state.")
  refreshSummaryState?: RefreshSummaryState;

  @doc("Last summary refresh time.")
  lastSummaryRefreshedTime?: utcDateTime;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Migrate Project is already GA and has these properties as record"
  @doc("Extended summary.")
  extendedSummary?: Record<string>;
}

@doc("Refresh summary state.")
union RefreshSummaryState {
  string,

  @doc("Started State")
  Started: "Started",

  @doc("InProgress State")
  InProgress: "InProgress",

  @doc("Completed State")
  Completed: "Completed",

  @doc("Failed State")
  Failed: "Failed",
}

@doc("Items Enum")
union Items {
  string,

  @doc("Server Discovery Item")
  ServerDiscovery: "ServerDiscovery",

  @doc("Server Assessment Item")
  ServerAssessment: "ServerAssessment",

  @doc("Server Migration Item")
  ServerMigration: "ServerMigration",

  @doc("Cloudamize Item")
  Cloudamize: "Cloudamize",

  @doc("Turbonomic Item")
  Turbonomic: "Turbonomic",

  @doc("Zerto Item")
  Zerto: "Zerto",

  @doc("CorentTech Item")
  CorentTech: "CorentTech",

  @doc("ServerAssessmentV1")
  ServerAssessmentV1: "ServerAssessmentV1",

  @doc("ServerMigration_Replication")
  ServerMigration_Replication: "ServerMigration_Replication",

  @doc("Carbonite Item")
  Carbonite: "Carbonite",

  @doc("DataMigrationAssistant Item")
  DataMigrationAssistant: "DataMigrationAssistant",

  @doc("DatabaseMigrationService Item")
  DatabaseMigrationService: "DatabaseMigrationService",

  @doc("Device42 Item")
  Device42: "Device42",

  @doc("JetStream Item")
  JetStream: "JetStream",

  @doc("RackWare Item")
  RackWare: "RackWare",

  @doc("UnifyCloud Item")
  UnifyCloud: "UnifyCloud",

  @doc("Flexera Item")
  Flexera: "Flexera",

  @doc("ServerDiscovery_Import Item.")
  ServerDiscovery_Import: "ServerDiscovery_Import",

  @doc("Lakeside Item")
  Lakeside: "Lakeside",

  @doc("AppServiceMigrationAssistant Item")
  AppServiceMigrationAssistant: "AppServiceMigrationAssistant",

  @doc("Movere Item")
  Movere: "Movere",

  @doc("CloudSphere Item")
  CloudSphere: "CloudSphere",

  @doc("Modernization Item")
  Modernization: "Modernization",

  @doc("ServerMigration_DataReplication Item")
  ServerMigration_DataReplication: "ServerMigration_DataReplication",

  @doc("Unknown Item")
  Unknown: "Unknown",
}

@doc("Gets or sets the state of public network access.")
union PublicNetworkAccess {
  string,

  @doc("NotSpecified Network Access")
  NotSpecified: "NotSpecified",

  @doc("Enabled Network Access")
  Enabled: "Enabled",

  @doc("Disabled Network Access")
  Disabled: "Disabled",
}
