import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./VnetInfoResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CertificateRegistration;
/**
 * The Virtual Network gateway contract. This is used to give the Virtual Network gateway access to the VPN package.
 */
@parentResource(VnetInfoResource)
model VnetGateway is ProxyResource<VnetGatewayProperties> {
  /**
   * Name of the gateway. Only the 'primary' gateway is supported.
   */
  @path
  @key("gatewayName")
  @segment("gateways")
  name: string;
}

@armResourceOperations
interface VnetGateways {
  /**
   * Description for Get a Virtual Network gateway.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AppServicePlans_GetVnetGateway")
  getVnetGateway is ArmResourceRead<VnetGateway>;

  /**
   * Description for Update a Virtual Network gateway.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AppServicePlans_UpdateVnetGateway")
  updateVnetGateway is ArmResourceCreateOrReplaceSync<VnetGateway>;
}

@@projectedName(VnetGateways.updateVnetGateway::parameters.resource,
  "json",
  "connectionEnvelope"
);
@@extension(VnetGateways.updateVnetGateway::parameters.resource,
  "x-ms-client-name",
  "connectionEnvelope"
);
@@doc(VnetGateways.updateVnetGateway::parameters.resource,
  "Definition of the gateway."
);
