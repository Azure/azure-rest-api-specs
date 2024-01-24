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
/**
 * The Role Assignment resource format.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Hub)
@Azure.ResourceManager.Private.armResourceInternal(RoleAssignment)
@includeInapplicableMetadataInPayload(false)
model RoleAssignmentResourceFormat extends ProxyResource {
  /**
   * The name of the role assignment.
   */
  @path
  @key("assignmentName")
  @segment("roleAssignments")
  name: string;

  /**
   * The Role Assignment definition.
   */
  @extension("x-ms-client-flatten", true)
  properties?: RoleAssignment;
}

@armResourceOperations
interface RoleAssignmentResourceFormats {
  /**
   * Gets the role assignment in the hub.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("RoleAssignments_Get")
  get is ArmResourceRead<RoleAssignmentResourceFormat>;

  /**
   * Creates or updates a role assignment in the hub.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("RoleAssignments_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<RoleAssignmentResourceFormat>;

  /**
   * Deletes the role assignment in the hub.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("RoleAssignments_Delete")
  delete is ArmResourceDeleteSync<RoleAssignmentResourceFormat>;

  /**
   * Gets all the role assignments for the specified hub.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
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
