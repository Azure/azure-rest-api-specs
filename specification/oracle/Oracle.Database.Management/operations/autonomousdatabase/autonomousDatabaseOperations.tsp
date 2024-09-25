import "../../../models/autonomousdatabase/autonomousDatabase.tsp";
import "../commons.tsp";

using Azure.ResourceManager;
using Autorest;
namespace Oracle.Database;

@armResourceOperations(AutonomousDatabase)
interface AutonomousDatabases
  extends OracleTrackedResource<
      AutonomousDatabase,
      AutonomousDatabaseBaseProperties
    > {
  //OCI switchover API doc: https://docs.oracle.com/en-us/iaas/api/#/en/database/20160918/AutonomousDatabase/SwitchoverAutonomousDatabase
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "TODO FIX - DO NOT COPY - BAD PATTERN"
  @doc("Perform switchover action on Autonomous Database")
  @Autorest.example(
    "./examples/autonomousDatabase_switchover.json",
    "Perform switchover action on Autonomous Database"
  )
  switchover is ArmResourceActionAsync<
    AutonomousDatabase,
    PeerDbDetails,
    AutonomousDatabase
  >;

  //OCI failover API doc: https://docs.oracle.com/en-us/iaas/api/#/en/database/20160918/AutonomousDatabase/FailOverAutonomousDatabase
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "TODO FIX - DO NOT COPY - BAD PATTERN"
  @doc("Perform failover action on Autonomous Database")
  @Autorest.example(
    "./examples/autonomousDatabase_failover.json",
    "Perform failover action on Autonomous Database"
  )
  failover is ArmResourceActionAsync<
    AutonomousDatabase,
    PeerDbDetails,
    AutonomousDatabase
  >;

  //OCI generate wallet API doc: https://docs.oracle.com/en-us/iaas/api/#/en/database/20160918/AutonomousDatabase/GenerateAutonomousDatabaseWallet
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "TODO FIX - DO NOT COPY - BAD PATTERN"
  @doc("Generate wallet action on Autonomous Database")
  @Autorest.example(
    "./examples/autonomousDatabase_generateWallet.json",
    "Generate wallet action on Autonomous Database"
  )
  generateWallet is ArmResourceActionSync<
    AutonomousDatabase,
    GenerateAutonomousDatabaseWalletDetails,
    AutonomousDatabaseWalletFile
  >;

  //OCI RestoreAutonomousDatabase API doc: https://docs.oracle.com/en-us/iaas/api/#/en/database/20160918/AutonomousDatabase/RestoreAutonomousDatabase
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "TODO FIX - DO NOT COPY - BAD PATTERN"
  @doc("Restores an Autonomous Database based on the provided request parameters.")
  @Autorest.example(
    "./examples/autonomousDatabase_restore.json",
    "Perform restore action on Autonomous Database"
  )
  restore is ArmResourceActionAsync<
    AutonomousDatabase,
    RestoreAutonomousDatabaseDetails,
    AutonomousDatabase
  >;

  //OCI ShrinkAutonomousDatabase API doc: https://docs.oracle.com/en-us/iaas/api/#/en/database/20160918/AutonomousDatabase/ShrinkAutonomousDatabase
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "TODO FIX - DO NOT COPY - BAD PATTERN"
  @doc("This operation shrinks the current allocated storage down to the current actual used data storage.")
  @Autorest.example(
    "./examples/autonomousDatabase_shrink.json",
    "Perform shrink action on Autonomous Database"
  )
  shrink is ArmResourceActionAsync<
    AutonomousDatabase,
    void,
    AutonomousDatabase
  >;
}

#suppress "@azure-tools/typespec-azure-core/no-openapi" "TODO FIX - DO NOT COPY - BAD PATTERN"
@@Autorest.example(AutonomousDatabases.listBySubscription,
  "./examples/autonomousDatabase_listBySubscription.json",
  "List Autonomous Database by subscription"
);
#suppress "@azure-tools/typespec-azure-core/no-openapi" "TODO FIX - DO NOT COPY - BAD PATTERN"
@@Autorest.example(AutonomousDatabases.listByResourceGroup,
  "./examples/autonomousDatabase_listByResourceGroup.json",
  "List Autonomous Database by resource group"
);
#suppress "@azure-tools/typespec-azure-core/no-openapi" "TODO FIX - DO NOT COPY - BAD PATTERN"
@@Autorest.example(AutonomousDatabases.createOrUpdate,
  "./examples/autonomousDatabase_create.json",
  "Create Autonomous Database"
);
#suppress "@azure-tools/typespec-azure-core/no-openapi" "TODO FIX - DO NOT COPY - BAD PATTERN"
@@Autorest.example(AutonomousDatabases.createOrUpdate,
  "./examples/autonomousDatabaseClone_create.json",
  "Create clone Autonomous Database"
);
#suppress "@azure-tools/typespec-azure-core/no-openapi" "TODO FIX - DO NOT COPY - BAD PATTERN"
@@Autorest.example(AutonomousDatabases.get,
  "./examples/autonomousDatabase_get.json",
  "Get Autonomous Database"
);
#suppress "@azure-tools/typespec-azure-core/no-openapi" "TODO FIX - DO NOT COPY - BAD PATTERN"
@@Autorest.example(AutonomousDatabases.update,
  "./examples/autonomousDatabase_patch.json",
  "Patch Autonomous Database"
);
#suppress "@azure-tools/typespec-azure-core/no-openapi" "TODO FIX - DO NOT COPY - BAD PATTERN"
@@Autorest.example(AutonomousDatabases.delete,
  "./examples/autonomousDatabase_delete.json",
  "Delete Autonomous Database"
);
