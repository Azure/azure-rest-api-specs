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

  // --- OpenAI OutputItem subtypes that lead to locally emitted types ---
  // These subtypes are not emitted themselves: operations carry the OpenAI ResponseItem (the
  // OutputItem base is alt-typed to it), so nothing references them and the generator drops them
  // as unreferenced. Their usage still propagates to their property types, and some of those have
  // no OpenAI SDK mapping below and are emitted locally (apply-patch operations, shell actions and
  // outcomes, web-search actions, message and reasoning content, MCP list-tools entries, ...).
  // Without Input usage those types get internal constructors and read-only properties.
  // Other OutputItem subtypes are not listed: their property types are mapped to OpenAI, already
  // covered here, or (ComputerScreenshotImage, ToolCallCallerParam) exposed only by output-only
  // ItemField* models.
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

  // FunctionAndCustomToolCallOutput (text, image and file content of tool call outputs) has no
  // OpenAI SDK mapping and is emitted locally; the usage gives it public constructors and setters.
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

// The custom-tool-call items have no counterpart in the OpenAI library, so they are emitted
// here as `ResponseItem` subtypes. The `OutputItem` base is alternate-typed to
// `OpenAI.Responses.ResponseItem`, so its derived models are not emitted on their own and
// must be marked as used explicitly. Rename them to match the other OutputItem* models.
@@clientName(
  OpenAI.CustomToolCallResource,
  "OutputItemCustomToolCall",
  "csharp"
);
@@clientName(
  OpenAI.CustomToolCallOutputResource,
  "OutputItemCustomToolCallOutput",
  "csharp"
);
@@access(OpenAI.CustomToolCallResource, Access.public, "csharp");
@@access(OpenAI.CustomToolCallOutputResource, Access.public, "csharp");
@@usage(OpenAI.CustomToolCallResource, Usage.input | Usage.output, "csharp");
@@usage(
  OpenAI.CustomToolCallOutputResource,
  Usage.input | Usage.output,
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

// Public models that expose or derive from those OpenAI types forward the same diagnostic ID,
// so consumers opt in to the OpenAI experiment rather than to a separate AgentServer one.
// Template instances (AgentsPagedResult<OpenAI.OutputItem>) and anonymous operation responses
// cannot be targeted by augment decorators; their members still get targeted suppressions.
@@TypeSpec.HttpClient.experimental(
  OpenAI.CustomToolCallResource,
  #{ emitterScope: "@typespec/http-client-csharp", diagnosticId: "OPENAI001" }
);
@@TypeSpec.HttpClient.experimental(
  OpenAI.CustomToolCallOutputResource,
  #{ emitterScope: "@typespec/http-client-csharp", diagnosticId: "OPENAI001" }
);
@@TypeSpec.HttpClient.experimental(
  OpenAI.CompactResource,
  #{ emitterScope: "@typespec/http-client-csharp", diagnosticId: "OPENAI001" }
);
@@TypeSpec.HttpClient.experimental(
  OpenAI.ItemFieldAdditionalTools,
  #{ emitterScope: "@typespec/http-client-csharp", diagnosticId: "OPENAI001" }
);
@@TypeSpec.HttpClient.experimental(
  OpenAI.ItemFieldComputerToolCall,
  #{ emitterScope: "@typespec/http-client-csharp", diagnosticId: "OPENAI001" }
);
@@TypeSpec.HttpClient.experimental(
  OpenAI.ItemFieldToolSearchOutput,
  #{ emitterScope: "@typespec/http-client-csharp", diagnosticId: "OPENAI001" }
);
@@TypeSpec.HttpClient.experimental(
  OpenAI.MessageContentOutputTextContent,
  #{ emitterScope: "@typespec/http-client-csharp", diagnosticId: "OPENAI001" }
);

// ============================================================================
// Internal models.
// The @@usage roots above (and the operations) pull in models that no public member of this
// package takes or returns: handlers, providers, builders, options and extension accessors only
// expose OpenAI types or the models that remain public. Emit those as internal so they are not
// published as unreachable public API; several also duplicate OpenAI.Responses types.
// A model is made public again only once a public member exposes it.
// ============================================================================
@@access(Azure.AI.Projects.AzureUserSecurityContext, Access.internal, "csharp");
@@access(Azure.AI.Projects.DeleteResponseResult, Access.internal, "csharp");
@@access(Azure.AI.Projects.PageOrder, Access.internal, "csharp");
@@access(Azure.AI.Projects.RoutingConfiguration, Access.internal, "csharp");
@@access(
  Azure.AI.Projects.SessionAffinityConfiguration,
  Access.internal,
  "csharp"
);
@@access(
  Azure.AI.Projects.SessionAffinityRequestStrategy,
  Access.internal,
  "csharp"
);
@@access(OpenAI.ApplyPatchCreateFileOperation, Access.internal, "csharp");
@@access(OpenAI.ApplyPatchDeleteFileOperation, Access.internal, "csharp");
@@access(OpenAI.ApplyPatchFileOperation, Access.internal, "csharp");
@@access(OpenAI.ApplyPatchUpdateFileOperation, Access.internal, "csharp");
@@access(OpenAI.CodeInterpreterOutputImage, Access.internal, "csharp");
@@access(OpenAI.CodeInterpreterOutputLogs, Access.internal, "csharp");
@@access(OpenAI.CompactResource, Access.internal, "csharp");
@@access(OpenAI.ComputerCallSafetyCheckParam, Access.internal, "csharp");
@@access(OpenAI.ComputerScreenshotContent, Access.internal, "csharp");
@@access(OpenAI.ComputerScreenshotImage, Access.internal, "csharp");
@@access(OpenAI.ContainerReferenceResource, Access.internal, "csharp");
@@access(OpenAI.ContextManagementParam, Access.internal, "csharp");
@@access(OpenAI.Error, Access.internal, "csharp");
@@access(OpenAI.FileInputDetail, Access.internal, "csharp");
@@access(OpenAI.FileSearchToolCallResults, Access.internal, "csharp");
@@access(OpenAI.FunctionShellAction, Access.internal, "csharp");
@@access(OpenAI.FunctionShellCallEnvironment, Access.internal, "csharp");
@@access(OpenAI.FunctionShellCallOutputContent, Access.internal, "csharp");
@@access(OpenAI.FunctionShellCallOutputExitOutcome, Access.internal, "csharp");
@@access(OpenAI.FunctionShellCallOutputOutcome, Access.internal, "csharp");
@@access(OpenAI.FunctionShellCallOutputStatusEnum, Access.internal, "csharp");
@@access(
  OpenAI.FunctionShellCallOutputTimeoutOutcome,
  Access.internal,
  "csharp"
);
@@access(OpenAI.FunctionShellCallStatus, Access.internal, "csharp");
@@access(OpenAI.ImageBackground, Access.internal, "csharp");
@@access(OpenAI.ImageDetail, Access.internal, "csharp");
@@access(OpenAI.ImageGenActionEnum, Access.internal, "csharp");
@@access(OpenAI.ImageOutputFormat, Access.internal, "csharp");
@@access(OpenAI.IncludeEnum, Access.internal, "csharp");
@@access(OpenAI.InputFileContent, Access.internal, "csharp");
@@access(OpenAI.InputImageContent, Access.internal, "csharp");
@@access(OpenAI.InputTextContent, Access.internal, "csharp");
@@access(OpenAI.ItemField, Access.internal, "csharp");
@@access(OpenAI.ItemFieldAdditionalTools, Access.internal, "csharp");
@@access(OpenAI.ItemFieldApplyPatchToolCall, Access.internal, "csharp");
@@access(OpenAI.ItemFieldApplyPatchToolCallOutput, Access.internal, "csharp");
@@access(OpenAI.ItemFieldCodeInterpreterToolCall, Access.internal, "csharp");
@@access(OpenAI.ItemFieldCompactionBody, Access.internal, "csharp");
@@access(OpenAI.ItemFieldComputerToolCall, Access.internal, "csharp");
@@access(OpenAI.ItemFieldComputerToolCallOutput, Access.internal, "csharp");
@@access(OpenAI.ItemFieldCustomToolCall, Access.internal, "csharp");
@@access(OpenAI.ItemFieldCustomToolCallOutput, Access.internal, "csharp");
@@access(OpenAI.ItemFieldFileSearchToolCall, Access.internal, "csharp");
@@access(OpenAI.ItemFieldFunctionShellCall, Access.internal, "csharp");
@@access(OpenAI.ItemFieldFunctionShellCallOutput, Access.internal, "csharp");
@@access(OpenAI.ItemFieldFunctionToolCall, Access.internal, "csharp");
@@access(OpenAI.ItemFieldFunctionToolCallOutput, Access.internal, "csharp");
@@access(OpenAI.ItemFieldImageGenToolCall, Access.internal, "csharp");
@@access(OpenAI.ItemFieldLocalShellToolCall, Access.internal, "csharp");
@@access(OpenAI.ItemFieldLocalShellToolCallOutput, Access.internal, "csharp");
@@access(OpenAI.ItemFieldMcpApprovalRequest, Access.internal, "csharp");
@@access(
  OpenAI.ItemFieldMcpApprovalResponseResource,
  Access.internal,
  "csharp"
);
@@access(OpenAI.ItemFieldMcpListTools, Access.internal, "csharp");
@@access(OpenAI.ItemFieldMcpToolCall, Access.internal, "csharp");
@@access(OpenAI.ItemFieldMessage, Access.internal, "csharp");
@@access(OpenAI.ItemFieldProgram, Access.internal, "csharp");
@@access(OpenAI.ItemFieldProgramOutput, Access.internal, "csharp");
@@access(OpenAI.ItemFieldReasoningItem, Access.internal, "csharp");
@@access(OpenAI.ItemFieldToolSearchCall, Access.internal, "csharp");
@@access(OpenAI.ItemFieldToolSearchOutput, Access.internal, "csharp");
@@access(OpenAI.ItemFieldWebSearchToolCall, Access.internal, "csharp");
@@access(OpenAI.LocalEnvironmentResource, Access.internal, "csharp");
@@access(OpenAI.LocalShellExecAction, Access.internal, "csharp");
@@access(OpenAI.LogProb, Access.internal, "csharp");
@@access(OpenAI.MCPListToolsTool, Access.internal, "csharp");
@@access(OpenAI.MCPListToolsToolAnnotations, Access.internal, "csharp");
@@access(OpenAI.MCPListToolsToolInputSchema, Access.internal, "csharp");
@@access(OpenAI.MessageContent, Access.internal, "csharp");
@@access(OpenAI.MessageContentInputFileContent, Access.internal, "csharp");
@@access(OpenAI.MessageContentInputImageContent, Access.internal, "csharp");
@@access(OpenAI.MessageContentInputTextContent, Access.internal, "csharp");
@@access(OpenAI.MessageContentOutputTextContent, Access.internal, "csharp");
@@access(OpenAI.MessageContentReasoningTextContent, Access.internal, "csharp");
@@access(OpenAI.MessageContentRefusalContent, Access.internal, "csharp");
@@access(OpenAI.MessagePhase, Access.internal, "csharp");
@@access(OpenAI.MessageRole, Access.internal, "csharp");
@@access(OpenAI.MessageStatus, Access.internal, "csharp");
@@access(OpenAI.MisalignmentErrorDetailsResource, Access.internal, "csharp");
@@access(OpenAI.ModerationConfigParam, Access.internal, "csharp");
@@access(OpenAI.ModerationMode, Access.internal, "csharp");
@@access(OpenAI.ModerationParam, Access.internal, "csharp");
@@access(OpenAI.ModerationPolicyParam, Access.internal, "csharp");
@@access(OpenAI.ProgramOutputStatus, Access.internal, "csharp");
@@access(OpenAI.PromptCacheBreakpointConfig, Access.internal, "csharp");
@@access(OpenAI.PromptCacheOptionsParam, Access.internal, "csharp");
@@access(OpenAI.PromptCacheRetentionEnum, Access.internal, "csharp");
@@access(OpenAI.RealtimeMCPError, Access.internal, "csharp");
@@access(OpenAI.RealtimeMCPHTTPError, Access.internal, "csharp");
@@access(OpenAI.RealtimeMCPProtocolError, Access.internal, "csharp");
@@access(OpenAI.RealtimeMCPToolExecutionError, Access.internal, "csharp");
@@access(OpenAI.ReasoningTextContent, Access.internal, "csharp");
@@access(OpenAI.ResponsePromptCacheOptionsParam, Access.internal, "csharp");
@@access(OpenAI.ResponseStreamOptions, Access.internal, "csharp");
@@access(OpenAI.ServiceTierEnum, Access.internal, "csharp");
@@access(OpenAI.SpecificApplyPatchParam, Access.internal, "csharp");
@@access(OpenAI.SpecificFunctionShellParam, Access.internal, "csharp");
@@access(
  OpenAI.SpecificProgrammaticToolCallingParam,
  Access.internal,
  "csharp"
);
@@access(OpenAI.SummaryTextContent, Access.internal, "csharp");
@@access(OpenAI.TextContent, Access.internal, "csharp");
@@access(OpenAI.ToolChoiceAllowed, Access.internal, "csharp");
@@access(OpenAI.ToolChoiceCodeInterpreter, Access.internal, "csharp");
@@access(OpenAI.ToolChoiceComputer, Access.internal, "csharp");
@@access(OpenAI.ToolChoiceComputerUse, Access.internal, "csharp");
@@access(OpenAI.ToolChoiceComputerUsePreview, Access.internal, "csharp");
@@access(OpenAI.ToolChoiceCustom, Access.internal, "csharp");
@@access(OpenAI.ToolChoiceFileSearch, Access.internal, "csharp");
@@access(OpenAI.ToolChoiceFunction, Access.internal, "csharp");
@@access(OpenAI.ToolChoiceImageGeneration, Access.internal, "csharp");
@@access(OpenAI.ToolChoiceMCP, Access.internal, "csharp");
@@access(OpenAI.ToolChoiceOptions, Access.internal, "csharp");
@@access(OpenAI.ToolChoiceParam, Access.internal, "csharp");
@@access(OpenAI.ToolChoiceWebSearchPreview, Access.internal, "csharp");
@@access(OpenAI.ToolChoiceWebSearchPreview20250311, Access.internal, "csharp");
@@access(OpenAI.ToolSearchExecutionType, Access.internal, "csharp");
@@access(OpenAI.TopLogProb, Access.internal, "csharp");
@@access(OpenAI.VectorStoreFileAttributes, Access.internal, "csharp");
@@access(OpenAI.WebSearchActionFind, Access.internal, "csharp");
@@access(OpenAI.WebSearchActionOpenPage, Access.internal, "csharp");
@@access(OpenAI.WebSearchActionSearch, Access.internal, "csharp");
@@access(OpenAI.WebSearchActionSearchSources, Access.internal, "csharp");
@@access(OpenAI.WebSearchCallStatus, Access.internal, "csharp");
@@access(OpenAI._MisalignmentErrorType, Access.internal, "csharp");
@@access(OpenAI._MisalignmentSteer, Access.internal, "csharp");

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
// OpenAI does not model status on MCP tool calls.
@@access(OpenAI.MCPToolCallStatus, Access.public, "csharp");
