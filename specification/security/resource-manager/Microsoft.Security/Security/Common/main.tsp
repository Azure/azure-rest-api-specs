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
