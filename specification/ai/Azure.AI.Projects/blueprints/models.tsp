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
@doc("AgentBlueprint resource Definition")
@Rest.resource("agentblueprints")
@discriminator("type")
@added(Versions.v2025_05_01)
model AgentBlueprint {
    ..AssetBase

    @doc ("System related metadata")
    @visibility(Lifecycle.Read)
    SystemData?: SystemData;

    @doc("Catalog information for the agent")
    catalogInfo: AgentBlueprintCatalogInformation;
    
    @doc("Instructions for deploying the agent")
    implementation: AgentImplementationDetails;

    @doc("Dependencies for the agent")
    dependencies?: Record<string, BaseAgentDependency>;

    @doc("Parameters for the agent")
    parameters?: Record<string, BaseParameter>;
}

@doc("An abstract representation of instructions on how to deploy and run the agent")
model AgentImplementationDetails {
    @doc("type of agent")
    type: string;

    @doc("instructions/prompt for the agent")
    instructions: string;
}

@doc("An abstract representation of a dependency for the agent")
model BaseAgentDependency {
    @doc("type of dependency")
    type: string;

    @doc("identifier of the dependency")
    assetId: string;
}

@doc("Representation of a model dependency for the agent")
model ModelDependency extends BaseAgentDependency {
    @doc("type of dependency")
    type: "model";

    @doc("parameters for the model")
    parameters?: Record<string>;
}

@doc("Catalog information for the agent blueprint")
model AgentBlueprintCatalogInformation extends CatalogInformation {  
}

@doc("Represents the request for a blueprint scaffold operation")
model ScaffoldRequest {
}

@doc("Represents the response for a blueprint scaffold request")
model ScaffoldResponse {
    @doc("The parameters for the blueprint")
    parameters: Record<string, BaseParameterValue>;

    @doc("comment metadata for each parameter")
    _meta: Record<string, string>;
}