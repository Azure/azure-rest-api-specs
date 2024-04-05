import "../models/autonomousDatabase.tsp";
import "./commons.tsp";

using Azure.ResourceManager;
using Autorest;

namespace Oracle.Database;

@armResourceOperations(AutonomousDatabase)
interface AutonomousDatabases extends OracleTrackedResource<AutonomousDatabase, AutonomousDatabaseBaseProperties> {
  //OCI switchover API doc: https://docs.oracle.com/en-us/iaas/api/#/en/database/20160918/AutonomousDatabase/SwitchoverAutonomousDatabase
  @doc("Perform switchover action on Autonomous Database")
  @example("./examples/autonomousDatabase_switchover.json", "Perform switchover action on Autonomous Database")
  switchover is ArmResourceActionAsync<AutonomousDatabase, PeerDbDetails, AutonomousDatabase>;

  //OCI failover API doc: https://docs.oracle.com/en-us/iaas/api/#/en/database/20160918/AutonomousDatabase/FailOverAutonomousDatabase
  @doc("Perform failover action on Autonomous Database")
  @example("./examples/autonomousDatabase_failover.json", "Perform failover action on Autonomous Database")
  failover is ArmResourceActionAsync<AutonomousDatabase, PeerDbDetails, AutonomousDatabase>;
}

@@example(AutonomousDatabases.listBySubscription, "./examples/autonomousDatabase_listBySubscription.json", "List Autonomous Database by subscription");
@@example(AutonomousDatabases.listByResourceGroup, "./examples/autonomousDatabase_listByResourceGroup.json", "List Autonomous Database by resource group");
@@example(AutonomousDatabases.createOrUpdate, "./examples/autonomousDatabase_create.json", "Create Autonomous Database");
@@example(AutonomousDatabases.createOrUpdate, "./examples/autonomousDatabaseClone_create.json", "Create clone Autonomous Database");
@@example(AutonomousDatabases.get, "./examples/autonomousDatabase_get.json", "Get Autonomous Database");
@@example(AutonomousDatabases.update, "./examples/autonomousDatabase_patch.json", "Patch Autonomous Database");
@@example(AutonomousDatabases.delete, "./examples/autonomousDatabase_delete.json", "Delete Autonomous Database");

