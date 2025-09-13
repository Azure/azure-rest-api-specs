using Azure.ResourceManager;

@doc("Strategy for migration to Azure")
union Strategy {
  @doc("No specific strategy defined.")
  None: "None",

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

  @doc("Replatform: This strategy involves making more substantial changes to the application.")
  Replatform: "Replatform",

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
  @doc("Creation. Indicates the wave is being created.")
  Creation: "Creation",

  @doc("Configuration. Indicates the wave is in configuration.")
  Configuration: "Configuration",

  @doc("Ready for Execution. Indicates the wave is ready for execution.")
  ReadyForExecution: "ReadyForExecution",

  @doc("Execution in Progress. Indicates the wave is currently being executed.")
  ExecutionInProgress: "ExecutionInProgress",

  @doc("Completed. Indicates the wave is completed.")
  ExecutionCompleted: "ExecutionCompleted",

  string,
}

@doc("The status of the wave.")
union WaveStatus {
  @doc("Not Started. Indicates the wave is not started.")
  NotStarted: "NotStarted",

  @doc("On Track. Indicates the wave is on track.")
  OnTrack: "OnTrack",

  @doc("Off Track. Indicates the wave is off track.")
  OffTrack: "OffTrack",

  @doc("At Risk. Indicates the wave is at risk.")
  AtRisk: "AtRisk",

  @doc("Completed. Indicates the wave is completed.")
  Completed: "Completed",

  @doc("New. Indicates the wave is newly created.")
  New: "New",

  string,
}

@doc("The target of the Migration Entity.")
union MigrationEntityTarget {
  @doc("None. Indicates the Migration Entity target is not specified.")
  None: "None",

  @doc("AzureVM. Indicates the Migration Entity target is Azure VM.")
  AzureVm: "AzureVM",

  @doc("SqlMI. Indicates the Migration Entity target is Azure SQL Managed Instance.")
  SqlMI: "SqlMI",

  @doc("SqlDatabase. Indicates the Migration Entity target is Azure SQL Database.")
  SqlDatabase: "SqlDatabase",

  @doc("AzureSQLVM. Indicates the Migration Entity target is Azure SQL Virtual Machine.")
  AzureSQLVM: "AzureSQLVM",

  @doc("AKS. Indicates the Migration Entity target is Azure Kubernetes Service.")
  AKS: "AKS",

  @doc("AzureAppService. Indicates the Migration Entity target is Azure App Service.")
  AzureAppService: "AzureAppService",

  @doc("AzureAppServiceContainer. Indicates the Migration Entity target is Azure App Service Container.")
  AzureAppServiceContainer: "AzureAppServiceContainer",

  @doc("AzureLocal. Indicates the Migration Entity target is Azure Local.")
  AzureLocal: "AzureLocal",

  @doc("Others. Indicates the Migration Entity target is Others.")
  Others: "Others",

  string,
}

@doc("Wave execution readiness options.")
union MigrationEntityExecutionReadiness {
  @doc("Not Available. Indicates the MigrationEntity execution readiness is not available.")
  NotAvailable: "NotAvailable",

  @doc("Ready. Indicates that MigrationEntity is ready for execution")
  Ready: "Ready",

  @doc("Not Ready. Indicates that MigrationEntity is not ready for execution")
  NotReady: "NotReady",

  string,
}

@doc("Migration Entity Migration Tool.")
union MigrationEntityMigrationTool {
  @doc("Server Migration Agentless. Indicates that the migration tool is using the server migration agentless approach.")
  ServerMigrationAgentless: "Server Migration Agentless",

  @doc("Server Migration Agent Based. Indicates that the migration tool is using the server migration agent-based approach.")
  ServerMigrationAgentBased: "Server Migration Agent Based",

  @doc("Iac ReDeploy. Indicates that the migration tool is using the Iac ReDeploy approach.")
  IacReDeploy: "IacReDeploy",

  @doc("Other tools. Indicates that the migration tool is using other tools.")
  Others: "Others",

  string,
}

@doc("Migration Entity Execution Status.")
union MigrationEntityExecutionStatus {
  @doc("Not Started migration entity status. This indicates that the migration process for the entity has not yet begun.")
  NotStarted: "NotStarted",

  @doc("In progress migration entity status. This indicates that the migration process for the entity is currently underway and tasks are being executed to move the entity to its target environment.")
  InProgress: "InProgress",

  @doc("Action Pending migration entity status. This indicates that the migration process for the entity is waiting for some action to be taken before it can proceed.")
  ActionPending: "ActionPending",

