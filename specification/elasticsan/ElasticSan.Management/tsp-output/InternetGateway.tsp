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

namespace Microsoft.ManagedNetworkFabric;
@doc("The Internet Gateway resource definition.")
model InternetGateway is TrackedResource<InternetGatewayProperties> {
  @doc("Name of the Internet Gateway.")
  @path
  @key("internetGatewayName")
  @segment("internetGateways")
  name: string;
}

@armResourceOperations
interface InternetGateways {
  @doc("Implements Gateway GET method.")
  get is ArmResourceRead<InternetGateway>;

  @doc("Execute patch on Network Fabric Service Internet Gateway.")
  update is ArmCustomPatchAsync<
    InternetGateway,
    InternetGatewayPatch,
    BaseParameters<InternetGateway>,
    ArmLroLocationHeader
  >;

  @doc("Displays Internet Gateways list by resource group GET method.")
  listByResourceGroup is ArmResourceListByParent<InternetGateway>;

  @doc("Displays Internet Gateways list by subscription GET method.")
  listBySubscription is ArmListBySubscription<InternetGateway>;
}

@@projectedName(InternetGateways.update::parameters.properties, "json", "body");
@@extension(InternetGateways.update::parameters.properties,
  "x-ms-client-name",
  "body"
);
@@doc(InternetGateways.update::parameters.properties,
  "API to update certain properties of the L2 Isolation Domain resource.."
);
