import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "../Common/main.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Common;

namespace GovernanceAPI;
/**
 * Governance assignment over a given scope
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-base-parameter" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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

alias GovernanceAssignmentsOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;

    /**
     * The scope of the governance assignment.
     */
    @path(#{ allowReserved: true })
    @key
    scope: string;

    /**
     * The provider namespace.
     */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.Security";
  },
  {
    /**
     * The assessment key of the governance assignment.
     */
    @path
    @segment("assessments")
    @key
    @pattern("^[-\\w\\._\\(\\)]+$")
    assessmentName: string;
  },
  {
    /**
     * The assessment key of the governance assignment.
     */
    @path
    @segment("assessments")
    @key
    @pattern("^[-\\w\\._\\(\\)]+$")
    assessmentName: string;

    /**
     * The governance assignment key.
     */
    @path
    @segment("governanceAssignments")
    @key
    assignmentKey: string;
  }
>;

@armResourceOperations
interface GovernanceAssignments {
  /**
   * Get a specific governanceAssignment for the requested scope by AssignmentKey
   */
  get is GovernanceAssignmentsOps.Read<
    GovernanceAssignment,
    ErrorType = CloudError
  >;

  /**
   * Creates or updates a governance assignment on the given subscription.
   */
  createOrUpdate is GovernanceAssignmentsOps.CreateOrUpdateSync<
    GovernanceAssignment,
    ErrorType = CloudError
  >;

  /**
   * Delete a GovernanceAssignment over a given scope
   */
  delete is GovernanceAssignmentsOps.DeleteSync<
    GovernanceAssignment,
    ErrorType = CloudError
  >;

  /**
   * Get governance assignments on all of your resources inside a scope
   */
  list is GovernanceAssignmentsOps.List<
    GovernanceAssignment,
    Response = ArmResponse<GovernanceAssignmentsList>,
    ErrorType = CloudError
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



