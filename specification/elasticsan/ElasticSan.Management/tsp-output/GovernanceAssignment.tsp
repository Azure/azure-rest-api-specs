import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./SecurityAssessmentResponse.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Security;
@doc("Governance assignment over a given scope")
@parentResource(SecurityAssessmentResponse)
model GovernanceAssignment is ProxyResource<GovernanceAssignmentProperties> {
  @doc("The governance assignment key - the assessment key of the required governance assignment")
  @path
  @key("assignmentKey")
  @segment("governanceAssignments")
  name: string;
}

@armResourceOperations
interface GovernanceAssignments {
  @doc("Get a specific governanceAssignment for the requested scope by AssignmentKey")
  get is ArmResourceRead<GovernanceAssignment>;

  @doc("Creates or updates a governance assignment on the given subscription.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<GovernanceAssignment>;

  @doc("Delete a GovernanceAssignment over a given scope")
  delete is ArmResourceDeleteSync<GovernanceAssignment>;

  @doc("Get governance assignments on all of your resources inside a scope")
  list is ArmResourceListByParent<GovernanceAssignment>;
}

@@projectedName(GovernanceAssignments.createOrUpdate::parameters.resource,
  "json",
  "governanceAssignment"
);
@@extension(GovernanceAssignments.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "governanceAssignment"
);
@@doc(GovernanceAssignments.createOrUpdate::parameters.resource,
  "Governance assignment over a subscription scope"
);