  @doc("In error migration entity status. This indicates that the migration process for the entity has encountered issues and could not be completed successfully.")
  InError: "InError",

  @doc("Paused migration entity status. This indicates that the migration process for the entity has been temporarily halted and is not currently progressing.")
  Paused: "Paused",

  @doc("Stopped migration entity status. This indicates that the migration process for the entity has been intentionally halted and will not continue unless restarted.")
  Stopped: "Stopped",

  @doc("Completed migration entity status. This indicates that the migration process for the entity has been successfully finished and the entity is now in its target environment.")
  Completed: "Completed",

  string,
}

@doc("Migration Entity Execution Stage.")
union MigrationEntityExecutionStage {
  @doc("Preparation migration entity execution stage. This indicates that the migration process for the entity is in the preparation phase, where initial tasks are being executed to set up the environment and resources needed for migration.")
  Preparation: "Preparation",

  @doc("Testing migration entity execution stage.  This indicates that the migration process for the entity is in the testing phase, where tasks are being executed to validate the migration before it is fully implemented.")
  Testing: "Testing",

  @doc("Completion migration entity execution stage. This indicates that the migration process for the entity has been successfully finished and the entity is now in its target environment.")
  Completion: "Completion",

  string,
}

@doc("Migration Entity Group Migration Status.")
union MigrationEntityGroupExecutionStatus {
  @doc("Not Started migration entity status. This indicates that the migration process for the entity has not yet begun.")
  NotStarted: "NotStarted",

  @doc("In progress migration entity status. This indicates that the migration process for the entity is currently underway and tasks are being executed to move the entity to its target environment.")
  InProgress: "InProgress",

  @doc("Action Pending migration entity status. This indicates that the migration process for the entity is waiting for some action to be taken before it can proceed.")
  ActionPending: "ActionPending",

  @doc("In error migration entity status. This indicates that the migration process for the entity has encountered issues and could not be completed successfully.")
  InError: "InError",

  @doc("Completed migration entity status. This indicates that the migration process for the entity has been successfully finished and the entity is now in its target environment.")
  Completed: "Completed",

  @doc("None migration entity status")
  None: "None",

  string,
}

@doc("TaskScope can be either 'Wave' or 'MigrationEntity' or 'MigrationEntityGroup'")
union TaskScope {
  @doc("Wave task - typically related to a specific wave of migration")
  Wave: "Wave",

  @doc("Migration Entity task - typically related to a specific migration entity")
  MigrationEntity: "MigrationEntity",

  @doc("Migration Entity Group task - typically related to a specific migration entity group")
  MigrationEntityGroup: "MigrationEntityGroup",

  string,
}

@doc("TaskType can be either 'User' or 'System'")
union TaskType {
  @doc("UserDefined task - typically initiated by a user")
  UserDefined: "UserDefined",

  @doc("SystemDefined task - typically initiated by the system")
  SystemDefined: "SystemDefined",

  string,
}

@doc("Status represents the current state of the task")
union TaskStatus {
  @doc("Task is pending")
  Pending: "Pending",

  @doc("Task is in progress")
  InProgress: "InProgress",

  @doc("Task is completed")
  Completed: "Completed",

  @doc("Task has failed")
  Failed: "Failed",

  @doc("Task is skipped")
  Skipped: "Skipped",

  @doc("Task is on hold")
  Paused: "Paused",

  @doc("Task is stopped")
  Stopped: "Stopped",

  string,
}

@doc("Migration Specific Properties Instance Types.")
union MigrationSpecificPropertiesInstanceType {
  ServerMigration: "ServerMigration",
  string,
}

@doc("Migration Path Options.")
union MigrationPath {
  @doc("PaaS Preferred")
  PaaSPreferred: "PaaSPreferred",

  @doc("PaaS Centric")
  PaaSCentric: "PaaSCentric",

  @doc("IaaS Centric")
  IaaSCentric: "IaaSCentric",

  @doc("Recommended Path")
  RecommendedPath: "RecommendedPath",

  @doc("Azure VM")
  AzureVM: "AzureVM",

  @doc("AVS")
  Avs: "Avs",

  @doc("SQL Database")
  SqlDatabase: "SqlDatabase",

  @doc("SQL MI")
  SqlMI: "SqlMI",

  @doc("Azure SQL VM")
  AzureSQLVM: "AzureSQLVM",

  @doc("Azure App Service")
  AzureAppService: "AzureAppService",

  @doc("Azure App Service Container")
  AzureAppServiceContainer: "AzureAppServiceContainer",

  @doc("AKS")
  AKS: "AKS",

  @doc("The Modernize path")
  Modernize: "Modernize",

  string,
}
