import "../../../models/autonomousdatabase/autonomousDatabaseBackup.tsp";
import "../commons.tsp";

using Azure.ResourceManager;
using Autorest;
using TypeSpec.Versioning;

namespace Oracle.Database;

@armResourceOperations(AutonomousDatabaseBackup)
interface AutonomousDatabaseBackups
  extends OracleChildResource<
      AutonomousDatabaseBackup,
      AutonomousDatabaseBackupProperties
    > {
  @example(
    "./examples/autonomousDatabaseBackup_patch.json",
    "Patch Autonomous Database Backup."
  )
  update is ArmResourcePatchAsync<
    AutonomousDatabaseBackup,
    AutonomousDatabaseBackupProperties
  >;

  @example(
    "./examples/autonomousDatabaseBackup_listByParent.json",
    "List Autonomous Database Backups by Autonomous Database."
  )
  listByParent is ArmResourceListByParent<AutonomousDatabaseBackup>;
}

@@example(AutonomousDatabaseBackups.createOrUpdate,
  "./examples/autonomousDatabaseBackup_create.json",
  "Create Autonomous Database Backup."
);
@@example(AutonomousDatabaseBackups.get,
  "./examples/autonomousDatabaseBackup_get.json",
  "Get Autonomous Database Backup."
);
@@example(AutonomousDatabaseBackups.delete,
  "./examples/autonomousDatabaseBackup_delete.json",
  "Delete Autonomous Database Backup."
);
