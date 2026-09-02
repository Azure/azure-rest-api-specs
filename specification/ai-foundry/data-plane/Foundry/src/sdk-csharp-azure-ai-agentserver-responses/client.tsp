import "./main.tsp";

using Azure.ClientGenerator.Core;
using Azure.Core.Experimental;

// Map all OpenAI base types into our SDK namespace
@clientNamespace("Azure.AI.AgentServer.Responses.Models")
namespace OpenAI {
  // The responses view does not export ItemResourceType (only the full src does).
  // Bridge the gap with an alias so the Azure augmentations can reference it.
  alias ItemResourceType = OutputItemType;

  @@withoutOmittedProperties(Item, "type");
  #suppress "@azure-tools/typespec-azure-core/no-unnamed-types" "The widened discriminator is deliberately anonymous; declaring it as a named union would add a schema to the emitted OpenAPI contract, changing the published wire shape."
  #suppress "@azure-tools/typespec-azure-core/experimental-feature" "@copyProperties widens the `type` discriminator to admit the `program` and `program_output` replay items that the AgentServer input contract accepts; without it the discriminator degrades to a plain string."
  @@copyProperties(
    Item,
    {
      type: ItemType | "program" | "program_output",
    }
  );
}

// Map Azure.AI.Projects augmentation types into our SDK namespace
@clientNamespace("Azure.AI.AgentServer.Responses.Models")
namespace Azure.AI.Projects {
  // Propagate "sequence_number" to base of stream events
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "`sequence_number` must stay OpenAI.integer: the upstream leaf events inherit that exact type, and int32 fails with override-property-mismatch."
  #suppress "@azure-tools/typespec-azure-core/experimental-feature" "@copyProperties propagates `sequence_number` onto the stream event base type; upstream OpenAI declares it only on the leaf events."
  @@copyProperties(
    OpenAI.ResponseStreamEvent,
    {
      sequence_number: OpenAI.integer,
    }
  );

