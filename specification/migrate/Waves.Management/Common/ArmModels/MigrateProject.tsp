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

#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Migrate Project is already GA and has these properties as record"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Migrate Project is already GA and does not have provisioning state"
@doc("Properties of a migrate project.")
model MigrateProjectProperties {
  @doc("Register tools inside project.")
  @visibility(Lifecycle.Read)
  registeredTools?: Items[];

  @doc("Service endpoint.")
  serviceEndpoint?: string;

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

#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Migrate Project is already GA and has these properties as record"
@doc("Project summary.")
model ProjectSummary {
  @doc("Instance type.")
  @visibility(Lifecycle.Read)
  instanceType?: string;

  @doc("Refresh summary state.")
  refreshSummaryState?: RefreshSummaryState;

  @doc("Last summary refresh time.")
  lastSummaryRefreshedTime?: utcDateTime;

  @doc("Extended summary.")
  extendedSummary?: Record<string>;
}

@doc("Refresh summary state.")
union RefreshSummaryState {
  string,

  @doc("Started")
  Started: "Started",

  @doc("InProgress")
  InProgress: "InProgress",

  @doc("Completed")
  Completed: "Completed",

  @doc("Failed")
  Failed: "Failed",
}

@doc("Items Enum")
union Items {
  string,

  @doc("ServerDiscovery")
  ServerDiscovery: "ServerDiscovery",

  @doc("ServerAssessment")
  ServerAssessment: "ServerAssessment",

  @doc("ServerMigration")
  ServerMigration: "ServerMigration",

  @doc("Cloudamize")
  Cloudamize: "Cloudamize",

  @doc("Turbonomic")
  Turbonomic: "Turbonomic",

  @doc("Zerto")
  Zerto: "Zerto",

  @doc("CorentTech")
  CorentTech: "CorentTech",

  @doc("ServerAssessmentV1")
  ServerAssessmentV1: "ServerAssessmentV1",

  @doc("ServerMigration_Replication")
  ServerMigration_Replication: "ServerMigration_Replication",

  @doc("Carbonite")
  Carbonite: "Carbonite",

  @doc("DataMigrationAssistant")
  DataMigrationAssistant: "DataMigrationAssistant",

  @doc("DatabaseMigrationService")
  DatabaseMigrationService: "DatabaseMigrationService",

  @doc("Device42")
  Device42: "Device42",

  @doc("JetStream")
  JetStream: "JetStream",

  @doc("RackWare")
  RackWare: "RackWare",

  @doc("UnifyCloud")
  UnifyCloud: "UnifyCloud",

  @doc("Flexera")
  Flexera: "Flexera",

  @doc("ServerDiscovery_Import")
  ServerDiscovery_Import: "ServerDiscovery_Import",

  @doc("Lakeside")
  Lakeside: "Lakeside",

  @doc("AppServiceMigrationAssistant")
  AppServiceMigrationAssistant: "AppServiceMigrationAssistant",

  @doc("Movere")
  Movere: "Movere",

  @doc("CloudSphere")
  CloudSphere: "CloudSphere",

  @doc("Modernization")
  Modernization: "Modernization",

  @doc("ServerMigration_DataReplication")
  ServerMigration_DataReplication: "ServerMigration_DataReplication",

  @doc("Unknown")
  Unknown: "Unknown",
}

@doc("Gets or sets the state of public network access.")
union PublicNetworkAccess {
  string,

  @doc("NotSpecified")
  NotSpecified: "NotSpecified",

  @doc("Enabled")
  Enabled: "Enabled",

  @doc("Disabled")
  Disabled: "Disabled",
}
