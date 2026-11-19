import "./main.tsp";
import "@typespec/http-client";

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
  @@clientNamespace(
    Azure.AI.ProjectsInternal,
    "Azure.AI.AgentServer.Responses.Models",
    "csharp"
  );

  // The single-value `ResponseObjectType` union is otherwise emitted as a fixed enum that the emitter
  // initializes with a string literal (`ResponseObjectType Object { get; } = "response"`), which does not compile.
  @@alternateType(Azure.AI.Projects.ResponseObjectType, string, "csharp");

  // ============================================================================
  // Public constructors: mark models as input+output so the C# emitter generates
  // public compact constructors. Consumers need these to construct events in their
  // ResponseHandler implementations.
  // ============================================================================

  // --- API envelope types (server needs to construct these) ---
  @@usage(Azure.AI.Projects.DeleteResponseResult, Usage.input | Usage.output);

  // ---------------------------------------------------------------------
  // Shared-type ownership: consume concrete models from their owning
  // packages rather than re-emitting duplicates.
  //   OpenAI SDK                -> official Responses/Containers models
  //   Azure.AI.Extensions.OpenAI -> Azure-specific Foundry tool models
  // Types with no public upstream owner are mapped to System.Object when nothing
  // in the public surface uses them (see the mapping section below).
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
// this package's operations, so it needs an explicit usage to be emitted. No public API takes or
// returns it (the server writes error bodies itself), so it is emitted as internal.
@@usage(Azure.AI.Projects.ApiErrorResponse, Usage.input | Usage.output);
@@access(Azure.AI.Projects.ApiErrorResponse, Access.internal, "csharp");

// The C# generator renames public models that end in "Response" to "Result" unless the name is
// exact. Keep ApiErrorResponse as is: it is already the public name of this error envelope.
@@clientName(
  Azure.AI.Projects.ApiErrorResponse,
  Azure.ClientGenerator.Core.exact("ApiErrorResponse"),
  "csharp"
);

// ApiErrorResponse.error is OpenAI.Error, which the Azure.AI.Projects spec aliases as ApiError.
// Emit it under that name: this package maps the simple name Error to
// OpenAI.Responses.ResponseError, so a generated type named Error would be shadowed.
@@clientName(OpenAI.Error, "ApiError");

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