  // Propagate "id" to Azure.AI.Projects OutputItem types that lack it.
  // The OpenAI base types already have id; these are Azure-specific extensions.
  #suppress "@azure-tools/typespec-azure-core/experimental-feature" "@copyProperties adds `id` to this Azure-specific tool call item; these Foundry extensions do not inherit the upstream item base that declares `id`, so the emitted model would otherwise have no identifier."
  @@copyProperties(
    Azure.AI.Projects.A2AToolCall,
    {
      id: string,
    }
  );
  #suppress "@azure-tools/typespec-azure-core/experimental-feature" "@copyProperties adds `id` to this Azure-specific tool call item; these Foundry extensions do not inherit the upstream item base that declares `id`, so the emitted model would otherwise have no identifier."
  @@copyProperties(
    Azure.AI.Projects.A2AToolCallOutput,
    {
      id: string,
    }
  );
  #suppress "@azure-tools/typespec-azure-core/experimental-feature" "@copyProperties adds `id` to this Azure-specific tool call item; these Foundry extensions do not inherit the upstream item base that declares `id`, so the emitted model would otherwise have no identifier."
  @@copyProperties(
    Azure.AI.Projects.AzureAISearchToolCall,
    {
      id: string,
    }
  );
  #suppress "@azure-tools/typespec-azure-core/experimental-feature" "@copyProperties adds `id` to this Azure-specific tool call item; these Foundry extensions do not inherit the upstream item base that declares `id`, so the emitted model would otherwise have no identifier."
  @@copyProperties(
    Azure.AI.Projects.AzureAISearchToolCallOutput,
    {
      id: string,
    }
  );
  #suppress "@azure-tools/typespec-azure-core/experimental-feature" "@copyProperties adds `id` to this Azure-specific tool call item; these Foundry extensions do not inherit the upstream item base that declares `id`, so the emitted model would otherwise have no identifier."
  @@copyProperties(
    Azure.AI.Projects.AzureFunctionToolCall,
    {
      id: string,
    }
  );
  #suppress "@azure-tools/typespec-azure-core/experimental-feature" "@copyProperties adds `id` to this Azure-specific tool call item; these Foundry extensions do not inherit the upstream item base that declares `id`, so the emitted model would otherwise have no identifier."
  @@copyProperties(
    Azure.AI.Projects.AzureFunctionToolCallOutput,
    {
      id: string,
    }
  );
  #suppress "@azure-tools/typespec-azure-core/experimental-feature" "@copyProperties adds `id` to this Azure-specific tool call item; these Foundry extensions do not inherit the upstream item base that declares `id`, so the emitted model would otherwise have no identifier."
  @@copyProperties(
    Azure.AI.Projects.BingCustomSearchToolCall,
    {
      id: string,
    }
  );
  #suppress "@azure-tools/typespec-azure-core/experimental-feature" "@copyProperties adds `id` to this Azure-specific tool call item; these Foundry extensions do not inherit the upstream item base that declares `id`, so the emitted model would otherwise have no identifier."
  @@copyProperties(
    Azure.AI.Projects.BingCustomSearchToolCallOutput,
    {
      id: string,
    }
  );
  #suppress "@azure-tools/typespec-azure-core/experimental-feature" "@copyProperties adds `id` to this Azure-specific tool call item; these Foundry extensions do not inherit the upstream item base that declares `id`, so the emitted model would otherwise have no identifier."
  @@copyProperties(
    Azure.AI.Projects.BingGroundingToolCall,
    {
      id: string,
    }
  );
  #suppress "@azure-tools/typespec-azure-core/experimental-feature" "@copyProperties adds `id` to this Azure-specific tool call item; these Foundry extensions do not inherit the upstream item base that declares `id`, so the emitted model would otherwise have no identifier."
  @@copyProperties(
    Azure.AI.Projects.BingGroundingToolCallOutput,
    {
      id: string,
    }
  );
  #suppress "@azure-tools/typespec-azure-core/experimental-feature" "@copyProperties adds `id` to this Azure-specific tool call item; these Foundry extensions do not inherit the upstream item base that declares `id`, so the emitted model would otherwise have no identifier."
  @@copyProperties(
    Azure.AI.Projects.BrowserAutomationToolCall,
    {
      id: string,
    }
  );
  #suppress "@azure-tools/typespec-azure-core/experimental-feature" "@copyProperties adds `id` to this Azure-specific tool call item; these Foundry extensions do not inherit the upstream item base that declares `id`, so the emitted model would otherwise have no identifier."
  @@copyProperties(
    Azure.AI.Projects.BrowserAutomationToolCallOutput,
    {
      id: string,
    }
  );
  #suppress "@azure-tools/typespec-azure-core/experimental-feature" "@copyProperties adds `id` to this Azure-specific tool call item; these Foundry extensions do not inherit the upstream item base that declares `id`, so the emitted model would otherwise have no identifier."
  @@copyProperties(
    Azure.AI.Projects.FabricDataAgentToolCall,
    {
      id: string,
    }
  );
  #suppress "@azure-tools/typespec-azure-core/experimental-feature" "@copyProperties adds `id` to this Azure-specific tool call item; these Foundry extensions do not inherit the upstream item base that declares `id`, so the emitted model would otherwise have no identifier."
  @@copyProperties(
    Azure.AI.Projects.FabricDataAgentToolCallOutput,
    {
      id: string,
    }
  );
  #suppress "@azure-tools/typespec-azure-core/experimental-feature" "@copyProperties adds `id` to this Azure-specific tool call item; these Foundry extensions do not inherit the upstream item base that declares `id`, so the emitted model would otherwise have no identifier."
  @@copyProperties(
    Azure.AI.Projects.MemoryCommandToolCall,
    {
      id: string,
    }
  );
  #suppress "@azure-tools/typespec-azure-core/experimental-feature" "@copyProperties adds `id` to this Azure-specific tool call item; these Foundry extensions do not inherit the upstream item base that declares `id`, so the emitted model would otherwise have no identifier."
  @@copyProperties(
    Azure.AI.Projects.MemoryCommandToolCallOutput,
    {
      id: string,
    }
  );
  #suppress "@azure-tools/typespec-azure-core/experimental-feature" "@copyProperties adds `id` to this Azure-specific tool call item; these Foundry extensions do not inherit the upstream item base that declares `id`, so the emitted model would otherwise have no identifier."
  @@copyProperties(
    Azure.AI.Projects.MemorySearchToolCall,
    {
      id: string,
    }
  );
  #suppress "@azure-tools/typespec-azure-core/experimental-feature" "@copyProperties adds `id` to this Azure-specific tool call item; these Foundry extensions do not inherit the upstream item base that declares `id`, so the emitted model would otherwise have no identifier."
  @@copyProperties(
    Azure.AI.Projects.OpenApiToolCall,
    {
      id: string,
    }
  );
  #suppress "@azure-tools/typespec-azure-core/experimental-feature" "@copyProperties adds `id` to this Azure-specific tool call item; these Foundry extensions do not inherit the upstream item base that declares `id`, so the emitted model would otherwise have no identifier."
  @@copyProperties(
    Azure.AI.Projects.OpenApiToolCallOutput,
    {
      id: string,
    }
  );
  #suppress "@azure-tools/typespec-azure-core/experimental-feature" "@copyProperties adds `id` to this Azure-specific tool call item; these Foundry extensions do not inherit the upstream item base that declares `id`, so the emitted model would otherwise have no identifier."
  @@copyProperties(
    Azure.AI.Projects.SharepointGroundingToolCall,
    {
      id: string,
    }
  );
  #suppress "@azure-tools/typespec-azure-core/experimental-feature" "@copyProperties adds `id` to this Azure-specific tool call item; these Foundry extensions do not inherit the upstream item base that declares `id`, so the emitted model would otherwise have no identifier."
  @@copyProperties(
    Azure.AI.Projects.SharepointGroundingToolCallOutput,
    {
      id: string,
    }
  );
  #suppress "@azure-tools/typespec-azure-core/experimental-feature" "@copyProperties adds `id` to this Azure-specific tool call item; these Foundry extensions do not inherit the upstream item base that declares `id`, so the emitted model would otherwise have no identifier."
  @@copyProperties(
    Azure.AI.Projects.StructuredOutputsOutputItem,
    {
      id: string,
    }
  );
  #suppress "@azure-tools/typespec-azure-core/experimental-feature" "@copyProperties adds `id` to this Azure-specific tool call item; these Foundry extensions do not inherit the upstream item base that declares `id`, so the emitted model would otherwise have no identifier."
  @@copyProperties(
    Azure.AI.Projects.WorkflowActionOutputItem,
    {
      id: string,
    }
  );

  // Remove created_by from specific models to avoid BinaryData/string mismatch
  // with the base OutputItem.CreatedBy (BinaryData) type
  @@withoutOmittedProperties(
    OpenAI.OutputItemFunctionShellCallOutput,
    "created_by"
  );
  @@withoutOmittedProperties(OpenAI.OutputItemFunctionShellCall, "created_by");
  @@withoutOmittedProperties(OpenAI.OutputItemCompactionBody, "created_by");
  @@withoutOmittedProperties(
    OpenAI.OutputItemApplyPatchToolCallOutput,
    "created_by"
  );
  @@withoutOmittedProperties(OpenAI.OutputItemApplyPatchToolCall, "created_by");

