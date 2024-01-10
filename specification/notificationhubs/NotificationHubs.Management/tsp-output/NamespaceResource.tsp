import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.NotificationHubs;
@doc("Description of a Namespace resource.")
model NamespaceResource is TrackedResource<NamespaceProperties> {
  @doc("The namespace name.")
  @key("namespaceName")
  @segment("namespaces")
  name: string;
}

@armResourceOperations
@projectedName("client", "Namespaces")
interface NamespaceResources_Namespaces {
  @doc("Returns the description for the specified namespace.")
  get is ArmResourceRead<NamespaceResource>;

  @doc("Creates/Updates a service namespace. Once created, this namespace's resource manifest is immutable. This operation is idempotent.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<NamespaceResource>;

  @doc("Patches the existing namespace")
  patch is ArmCustomPatchSync<NamespaceResource, NamespacePatchParameters>;

  @doc("Deletes an existing namespace. This operation also removes all associated notificationHubs under the namespace.")
  delete is ArmResourceDeleteAsync<NamespaceResource>;

  @doc("Lists the available namespaces within a resourceGroup.")
  list is ArmResourceListByParent<NamespaceResource>;

  @doc("Lists all the available namespaces within the subscription irrespective of the resourceGroups.")
  listAll is ArmListBySubscription<NamespaceResource>;
}

@armResourceOperations
@projectedName("client", "NotificationHubs")
interface NamespaceResources_NotificationHubs {
  @doc("Checks the availability of the given notificationHub in a namespace.")
  checkNotificationHubAvailability is ArmResourceActionSync<
    NamespaceResource,
    CheckAvailabilityParameters,
    CheckAvailabilityResult
  >;
}
