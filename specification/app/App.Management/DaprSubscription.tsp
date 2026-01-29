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

@armResourceOperations
interface DaprSubscriptions {
  /**
   * Get a dapr subscription.
   */
  get is ArmResourceRead<DaprSubscription>;

  /**
   * Creates or updates a Dapr subscription in a Managed Environment.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<DaprSubscription>;

  /**
   * Delete a Dapr subscription from a Managed Environment.
   */
  delete is ArmResourceDeleteSync<DaprSubscription>;

  /**
   * Get the Dapr subscriptions for a managed environment.
   */
  list is ArmResourceListByParent<
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
