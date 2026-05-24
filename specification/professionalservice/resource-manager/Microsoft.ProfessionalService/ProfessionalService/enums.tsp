namespace Microsoft.ProfessionalService;

/** The provisioning state of the Professional Service resource. */
union ProfessionalServiceProvisioningState {
  string,
  Azure.ResourceManager.ResourceProvisioningState,
}

/** The Professional Service Subscription Status. */
union ProfessionalServiceResourceStatus {
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
