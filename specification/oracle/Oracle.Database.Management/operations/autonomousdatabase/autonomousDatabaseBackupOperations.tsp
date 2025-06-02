import "../../models/autonomousdatabase/autonomousDatabaseBackup.tsp";
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
  update is ArmResourcePatchAsync<
    AutonomousDatabaseBackup,
    AutonomousDatabaseBackupProperties
  >;

  listByParent is ArmResourceListByParent<AutonomousDatabaseBackup>;
}
