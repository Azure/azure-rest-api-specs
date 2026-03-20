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
 * Governance assignment over a given scope
 */
@extensionResource
model GovernanceAssignment
  is Azure.ResourceManager.ExtensionResource<GovernanceAssignmentProperties> {
  ...ResourceNameParameter<
    Resource = GovernanceAssignment,
    KeyName = "assignmentKey",
    SegmentName = "governanceAssignments",
    NamePattern = ""
  >;
}

@armResourceOperations
interface GovernanceAssignments {
  /**
   * Get a specific governanceAssignment for the requested scope by AssignmentKey
   */
  get is Extension.Read<Extension.ScopeParameter, GovernanceAssignment>;

  /**
   * Creates or updates a governance assignment on the given subscription.
   */
  createOrUpdate is Extension.CreateOrReplaceSync<
    Extension.ScopeParameter,
    GovernanceAssignment
  >;

  /**
   * Delete a GovernanceAssignment over a given scope
   */
  delete is Extension.DeleteSync<
    Extension.ScopeParameter,
    GovernanceAssignment
  >;

  /**
   * Get governance assignments on all of your resources inside a scope
   */
  list is Extension.ListByTarget<
    Extension.ScopeParameter,
    GovernanceAssignment,
    Response = ArmResponse<GovernanceAssignmentsList>
  >;
}

@@doc(GovernanceAssignment.name,
  "The governance assignment key - the assessment key of the required governance assignment"
);
@@doc(GovernanceAssignment.properties,
  "The properties of a governance assignment"
);
@@doc(GovernanceAssignments.createOrUpdate::parameters.resource,
  "Governance assignment over a subscription scope"
);
