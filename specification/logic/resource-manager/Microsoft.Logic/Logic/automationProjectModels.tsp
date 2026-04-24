import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.Logic;

/**
 * The provisioning state of the automation project resource.
 */
union AutomationProjectProvisioningState {
  string,

  /** The automation project is being provisioned. */
  Provisioning: "Provisioning",

  /** The automation project is being updated. */
  Updating: "Updating",

  /** The automation project is being deleted. */
  Deleting: "Deleting",

  /** The automation project has been successfully provisioned. */
  Succeeded: "Succeeded",

  /** The automation project provisioning has failed. */
  Failed: "Failed",

  /** The automation project provisioning was canceled. */
  Canceled: "Canceled",
}

/**
 * The properties of the automation project resource.
 */
model AutomationProjectProperties {
  /**
   * Gets the provisioning state of the automation project.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: AutomationProjectProvisioningState;

  /**
   * A description of the automation project.
   */
  @maxLength(1024)
  description?: string;
}

/**
 * The updatable properties of the automation project resource.
 */
model AutomationProjectUpdateProperties {
  /**
   * A description of the automation project.
   */
  @maxLength(1024)
  description?: string;
}

/**
 * The automation project patch model for update operations.
 */
model AutomationProjectUpdate
  is Azure.ResourceManager.Foundations.TagsUpdateModel<AutomationProject> {
  /**
   * The updatable properties of the automation project.
   */
  properties?: AutomationProjectUpdateProperties;

  /**
   * Managed service identity for the automation project.
   */
  ...Azure.ResourceManager.ManagedServiceIdentityProperty;
}
