import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Security;
/**
 * Security Assignment on a resource group over a given scope
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-base-parameter" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@extensionResource
model StandardAssignment
  is Azure.ResourceManager.ExtensionResource<StandardAssignmentProperties> {
  ...ResourceNameParameter<
    Resource = StandardAssignment,
    KeyName = "standardAssignmentName",
    SegmentName = "standardAssignments",
    NamePattern = "[{]?[0-9a-fA-F]{8}-(?:[0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}[}]?$"
  >;
}

model ResourceIdScopeParameter is Extension.ScopeParameter;

@armResourceOperations
interface StandardAssignments {
  /**
   * This operation retrieves a single standard assignment, given its name and the scope it was created at.
   */
  @summary("Retrieves a standard assignment.")
  get is Extension.Read<ResourceIdScopeParameter, StandardAssignment>;

  /**
   *  This operation creates or updates a standard assignment with the given scope and name. standard assignments apply to all resources contained within their scope. For example, when you assign a policy at resource group scope, that policy applies to all resources in the group.
   */
  @summary("Creates or updates a standard assignment.")
  create is Extension.CreateOrReplaceSync<
    ResourceIdScopeParameter,
    StandardAssignment
  >;

  /**
   * This operation deletes a standard assignment, given its name and the scope it was created in. The scope of a standard assignment is the part of its ID preceding '/providers/Microsoft.Security/standardAssignments/{standardAssignmentName}'.
   */
  @summary("Deletes a standard assignment.")
  delete is Extension.DeleteSync<ResourceIdScopeParameter, StandardAssignment>;

  /**
   * Get a list of all relevant standard assignments over a scope
   */
  list is Extension.ListByTarget<
    Extension.ScopeParameter,
    StandardAssignment,
    Response = ArmResponse<StandardAssignmentsList>
  >;
}

@@doc(StandardAssignment.name,
  "The standard assignments assignment key - unique key for the standard assignment"
);
@@doc(StandardAssignment.properties,
  "Properties of a standard assignments assignment"
);
@@doc(StandardAssignments.create::parameters.resource,
  "Custom standard assignment over a pre-defined scope"
);

@@key(ResourceIdScopeParameter.scope, "resourceId");
