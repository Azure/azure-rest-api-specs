import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Cluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AVS;
@doc("A vSphere Distributed Resource Scheduler (DRS) placement policy")
@parentResource(Cluster)
model PlacementPolicy is ProxyResource<PlacementPolicyProperties> {
  @doc("Name of the VMware vSphere Distributed Resource Scheduler (DRS) placement policy")
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
  update is ArmCustomPatchAsync<PlacementPolicy, PlacementPolicyUpdate>;

  @doc("Delete a placement policy in a private cloud cluster")
  delete is ArmResourceDeleteAsync<PlacementPolicy>;

  @doc("List placement policies in a private cloud cluster")
  list is ArmResourceListByParent<PlacementPolicy>;
}

@@projectedName(PlacementPolicies.createOrUpdate::parameters.resource,
  "json",
  "placementPolicy"
);
@@extension(PlacementPolicies.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "placementPolicy"
);
@@doc(PlacementPolicies.createOrUpdate::parameters.resource,
  "A placement policy in the private cloud cluster"
);
@@projectedName(PlacementPolicies.update::parameters.properties,
  "json",
  "placementPolicyUpdate"
);
@@extension(PlacementPolicies.update::parameters.properties,
  "x-ms-client-name",
  "placementPolicyUpdate"
);
@@doc(PlacementPolicies.update::parameters.properties,
  "The placement policy properties that may be updated"
);
