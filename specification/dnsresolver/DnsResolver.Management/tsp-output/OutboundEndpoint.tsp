import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./DnsResolver.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.Network;
@doc("Describes an outbound endpoint for a DNS resolver.")
@parentResource(DnsResolver)
model OutboundEndpoint is TrackedResource<OutboundEndpointProperties> {
  @doc("The name of the outbound endpoint for the DNS resolver.")
  @path
  @key("outboundEndpointName")
  @segment("outboundEndpoints")
  name: string;
}

@armResourceOperations
interface OutboundEndpoints {
  @doc("Gets properties of an outbound endpoint for a DNS resolver.")
  get is ArmResourceRead<OutboundEndpoint>;
  @doc("Creates or updates an outbound endpoint for a DNS resolver.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    OutboundEndpoint,
    {
      ...BaseParameters<OutboundEndpoint>;

      @doc("ETag of the resource. Omit this value to always overwrite the current resource. Specify the last-seen ETag value to prevent accidentally overwriting any concurrent changes.")
      @header
      IfMatch?: string;

      @doc("Set to '*' to allow a new resource to be created, but to prevent updating an existing resource. Other values will be ignored.")
      @header
      IfNoneMatch?: string;
    }
  >;
  @doc("Updates an outbound endpoint for a DNS resolver.")
  update is ArmTagsPatchAsync<
    OutboundEndpoint,
    {
      ...BaseParameters<OutboundEndpoint>;

      @doc("ETag of the resource. Omit this value to always overwrite the current resource. Specify the last-seen ETag value to prevent accidentally overwriting any concurrent changes.")
      @header
      IfMatch?: string;
    }
  >;
  @doc("Deletes an outbound endpoint for a DNS resolver. WARNING: This operation cannot be undone.")
  delete is ArmResourceDeleteAsync<
    OutboundEndpoint,
    {
      ...BaseParameters<OutboundEndpoint>;

      @doc("ETag of the resource. Omit this value to always overwrite the current resource. Specify the last-seen ETag value to prevent accidentally overwriting any concurrent changes.")
      @header
      IfMatch?: string;
    }
  >;
  @doc("Lists outbound endpoints for a DNS resolver.")
  list is ArmResourceListByParent<
    OutboundEndpoint,
    {
      ...BaseParameters<OutboundEndpoint>;

      @doc("The maximum number of results to return. If not specified, returns up to 100 results.")
      @query("$top")
      $top?: int32;
    }
  >;
}
