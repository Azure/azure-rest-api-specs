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
 * Define the Database resource.
 */
@parentResource(EpicVirtualInstance)
model DatabaseServerInstance is TrackedResource<DatabaseServerProperties> {
  /**
   * Database resource name string modeled as parameter for auto generation to work correctly.
   */
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{0,78}[a-zA-Z0-9_]")
  @path
  @key("databaseInstanceName")
  @segment("databaseInstances")
  @visibility("read")
  name: string;
}

@armResourceOperations
interface DatabaseServerInstances {
  /**
   * Gets the Epic Database Instance resource.
   */
  get is ArmResourceRead<DatabaseServerInstance>;

  /**
   * Creates the Database resource corresponding to the Virtual Instance for Epic solutions resource. &lt;br&gt;&lt;br&gt;This will be used by service only. PUT by end user will return a Bad Request error.
   */
  create is ArmResourceCreateOrReplaceAsync<DatabaseServerInstance>;

  /**
   * Updates the Database resource.
   */
  @parameterVisibility
  update is ArmTagsPatchSync<DatabaseServerInstance>;

  /**
   * Deletes the Database resource corresponding to a Virtual Instance for Epic solutions resource. &lt;br&gt;&lt;br&gt;This will be used by service only. Delete by end user will return a Bad Request error.
   */
  delete is ArmResourceDeleteWithoutOkAsync<DatabaseServerInstance>;

  /**
   * Lists the Database resources associated with a Virtual Instance for Epic solutions resource.
   */
  listByEpicVirtualInstance is ArmResourceListByParent<DatabaseServerInstance>;
}
