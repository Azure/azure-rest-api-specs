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
}

/**
 * The updatable properties of the auto project resource.
 */
model AutoProjectUpdateProperties {
  /**
   * A description of the auto project.
   */
  description?: string;
}

/**
 * The auto project patch model for update operations.
 */
model AutoProjectUpdate
  is Azure.ResourceManager.Foundations.TagsUpdateModel<AutoProject> {
  /**
   * The updatable properties of the auto project.
   */
  properties?: AutoProjectUpdateProperties;

  /**
   * Managed service identity for the auto project.
   */
  ...Azure.ResourceManager.ManagedServiceIdentityProperty;
}
