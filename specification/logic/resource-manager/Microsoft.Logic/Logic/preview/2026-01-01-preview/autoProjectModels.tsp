import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.Logic;

/**
 * The provisioning state of the auto project resource.
 */
union AutoProjectProvisioningState {
  string,

  /** The auto project is being created or updated. */
  InProgress: "InProgress",

  /** The auto project has been successfully provisioned. */
  Succeeded: "Succeeded",

  /** The auto project provisioning has failed. */
  Failed: "Failed",

  /** The auto project provisioning was canceled. */
  Canceled: "Canceled",

  /** The auto project is being deleted. */
  Deleting: "Deleting",
}

/**
 * The properties of the auto project resource.
 */
model AutoProjectProperties {
  /**
   * Gets the provisioning state of the auto project.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: AutoProjectProvisioningState;

  /**
   * Gets the created time of the auto project.
   */
  @visibility(Lifecycle.Read)
  createdTime?: utcDateTime;

  /**
   * Gets the last modified time of the auto project.
   */
  @visibility(Lifecycle.Read)
  changedTime?: utcDateTime;

  /**
   * A description of the auto project.
   */
  description?: string;

  /**
   * The auto apps managed by this auto project (read-only).
   * Populated by the server based on ContainerApps that have `managedBy` set to this auto project's resource ID.
   * Each ContainerApp must have kind set to 'workflowapp'.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["resourceId"])
  autoApps?: AutoAppReference[];
}

/**
 * A reference to a ContainerApp of kind workflowapp managed by this auto project.
 */
model AutoAppReference {
  /**
   * The ARM resource ID of the ContainerApp (Microsoft.App/containerApps).
   * The ContainerApp must have kind set to 'workflowapp' and managedBy set to this auto project's resource ID.
   */
  resourceId: string;

  /**
   * A friendly display name for this auto app within the auto project.
   */
  displayName?: string;

  /**
   * Gets the current provisioning state of the referenced auto app.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: AutoAppProvisioningState;

  /**
   * Gets the current running state of the referenced auto app.
   */
  @visibility(Lifecycle.Read)
  runningState?: AutoAppRunningState;
}

/**
 * The provisioning state of an auto app managed by the auto project.
 */
union AutoAppProvisioningState {
  string,

  /** The auto app is being provisioned. */
  InProgress: "InProgress",

  /** The auto app has been successfully provisioned. */
  Succeeded: "Succeeded",

  /** The auto app provisioning has failed. */
  Failed: "Failed",

  /** The auto app provisioning was canceled. */
  Canceled: "Canceled",

  /** The auto app is being deleted. */
  Deleting: "Deleting",
}

/**
 * The running state of an auto app managed by the auto project.
 */
union AutoAppRunningState {
  string,

  /** The auto app is running. */
  Running: "Running",

  /** The auto app is stopped. */
  Stopped: "Stopped",

  /** The running state is unknown. */
  Unknown: "Unknown",
}
