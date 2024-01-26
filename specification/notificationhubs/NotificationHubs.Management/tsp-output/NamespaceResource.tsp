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
/**
 * Description of a Namespace resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@includeInapplicableMetadataInPayload(false)
model NamespaceResource extends Resource {
  /**
   * The namespace name.
   */
  @path
  @key("namespaceName")
  @segment("namespaces")
  @visibility("read")
  name: string;

  /**
   * Properties of the Namespace.
   */
  @extension("x-ms-client-flatten", true)
  properties?: NamespaceProperties;
}

@armResourceOperations
interface NamespaceResources {
  /**
   * Returns the description for the specified namespace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Namespaces_Get")
  get is ArmResourceRead<NamespaceResource>;

  /**
   * Creates/Updates a service namespace. Once created, this namespace's resource manifest is immutable. This operation is idempotent.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Namespaces_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<NamespaceResource>;

  /**
   * Patches the existing namespace
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("Namespaces_Patch")
  patch is ArmCustomPatchSync<NamespaceResource, NamespacePatchParameters>;

  /**
   * Deletes an existing namespace. This operation also removes all associated notificationHubs under the namespace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Namespaces_Delete")
  delete is ArmResourceDeleteAsync<NamespaceResource>;

  /**
   * Lists the available namespaces within a resourceGroup.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Namespaces_List")
  list is ArmResourceListByParent<NamespaceResource>;

  /**
   * Lists all the available namespaces within the subscription irrespective of the resourceGroups.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Namespaces_ListAll")
  listAll is ArmListBySubscription<NamespaceResource>;

  /**
   * Checks the availability of the given notificationHub in a namespace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
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
