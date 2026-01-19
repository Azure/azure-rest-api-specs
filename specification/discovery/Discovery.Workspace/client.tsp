/**
 * Client customizations for Discovery.Workspace SDK generation.
 *
 * This file addresses accessibility issues with vendored OpenAI/Foundry types
 * to ensure they are properly exposed in generated SDKs.
 */
import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

// Make OpenAI ResponseError and related types public so they can be used
// in public properties like DiscoveryFoundryResponse.error
@@access(OpenAI.ResponseError, Access.public);
@@access(OpenAI.ResponseErrorCode, Access.public);

// Make OpenAI ItemResource and related types public since they are used
// in public properties and extended by Foundry models
@@access(OpenAI.ItemResource, Access.public);
@@access(OpenAI.ItemType, Access.public);

// Make Foundry extension types public
@@access(Azure.AI.Projects.OAuthConsentRequestItemResource, Access.public);
@@access(Azure.AI.Projects.CreatedBy, Access.public);
@@access(Azure.AI.Projects.AgentId, Access.public);
@@access(Azure.AI.Projects.WorkflowActionOutputItemResource, Access.public);
@@access(Azure.AI.Projects.StructuredOutputsItemResource, Access.public);

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

// Additional Workspace types - AZC0012 (generic names)
@@clientName(Microsoft.Discovery.Workspace.Agent, "DiscoveryAgent", "csharp");
@@clientName(Microsoft.Discovery.Workspace.Agents,
  "DiscoveryAgentsClient",
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

// OpenAI vendored types - AZC0012 (generic) and AZC0034 (conflicts with Azure.Core)
@@clientName(OpenAI.Tool, "FoundryTool", "csharp");
@@clientName(OpenAI.Reasoning, "FoundryReasoning", "csharp");
@@clientName(OpenAI.ResponseError, "FoundryResponseError", "csharp");

// AZC0034: Response conflicts with Azure.Response from Azure.Core
@@clientName(OpenAI.Response, "FoundryResponse", "csharp");
@@clientName(OpenAI.CreateResponse, "FoundryCreateResponse", "csharp");
@@clientName(OpenAI.ResponseErrorResponse,
  "FoundryResponseErrorResponse",
  "csharp"
);
@@clientName(OpenAI.ResponseErrorCode, "FoundryResponseErrorCode", "csharp");
@@clientName(OpenAI.ResponseProperties, "FoundryResponseProperties", "csharp");
@@clientName(OpenAI.ResponseFormat, "FoundryResponseFormat", "csharp");
@@clientName(OpenAI.ResponseTextFormatConfiguration,
  "FoundryResponseTextFormatConfiguration",
  "csharp"
);

// AZC0012: Generic names that conflict with BCL types
@@clientName(OpenAI.Location, "FoundryLocation", "csharp");
@@clientName(OpenAI.Coordinate, "FoundryCoordinate", "csharp");
@@clientName(OpenAI.Annotation, "FoundryAnnotation", "csharp");
@@clientName(OpenAI.AnnotationFileCitation,
  "FoundryAnnotationFileCitation",
  "csharp"
);
@@clientName(OpenAI.AnnotationUrlCitation,
  "FoundryAnnotationUrlCitation",
  "csharp"
);
@@clientName(OpenAI.AnnotationFilePath, "FoundryAnnotationFilePath", "csharp");
@@clientName(OpenAI.Prompt, "FoundryPrompt", "csharp");

// =============================================================================
// Java-specific: Rename OpenAI/Foundry Response types to avoid conflicts
// with com.azure.core.http.rest.Response
// =============================================================================
@@clientName(OpenAI.Response, "FoundryResponse", "java");
@@clientName(OpenAI.CreateResponse, "FoundryCreateResponse", "java");
@@clientName(OpenAI.ResponseError, "FoundryResponseError", "java");
@@clientName(OpenAI.ResponseErrorCode, "FoundryResponseErrorCode", "java");
@@clientName(OpenAI.ResponseErrorResponse,
  "FoundryResponseErrorResponse",
  "java"
);
@@clientName(OpenAI.ResponseProperties, "FoundryResponseProperties", "java");
@@clientName(OpenAI.ResponseFormat, "FoundryResponseFormat", "java");
@@clientName(OpenAI.ResponseTextFormatConfiguration,
  "FoundryResponseTextFormatConfiguration",
  "java"
);
@@clientName(OpenAI.ResponsesMessageItemParam,
  "FoundryResponsesMessageItemParam",
  "java"
);
@@clientName(OpenAI.ResponsesMessageItemResource,
  "FoundryResponsesMessageItemResource",
  "java"
);
@@clientName(OpenAI.ResponsesUserMessageItemParam,
  "FoundryResponsesUserMessageItemParam",
  "java"
);
@@clientName(OpenAI.ResponsesUserMessageItemResource,
  "FoundryResponsesUserMessageItemResource",
  "java"
);
@@clientName(OpenAI.ResponsesSystemMessageItemParam,
  "FoundryResponsesSystemMessageItemParam",
  "java"
);
@@clientName(OpenAI.ResponsesSystemMessageItemResource,
  "FoundryResponsesSystemMessageItemResource",
  "java"
);
@@clientName(OpenAI.ResponsesDeveloperMessageItemParam,
  "FoundryResponsesDeveloperMessageItemParam",
  "java"
);
@@clientName(OpenAI.ResponsesDeveloperMessageItemResource,
  "FoundryResponsesDeveloperMessageItemResource",
  "java"
);
@@clientName(OpenAI.ResponsesAssistantMessageItemParam,
  "FoundryResponsesAssistantMessageItemParam",
  "java"
);
@@clientName(OpenAI.ResponsesAssistantMessageItemResource,
  "FoundryResponsesAssistantMessageItemResource",
  "java"
);
