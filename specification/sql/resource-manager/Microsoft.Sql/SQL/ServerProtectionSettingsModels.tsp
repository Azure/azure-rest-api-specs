import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/versioning";

using TypeSpec.Versioning;

namespace Microsoft.Sql;

/** The singleton name for logical server or managed instance protection settings. */
@added(Versions.v2026_11_01_preview)
union ServerProtectionSettingsName {
  string,

  /** The only supported protection settings resource, matched case-insensitively. */
  Default: "default",
}

/** Deletion protection settings for a logical server or managed instance. */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "These singleton APIs use operation polling instead of resource provisioningState; SQL DB requires the same exception as MI."
@added(Versions.v2026_11_01_preview)
model ServerProtectionSettingsProperties {
  /**
   * Block server deletion while any live or dropped user database has immutable
   * point-in-time restore backups within retention.
   */
  blockDropWhenImmutablePitrBackupInRetention: BlockDropWhenImmutablePitrBackupInRetention;
}

/**
 * Opt-in state for protecting a logical server or managed instance from deletion
 * while immutable point-in-time restore backups remain within retention.
 */
@added(Versions.v2026_11_01_preview)
union BlockDropWhenImmutablePitrBackupInRetention {
  string,

  /**
   * Deletion protection is enabled. Once enabled, it cannot be disabled.
   * Deletion of the logical server or managed instance is blocked while
   * immutable point-in-time restore backups remain within retention.
   */
  Enabled: "enabled",

  /**
   * Deletion protection has not been enabled. Requesting disabled before
   * opt-in leaves the setting unchanged.
   */
  Disabled: "disabled",
}

/** Metadata for an accepted protection-settings update. */
@added(Versions.v2026_11_01_preview)
model ServerProtectionSettingsOperationMetadata {
  /** Name of the accepted management operation. */
  operation: string;

  /** Time when the management operation started. */
  startTime: utcDateTime;
}
