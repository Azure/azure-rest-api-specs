using Azure.ResourceManager;

@doc("Strategy for migration to Azure")
union Strategy {
  @doc("Rehost: Also known as 'lift and shift', this strategy involves moving existing applications to Azure without modification.")
  Rehost: "Rehost",

  @doc("Refactor: Often referred to as 'lift, tinker, and shift', this involves making minor modifications to the application to take advantage of Azure's cloud capabilities.")
  Refactor: "Refactor",

  @doc("Rearchitect: This approach involves significant changes to the application's architecture to fully utilize cloud-native features and scalability of Azure.")
  Rearchitect: "Rearchitect",

  @doc("Rebuild: Involves completely redesigning and rewriting the application from scratch to be cloud-native, leveraging Azure's advanced services.")
  Rebuild: "Rebuild",

  @doc("Replace: This strategy involves discarding the existing application and replacing it with a new Azure solution or a SaaS platform.")
  Replace: "Replace",

  @doc("Retire: This strategy involves discarding the existing application and replacing it with a new Azure solution or a SaaS platform.")
  Retire: "Retire",

  @doc("Retain: Keeping certain applications in the current environment when they are not suitable for cloud migration or when the timing is not right.")
  Retain: "Retain",

  string,
}

@doc("Server migration path options.")
union ServerMigrationPath {
  @doc("Agentlessa")
  Agentlessa: "agentlessa",

  @doc("Agentbased")
  Agentbased: "agentbased",

  string,
}

@doc("Preset stage of the wave.")
union WaveStage {
  @doc("Planning in progress")
  PlanningInProgress: "PlanningInProgress",

  @doc("Ready for migration")
  ReadyForMigration: "ReadyForMigration",

  @doc("Migration in progress")
  MigrationInProgress: "MigrationInProgress",

  @doc("Migration completed")
  MigrationCompleted: "MigrationCompleted",

  string,
}

@doc("The status of the wave.")
union WaveStatus {
  @doc("New. Indicates the wave is new and has not been started. This is the default value.")
  New: "New",

  @doc("On Track. Indicates the wave is on Track.")
  OnTrack: "OnTrack",

  @doc("At Risk. Indicates the wave is at risk.")
  AtRisk: "AtRisk",

  @doc("On Hold. Indicates the wave is on hold.")
  OnHold: "OnHold",

  @doc("Completed. Indicates the wave is completed.")
  Completed: "Completed",

  @doc("Blocked. Indicates the wave is blocked.")
  Blocked: "Blocked",

  string,
}

@doc("Readiness of the Migration Entity.")
union MigrationEntityReadiness {
  @doc("Ready. Indicates the Migration Entity is ready.")
  Ready: "Ready",

  @doc("Not Ready. Indicates the Migration Entity is not ready.")
  NotReady: "NotReady",

  @doc("Unknown. Indicates the Migration Entity readiness is unknown.")
  Unknown: "Unknown",

  string,
}

@doc("The target of the Migration Entity.")
union MigrationEntityTarget {
  @doc("AzureVM. Indicates the Migration Entity target is Azure VM.")
  AzureVm: "AzureVM",

  @doc("AzureVMSS. Indicates the Migration Entity target is Azure SQL Managed Instance.")
  AzureSqlMi: "AzureSQLMI",

  @doc("AzureSQLMI. Indicates the Migration Entity target is Azure SQL Database.")
  AzureSqlDb: "AzureSQLDB",

  @doc("AzureSQLDB. Indicates the Migration Entity target is Others")
  Others: "Others",

  string,
}

@doc("Migration Entity Migration Status.")
union MigrationEntityMigrationStatus {
  @doc("New")
  New: "New",

  @doc("In progress")
  InProgress: "InProgress",

  @doc("At Risk")
  AtRisk: "AtRisk",

  @doc("Failed")
  Failed: "Failed",

  @doc("Cancelled")
  Cancelled: "Cancelled",

  @doc("Completed")
  Completed: "Completed",

  @doc("None")
  None: "None",

  string,
}

@doc("Migration Entity Planning Status.")
union MigrationEntityPlanningStatus {
  @doc("New")
  New: "New",

  @doc("In progress")
  InProgress: "InProgress",

  @doc("At Risk")
  AtRisk: "AtRisk",

  @doc("Failed")
  Failed: "Failed",

  @doc("Cancelled")
  Cancelled: "Cancelled",

  @doc("Completed")
  Completed: "Completed",

  @doc("None")
  None: "None",

  string,
}

@doc("Migration Entity Migration Stage.")
union MigrationEntityMigrationStage {
  @doc("New.")
  New: "New",

  @doc("Preparation.")
  Preparation: "Preparation",

  @doc("Test Migration.")
  TestMigration: "TestMigration",

  @doc("Migration.")
  Migration: "Migration",

  string,
}

@doc("Migration Entity Group Migration Status.")
union MigrationEntityGroupMigrationStatus {
  @doc("New")
  New: "New",

  @doc("In progress")
  InProgress: "InProgress",

  @doc("At Risk")
  AtRisk: "AtRisk",

  @doc("Failed")
  Failed: "Failed",

  @doc("Cancelled")
  Cancelled: "Cancelled",

  @doc("Completed")
  Completed: "Completed",

  @doc("None")
  None: "None",

  string,
}

@doc("Pre Migration, Post Migration, Planning.")
union StepStage {
  @doc("Pre Migration.")
  PreMigration: "Pre Migration",

  @doc("Post Migration.")
  PostMigration: "Post  Migration",

  @doc("Planning")
  Planning: "Planning",

  string,
}



@doc("TaskType can be either 'User' or 'System'")
union TaskType {
  @doc("User task")
  User: "User",

  @doc("System task")
  System: "System",

  string,
}

@doc("Category defines the type of task")
union Category {
  @doc("Tooling setup task")
  ToolingSetup: "TOOLINGSETUP",

  @doc("Environment preparation task")
  EnvironmentPrep: "ENVIRONMENTPREP",

  @doc("Security task")
  Security: "SECURITY",

  @doc("Networking task")
  Networking: "NETWORKING",

  @doc("Workload agent installation task")
  WorkloadAgentInstall: "WORKLOADAGENTINSTALL",

  string,
}

@doc("Status represents the current state of the task")
union TaskStatus {
  @doc("Task is pending")
  Pending: "PENDING",

  @doc("Task is in progress")
  InProgress: "IN_PROGRESS",

  @doc("Task is completed")
  Completed: "COMPLETED",

  @doc("Task has failed")
  Failed: "FAILED",

  @doc("Task is blocked")
  Blocked: "BLOCKED",

  @doc("Task is skipped")
  Skipped: "SKIPPED",

  string,
}

@doc("Migration Specific Properties Instance Types.")
union MigrationSpecificPropertiesInstanceType {
  ServerMigration: "ServerMigration";
  string;
}


