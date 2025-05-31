import "../../models/autonomousdatabase/autonomousDatabase.tsp";
import "../commons.tsp";

using Azure.ResourceManager;
using Autorest;
using TypeSpec.Versioning;
namespace Oracle.Database;

@armResourceOperations(AutonomousDatabase)
interface AutonomousDatabases
  extends OracleTrackedResource<
      AutonomousDatabase,
      AutonomousDatabaseBaseProperties
    > {
  //OCI switchover API doc: https://docs.oracle.com/en-us/iaas/api/#/en/database/20160918/AutonomousDatabase/SwitchoverAutonomousDatabase
  @doc("Perform switchover action on Autonomous Database")
  switchover is ArmResourceActionAsync<
    AutonomousDatabase,
    PeerDbDetails,
    AutonomousDatabase
  >;

  //OCI failover API doc: https://docs.oracle.com/en-us/iaas/api/#/en/database/20160918/AutonomousDatabase/FailOverAutonomousDatabase
  @doc("Perform failover action on Autonomous Database")
  failover is ArmResourceActionAsync<
    AutonomousDatabase,
    PeerDbDetails,
    AutonomousDatabase
  >;

  //OCI generate wallet API doc: https://docs.oracle.com/en-us/iaas/api/#/en/database/20160918/AutonomousDatabase/GenerateAutonomousDatabaseWallet
  @doc("Generate wallet action on Autonomous Database")
  generateWallet is ArmResourceActionSync<
    AutonomousDatabase,
    GenerateAutonomousDatabaseWalletDetails,
    AutonomousDatabaseWalletFile
  >;

  //OCI RestoreAutonomousDatabase API doc: https://docs.oracle.com/en-us/iaas/api/#/en/database/20160918/AutonomousDatabase/RestoreAutonomousDatabase
  @doc("Restores an Autonomous Database based on the provided request parameters.")
  restore is ArmResourceActionAsync<
    AutonomousDatabase,
    RestoreAutonomousDatabaseDetails,
    AutonomousDatabase
  >;

  //OCI ShrinkAutonomousDatabase API doc: https://docs.oracle.com/en-us/iaas/api/#/en/database/20160918/AutonomousDatabase/ShrinkAutonomousDatabase
  @doc("This operation shrinks the current allocated storage down to the current actual used data storage.")
  shrink is ArmResourceActionAsync<
    AutonomousDatabase,
    void,
    AutonomousDatabase
  >;

  //OCI ChangeDisasterRecoveryConfiguration API doc: https://docs.oracle.com/en-us/iaas/api/#/en/database/20160918/AutonomousDatabase/ChangeDisasterRecoveryConfiguration
  @added(Versions.v20241001_preview)
  @doc("Perform ChangeDisasterRecoveryConfiguration action on Autonomous Database")
  changeDisasterRecoveryConfiguration is ArmResourceActionAsync<
    AutonomousDatabase,
    DisasterRecoveryConfigurationDetails,
    AutonomousDatabase
  >;

  //OCI Lifecycle Action - Configuration API doc: https://docs.oracle.com/en-us/iaas/api/#/en/database/20160918/AutonomousDatabase/{Start/Stop/Restart}AutonomousDatabase
  @added(Versions.v20250601_preview)
  @doc("Perform Lifecycle Management Action on Autonomous Database")
  action is ArmResourceActionAsync<
    AutonomousDatabase,
    AutonomousDatabaseLifecycleAction,
    AutonomousDatabase
  >;
}
