import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "../common/models.tsp";
import "./models.tsp";
import "../servicepatterns.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

alias ListAgentBlueprintVersionsParameters = {
  @doc("Continuation token for pagination")
  @query
  continuationToken?: string;
};

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "We are using service specific operation templates"
@added(Versions.v1)
interface AgentBlueprints
  extends VersionedOperations<
      AgentBlueprint,
      InputParameters<AgentBlueprint, "agentblueprint">,
      ListAgentBlueprintVersionsParameters,
      ListAgentBlueprintVersionsParameters
    > {
  @doc("Start a new or get an existing pending upload of a dataset for a specific version.")
  @Rest.action("scaffold")
  scaffoldBlueprint is Azure.Core.Foundations.ResourceOperation<
    AgentBlueprint,
    {
      @doc("The scaffold request parameters")
      @Http.bodyRoot
      scaffoldRequest: ScaffoldRequest;

      @doc("The specific version id of the AgentBlueprint to operate on.")
      @Rest.segment("versions")
      @Http.path
      version: string;
    },
    ScaffoldResponse
  >;
}
