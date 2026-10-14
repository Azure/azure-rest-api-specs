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
   * Initiate a Defender for Storage malware scan for the specified storage account. Blobs and Files will be scanned for malware.
   */
  // Hand-written (not built from DefenderForStorageSettingsOps.ActionSync<>) so the request
  // body can be versioned: only the `body` parameter is @added(v2026), so the operation
  // exists in all versions but the optional StartMalwareScanRequest body only appears in
  // 2026-01-01-preview. This keeps 2025-09-01-preview byte-identical to main while adding
  // the on-demand scan filters in 2026. ActionSync<> can't express a per-version body.
  //
  // The path parameters are declared inline (matching the DefenderForStorageSettingsOps
  // legacy alias) rather than via ResourceInstanceParameters<>, so the URL keeps the
  // existing `resourceId` scope naming instead of switching to `resourceUri`. Route
  // assembly is driven by @armResourceAction + the @segment/@key decorators (no explicit
  // @route), which avoids the path-parameter duplication seen when combining an explicit
  // @route with @armResourceOperations.
  @tag("DefenderForStorage")
  @tag("Antimalware")
  @tag("Scan")
  @armResourceAction(DefenderForStorageSetting)
  @post
  startMalwareScan(
    ...ApiVersionParameter,

    /** The fully qualified Azure Resource manager identifier of the resource. */
    @path(#{ allowReserved: true })
    @key
    resourceId: string,

    /** The provider namespace. */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.Security",

    /** The defender for storage setting name. */
    @path
    @segment("defenderForStorageSettings")
    @key
    @pattern("^[a-z][a-z0-9]*$")
    settingName: SettingName,

    /** Optional request body to filter which blobs and files to scan. */
    @added(Versions.v2026_01_01_preview)
    @bodyRoot
    body?: StartMalwareScanRequest,
  ): ArmResponse<MalwareScan> | CloudError;

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

@@doc(DefenderForStorageSetting.name, "Defender for Storage setting name.");
@@doc(
  DefenderForStorageSetting.properties,
  "Defender for Storage resource properties."
);
@@doc(
  DefenderForStorageSettings.create::parameters.resource,
  "Defender for Storage Settings"
);
