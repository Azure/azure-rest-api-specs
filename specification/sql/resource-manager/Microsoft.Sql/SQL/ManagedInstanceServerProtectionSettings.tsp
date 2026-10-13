import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
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

  /**
   * The location of the parent managed instance. A value supplied in a PUT
   * request is accepted but ignored; responses return the parent instance's
   * location.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "The existing service contract accepts an optional top-level location on this proxy resource and returns the parent instance's location."
  location?: string;
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
   * The state of the latest retained protection settings update for the current
   * managed instance. Updating indicates an operation in progress; Succeeded,
   * Failed, and Canceled are terminal states. If no operation history is retained,
   * GET and LIST return Succeeded with the persisted setting. In that case,
   * Succeeded describes the persisted setting, not the outcome of a past update;
   * historical failure or cancellation states are not preserved after the
   * corresponding operation history is removed.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ServerProtectionSettingsProvisioningState;

  /**
   * Whether to block deletion of the managed instance while any live user database
   * exists or any dropped user database has immutable point-in-time restore backups
   * within retention. Supported request values
   * are enabled and disabled, compared case-insensitively. Setting enabled is an
   * irreversible opt-in. Setting disabled before opt-in is a no-op; changing from
   * enabled to disabled is rejected. While provisioningState is Updating,
   * responses show the accepted requested value, which does not confirm that
   * protection is effective. In terminal states, GET and LIST show the effective
   * persisted setting, including when no operation history is retained. A Failed
   * or Canceled update does not imply that protection is disabled.
   */
  blockDropWhenImmutablePitrBackupInRetention: BlockDropWhenImmutablePitrBackupInRetention;
}

/** The state of the latest retained protection settings update, or Succeeded for the persisted setting when no operation history is retained. */
@added(Versions.v2026_11_01_preview)
union ServerProtectionSettingsProvisioningState {
  ResourceProvisioningState,

  /** The settings update is in progress. */
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
   * while a live user database exists or a dropped user database has immutable PITR
   * backups in retention. While provisioningState is Updating, the requested
   * protection is not yet confirmed effective.
   */
  Enabled: "enabled",

  /**
   * Deletion protection has not been enabled. Requesting this state before opt-in
   * leaves the settings unchanged.
   */
  Disabled: "disabled",
}

/**
 * The protection settings update was accepted or has completed. The resource
 * contains its provisioning state; use the polling headers while the update is
 * in progress and the Location header to retrieve the final resource result.
 */
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
   * Updates managed instance server protection setting. A successful request
   * returns HTTP 200 with the resource. While the update is in progress,
   * provisioningState is Updating; use the polling headers to track completion
   * and retrieve the final resource result from the Location URL.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "The singleton settings always exist with the managed instance, so PUT updates an existing resource and returns 200, never 201."
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
@@Azure.ClientGenerator.Core.clientName(
  ManagedInstanceServerProtectionSettings.createOrUpdate::parameters.resource,
  "parameters"
);
