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

alias ListAgentToolVersionsParameters = {};

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "We are using service specific operation templates"
@added(Versions.v2025_05_01)
interface AgentTools
  extends VersionedOperations<
      AgentTool,
      InputParameters<AgentTool, "agenttool">,
      ListAgentToolVersionsParameters,
      ListAgentToolVersionsParameters
    > {
}
