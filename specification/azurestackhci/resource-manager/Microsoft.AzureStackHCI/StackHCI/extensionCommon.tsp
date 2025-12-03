import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using TypeSpec.OpenAPI;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.AzureStackHCI;

//TODO: Use the common models in Extension.tsp
/**
 * Status of Arc Extension for a particular node in the Parent Entity(HCI Cluster/Edge Machine).
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
  extensionParameters?: ExtensionParameters;

  /**
   * Aggregate state of Arc Extensions across the nodes in the Parent Entity(HCI Cluster/Edge Machine).
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
 * Status of Arc Extension for a particular node in the Parent Entity(HCI Cluster/Edge Machine).
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
 * Aggregate state of Arc Extensions across the nodes in the Parent Entity(HCI Cluster/Edge Machine).
 */
union ExtensionAggregateState {
  string,

  /** The state is not specified. */
  NotSpecified: "NotSpecified",

  /** An error occurred. */
  Error: "Error",

  /** The operation succeeded. */
  Succeeded: "Succeeded",

  /** The operation was canceled. */
  Canceled: "Canceled",

  /** The operation failed. */
  Failed: "Failed",

  /** The extension is connected. */
  Connected: "Connected",

  /** The extension is disconnected. */
  Disconnected: "Disconnected",

  /** The extension is deleted. */
  Deleted: "Deleted",

  /** The extension is being created. */
  Creating: "Creating",

  /** The extension is being updated. */
  Updating: "Updating",

  /** The extension is being deleted. */
  Deleting: "Deleting",

  /** The extension is being moved. */
  Moving: "Moving",

  /** The operation partially succeeded. */
  PartiallySucceeded: "PartiallySucceeded",

  /** The extension is partially connected. */
  PartiallyConnected: "PartiallyConnected",

  /** The operation is in progress. */
  InProgress: "InProgress",

  /** The operation has been accepted. */
  Accepted: "Accepted",

  /** The extension is provisioning. */
  Provisioning: "Provisioning",

  /** Upgrade failed but rollback succeeded. */
  UpgradeFailedRollbackSucceeded: "UpgradeFailedRollbackSucceeded",
}

/**
 * State of Arc Extension in this node.
 */
union NodeExtensionState {
  string,

  /** The state is not specified. */
  NotSpecified: "NotSpecified",

  /** An error occurred. */
  Error: "Error",

  /** The operation succeeded. */
  Succeeded: "Succeeded",

  /** The operation was canceled. */
  Canceled: "Canceled",

  /** The operation failed. */
  Failed: "Failed",

  /** The extension is connected. */
  Connected: "Connected",

  /** The extension is disconnected. */
  Disconnected: "Disconnected",

  /** The extension is deleted. */
  Deleted: "Deleted",

  /** The extension is being created. */
  Creating: "Creating",

  /** The extension is being updated. */
  Updating: "Updating",

  /** The extension is being deleted. */
  Deleting: "Deleting",

  /** The extension is being moved. */
  Moving: "Moving",

  /** The operation partially succeeded. */
  PartiallySucceeded: "PartiallySucceeded",

  /** The extension is partially connected. */
  PartiallyConnected: "PartiallyConnected",

  /** The operation is in progress. */
  InProgress: "InProgress",

  /** The operation has been accepted. */
  Accepted: "Accepted",

  /** The extension is provisioning. */
  Provisioning: "Provisioning",
}

/**
 * The level code.
 */
union StatusLevelTypes {
  string,

  /** Information level. */
  Info: "Info",

  /** Warning level. */
  Warning: "Warning",

  /** Error level. */
  Error: "Error",
}
