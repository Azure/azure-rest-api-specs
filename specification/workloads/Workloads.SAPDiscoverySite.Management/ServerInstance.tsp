using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

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
  @visibility(Lifecycle.Read)
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
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  create is ArmResourceCreateOrReplaceAsync<
    ServerInstance,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Updates the Server Instance resource. This operation on a resource by end user will return a Bad Request error.
   */
  @patch(#{ implicitOptionality: false })
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
  ListBySapInstance is ArmResourceListByParent<ServerInstance>;
}
