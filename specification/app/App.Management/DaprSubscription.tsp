import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedEnvironment.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.App;
/**
 * Dapr PubSub Event Subscription.
 */
@parentResource(ManagedEnvironment)
model DaprSubscription
  is Azure.ResourceManager.ProxyResource<DaprSubscriptionProperties> {
  ...ResourceNameParameter<
    Resource = DaprSubscription,
    KeyName = "name",
    SegmentName = "daprSubscriptions",
    NamePattern = ""
  >;
}

alias DaprSubscriptionOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** Name of the managed environment. */
    @path
    @segment("managedEnvironments")
    @key
    @pattern("^[-\\w\\._\\(\\)]+$")
    environmentName: string;
  },
  {
    /** Name of the Dapr Subscription. */
    @path
    @segment("daprSubscriptions")
    @key
    name: string;
  },
  ErrorType = DefaultErrorResponse
>;

@armResourceOperations
interface DaprSubscriptions {
  /**
   * Get a dapr subscription.
   */
  @summary("Get a dapr subscription.")
  get is DaprSubscriptionOps.Read<DaprSubscription>;

  /**
   * Creates or updates a Dapr subscription in a Managed Environment.
   */
  @summary("Creates or updates a Dapr subscription.")
  createOrUpdate is DaprSubscriptionOps.CreateOrUpdateSync<DaprSubscription>;

  /**
   * Delete a Dapr subscription from a Managed Environment.
   */
  @summary("Creates or updates a Dapr subscription.")
  delete is DaprSubscriptionOps.DeleteSync<DaprSubscription>;

  /**
   * Get the Dapr subscriptions for a managed environment.
   */
  @summary("Get the Dapr subscriptions for a managed environment.")
  list is DaprSubscriptionOps.List<
    DaprSubscription,
    Response = ArmResponse<DaprSubscriptionsCollection>
  >;
}

@@doc(DaprSubscription.name, "Name of the Dapr subscription.");
@@doc(DaprSubscription.properties,
  "Dapr PubSub Event Subscription resource specific properties"
);
@@doc(DaprSubscriptions.createOrUpdate::parameters.resource,
  "Configuration details of the Dapr subscription."
);
