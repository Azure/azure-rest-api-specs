import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;

namespace Microsoft.SoftwarePlan;

/** SoftwareBillingSubscription resource */
model SoftwareBillingSubscription
  is ProxyResource<SoftwareBillingSubscriptionProperties> {
  /** The ID that uniquely identifies a software billing subscription. */
  @key("softwareBillingSubscriptionName")
  @path
  @segment("softwareBillingSubscriptions")
  @pattern("^[0-9A-Fa-f]{8}-([0-9A-Fa-f]{4}-){3}[0-9A-Fa-f]{12}$")
  @visibility(Lifecycle.Read)
  name: string;
}

/** SoftwareBillingSubscription properties */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "SoftwareBillingSubscription is a proxy resource"
model SoftwareBillingSubscriptionProperties {
  /** Friendly name for the subscription */
  @visibility(Lifecycle.Read)
  displayName: string;

  /** Unique identifier for the product purchased */
  @visibility(Lifecycle.Read)
  productCode: string;

  /** Quantity of the product being billed under this subscription. */
  @visibility(Lifecycle.Read)
  quantity: int32;

  /** The status of the software billing subscription. */
  @visibility(Lifecycle.Read)
  status: SoftwareBillingSubscriptionStatus;

  /** Date when the subscription benefit should start. Format : 2023-02-01T01:01:01.1075056Z */
  @visibility(Lifecycle.Read)
  startDate: string;

  /** Date when the subscription benefit should end. Format : 2026-02-01T01:01:01.1075056Z */
  @visibility(Lifecycle.Read)
  endDate: string;

  /** Indicates whether the subscription is configured for automatic renewal upon expiration. */
  @visibility(Lifecycle.Read)
  autoRenew: AutoRenewSetting;

  /** Contains information about renewal of this subscription */
  @visibility(Lifecycle.Read)
  renewal?: SoftwareSubscriptionRenewalProperties;

  /** The ID of the software billing subscription corresponding to the base/initial software subscription purchased. Format : /providers/Microsoft.Billing/billingAccounts/{billingAccountName}/providers/Microsoft.SoftwarePlan/softwareBillingSubscriptions/{softwareBillingSubscriptionName} */
  @visibility(Lifecycle.Read)
  parentSoftwareBillingSubscriptionId?: string;

  /** The IDs of the software billing subscriptions corresponding to the True up or Licenses that are added on top of the base/initial software subscription purchase (parent). Returned only if requested in the $expand query parameter. Format : /providers/Microsoft.Billing/billingAccounts/{billingAccountName}/providers/Microsoft.SoftwarePlan/softwareBillingSubscriptions/{softwareBillingSubscriptionName} */
  @visibility(Lifecycle.Read)
  associatedSoftwareBillingSubscriptionIds?: string[];

  /** The ID of the billing profile to which this subscription is billed. Format : /providers/Microsoft.Billing/billingAccounts/{billingAccountName}/billingProfiles/{billingProfileName} */
  @visibility(Lifecycle.Read)
  billingProfileId: string;

  /** The uri of the software subscription resource corresponding to this software billing subscription. Format : /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SoftwarePlan/softwareSubscriptions/{softwareSubscriptionName} */
  @visibility(Lifecycle.Read)
  resourceUri: string;

  /** The type of the software subscription resource corresponding to this software billing subscription. */
  @visibility(Lifecycle.Read)
  softwareSubscriptionType: SoftwareSubscriptionType;
}

/** The status of the software billing subscription. */
union SoftwareBillingSubscriptionStatus {
  string,

  /** The software billing subscription is in a pending state. This represents the initial phase after creation, before activation and the commencement of billing. */
  Pending: "Pending",

  /** Software billing subscription is active. */
  Active: "Active",

  /** Software billing subscription creation failed. */
  Failed: "Failed",

  /** Software billing subscription has been canceled. */
  Canceled: "Canceled",

  /** Software billing subscription has expired. */
  Expired: "Expired",
}

/** SoftwareBillingSubscription expand query parameter */
model ExpandSoftwareBillingSubscriptionQueryParameter {
  /** The $expand OData query parameter. This is a comma-separated list of additional properties to include in the response. Possible values include: 'associatedSoftwareBillingSubscriptionIds'. */
  @query("$expand")
  expand?: string;
}
