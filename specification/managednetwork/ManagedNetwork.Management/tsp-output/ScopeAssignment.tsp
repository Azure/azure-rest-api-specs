import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ManagedNetwork;
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

@@projectedName(ScopeAssignments.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(ScopeAssignments.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(ScopeAssignments.createOrUpdate::parameters.resource,
  "Parameters supplied to the specify which Managed Network this scope is being assigned"
);
