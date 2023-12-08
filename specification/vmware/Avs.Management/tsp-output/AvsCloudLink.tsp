import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./AvsPrivateCloud.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Avs;
@doc("A cloud link resource")
@parentResource(AvsPrivateCloud)
model AvsCloudLink is ProxyResource<CloudLinkProperties> {
  @doc("Name of the cloud link resource")
  @path
  @key("cloudLinkName")
  @segment("cloudLinks")
  name: string;
}

@armResourceOperations
interface AvsCloudLinks {
  @doc("Get an cloud link by name in a private cloud")
  get is ArmResourceRead<AvsCloudLink>;
  @doc("Create or update a cloud link in a private cloud")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<AvsCloudLink>;
  @doc("Delete a cloud link in a private cloud")
  delete is ArmResourceDeleteAsync<AvsCloudLink>;
  @doc("List cloud link in a private cloud")
  list is ArmResourceListByParent<AvsCloudLink>;
}
