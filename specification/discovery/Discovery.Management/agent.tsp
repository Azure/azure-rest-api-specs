import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-client-generator-core";

import "../Discovery.Management.Shared/all.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ClientGenerator.Core;
using Azure.Core;
using Azure.ResourceManager;

@armProviderNamespace("Microsoft.Discovery")
@versioned(Microsoft.Discovery.Versions)
namespace Microsoft.Discovery;

@removed(Microsoft.Discovery.Versions.v2026_02_01_preview)
@doc("Agent tracked resource")
model Agent is TrackedResource<AgentProperties> {
  ...ResourceNameParameter<Agent>;
}

@removed(Microsoft.Discovery.Versions.v2026_02_01_preview)
@doc("Tool reference")
model ToolReference {
  @doc("The resource ID of the tool.")
  toolId: Microsoft.Discovery.Shared.ToolId;

  @doc("The name of the tool.")
  name: string;
}

@removed(Microsoft.Discovery.Versions.v2026_02_01_preview)
@doc("Agent reference")
model AgentReference {
  @doc("The resource ID of the agent.")
  agentId: Microsoft.Discovery.Shared.AgentId;

  @doc("The name of the agent.")
  name: string;
}

@removed(Microsoft.Discovery.Versions.v2026_02_01_preview)
@doc("KnowledgeBase reference")
model KnowledgeBaseReference {
  @doc("The resource ID of the knowledge base.")
  knowledgeBaseId: string;

  @doc("The name of the knowledge base.")
  name: string;
}

@removed(Microsoft.Discovery.Versions.v2026_02_01_preview)
@doc("Agent list item properties")
model AgentProperties {
  @doc("Reference to the model.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  modelName: string;

  ...DiscoveryResourceProperties;

  @doc("References to other agents.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  agents?: AgentReference[];

  @doc("References to the tools.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  tools?: ToolReference[];

  @doc("References to the knowledgeBases.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  knowledgeBases?: KnowledgeBaseReference[];

  ...WithDefinitionContent;
}

@removed(Microsoft.Discovery.Versions.v2026_02_01_preview)
@armResourceOperations
interface Agents extends DiscoveryResource<Agent, AgentProperties> {}
