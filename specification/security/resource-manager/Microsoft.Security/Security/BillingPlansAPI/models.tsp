import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;
using Azure.ResourceManager;

namespace BillingPlansAPI;

/** The operational state of a billing plan. */
union BillingPlanState {
  string,

  /** The billing plan is enabled. */
  Enabled: "Enabled",

  /** The billing plan is disabled. */
  Disabled: "Disabled",
}

/** The provisioning state of a billing plan. */
@lroStatus
union BillingPlanProvisioningState {
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

/** Properties of a billing plan. */
model BillingPlanProperties {
  /** The service associated with the billing plan. */
  @visibility(Lifecycle.Create, Lifecycle.Read)
  serviceType: string;

  /** Indicates whether the billing plan is enabled. */
  @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
  state: BillingPlanState;

  /**
   * Service-specific billing plan configuration. The schema is owned by the
   * service identified by serviceType.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Billing plans provide a service-owned extensibility bag so new Microsoft.Security products can onboard without changing this API contract."
  @visibility(Lifecycle.Create, Lifecycle.Read)
  serviceProperties?: Record<unknown>;

  /** The status of the most recent resource operation. */
  @visibility(Lifecycle.Read)
  provisioningState?: BillingPlanProvisioningState;
}

/** Properties that can be updated on a billing plan. */
model BillingPlanUpdateProperties {
  /** Indicates whether the billing plan is enabled. */
  state?: BillingPlanState;
}

/** The request body for updating a billing plan. */
model BillingPlanUpdate {
  /** Properties to update on the billing plan. */
  properties?: BillingPlanUpdateProperties;
}
