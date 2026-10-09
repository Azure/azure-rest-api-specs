import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./main.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.HorizonDb;

@doc("Represents the HorizonDB private link resource.")
@parentResource(Cluster)
model PrivateLinkResource
  is Azure.ResourceManager.ProxyResource<PrivateLinkResourceProperties> {
  @doc("The name of the private link resource.")
  @pattern("^.*$")
  @minLength(1)
  @maxLength(128)
  @key("groupName")
  @path
  @segment("privateLinkResources")
  name: string;
}

alias PrivateEndpointOperations = Azure.ResourceManager.PrivateEndpoints<PrivateEndpointConnection>;

@armResourceOperations
interface PrivateEndpointConnections {
  @doc("Gets a private endpoint connection.")
  get is PrivateEndpointOperations.Read<
    Cluster,
    PrivateEndpointConnectionResource
  >;

  @doc("Lists private endpoint connections in a HorizonDB cluster.")
  list is PrivateEndpointOperations.ListByParent<
    Cluster,
    PrivateEndpointConnectionResource
  >;

  @doc("Approves or rejects an existing private endpoint connection. Approval requires the parent Cluster to contain at least one Pool. An approval attempt when the Cluster has no Pools fails with 409 Conflict and the stable error code PrivateEndpointRequiresPool. Rejection remains allowed when the Cluster has no Pools so that existing connections can be cleaned up.")
  @sharedRoute
  approveOrReject is PrivateEndpointOperations.CreateOrReplaceAsync<
    Cluster,
    PrivateEndpointConnectionResource,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = PrivateEndpointConnectionResource> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  @doc("Deletes a private endpoint connection.")
  delete is PrivateEndpointOperations.DeleteAsync<
    Cluster,
    PrivateEndpointConnectionResource,
    Response =
      | ArmDeleteAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders &
          Azure.Core.Foundations.RetryAfterHeader>
      | ArmDeletedNoContentResponse
  >;
}

@armResourceOperations
interface PrivateLinkResources {
  @doc("Gets a private link resource.")
  get is ArmResourceRead<PrivateLinkResource>;

  @doc("Lists private link resources in a HorizonDB cluster.")
  list is ArmResourceListByParent<PrivateLinkResource>;
}
