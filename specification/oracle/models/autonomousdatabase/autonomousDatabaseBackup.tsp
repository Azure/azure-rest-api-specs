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
  @visibility("read")
  autonomousDatabaseOcid?: Ocid;

  @doc("The size of the database in terabytes at the time the backup was taken.")
  @visibility("read")
  databaseSizeInTbs?: float64;

  @doc("A valid Oracle Database version for Autonomous Database.")
  @visibility("read")
  dbVersion?: string;

  @doc("The user-friendly name for the backup. The name does not have to be unique.")
  @visibility("create", "read")
  displayName?: string;

  @doc("The OCID of the Autonomous Database backup.")
  @visibility("read")
  ocid?: Ocid;

  @doc("Indicates whether the backup is user-initiated or automatic.")
  @visibility("read")
  isAutomatic?: boolean;

  @doc("Indicates whether the backup can be used to restore the associated Autonomous Database.")
  @visibility("read")
  isRestorable?: boolean;

  @doc("Additional information about the current lifecycle state.")
  @visibility("read")
  lifecycleDetails?: string;

  @doc("The current state of the backup.")
  @visibility("read")
  lifecycleState?: AutonomousDatabaseBackupLifecycleState;

  @doc("Retention period, in days, for long-term backups.")
  @minValue(60)
  @maxValue(3650)
  @visibility("read", "create", "update")
  retentionPeriodInDays?: int32;

  @doc("The backup size in terabytes (TB).")
  @visibility("read")
  sizeInTbs?: float64;

  @doc("Timestamp until when the backup will be available.")
  @visibility("read")
  timeAvailableTil?: utcDateTime;

  @doc("The date and time the backup started.")
  @visibility("read")
  timeStarted?: string;

  @doc("The date and time the backup completed.")
  @visibility("read")
  timeEnded?: string;

  @doc("The type of backup.")
  @visibility("read")
  backupType?: AutonomousDatabaseBackupType;

  @doc("Azure resource provisioning state.")
  @visibility("read")
  provisioningState?: AzureResourceProvisioningState;
}

@doc("Details to restore an Oracle Autonomous Database.")
model RestoreAutonomousDatabaseDetails {
  @doc("The time to restore the database to.")
  timestamp: utcDateTime;
}
