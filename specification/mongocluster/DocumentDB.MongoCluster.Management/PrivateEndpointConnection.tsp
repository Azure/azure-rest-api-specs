using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;

namespace Microsoft.DocumentDB;

@parentResource(MongoCluster)
model PrivateEndpointConnectionResource
  is ProxyResource<PrivateEndpointConnectionProperties> {
  ...PrivateEndpointConnectionParameter;
}

@armResourceOperations(PrivateEndpointConnectionResource)
interface PrivateEndpointConnections {
  /** List existing private connections */
  listConnections is ArmResourceListByParent<PrivateEndpointConnectionResource>;
  /** Get a specific private connection */
  get is ArmResourceRead<PrivateEndpointConnectionResource>;
  /** Create a Private endpoint connection */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "Need to support existing 202 response for PUT operations"
  create is Operations.ArmResourceCreateOrUpdateWithAcceptedAsync<PrivateEndpointConnectionResource>;
  /** Delete the private endpoint connection */
  delete is ArmResourceDeleteWithoutOkAsync<PrivateEndpointConnectionResource>;
}

#suppress "@azure-tools/typespec-providerhub-controller/no-resource-operations" "Expected for private links"
@parentResource(MongoCluster)
model PrivateLinkResource is ProxyResource<PrivateLinkResourceProperties> {
  ...PrivateLinkResourceParameter;
}

@armResourceOperations(PrivateLinkResource)
interface PrivateLinks {
  /** list private links on the given resource */
  list is ArmResourceListByParent<PrivateLinkResource>;
}
