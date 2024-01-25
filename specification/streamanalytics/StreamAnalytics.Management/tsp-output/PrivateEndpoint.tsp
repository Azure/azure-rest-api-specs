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

namespace Microsoft.StreamAnalytics;
/**
 * Complete information about the private endpoint.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Cluster)
@includeInapplicableMetadataInPayload(false)
model PrivateEndpoint extends ProxyResource {
  /**
   * The name of the private endpoint.
   */
  @path
  @key("privateEndpointName")
  @segment("privateEndpoints")
  @visibility("read")
  name: string;

  /**
   * Unique opaque string (generally a GUID) that represents the metadata state of the resource (private endpoint) and changes whenever the resource is updated. Required on PUT (CreateOrUpdate) requests.
   */
  @visibility("read")
  etag?: string;

  /**
   * The properties associated with a private endpoint.
   */
  @extension("x-ms-client-flatten", true)
  properties?: PrivateEndpointProperties;
}

@armResourceOperations
interface PrivateEndpoints {
  /**
   * Gets information about the specified Private Endpoint.
   */
  get is ArmResourceRead<PrivateEndpoint>;

  /**
   * Creates a Stream Analytics Private Endpoint or replaces an already existing Private Endpoint.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    PrivateEndpoint,
    {
      ...BaseParameters<PrivateEndpoint>;

      /**
       * The ETag of the resource. Omit this value to always overwrite the current record set. Specify the last-seen ETag value to prevent accidentally overwriting concurrent changes.
       */
      @header
      `If-Match`?: string;

      /**
       * Set to '*' to allow a new resource to be created, but to prevent updating an existing record set. Other values will result in a 412 Pre-condition Failed response.
       */
      @header
      `If-None-Match`?: string;
    }
  >;

  /**
   * Delete the specified private endpoint.
   */
  delete is ArmResourceDeleteAsync<PrivateEndpoint>;

  /**
   * Lists the private endpoints in the cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateEndpoints_ListByCluster")
  listByCluster is ArmResourceListByParent<PrivateEndpoint>;
}

@@projectedName(PrivateEndpoints.createOrUpdate::parameters.resource,
  "json",
  "privateEndpoint"
);
@@extension(PrivateEndpoints.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "privateEndpoint"
);
@@doc(PrivateEndpoints.createOrUpdate::parameters.resource,
  "The definition of the private endpoint that will be used to create a new cluster or replace the existing one."
);