  // Remove "id" and "status" from ItemMessage (input-only model).
  // The Responses-only TypeSpec view merges input and output item types into a
  // single Item union, losing the distinction between EasyInputMessage (input,
  // requires only role/content/type) and ConversationItemMessage (output,
  // requires id/status/role/content/type). ItemMessage is only referenced by
  // OpenAI.Item (input context); the output side uses OpenAI.OutputItemMessage.
  @@withoutOmittedProperties(OpenAI.ItemMessage, "id");
  @@withoutOmittedProperties(OpenAI.ItemMessage, "status");

  // Remove output-assigned "id" from ItemFunctionToolCall in input context.
  // Function call input items require type/call_id/name/arguments; the server
  // assigns id later when the item is persisted or returned as output.
  @@withoutOmittedProperties(OpenAI.ItemFunctionToolCall, "id");

  // Fix ItemMessage.content to match the upstream EasyInputMessage format.
  // The Responses-only view inherits content: MessageContent[] from the output-
  // oriented Message model. The upstream EasyInputMessage accepts either a plain
  // string or an array of content parts (string | InputMessageContentList).
  // Remove the array-only content and replace with the union type.
  @@withoutOmittedProperties(OpenAI.ItemMessage, "content");
  #suppress "@azure-tools/typespec-azure-core/no-unnamed-types" "The string-or-array shorthand is deliberately anonymous; declaring it as a named union would add a schema to the emitted OpenAPI contract, changing the published wire shape."
  #suppress "@azure-tools/typespec-azure-core/experimental-feature" "@copyProperties widens `content` to `string | MessageContent[]`; the Responses wire protocol accepts the string shorthand that upstream OpenAI declares as array-only."
  @@copyProperties(
    OpenAI.ItemMessage,
    {
      content: string | OpenAI.MessageContent[],
    }
  );

  // Match the Responses API behavior, which accepts assistant output text
  // without token log probabilities.
  @@withoutOmittedProperties(OpenAI.OutputContentOutputTextContent, "logprobs");
  #suppress "@azure-tools/typespec-azure-core/experimental-feature" "@copyProperties re-adds `logprobs` as optional after @withoutOmittedProperties removed the required upstream declaration; without it `logprobs` becomes a required constructor parameter on the emitted model."
  @@copyProperties(
    OpenAI.OutputContentOutputTextContent,
    {
      logprobs?: OpenAI.LogProb[],
    }
  );
  @@withoutOmittedProperties(
    OpenAI.MessageContentOutputTextContent,
    "logprobs"
  );
  #suppress "@azure-tools/typespec-azure-core/experimental-feature" "@copyProperties re-adds `logprobs` as optional after @withoutOmittedProperties removed the required upstream declaration; without it `logprobs` becomes a required constructor parameter on the emitted model."
  @@copyProperties(
    OpenAI.MessageContentOutputTextContent,
    {
      logprobs?: OpenAI.LogProb[],
    }
  );
  @@withoutOmittedProperties(
    OpenAI.OutputMessageContentOutputTextContent,
    "logprobs"
  );
  #suppress "@azure-tools/typespec-azure-core/experimental-feature" "@copyProperties re-adds `logprobs` as optional after @withoutOmittedProperties removed the required upstream declaration; without it `logprobs` becomes a required constructor parameter on the emitted model."
  @@copyProperties(
    OpenAI.OutputMessageContentOutputTextContent,
    {
      logprobs?: OpenAI.LogProb[],
    }
  );

  // Avoid Markdown list formatting that produces an invalid Python docstring.
  @@doc(
    OpenAI.Response.output,
    "An array of content items generated by the model. The length and order of items depends on the model response. Use the output_text property instead of assuming the first item is an assistant message."
  );

  // Rename "Response" to "ResponseObject" to avoid conflict with Azure.Response
  @@clientName(OpenAI.Response, "ResponseObject");

  // Rename "ResponseError" to "ResponseErrorInfo" to avoid conflict with Azure.ResponseError
  @@clientName(OpenAI.ResponseError, "ResponseErrorInfo");

  // Remove "object" from DeleteResponseResult to work around codegen bug
  // (TypeSpec emitter generates `= "response"` string default for ResponseObjectType enum)
  @@withoutOmittedProperties(Azure.AI.Projects.DeleteResponseResult, "object");
  #suppress "@azure-tools/typespec-azure-core/experimental-feature" "@copyProperties stamps the `object: \"response\"` literal that the delete envelope must return; it is not declared on the upstream model."
  @@copyProperties(
    Azure.AI.Projects.DeleteResponseResult,
    {
      object: "response",
    }
  );

  // ============================================================================
  // Public constructors: mark models as input+output so the C# emitter generates
  // public compact constructors. Consumers need these to construct events in their
  // ResponseHandler implementations.
  // ============================================================================

