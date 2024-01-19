import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Cluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AzureStackHCI;
@doc("Update details")
@parentResource(Cluster)
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
  delete is ArmResourceDeleteAsync<
    Update,
    BaseParameters<Update>,
    ArmAsyncOperationHeader
  >;

  @doc("List all Updates")
  list is ArmResourceListByParent<Update>;

  @doc("Apply Update")
  post is ArmResourceActionAsync<
    Update,
    void,
    void,
    BaseParameters<Update>,
    ArmAsyncOperationHeader
  >;
}

@@projectedName(Updates.put::parameters.resource, "json", "updateProperties");
@@extension(Updates.put::parameters.resource,
  "x-ms-client-name",
  "updateProperties"
);
@@doc(Updates.put::parameters.resource, "Properties of the Updates object");
