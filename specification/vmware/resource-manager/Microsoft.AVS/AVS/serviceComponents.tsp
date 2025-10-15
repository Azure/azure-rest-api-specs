namespace Microsoft.AVS;

using Azure.ClientGenerator.Core;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

@armResourceOperations
interface ServiceComponents {
  @doc("Return service component availability")
  @added(Versions.v2025_09_01)
  @access(Access.internal)
  checkAvailability is ArmResourceActionAsyncBase<
    ServiceComponent,
    void,
    ArmAcceptedLroResponse,
    Foundations.BaseParameters<ServiceComponent>
  >;
}

@doc("A service component resource")
@parentResource(Location)
model ServiceComponent is ProxyResource<ServiceComponentProperties> {
  @doc("A service component")
  @pattern("^[-\\w\\._]+$")
  @key("serviceComponentName")
  @path
  @segment("serviceComponents")
  name: string;
}

@doc("service component provisioning state")
union ServiceComponentProvisioningState {
  string,
  ResourceProvisioningState,
}

@doc("The properties of a service component resource")
model ServiceComponentProperties {
  @doc("The provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ServiceComponentProvisioningState;
}
