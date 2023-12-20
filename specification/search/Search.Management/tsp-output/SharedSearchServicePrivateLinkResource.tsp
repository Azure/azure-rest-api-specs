import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./SearchService.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Search;
@doc("Describes a Shared Private Link Resource managed by the Azure Cognitive Search service.")
@parentResource(SearchService)
model SharedSearchServicePrivateLinkResource
  is ProxyResource<SharedPrivateLinkResourceProperties> {
  @doc("The name of the shared private link resource managed by the Azure Cognitive Search service within the specified resource group.")
  @path
  @key("sharedPrivateLinkResourceName")
  @segment("sharedPrivateLinkResources")
  name: string;
}

@armResourceOperations
interface SharedSearchServicePrivateLinkResources {
  @doc("Gets the details of the shared private link resource managed by the search service in the given resource group.")
  get is ArmResourceRead<
    SharedSearchServicePrivateLinkResource,
    {
      ...BaseParameters<SharedSearchServicePrivateLinkResource>;

      @doc("A client-generated GUID value that identifies this request. If specified, this will be included in response information as a way to track the request.")
      @header
      clientRequestId?: string;
    }
  >;
  @doc("Initiates the creation or update of a shared private link resource managed by the search service in the given resource group.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    SharedSearchServicePrivateLinkResource,
    {
      ...BaseParameters<SharedSearchServicePrivateLinkResource>;

      @doc("A client-generated GUID value that identifies this request. If specified, this will be included in response information as a way to track the request.")
      @header
      clientRequestId?: string;
    }
  >;
  @doc("Initiates the deletion of the shared private link resource from the search service.")
  delete is ArmResourceDeleteWithoutOkAsync<
    SharedSearchServicePrivateLinkResource,
    {
      ...BaseParameters<SharedSearchServicePrivateLinkResource>;

      @doc("A client-generated GUID value that identifies this request. If specified, this will be included in response information as a way to track the request.")
      @header
      clientRequestId?: string;
    }
  >;
  @doc("Gets a list of all shared private link resources managed by the given service.")
  listByService is ArmResourceListByParent<
    SharedSearchServicePrivateLinkResource,
    {
      ...BaseParameters<SharedSearchServicePrivateLinkResource>;

      @doc("A client-generated GUID value that identifies this request. If specified, this will be included in response information as a way to track the request.")
      @header
      clientRequestId?: string;
    }
  >;
}
