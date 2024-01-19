import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./BatchAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Batch;
@doc("Contains information about a private link resource.")
@parentResource(BatchAccount)
model PrivateLinkResource is ProxyResource<PrivateLinkResourceProperties> {
  @doc("The private link resource name. This must be unique within the account.")
  @maxLength(101)
  @minLength(1)
  @pattern("^[a-zA-Z0-9_-]+\\.?[a-fA-F0-9-]*$")
  @path
  @key("privateLinkResourceName")
  @segment("privateLinkResources")
  name: string;
}

@armResourceOperations
interface PrivateLinkResources {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets information about the specified private link resource.")
  @operationId("PrivateLinkResource_Get")
  get is ArmResourceRead<PrivateLinkResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Lists all of the private link resources in the specified account.")
  @operationId("PrivateLinkResource_ListByBatchAccount")
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
