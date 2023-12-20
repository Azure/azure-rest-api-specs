import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.HybridConnectivity;
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
  get is ArmResourceRead<
    EndpointResource,
    {
      ...BaseParameters<EndpointResource>;

      @doc("The fully qualified Azure Resource manager identifier of the resource to be connected.")
      @path
      scope: string;
    }
  >;
  @doc("Create or update the endpoint to the target resource.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    EndpointResource,
    {
      ...BaseParameters<EndpointResource>;

      @doc("The fully qualified Azure Resource manager identifier of the resource to be connected.")
      @path
      scope: string;
    }
  >;
  @doc("Update the endpoint to the target resource.")
  update is ArmResourcePatchSync<
    EndpointResource,
    EndpointProperties,
    {
      ...BaseParameters<EndpointResource>;

      @doc("The fully qualified Azure Resource manager identifier of the resource to be connected.")
      @path
      scope: string;
    }
  >;
  @doc("Deletes the endpoint access to the target resource.")
  delete is ArmResourceDeleteSync<
    EndpointResource,
    {
      ...BaseParameters<EndpointResource>;

      @doc("The fully qualified Azure Resource manager identifier of the resource to be connected.")
      @path
      scope: string;
    }
  >;
  @doc("List of endpoints to the target resource.")
  list is ArmResourceListByParent<
    EndpointResource,
    {
      ...BaseParameters<EndpointResource>;

      @doc("The fully qualified Azure Resource manager identifier of the resource to be connected.")
      @path
      scope: string;
    }
  >;
  @doc("Gets the endpoint access credentials to the resource.")
  listCredentials is ArmResourceActionSync<
    EndpointResource,
    void,
    TargetResourceEndpointAccess,
    {
      ...BaseParameters<EndpointResource>;

      @doc("The fully qualified Azure Resource manager identifier of the resource to be connected.")
      @path
      scope: string;

      @doc("The is how long the endpoint access token is valid (in seconds).")
      @maxValue(10800)
      @minValue(600)
      @query("expiresin")
      expiresin?: int32 = 10800;
    }
  >;
}
