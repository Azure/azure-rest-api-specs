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
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "This always-existing settings resource has no provisioningState property; asynchronous update status is reported through the polling headers."
@added(Versions.v2026_11_01_preview)
model ServerProtectionSettingsProperties {
  /**
   * Whether to block deletion of the managed instance while any live user database
   * exists or any dropped user database has immutable point-in-time restore backups
   * within retention. Supported request values
   * are enabled and disabled, compared case-insensitively. Setting enabled is an
   * irreversible opt-in. Setting disabled before opt-in is a no-op; changing from
   * enabled to disabled is rejected.
   */
  blockDropWhenImmutablePitrBackupInRetention: BlockDropWhenImmutablePitrBackupInRetention;
}

/**
 * Opt-in state for managed instance deletion protection while immutable backups
 * are retained.
 */
@added(Versions.v2026_11_01_preview)
union BlockDropWhenImmutablePitrBackupInRetention {
  string,

  /**
   * Protection is permanently enabled. Instance deletion is blocked while a live
   * user database exists or a dropped user database has immutable PITR backups in retention.
   */
  Enabled: "enabled",

  /**
   * Deletion protection has not been enabled. Requesting this state before opt-in
   * leaves the settings unchanged.
   */
  Disabled: "disabled",
}

/**
 * Information returned when a managed instance protection settings update is
 * accepted.
 */
@added(Versions.v2026_11_01_preview)
model ServerProtectionSettingsOperation {
  /** The name of the accepted operation. */
  operation: string;

  /** The UTC time when the operation started. */
  startTime: utcDateTime;
}

/**
 * The update was accepted; use the polling headers to track completion and
 * retrieve the result.
 */
@added(Versions.v2026_11_01_preview)
model ServerProtectionSettingsAcceptedResult
  is ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = ServerProtectionSettings> &
    Azure.Core.Foundations.RetryAfterHeader> {
  /** Information about the accepted update, not the final resource state. */
  @bodyRoot
  body: ServerProtectionSettingsOperation;
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

  /** Updates managed instance server protection setting. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "The singleton settings always exist: PUT returns 200 when complete or 202 when accepted, never 201."
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "The service returns operation and startTime in the 202 response; retain this acceptance payload rather than documenting an empty body."
  #suppress "@azure-tools/typespec-azure-core/response-schema-problem" "The service returns the resource on completion (200) and operation metadata on acceptance (202); these are intentionally different successful response bodies."
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ServerProtectionSettings,
    Response =
      | ArmResourceUpdatedResponse<ServerProtectionSettings>
      | ServerProtectionSettingsAcceptedResult
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
