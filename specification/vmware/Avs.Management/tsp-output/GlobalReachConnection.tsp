import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./PrivateCloud.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AVS;
/**
 * A global reach connection resource
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(PrivateCloud)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(
  GlobalReachConnectionProperties
)
model GlobalReachConnection extends ProxyResourceBase {
  /**
   * Name of the global reach connection in the private cloud
   */
  @pattern("^[-\\w\\._]+$")
  @path
  @key("globalReachConnectionName")
  @segment("globalReachConnections")
  @visibility("read")
  name: string;

  /**
   * The properties of a global reach connection resource
   */
  @extension("x-ms-client-flatten", true)
  properties?: GlobalReachConnectionProperties;
}

@armResourceOperations
interface GlobalReachConnections {
  /**
   * Get a global reach connection by name in a private cloud
   */
  get is ArmResourceRead<GlobalReachConnection>;

  /**
   * Create or update a global reach connection in a private cloud
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<GlobalReachConnection>;

  /**
   * Delete a global reach connection in a private cloud
   */
  delete is ArmResourceDeleteAsync<GlobalReachConnection>;

  /**
   * List global reach connections in a private cloud
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("GlobalReachConnections_List")
  list is ArmResourceListByParent<GlobalReachConnection>;
}

@@projectedName(GlobalReachConnections.createOrUpdate::parameters.resource,
  "json",
  "globalReachConnection"
);
@@extension(GlobalReachConnections.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "globalReachConnection"
);
@@doc(GlobalReachConnections.createOrUpdate::parameters.resource,
  "A global reach connection in the private cloud"
);
