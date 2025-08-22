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
model HCIExtension
  is Azure.ResourceManager.ProxyResource<HCIExtensionProperties> {
  ...ResourceNameParameter<
    Resource = HCIExtension,
    KeyName = "extensionName",
    SegmentName = "extensions",
    NamePattern = ""
  >;
}

@armResourceOperations
interface Extensions {
  /**
   * Get particular Arc Extension of HCI Cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  get is ArmResourceRead<HCIExtension>;

  /**
   * Create Extension for HCI cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  create is ArmResourceCreateOrReplaceAsync<HCIExtension>;

  /**
   * Update Extension for HCI cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<HCIExtension, PatchModel = HCIExtensionPatch>;

  /**
   * Delete particular Arc Extension of HCI Cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    HCIExtension,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader &
      ArmLroLocationHeader> | ArmDeletedNoContentResponse
  >;

  /**
   * List all Extensions under ArcSetting resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  listByArcSetting is ArmResourceListByParent<
    HCIExtension,
    Response = ArmResponse<HCIExtensionList>
  >;

  /**
   * Upgrade a particular Arc Extension of HCI Cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  upgrade is ArmResourceActionAsyncBase<
    HCIExtension,
    HCIExtensionUpgradeParameters,
    Response = ArmAcceptedLroResponse<"azure-asyncoperation">,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<HCIExtension>
  >;
}

@@doc(HCIExtension.name, "The name of the machine extension.");
@@doc(HCIExtension.properties, "Describes Machine Extension Properties.");
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
 * List of Extensions in HCI cluster.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "model nomenclature"
model HCIExtensionList is Azure.Core.Page<HCIExtension>;

/**
 * Status of Arc Extension for a particular node in HCI Cluster.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "model nomenclature"
model HCIExtensionProperties {
  /**
   * Provisioning state of the Extension proxy resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Parameters specific to this extension type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  extensionParameters?: HCIExtensionParameters;

  /**
   * Aggregate state of Arc Extensions across the nodes in this HCI cluster.
   */
  @visibility(Lifecycle.Read)
  aggregateState?: ExtensionAggregateState;

  /**
   * State of Arc Extension in each of the nodes.
   */
  @visibility(Lifecycle.Read)
  perNodeExtensionDetails?: HCIPerNodeExtensionState[];

  /**
   * Indicates if the extension is managed by azure or the user.
   */
  @visibility(Lifecycle.Read)
  managedBy?: ExtensionManagedBy;
}

/**
 * Describes the properties of a Machine Extension. This object mirrors the definition in HybridCompute.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "model nomenclature"
model HCIExtensionParameters {
  /**
   * How the extension handler should be forced to update even if the extension configuration has not changed.
   */
  forceUpdateTag?: string;

  /**
   * The name of the extension handler publisher.
   */
  publisher?: string;

  /**
   * Specifies the type of the extension; an example is "CustomScriptExtension".
   */
  type?: string;

  /**
   * Specifies the version of the script handler. Latest version would be used if not specified.
   */
  typeHandlerVersion?: string;

  /**
   * Indicates whether the extension should use a newer minor version if one is available at deployment time. Once deployed, however, the extension will not upgrade minor versions unless redeployed, even with this property set to true.
   */
  autoUpgradeMinorVersion?: boolean;

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

  /**
   * Indicates whether the extension should be automatically upgraded by the platform if there is a newer version available.
   */
  enableAutomaticUpgrade?: boolean;
}

/**
 * Status of Arc Extension for a particular node in HCI Cluster.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "model nomenclature"
model HCIPerNodeExtensionState {
  /**
   * Name of the node in HCI Cluster.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Fully qualified resource ID for the particular Arc Extension on this node.
   */
  @visibility(Lifecycle.Read)
  extension?: string;

  /**
   * Specifies the version of the script handler.
   */
  @visibility(Lifecycle.Read)
  typeHandlerVersion?: string;

  /**
   * State of Arc Extension in this node.
   */
  @visibility(Lifecycle.Read)
  state?: NodeExtensionState;

  /**
   * The extension instance view.
   */
  @visibility(Lifecycle.Read)
  instanceView?: HCIExtensionInstanceView;
}

/**
 * Describes the Extension Instance View.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "model nomenclature"
model HCIExtensionInstanceView {
  /**
   * The extension name.
   */
  name?: string;

  /**
   * Specifies the type of the extension; an example is "MicrosoftMonitoringAgent".
   */
  type?: string;

  /**
   * Specifies the version of the script handler.
   */
  typeHandlerVersion?: string;

  /**
   * Instance view status.
   */
  status?: HCIExtensionInstanceViewStatus;
}

/**
 * Instance view status.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "model nomenclature"
model HCIExtensionInstanceViewStatus {
  /**
   * The status code.
   */
  code?: string;

  /**
   * The level code.
   */
  level?: StatusLevelTypes;

  /**
   * The short localizable label for the status.
   */
  displayStatus?: string;

  /**
   * The detailed status message, including for alerts and error messages.
   */
  message?: string;

  /**
   * The time of the status.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  time?: utcDateTime;
}

/**
 * Extension Details to update
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "model nomenclature"
model HCIExtensionPatch {
  /**
   * Describes Machine Extension Properties that can be updated.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: HCIExtensionPatchProperties;
}

/**
 * Describes Machine Extension Properties that can be updated.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "model nomenclature"
model HCIExtensionPatchProperties {
  /**
   * Describes the properties of a Machine Extension that can be updated.
   */
  extensionParameters?: HCIExtensionPatchParameters;
}

/**
 * Describes the properties of a Machine Extension that can be updated.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "model nomenclature"
model HCIExtensionPatchParameters {
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
model HCIExtensionUpgradeParameters {
  /**
   * Extension Upgrade Target Version.
   */
  targetVersion?: string;
}
