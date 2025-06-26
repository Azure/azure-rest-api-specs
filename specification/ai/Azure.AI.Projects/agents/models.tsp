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
    @doc("Asset ID, a unique identifier for the asset")
    @visibility(Lifecycle.Read)
    id?: string;

    @doc("The name of the resource")
    @visibility(Lifecycle.Read)
    @key
    name: string;

    @doc ("System related metadata")
    @visibility(Lifecycle.Read)
    SystemData?: SystemData;

    @doc("blueprint the agent is based on")
    blueprint: string;

    @doc("Parameters for the agent")
    parameters?: Record<BaseParameterValue>;

    @doc("state of the agent: paused or active")
    state: string;
}

@doc("Agent deployment response")
model AgentDeploymentResponse {
}

@doc("Agent deployment request")
model AgentDeploymentRequest {
    @doc("blueprint id used by the agent")
    blueprint: string;

    @doc("deployment configuration")
    parameters: Record<BaseParameterValue>;
}