  // --- ResponseStreamEvent subtypes (58 concrete types) ---
  @@usage(OpenAI.ResponseAudioDeltaEvent, Usage.input | Usage.output);
  @@usage(OpenAI.ResponseAudioDoneEvent, Usage.input | Usage.output);
  @@usage(OpenAI.ResponseAudioTranscriptDeltaEvent, Usage.input | Usage.output);
  @@usage(OpenAI.ResponseAudioTranscriptDoneEvent, Usage.input | Usage.output);
  @@usage(
    OpenAI.ResponseCodeInterpreterCallCodeDeltaEvent,
    Usage.input | Usage.output
  );
  @@usage(
    OpenAI.ResponseCodeInterpreterCallCodeDoneEvent,
    Usage.input | Usage.output
  );
  @@usage(
    OpenAI.ResponseCodeInterpreterCallCompletedEvent,
    Usage.input | Usage.output
  );
  @@usage(
    OpenAI.ResponseCodeInterpreterCallInProgressEvent,
    Usage.input | Usage.output
  );
  @@usage(
    OpenAI.ResponseCodeInterpreterCallInterpretingEvent,
    Usage.input | Usage.output
  );
  @@usage(OpenAI.ResponseCompletedEvent, Usage.input | Usage.output);
  @@usage(OpenAI.ResponseContentPartAddedEvent, Usage.input | Usage.output);
  @@usage(OpenAI.ResponseContentPartDoneEvent, Usage.input | Usage.output);
  @@usage(OpenAI.ResponseCreatedEvent, Usage.input | Usage.output);
  @@usage(
    OpenAI.ResponseCustomToolCallInputDeltaEvent,
    Usage.input | Usage.output
  );
  @@usage(
    OpenAI.ResponseCustomToolCallInputDoneEvent,
    Usage.input | Usage.output
  );
  @@usage(OpenAI.ResponseErrorEvent, Usage.input | Usage.output);
  @@usage(OpenAI.ResponseFailedEvent, Usage.input | Usage.output);
  @@usage(
    OpenAI.ResponseFileSearchCallCompletedEvent,
    Usage.input | Usage.output
  );
  @@usage(
    OpenAI.ResponseFileSearchCallInProgressEvent,
    Usage.input | Usage.output
  );
  @@usage(
    OpenAI.ResponseFileSearchCallSearchingEvent,
    Usage.input | Usage.output
  );
  @@usage(
    OpenAI.ResponseFunctionCallArgumentsDeltaEvent,
    Usage.input | Usage.output
  );
  @@usage(
    OpenAI.ResponseFunctionCallArgumentsDoneEvent,
    Usage.input | Usage.output
  );
  @@usage(
    OpenAI.ResponseImageGenCallCompletedEvent,
    Usage.input | Usage.output
  );
  @@usage(
    OpenAI.ResponseImageGenCallGeneratingEvent,
    Usage.input | Usage.output
  );
  @@usage(
    OpenAI.ResponseImageGenCallInProgressEvent,
    Usage.input | Usage.output
  );
  @@usage(
    OpenAI.ResponseImageGenCallPartialImageEvent,
    Usage.input | Usage.output
  );
  @@usage(OpenAI.ResponseIncompleteEvent, Usage.input | Usage.output);
  @@usage(OpenAI.ResponseInProgressEvent, Usage.input | Usage.output);
  @@usage(
    OpenAI.ResponseMCPCallArgumentsDeltaEvent,
    Usage.input | Usage.output
  );
  @@usage(OpenAI.ResponseMCPCallArgumentsDoneEvent, Usage.input | Usage.output);
  @@usage(OpenAI.ResponseMCPCallCompletedEvent, Usage.input | Usage.output);
  @@usage(OpenAI.ResponseMCPCallFailedEvent, Usage.input | Usage.output);
  @@usage(OpenAI.ResponseMCPCallInProgressEvent, Usage.input | Usage.output);
  @@usage(
    OpenAI.ResponseMCPListToolsCompletedEvent,
    Usage.input | Usage.output
  );
  @@usage(OpenAI.ResponseMCPListToolsFailedEvent, Usage.input | Usage.output);
  @@usage(
    OpenAI.ResponseMCPListToolsInProgressEvent,
    Usage.input | Usage.output
  );
  @@usage(OpenAI.ResponseOutputItemAddedEvent, Usage.input | Usage.output);
  @@usage(OpenAI.ResponseOutputItemDoneEvent, Usage.input | Usage.output);
  @@usage(
    OpenAI.ResponseOutputTextAnnotationAddedEvent,
    Usage.input | Usage.output
  );
  @@usage(OpenAI.ResponseQueuedEvent, Usage.input | Usage.output);
  @@usage(
    OpenAI.ResponseReasoningSummaryPartAddedEvent,
    Usage.input | Usage.output
  );
  @@usage(
    OpenAI.ResponseReasoningSummaryPartDoneEvent,
    Usage.input | Usage.output
  );
  @@usage(
    OpenAI.ResponseReasoningSummaryTextDeltaEvent,
    Usage.input | Usage.output
  );
  @@usage(
    OpenAI.ResponseReasoningSummaryTextDoneEvent,
    Usage.input | Usage.output
  );
  @@usage(OpenAI.ResponseReasoningTextDeltaEvent, Usage.input | Usage.output);
  @@usage(OpenAI.ResponseReasoningTextDoneEvent, Usage.input | Usage.output);
  @@usage(OpenAI.ResponseRefusalDeltaEvent, Usage.input | Usage.output);
  @@usage(OpenAI.ResponseRefusalDoneEvent, Usage.input | Usage.output);
  @@usage(OpenAI.ResponseTextDeltaEvent, Usage.input | Usage.output);
  @@usage(OpenAI.ResponseTextDoneEvent, Usage.input | Usage.output);
  @@usage(
    OpenAI.ResponseWebSearchCallCompletedEvent,
    Usage.input | Usage.output
  );
  @@usage(
    OpenAI.ResponseWebSearchCallInProgressEvent,
    Usage.input | Usage.output
  );
  @@usage(
    OpenAI.ResponseWebSearchCallSearchingEvent,
    Usage.input | Usage.output
  );

  // --- Response, ResponseError, Error, and CreateResponse ---
  @@usage(OpenAI.Response, Usage.input | Usage.output);
  @@usage(OpenAI.ResponseError, Usage.input | Usage.output);
  @@usage(OpenAI.Error, Usage.input | Usage.output);
  @@usage(OpenAI.CreateResponse, Usage.input | Usage.output);

