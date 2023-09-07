using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using OpenAPI;

namespace Microsoft.AppSecurity;

@doc("Protected endpoint definition")
@discriminator("endpointType")
model ProtectedEndpoint {
  // TODO - enable this when providerhub emitter supports this https://msazure.visualstudio.com/One/_workitems/edit/24658912
  // @doc("Defines the endpoint type")
  // endpointType: EndpointType;

  @doc("Fully qualified ARM ID of the endpoint to protect")
  endpointId: ProtectedEndpointId;

  @doc("The status of the last attachment operation between the policy and the endpoint")
  @visibility("read")
  attachmentState?: ProvisioningState;

  @doc("Azure Resource Manager metadata containing createdBy and modifiedBy information")
  @visibility("read")
  systemData?: SystemData;
}

@doc("Defines a custom rule condition of type Ip")
model ApplicationGatewayProtectedEndpoint extends ProtectedEndpoint {
  @doc("Defines the endpoint type")
  endpointType: "ApplicationGateway";
}

@doc("Defines a custom rule condition of type Ip")
model FrontDoorProtectedEndpoint extends ProtectedEndpoint {
  @doc("Defines the endpoint type")
  endpointType: "FrontDoor";
}

scalar ProtectedEndpointId
  extends Azure.ResourceManager.ResourceIdentifier<[
    {
      type: "Microsoft.Network/applicationGateways",
    },
    {
      type: "Microsoft.Network/applicationGateways/httpListeners",
    },
    {
      type: "Microsoft.Network/applicationGateways/requestRoutingRules",
    },
    {
      type: "Microsoft.Cdn/profiles",
    },
    {
      type: "Microsoft.Cdn/profiles/afdEndpoints",
    },
    {
      type: "Microsoft.Cdn/profiles/afdEndpoints/customDomains",
    },
    {
      type: "Microsoft.Cdn/profiles/afdEndpoints/routes",
    }
  ]>;
