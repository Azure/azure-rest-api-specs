import "../models/common.tsp";
import "../models/InternetGateway.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;

using TypeSpec.Http;

namespace Microsoft.ManagedNetworkFabric;
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" ""
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "Unsupported common type"
@doc("The Internet Gateway resource definition.")
@Http.Private.includeInapplicableMetadataInPayload(false)
model InternetGateway
  extends Azure.ResourceManager.Foundations.TrackedResource {
  @doc("Name of the Internet Gateway.")
  @pattern("^[a-zA-Z]{1}[a-zA-Z0-9-_]{2,127}$")
  @path
  @key("internetGatewayName")
  @segment("internetGateways")
  @visibility(Lifecycle.Read)
  name: string;

  /** The Internet Gateway Properties */
  properties: InternetGatewayProperties;
}

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
  listByResourceGroup is ArmResourceListByParent<InternetGateway>;

  @doc("Displays Internet Gateways list by subscription GET method.")
  listBySubscription is ArmListBySubscription<InternetGateway>;
}

@@doc(InternetGateways.create::parameters.resource, "Request payload.");
@@doc(InternetGateways.update::parameters.properties,
  "API to update certain properties of the InternetGateway resource.."
);
