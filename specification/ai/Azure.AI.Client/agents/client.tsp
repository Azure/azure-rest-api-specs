import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@TypeSpec.Versioning.versioned(Azure.AI.Client.Agents.ServiceApiVersions)
namespace Azure.AI.Client.Agents {
  // Trivial response value containers should treat these containers as internal details and instead surface a shimmed
  // operation that exposes the underlying data directly.
  @@clientName(AgentDeletionStatus,
    "InternalAgentDeletionStatus",
    "csharp"
  );
  @@access(deleteAgent, Access.internal, "csharp");
  @@clientName(deleteAgent, "InternalDeleteAgent", "csharp");
  @@access(listAgents, Access.internal, "csharp");
  @@clientName(listAgents, "InternalGetAgents", "csharp");

  // Tool resources
  @@usage(ToolResources, Usage.output);
  @@access(ToolResources, Access.public);

  @@usage(CodeInterpreterToolResource, Usage.output);
  @@access(CodeInterpreterToolResource, Access.public);

  @@usage(FileSearchToolResource, Usage.output);
  @@access(FileSearchToolResource, Access.public);

}