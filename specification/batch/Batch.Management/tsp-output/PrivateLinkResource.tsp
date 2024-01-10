import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./BatchAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.Batch;
@doc("Contains information about a private link resource.")
@parentResource(BatchAccount)
model PrivateLinkResource is ProxyResource<PrivateLinkResourceProperties> {
  @doc("The private link resource name. This must be unique within the account.")
  @maxLength(101)
  @minLength(1)
  @pattern("^[a-zA-Z0-9_-]+\\.?[a-fA-F0-9-]*$")
  @key("privateLinkResourceName")
  @segment("privateLinkResources")
  name: string;
}

@armResourceOperations
@projectedName("client", "PrivateLinkResource")
interface PrivateLinkResources_PrivateLinkResource {
  @doc("Gets information about the specified private link resource.")
  get is ArmResourceRead<PrivateLinkResource>;

  @doc("Lists all of the private link resources in the specified account.")
  listByBatchAccount is ArmResourceListByParent<
    PrivateLinkResource,
    {
      ...BaseParameters<PrivateLinkResource>;

      @doc("The maximum number of items to return in the response.")
      @query("maxresults")
      maxresults?: int32;
    }
  >;
}
