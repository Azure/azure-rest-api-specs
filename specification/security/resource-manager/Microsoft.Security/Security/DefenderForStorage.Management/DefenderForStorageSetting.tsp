import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Security;
/**
 * The Defender for Storage resource.
 */
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

@armResourceOperations
interface DefenderForStorageSettings {
  /**
   * Gets the Defender for Storage settings for the specified storage account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DefenderForStorage_Get")
  get is Extension.Read<Extension.ScopeParameter, DefenderForStorageSetting>;

  /**
   * Creates or updates the Defender for Storage settings on a specified storage account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DefenderForStorage_Create")
  create is Extension.CreateOrReplaceSync<
    Extension.ScopeParameter,
    DefenderForStorageSetting
  >;

  /**
   * Lists the Defender for Storage settings for the specified storage account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DefenderForStorage_List")
  list is Extension.ListByTarget<
    Extension.ScopeParameter,
    DefenderForStorageSetting,
    Response = ArmResponse<DefenderForStorageSettingList>
  >;

  /**
   * Initiate a Defender for Storage malware scan for the specified storage account. Blobs and Files will be scanned for malware.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DefenderForStorage_StartMalwareScan")
  startMalwareScan is Extension.ActionSync<
    Extension.ScopeParameter,
    DefenderForStorageSetting,
    void,
    ArmResponse<MalwareScan>
  >;

  /**
   * Cancels a Defender for Storage malware scan for the specified storage account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DefenderForStorage_CancelMalwareScan")
  cancelMalwareScan is Extension.ActionSync<
    Extension.ScopeParameter,
    DefenderForStorageSetting,
    void,
    ArmResponse<MalwareScan>,
    Parameters = {
      /**
       * The identifier of the scan. Can be either 'latest' or a GUID.
       */
      @pattern("^(latest|[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12})$")
      @path
      scanId: string;
    }
  >;

  /**
   * Gets the Defender for Storage malware scan for the specified storage resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DefenderForStorage_GetMalwareScan")
  @get
  @action("{scanId}")
  getMalwareScan is Extension.ActionSync<
    Extension.ScopeParameter,
    DefenderForStorageSetting,
    void,
    ArmResponse<MalwareScan>,
    Parameters = {
      /**
       * The identifier of the scan. Can be either 'latest' or a GUID.
       */
      @pattern("^(latest|[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12})$")
      @path
      scanId: string;
    }
  >;
}

@@doc(DefenderForStorageSetting.name, "Defender for Storage setting name.");
@@doc(DefenderForStorageSetting.properties,
  "Defender for Storage resource properties."
);
@@doc(DefenderForStorageSettings.create::parameters.resource,
  "Defender for Storage Settings"
);
