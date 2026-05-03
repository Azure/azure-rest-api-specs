using TypeSpec.Rest;
using TypeSpec.Http;
namespace Microsoft.SaaS;

/** The SaaS Subscription Status. */
union SaasResourceStatus {
  string,
  /** Subscription has not started */
  "NotStarted",
  /** Pending fulfillment start */
  "PendingFulfillmentStart",
  /** Subscribed */
  "Subscribed",
  /** Unsubscribed */
  "Unsubscribed",
  /** Suspended */
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

/** The deletion source. */
union DeletionSource {
  string,
  /** Customer initiated cancellation */
  "CustomerCancellation",
  /** Azure subscription deletion */
  "AzureSubscriptionDeletion",
}

