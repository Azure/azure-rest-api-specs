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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "TODO FIX - DO NOT COPY - BAD PATTERN"
  @Autorest.example(
    "./examples/autonomousDatabaseBackup_patch.json",
    "Patch Autonomous Database Backup."
  )
  update is ArmCustomPatchAsync<
    AutonomousDatabaseBackup,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      AutonomousDatabaseBackup,
      AutonomousDatabaseBackupProperties
    >
  >;

  #suppress "@azure-tools/typespec-azure-core/no-openapi" "TODO FIX - DO NOT COPY - BAD PATTERN"
  @Autorest.example(
    "./examples/autonomousDatabaseBackup_listByParent.json",
    "List Autonomous Database Backups by Autonomous Database."
  )
  listByAutonomousDatabase is ArmResourceListByParent<AutonomousDatabaseBackup>;
}

#suppress "@azure-tools/typespec-azure-core/no-openapi" "TODO FIX - DO NOT COPY - BAD PATTERN"
@@Autorest.example(AutonomousDatabaseBackups.createOrUpdate,
  "./examples/autonomousDatabaseBackup_create.json",
  "Create Autonomous Database Backup."
);
#suppress "@azure-tools/typespec-azure-core/no-openapi" "TODO FIX - DO NOT COPY - BAD PATTERN"
@@Autorest.example(AutonomousDatabaseBackups.get,
  "./examples/autonomousDatabaseBackup_get.json",
  "Get Autonomous Database Backup."
);
#suppress "@azure-tools/typespec-azure-core/no-openapi" "TODO FIX - DO NOT COPY - BAD PATTERN"
@@Autorest.example(AutonomousDatabaseBackups.delete,
  "./examples/autonomousDatabaseBackup_delete.json",
  "Delete Autonomous Database Backup."
);