// The custom-tool-call items map to the OpenAI library's own item types. Azure-only fields
// (namespace, caller, async) are exposed through extension accessors over their JsonPatch.
@@alternateType(
  OpenAI.CustomToolCallResource,
  {
    identity: "OpenAI.Responses.CustomToolCallItem",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.CustomToolCallOutputResource,
  {
    identity: "OpenAI.Responses.CustomToolCallOutputItem",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);

// ============================================================================
// OPENAI001 forwarding.
// The OpenAI.Responses types mapped above are [Experimental("OPENAI001")] in the OpenAI library.
// Annotating their sources tells the C# emitter, so generated code that references them is
// compiled with targeted OPENAI001 suppressions instead of a package-wide one. No attribute is
// emitted for these: their declarations live in the OpenAI library.
// ============================================================================
@@TypeSpec.HttpClient.experimental(
  OpenAI.OutputItem,
  #{ emitterScope: "@typespec/http-client-csharp", diagnosticId: "OPENAI001" }
);
@@TypeSpec.HttpClient.experimental(
  OpenAI.InputItem,
  #{ emitterScope: "@typespec/http-client-csharp", diagnosticId: "OPENAI001" }
);
@@TypeSpec.HttpClient.experimental(
  OpenAI.ItemMessage,
  #{ emitterScope: "@typespec/http-client-csharp", diagnosticId: "OPENAI001" }
);
@@TypeSpec.HttpClient.experimental(
  OpenAI.Tool,
  #{ emitterScope: "@typespec/http-client-csharp", diagnosticId: "OPENAI001" }
);
@@TypeSpec.HttpClient.experimental(
  OpenAI.Response,
  #{ emitterScope: "@typespec/http-client-csharp", diagnosticId: "OPENAI001" }
);
@@TypeSpec.HttpClient.experimental(
  OpenAI.ResponseError,
  #{ emitterScope: "@typespec/http-client-csharp", diagnosticId: "OPENAI001" }
);
@@TypeSpec.HttpClient.experimental(
  OpenAI.Annotation,
  #{ emitterScope: "@typespec/http-client-csharp", diagnosticId: "OPENAI001" }
);
@@TypeSpec.HttpClient.experimental(
  OpenAI.ComputerAction,
  #{ emitterScope: "@typespec/http-client-csharp", diagnosticId: "OPENAI001" }
);
@@TypeSpec.HttpClient.experimental(
  OpenAI.ConversationParam,
  #{ emitterScope: "@typespec/http-client-csharp", diagnosticId: "OPENAI001" }
);
@@TypeSpec.HttpClient.experimental(
  OpenAI.ResponseUsage,
  #{ emitterScope: "@typespec/http-client-csharp", diagnosticId: "OPENAI001" }
);

// ============================================================================
// Models pulled in by the @@usage roots and operations that no public member of this package
// takes or returns (handlers, providers, builders and extension accessors expose OpenAI types).
// Reuse the OpenAI SDK type where one exists; mapping a parent (ApplyPatchFileOperation,
// ItemField, MessageContent, ToolChoiceParam, ...) also drops its dependent child types.
// Types with no public OpenAI equivalent are mapped to System.Object so no class is generated.
// ============================================================================
@@alternateType(
  OpenAI.ApplyPatchFileOperation,
  {
    identity: "OpenAI.Responses.ApplyPatchOperation",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.ApplyPatchCreateFileOperation,
  {
    identity: "OpenAI.Responses.ApplyPatchCreateFileOperation",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.ApplyPatchDeleteFileOperation,
  {
    identity: "OpenAI.Responses.ApplyPatchDeleteFileOperation",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.ApplyPatchUpdateFileOperation,
  {
    identity: "OpenAI.Responses.ApplyPatchUpdateFileOperation",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.CodeInterpreterOutputImage,
  {
    identity: "OpenAI.Responses.CodeInterpreterCallImageOutput",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.CodeInterpreterOutputLogs,
  {
    identity: "OpenAI.Responses.CodeInterpreterCallLogsOutput",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.ComputerCallSafetyCheckParam,
  {
    identity: "OpenAI.Responses.ComputerCallSafetyCheck",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.FileSearchToolCallResults,
  {
    identity: "OpenAI.Responses.FileSearchCallResult",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.FunctionCallOutputStatusEnum,
  {
    identity: "OpenAI.Responses.FunctionCallOutputStatus",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.FunctionCallStatus,
  {
    identity: "OpenAI.Responses.FunctionCallStatus",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.ImageBackground,
  {
    identity: "OpenAI.Responses.ImageGenerationToolBackground",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.ImageDetail,
  {
    identity: "OpenAI.Responses.ResponseImageDetailLevel",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.ImageGenActionEnum,
  {
    identity: "OpenAI.Responses.ImageGenerationToolAction",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.ImageOutputFormat,
  {
    identity: "OpenAI.Responses.ImageGenerationToolOutputFileFormat",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.ItemField,
  {
    identity: "OpenAI.Responses.ResponseItem",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.LogProb,
  {
    identity: "OpenAI.Responses.ResponseTokenLogProbabilityDetails",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.MCPListToolsTool,
  {
    identity: "OpenAI.Responses.McpToolDefinition",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.MessageContent,
  {
    identity: "OpenAI.Responses.ResponseContentPart",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.MessageRole,
  {
    identity: "OpenAI.Responses.MessageRole",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.MessageStatus,
  {
    identity: "OpenAI.Responses.MessageStatus",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.ToolChoiceParam,
  {
    identity: "OpenAI.Responses.ResponseToolChoice",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.TopLogProb,
  {
    identity: "OpenAI.Responses.ResponseTokenTopLogProbabilityDetails",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.WebSearchActionFind,
  {
    identity: "OpenAI.Responses.WebSearchFindInPageAction",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.WebSearchActionOpenPage,
  {
    identity: "OpenAI.Responses.WebSearchOpenPageAction",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.WebSearchActionSearch,
  {
    identity: "OpenAI.Responses.WebSearchSearchAction",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);
@@alternateType(
  OpenAI.WebSearchCallStatus,
  {
    identity: "OpenAI.Responses.WebSearchCallStatus",
    package: "OpenAI",
    minVersion: "2.12.0",
  },
  "csharp"
);

// No public OpenAI SDK equivalent (shell, moderation, prompt cache, session affinity, ...).
// OpenAI's ResponseServiceTier and ResponsePromptCacheRetentionPolicy are experimental (OPENAI001),
// and these enums are only used by internal request bodies. IncludeEnum (IncludedResponseProperty)
// stays an internal generated enum: the emitter cannot serialize a list of enums mapped to System.Object.
@@alternateType(
  OpenAI.PromptCacheRetentionEnum,
  {
    identity: "System.Object",
  },
  "csharp"
);
@@alternateType(
  OpenAI.ServiceTierEnum,
  {
    identity: "System.Object",
  },
  "csharp"
);
@@alternateType(
  OpenAI.FunctionAndCustomToolCallOutput,
  {
    identity: "System.Object",
  },
  "csharp"
);
@@alternateType(
  Azure.AI.Projects.AzureUserSecurityContext,
  {
    identity: "System.Object",
  },
  "csharp"
);
@@alternateType(
  Azure.AI.Projects.PageOrder,
  {
    identity: "System.Object",
  },
  "csharp"
);
@@alternateType(
  Azure.AI.Projects.RoutingConfiguration,
  {
    identity: "System.Object",
  },
  "csharp"
);
@@alternateType(
  Azure.AI.Projects.SessionAffinityConfiguration,
  {
    identity: "System.Object",
  },
  "csharp"
);
@@alternateType(
  Azure.AI.Projects.SessionAffinityRequestStrategy,
  {
    identity: "System.Object",
  },
  "csharp"
);
@@alternateType(
  OpenAI.CompactResource,
  {
    identity: "System.Object",
  },
  "csharp"
);
@@alternateType(
  OpenAI.ComputerScreenshotContent,
  {
    identity: "System.Object",
  },
  "csharp"
);
@@alternateType(
  OpenAI.ComputerScreenshotImage,
  {
    identity: "System.Object",
  },
  "csharp"
);
@@alternateType(
  OpenAI.ContainerReferenceResource,
  {
    identity: "System.Object",
  },
  "csharp"
);
@@alternateType(
  OpenAI.ContextManagementParam,
  {
    identity: "System.Object",
  },
  "csharp"
);
@@alternateType(
  OpenAI.FileInputDetail,
  {
    identity: "System.Object",
  },
  "csharp"
);
@@alternateType(
  OpenAI.FunctionShellAction,
  {
    identity: "System.Object",
  },
  "csharp"
);
@@alternateType(
  OpenAI.FunctionShellCallEnvironment,
  {
    identity: "System.Object",
  },
  "csharp"
);
@@alternateType(
  OpenAI.FunctionShellCallOutputContent,
  {
    identity: "System.Object",
  },
  "csharp"
);
@@alternateType(
  OpenAI.FunctionShellCallOutputOutcome,
  {
    identity: "System.Object",
  },
  "csharp"
);
@@alternateType(
  OpenAI.FunctionShellCallOutputStatusEnum,
  {
    identity: "System.Object",
  },
  "csharp"
);
@@alternateType(
  OpenAI.FunctionShellCallStatus,
  {
    identity: "System.Object",
  },
  "csharp"
);
@@alternateType(
  OpenAI.InputFileContent,
  {
    identity: "System.Object",
  },
  "csharp"
);
@@alternateType(
  OpenAI.InputImageContent,
  {
    identity: "System.Object",
  },
  "csharp"
);
@@alternateType(
  OpenAI.InputTextContent,
  {
    identity: "System.Object",
  },
  "csharp"
);
@@alternateType(
  OpenAI.LocalEnvironmentResource,
  {
    identity: "System.Object",
  },
  "csharp"
);
@@alternateType(
  OpenAI.LocalShellExecAction,
  {
    identity: "System.Object",
  },
  "csharp"
);
@@alternateType(
  OpenAI.MessagePhase,
  {
    identity: "System.Object",
  },
  "csharp"
);
@@alternateType(
  OpenAI.MisalignmentErrorDetailsResource,
  {
    identity: "System.Object",
  },
  "csharp"
);
@@alternateType(
  OpenAI.ModerationConfigParam,
  {
    identity: "System.Object",
  },
  "csharp"
);
@@alternateType(
  OpenAI.ModerationMode,
  {
    identity: "System.Object",
  },
  "csharp"
);
@@alternateType(
  OpenAI.ModerationParam,
  {
    identity: "System.Object",
  },
  "csharp"
);
@@alternateType(
  OpenAI.ModerationPolicyParam,
  {
    identity: "System.Object",
  },
  "csharp"
);
@@alternateType(
  OpenAI.ProgramOutputStatus,
  {
    identity: "System.Object",
  },
  "csharp"
);
@@alternateType(
  OpenAI.PromptCacheBreakpointConfig,
  {
    identity: "System.Object",
  },
  "csharp"
);
@@alternateType(
  OpenAI.PromptCacheOptionsParam,
  {
    identity: "System.Object",
  },
  "csharp"
);
@@alternateType(
  OpenAI.RealtimeMCPError,
  {
    identity: "System.Object",
  },
  "csharp"
);
@@alternateType(
  OpenAI.ReasoningTextContent,
  {
    identity: "System.Object",
  },
  "csharp"
);
@@alternateType(
  OpenAI.ResponsePromptCacheOptionsParam,
  {
    identity: "System.Object",
  },
  "csharp"
);
@@alternateType(
  OpenAI.ResponseStreamOptions,
  {
    identity: "System.Object",
  },
  "csharp"
);
@@alternateType(
  OpenAI.SpecificApplyPatchParam,
  {
    identity: "System.Object",
  },
  "csharp"
);
@@alternateType(
  OpenAI.SpecificFunctionShellParam,
  {
    identity: "System.Object",
  },
  "csharp"
);
@@alternateType(
  OpenAI.SpecificProgrammaticToolCallingParam,
  {
    identity: "System.Object",
  },
  "csharp"
);
@@alternateType(
  OpenAI.SummaryTextContent,
  {
    identity: "System.Object",
  },
  "csharp"
);
@@alternateType(
  OpenAI.TextContent,
  {
    identity: "System.Object",
  },
  "csharp"
);
@@alternateType(
  OpenAI.ToolChoiceOptions,
  {
    identity: "System.Object",
  },
  "csharp"
);
@@alternateType(
  OpenAI.ToolSearchExecutionType,
  {
    identity: "System.Object",
  },
  "csharp"
);
@@alternateType(
  OpenAI.VectorStoreFileAttributes,
  {
    identity: "System.Object",
  },
  "csharp"
);
@@alternateType(
  OpenAI.WebSearchActionSearchSources,
  {
    identity: "System.Object",
  },
  "csharp"
);
@@alternateType(
  OpenAI._MisalignmentErrorType,
  {
    identity: "System.Object",
  },
  "csharp"
);
@@alternateType(
  OpenAI._MisalignmentSteer,
  {
    identity: "System.Object",
  },
  "csharp"
);

// Used by the hosting runtime (error responses and DELETE results) but not public API.
// OpenAI's ResponseError carries only code/message, and ResponseDeletionResult has no public
// constructor or factory.
@@access(OpenAI.Error, Access.internal, "csharp");
@@access(Azure.AI.Projects.DeleteResponseResult, Access.internal, "csharp");

// The generated `Responses` client is not shipped (only the models are committed), but its
// public protocol methods would otherwise force their parameter/return models (IncludeEnum,
// DeleteResponseResult, ...) to be public. Keep the operations internal.
@@access(Azure.AI.Projects.Responses.createResponse, Access.internal, "csharp");
@@access(Azure.AI.Projects.Responses.getResponse, Access.internal, "csharp");
@@access(Azure.AI.Projects.Responses.deleteResponse, Access.internal, "csharp");
@@access(Azure.AI.Projects.Responses.cancelResponse, Access.internal, "csharp");
@@access(Azure.AI.Projects.Responses.listInputItems, Access.internal, "csharp");
@@access(Azure.AI.Projects.Responses.listResponses, Access.internal, "csharp");
@@access(
  Azure.AI.Projects.Responses.Compactconversation,
  Access.internal,
  "csharp"
);

// `McpToolCallItem.Status` (ResponseItemAttributionExtensions) exposes this enum because
// OpenAI does not model status on MCP tool calls. Renamed to follow .NET acronym casing and
// match OpenAI's `McpToolCallItem`.
@@access(OpenAI.MCPToolCallStatus, Access.public, "csharp");
@@clientName(OpenAI.MCPToolCallStatus, "McpToolCallStatus", "csharp");

// ToolCallCaller (DirectToolCallCaller, ProgramToolCallCaller) stays public: the
// CustomToolCallItem/CustomToolCallOutputItem Caller extension accessors expose it, and the
// OpenAI SDK's caller types are internal, so there is no public @@alternateType target.
// Mapping the OpenAI items to ResponseItem drops the models that made these types public and
// propagated JSON usage to them, so set both explicitly.
@@access(OpenAI.ToolCallCaller, Access.public, "csharp");
@@access(OpenAI.DirectToolCallCaller, Access.public, "csharp");
@@access(OpenAI.ProgramToolCallCaller, Access.public, "csharp");
@@usage(OpenAI.ToolCallCaller, Usage.input | Usage.output | Usage.json);
@@usage(OpenAI.MCPToolCallStatus, Usage.input | Usage.output | Usage.json);
