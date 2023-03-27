namespace DeveloperServicesApi.Models;

@doc("Subscription model.")
model Subscription {
  @doc("The unique identifier of the subscription.")
  id: string;

  @doc("The name of the subscription.")
  name: string;

  @doc("The owner of the subscription")
  ownerId: string;

  @doc("Scope like /products/{productId} or /apis or /apis/{apiId} or /.")
  scope: string;

  @doc("Subscription state.")
  state: SubscriptionState;

  @doc("Subscription creation date.")
  createdDate: zonedDateTime;

  @doc("Subscription activation date.")
  startDate: zonedDateTime;

  @doc("Subscription expiration date.")
  expirationDate: zonedDateTime;

  @doc("Date when subscription was cancelled or expired.")
  endDate: zonedDateTime;

  @doc("Upcoming subscription expiration notification date.")
  notificationDate: zonedDateTime;

  @doc("The subscription's primary key.")
  primaryKey: string;

  @doc("The subscription's secondary key.")
  secondaryKey: string;

  @doc("The subscription's state comment.")
  stateComment: string;
}

@doc("Subscription state.")
enum SubscriptionState {
  @doc("The subscription is active.")
  Active: "active",

  @doc("Subscription is blocked. User whose subscription is blocked cannot call subscription's product APIs.")
  Suspended: "suspended",

  @doc("Subscription is expired. User whose subscription is expired cannot call subscription's product APIs.")
  Expired: "expired",

  @doc("Subscription request has been submitted.")
  Submitted: "submitted",

  @doc("Subscription request has been rejected.")
  Rejected: "rejected",

  @doc("Subscription request has been cancelled.")
  Cancelled: "cancelled",
}

@doc("Create user subscription request.")
model UserSubscriptionCreate {
  @doc("Scope like /products/{productId} or /apis or /apis/{apiId} or /.")
  scope: string;

  @doc("The name of the subscription.")
  name: string;
}

@doc("Update user subscription request.")
model UserSubscriptionUpdate {
  @doc("Scope like /products/{productId} or /apis or /apis/{apiId} or /.")
  scope: string;

  @doc("Subscription state.")
  state: SubscriptionState;

  @doc("The name of the subscription.")
  name: string;
}
