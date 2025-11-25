import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ArcSetting.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AzureStackHCI;
/**
 * Details of a particular extension in HCI Cluster.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "model nomenclature"
@parentResource(ArcSetting)
model Extension is Azure.ResourceManager.ProxyResource<ExtensionProperties> {
  ...ResourceNameParameter<
    Resource = Extension,
    KeyName = "extensionName",
    SegmentName = "extensions",
    NamePattern = ""
  >;
}

@armResourceOperations
interface Extensions {
  /**
   * Get particular Arc Extension of the Parent Entity(HCI Cluster/Edge Machine).
   */
  get is ArmResourceRead<Extension>;

  /**
   * Create Extension for the Parent Entity(HCI Cluster/Edge Machine).
   */
  create is ArmResourceCreateOrReplaceAsync<Extension>;

  /**
   * Update Extension for the Parent Entity(HCI Cluster/Edge Machine).
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<Extension, PatchModel = ExtensionPatch>;

  /**
   * Delete particular Arc Extension of the Parent Entity(HCI Cluster/Edge Machine).
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    Extension,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader &
      ArmLroLocationHeader> | ArmDeletedNoContentResponse
  >;

  /**
   * List all Extensions under the Parent Entity(HCI Cluster/Edge Machine).
   */
  listByArcSetting is ArmResourceListByParent<
    Extension,
    Response = ArmResponse<ExtensionList>
  >;

  /**
   * Upgrade a particular Arc Extension of the Parent Entity(HCI Cluster/Edge Machine).
   */
  upgrade is ArmResourceActionAsyncBase<
    Extension,
    ExtensionUpgradeParameters,
    Response = ArmAcceptedLroResponse<"azure-asyncoperation">,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<Extension>
  >;
}

@@doc(Extension.name, "The name of the machine extension.");
@@doc(Extension.properties, "Describes Machine Extension Properties.");
@@doc(Extensions.create::parameters.resource,
  "Details of the Machine Extension to be created."
);
@@doc(Extensions.update::parameters.properties,
  "Details of the Machine Extension to be created."
);
@@doc(Extensions.upgrade::parameters.body,
  "Parameters supplied to the Upgrade Extensions operation."
);

// Models

/**
 * List of Extensions in the Parent Entity(HCI Cluster/Edge Machine).
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "model nomenclature"
model ExtensionList is Azure.Core.Page<Extension>;

/**
 * Extension Details to update
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "model nomenclature"
model ExtensionPatch {
  /**
   * Describes Machine Extension Properties that can be updated.
   */
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
  @Azure.ClientGenerator.Core.Legacy.flattenProperty
  properties?: ExtensionPatchProperties;
}

/**
 * Describes Machine Extension Properties that can be updated.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "model nomenclature"
model ExtensionPatchProperties {
  /**
   * Describes the properties of a Machine Extension that can be updated.
   */
  extensionParameters?: ExtensionPatchParameters;
}

/**
 * Describes the properties of a Machine Extension that can be updated.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "model nomenclature"
model ExtensionPatchParameters {
  /**
   * Specifies the version of the script handler. Latest version would be used if not specified.
   */
  typeHandlerVersion?: string;

  /**
   * Indicates whether the extension should be automatically upgraded by the platform if there is a newer version available.
   */
  enableAutomaticUpgrade?: boolean;

  /**
   * Json formatted public settings for the extension.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Backward compatibility to maintain consistency with old swagger"
  settings?: Record<unknown>;

  /**
   * Protected settings (may contain secrets).
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Backward compatibility to maintain consistency with old swagger"
  protectedSettings?: Record<unknown>;
}

/**
 * Describes the parameters for Extension upgrade.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "model nomenclature"
model ExtensionUpgradeParameters {
  /**
   * Extension Upgrade Target Version.
   */
  targetVersion?: string;
}
