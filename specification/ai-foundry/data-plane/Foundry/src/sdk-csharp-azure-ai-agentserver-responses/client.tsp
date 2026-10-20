import "./main.tsp";

using Azure.ClientGenerator.Core;
using Azure.Core.Experimental;

// Map all OpenAI base types into our SDK namespace
@clientNamespace("Azure.AI.AgentServer.Responses.Models")
namespace OpenAI {
  // The responses view does not export ItemResourceType (only the full src does).
  // Bridge the gap with an alias so the Azure augmentations can reference it.
  alias ItemResourceType = OutputItemType;
}

// Map Azure.AI.Projects augmentation types into our SDK namespace
@clientNamespace("Azure.AI.AgentServer.Responses.Models")
namespace Azure.AI.Projects {
  // The single-value `ResponseObjectType` union is otherwise emitted as a fixed enum that the emitter
  // initializes with a string literal (`ResponseObjectType Object { get; } = "response"`), which does not compile.
  @@alternateType(Azure.AI.Projects.ResponseObjectType, string, "csharp");

  // ============================================================================
  // Public constructors: mark models as input+output so the C# emitter generates
  // public compact constructors. Consumers need these to construct events in their
  // ResponseHandler implementations.
  // ============================================================================

  // --- CreateResponse ---
  // CreateResponse is alt-typed to the OpenAI SDK, but this usage still has to be
  // declared: it is what marks the request-side types reachable only through it
  // (session affinity, routing, moderation, ...) as inputs. Dropping it leaves
  // those types without Input usage.
  @@usage(OpenAI.CreateResponse, Usage.input | Usage.output);

  // --- API envelope types (server needs to construct these) ---
  @@usage(Azure.AI.Projects.DeleteResponseResult, Usage.input | Usage.output);

  // --- OpenAI OutputItem subtypes that lead to locally emitted types ---
  // The OutputItem base is alt-typed to OpenAI.Responses.ResponseItem, so these subtypes are
  // not emitted themselves. The usage is still needed because it propagates to their property
  // types, and some of those have no OpenAI SDK mapping below and are emitted locally (apply-patch
  // operations, shell actions and outcomes, web-search actions, message and reasoning content,
  // MCP list-tools entries, ...). Without Input usage those types would get internal constructors.
  // OutputItem subtypes whose property types are all mapped to OpenAI (function call, MCP tool call,
  // image generation, compaction, ...) are deliberately not listed: a usage on them changes nothing.
  @@usage(OpenAI.OutputItemApplyPatchToolCall, Usage.input | Usage.output);
  @@usage(OpenAI.OutputItemCodeInterpreterToolCall, Usage.input | Usage.output);
  @@usage(OpenAI.OutputItemComputerToolCall, Usage.input | Usage.output);
  @@usage(OpenAI.OutputItemFileSearchToolCall, Usage.input | Usage.output);
  @@usage(OpenAI.OutputItemFunctionShellCall, Usage.input | Usage.output);
  @@usage(OpenAI.OutputItemFunctionShellCallOutput, Usage.input | Usage.output);
  @@usage(OpenAI.OutputItemLocalShellToolCall, Usage.input | Usage.output);
  @@usage(OpenAI.OutputItemMcpListTools, Usage.input | Usage.output);
  @@usage(OpenAI.OutputItemMessage, Usage.input | Usage.output);
  @@usage(OpenAI.OutputItemReasoningItem, Usage.input | Usage.output);
  @@usage(OpenAI.OutputItemWebSearchToolCall, Usage.input | Usage.output);
  @@usage(OpenAI.FunctionAndCustomToolCallOutput, Usage.input | Usage.output);

  // ---------------------------------------------------------------------
  // Shared-type ownership: consume concrete models from their owning
  // packages rather than re-emitting duplicates.
  //   OpenAI SDK                -> official Responses/Containers models
  //   Azure.AI.Extensions.OpenAI -> Azure-specific Foundry tool models
  // Types with no upstream owner (for example apply_patch, shell, web-search
  // actions, message content, moderation, content filter results and prompt
  // cache diagnostics) remain AgentServer-emitted.
  // ---------------------------------------------------------------------

