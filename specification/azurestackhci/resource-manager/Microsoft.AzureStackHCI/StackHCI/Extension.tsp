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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  get is ArmResourceRead<Extension>;

  /**
   * Create Extension for the Parent Entity(HCI Cluster/Edge Machine).
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  create is ArmResourceCreateOrReplaceAsync<Extension>;

  /**
   * Update Extension for the Parent Entity(HCI Cluster/Edge Machine).
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<Extension, PatchModel = ExtensionPatch>;

  /**
   * Delete particular Arc Extension of the Parent Entity(HCI Cluster/Edge Machine).
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  listByArcSetting is ArmResourceListByParent<
    Extension,
    Response = ArmResponse<ExtensionList>
  >;

  /**
   * Upgrade a particular Arc Extension of the Parent Entity(HCI Cluster/Edge Machine).
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
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
 * Status of Arc Extension for a particular node/machine in the Parent Entity(HCI Cluster/Edge Machine).
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "model nomenclature"
model ExtensionProperties {
  /**
   * Provisioning state of the Extension proxy resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Parameters specific to this extension type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  extensionParameters?: ExtensionParameters;

  /**
   * Aggregate state of Arc Extensions across the node/machines in the Parent Entity(HCI Cluster/Edge Machine).
   */
  @visibility(Lifecycle.Read)
  aggregateState?: ExtensionAggregateState;

  /**
   * State of Arc Extension in each of the nodes/machines.
   */
  @visibility(Lifecycle.Read)
  perNodeExtensionDetails?: PerNodeExtensionState[];

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
model ExtensionParameters {
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
 * Status of Arc Extension for a particular node/machine in the Parent Entity(HCI Cluster/Edge Machine).
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "model nomenclature"
model PerNodeExtensionState {
  /**
   * Name of the node/machine in the Parent Entity(HCI Cluster/Edge Machine).
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Fully qualified resource ID for the particular Arc Extension on this node/machine.
   */
  @visibility(Lifecycle.Read)
  extension?: string;

  /**
   * Specifies the version of the script handler.
   */
  @visibility(Lifecycle.Read)
  typeHandlerVersion?: string;

  /**
   * State of Arc Extension in this node/machine.
   */
  @visibility(Lifecycle.Read)
  state?: NodeExtensionState;

  /**
   * The extension instance view.
   */
  @visibility(Lifecycle.Read)
  instanceView?: ExtensionInstanceView;
}

/**
 * Describes the Extension Instance View.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "model nomenclature"
model ExtensionInstanceView {
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
  status?: ExtensionInstanceViewStatus;
}

/**
 * Instance view status.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "model nomenclature"
model ExtensionInstanceViewStatus {
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
model ExtensionPatch {
  /**
   * Describes Machine Extension Properties that can be updated.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
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
