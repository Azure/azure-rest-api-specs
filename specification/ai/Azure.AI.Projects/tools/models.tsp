import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "../common/models.tsp";
import "../main.tsp";
import "@typespec/openapi";
import "@typespec/versioning";

using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;


#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance"
@doc("AgentBlueprint resource Definition")
@Rest.resource("agenttools")
@added(Versions.v1)
model AgentTool {
    ...AssetBase;

    @doc ("System related metadata")
    @visibility(Lifecycle.Read)
    SystemData?: SystemData;

    @doc("Catalog information for the tool")
    catalogInfo: AgentToolCatalogInformation;
    
    @doc("implementation details for the tool")
    implementation: AgentToolImplementationDetails;

    @doc("Instructions for how to deploy and invoke the tool")
    protocol: AgentToolProtocolDetails;

    @doc("Dependencies for the tool")
    dependencies?: Record<BaseAgentDependency>;

    @doc("Parameters for the tool")
    parameters?: Record<BaseParameterDefinition>;
}



@doc("Catalog information for the agent tool")
model AgentToolCatalogInformation {
    ...CatalogInformation;  
}

@doc("Implementation details for the agent tool")
model AgentToolImplementationDetails {
    @doc("Type of agent tool")
    type: string;
}

@doc("instructions for how to deploy the tool")
model AgentToolProtocolDetails {
    @doc("type of protocol")
    type: string;

    @doc("authorization details")
    auth: AuthorizationDetails;

    @doc("spec for the tool that contains {{mustache}} string which are replaced from parameters")
    spec: Record<unknown>;
}

@doc("Authorization specification for a tool protocol")
model AuthorizationDetails {
    @doc("Type of authorization")
    type: string;
}