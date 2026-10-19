import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "@typespec/versioning";
import "./ManagedInstance.tsp";

using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Microsoft.Sql;

/**
 * The singleton protection settings for a managed instance. The only supported
 * resource name is default. Enabling protection is an irreversible opt-in.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "This SQL project uses legacy-feature-files output splitting; this resource belongs to the server protection settings feature."
@added(Versions.v2026_11_01_preview)
@parentResource(ManagedInstance)
@Azure.ResourceManager.Legacy.feature(
  Features.ManagedInstanceServerProtectionSettings
)
model ServerProtectionSettings is ProxyResource<
  ServerProtectionSettingsProperties,
  PropertiesOptional = false
> {
  ...ResourceNameParameter<
    Resource = ServerProtectionSettings,
    KeyName = "serverProtectionSettingsName",
    SegmentName = "serverProtectionSettings",
    NamePattern = "",
    Type = ServerProtectionSettingsName
  >;
}

/** The singleton name for managed instance protection settings. */
@added(Versions.v2026_11_01_preview)
union ServerProtectionSettingsName {
  string,

  /** The only supported protection settings resource, matched case-insensitively. */
  Default: "default",
}

/** Settings that control protection against deletion of a managed instance. */
@added(Versions.v2026_11_01_preview)
model ServerProtectionSettingsProperties {
  /**
   * Status of the active or latest retained protection-settings update. If no
   * operation history is retained, Succeeded describes the persisted setting
   * rather than a past operation outcome. Failed and Canceled outcomes are not
   * preserved after their operation history is removed.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ServerProtectionSettingsProvisioningState;

  /**
   * Block managed instance deletion while any live or dropped user database has
   * immutable PITR backups within retention. Supported request values are enabled
   * and disabled, compared case-insensitively. Setting enabled is an
   * irreversible opt-in. Setting disabled before opt-in is a no-op; changing from
   * enabled to disabled is rejected. While provisioningState is Updating, the
   * value describes the accepted request and does not confirm that protection is
   * effective. Otherwise, GET and LIST return the persisted setting. Use the
   * update operation's polling endpoints to track completion.
   */
  blockDropWhenImmutablePitrBackupInRetention: BlockDropWhenImmutablePitrBackupInRetention;
}

/** Status of the active or latest retained protection-settings update. */
@added(Versions.v2026_11_01_preview)
union ServerProtectionSettingsProvisioningState {
  ResourceProvisioningState,

  /** The protection-settings update is in progress. */
  Updating: "Updating",
}

/**
 * Opt-in state for managed instance deletion protection while immutable backups
 * are retained.
 */
@added(Versions.v2026_11_01_preview)
union BlockDropWhenImmutablePitrBackupInRetention {
  string,

  /**
   * Permanent protection is requested. Once applied, instance deletion is blocked
   * while any live or dropped user database has immutable PITR backups in retention.
   */
  Enabled: "enabled",

  /**
   * Deletion protection has not been enabled. Requesting this state before opt-in
   * leaves the settings unchanged.
   */
  Disabled: "disabled",
}

/** The settings update was accepted or completed. Follow the polling headers while provisioningState is Updating. */
@added(Versions.v2026_11_01_preview)
model ServerProtectionSettingsUpdateResult
  is ArmResponse<ServerProtectionSettings> {
  ...ArmCombinedLroHeaders<FinalResult = ServerProtectionSettings>;
  ...Azure.Core.Foundations.RetryAfterHeader;
}

/** Read, list, and update the default protection settings of a managed instance. */
#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "These settings always exist with the managed instance and cannot be deleted; enabling protection is irreversible."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "This SQL project requires legacy-feature-files output splitting for operation registration."
@added(Versions.v2026_11_01_preview)
@armResourceOperations
@Azure.ResourceManager.Legacy.feature(
  Features.ManagedInstanceServerProtectionSettings
)
interface ManagedInstanceServerProtectionSettings {
  /** Gets a managed instance's server protection settings. */
  get is ArmResourceRead<ServerProtectionSettings>;

  /**
   * Lists the managed instance's server protection settings. The collection contains the default resource.
   */
  listByManagedInstance is ArmResourceListByParent<ServerProtectionSettings>;

  /**
   * Updates managed instance server protection setting. Returns HTTP 200 with
   * the resource. While provisioningState is Updating, follow the polling
   * headers to track completion and retrieve the final resource result.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "The singleton always exists with its managed instance, so PUT replaces the existing resource and returns 200, never a creation response."
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ServerProtectionSettings,
    Response = ServerProtectionSettingsUpdateResult
  >;
}

@@doc(
  ServerProtectionSettings.name,
  "The protection settings name. Only default is supported."
);
@@doc(
  ServerProtectionSettings.properties,
  "The required managed instance protection settings."
);
@@doc(
  ManagedInstanceServerProtectionSettings.createOrUpdate::parameters.resource,
  "The managed instance protection settings to apply."
);
