import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.ContainerService;
@doc("The OS option profile.")
@singleton("default")
@locationResource
model OSOptionProfile is ProxyResource<OSOptionPropertyList> {
  @key("default")
  @segment("osOptions")
  name: string;
}

@armResourceOperations
interface OSOptionProfiles {
  @doc("Gets supported OS options in the specified subscription.")
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
