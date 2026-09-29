import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "../Common/main.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Common;

namespace DefenderForStorageAPI;
/**
 * The Defender for Storage resource.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-base-parameter" "DefenderForStorageSetting is an extension resource scoped to an arbitrary storage resource via the custom `resourceId` path parameter on the operation templates. The linter mistakes the extension scope plus the explicit `settingName` parameter for multiple base-parameter decorators, but only one scope is defined."
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

/**
 * Describes the state of a malware scan operation.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-base-parameter" "MalwareScan is an extension resource nested under defenderForStorageSettings whose scope is supplied via the custom `resourceId` path parameter on the operation templates. The linter mistakes the extension scope plus the explicit name parameter for multiple base-parameter decorators, but only one scope is defined."
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
  get is DefenderForStorageSettingsOps.Read<DefenderForStorageSetting>;
  /**
   * Creates or updates the Defender for Storage settings on a specified storage account.
   * This is an asynchronous operation. The response includes the `Azure-AsyncOperation`
   * header pointing to the operation status endpoint, which can be polled until the
   * operation completes.
   */
  @tag("DefenderForStorage")
  create is DefenderForStorageSettingsOps.CreateOrUpdateAsync<DefenderForStorageSetting>;

  /**
   * Lists the Defender for Storage settings for the specified storage account.
   */
  @tag("DefenderForStorage")
  list is DefenderForStorageSettingsOps.List<
    DefenderForStorageSetting,
    Response = ArmResponse<DefenderForStorageSettingList>
  >;

  /**
   * Cancels a Defender for Storage malware scan for the specified storage account.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation-response" "This action returns the MalwareScan resource it cancels, not the parent DefenderForStorageSetting; this differs from the resource's CRUD operations by design."
  @tag("DefenderForStorage")
  @tag("Antimalware")
  @tag("Scan")
  @action("cancelMalwareScan")
  cancelMalwareScan is DefenderForStorageMalwareScansOps.ActionSync<
    DefenderForStorageSetting,
    void,
    ArmResponse<MalwareScan>
  >;

  /**
   * Initiate a Defender for Storage malware scan for the specified storage account. Blobs and Files will be scanned for malware.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation-response" "This action returns a MalwareScan resource (the scan it initiated), not the parent DefenderForStorageSetting; this differs from the resource's CRUD operations by design."
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

    /**
     * Optional request body to filter which blobs and files to scan.
     * Supported since API version 2026-01-01-preview.
     */
    @bodyRoot
    body?: StartMalwareScanRequest,
  ): ArmResponse<MalwareScan> | ErrorResponse;

  /**
   * Gets the Defender for Storage malware scan for the specified storage resource.
   */
  @tag("DefenderForStorage")
  @tag("Antimalware")
  @tag("Scan")
  getMalwareScan is DefenderForStorageMalwareScansOps.Read<MalwareScan>;

  /**
   * Lists the Defender for Storage malware scans for the specified storage resource.
   */
  @tag("DefenderForStorage")
  @tag("Antimalware")
  @tag("Scan")
  listMalwareScans is DefenderForStorageMalwareScansOps.List<
    MalwareScan,
    Response = ArmResponse<MalwareScanList>
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

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "This is the polling endpoint for asynchronous Defender for Storage operations and is not itself an Azure resource interface."
interface DefenderForStorageOperationStatus {
  /**
   * Gets the status of an asynchronous Defender for Storage settings operation. This is
   * the polling endpoint referenced by the `Azure-AsyncOperation` header returned from
   * the create-or-update operation.
   */
  @tag("DefenderForStorage")
  @route("/{+resourceId}/providers/Microsoft.Security/defenderForStorageSettings/{settingName}/operationStatus/{operationId}")
  @get
  get(
    ...ApiVersionParameter,

    /** The fully qualified Azure Resource manager identifier of the resource. */
    @path
    resourceId: string,

    /** The defender for storage setting name. */
    @path
    @pattern("^[a-z][a-z0-9]*$")
    settingName: SettingName,

    ...Azure.ResourceManager.CommonTypes.OperationIdParameter,
  ):
    | ArmResponse<Azure.ResourceManager.CommonTypes.OperationStatusResult>
    | ErrorResponse;
}
