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
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-base-parameter" "The legacy extension operation templates supply the resourceId scope explicitly. Retain that scope parameter instead of the inherited resourceUri parameter to preserve existing URLs and SDK parameter names."
@extensionResource
model DefenderForStorageSetting
  is Azure.ResourceManager.ExtensionResource<DefenderForStorageSettingProperties> {
  ...ResourceNameParameter<
    Resource = DefenderForStorageSetting,
    KeyName = "settingName",
    SegmentName = "defenderForStorageSettings",
    NamePattern = "^current$"
  >;
}

/**
 * Describes the state of a malware scan operation.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-base-parameter" "The legacy malware scan operation templates supply the resourceId scope and settingName parent explicitly. Retain those parameters instead of the inherited resourceUri parameter to preserve existing URLs and SDK parameter names."
@extensionResource
model MalwareScan
  is Azure.ResourceManager.ExtensionResource<MalwareScanProperties> {
  ...ResourceNameParameter<
    Resource = MalwareScan,
    KeyName = "scanId",
    SegmentName = "malwareScans",
    NamePattern = "^(latest|[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12})$"
  >;
}

/**
 * Operations scoped to the Defender for Storage settings of an Azure resource.
 */
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
    /** The Defender for Storage setting name. Only 'current' is supported. */
    @path
    @segment("defenderForStorageSettings")
    @key
    @pattern("^current$")
    settingName: string;
  }
>;

/**
 * Operations scoped to a malware scan under a Defender for Storage setting.
 */
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

    /** The Defender for Storage setting name. Only 'current' is supported. */
    @path
    @segment("defenderForStorageSettings")
    @key
    @pattern("^current$")
    settingName: string;
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

/**
 * Manages Defender for Storage settings and malware scans.
 */
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation-response" "The legacy ExtensionOperations.ActionSync template registers actions in the list-operation collection, so the CRUD/list response rule also checks this POST action. Cancellation intentionally returns MalwareScan rather than the parent DefenderForStorageSetting."
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
  // Declare the action inline so only its optional body is added in 2026-01-01-preview.
  // Keep the legacy path parameters to preserve resourceId scope naming and route assembly.
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

    /** The Defender for Storage setting name. Only 'current' is supported. */
    @path
    @segment("defenderForStorageSettings")
    @key
    @pattern("^current$")
    settingName: string,

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
  getMalwareScan is DefenderForStorageMalwareScansOps.Read<
    MalwareScan,
    ErrorType = CloudError
  >;
}

@@doc(
  DefenderForStorageSetting.name,
  "The Defender for Storage setting name. Only 'current' is supported."
);
@@doc(
  MalwareScan.name,
  "The identifier of the scan. Use 'latest' to retrieve the most recent scan, or a GUID to identify a specific scan."
);
@@doc(
  DefenderForStorageSetting.properties,
  "Defender for Storage resource properties."
);
@@doc(
  DefenderForStorageSettings.create::parameters.resource,
  "Defender for Storage Settings"
);
