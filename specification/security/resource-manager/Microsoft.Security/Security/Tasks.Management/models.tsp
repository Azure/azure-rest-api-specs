import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Security;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union TaskUpdateActionType {
  string,

  /**
   * Activate
   */
  Activate: "Activate",

  /**
   * Dismiss
   */
  Dismiss: "Dismiss",

  /**
   * Start
   */
  Start: "Start",

  /**
   * Resolve
   */
  Resolve: "Resolve",

  /**
   * Close
   */
  Close: "Close",
}

/**
 * List of security task recommendations
 */
model SecurityTaskList {
  /** The SecurityTask items on this page */
  @pageItems
  @visibility(Lifecycle.Read)
  value?: SecurityTask[];

  /** The URI to fetch the next page. */
  @nextLink
  @visibility(Lifecycle.Read)
  nextLink?: string;
}

/**
 * Describes properties of a task.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SecurityTaskProperties {
  /**
   * State of the task (Active, Resolved etc.)
   */
  @visibility(Lifecycle.Read)
  state?: string;

  /**
   * The time this task was discovered in UTC
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTimeUtc?: utcDateTime;

  /**
   * Changing set of properties, depending on the task type that is derived from the name field
   */
  securityTaskParameters?: SecurityTaskParameters;

  /**
   * The time this task's details were last changed in UTC
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastStateChangeTimeUtc?: utcDateTime;

  /**
   * Additional data on the state of the task
   */
  @visibility(Lifecycle.Read)
  subState?: string;
}

/**
 * Changing set of properties, depending on the task type that is derived from the name field
 */
model SecurityTaskParameters {
  ...Record<unknown>;

  /**
   * Name of the task type
   */
  @visibility(Lifecycle.Read)
  name?: string;
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
 * Common error response for all Azure Resource Manager APIs to return error details for failed operations. (This also follows the OData error response format.).
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@error
@Azure.ResourceManager.Legacy.armExternalType
model CloudError {
  /**
   * The error object.
   */
  error?: CloudErrorBody;
}

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
  details?: CloudErrorBody[];

  /**
   * The error additional info.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
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
