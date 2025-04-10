import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Cluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.StreamAnalytics;
/**
 * Complete information about the private endpoint.
 */
@parentResource(Cluster)
model PrivateEndpoint
  is Azure.ResourceManager.ProxyResource<PrivateEndpointProperties> {
  ...ResourceNameParameter<
    Resource = PrivateEndpoint,
    KeyName = "privateEndpointName",
    SegmentName = "privateEndpoints",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.EntityTagProperty;
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
    Parameters = {
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    PrivateEndpoint,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Lists the private endpoints in the cluster.
   */
  listByCluster is ArmResourceListByParent<PrivateEndpoint>;
}

@@doc(PrivateEndpoint.name, "The name of the private endpoint.");
@@encodedName(PrivateEndpoint.eTag, "application/json", "etag");
@@doc(PrivateEndpoint.properties,
  "The properties associated with a private endpoint."
);
@@doc(PrivateEndpoints.createOrUpdate::parameters.resource,
  "The definition of the private endpoint that will be used to create a new cluster or replace the existing one."
);
