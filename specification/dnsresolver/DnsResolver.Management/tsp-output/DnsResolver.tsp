import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.Network;
@doc("Describes a DNS resolver.")
model DnsResolver is TrackedResource<DnsResolverProperties> {
  @doc("The name of the DNS resolver.")
  @path
  @key("dnsResolverName")
  @segment("dnsResolvers")
  name: string;
}

@armResourceOperations
interface DnsResolvers {
  @doc("Gets properties of a DNS resolver.")
  get is ArmResourceRead<DnsResolver>;
  @doc("Creates or updates a DNS resolver.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    DnsResolver,
    {
      ...BaseParameters<DnsResolver>;

      @doc("ETag of the resource. Omit this value to always overwrite the current resource. Specify the last-seen ETag value to prevent accidentally overwriting any concurrent changes.")
      @header
      IfMatch?: string;

      @doc("Set to '*' to allow a new resource to be created, but to prevent updating an existing resource. Other values will be ignored.")
      @header
      IfNoneMatch?: string;
    }
  >;
  @doc("Updates a DNS resolver.")
  update is ArmTagsPatchAsync<
    DnsResolver,
    {
      ...BaseParameters<DnsResolver>;

      @doc("ETag of the resource. Omit this value to always overwrite the current resource. Specify the last-seen ETag value to prevent accidentally overwriting any concurrent changes.")
      @header
      IfMatch?: string;
    }
  >;
  @doc("Deletes a DNS resolver. WARNING: This operation cannot be undone.")
  delete is ArmResourceDeleteAsync<
    DnsResolver,
    {
      ...BaseParameters<DnsResolver>;

      @doc("ETag of the resource. Omit this value to always overwrite the current resource. Specify the last-seen ETag value to prevent accidentally overwriting any concurrent changes.")
      @header
      IfMatch?: string;
    }
  >;
  @doc("Lists DNS resolvers within a resource group.")
  listByResourceGroup is ArmResourceListByParent<
    DnsResolver,
    {
      ...BaseParameters<DnsResolver>;

      @doc("The maximum number of results to return. If not specified, returns up to 100 results.")
      @query("$top")
      $top?: int32;
    }
  >;
  @doc("Lists DNS resolvers in all resource groups of a subscription.")
  list is ArmListBySubscription<DnsResolver>;
}