  @@alternateType(
    OpenAI.OutputItemType,
    {
      identity: "OpenAI.Responses.ResponseItemKind",
      package: "OpenAI",
      minVersion: "2.12.0",
    },
    "csharp"
  );
  @@alternateType(
    OpenAI.ToolType,
    {
      identity: "OpenAI.Responses.ResponseToolKind",
      package: "OpenAI",
      minVersion: "2.12.0",
    },
    "csharp"
  );
  @@alternateType(
    OpenAI.OutputItem,
    {
      identity: "OpenAI.Responses.ResponseItem",
      package: "OpenAI",
      minVersion: "2.12.0",
    },
    "csharp"
  );
  @@alternateType(
    OpenAI.InputItem,
    {
      identity: "OpenAI.Responses.ResponseItem",
      package: "OpenAI",
      minVersion: "2.12.0",
    },
    "csharp"
  );
  @@alternateType(
    OpenAI.ItemMessage,
    {
      identity: "OpenAI.Responses.MessageResponseItem",
      package: "OpenAI",
      minVersion: "2.12.0",
    },
    "csharp"
  );
  @@alternateType(
    OpenAI.Tool,
    {
      identity: "OpenAI.Responses.ResponseTool",
      package: "OpenAI",
      minVersion: "2.12.0",
    },
    "csharp"
  );
  @@alternateType(
    OpenAI.Response,
    {
      identity: "OpenAI.Responses.ResponseResult",
      package: "OpenAI",
      minVersion: "2.12.0",
    },
    "csharp"
  );
  @@alternateType(
    OpenAI.ResponseError,
    {
      identity: "OpenAI.Responses.ResponseError",
      package: "OpenAI",
      minVersion: "2.12.0",
    },
    "csharp"
  );
  @@alternateType(
    OpenAI.ResponseErrorCode,
    {
      identity: "OpenAI.Responses.ResponseErrorCode",
      package: "OpenAI",
      minVersion: "2.12.0",
    },
    "csharp"
  );
  @@alternateType(
    OpenAI.CreateResponse,
    {
      identity: "OpenAI.Responses.CreateResponseOptions",
      package: "OpenAI",
      minVersion: "2.12.0",
    },
    "csharp"
  );
  @@alternateType(
    OpenAI.ResponseStreamEvent,
    {
      identity: "OpenAI.Responses.StreamingResponseUpdate",
      package: "OpenAI",
      minVersion: "2.12.0",
    },
    "csharp"
  );
  @@alternateType(
    OpenAI.ContainerNetworkPolicyParam,
    {
      identity: "OpenAI.Containers.ContainerNetworkPolicy",
      package: "OpenAI",
      minVersion: "2.12.0",
    },
    "csharp"
  );
  @@alternateType(
    OpenAI.ContainerNetworkPolicyAllowlistParam,
    {
      identity: "OpenAI.Containers.ContainerAllowlistNetworkPolicy",
      package: "OpenAI",
      minVersion: "2.12.0",
    },
    "csharp"
  );
  @@alternateType(
    OpenAI.ContainerNetworkPolicyDisabledParam,
    {
      identity: "OpenAI.Containers.ContainerDisabledNetworkPolicy",
      package: "OpenAI",
      minVersion: "2.12.0",
    },
    "csharp"
  );
  @@alternateType(
    OpenAI.ContainerNetworkPolicyDomainSecretParam,
    {
      identity: "OpenAI.Containers.ContainerNetworkPolicyDomainSecret",
      package: "OpenAI",
      minVersion: "2.12.0",
    },
    "csharp"
  );
  @@alternateType(
    OpenAI.ContainerMemoryLimit,
    {
      identity: "OpenAI.Containers.ContainerMemoryLimit",
      package: "OpenAI",
      minVersion: "2.12.0",
    },
    "csharp"
  );
  @@alternateType(
    OpenAI.MCPToolFilter,
    {
      identity: "OpenAI.Responses.McpToolFilter",
      package: "OpenAI",
      minVersion: "2.12.0",
    },
    "csharp"
  );
  @@alternateType(
    AgentReference,
    {
      identity: "Azure.AI.Extensions.OpenAI.AgentReference",
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-beta.1",
    },
    "csharp"
  );
  @@alternateType(
    A2APreviewTool,
    {
      identity: "Azure.AI.Extensions.OpenAI.A2APreviewTool",
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-beta.1",
    },
    "csharp"
  );
  @@alternateType(
    A2AToolCall,
    {
      identity: "Azure.AI.Extensions.OpenAI.A2AToolCall",
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-beta.1",
    },
    "csharp"
  );
  @@alternateType(
    A2AToolCallOutput,
    {
      identity: "Azure.AI.Extensions.OpenAI.A2AToolCallOutput",
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-beta.1",
    },
    "csharp"
  );
  @@alternateType(
    AzureAISearchTool,
    {
      identity: "Azure.AI.Extensions.OpenAI.AzureAISearchTool",
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-beta.1",
    },
    "csharp"
  );
  @@alternateType(
    AzureAISearchToolCall,
    {
      identity: "Azure.AI.Extensions.OpenAI.AzureAISearchToolCall",
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-beta.1",
    },
    "csharp"
  );
  @@alternateType(
    AzureAISearchToolCallOutput,
    {
      identity: "Azure.AI.Extensions.OpenAI.AzureAISearchToolCallOutput",
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-beta.1",
    },
    "csharp"
  );
  @@alternateType(
    AzureFunctionTool,
    {
      identity: "Azure.AI.Extensions.OpenAI.AzureFunctionTool",
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-beta.1",
    },
    "csharp"
  );
  @@alternateType(
    AzureFunctionToolCall,
    {
      identity: "Azure.AI.Extensions.OpenAI.AzureFunctionToolCall",
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-beta.1",
    },
    "csharp"
  );
  @@alternateType(
    AzureFunctionToolCallOutput,
    {
      identity: "Azure.AI.Extensions.OpenAI.AzureFunctionToolCallOutput",
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-beta.1",
    },
    "csharp"
  );
  @@alternateType(
    BingCustomSearchPreviewTool,
    {
      identity: "Azure.AI.Extensions.OpenAI.BingCustomSearchPreviewTool",
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-beta.1",
    },
    "csharp"
  );
  @@alternateType(
    BingCustomSearchToolCall,
    {
      identity: "Azure.AI.Extensions.OpenAI.BingCustomSearchToolCall",
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-beta.1",
    },
    "csharp"
  );
  @@alternateType(
    BingCustomSearchToolCallOutput,
    {
      identity: "Azure.AI.Extensions.OpenAI.BingCustomSearchToolCallOutput",
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-beta.1",
    },
    "csharp"
  );
  @@alternateType(
    BingGroundingTool,
    {
      identity: "Azure.AI.Extensions.OpenAI.BingGroundingTool",
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-beta.1",
    },
    "csharp"
  );
  @@alternateType(
    BingGroundingToolCall,
    {
      identity: "Azure.AI.Extensions.OpenAI.BingGroundingToolCall",
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-beta.1",
    },
    "csharp"
  );
  @@alternateType(
    BingGroundingToolCallOutput,
    {
      identity: "Azure.AI.Extensions.OpenAI.BingGroundingToolCallOutput",
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-beta.1",
    },
    "csharp"
  );
  @@alternateType(
    BrowserAutomationPreviewTool,
    {
      identity: "Azure.AI.Extensions.OpenAI.BrowserAutomationPreviewTool",
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-beta.1",
    },
    "csharp"
  );
  @@alternateType(
    BrowserAutomationToolCall,
    {
      identity: "Azure.AI.Extensions.OpenAI.BrowserAutomationToolCall",
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-beta.1",
    },
    "csharp"
  );
  @@alternateType(
    BrowserAutomationToolCallOutput,
    {
      identity: "Azure.AI.Extensions.OpenAI.BrowserAutomationToolCallOutput",
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-beta.1",
    },
    "csharp"
  );
  @@alternateType(
    CaptureStructuredOutputsTool,
    {
      identity: "Azure.AI.Extensions.OpenAI.CaptureStructuredOutputsTool",
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-beta.1",
    },
    "csharp"
  );
  @@alternateType(
    FabricDataAgentToolCall,
    {
      identity: "Azure.AI.Extensions.OpenAI.FabricDataAgentToolCall",
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-beta.1",
    },
    "csharp"
  );
  @@alternateType(
    FabricDataAgentToolCallOutput,
    {
      identity: "Azure.AI.Extensions.OpenAI.FabricDataAgentToolCallOutput",
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-beta.1",
    },
    "csharp"
  );
  @@alternateType(
    FabricIQPreviewTool,
    {
      identity: "Azure.AI.Extensions.OpenAI.FabricIQPreviewTool",
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-beta.1",
    },
    "csharp"
  );
  @@alternateType(
    MemoryCommandToolCall,
    {
      identity: "Azure.AI.Extensions.OpenAI.MemoryCommandToolCall",
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-beta.1",
    },
    "csharp"
  );
  @@alternateType(
    MemoryCommandToolCallOutput,
    {
      identity: "Azure.AI.Extensions.OpenAI.MemoryCommandToolCallOutput",
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-beta.1",
    },
    "csharp"
  );
  @@alternateType(
    MemorySearchPreviewTool,
    {
      identity: "Azure.AI.Extensions.OpenAI.MemorySearchPreviewTool",
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-beta.1",
    },
    "csharp"
  );
  @@alternateType(
    MemorySearchToolCall,
    {
      identity: "Azure.AI.Extensions.OpenAI.MemorySearchToolCall",
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-beta.1",
    },
    "csharp"
  );
  @@alternateType(
    MicrosoftFabricPreviewTool,
    {
      identity: "Azure.AI.Extensions.OpenAI.MicrosoftFabricPreviewTool",
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-beta.1",
    },
    "csharp"
  );
  @@alternateType(
    OpenApiTool,
    {
      identity: "Azure.AI.Extensions.OpenAI.OpenApiTool",
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-beta.1",
    },
    "csharp"
  );
  @@alternateType(
    OpenApiToolCall,
    {
      identity: "Azure.AI.Extensions.OpenAI.OpenApiToolCall",
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-beta.1",
    },
    "csharp"
  );
  @@alternateType(
    OpenApiToolCallOutput,
    {
      identity: "Azure.AI.Extensions.OpenAI.OpenApiToolCallOutput",
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-beta.1",
    },
    "csharp"
  );
  @@alternateType(
    SharepointPreviewTool,
    {
      identity: "Azure.AI.Extensions.OpenAI.SharePointPreviewTool",
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-beta.1",
    },
    "csharp"
  );
  @@alternateType(
    SharepointGroundingToolCall,
    {
      identity: "Azure.AI.Extensions.OpenAI.SharePointGroundingToolCall",
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-beta.1",
    },
    "csharp"
  );
  @@alternateType(
    SharepointGroundingToolCallOutput,
    {
      identity: "Azure.AI.Extensions.OpenAI.SharePointGroundingToolCallOutput",
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-beta.1",
    },
    "csharp"
  );
  @@alternateType(
    WorkIQPreviewTool,
    {
      identity: "Azure.AI.Extensions.OpenAI.WorkIQPreviewTool",
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-beta.1",
    },
    "csharp"
  );
  @@alternateType(
    OAuthConsentRequestOutputItem,
    {
      identity: "Azure.AI.Extensions.OpenAI.OAuthConsentRequestResponseItem",
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-beta.1",
    },
    "csharp"
  );
  @@alternateType(
    StructuredOutputsOutputItem,
    {
      identity: "Azure.AI.Extensions.OpenAI.AgentStructuredOutputsResponseItem",
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-beta.1",
    },
    "csharp"
  );
  @@alternateType(
    WorkflowActionOutputItem,
    {
      identity: "Azure.AI.Extensions.OpenAI.AgentWorkflowPreviewActionResponseItem",
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-beta.1",
    },
    "csharp"
  );
}