  // --- API envelope types (server needs to construct these) ---
  @@usage(Azure.AI.Projects.ApiErrorResponse, Usage.input | Usage.output);
  @@usage(Azure.AI.Projects.DeleteResponseResult, Usage.input | Usage.output);

  // --- OpenAI OutputItem subtypes (24 concrete types) ---
  @@usage(OpenAI.OutputItemApplyPatchToolCall, Usage.input | Usage.output);
  @@usage(
    OpenAI.OutputItemApplyPatchToolCallOutput,
    Usage.input | Usage.output
  );
  @@usage(OpenAI.OutputItemCodeInterpreterToolCall, Usage.input | Usage.output);
  @@usage(OpenAI.OutputItemCompactionBody, Usage.input | Usage.output);
  @@usage(OpenAI.OutputItemComputerToolCall, Usage.input | Usage.output);
  @@usage(OpenAI.OutputItemFileSearchToolCall, Usage.input | Usage.output);
  @@usage(OpenAI.OutputItemFunctionShellCall, Usage.input | Usage.output);
  @@usage(OpenAI.OutputItemFunctionShellCallOutput, Usage.input | Usage.output);
  @@usage(OpenAI.OutputItemFunctionToolCall, Usage.input | Usage.output);
  @@usage(OpenAI.OutputItemImageGenToolCall, Usage.input | Usage.output);
  @@usage(OpenAI.OutputItemLocalShellToolCall, Usage.input | Usage.output);
  @@usage(
    OpenAI.OutputItemLocalShellToolCallOutput,
    Usage.input | Usage.output
  );
  @@usage(OpenAI.OutputItemMcpApprovalRequest, Usage.input | Usage.output);
  @@usage(
    OpenAI.OutputItemMcpApprovalResponseResource,
    Usage.input | Usage.output
  );
  @@usage(OpenAI.OutputItemMcpListTools, Usage.input | Usage.output);
  @@usage(OpenAI.OutputItemMcpToolCall, Usage.input | Usage.output);
  @@usage(OpenAI.OutputItemMessage, Usage.input | Usage.output);
  @@usage(OpenAI.OutputItemOutputMessage, Usage.input | Usage.output);
  @@access(OpenAI.OutputItemOutputMessage, Access.internal);
  @@usage(OpenAI.OutputItemReasoningItem, Usage.input | Usage.output);
  @@usage(OpenAI.OutputItemWebSearchToolCall, Usage.input | Usage.output);
  @@usage(OpenAI.FunctionAndCustomToolCallOutput, Usage.input | Usage.output);

  // --- OutputContent subtypes (3 concrete types) ---
  @@usage(OpenAI.OutputContentOutputTextContent, Usage.input | Usage.output);
  @@usage(OpenAI.OutputContentReasoningTextContent, Usage.input | Usage.output);
  @@usage(OpenAI.OutputContentRefusalContent, Usage.input | Usage.output);

  // --- OutputMessageContent subtypes (internal — use MessageContent instead) ---
  @@usage(
    OpenAI.OutputMessageContentOutputTextContent,
    Usage.input | Usage.output
  );
  @@access(OpenAI.OutputMessageContentOutputTextContent, Access.internal);
  @@usage(
    OpenAI.OutputMessageContentRefusalContent,
    Usage.input | Usage.output
  );
  @@access(OpenAI.OutputMessageContentRefusalContent, Access.internal);
  @@access(OpenAI.OutputMessageContent, Access.internal);
  @@access(OpenAI.ItemOutputMessage, Access.internal);

  // --- Azure.AI.Projects OutputItem subtypes (24 concrete types) ---
  @@usage(Azure.AI.Projects.A2AToolCall, Usage.input | Usage.output);
  @@usage(Azure.AI.Projects.A2AToolCallOutput, Usage.input | Usage.output);
  @@usage(Azure.AI.Projects.AzureAISearchToolCall, Usage.input | Usage.output);
  @@usage(
    Azure.AI.Projects.AzureAISearchToolCallOutput,
    Usage.input | Usage.output
  );
  @@usage(Azure.AI.Projects.AzureFunctionToolCall, Usage.input | Usage.output);
  @@usage(
    Azure.AI.Projects.AzureFunctionToolCallOutput,
    Usage.input | Usage.output
  );
  @@usage(
    Azure.AI.Projects.BingCustomSearchToolCall,
    Usage.input | Usage.output
  );
  @@usage(
    Azure.AI.Projects.BingCustomSearchToolCallOutput,
    Usage.input | Usage.output
  );
  @@usage(Azure.AI.Projects.BingGroundingToolCall, Usage.input | Usage.output);
  @@usage(
    Azure.AI.Projects.BingGroundingToolCallOutput,
    Usage.input | Usage.output
  );
  @@usage(
    Azure.AI.Projects.BrowserAutomationToolCall,
    Usage.input | Usage.output
  );
  @@usage(
    Azure.AI.Projects.BrowserAutomationToolCallOutput,
    Usage.input | Usage.output
  );
  @@usage(
    Azure.AI.Projects.FabricDataAgentToolCall,
    Usage.input | Usage.output
  );
  @@usage(
    Azure.AI.Projects.FabricDataAgentToolCallOutput,
    Usage.input | Usage.output
  );
  @@usage(Azure.AI.Projects.MemoryCommandToolCall, Usage.input | Usage.output);
  @@usage(
    Azure.AI.Projects.MemoryCommandToolCallOutput,
    Usage.input | Usage.output
  );
  @@usage(Azure.AI.Projects.MemorySearchToolCall, Usage.input | Usage.output);
  @@usage(
    Azure.AI.Projects.OAuthConsentRequestOutputItem,
    Usage.input | Usage.output
  );
  @@usage(Azure.AI.Projects.OpenApiToolCall, Usage.input | Usage.output);
  @@usage(Azure.AI.Projects.OpenApiToolCallOutput, Usage.input | Usage.output);
  @@usage(
    Azure.AI.Projects.SharepointGroundingToolCall,
    Usage.input | Usage.output
  );
  @@usage(
    Azure.AI.Projects.SharepointGroundingToolCallOutput,
    Usage.input | Usage.output
  );
  @@usage(
    Azure.AI.Projects.StructuredOutputsOutputItem,
    Usage.input | Usage.output
  );
  @@usage(
    Azure.AI.Projects.WorkflowActionOutputItem,
    Usage.input | Usage.output
  );

