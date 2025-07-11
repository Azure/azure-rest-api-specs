import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "../main.tsp";
import "../common/models.tsp";
import "@typespec/openapi";
import "@typespec/versioning";

using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance"
@doc("Agent resource Definition")
@Rest.resource("agents")
@added(Versions.v1)
model Agent {
  @doc("The name of the created agent")
  @visibility(Lifecycle.Read)
  @key
  name: string;

  @doc("blueprint the agent is based on")
  blueprint: string;

  @doc("Parameters for the agent")
  parameters?: Record<BaseParameterValue>;

  @doc("state of the agent: paused or active")
  state: State;
}

@doc("Agent deployment request")
model AgentDeploymentRequest {
  @doc("blueprint id used by the agent")
  blueprint: string;

  @doc("deployment configuration")
  parameters: Record<BaseParameterValue>;
}

@doc("Enum to determine the state of the agent.")
union State {
  string,

  @doc("active state.")
  active: "active",

  @doc("paused state.")
  paused: "paused",
}
