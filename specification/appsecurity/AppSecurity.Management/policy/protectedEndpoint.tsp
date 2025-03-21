using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using OpenAPI;

namespace Microsoft.AppSecurity;

@doc("Protected endpoint definition")
@discriminator("endpointType")
model ProtectedEndpoint {
  @doc("Defines the endpoint type")
  endpointType: EndpointType;

  @doc("Fully qualified ARM ID of the endpoint to protect")
  endpointId: ProtectedEndpointId;

  @doc("The status of the last attachment operation between the policy and the endpoint")
  @visibility(Lifecycle.Read)
  attachmentState?: ProvisioningState;

  @doc("Azure Resource Manager metadata containing createdBy and modifiedBy information")
  @visibility(Lifecycle.Read)
  systemData?: SystemData;
}

@doc("Defines a custom rule condition of type Ip")
model ApplicationGatewayProtectedEndpoint extends ProtectedEndpoint {
  @doc("Defines the endpoint type")
  endpointType: EndpointType.ApplicationGateway;
}

@doc("Defines a custom rule condition of type Ip")
model FrontDoorProtectedEndpoint extends ProtectedEndpoint {
  @doc("Defines the endpoint type")
  endpointType: EndpointType.FrontDoor;
}

scalar ProtectedEndpointId extends Azure.Core.armResourceIdentifier;
