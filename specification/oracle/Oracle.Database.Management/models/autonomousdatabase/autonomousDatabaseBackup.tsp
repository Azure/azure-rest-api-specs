import "../common.tsp";
import "./adbCommon.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Oracle.Database;

// https://docs.oracle.com/en-us/iaas/api/#/en/database/20160918/AutonomousDatabaseBackup/

@doc("Autonomous database backup lifecycle state enum")
union AutonomousDatabaseBackupLifecycleState {
  @doc("AutonomousDatabase backup is creating")
  Creating: "Creating",

  @doc("AutonomousDatabase backup is active")
  Active: "Active",

  @doc("AutonomousDatabase backup is deleting")
  Deleting: "Deleting",

  @doc("AutonomousDatabase backup is failed")
  Failed: "Failed",

  @doc("AutonomousDatabase backup is updating")
  Updating: "Updating",

  string,
}

@doc("Autonomous database backup type enum")
union AutonomousDatabaseBackupType {
  @doc("Incremental backup")
  Incremental: "Incremental",

  @doc("Full backup")
  Full: "Full",

  @doc("LongTerm backup")
  LongTerm: "LongTerm",

  string,
}

@doc("AutonomousDatabaseBackup resource definition")
@parentResource(AutonomousDatabase)
model AutonomousDatabaseBackup
  is ProxyResource<AutonomousDatabaseBackupProperties> {
  @doc("AutonomousDatabaseBackup id")
  @key("adbbackupid")
  @path
  @segment("autonomousDatabaseBackups")
  @pattern(".*")
  name: string;
}

@doc("AutonomousDatabaseBackup resource model")
model AutonomousDatabaseBackupProperties {
  @doc("The OCID of the Autonomous Database.")
  @visibility(Lifecycle.Read)
  autonomousDatabaseOcid?: Ocid;

  @doc("The size of the database in terabytes at the time the backup was taken.")
  @visibility(Lifecycle.Read)
  databaseSizeInTbs?: float64;

  @doc("A valid Oracle Database version for Autonomous Database.")
  @visibility(Lifecycle.Read)
  dbVersion?: string;

  @doc("The user-friendly name for the backup. The name does not have to be unique.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  displayName?: string;

  @doc("The OCID of the Autonomous Database backup.")
  @visibility(Lifecycle.Read)
  ocid?: Ocid;

  @doc("Indicates whether the backup is user-initiated or automatic.")
  @visibility(Lifecycle.Read)
  isAutomatic?: boolean;

  @doc("Indicates whether the backup can be used to restore the associated Autonomous Database.")
  @visibility(Lifecycle.Read)
  isRestorable?: boolean;

  @doc("Additional information about the current lifecycle state.")
  @visibility(Lifecycle.Read)
  lifecycleDetails?: string;

  @doc("The current state of the backup.")
  @visibility(Lifecycle.Read)
  lifecycleState?: AutonomousDatabaseBackupLifecycleState;

  @doc("Retention period, in days")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  retentionPeriodInDays?: int32;

  @doc("The backup size in terabytes (TB).")
  @visibility(Lifecycle.Read)
  sizeInTbs?: float64;

  @doc("Timestamp until when the backup will be available.")
  @visibility(Lifecycle.Read)
  timeAvailableTil?: utcDateTime;

  @doc("The date and time the backup started.")
  @visibility(Lifecycle.Read)
  timeStarted?: string;

  @doc("The date and time the backup completed.")
  @visibility(Lifecycle.Read)
  timeEnded?: string;

  @doc("The type of backup.")
  @visibility(Lifecycle.Read)
  backupType?: AutonomousDatabaseBackupType;

  @doc("Azure resource provisioning state.")
  @visibility(Lifecycle.Read)
  provisioningState?: AzureResourceProvisioningState;
}

@doc("Details to restore an Oracle Autonomous Database.")
model RestoreAutonomousDatabaseDetails {
  @doc("The time to restore the database to.")
  timestamp: utcDateTime;
}
