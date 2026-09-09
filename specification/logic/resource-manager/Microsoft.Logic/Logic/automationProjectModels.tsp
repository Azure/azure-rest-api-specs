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
   * Customer networking configuration. Omitting networking or subnetResourceId in a PUT or PATCH
   * preserves the current subnet. Network changes complete asynchronously through replacement
   * backing applications, not an in-place network update. The operation succeeds only after
   * replacement applications are ready, cutover is complete, and old network resources are released.
   */
  @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
  networking?: AutomationProjectNetworking;
}

/**
 * Customer-owned network used by the automation project's backing applications.
 */
model AutomationProjectNetworking {
  /**
   * Fully qualified resource ID of a subnet in the same region and customer tenant as the
   * automation project. The subnet may be in a different subscription in that customer tenant.
   * Service-owned backing resources may be in a different service tenant and subscription.
   * The subnet must be delegated to Microsoft.App/environments. The caller must have
   * Microsoft.Network/virtualNetworks/subnets/join/action permission on every non-null requested
   * subnet, in addition to Microsoft.Logic/automationProjects/write on the project.
   * On create, a subnet provisions network-connected backing applications; omission or null
   * provisions backing applications without a customer subnet. On PUT or PATCH of an existing
   * project, omission preserves the current subnet, the same subnet leaves networking unchanged,
   * and a different non-null subnet requests asynchronous migration to replacement backing
   * applications. Explicit null requests asynchronous detach to replacement backing applications
   * without a customer subnet. Detaching an already detached project leaves networking unchanged.
   * During provisioning or migration, responses describe the requested configuration, not proof
   * of effective connectivity. Responses omit subnetResourceId when no customer subnet is requested.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Explicit null requests subnet detach on PUT/PATCH; omission preserves the current subnet. Null is an operation input, not a substitute for optionality."
  @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
  @minLength(1)
  subnetResourceId?:
    | Azure.Core.armResourceIdentifier<[
        {
          type: "Microsoft.Network/virtualNetworks/subnets";
        }
      ]>
    | null;
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

  /**
   * Customer networking configuration. Omitting networking or subnetResourceId preserves the
   * current subnet. A changed subnet or explicit null subnetResourceId requests asynchronous
   * migration. The operation succeeds only after replacement applications are ready, cutover
   * is complete, and old network resources are released.
   */
  @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
  networking?: AutomationProjectNetworking;
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
