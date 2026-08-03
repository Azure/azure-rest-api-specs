using Azure.ResourceManager;
using TypeSpec.Versioning;
using Microsoft.Migrate;

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

@doc("Migration Specific Properties Instance Types.")
union MigrationSpecificPropertiesInstanceType {
  ServerMigration: "ServerMigration",
  string,
}

@doc("Runbook scope type.")
@added(ApiVersions.v2026_08_01_preview)
union RunbookScopeType {
  @doc("Wave-scoped runbook.")
  Wave: "Wave",

  string,
}

@doc("Runbook execution action.")
@added(ApiVersions.v2026_08_01_preview)
union RunbookExecutionAction {
  @doc("Start runbook execution.")
  Start: "Start",

  @doc("Pause runbook execution.")
  Pause: "Pause",

  @doc("Resume runbook execution.")
  Resume: "Resume",

  @doc("Cancel runbook execution.")
  Cancel: "Cancel",

  @doc("Retry runbook execution.")
  Retry: "Retry",

  @doc("Complete runbook execution step.")
  Complete: "Complete",

  @doc("Fail runbook execution step.")
  Fail: "Fail",

  @doc("Skip runbook execution step.")
  Skip: "Skip",

  @doc("Approve runbook execution step.")
  Approve: "Approve",

  @doc("Reject runbook execution step.")
  Reject: "Reject",

  string,
}

@doc("Dependency mode between runbook steps.")
@added(ApiVersions.v2026_08_01_preview)
union RunbookStepDependencyMode {
  @doc("Step-level dependency.")
  Step: "Step",

  @doc("Migration entity-level dependency.")
  MigrationEntity: "MigrationEntity",

  string,
}
