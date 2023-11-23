import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./NamespaceResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.NotificationHubs;
@doc("Description of a NotificationHub Resource.")
@parentResource(NamespaceResource)
model NotificationHubResource is TrackedResource<NotificationHubProperties> {
  @doc("The notification hub name.")
  @path
  @key("notificationHubName")
  @segment("notificationHubs")
  name: string;
}

@armResourceOperations
interface NotificationHubResources {
  @doc("Lists the notification hubs associated with a namespace.")
  get is ArmResourceRead<NotificationHubResource>;
  @doc("Creates/Update a NotificationHub in a namespace.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<NotificationHubResource>;
  @doc("Patch a NotificationHub in a namespace.")
  patch is ArmResourcePatchSync<
    NotificationHubResource,
    NotificationHubProperties
  >;
  @doc("Deletes a notification hub associated with a namespace.")
  delete is ArmResourceDeleteSync<NotificationHubResource>;
  @doc("Lists the notification hubs associated with a namespace.")
  list is ArmResourceListByParent<NotificationHubResource>;
  @doc("test send a push notification")
  debugSend is ArmResourceActionNoContentSync<
    NotificationHubResource,
    Record<unknown>
  >;
  @doc("Lists the PNS Credentials associated with a notification hub .")
  getPnsCredentials is ArmResourceActionSync<
    NotificationHubResource,
    {},
    PnsCredentialsResource
  >;
}
