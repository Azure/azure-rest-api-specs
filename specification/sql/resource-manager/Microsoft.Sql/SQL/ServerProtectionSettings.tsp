import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "@typespec/versioning";
import "./Server.tsp";

using Azure.ResourceManager;
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
   * rejected. Repeating the persisted value succeeds without changing it, using
   * the same asynchronous workflow. GET and LIST always return the persisted
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
   * Updates logical server protection settings. Every accepted request, including
   * a repeated value, returns HTTP 202 without a resource body. Follow
   * Azure-AsyncOperation for operation status: HTTP 200 with status InProgress,
   * Succeeded, Failed, or Canceled and error details on failure. The Location
   * endpoint returns HTTP 202 while pending, HTTP 200 with the complete settings
   * resource on success, or an appropriate HTTP error with the standard error
   * body on failure. Resource GET and LIST return HTTP 200 with the persisted
   * flag while the operation is pending. Requests to disable protection after opt-in are
   * rejected. This proxy resource does not expose provisioningState; update status
   * is available only through the operation polling endpoints.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "Exception assumed for this proxy resource: accepted PUT requests return 202 and expose operation status only through polling endpoints."
  @tag("ServerProtectionSettings")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ServerProtectionSettings,
    Response = ArmAcceptedLroResponse<
      "The protection settings update was accepted. Poll the operation for completion.",
      LroHeaders = ArmCombinedLroHeaders<FinalResult = ServerProtectionSettings> &
        Azure.Core.Foundations.RetryAfterHeader
    >
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
