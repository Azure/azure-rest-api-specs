import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./NotificationHubNamespace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.NotificationHubs;
@doc("Description of a NotificationHub Resource.")
@parentResource(NotificationHubNamespace)
model NotificationHub is TrackedResource<NotificationHubProperties> {
  @doc("The notification hub name.")
  @path
  @key("notificationHubName")
  @segment("notificationHubs")
  name: string;
}

@armResourceOperations
interface NotificationHubs {
  @doc("Lists the notification hubs associated with a namespace.")
  get is ArmResourceRead<NotificationHub>;
  @doc("Creates/Update a NotificationHub in a namespace.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<NotificationHub>;
  @doc("Patch a NotificationHub in a namespace.")
  patch is ArmResourcePatchSync<NotificationHub, NotificationHubProperties>;
  @doc("Deletes a notification hub associated with a namespace.")
  delete is ArmResourceDeleteSync<NotificationHub>;
  @doc("Lists the notification hubs associated with a namespace.")
  list is ArmResourceListByParent<NotificationHub>;
  @doc("test send a push notification")
  debugSend is ArmResourceActionNoContentSync<NotificationHub, Record<unknown>>;
  @doc("Lists the PNS Credentials associated with a notification hub .")
  getPnsCredentials is ArmResourceActionSync<
    NotificationHub,
    {},
    PnsCredentialsResource
  >;
}
