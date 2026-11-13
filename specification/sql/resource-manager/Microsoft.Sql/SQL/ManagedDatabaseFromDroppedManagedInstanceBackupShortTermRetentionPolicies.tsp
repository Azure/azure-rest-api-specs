import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "@typespec/versioning";
import "./ManagedBackupShortTermRetentionPolicy.tsp";
import "./RestorableDroppedManagedDatabasesFromDroppedManagedInstance.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.Sql;

alias ManagedDatabaseFromDroppedManagedInstanceBackupShortTermRetentionPolicyOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...RestorableDroppedManagedInstanceLocationParameters;
    ...RestorableDroppedManagedInstanceIdParameter;
    ...RestorableDroppedManagedDatabaseFromDroppedManagedInstanceIdParameter;
  },
  {
    /** The policy name. Only default is supported. */
    @path
    @segment("backupShortTermRetentionPolicies")
    @key
    policyName: ManagedShortTermRetentionPolicyName;
  },
  ResourceName = "ManagedBackupShortTermRetentionPolicy"
>;

/**
 * Reads short-term retention policies for databases under dropped managed instances.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Feature metadata is required to emit this operation group as a separate Swagger file."
@added(Versions.v2026_11_01_preview)
@armResourceOperations
@Azure.ResourceManager.Legacy.feature(
  Microsoft.SqlFeatureRegistration.RestoreFromDroppedManagedInstanceFeatures.ManagedDatabaseFromDroppedManagedInstanceBackupShortTermRetentionPolicies
)
interface ManagedDatabaseFromDroppedManagedInstanceBackupShortTermRetentionPolicies {
  /** Gets the short-term retention policy for a database under a dropped managed instance. */
  get is ManagedDatabaseFromDroppedManagedInstanceBackupShortTermRetentionPolicyOps.Read<ManagedBackupShortTermRetentionPolicy>;

  /** Lists short-term retention policies for a database under a dropped managed instance. */
  listByRestorableDroppedManagedDatabase is ManagedDatabaseFromDroppedManagedInstanceBackupShortTermRetentionPolicyOps.List<ManagedBackupShortTermRetentionPolicy>;
}
