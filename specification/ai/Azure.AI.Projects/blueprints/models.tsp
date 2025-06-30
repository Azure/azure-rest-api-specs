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
@added(Versions.v1)
model AgentBlueprint {
  ...AssetBase;

  @doc("display name of the blueprint")
  displayName: string;

  @doc("System related metadata")
  @visibility(Lifecycle.Read)
  SystemData?: SystemData;

  @doc("Catalog information for the agent")
  catalogInfo: AgentBlueprintCatalogInformation;

  @doc("Instructions for deploying the agent")
  implementation: AgentImplementationDetails;

  @doc("Dependencies for the agent")
  dependencies?: Record<BaseAgentDependency>;

  @doc("Parameters for the agent")
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
  assetId: Record<string>;

  @doc("optional description of how the blueprint will use the tool")
  description?: string;
}

@doc("Catalog information for the agent blueprint")
model AgentBlueprintCatalogInformation {
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