  // ---------------------------------------------------------------------
  // Shared-type ownership: consume concrete models from their owning
  // packages rather than re-emitting duplicates.
  //   OpenAI SDK                -> official Responses/Containers models
  //   Azure.AI.Extensions.OpenAI -> Azure-specific Foundry tool models
  // Types with no upstream owner (local_shell / function_shell /
  // compaction) remain AgentServer-emitted.
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
    OpenAI.OutputMessage,
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
    OpenAI.Message,
    {
      identity: "OpenAI.Responses.MessageResponseItem",
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
}


// Types declared in the Azure.AI.Projects TypeSpec namespace that are still part of the
// AgentServer.Responses wire contract. Without an explicit usage they are unreachable from
// this package's operations and are therefore not emitted.
@@usage(Azure.AI.Projects.StructuredOutputsOutputItem, Usage.input | Usage.output);
@@usage(Azure.AI.Projects.ApiErrorResponse, Usage.input | Usage.output);

// These are surfaced on this package's public hosting API (ResponseStreamEvent.EventType and
// the tool-choice extension helpers), so they must not be emitted as internal.
@@access(OpenAI.ToolChoiceParam, Access.public);

// ============================================================================
// Stream event subtypes -> OpenAI.Responses.Streaming*Update.
// OpenAI's StreamingResponseUpdate has a single `private protected` constructor, so no
// external assembly can derive from it. Every emitted subtype must therefore be replaced
// by its OpenAI counterpart; the six with no counterpart map to the base update type.
// ============================================================================
@@alternateType(OpenAI.ResponseAudioDeltaEvent,
  { identity: "OpenAI.Responses.StreamingResponseUpdate", package: "OpenAI", minVersion: "2.12.0" },
  "csharp"
);
@@alternateType(OpenAI.ResponseAudioDoneEvent,
  { identity: "OpenAI.Responses.StreamingResponseUpdate", package: "OpenAI", minVersion: "2.12.0" },
  "csharp"
);
@@alternateType(OpenAI.ResponseAudioTranscriptDeltaEvent,
  { identity: "OpenAI.Responses.StreamingResponseUpdate", package: "OpenAI", minVersion: "2.12.0" },
  "csharp"
);
@@alternateType(OpenAI.ResponseAudioTranscriptDoneEvent,
  { identity: "OpenAI.Responses.StreamingResponseUpdate", package: "OpenAI", minVersion: "2.12.0" },
  "csharp"
);
@@alternateType(OpenAI.ResponseCodeInterpreterCallCodeDeltaEvent,
  { identity: "OpenAI.Responses.StreamingResponseCodeInterpreterCallCodeDeltaUpdate", package: "OpenAI", minVersion: "2.12.0" },
  "csharp"
);
@@alternateType(OpenAI.ResponseCodeInterpreterCallCodeDoneEvent,
  { identity: "OpenAI.Responses.StreamingResponseCodeInterpreterCallCodeDoneUpdate", package: "OpenAI", minVersion: "2.12.0" },
  "csharp"
);
@@alternateType(OpenAI.ResponseCodeInterpreterCallCompletedEvent,
  { identity: "OpenAI.Responses.StreamingResponseCodeInterpreterCallCompletedUpdate", package: "OpenAI", minVersion: "2.12.0" },
  "csharp"
);
@@alternateType(OpenAI.ResponseCodeInterpreterCallInProgressEvent,
  { identity: "OpenAI.Responses.StreamingResponseCodeInterpreterCallInProgressUpdate", package: "OpenAI", minVersion: "2.12.0" },
  "csharp"
);
@@alternateType(OpenAI.ResponseCodeInterpreterCallInterpretingEvent,
  { identity: "OpenAI.Responses.StreamingResponseCodeInterpreterCallInterpretingUpdate", package: "OpenAI", minVersion: "2.12.0" },
  "csharp"
);
@@alternateType(OpenAI.ResponseCompletedEvent,
  { identity: "OpenAI.Responses.StreamingResponseCompletedUpdate", package: "OpenAI", minVersion: "2.12.0" },
  "csharp"
);
@@alternateType(OpenAI.ResponseContentPartAddedEvent,
  { identity: "OpenAI.Responses.StreamingResponseContentPartAddedUpdate", package: "OpenAI", minVersion: "2.12.0" },
  "csharp"
);
@@alternateType(OpenAI.ResponseContentPartDoneEvent,
  { identity: "OpenAI.Responses.StreamingResponseContentPartDoneUpdate", package: "OpenAI", minVersion: "2.12.0" },
  "csharp"
);
@@alternateType(OpenAI.ResponseCreatedEvent,
  { identity: "OpenAI.Responses.StreamingResponseCreatedUpdate", package: "OpenAI", minVersion: "2.12.0" },
  "csharp"
);
@@alternateType(OpenAI.ResponseCustomToolCallInputDeltaEvent,
  { identity: "OpenAI.Responses.StreamingResponseUpdate", package: "OpenAI", minVersion: "2.12.0" },
  "csharp"
);
@@alternateType(OpenAI.ResponseCustomToolCallInputDoneEvent,
  { identity: "OpenAI.Responses.StreamingResponseUpdate", package: "OpenAI", minVersion: "2.12.0" },
  "csharp"
);
@@alternateType(OpenAI.ResponseErrorEvent,
  { identity: "OpenAI.Responses.StreamingResponseErrorUpdate", package: "OpenAI", minVersion: "2.12.0" },
  "csharp"
);
@@alternateType(OpenAI.ResponseFailedEvent,
  { identity: "OpenAI.Responses.StreamingResponseFailedUpdate", package: "OpenAI", minVersion: "2.12.0" },
  "csharp"
);
@@alternateType(OpenAI.ResponseFileSearchCallCompletedEvent,
  { identity: "OpenAI.Responses.StreamingResponseFileSearchCallCompletedUpdate", package: "OpenAI", minVersion: "2.12.0" },
  "csharp"
);
@@alternateType(OpenAI.ResponseFileSearchCallInProgressEvent,
  { identity: "OpenAI.Responses.StreamingResponseFileSearchCallInProgressUpdate", package: "OpenAI", minVersion: "2.12.0" },
  "csharp"
);
@@alternateType(OpenAI.ResponseFileSearchCallSearchingEvent,
  { identity: "OpenAI.Responses.StreamingResponseFileSearchCallSearchingUpdate", package: "OpenAI", minVersion: "2.12.0" },
  "csharp"
);
@@alternateType(OpenAI.ResponseFunctionCallArgumentsDeltaEvent,
  { identity: "OpenAI.Responses.StreamingResponseFunctionCallArgumentsDeltaUpdate", package: "OpenAI", minVersion: "2.12.0" },
  "csharp"
);
@@alternateType(OpenAI.ResponseFunctionCallArgumentsDoneEvent,
  { identity: "OpenAI.Responses.StreamingResponseFunctionCallArgumentsDoneUpdate", package: "OpenAI", minVersion: "2.12.0" },
  "csharp"
);
@@alternateType(OpenAI.ResponseImageGenCallCompletedEvent,
  { identity: "OpenAI.Responses.StreamingResponseImageGenerationCallCompletedUpdate", package: "OpenAI", minVersion: "2.12.0" },
  "csharp"
);
@@alternateType(OpenAI.ResponseImageGenCallGeneratingEvent,
  { identity: "OpenAI.Responses.StreamingResponseImageGenerationCallGeneratingUpdate", package: "OpenAI", minVersion: "2.12.0" },
  "csharp"
);
@@alternateType(OpenAI.ResponseImageGenCallInProgressEvent,
  { identity: "OpenAI.Responses.StreamingResponseImageGenerationCallInProgressUpdate", package: "OpenAI", minVersion: "2.12.0" },
  "csharp"
);
@@alternateType(OpenAI.ResponseImageGenCallPartialImageEvent,
  { identity: "OpenAI.Responses.StreamingResponseImageGenerationCallPartialImageUpdate", package: "OpenAI", minVersion: "2.12.0" },
  "csharp"
);
@@alternateType(OpenAI.ResponseInProgressEvent,
  { identity: "OpenAI.Responses.StreamingResponseInProgressUpdate", package: "OpenAI", minVersion: "2.12.0" },
  "csharp"
);
@@alternateType(OpenAI.ResponseIncompleteEvent,
  { identity: "OpenAI.Responses.StreamingResponseIncompleteUpdate", package: "OpenAI", minVersion: "2.12.0" },
  "csharp"
);
@@alternateType(OpenAI.ResponseMCPCallArgumentsDeltaEvent,
  { identity: "OpenAI.Responses.StreamingResponseMcpCallArgumentsDeltaUpdate", package: "OpenAI", minVersion: "2.12.0" },
  "csharp"
);
@@alternateType(OpenAI.ResponseMCPCallArgumentsDoneEvent,
  { identity: "OpenAI.Responses.StreamingResponseMcpCallArgumentsDoneUpdate", package: "OpenAI", minVersion: "2.12.0" },
  "csharp"
);
@@alternateType(OpenAI.ResponseMCPCallCompletedEvent,
  { identity: "OpenAI.Responses.StreamingResponseMcpCallCompletedUpdate", package: "OpenAI", minVersion: "2.12.0" },
  "csharp"
);
@@alternateType(OpenAI.ResponseMCPCallFailedEvent,
  { identity: "OpenAI.Responses.StreamingResponseMcpCallFailedUpdate", package: "OpenAI", minVersion: "2.12.0" },
  "csharp"
);
@@alternateType(OpenAI.ResponseMCPCallInProgressEvent,
  { identity: "OpenAI.Responses.StreamingResponseMcpCallInProgressUpdate", package: "OpenAI", minVersion: "2.12.0" },
  "csharp"
);
@@alternateType(OpenAI.ResponseMCPListToolsCompletedEvent,
  { identity: "OpenAI.Responses.StreamingResponseMcpListToolsCompletedUpdate", package: "OpenAI", minVersion: "2.12.0" },
  "csharp"
);
@@alternateType(OpenAI.ResponseMCPListToolsFailedEvent,
  { identity: "OpenAI.Responses.StreamingResponseMcpListToolsFailedUpdate", package: "OpenAI", minVersion: "2.12.0" },
  "csharp"
);
@@alternateType(OpenAI.ResponseMCPListToolsInProgressEvent,
  { identity: "OpenAI.Responses.StreamingResponseMcpListToolsInProgressUpdate", package: "OpenAI", minVersion: "2.12.0" },
  "csharp"
);
@@alternateType(OpenAI.ResponseOutputItemAddedEvent,
  { identity: "OpenAI.Responses.StreamingResponseOutputItemAddedUpdate", package: "OpenAI", minVersion: "2.12.0" },
  "csharp"
);
@@alternateType(OpenAI.ResponseOutputItemDoneEvent,
  { identity: "OpenAI.Responses.StreamingResponseOutputItemDoneUpdate", package: "OpenAI", minVersion: "2.12.0" },
  "csharp"
);
@@alternateType(OpenAI.ResponseOutputTextAnnotationAddedEvent,
  { identity: "OpenAI.Responses.StreamingResponseOutputTextAnnotationAddedUpdate", package: "OpenAI", minVersion: "2.12.0" },
  "csharp"
);
@@alternateType(OpenAI.ResponseQueuedEvent,
  { identity: "OpenAI.Responses.StreamingResponseQueuedUpdate", package: "OpenAI", minVersion: "2.12.0" },
  "csharp"
);
@@alternateType(OpenAI.ResponseReasoningSummaryPartAddedEvent,
  { identity: "OpenAI.Responses.StreamingResponseReasoningSummaryPartAddedUpdate", package: "OpenAI", minVersion: "2.12.0" },
  "csharp"
);
@@alternateType(OpenAI.ResponseReasoningSummaryPartDoneEvent,
  { identity: "OpenAI.Responses.StreamingResponseReasoningSummaryPartDoneUpdate", package: "OpenAI", minVersion: "2.12.0" },
  "csharp"
);
@@alternateType(OpenAI.ResponseReasoningSummaryTextDeltaEvent,
  { identity: "OpenAI.Responses.StreamingResponseReasoningSummaryTextDeltaUpdate", package: "OpenAI", minVersion: "2.12.0" },
  "csharp"
);
@@alternateType(OpenAI.ResponseReasoningSummaryTextDoneEvent,
  { identity: "OpenAI.Responses.StreamingResponseReasoningSummaryTextDoneUpdate", package: "OpenAI", minVersion: "2.12.0" },
  "csharp"
);
@@alternateType(OpenAI.ResponseReasoningTextDeltaEvent,
  { identity: "OpenAI.Responses.StreamingResponseReasoningTextDeltaUpdate", package: "OpenAI", minVersion: "2.12.0" },
  "csharp"
);
@@alternateType(OpenAI.ResponseReasoningTextDoneEvent,
  { identity: "OpenAI.Responses.StreamingResponseReasoningTextDoneUpdate", package: "OpenAI", minVersion: "2.12.0" },
  "csharp"
);
@@alternateType(OpenAI.ResponseRefusalDeltaEvent,
  { identity: "OpenAI.Responses.StreamingResponseRefusalDeltaUpdate", package: "OpenAI", minVersion: "2.12.0" },
  "csharp"
);
@@alternateType(OpenAI.ResponseRefusalDoneEvent,
  { identity: "OpenAI.Responses.StreamingResponseRefusalDoneUpdate", package: "OpenAI", minVersion: "2.12.0" },
  "csharp"
);
@@alternateType(OpenAI.ResponseTextDeltaEvent,
  { identity: "OpenAI.Responses.StreamingResponseOutputTextDeltaUpdate", package: "OpenAI", minVersion: "2.12.0" },
  "csharp"
);
@@alternateType(OpenAI.ResponseTextDoneEvent,
  { identity: "OpenAI.Responses.StreamingResponseOutputTextDoneUpdate", package: "OpenAI", minVersion: "2.12.0" },
  "csharp"
);
@@alternateType(OpenAI.ResponseWebSearchCallCompletedEvent,
  { identity: "OpenAI.Responses.StreamingResponseWebSearchCallCompletedUpdate", package: "OpenAI", minVersion: "2.12.0" },
  "csharp"
);
@@alternateType(OpenAI.ResponseWebSearchCallInProgressEvent,
  { identity: "OpenAI.Responses.StreamingResponseWebSearchCallInProgressUpdate", package: "OpenAI", minVersion: "2.12.0" },
  "csharp"
);
@@alternateType(OpenAI.ResponseWebSearchCallSearchingEvent,
  { identity: "OpenAI.Responses.StreamingResponseWebSearchCallSearchingUpdate", package: "OpenAI", minVersion: "2.12.0" },
  "csharp"
);

@@alternateType(OpenAI.ResponseStreamEventType,
  { identity: "OpenAI.Responses.StreamingResponseUpdateKind", package: "OpenAI", minVersion: "2.12.0" },
  "csharp"
);


// ============================================================================
// Remaining Azure models that have exact OpenAI counterparts. Mapping them
// keeps a single representation on the wire-facing surface instead of forcing
// conversions between two structurally identical types.
// ============================================================================
@@alternateType(OpenAI.Annotation,
  { identity: "OpenAI.Responses.ResponseMessageAnnotation", package: "OpenAI", minVersion: "2.12.0" },
  "csharp"
);
@@alternateType(OpenAI.ComputerAction,
  { identity: "OpenAI.Responses.ComputerCallAction", package: "OpenAI", minVersion: "2.12.0" },
  "csharp"
);
@@alternateType(OpenAI.ConversationParam,
  { identity: "OpenAI.Responses.ResponseConversationOptions", package: "OpenAI", minVersion: "2.12.0" },
  "csharp"
);
@@alternateType(OpenAI.ResponseUsage,
  { identity: "OpenAI.Responses.ResponseTokenUsage", package: "OpenAI", minVersion: "2.12.0" },
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
@@alternateType(OpenAI.CustomToolCallResource,
  { identity: "Azure.AI.AgentServer.Responses.OutputItemCustomToolCall" },
  "csharp"
);
@@alternateType(OpenAI.CustomToolCallOutputResource,
  { identity: "Azure.AI.AgentServer.Responses.OutputItemCustomToolCallOutput" },
  "csharp"
);
