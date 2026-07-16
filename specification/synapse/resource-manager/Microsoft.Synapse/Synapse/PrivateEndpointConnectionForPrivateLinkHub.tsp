import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./PrivateLinkHub.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Synapse;
// FIXME: PrivateEndpointConnectionForPrivateLinkHub has no properties property

@parentResource(PrivateLinkHub)
model PrivateEndpointConnectionForPrivateLinkHub
  is Azure.ResourceManager.ProxyResource<{}> {
  ...ResourceNameParameter<
    Resource = PrivateEndpointConnectionForPrivateLinkHub,
    KeyName = "privateEndpointConnectionName",
    SegmentName = "privateEndpointConnections",
    NamePattern = ""
  >;
}

@armResourceOperations
interface PrivateEndpointConnectionForPrivateLinkHubs {
  /**
   * Get all PrivateEndpointConnection in the PrivateLinkHub by name
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PrivateEndpointConnectionsPrivateLinkHub_Get")
  get is ArmResourceRead<PrivateEndpointConnectionForPrivateLinkHub>;

  /**
   * Get all PrivateEndpointConnections in the PrivateLinkHub
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PrivateEndpointConnectionsPrivateLinkHub_List")
  list is ArmResourceListByParent<
    PrivateEndpointConnectionForPrivateLinkHub,
    Response = ArmResponse<PrivateEndpointConnectionForPrivateLinkHubResourceCollectionResponse>
  >;
}

@@doc(
  PrivateEndpointConnectionForPrivateLinkHub.name,
  "Name of the privateEndpointConnection"
);
