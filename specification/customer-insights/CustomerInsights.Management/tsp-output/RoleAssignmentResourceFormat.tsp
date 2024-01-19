import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Hub.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CustomerInsights;
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
interface RoleAssignmentResourceFormats {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets the role assignment in the hub.")
  @operationId("RoleAssignments_Get")
  get is ArmResourceRead<RoleAssignmentResourceFormat>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Creates or updates a role assignment in the hub.")
  @operationId("RoleAssignments_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<RoleAssignmentResourceFormat>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deletes the role assignment in the hub.")
  @operationId("RoleAssignments_Delete")
  delete is ArmResourceDeleteSync<RoleAssignmentResourceFormat>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets all the role assignments for the specified hub.")
  @operationId("RoleAssignments_ListByHub")
  listByHub is ArmResourceListByParent<RoleAssignmentResourceFormat>;
}

@@projectedName(RoleAssignmentResourceFormats.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(RoleAssignmentResourceFormats.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(RoleAssignmentResourceFormats.createOrUpdate::parameters.resource,
  "Parameters supplied to the CreateOrUpdate RoleAssignment operation."
);
