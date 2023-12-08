import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./HciCluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Hci;
@doc("Update details")
@parentResource(HciCluster)
model Update is ProxyResource<UpdateProperties> {
  @doc("The name of the Update")
  @path
  @key("updateName")
  @segment("updates")
  name: string;
}

@armResourceOperations
interface Updates {
  @doc("Get specified Update")
  get is ArmResourceRead<Update>;
  @doc("Put specified Update")
  put is ArmResourceCreateOrReplaceSync<Update>;
  @doc("Delete specified Update")
  delete is ArmResourceDeleteAsync<Update>;
  @doc("List all Updates")
  list is ArmResourceListByParent<Update>;
  @doc("Apply Update")
  post is ArmResourceActionAsync<Update, {}, {}>;
}
