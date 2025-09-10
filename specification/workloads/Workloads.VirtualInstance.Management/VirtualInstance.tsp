import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Workloads;
/**
 * Defines the Virtual Instance (VI) resource.
 */
model VirtualInstance is TrackedResource<VirtualInstanceProperties> {
  ...ResourceNameParameter<
    Resource = VirtualInstance,
    KeyName = "virtualInstanceName",
    SegmentName = "virtualInstances",
    NamePattern = "^[a-zA-Z0-9-_]{3,64}$"
  >;
  ...ManagedServiceIdentityProperty;
  ...ResourceKindProperty;
}

@armResourceOperations
interface VirtualInstances {
  /**
   * Gets a Virtual Instance resource
   */
  get is ArmResourceRead<VirtualInstance>;

  /**
   * Creates a Virtual Instance resource
   */
  create is ArmResourceCreateOrReplaceAsync<VirtualInstance>;

  /**
   * Updates a Virtual Instance resource
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<VirtualInstance, UpdateVirtualInstanceRequest>;

  /**
   * Deletes a Virtual Instance resource.
   */
  delete is ArmResourceDeleteWithoutOkAsync<VirtualInstance>;

  /**
   * Gets all Virtual Instance resources in a Resource Group.
   */
  @list
  listByResourceGroup is ArmResourceListByParent<VirtualInstance>;

  /**
   * Gets all Virtual Instance resources in a Subscription.
   */
  @list
  listBySubscription is ArmListBySubscription<VirtualInstance>;
}

@@doc(VirtualInstance.name, "The name of the Virtual Instance resource");
@@doc(VirtualInstances.create::parameters.resource,
  "Request body to create the Virtual Instance resource."
);
@@doc(VirtualInstances.update::parameters.properties,
  "Request body to update the Virtual Instance resource."
);
