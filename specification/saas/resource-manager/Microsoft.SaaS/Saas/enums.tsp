namespace Microsoft.SaaS;

/** The provisioning state of the SaaS resource. */
union SaasProvisioningState {
  string,
  Azure.ResourceManager.ResourceProvisioningState,
}

/** The SaaS Subscription Status. */
union SaasResourceStatus {
  string,

  /** Subscription has not started */
  "NotStarted",

  /** Pending fulfillment start */
  "PendingFulfillmentStart",

  /** The subscription is active and in use */
  "Subscribed",

  /** The subscription has been cancelled */
  "Unsubscribed",

  /** The subscription is suspended */
  "Suspended",
}

/** The reason for the subscription status. */
union SubscriptionStatusReason {
  string,

  /** No specific reason */
  "None",

  /** Suspended internally */
  "SuspendedInternal",

  /** Azure subscription deleted */
  "AzureSubscriptionDeletion",
}

/** The deletion source. */
union DeletionSource {
  string,

  /** Customer initiated cancellation */
  CustomerCancellation: "CustomerCancellation",

  /** Azure subscription deletion */
  AzureSubscriptionDeletion: "AzureSubscriptionDeletion",
}

/** The intent for a patch operation. */
union PatchIntent {
  string,

  /** Retain the current subscription */
  "Retain",

  /** Reset the subscription */
  "Reset",

  /** Schedule a change */
  "ScheduleChange",
}

/** The status of a preflight validation. */
union PreflightStatus {
  string,

  /** Preflight validation succeeded. */
  "Succeeded",

  /** Preflight validation failed. */
  "Failed",
}
