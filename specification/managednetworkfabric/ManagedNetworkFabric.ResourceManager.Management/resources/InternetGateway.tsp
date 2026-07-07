import "../models/common.tsp";
import "../models/InternetGateway.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Microsoft.ManagedNetworkFabric;
@doc("The Internet Gateway resource definition.")
model InternetGateway
  is Azure.ResourceManager.TrackedResource<InternetGatewayProperties, false> {
  @doc("Name of the Internet Gateway.")
  @pattern("^[a-zA-Z]{1}[a-zA-Z0-9-_]{2,127}$")
  @path
  @key("internetGatewayName")
  @segment("internetGateways")
  @visibility(Lifecycle.Read)
  name: string;
}

@@doc(InternetGateway.properties, "The Internet Gateway Properties");

@armResourceOperations
interface InternetGateways {
  @doc("Implements Gateway GET method.")
  get is ArmResourceRead<InternetGateway>;

  @doc("Creates a Network Fabric Service Internet Gateway resource instance.")
  create is ArmResourceCreateOrReplaceAsync<InternetGateway>;

  @doc("Execute patch on Network Fabric Service Internet Gateway.")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<InternetGateway, InternetGatewayPatch>;

  @doc("Execute a delete on Network Fabric Service Internet Gateway.")
  delete is ArmResourceDeleteWithoutOkAsync<InternetGateway>;

  @doc("Displays Internet Gateways list by resource group GET method.")
  listByResourceGroup is ArmResourceListByParent<
    InternetGateway,
    Response = InternetGatewaysListResult
  >;

  @doc("Displays Internet Gateways list by subscription GET method.")
  listBySubscription is ArmListBySubscription<
    InternetGateway,
    Response = InternetGatewaysListResult
  >;
}

@@doc(InternetGateways.create::parameters.resource, "Request payload.");
@@doc(
  InternetGateways.update::parameters.properties,
  "API to update certain properties of the InternetGateway resource.."
);
