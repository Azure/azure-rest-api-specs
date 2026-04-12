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
   * The unique application identifier. This is a server-generated GUID assigned
   * when the application is first created.
   */
  @visibility(Lifecycle.Read)
  applicationId?: string;

  /**
   * The ARM resource identifier of the ContainerApp associated with this application.
   */
  appResourceId?: string;

  /**
   * The timestamp when the application was created.
   */
  @visibility(Lifecycle.Read)
  createdOn?: utcDateTime;

  /**
   * The timestamp when the application was last updated.
   */
  @visibility(Lifecycle.Read)
  updatedOn?: utcDateTime;

  /**
   * The identity (object ID) that created this application association.
   */
  @visibility(Lifecycle.Read)
  createdBy?: string;

  /**
   * The identity (object ID) that last updated this application association.
   */
  @visibility(Lifecycle.Read)
  updatedBy?: string;
}
