import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.NotificationHubs;
@doc("Description of a Namespace resource.")
model NamespaceResource is TrackedResource<NamespaceProperties> {
  @doc("The namespace name.")
  @path
  @key("namespaceName")
  @segment("namespaces")
  name: string;
}

@armResourceOperations
interface NamespaceResources {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Returns the description for the specified namespace.")
  @operationId("Namespaces_Get")
  get is ArmResourceRead<NamespaceResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Creates/Updates a service namespace. Once created, this namespace's resource manifest is immutable. This operation is idempotent.")
  @operationId("Namespaces_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<NamespaceResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Patches the existing namespace")
  @operationId("Namespaces_Patch")
  patch is ArmCustomPatchSync<NamespaceResource, NamespacePatchParameters>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deletes an existing namespace. This operation also removes all associated notificationHubs under the namespace.")
  @operationId("Namespaces_Delete")
  delete is ArmResourceDeleteAsync<NamespaceResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Lists the available namespaces within a resourceGroup.")
  @operationId("Namespaces_List")
  list is ArmResourceListByParent<NamespaceResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Lists all the available namespaces within the subscription irrespective of the resourceGroups.")
  @operationId("Namespaces_ListAll")
  listAll is ArmListBySubscription<NamespaceResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Checks the availability of the given notificationHub in a namespace.")
  @operationId("NotificationHubs_CheckNotificationHubAvailability")
  checkNotificationHubAvailability is ArmResourceActionSync<
    NamespaceResource,
    CheckAvailabilityParameters,
    CheckAvailabilityResult
  >;
}

@@projectedName(NamespaceResources.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(NamespaceResources.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(NamespaceResources.createOrUpdate::parameters.resource,
  "Parameters supplied to create a Namespace Resource."
);
@@projectedName(NamespaceResources.patch::parameters.properties,
  "json",
  "parameters"
);
@@extension(NamespaceResources.patch::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(NamespaceResources.patch::parameters.properties,
  "Parameters supplied to patch a Namespace Resource."
);
@@projectedName(NamespaceResources.checkNotificationHubAvailability::parameters.body,
  "json",
  "parameters"
);
@@extension(NamespaceResources.checkNotificationHubAvailability::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@doc(NamespaceResources.checkNotificationHubAvailability::parameters.body,
  "The notificationHub name."
);
