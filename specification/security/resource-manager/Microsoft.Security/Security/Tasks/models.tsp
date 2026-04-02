import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "../Common/main.tsp";

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
