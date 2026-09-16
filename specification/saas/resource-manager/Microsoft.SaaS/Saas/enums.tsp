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
  NotStarted: "NotStarted",

  /** Pending fulfillment start */
  PendingFulfillmentStart: "PendingFulfillmentStart",

  /** The subscription is active and in use */
  Subscribed: "Subscribed",

  /** The subscription has been cancelled */
  Unsubscribed: "Unsubscribed",

  /** The subscription is suspended */
  Suspended: "Suspended",
}

/** The reason for the subscription status. */
union SubscriptionStatusReason {
  string,

  /** No specific reason */
  None: "None",

  /** Suspended internally */
  SuspendedInternal: "SuspendedInternal",

  /** Azure subscription deleted */
  AzureSubscriptionDeletion: "AzureSubscriptionDeletion",
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
  Retain: "Retain",

  /** Reset the subscription */
  Reset: "Reset",

  /** Schedule a change */
  ScheduleChange: "ScheduleChange",
}
