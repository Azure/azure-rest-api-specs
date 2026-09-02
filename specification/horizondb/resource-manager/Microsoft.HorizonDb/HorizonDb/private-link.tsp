import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.HorizonDb;

@renamedFrom(Versions.v2026_10_01, "HorizonDbPrivateLinkResource")
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

@renamedFrom(Versions.v2026_10_01, "HorizonDbPrivateEndpointConnections")
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

  @doc("Updates a private endpoint connection.")
  @removed(Versions.v2026_05_01_preview)
  @renamedFrom(Versions.v2026_05_01_preview, "update")
  @sharedRoute
  updateLegacy is PrivateEndpointOperations.CustomPatchAsync<
    Cluster,
    PrivateEndpointConnectionResource
  >;

  @added(Versions.v2026_10_01)
  @sharedRoute
  update is PrivateEndpointOperations.CustomPatchAsync<
    Cluster,
    PrivateEndpointConnectionResource
  >;

  @doc("Approves or rejects a private endpoint connection.")
  @added(Versions.v2026_05_01_preview)
  @removed(Versions.v2026_10_01)
  updateStatus is PrivateEndpointOperations.CreateOrReplaceSync<
    Cluster,
    PrivateEndpointConnectionResource
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

@renamedFrom(Versions.v2026_10_01, "HorizonDbPrivateLinkResources")
@armResourceOperations
interface PrivateLinkResources {
  @doc("Gets a private link resource.")
  get is ArmResourceRead<PrivateLinkResource>;

  @doc("Lists private link resources in a HorizonDB cluster.")
  list is ArmResourceListByParent<PrivateLinkResource>;
}
