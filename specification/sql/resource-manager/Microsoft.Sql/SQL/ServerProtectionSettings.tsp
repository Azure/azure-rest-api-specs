import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "@typespec/versioning";
import "./Server.tsp";

using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Microsoft.Sql;

/** The protection settings that always exist for a logical server under the name default. */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "SQL uses legacy feature files to split its OpenAPI output."
@added(Versions.v2026_11_01_preview)
@parentResource(Server)
@Azure.ResourceManager.Legacy.feature(Features.Servers)
model ServerProtectionSettings is ProxyResource<
  ServerProtectionSettingsProperties,
  PropertiesOptional = false
> {
  ...ResourceNameParameter<
    Resource = ServerProtectionSettings,
    KeyName = "serverProtectionSettingsName",
    SegmentName = "serverProtectionSettings",
    NamePattern = "^[dD][eE][fF][aA][uU][lL][tT]$",
    Type = ServerProtectionSettingsName
  >;
}

/** The supported logical server protection settings resource name. */
@added(Versions.v2026_11_01_preview)
union ServerProtectionSettingsName {
  string,

  /** The only supported resource name, matched case-insensitively. */
  Default: "default",
}

/** Settings that protect a logical server from deletion while immutable PITR backups remain in retention. */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Exception assumed for this proxy resource: operation status is available through polling endpoints, not retained in the resource."
@added(Versions.v2026_11_01_preview)
model ServerProtectionSettingsProperties {
  /**
   * Whether to block logical server deletion while immutable point-in-time restore
   * backups remain within retention. Supported request values are enabled and
   * disabled, matched case-insensitively. Protection is disabled by default.
   * Enabling protection is irreversible; requesting disabled after opt-in is
   * rejected. Repeating the persisted value succeeds without changing it.
   * PUT returns the resource if complete or operation metadata if still pending.
   * GET and LIST always return the persisted
   * value, including during an update; use the polling endpoints to determine
   * whether an update succeeded. After opt-in, delete all databases and wait for
   * their immutable backups to leave retention before deleting the logical server.
   */
  blockDropWhenImmutablePitrBackupInRetention: ServerProtectionSettingsBlockDrop;
}

/** The irreversible opt-in state for logical server deletion protection. */
@added(Versions.v2026_11_01_preview)
union ServerProtectionSettingsBlockDrop {
  string,

  /** Protection is enabled and cannot be disabled. */
  Enabled: "enabled",

  /** Protection has not been enabled. */
  Disabled: "disabled",
}

/** Metadata for an accepted logical server protection settings update. */
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

/** Read, list, and update the default logical server protection settings. */
#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "The settings always exist with the logical server; irreversible protection cannot be removed by deleting the settings."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "SQL uses legacy feature files to register operations."
@added(Versions.v2026_11_01_preview)
@armResourceOperations(#{ omitTags: true })
@Azure.ResourceManager.Legacy.feature(Features.Servers)
interface ServerProtectionSettingsOperations {
  /** Gets the logical server's persisted protection settings, independently of pending updates. */
  @tag("ServerProtectionSettings")
  get is ArmResourceRead<ServerProtectionSettings>;

  /** Lists the logical server's persisted protection settings. The collection contains the default resource. */
  @tag("ServerProtectionSettings")
  listByServer is ArmResourceListByParent<ServerProtectionSettings>;

  /**
   * Updates logical server protection settings. Returns HTTP 200 with the resource
   * if the update has completed, or HTTP 202 with operation metadata and polling
   * headers while it is pending. The same response contract applies to repeated
   * values. Follow
   * Azure-AsyncOperation for operation status: HTTP 200 with status InProgress,
   * Succeeded, Failed, or Canceled and error details on failure. The Location
   * endpoint returns HTTP 202 while pending, HTTP 200 with the complete settings
   * resource on success, or an appropriate HTTP error with the standard error
   * body on failure. Resource GET and LIST return HTTP 200 with the persisted
   * flag while the operation is pending. Requests to disable protection after opt-in are
   * rejected. This proxy resource does not expose provisioningState; update status
   * is available only through the operation polling endpoints.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "This existing singleton returns 202 while updating and 200 on completion; PUT never creates a new resource."
  #suppress "@azure-tools/typespec-azure-core/response-schema-problem" "The SQL RP returns operation metadata for pending 202 responses and the resource only for completed 200 responses, following the MI contract."
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "The SQL RP pending 202 response contains the operation name and start time, following the MI contract."
  @tag("ServerProtectionSettings")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ServerProtectionSettings,
    Response =
      | ArmResponse<ServerProtectionSettings>
      | ServerProtectionSettingsAcceptedResult
  >;
}

@@doc(
  ServerProtectionSettings.name,
  "The protection settings name. Only default is supported."
);
@@doc(
  ServerProtectionSettings.properties,
  "The required logical server protection settings."
);
@@doc(
  ServerProtectionSettingsOperations.createOrUpdate::parameters.resource,
  "The logical server protection settings to apply."
);
