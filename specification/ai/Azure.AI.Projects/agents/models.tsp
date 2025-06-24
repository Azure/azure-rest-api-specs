import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@typespec/openapi";
import "@typespec/versioning";

using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;


#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance"
@doc("Agent resource Definition")
@Rest.resource("agents")
@discriminator("type")
@added(Versions.v2025_05_01)
model Agent {
    ..AssetBase

    @doc ("System related metadata")
    @visibility(Lifecycle.Read)
    SystemData?: SystemData;

    @doc("Catalog information for the agent")
    catalogInfo: AgentCatalogInformation;

    @doc("blueprint the agent is based on")
    blueprint: string;

    @doc("Parameters for the agent")
    parameters?: Record<string, BaseParameterValue>;
}

@doc("Catalog information for the agent")
model AgentCatalogInformation extends CatalogInformation {  
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

@doc("Agent pause or resume request")
model PauseOrResumeRequest {
    @doc("pause or resume the agent")
    action: "pause" | "resume";
}

@doc("Agent pause or resume response")
model PauseOrResumeResponse {
}