/**
 * Client customizations for Discovery.Workspace SDK generation.
 *
 * This file addresses accessibility issues with vendored OpenAI/Foundry types
 * to ensure they are properly exposed in generated SDKs.
 */
import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

// =============================================================================
// Client name customizations to avoid .NET naming conflicts (AZC0012/AZC0034)
// =============================================================================

// AZC0012: Generic names that conflict with BCL types
@@clientName(Microsoft.Discovery.Workspace.Task, "DiscoveryTask", "csharp");
@@clientName(Microsoft.Discovery.Workspace.Tasks,
  "DiscoveryTasksClient",
  "csharp"
);
@@clientName(Microsoft.Discovery.Workspace.Suggestion,
  "DiscoveryChatSuggestion",
  "csharp"
);
@@clientName(Microsoft.Discovery.Workspace.Operation,
  "WorkspaceOperation",
  "csharp"
);
@@clientName(Microsoft.Discovery.Workspace.Tools,
  "DiscoveryToolsClient",
  "csharp"
);

// Shared types
@@clientName(Microsoft.Discovery.DataPlane.Shared.Tag,
  "DiscoveryTag",
  "csharp"
);
@@clientName(Microsoft.Discovery.DataPlane.Shared.ProvisioningState,
  "DiscoveryProvisioningState",
  "csharp"
);

@@clientName(Microsoft.Discovery.Workspace.Conversation,
  "DiscoveryConversation",
  "csharp"
);
@@clientName(Microsoft.Discovery.Workspace.Conversations,
  "DiscoveryConversationsClient",
  "csharp"
);

@@clientName(Microsoft.Discovery.Workspace.Investigation,
  "DiscoveryInvestigation",
  "csharp"
);
@@clientName(Microsoft.Discovery.Workspace.Investigations,
  "DiscoveryInvestigationsClient",
  "csharp"
);
