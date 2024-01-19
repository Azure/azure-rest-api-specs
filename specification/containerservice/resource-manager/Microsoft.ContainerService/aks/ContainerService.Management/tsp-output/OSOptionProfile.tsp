import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ContainerService;
@doc("The OS option profile.")
@singleton("default")
@locationResource
model OSOptionProfile is ProxyResource<OSOptionPropertyList> {
  @key("osOption")
  @segment("osOptions")
  name: string;
}

@armResourceOperations
interface OSOptionProfiles {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets supported OS options in the specified subscription.")
  @operationId("ManagedClusters_GetOSOptions")
  getOSOptions is ArmResourceRead<
    OSOptionProfile,
    {
      ...BaseParameters<OSOptionProfile>;

      @doc("The resource type for which the OS options needs to be returned")
      @query("resource-type")
      `resource-type`?: string;
    }
  >;
}
