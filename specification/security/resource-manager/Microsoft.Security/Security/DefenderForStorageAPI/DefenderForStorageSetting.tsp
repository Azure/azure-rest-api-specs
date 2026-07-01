import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "../Common/main.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;
using Common;

namespace DefenderForStorageAPI;
/**
 * The Defender for Storage resource.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-base-parameter" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@extensionResource
model DefenderForStorageSetting
  is Azure.ResourceManager.ExtensionResource<DefenderForStorageSettingProperties> {
  ...ResourceNameParameter<
    Resource = DefenderForStorageSetting,
    KeyName = "settingName",
    SegmentName = "defenderForStorageSettings",
    NamePattern = "",
    Type = SettingName
  >;
}

alias DefenderForStorageSettingsOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;

    /** The fully qualified Azure Resource manager identifier of the resource. */
    @path(#{ allowReserved: true })
    @key
    resourceId: string;

    /** The provider namespace. */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.Security";
  },
  {},
  {
    /** The defender for storage setting name. */
    @path
    @segment("defenderForStorageSettings")
    @key
    @pattern("^[a-z][a-z0-9]*$")
    settingName: SettingName;
  }
>;

alias DefenderForStorageMalwareScansOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;

    /** The fully qualified Azure Resource manager identifier of the resource. */
    @path(#{ allowReserved: true })
    @key
    resourceId: string;

    /** The provider namespace. */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.Security";

    /** The defender for storage setting name. */
    @path
    @segment("defenderForStorageSettings")
    @key
    @pattern("^[a-z][a-z0-9]*$")
    settingName: SettingName;
  },
  {},
  {
    /** The identifier of the scan. Can be either 'latest' or a GUID. */
    @pattern("^(latest|[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12})$")
    @path
    @segment("malwareScans")
    @key
    scanId: string;
  }
>;

@armResourceOperations(#{ omitTags: true })
interface DefenderForStorageSettings {
  /**
   * Gets the Defender for Storage settings for the specified storage account.
   */
  @tag("DefenderForStorage")
  get is DefenderForStorageSettingsOps.Read<
    DefenderForStorageSetting,
    ErrorType = CloudError
  >;
  /**
   * Creates or updates the Defender for Storage settings on a specified storage account.
   */
  @tag("DefenderForStorage")
  create is DefenderForStorageSettingsOps.CreateOrUpdateSync<
    DefenderForStorageSetting,
    ErrorType = CloudError
  >;

  /**
   * Lists the Defender for Storage settings for the specified storage account.
   */
  @tag("DefenderForStorage")
  list is DefenderForStorageSettingsOps.List<
    DefenderForStorageSetting,
    Response = ArmResponse<DefenderForStorageSettingList>,
    ErrorType = CloudError
  >;

  /**
   * Cancels a Defender for Storage malware scan for the specified storage account.
   */
  @tag("DefenderForStorage")
  @tag("Antimalware")
  @tag("Scan")
  @action("cancelMalwareScan")
  cancelMalwareScan is DefenderForStorageMalwareScansOps.ActionSync<
    DefenderForStorageSetting,
    void,
    ArmResponse<MalwareScan>,
    ErrorType = CloudError
  >;

  /**
   * Gets the Defender for Storage malware scan for the specified storage resource.
   */
  @tag("DefenderForStorage")
  @tag("Antimalware")
  @tag("Scan")
  @get
  getMalwareScan is DefenderForStorageMalwareScansOps.Read<
    MalwareScan,
    ErrorType = CloudError
  >;
}

// startMalwareScan is hand-written (not built from DefenderForStorageSettingsOps.ActionSync<>)
// and lives in this standalone interface (not @armResourceOperations) so that the request
// body can be versioned per API version:
//   - 2025-09-01-preview: no request body (keeps the shipped swagger byte-identical).
//   - 2026-01-01-preview: optional StartMalwareScanRequest body with on-demand scan filters.
//
// Only the `body` parameter carries @added(v2026); the operation itself exists in all
// versions. This is the only shape that satisfies both constraints at once:
//   1. A single SDK method named `startMalwareScan` across versions. Two source operations
//      would collide on TCGC's duplicate-client-name check (source-level, not version-aware;
//      a hard error that cannot be suppressed), and on @typespec/http duplicate-operation.
//   2. 2025-09-01-preview must remain unchanged. ActionSync<> always emits a body parameter
//      and offers no hook to add @added to it, so it can't express a per-version body;
//      augment decorators can't retrofit @added either (the versioning checker runs first).
//
// It cannot live inside the DefenderForStorageSettings @armResourceOperations interface:
// that decorator auto-injects the resource path parameters, which conflicts with the
// explicit @route (doubled URL) — and using ResourceInstanceParameters<> instead renames
// resourceId -> resourceUri in the shipped 2025 swagger. @@clientLocation in
// back-compatible.tsp folds this operation into the same "DefenderForStorage" SDK client.
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "Hand-written operation supplies its own @route; applying @armResourceOperations would re-inject the resource's path parameters and duplicate them in the URL."
interface DefenderForStorageMalwareScan {
  /**
   * Initiate a Defender for Storage malware scan for the specified storage account. Blobs and Files will be scanned for malware.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Stable operationId to match the rest of the DefenderForStorage operations."
  @tag("DefenderForStorage")
  @tag("Antimalware")
  @tag("Scan")
  @route("/{+resourceId}/providers/Microsoft.Security/defenderForStorageSettings/{settingName}/startMalwareScan")
  @post
  @operationId("DefenderForStorage_StartMalwareScan")
  startMalwareScan(
    ...ApiVersionParameter,

    /** The fully qualified Azure Resource manager identifier of the resource. */
    @path
    resourceId: string,

    /** The defender for storage setting name. */
    @path
    @pattern("^[a-z][a-z0-9]*$")
    settingName: SettingName,

    /** Optional request body to filter which blobs and files to scan. */
    @added(Versions.v2026_01_01_preview)
    @bodyRoot
    body?: StartMalwareScanRequest,
  ): ArmResponse<MalwareScan> | CloudError;
}

@@doc(DefenderForStorageSetting.name, "Defender for Storage setting name.");
@@doc(
  DefenderForStorageSetting.properties,
  "Defender for Storage resource properties."
);
@@doc(
  DefenderForStorageSettings.create::parameters.resource,
  "Defender for Storage Settings"
);
