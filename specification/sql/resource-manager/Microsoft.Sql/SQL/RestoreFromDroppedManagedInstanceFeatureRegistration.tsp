import "@azure-tools/typespec-azure-resource-manager";
import "./ServerProtectionSettingsFeatureRegistration.tsp";

namespace Microsoft.SqlFeatureRegistration;

/** Generator-only feature registration, outside the public SQL service namespace. */
#suppress "@azure-tools/typespec-azure-core/no-enum" "The legacy feature registry requires enum members; this enum is not an API schema."
enum RestoreFromDroppedManagedInstanceFeatures {
  ...Microsoft.SqlFeatureRegistration.Features,

  /** Short-term retention policies for databases under dropped managed instances. */
  ManagedDatabaseFromDroppedManagedInstanceBackupShortTermRetentionPolicies,

  /** Restorable databases under dropped managed instances. */
  RestorableDroppedManagedDatabasesFromDroppedManagedInstance,

  /** Restorable dropped managed instances discovered by location. */
  RestorableDroppedManagedInstancesByLocation,
}
