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
 * Define the Epic WSS server Instance resource.
 */
@parentResource(EpicVirtualInstance)
model WssServerInstance is TrackedResource<WssServerProperties> {
  /**
   * Wss Services Instance resource name string modeled as parameter for auto generation to work correctly.
   */
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{0,78}[a-zA-Z0-9_]")
  @path
  @key("wssInstanceName")
  @segment("wssInstances")
  @visibility(Lifecycle.Read)
  name: string;
}

@armResourceOperations
interface WssServerInstances {
  /**
   * Gets the Epic WSS server Instance resource.
   */
  get is ArmResourceRead<WssServerInstance>;

  /**
   * Creates the Epic WSS server Instance resource. &lt;br&gt;&lt;br&gt;This will be used by service only. PUT operation on this resource by end user will return a Bad Request error.
   */
  create is ArmResourceCreateOrReplaceAsync<WssServerInstance>;

  /**
   * Updates the Epic WSS server Instance resource. &lt;br&gt;&lt;br&gt;This can be used to update tags on the resource.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmTagsPatchSync<WssServerInstance>;

  /**
   * Deletes the Epic WSS server Instance resource. &lt;br&gt;&lt;br&gt;This will be used by service only. Delete operation on this resource by end user will return a Bad Request error. You can delete the parent resource, which is the Virtual Instance for Epic solutions resource, using the delete operation on it.
   */
  delete is ArmResourceDeleteWithoutOkAsync<WssServerInstance>;

  /**
   * Lists the Epic WSS server Instance resource for the given Virtual Instance for Epic solutions resource.
   */
  @list
  listByEpicVirtualInstance is ArmResourceListByParent<WssServerInstance>;
}
