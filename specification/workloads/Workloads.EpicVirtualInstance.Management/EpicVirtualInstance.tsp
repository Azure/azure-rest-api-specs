import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Workloads;
/**
 * Define the Virtual Instance for Epic solutions resource.
 */
model EpicVirtualInstance is TrackedResource<EpicVirtualInstanceProperties> {
  /**
   * The name of the Virtual Instances for Epic solutions resource
   */
  @pattern("^[a-zA-Z][a-zA-Z0-9_-]{2,23}")
  @path
  @key("epicVirtualInstanceName")
  @segment("epicVirtualInstances")
  @visibility(Lifecycle.Read)
  name: string;
}

@armResourceOperations
interface EpicVirtualInstances {
  /**
   * Gets a Virtual Instance for Epic solutions resource
   */
  get is ArmResourceRead<EpicVirtualInstance>;

  /**
   * Creates a Virtual Instance for Epic solutions (VIS) resource
   */
  create is ArmResourceCreateOrReplaceAsync<EpicVirtualInstance>;

  /**
   * Updates a Virtual Instance for Epic solutions resource
   */
  @patch(#{ implicitOptionality: false })
  update is ArmTagsPatchSync<EpicVirtualInstance>;

  /**
   * Deletes a Virtual Instance for Epic solutions resource and its child resources, that is the associated Wss Services Instance, HyperspaceWeb Server Instances and Database Instance.
   */
  delete is ArmResourceDeleteWithoutOkAsync<EpicVirtualInstance>;

  /**
   * Gets all Virtual Instances for Epic solution resources in a Resource Group.
   */
  @list
  listByResourceGroup is ArmResourceListByParent<EpicVirtualInstance>;

  /**
   * Gets all Virtual Instances for Epic solutions resources in a Subscription.
   */
  @list
  listBySubscription is ArmListBySubscription<EpicVirtualInstance>;
}
