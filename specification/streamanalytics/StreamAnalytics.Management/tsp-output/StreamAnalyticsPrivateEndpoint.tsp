import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./StreamAnalyticsCluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.StreamAnalytics;
@doc("Complete information about the private endpoint.")
@parentResource(StreamAnalyticsCluster)
model StreamAnalyticsPrivateEndpoint
  is ProxyResource<PrivateEndpointProperties> {
  @doc("The name of the private endpoint.")
  @path
  @key("privateEndpointName")
  @segment("privateEndpoints")
  name: string;
}

@armResourceOperations
interface StreamAnalyticsPrivateEndpoints {
  @doc("Gets information about the specified Private Endpoint.")
  get is ArmResourceRead<StreamAnalyticsPrivateEndpoint>;
  @doc("Creates a Stream Analytics Private Endpoint or replaces an already existing Private Endpoint.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    StreamAnalyticsPrivateEndpoint,
    {
      ...BaseParameters<StreamAnalyticsPrivateEndpoint>;

      @doc("The ETag of the resource. Omit this value to always overwrite the current record set. Specify the last-seen ETag value to prevent accidentally overwriting concurrent changes.")
      @header
      `If-Match`?: string;

      @doc("Set to '*' to allow a new resource to be created, but to prevent updating an existing record set. Other values will result in a 412 Pre-condition Failed response.")
      @header
      `If-None-Match`?: string;
    }
  >;
  @doc("Delete the specified private endpoint.")
  delete is ArmResourceDeleteAsync<StreamAnalyticsPrivateEndpoint>;
  @doc("Lists the private endpoints in the cluster.")
  listByCluster is ArmResourceListByParent<StreamAnalyticsPrivateEndpoint>;
}
