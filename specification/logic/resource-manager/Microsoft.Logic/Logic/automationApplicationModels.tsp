import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.Logic;

/**
 * The provisioning state of the application resource.
 */
union ApplicationProvisioningState {
  string,

  /** The application is being provisioned. */
  Provisioning: "Provisioning",

  /** The application is being updated. */
  Updating: "Updating",

  /** The application is being deleted. */
  Deleting: "Deleting",

  /** The application has been successfully provisioned. */
  Succeeded: "Succeeded",

  /** The application provisioning has failed. */
  Failed: "Failed",

  /** The application provisioning was canceled. */
  Canceled: "Canceled",
}

/**
 * The properties of the application resource.
 */
model ApplicationProperties {
  /**
   * Gets the provisioning state of the application.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ApplicationProvisioningState;

  /**
   * The ARM resource identifier of the ContainerApp associated with this application.
   */
  appResourceId?: string;

  /**
   * The location of the application.
   */
  location?: string;
}
