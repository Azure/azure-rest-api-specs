import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./EpicVirtualInstance.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Workloads;
/**
 * Define the Epic Shared Server Instance resource.
 */
@parentResource(EpicVirtualInstance)
model SharedServerInstance is TrackedResource<SharedServerProperties> {
  /**
   * Shared Services Instance resource name string modeled as parameter for auto generation to work correctly.
   */
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{0,78}[a-zA-Z0-9_]")
  @path
  @key("sharedInstanceName")
  @segment("sharedInstances")
  @visibility("read")
  name: string;
}

@armResourceOperations
interface SharedServerInstances {
  /**
   * Gets the Epic Shared Services Instance resource.
   */
  get is ArmResourceRead<SharedServerInstance>;

  /**
   * Creates the Epic Shared Services Instance resource. &lt;br&gt;&lt;br&gt;This will be used by service only. PUT operation on this resource by end user will return a Bad Request error.
   */
  create is ArmResourceCreateOrReplaceAsync<SharedServerInstance>;

  /**
   * Updates the Epic Shared Services Instance resource. &lt;br&gt;&lt;br&gt;This can be used to update tags on the resource.
   */
  @parameterVisibility
  update is ArmTagsPatchSync<SharedServerInstance>;

  /**
   * Deletes the Epic Shared Services Instance resource. &lt;br&gt;&lt;br&gt;This will be used by service only. Delete operation on this resource by end user will return a Bad Request error. You can delete the parent resource, which is the Virtual Instance for Epic solutions resource, using the delete operation on it.
   */
  delete is ArmResourceDeleteWithoutOkAsync<SharedServerInstance>;

  /**
   * Lists the Epic Shared Services Instance resource for the given Virtual Instance for Epic solutions resource.
   */
  listByEpicVirtualInstance is ArmResourceListByParent<SharedServerInstance>;
}
