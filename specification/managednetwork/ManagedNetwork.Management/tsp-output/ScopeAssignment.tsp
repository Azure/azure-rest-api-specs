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
/**
 * The Managed Network resource
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@Azure.ResourceManager.Private.armResourceInternal(ScopeAssignmentProperties)
@includeInapplicableMetadataInPayload(false)
model ScopeAssignment extends ProxyResource {
  /**
   * The name of the scope assignment to get.
   */
  @path
  @key("scopeAssignmentName")
  @segment("scopeAssignments")
  name: string;

  /**
   * The Scope Assignment properties
   */
  @extension("x-ms-client-flatten", true)
  properties?: ScopeAssignmentProperties;
}

@armResourceOperations
interface ScopeAssignments {
  /**
   * Get the specified scope assignment.
   */
  get is ArmResourceRead<ScopeAssignment>;

  /**
   * Creates a scope assignment.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<ScopeAssignment>;

  /**
   * Deletes a scope assignment.
   */
  delete is ArmResourceDeleteSync<ScopeAssignment>;

  /**
   * Get the specified scope assignment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ScopeAssignments_List")
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
