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
@doc("Complete information about the private endpoint.")
@parentResource(Cluster)
model PrivateEndpoint is ProxyResource<PrivateEndpointProperties> {
  @doc("The name of the private endpoint.")
  @path
  @key("privateEndpointName")
  @segment("privateEndpoints")
  name: string;

  @doc("Unique opaque string (generally a GUID) that represents the metadata state of the resource (private endpoint) and changes whenever the resource is updated. Required on PUT (CreateOrUpdate) requests.")
  @visibility("read")
  etag?: string;
}

@armResourceOperations
interface PrivateEndpoints {
  @doc("Gets information about the specified Private Endpoint.")
  get is ArmResourceRead<PrivateEndpoint>;

  @doc("Creates a Stream Analytics Private Endpoint or replaces an already existing Private Endpoint.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    PrivateEndpoint,
    {
      ...BaseParameters<PrivateEndpoint>;

      @doc("The ETag of the resource. Omit this value to always overwrite the current record set. Specify the last-seen ETag value to prevent accidentally overwriting concurrent changes.")
      @header
      `If-Match`?: string;

      @doc("Set to '*' to allow a new resource to be created, but to prevent updating an existing record set. Other values will result in a 412 Pre-condition Failed response.")
      @header
      `If-None-Match`?: string;
    }
  >;

  @doc("Delete the specified private endpoint.")
  delete is ArmResourceDeleteAsync<PrivateEndpoint>;

  @doc("Lists the private endpoints in the cluster.")
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
