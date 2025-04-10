import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./PrivateCloud.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AVS;
/**
 * A global reach connection resource
 */
@parentResource(PrivateCloud)
model GlobalReachConnection
  is Azure.ResourceManager.ProxyResource<GlobalReachConnectionProperties> {
  ...ResourceNameParameter<
    Resource = GlobalReachConnection,
    KeyName = "globalReachConnectionName",
    SegmentName = "globalReachConnections",
    NamePattern = "^[-\\w\\._]+$"
  >;
}

@armResourceOperations
interface GlobalReachConnections {
  /**
   * Get a GlobalReachConnection
   */
  get is ArmResourceRead<GlobalReachConnection>;

  /**
   * Create a GlobalReachConnection
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<GlobalReachConnection>;

  /**
   * Delete a GlobalReachConnection
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    GlobalReachConnection,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List GlobalReachConnection resources by PrivateCloud
   */
  list is ArmResourceListByParent<
    GlobalReachConnection,
    Response = ArmResponse<GlobalReachConnectionList>
  >;
}

@@doc(GlobalReachConnection.name, "Name of the global reach connection");
@@doc(GlobalReachConnection.properties,
  "The resource-specific properties for this resource."
);
