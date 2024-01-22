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
/**
 * The Internet Gateway resource definition.
 */
model InternetGateway is TrackedResource<InternetGatewayProperties> {
  /**
   * Name of the Internet Gateway.
   */
  @path
  @key("internetGatewayName")
  @segment("internetGateways")
  name: string;
}

@armResourceOperations
interface InternetGateways {
  /**
   * Implements Gateway GET method.
   */
  get is ArmResourceRead<InternetGateway>;

  /**
   * Execute patch on Network Fabric Service Internet Gateway.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<
    InternetGateway,
    InternetGatewayPatch,
    BaseParameters<InternetGateway>,
    ArmLroLocationHeader
  >;

  /**
   * Displays Internet Gateways list by resource group GET method.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("InternetGateways_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<InternetGateway>;

  /**
   * Displays Internet Gateways list by subscription GET method.
   */
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
