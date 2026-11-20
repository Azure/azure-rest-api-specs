import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;
using Azure.ResourceManager;

namespace ServiceEntitlementsApi;

/** The operational state of a service entitlement. */
union ServiceEntitlementState {
  string,

  /** The service entitlement is enabled. */
  Enabled: "Enabled",

  /** The service entitlement is disabled. */
  Disabled: "Disabled",
}

/** The provisioning state of a service entitlement. */
@lroStatus
union ServiceEntitlementProvisioningState {
  ResourceProvisioningState,

  /** The resource creation request has been accepted. */
  Accepted: "Accepted",

  /** The resource is being created. */
  Creating: "Creating",

  /** The resource is being updated. */
  Updating: "Updating",

  /** The resource is being deleted. */
  Deleting: "Deleting",

  string,
}

/** Properties of a service entitlement. */
model ServiceEntitlementProperties {
  /** The service associated with the service entitlement. Current supported Value is Perception. */
  @visibility(Lifecycle.Create, Lifecycle.Read)
  serviceType: string;

  /** Indicates whether the service entitlement is enabled. */
  @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
  state: ServiceEntitlementState;

  /** The status of the most recent resource operation. */
  @visibility(Lifecycle.Read)
  provisioningState?: ServiceEntitlementProvisioningState;
}

/** Properties that can be updated on a service entitlement. */
model ServiceEntitlementUpdateProperties {
  /** Indicates whether the service entitlement is enabled. */
  state?: ServiceEntitlementState;
}

/** The request body for updating a service entitlement. */
model ServiceEntitlementUpdate {
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;

  /** Properties to update on the service entitlement. */
  properties?: ServiceEntitlementUpdateProperties;
}
