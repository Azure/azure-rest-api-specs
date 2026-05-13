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

/** The status of a preflight validation. */
union PreflightStatus {
  string,

  /** Preflight validation succeeded. */
  "Succeeded",

  /** Preflight validation failed. */
  "Failed",
}
