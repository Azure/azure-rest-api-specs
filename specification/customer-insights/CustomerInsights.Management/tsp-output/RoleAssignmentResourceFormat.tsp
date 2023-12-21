import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Hub.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.CustomerInsights;
@doc("The Role Assignment resource format.")
@parentResource(Hub)
model RoleAssignmentResourceFormat is ProxyResource<RoleAssignment> {
  @doc("The name of the role assignment.")
  @path
  @key("assignmentName")
  @segment("roleAssignments")
  name: string;
}

@armResourceOperations
interface RoleAssignments {
  @doc("Gets the role assignment in the hub.")
  get is ArmResourceRead<RoleAssignmentResourceFormat>;
  @doc("Creates or updates a role assignment in the hub.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<RoleAssignmentResourceFormat>;
  @doc("Deletes the role assignment in the hub.")
  delete is ArmResourceDeleteSync<RoleAssignmentResourceFormat>;
  @doc("Gets all the role assignments for the specified hub.")
  listByHub is ArmResourceListByParent<RoleAssignmentResourceFormat>;
}
