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
  listByMongoCluster is ArmResourceListByParent<PrivateEndpointConnectionResource>;
  /** Get a specific private connection */
  get is ArmResourceRead<PrivateEndpointConnectionResource>;
  /** Create a Private endpoint connection */
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST REMOVE AT NEXT API VERSION UPDATE"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "Need to support existing 202 response for PUT operations"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  create is ArmResourceCreateOrReplaceAsync<
    PrivateEndpointConnectionResource,
    Response = ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = PrivateEndpointConnectionResource> &
      Azure.Core.Foundations.RetryAfterHeader> | ArmResourceUpdatedResponse<PrivateEndpointConnectionResource> | ArmResourceCreatedResponse<
      PrivateEndpointConnectionResource,
      LroHeaders = {}
    >
  >;
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
  listByMongoCluster is ArmResourceListByParent<PrivateLinkResource>;
}
