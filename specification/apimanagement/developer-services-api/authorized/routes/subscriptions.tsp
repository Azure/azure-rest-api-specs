import "@typespec/rest";
import "../../models/common.tsp";
import "../../models/subscription.tsp";

using TypeSpec.Http;
using DeveloperServicesAPI.Models;

namespace DeveloperServicesAuthorizedAPI.Routes.Subscriptions;

@route("/users/{userId}/subscriptions")
@doc("List a collection of user subscriptions.")
@get
op ListUserSubscriptions(
  ...UserParams,
  ...ListParams
): ApiResponse<Collection<Subscription>>;

@route("/users/{userId}/subscriptions/{subscriptionId}")
@doc("Get user subscription by its identifier.")
@get
op GetUserSubscription(
  ...UserParams,
  ...CommonParams
): ApiResponse<Subscription>;

@route("/users/{userId}/subscriptions/{subscriptionId}")
@doc("Create user subscription.")
@post
op CreateUserSubscription(
  ...UserParams,
  ...CommonParams,
  @body userSubscriptionCreate: UserSubscriptionCreate
): NoContentResponse | ErrorResponse;

@route("/users/{userId}/subscriptions/{subscriptionId}")
@doc("Update user subscription.")
@patch
op UpdateUserSubscription(
  ...UserParams,
  ...CommonParams,
  @body userSubscriptionUpdate: UserSubscriptionUpdate
): NoContentResponse | ErrorResponse;

@route("/users/{userId}/subscriptions/{subscriptionId}/regeneratePrimaryKey")
@doc("Regenerate subscription primary key.")
@post
op RegenerateUserSubscriptionPrimaryKey(
  ...UserParams,
  ...CommonParams
): NoContentResponse | ErrorResponse;

@route("/users/{userId}/subscriptions/{subscriptionId}/regenerateSecondaryKey")
@doc("Regenerate subscription secondary key.")
@post
op RegenerateUserSubscriptionSecondaryKey(
  ...UserParams,
  ...CommonParams
): NoContentResponse | ErrorResponse;

model CommonParams {
  @path subscriptionId: string;
}
