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
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "The API-review exception for this singleton permits operation polling instead of resource provisioningState."
@added(Versions.v2026_11_01_preview)
model ServerProtectionSettingsProperties {
  /**
   * Block managed instance deletion while any live or dropped user database has
   * immutable PITR backups within retention. Supported request values are enabled
   * and disabled, compared case-insensitively. Setting enabled is an
   * irreversible opt-in. Setting disabled before opt-in is a no-op; changing from
   * enabled to disabled is rejected. GET and LIST return the persisted setting.
   * Use the update operation's polling endpoints to track completion.
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

/** Metadata for an accepted protection-settings update. */
@added(Versions.v2026_11_01_preview)
model ServerProtectionSettingsOperationMetadata {
  /** Name of the accepted management operation. */
  operation: string;

  /** Time when the management operation started. */
  startTime: utcDateTime;
}

/** The update is in progress. Follow the polling headers to retrieve its result. */
@added(Versions.v2026_11_01_preview)
model ServerProtectionSettingsAcceptedResult {
  ...AcceptedResponse;
  ...ArmCombinedLroHeaders<FinalResult = ServerProtectionSettings>;
  ...Azure.Core.Foundations.RetryAfterHeader;

  /** Metadata for the accepted update. */
  @body body: ServerProtectionSettingsOperationMetadata;
}

/** Parent instance identifier for protection-settings operations. */
alias ServerProtectionSettingsRequestParameters = {
  ...ApiVersionParameter;
  ...SubscriptionIdParameter;
  ...ResourceGroupParameter;

  /** The provider namespace for the resource. */
  @path
  @segment("providers")
  provider: "Microsoft.Sql";

  /** The name of the managed instance. */
  @path
  @segment("managedInstances")
  @pattern("^[A-Za-z0-9]+(-*[A-Za-z0-9]+)*$")
  @minLength(1)
  @maxLength(63)
  managedInstanceName: string;
};

/** Path parameters for the protection-settings singleton. */
alias ServerProtectionSettingsInstanceParameters = {
  ...ServerProtectionSettingsRequestParameters;

  /** The protection settings name. Only default is supported. */
  @path
  @segment("serverProtectionSettings")
  serverProtectionSettingsName: ServerProtectionSettingsName;
};

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
  @get
  @autoRoute
  @armResourceRead(ServerProtectionSettings)
  get is Azure.ResourceManager.Foundations.ArmReadOperation<
    ServerProtectionSettingsInstanceParameters,
    ArmResponse<ServerProtectionSettings>,
    ErrorResponse
  >;

  /**
   * Lists the managed instance's server protection settings. The collection contains the default resource.
   */
  @get
  @autoRoute
  @list
  @listsResource(ServerProtectionSettings)
  @segmentOf(ServerProtectionSettings)
  @armResourceList(ServerProtectionSettings)
  listByManagedInstance is Azure.ResourceManager.Foundations.ArmReadOperation<
    ServerProtectionSettingsRequestParameters,
    ArmResponse<ResourceListResult<ServerProtectionSettings>>,
    ErrorResponse
  >;

  /**
   * Updates managed instance server protection setting. Returns HTTP 202 with
   * operation metadata and polling headers while the update is in progress,
   * or HTTP 200 with the resource when the update has completed.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "This existing singleton returns 202 while updating and 200 on completion; PUT never creates a new resource."
  #suppress "@azure-tools/typespec-azure-core/response-schema-problem" "The SQL RP returns operation metadata for pending 202 responses and the resource only for completed 200 responses."
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "The SQL RP pending 202 response contains the operation name and start time."
  @put
  @autoRoute
  @armResourceCreateOrUpdate(ServerProtectionSettings)
  @Azure.Core.useFinalStateVia("location")
  createOrUpdate is Azure.ResourceManager.Foundations.ArmCreateOperation<
    ServerProtectionSettingsInstanceParameters,
    ServerProtectionSettings,
    | ArmResponse<ServerProtectionSettings>
    | ServerProtectionSettingsAcceptedResult,
    ErrorResponse
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
