import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@armProviderNamespace
@service({
  title: "EdgeMarketPlaceClient",
  version: "2023-04-01-preview",
})
@doc("Edge Market Place Resource Provider management API.")
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
namespace Microsoft.EdgeMarketPlace;


@doc("A publisher who provides offers.")
model Publisher is ExtensionResource<PublisherProperties> {
  @doc("Name of the publisher")
  @key("publisherName")
  @path
  @segment("publishers")
  name: string;
}

@doc("Publisher properties")
model PublisherProperties {
  
	@doc("The resource provisioning state")
  provisioningState: ResourceProvisioningState;
}

@armResourceOperations
interface Publishers
{
  list is ArmResourceListByParent<Publisher,Azure.ResourceManager.Foundations.BaseParameters<Publisher> &
			Azure.Core.StandardListQueryParameters &
			Azure.Core.FilterQueryParameter
	>;
  get is ArmResourceRead<Publisher>;
}
