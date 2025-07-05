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

alias ListAgentToolVersionsParameters = {
  @doc("Continuation token for pagination")
  @query
  continuationToken?: string;
};

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "We are using service specific operation templates"
@added(Versions.v1)
interface AgentTools
  extends VersionedOperations<
      AgentTool,
      InputParameters<AgentTool, "agenttools">,
      ListAgentToolVersionsParameters,
      ListAgentToolVersionsParameters
    > {}
