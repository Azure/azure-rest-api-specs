import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "../../models/common.tsp";
import "../../models/subscription.tsp";

using TypeSpec.Http;
using Azure.Core;
using DeveloperServicesApi.Models;

namespace DeveloperServicesAuthorizedApi.Routes.Subscriptions;

@route("/users/{userId}/subscriptions")
@doc("List a collection of user subscriptions.")
@get
op ListUserSubscriptions(
  ...UserParams,
  ...ListParams
): ApiResponse<Page<Subscription>>;

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

  @doc("User subscription create model.")
  @body
  userSubscriptionCreate: UserSubscriptionCreate
): NoContentResponse | ErrorResponse;

@route("/users/{userId}/subscriptions/{subscriptionId}")
@doc("Update user subscription.")
@patch
op UpdateUserSubscription(
  ...UserParams,
  ...CommonParams,

  @doc("User subscription update model.")
  @body
  userSubscriptionUpdate: UserSubscriptionUpdate
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

@doc("Common parameters.")
model CommonParams {
  @doc("Subscription identifier.")
  @path
  subscriptionId: string;
}
