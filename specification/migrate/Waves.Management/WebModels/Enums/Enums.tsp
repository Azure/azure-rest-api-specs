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
