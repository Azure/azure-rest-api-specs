import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;
using Azure.ResourceManager;

namespace ServiceEntitlementSettingsApi;

/** The provisioning state of a service entitlement setting. */
@lroStatus
union ServiceEntitlementSettingProvisioningState {
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

/** Properties of a service entitlement setting. */
model ServiceEntitlementSettingProperties {
  /** Indicates whether the containing subscription is the default subscription for service entitlements in the tenant. Only one subscription in a tenant can be marked as the default. */
  @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
  isDefault: boolean;

  /** The status of the most recent resource operation. */
  @visibility(Lifecycle.Read)
  provisioningState?: ServiceEntitlementSettingProvisioningState;
}

/** Properties that can be updated on a service entitlement setting. */
model ServiceEntitlementSettingUpdateProperties {
  /** Indicates whether the containing subscription is the default subscription for service entitlements in the tenant. */
  isDefault?: boolean;
}

/** The request body for updating a service entitlement setting. */
model ServiceEntitlementSettingUpdate {
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;

  /** Properties to update on the service entitlement setting. */
  properties?: ServiceEntitlementSettingUpdateProperties;
}