// ApiErrorResponse is part of the AgentServer.Responses wire contract but is unreachable from
// this package's operations, so it needs an explicit usage to be emitted.
@@usage(Azure.AI.Projects.ApiErrorResponse, Usage.input | Usage.output);

// These are surfaced on this package's public hosting API (ResponseStreamEvent.EventType and
// the tool-choice extension helpers), so they must not be emitted as internal.
@@access(OpenAI.ToolChoiceParam, Access.public);

// ============================================================================
// Stream event subtypes -> OpenAI.Responses.Streaming*Update.
// OpenAI's StreamingResponseUpdate has a single `private protected` constructor, so no
// external assembly can derive from it. Every emitted subtype must therefore be replaced
// by its OpenAI counterpart. Never map a subtype to the base StreamingResponseUpdate: its
// parent ResponseStreamEvent already maps there, so the generator would see the external
// model as its own base type and loop forever walking the base chain.
// ============================================================================
@@alternateType(
  OpenAI.ResponseAudioDeltaEvent,
  {
    identity: "OpenAI.Responses.StreamingResponseAudioDeltaUpdate",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.ResponseAudioDoneEvent,
  {
    identity: "OpenAI.Responses.StreamingResponseAudioDoneUpdate",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.ResponseAudioTranscriptDeltaEvent,
  {
    identity: "OpenAI.Responses.StreamingResponseAudioTranscriptDeltaUpdate",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.ResponseAudioTranscriptDoneEvent,
  {
    identity: "OpenAI.Responses.StreamingResponseAudioTranscriptDoneUpdate",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.ResponseCodeInterpreterCallCodeDeltaEvent,
  {
    identity: "OpenAI.Responses.StreamingResponseCodeInterpreterCallCodeDeltaUpdate",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.ResponseCodeInterpreterCallCodeDoneEvent,
  {
    identity: "OpenAI.Responses.StreamingResponseCodeInterpreterCallCodeDoneUpdate",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.ResponseCodeInterpreterCallCompletedEvent,
  {
    identity: "OpenAI.Responses.StreamingResponseCodeInterpreterCallCompletedUpdate",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.ResponseCodeInterpreterCallInProgressEvent,
  {
    identity: "OpenAI.Responses.StreamingResponseCodeInterpreterCallInProgressUpdate",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.ResponseCodeInterpreterCallInterpretingEvent,
  {
    identity: "OpenAI.Responses.StreamingResponseCodeInterpreterCallInterpretingUpdate",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.ResponseCompletedEvent,
  {
    identity: "OpenAI.Responses.StreamingResponseCompletedUpdate",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.ResponseContentPartAddedEvent,
  {
    identity: "OpenAI.Responses.StreamingResponseContentPartAddedUpdate",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.ResponseContentPartDoneEvent,
  {
    identity: "OpenAI.Responses.StreamingResponseContentPartDoneUpdate",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.ResponseCreatedEvent,
  {
    identity: "OpenAI.Responses.StreamingResponseCreatedUpdate",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.ResponseCustomToolCallInputDeltaEvent,
  {
    identity: "OpenAI.Responses.StreamingResponseCustomToolCallInputDeltaUpdate",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.ResponseCustomToolCallInputDoneEvent,
  {
    identity: "OpenAI.Responses.StreamingResponseCustomToolCallInputDoneUpdate",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.ResponseErrorEvent,
  {
    identity: "OpenAI.Responses.StreamingResponseErrorUpdate",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.ResponseFailedEvent,
  {
    identity: "OpenAI.Responses.StreamingResponseFailedUpdate",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.ResponseFileSearchCallCompletedEvent,
  {
    identity: "OpenAI.Responses.StreamingResponseFileSearchCallCompletedUpdate",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.ResponseFileSearchCallInProgressEvent,
  {
    identity: "OpenAI.Responses.StreamingResponseFileSearchCallInProgressUpdate",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.ResponseFileSearchCallSearchingEvent,
  {
    identity: "OpenAI.Responses.StreamingResponseFileSearchCallSearchingUpdate",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.ResponseFunctionCallArgumentsDeltaEvent,
  {
    identity: "OpenAI.Responses.StreamingResponseFunctionCallArgumentsDeltaUpdate",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.ResponseFunctionCallArgumentsDoneEvent,
  {
    identity: "OpenAI.Responses.StreamingResponseFunctionCallArgumentsDoneUpdate",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.ResponseImageGenCallCompletedEvent,
  {
    identity: "OpenAI.Responses.StreamingResponseImageGenerationCallCompletedUpdate",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.ResponseImageGenCallGeneratingEvent,
  {
    identity: "OpenAI.Responses.StreamingResponseImageGenerationCallGeneratingUpdate",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.ResponseImageGenCallInProgressEvent,
  {
    identity: "OpenAI.Responses.StreamingResponseImageGenerationCallInProgressUpdate",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.ResponseImageGenCallPartialImageEvent,
  {
    identity: "OpenAI.Responses.StreamingResponseImageGenerationCallPartialImageUpdate",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.ResponseInProgressEvent,
  {
    identity: "OpenAI.Responses.StreamingResponseInProgressUpdate",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.ResponseIncompleteEvent,
  {
    identity: "OpenAI.Responses.StreamingResponseIncompleteUpdate",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.ResponseMCPCallArgumentsDeltaEvent,
  {
    identity: "OpenAI.Responses.StreamingResponseMcpCallArgumentsDeltaUpdate",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.ResponseMCPCallArgumentsDoneEvent,
  {
    identity: "OpenAI.Responses.StreamingResponseMcpCallArgumentsDoneUpdate",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.ResponseMCPCallCompletedEvent,
  {
    identity: "OpenAI.Responses.StreamingResponseMcpCallCompletedUpdate",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.ResponseMCPCallFailedEvent,
  {
    identity: "OpenAI.Responses.StreamingResponseMcpCallFailedUpdate",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.ResponseMCPCallInProgressEvent,
  {
    identity: "OpenAI.Responses.StreamingResponseMcpCallInProgressUpdate",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.ResponseMCPListToolsCompletedEvent,
  {
    identity: "OpenAI.Responses.StreamingResponseMcpListToolsCompletedUpdate",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.ResponseMCPListToolsFailedEvent,
  {
    identity: "OpenAI.Responses.StreamingResponseMcpListToolsFailedUpdate",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.ResponseMCPListToolsInProgressEvent,
  {
    identity: "OpenAI.Responses.StreamingResponseMcpListToolsInProgressUpdate",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.ResponseOutputItemAddedEvent,
  {
    identity: "OpenAI.Responses.StreamingResponseOutputItemAddedUpdate",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.ResponseOutputItemDoneEvent,
  {
    identity: "OpenAI.Responses.StreamingResponseOutputItemDoneUpdate",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.ResponseOutputTextAnnotationAddedEvent,
  {
    identity: "OpenAI.Responses.StreamingResponseOutputTextAnnotationAddedUpdate",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.ResponseQueuedEvent,
  {
    identity: "OpenAI.Responses.StreamingResponseQueuedUpdate",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.ResponseReasoningSummaryPartAddedEvent,
  {
    identity: "OpenAI.Responses.StreamingResponseReasoningSummaryPartAddedUpdate",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.ResponseReasoningSummaryPartDoneEvent,
  {
    identity: "OpenAI.Responses.StreamingResponseReasoningSummaryPartDoneUpdate",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.ResponseReasoningSummaryTextDeltaEvent,
  {
    identity: "OpenAI.Responses.StreamingResponseReasoningSummaryTextDeltaUpdate",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.ResponseReasoningSummaryTextDoneEvent,
  {
    identity: "OpenAI.Responses.StreamingResponseReasoningSummaryTextDoneUpdate",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.ResponseReasoningTextDeltaEvent,
  {
    identity: "OpenAI.Responses.StreamingResponseReasoningTextDeltaUpdate",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.ResponseReasoningTextDoneEvent,
  {
    identity: "OpenAI.Responses.StreamingResponseReasoningTextDoneUpdate",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.ResponseRefusalDeltaEvent,
  {
    identity: "OpenAI.Responses.StreamingResponseRefusalDeltaUpdate",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.ResponseRefusalDoneEvent,
  {
    identity: "OpenAI.Responses.StreamingResponseRefusalDoneUpdate",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.ResponseTextDeltaEvent,
  {
    identity: "OpenAI.Responses.StreamingResponseOutputTextDeltaUpdate",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.ResponseTextDoneEvent,
  {
    identity: "OpenAI.Responses.StreamingResponseOutputTextDoneUpdate",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.ResponseWebSearchCallCompletedEvent,
  {
    identity: "OpenAI.Responses.StreamingResponseWebSearchCallCompletedUpdate",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.ResponseWebSearchCallInProgressEvent,
  {
    identity: "OpenAI.Responses.StreamingResponseWebSearchCallInProgressUpdate",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.ResponseWebSearchCallSearchingEvent,
  {
    identity: "OpenAI.Responses.StreamingResponseWebSearchCallSearchingUpdate",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);

@@alternateType(
  OpenAI.ResponseStreamEventType,
  {
    identity: "OpenAI.Responses.StreamingResponseUpdateKind",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);

// ============================================================================
// Remaining Azure models that have exact OpenAI counterparts. Mapping them
// keeps a single representation on the wire-facing surface instead of forcing
// conversions between two structurally identical types.
// ============================================================================
@@alternateType(
  OpenAI.Annotation,
  {
    identity: "OpenAI.Responses.ResponseMessageAnnotation",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.ComputerAction,
  {
    identity: "OpenAI.Responses.ComputerCallAction",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.ConversationParam,
  {
    identity: "OpenAI.Responses.ResponseConversationOptions",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.ResponseUsage,
  {
    identity: "OpenAI.Responses.ResponseTokenUsage",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);

// The per-item `status` enums (code interpreter / file search / reasoning / web search) are
// inline unions in the spec, so they have no addressable TypeSpec name to map. They stay
// Azure-generated and are converted at the call sites that hand them to OpenAI types.

// The custom-tool-call items have no counterpart in the OpenAI library, but they cannot be
// emitted either: their base `OpenAI.Responses.ResponseItem` only exposes a
// `protected internal ResponseItem(ResponseItemKind)` constructor, so an emitted subclass
// cannot pass this package's Azure attribution fields to it. They are hand-written in
// src/Custom/Models instead, deriving from ResponseItem and carrying the Azure attribution
// over JsonPatch like the other attribution members in this package.
@@alternateType(
  OpenAI.CustomToolCallResource,
  {
    identity: "Azure.AI.AgentServer.Responses.OutputItemCustomToolCall",
  },
  "csharp"
);
@@alternateType(
  OpenAI.CustomToolCallOutputResource,
  {
    identity: "Azure.AI.AgentServer.Responses.OutputItemCustomToolCallOutput",
  },
  "csharp"
);
