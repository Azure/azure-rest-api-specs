import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "../../models/common.tsp";
import "../../models/subscription.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;
using Azure.Core.Traits;
using DeveloperServicesApi.Models;
using DeveloperServicesAuthorizedApi.Common;

namespace DeveloperServicesAuthorizedApi.Resources.Subscriptions;

interface Subscriptions {
  @doc("List a collection of user subscriptions.")
  listUserSubscriptions is ResourceList<
    SubscriptionResource,
    ListQueryParametersTrait<DefaultListQueryParameters>
  >;

  @doc("Get user subscription by its identifier.")
  getUserSubscription is ResourceRead<SubscriptionResource>;

  //TODO: find a workaround
  @route("/users/{userId}/subscriptions/{subscriptionId}")
  @doc("Create user subscription.")
  @post
  CreateUserSubscription(
    ...Azure.Core.Foundations.ApiVersionParameter,

    @doc("Subscription identifier.")
    @path
    subscriptionId: string,

    @doc("User identifier.")
    @path
    userId: string,

    @doc("User subscription create model.")
    @body
    userSubscriptionCreate: UserSubscriptionCreate
  ): NoContentResponse | Azure.Core.Foundations.ErrorResponse;

  //TODO: It returns the body
  @route("/users/{userId}/subscriptions/{subscriptionId}")
  @doc("Update user subscription.")
  @patch
  UpdateUserSubscription(
    ...Azure.Core.Foundations.ApiVersionParameter,

    @doc("Subscription identifier.")
    @path
    subscriptionId: string,

    @doc("User identifier.")
    @path
    userId: string,

    @doc("User subscription update model.")
    @body
    userSubscriptionUpdate: UserSubscriptionUpdate
  ): NoContentResponse | Azure.Core.Foundations.ErrorResponse;

  @route("/users/{userId}/subscriptions/{subscriptionId}/regeneratePrimaryKey")
  @doc("Regenerate subscription primary key.")
  @post
  RegenerateUserSubscriptionPrimaryKey(
    ...Azure.Core.Foundations.ApiVersionParameter,

    @doc("Subscription identifier.")
    @path
    subscriptionId: string,

    @doc("User identifier.")
    @path
    userId: string
  ): NoContentResponse | Azure.Core.Foundations.ErrorResponse;

  @route("/users/{userId}/subscriptions/{subscriptionId}/regenerateSecondaryKey")
  @doc("Regenerate subscription secondary key.")
  @post
  RegenerateUserSubscriptionSecondaryKey(
    ...Azure.Core.Foundations.ApiVersionParameter,

    @doc("Subscription identifier.")
    @path
    subscriptionId: string,

    @doc("User identifier.")
    @path
    userId: string
  ): NoContentResponse | Azure.Core.Foundations.ErrorResponse;
}

@doc("Subscription resource model.")
@resource("subscriptions")
@parentResource(UserResource)
model SubscriptionResource extends Subscription {
  @doc("Subscription identifier.")
  @key("subscriptionId")
  @visibility("query")
  subscriptionId: string;
}
