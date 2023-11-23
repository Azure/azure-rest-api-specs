import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.HybridConnectivity;
@doc("The endpoint for the target resource.")
model EndpointResource is ExtensionResource<EndpointProperties> {
  @doc("The endpoint name.")
  @path
  @key("endpointName")
  @segment("endpoints")
  name: string;
}

@armResourceOperations
interface EndpointResources {
  @doc("Gets the endpoint to the resource.")
  get is ArmResourceRead<EndpointResource>;
  @doc("Create or update the endpoint to the target resource.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<EndpointResource>;
  @doc("Update the endpoint to the target resource.")
  update is ArmResourcePatchSync<EndpointResource, EndpointProperties>;
  @doc("Deletes the endpoint access to the target resource.")
  delete is ArmResourceDeleteSync<EndpointResource>;
  @doc("List of endpoints to the target resource.")
  list is ArmResourceListByParent<EndpointResource>;
  @doc("Gets the endpoint access credentials to the resource.")
  listCredentials is ArmResourceActionSync<
    EndpointResource,
    {},
    EndpointAccessResource,
    {
      ...BaseParameters<EndpointResource>;

      @doc("The is how long the endpoint access token is valid (in seconds).")
      @query("expiresin")
      expiresin?: int32;
    }
  >;
}
