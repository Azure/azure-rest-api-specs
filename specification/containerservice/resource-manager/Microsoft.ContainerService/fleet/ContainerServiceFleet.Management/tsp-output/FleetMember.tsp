import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Fleet.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.ContainerService;
@doc("A member of the Fleet. It contains a reference to an existing Kubernetes cluster on Azure.")
@parentResource(Fleet)
model FleetMember is ProxyResource<FleetMemberProperties> {
  @doc("The name of the Fleet member resource.")
  @maxLength(50)
  @minLength(1)
  @pattern("^[a-z0-9]([-a-z0-9]*[a-z0-9])?$")
  @key("fleetMemberName")
  @segment("members")
  name: string;

  ...Azure.ResourceManager.EntityTag;
}

@armResourceOperations
interface FleetMembers {
  @doc("Get a FleetMember")
  get is ArmResourceRead<FleetMember>;

  @doc("Create a FleetMember")
  create is ArmResourceCreateOrUpdateAsync<
    FleetMember,
    {
      ...BaseParameters<FleetMember>;

      @doc("The request should only proceed if an entity matches this string.")
      @header
      ifMatch?: string;

      @doc("The request should only proceed if no entity matches this string.")
      @header
      ifNoneMatch?: string;
    }
  >;

  @doc("Update a FleetMember")
  update is ArmCustomPatchAsync<
    FleetMember,
    FleetMemberUpdate,
    {
      ...BaseParameters<FleetMember>;

      @doc("The request should only proceed if an entity matches this string.")
      @header
      ifMatch?: string;
    }
  >;

  @doc("Delete a FleetMember")
  delete is ArmResourceDeleteAsync<
    FleetMember,
    {
      ...BaseParameters<FleetMember>;

      @doc("The request should only proceed if an entity matches this string.")
      @header
      ifMatch?: string;
    }
  >;

  @doc("List FleetMember resources by Fleet")
  listByFleet is ArmResourceListByParent<FleetMember>;
}
