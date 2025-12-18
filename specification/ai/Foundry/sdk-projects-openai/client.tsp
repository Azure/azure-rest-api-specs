import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

@clientNamespace("Foundry.OpenAI")
namespace Foundry;

// ------------------------------------------------------------------------------------------------
// Operation scope customizations - don't generate OpenAI operations that we'll use the OpenAI client for
// ------------------------------------------------------------------------------------------------
@@scope(Responses.createResponse, "!csharp");
@@scope(Responses.createResponseStream, "!csharp");
@@scope(Responses.getResponseStream, "!csharp");
@@scope(Responses.getResponse, "!csharp");
@@scope(Responses.deleteResponse, "!csharp");
@@scope(Responses.cancelResponse, "!csharp");
@@scope(Responses.listInputItems, "!csharp");
@@scope(Responses.listResponses, "!csharp");

@@scope(Conversations.createConversation, "!csharp");
@@scope(Conversations.listConversations, "!csharp");
@@scope(Conversations.updateConversation, "!csharp");
@@scope(Conversations.getConversation, "!csharp");
@@scope(Conversations.deleteConversation, "!csharp");
@@scope(Conversations.createConversationItems, "!csharp");
@@scope(Conversations.listConversationItems, "!csharp");
@@scope(Conversations.getConversationItem, "!csharp");
@@scope(Conversations.deleteConversationItem, "!csharp");

@@usage(OpenAI.ConversationResource, Usage.output);
@@access(OpenAI.ConversationResource, Access.public);
@@usage(ConversationList, Usage.output);
@@access(ConversationList, Access.public);
@@usage(OpenAI.CreateConversationRequest, Usage.input);
@@access(OpenAI.CreateConversationRequest, Access.public);
@@usage(OpenAI.UpdateConversationRequest, Usage.input);
@@access(OpenAI.UpdateConversationRequest, Access.public);

// --------------------------------------------------------------------------------
// Root client
// --------------------------------------------------------------------------------
@@clientName(OpenAI, "ProjectOpenAIClient");

@@clientName(BingGroundingSearchToolParameters,
  "BingGroundingSearchToolOptions"
);
@@clientName(ContainerAppAgentDefinition,
  "ContainerApplicationAgentDefinition"
);
@@clientName(FabricDataAgentToolParameters, "FabricDataAgentToolOptions");

@@clientName(MemorySearchOptions, "MemorySearchToolOptions");
@@clientName(MemorySearchToolCallItemResource,
  "MemorySearchToolCallResponseItem"
);
@@clientName(OAuthConsentRequestItemResource,
  "OAuthConsentRequestResponseItem"
);
@@clientName(OpenApiAgentTool, "OpenAPIAgentTool");
@@clientName(OpenApiAnonymousAuthDetails,
  "OpenAPIAnonymousAuthenticationDetails"
);
@@clientName(OpenApiAuthDetails, "OpenAPIAuthenticationDetails");
@@clientName(OpenApiFunctionDefinition, "OpenAPIFunctionDefinition");
@@clientName(OpenApiManagedAuthDetails, "OpenAPIManagedAuthenticationDetails");
@@clientName(OpenApiProjectConnectionAuthDetails,
  "OpenAPIProjectConnectionAuthenticationDetails"
);
@@clientName(OpenApiProjectConnectionSecurityScheme,
  "OpenAPIProjectConnectionSecurityScheme"
);
@@clientName(RaiConfig, "ContentFilterConfiguration");
@@clientName(SharepointGroundingToolParameters,
  "SharePointGroundingToolOptions"
);
@@clientName(ToolArgumentBinding, "StructuredInputToolArgumentBinding");

// --------------------------------------------------------------------------------
// Usage / Public accessibility overrides
// --------------------------------------------------------------------------------

@@usage(OpenAI.ItemResource, Usage.json);
@@usage(OpenAI.ResponseStreamEvent, Usage.json);

@@usage(AgentId, Usage.output);
@@access(AgentId, Access.public);

@@usage(AgentReference, Usage.input);
@@access(AgentReference, Access.public);

@@usage(ApiError, Usage.output);
@@access(ApiError, Access.public);

@@usage(AgentDefinition, Usage.input | Usage.output);
@@access(AgentDefinition, Access.public);
@@usage(PromptAgentDefinition, Usage.input | Usage.output);
@@access(PromptAgentDefinition, Access.public);

@@usage(AgentObject, Usage.output);
@@access(AgentObject, Access.public);
@@clientName(AgentObject, "AgentRecord");

@@usage(AgentVersionObject, Usage.output);
@@access(AgentVersionObject, Access.public);
@@clientName(AgentVersionObject, "AgentVersion");
