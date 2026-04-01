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

    /** The defender for storage setting name. */
    @path
    @segment("defenderForStorageSettings")
    @key
    @pattern("^[a-z][a-z0-9]*$")
    settingName: SettingName;
  },
  {},
  {}
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

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
   * Initiate a Defender for Storage malware scan for the specified storage account.
   */
  @tag("DefenderForStorage")
  @tag("Antimalware")
  @tag("Scan")
  @post
  @action("startMalwareScan")
  startMalwareScan is DefenderForStorageSettingsOps.ActionSync<
    DefenderForStorageSetting,
    void,
    ArmResponse<MalwareScan>,
    ErrorType = CloudError
  >;

  /**
   * Cancels a Defender for Storage malware scan for the specified storage account.
   */
  @tag("DefenderForStorage")
  @tag("Antimalware")
  @tag("Scan")
  @post
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
  getMalwareScan is DefenderForStorageMalwareScansOps.Read<
    MalwareScan,
    ErrorType = CloudError
  >;
}

@@doc(DefenderForStorageSetting.name, "Defender for Storage setting name.");
@@doc(DefenderForStorageSetting.properties,
  "Defender for Storage resource properties."
);
@@doc(DefenderForStorageSettings.create::parameters.resource,
  "Defender for Storage Settings"
);
