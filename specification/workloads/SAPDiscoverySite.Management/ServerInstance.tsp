import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./SAPInstance.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Workloads;
/**
 * Define the Server Instance resource.
 */
@parentResource(SAPInstance)
model ServerInstance is ProxyResource<ServerInstanceProperties> {
  /**
   * The name of the Server instance resource for SAP Migration.
   */
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{0,78}[a-zA-Z0-9_]$")
  @path
  @key("serverInstanceName")
  @segment("serverInstances")
  @visibility("read")
  name: string;
}

@armResourceOperations
interface ServerInstances {
  /**
   * Gets the Server Instance resource.
   */
  get is ArmResourceRead<ServerInstance>;

  /**
   * Creates the Server Instance resource. <br><br>;This will be used by service only. PUT operation on this resource by end user will return a Bad Request error.
   */
  create is ArmResourceCreateOrReplaceAsync<ServerInstance>;

  /**
   * Updates the Server Instance resource. This operation on a resource by end user will return a Bad Request error.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchSync<ServerInstance, UpdateServerInstanceRequest>;

  /**
   * Deletes the Server Instance resource. <br><br>;This will be used by service only. Delete operation on this resource by end user will return a Bad Request error. You can delete the parent resource, which is the SAP Migration discovery site resource, using the delete operation on it.
   */
  #suppress "deprecated" "Existing API"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "Existing API"
  delete is ArmResourceDeleteAsync<ServerInstance>;

  /**
   * Lists the Server Instance resources for the given SAP Instance resource.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Supporting existing name."
  list is ArmResourceListByParent<ServerInstance>;
}
