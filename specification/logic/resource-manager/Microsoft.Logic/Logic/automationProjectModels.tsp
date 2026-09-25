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

  /**
   * Optional customer networking selected when the automation project is created.
   * Networking cannot be added, changed, or removed after creation. Omitted networking
   * preserves the existing configuration on update.
   */
  @visibility(Lifecycle.Create, Lifecycle.Read)
  networking?: AutomationProjectNetworking;
}

/**
 * Customer-owned network used by the automation project's backing applications.
 */
model AutomationProjectNetworking {
  /**
   * Fully qualified resource ID of a subnet in the same region and customer tenant as the
   * automation project. The subnet may be in another subscription in that customer tenant.
   * Service-owned backing resources may be in a different service tenant and subscription.
   * The subnet must be delegated to Microsoft.App/environments. The caller must have
   * Microsoft.Network/virtualNetworks/subnets/join/action on the supplied subnet in addition
   * to permission to write the project. Omit the subnet to create a project without customer
   * networking; it cannot be attached later. On update, omission preserves the subnet and
   * resubmitting the same resource ID is idempotent. A different ID or null is rejected
   * synchronously without starting a long-running operation.
   */
  @visibility(Lifecycle.Create, Lifecycle.Read)
  @minLength(1)
  subnetResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/virtualNetworks/subnets";
    }
  ]>;
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
