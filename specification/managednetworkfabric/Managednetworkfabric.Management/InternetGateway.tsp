import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ManagedNetworkFabric;
/**
 * The Internet Gateway resource definition.
 */
model InternetGateway
  is Azure.ResourceManager.TrackedResource<InternetGatewayProperties, false> {
  ...ResourceNameParameter<
    Resource = InternetGateway,
    KeyName = "internetGatewayName",
    SegmentName = "internetGateways",
    NamePattern = ""
  >;
}

@armResourceOperations
interface InternetGateways {
  /**
   * Implements Gateway GET method.
   */
  get is ArmResourceRead<InternetGateway>;

  /**
   * Creates a Network Fabric Service Internet Gateway resource instance.
   */
  create is ArmResourceCreateOrReplaceAsync<InternetGateway>;

  /**
   * Execute patch on Network Fabric Service Internet Gateway.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    InternetGateway,
    PatchModel = InternetGatewayPatch
  >;

  /**
   * Execute a delete on Network Fabric Service Internet Gateway.
   */
  delete is ArmResourceDeleteWithoutOkAsync<InternetGateway>;

  /**
   * Displays Internet Gateways list by resource group GET method.
   */
  listByResourceGroup is ArmResourceListByParent<InternetGateway>;

  /**
   * Displays Internet Gateways list by subscription GET method.
   */
  listBySubscription is ArmListBySubscription<InternetGateway>;
}

@@doc(InternetGateway.name, "Name of the Internet Gateway.");
@@doc(InternetGateway.properties, "Resource properties.");
@@doc(InternetGateways.create::parameters.resource, "Request payload.");
@@doc(InternetGateways.update::parameters.properties,
  "API to update certain properties of the L2 Isolation Domain resource.."
);
