import "@azure-tools/typespec-client-generator-core";
import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using Azure.ClientGenerator.Core;

namespace Microsoft.Security;
/**
 * The error detail.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.armExternalType
model CloudErrorBody {
  /**
   * The error code.
   */
  @visibility(Lifecycle.Read)
  code?: string;

  /**
   * The error message.
   */
  @visibility(Lifecycle.Read)
  message?: string;

  /**
   * The error target.
   */
  @visibility(Lifecycle.Read)
  target?: string;

  /**
   * The error details.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  details?: CloudErrorBody[];

  /**
   * The error additional info.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  additionalInfo?: ErrorAdditionalInfo[];
}

/**
 * The resource management error additional info.
 */
model ErrorAdditionalInfo {
  /**
   * The additional info type.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * The additional info.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  info?: unknown;
}

/**
 * Common error response for all Azure Resource Manager APIs to return error details for failed operations. (This also follows the OData error response format.).
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.armExternalType
@error
model CloudError {
  /**
   * The error object.
   */
  error?: CloudErrorBody;
}
/**
 * Describes an Azure resource.
 */
model Resource {
  /**
   * Resource Id
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Resource name
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Resource type
   */
  @visibility(Lifecycle.Read)
  type?: string;
}

/**
 * Enum. Indicates the action type.
 */
union ActionType {
  string,

  /**
   * LogicApp
   */
  LogicApp: "LogicApp",

  /**
   * EventHub
   */
  EventHub: "EventHub",

  /**
   * Workspace
   */
  Workspace: "Workspace",

  /**
   * Internal
   */
  Internal: "Internal",
}

/**
 * A status describing the success/failure of the enablement/disablement operation.
 */
model OperationStatus {
  /**
   * The operation status code.
   */
  code?: string;

  /**
   * Additional information regarding the success/failure of the operation.
   */
  message?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union SettingName {
  string,

  /**
   * MCAS
   */
  MCAS: "MCAS",

  /**
   * WDATP
   */
  WDATP: "WDATP",

  /**
   * WDATP_EXCLUDE_LINUX_PUBLIC_PREVIEW
   */
  WDATP_EXCLUDE_LINUX_PUBLIC_PREVIEW: "WDATP_EXCLUDE_LINUX_PUBLIC_PREVIEW",

  /**
   * WDATP_UNIFIED_SOLUTION
   */
  WDATP_UNIFIED_SOLUTION: "WDATP_UNIFIED_SOLUTION",

  /**
   * Sentinel
   */
  Sentinel: "Sentinel",

  /**
   * Name of the Defender for Storage Settings name.
   */
  current: "current",
}

/**
 * The current provisioning state of the resource. Indicates the status of the last operation performed on the resource.
 */
union ProvisioningState {
  string,

  /**
   * The resource has been successfully provisioned and is ready for use.
   */
  Succeeded: "Succeeded",

  /**
   * The resource is being created. This is a transitional state.
   */
  Creating: "Creating",

  /**
   * The resource is being updated. This is a transitional state.
   */
  Updating: "Updating",

  /**
   * The resource is being deleted. This is a transitional state.
   */
  Deleting: "Deleting",

  /**
   * The last operation on the resource failed. Check the error details for more information.
   */
  Failed: "Failed",

  /**
   * The operation was canceled before completion.
   */
  Canceled: "Canceled",

  /**
   * InProgress
   */
  InProgress: "InProgress",
}

/**
 * The type of identity that created the resource.
 */
union CreatedByType {
  string,

  /**
   * User
   */
  User: "User",

  /**
   * Application
   */
  Application: "Application",

  /**
   * ManagedIdentity
   */
  ManagedIdentity: "ManagedIdentity",

  /**
   * Key
   */
  Key: "Key",
}
/**
 * Aggregative state based on the standard's supported controls states
 */
union State {
  string,

  /**
   * All supported regulatory compliance controls in the given standard have a passed state
   */
  Passed: "Passed",

  /**
   * At least one supported regulatory compliance control in the given standard has a state of failed
   */
  Failed: "Failed",

  /**
   * All supported regulatory compliance controls in the given standard have a state of skipped
   */
  Skipped: "Skipped",

  /**
   * No supported regulatory compliance data for the given standard
   */
  Unsupported: "Unsupported",

  /**
   * Send notification on new alerts to the subscription's admins
   */
  On: "On",

  /**
   * Don't send notification on new alerts to the subscription's admins
   */
  Off: "Off",
}
