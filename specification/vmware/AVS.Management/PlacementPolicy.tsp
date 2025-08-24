import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Cluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.AVS;
@doc("A vSphere Distributed Resource Scheduler (DRS) placement policy")
@parentResource(Cluster)
model PlacementPolicy is ProxyResource<PlacementPolicyProperties> {
  @doc("Name of the VMware vSphere Distributed Resource Scheduler (DRS) placement policy")
  @pattern("^[-\\w\\._]+$")
  @path
  @key("placementPolicyName")
  @segment("placementPolicies")
  name: string;
}

@armResourceOperations
interface PlacementPolicies {
  @doc("Get a placement policy by name in a private cloud cluster")
  get is ArmResourceRead<PlacementPolicy>;
  @doc("Create or update a placement policy in a private cloud cluster")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<PlacementPolicy>;
  @doc("Update a placement policy in a private cloud cluster")
  update is ArmResourcePatchAsync<PlacementPolicy, PlacementPolicyProperties>;
  @doc("Delete a placement policy in a private cloud cluster")
  delete is ArmResourceDeleteAsync<PlacementPolicy>;
  @doc("List placement policies in a private cloud cluster")
  list is ArmResourceListByParent<PlacementPolicy>;
}
