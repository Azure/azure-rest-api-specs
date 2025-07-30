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
@Rest.resource("agentblueprints")
@added(Versions.v2025_05_15_preview)
model AgentBlueprint {
  ...AssetBase;

  @doc("display name of the blueprint")
  displayName: string;

  @doc("System related metadata")
  @visibility(Lifecycle.Read)
  SystemData?: SystemData;

  @doc("Catalog data for the blueprint")
  catalogData: AgentBlueprintCatalogData;

  @doc("Instructions for deploying an agent using this blueprint")
  implementation: AgentImplementationDetails;

  @doc("Dependencies that need to be specified to create an agent instance from this blueprint")
  dependencies?: Record<BaseAgentDependency>;

  @doc("Definitions of parameters to be specified when creating an agent instance from this blueprint")
  parameters?: Record<BaseParameterDefinition>;
}

@doc("An abstract representation of instructions on how to deploy and run the agent")
model AgentImplementationDetails {
  @doc("type of agent")
  type: string;

  @doc("instructions/prompt for the agent")
  instructions: string;
}

@doc("An abstract representation of a dependency for the agent")
@discriminator("type")
model BaseAgentDependency {
  @doc("type of dependency")
  type: string;
}

@doc("Representation of a model dependency for the agent")
model ModelDependency extends BaseAgentDependency {
  @doc("type of dependency")
  type: "model";

  @doc("identifier of the recommended model")
  recommendedModel: string;

  @doc("parameters for the model")
  parameters?: Record<string>;
}

@doc("Representation of a tool dependency for the agent")
model ToolDependency extends BaseAgentDependency {
  @doc("type of dependency")
  type: "tool";

  @doc("identifier for the tool")
  id: string;

  @doc("optional description of how the blueprint will use the tool")
  description?: string;
}

@doc("Catalog data for the agent blueprint")
model AgentBlueprintCatalogData {
  ...CatalogInformation;
}

@doc("Represents the request for a blueprint scaffold operation")
model ScaffoldRequest {}

@doc("Represents the response for a blueprint scaffold request")
model ScaffoldResponse {
  @doc("The parameters for the blueprint")
  parameters: Record<BaseParameterValue>;

  @doc("comment metadata for each parameter")
  _meta: Record<string>;
}
