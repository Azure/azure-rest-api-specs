import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Cluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.HDInsight;
/**
 * The private endpoint connection.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Cluster)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(
  PrivateEndpointConnectionProperties
)
model PrivateEndpointConnection extends ProxyResourceBase {
  /**
   * The name of the private endpoint connection.
   */
  @path
  @key("privateEndpointConnectionName")
  @segment("privateEndpointConnections")
  @visibility("read")
  name: string;

  /**
   * The private endpoint connection properties.
   */
  @extension("x-ms-client-flatten", true)
  properties: PrivateEndpointConnectionProperties;
}

@armResourceOperations
interface PrivateEndpointConnections {
  /**
   * Gets the specific private endpoint connection.
   */
  get is ArmResourceRead<PrivateEndpointConnection>;

  /**
   * Approve or reject a private endpoint connection manually.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    PrivateEndpointConnection,
    BaseParameters<PrivateEndpointConnection>,
    ArmAsyncOperationHeader
  >;

  /**
   * Deletes the specific private endpoint connection.
   */
  delete is ArmResourceDeleteAsync<
    PrivateEndpointConnection,
    BaseParameters<PrivateEndpointConnection>,
    ArmAsyncOperationHeader
  >;

  /**
   * Lists the private endpoint connections for a HDInsight cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateEndpointConnections_ListByCluster")
  listByCluster is ArmResourceListByParent<PrivateEndpointConnection>;
}

@@projectedName(PrivateEndpointConnections.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(PrivateEndpointConnections.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(PrivateEndpointConnections.createOrUpdate::parameters.resource,
  "The private endpoint connection create or update request."
);
