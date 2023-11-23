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
@doc("Describes an inbound endpoint for a DNS resolver.")
@parentResource(DnsResolver)
model InboundEndpoint is TrackedResource<InboundEndpointProperties> {
  @doc("The name of the inbound endpoint for the DNS resolver.")
  @path
  @key("inboundEndpointName")
  @segment("inboundEndpoints")
  name: string;
}

@armResourceOperations
interface InboundEndpoints {
  @doc("Gets properties of an inbound endpoint for a DNS resolver.")
  get is ArmResourceRead<InboundEndpoint>;
  @doc("Creates or updates an inbound endpoint for a DNS resolver.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    InboundEndpoint,
    {
      ...BaseParameters<InboundEndpoint>;

      @doc("ETag of the resource. Omit this value to always overwrite the current resource. Specify the last-seen ETag value to prevent accidentally overwriting any concurrent changes.")
      @header
      IfMatch?: string;

      @doc("Set to '*' to allow a new resource to be created, but to prevent updating an existing resource. Other values will be ignored.")
      @header
      IfNoneMatch?: string;
    }
  >;
  @doc("Updates an inbound endpoint for a DNS resolver.")
  update is ArmTagsPatchAsync<
    InboundEndpoint,
    {
      ...BaseParameters<InboundEndpoint>;

      @doc("ETag of the resource. Omit this value to always overwrite the current resource. Specify the last-seen ETag value to prevent accidentally overwriting any concurrent changes.")
      @header
      IfMatch?: string;
    }
  >;
  @doc("Deletes an inbound endpoint for a DNS resolver. WARNING: This operation cannot be undone.")
  delete is ArmResourceDeleteAsync<
    InboundEndpoint,
    {
      ...BaseParameters<InboundEndpoint>;

      @doc("ETag of the resource. Omit this value to always overwrite the current resource. Specify the last-seen ETag value to prevent accidentally overwriting any concurrent changes.")
      @header
      IfMatch?: string;
    }
  >;
  @doc("Lists inbound endpoints for a DNS resolver.")
  list is ArmResourceListByParent<
    InboundEndpoint,
    {
      ...BaseParameters<InboundEndpoint>;

      @doc("The maximum number of results to return. If not specified, returns up to 100 results.")
      @query("$top")
      $top?: int32;
    }
  >;
}
