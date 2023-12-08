import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.ManagedNetwork;
@doc("The Managed Network resource")
model ScopeAssignment is ExtensionResource<ScopeAssignmentProperties> {
  @doc("The name of the scope assignment to get.")
  @path
  @key("scopeAssignmentName")
  @segment("scopeAssignments")
  name: string;
}

@armResourceOperations
interface ScopeAssignments {
  @doc("Get the specified scope assignment.")
  get is ArmResourceRead<ScopeAssignment>;
  @doc("Creates a scope assignment.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<ScopeAssignment>;
  @doc("Deletes a scope assignment.")
  delete is ArmResourceDeleteSync<ScopeAssignment>;
  @doc("Get the specified scope assignment.")
  list is ArmResourceListByParent<ScopeAssignment>;
}
