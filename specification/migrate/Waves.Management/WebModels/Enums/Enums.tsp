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
  @doc("Agent less Migration Path. This path does not require an agent to be installed on the source server.")
  Agentless: "agentless",

  @doc("Agent based Migration Path. This path requires an agent to be installed on the source server.")
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
  @doc("New migration entity status. This indicates that the migration process for the entity has not yet started and is in the initial planning phase.")
  New: "New",

  @doc("In progress migration entity status. This indicates that the migration process for the entity is currently underway and tasks are being executed to move the entity to its target environment.")
  InProgress: "InProgress",

  @doc("At Risk migration entity status. This indicates that the migration process for the entity is facing challenges that could potentially delay or complicate the migration.")
  AtRisk: "AtRisk",

  @doc("Failed migration entity status. This indicates that the migration process for the entity has encountered issues and could not be completed successfully.")
  Failed: "Failed",

  @doc("Cancelled migration entity status.  This indicates that the migration process for the entity has been intentionally stopped before completion.")
  Cancelled: "Cancelled",

  @doc("Completed migration entity status. This indicates that the migration process for the entity has been successfully finished and the entity is now in its target environment.")
  Completed: "Completed",

  @doc("None migration entity status. This indicates that the migration entity has not been assigned a specific status, possibly because it is not yet started or is in a state that does not require a status update.")
  None: "None",

  string,
}

@doc("Migration Entity Planning Status.")
union MigrationEntityPlanningStatus {
  @doc("New migration entity planning status.")
  New: "New",

  @doc("In progress migration entity planning status. This indicates that the migration entity planning is currently underway and tasks are being executed to prepare for the migration.")
  InProgress: "InProgress",

  @doc("At Risk migration entity planning status. This indicates that the migration entity planning is facing challenges that could potentially delay or complicate the planning process.")
  AtRisk: "AtRisk",

  @doc("Failed migration entity planning status. This indicates that the migration entity planning has encountered issues and could not be completed successfully.")
  Failed: "Failed",

  @doc("Cancelled migration entity planning status. This indicates that the migration entity planning has been intentionally stopped before completion.")
  Cancelled: "Cancelled",

  @doc("Completed migration entity planning status.   This indicates that the migration entity has been successfully planned and all necessary preparations have been completed.")
  Completed: "Completed",

  @doc("None migration entity planning status.  This indicates that the migration entity has not been assigned a specific planning status, possibly because it is not yet started or is in a state that does not require a status update.")
  None: "None",

  string,
}

@doc("Migration Entity Migration Stage.")
union MigrationEntityMigrationStage {
  @doc("New migration entity migration stage. This indicates that the migration process for the entity has not yet started and is in the initial planning phase.")
  New: "New",

  @doc("Preparation migration entity migration stage. This indicates that the migration process for the entity is in the preparation phase, where initial tasks are being executed to set up the environment and resources needed for migration.")
  Preparation: "Preparation",

  @doc("Test Migration migration entity migration stage.  This indicates that the migration process for the entity is in the testing phase, where tasks are being executed to validate the migration before it is fully implemented.")
  TestMigration: "TestMigration",

  @doc("Migration migration entity migration stage. This indicates that the migration process for the entity is currently underway and tasks are being executed to move the entity to its target environment.")
  Migration: "Migration",

  string,
}

@doc("Migration Entity Group Migration Status.")
union MigrationEntityGroupMigrationStatus {
  @doc("New migration entity group migration status.  This indicates that the migration process for the group has not yet started and is in the initial planning phase.")
  New: "New",

  @doc("In progress migration entity group migration status. This indicates that the migration process for the group is currently underway and tasks are being executed to move the entities to their target environment.")
  InProgress: "InProgress",

  @doc("At Risk migration entity group migration status. This indicates that the migration process for the group is facing challenges that could potentially delay or complicate the migration.")
  AtRisk: "AtRisk",

  @doc("Failed migration entity group migration status. This indicates that the migration process for the group has encountered issues and could not be completed successfully.")
  Failed: "Failed",

  @doc("Cancelled migration entity group migration status. This indicates that the migration process for the group has been intentionally stopped before completion.")
  Cancelled: "Cancelled",

  @doc("Completed migration entity group migration status. This indicates that the migration process for the group has been successfully finished.")
  Completed: "Completed",

  @doc("None migration entity group migration status. This indicates that the migration group has not been assigned a specific status, possibly because it is not yet started or is in a state that does not require a status update.")
  None: "None",

  string,
}

@doc("Pre Migration, Post Migration, Planning.")
union StepStage {
  @doc("Pre Migration. This stage involves all the preparatory tasks that need to be completed before the actual migration begins.")
  PreMigration: "Pre Migration",

  @doc("Post Migration. This stage involves all the tasks that need to be completed after the actual migration has finished.")
  PostMigration: "Post  Migration",

  @doc("Planning. This stage involves all the tasks that need to be completed during the planning phase of the migration.")
  Planning: "Planning",

  string,
}

@doc("TaskType can be either 'User' or 'System'")
union TaskType {
  @doc("User task - typically initiated by a user")
  User: "User",

  @doc("System task - typically initiated by the system")
  System: "System",

  string,
}

@doc("Category defines the type of task")
union Category {
  @doc("Tooling setup task - involves setting up the necessary tools and configurations for migration.")
  ToolingSetup: "TOOLINGSETUP",

  @doc("Environment preparation task - involves preparing the environment for migration.")
  EnvironmentPrep: "ENVIRONMENTPREP",

  @doc("Security task - involves ensuring the security of the migration process.")
  Security: "SECURITY",

  @doc("Networking task - involves setting up the necessary networking configurations for migration.")
  Networking: "NETWORKING",

  @doc("Workload agent installation task - involves installing the necessary agents for migration.")
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
  ServerMigration: "ServerMigration",
  string,
}
